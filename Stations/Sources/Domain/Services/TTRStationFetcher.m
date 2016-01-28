//
//  TTRStationFetcher.m
//  Stations
//
//  Created by Nikolay Evstigneev on 26.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import "TTRStationFetcher.h"
#import "TTRCity.h"
#import "TTRStation.h"

NSString *const TTRStationsErrorDomain = @"TTRStationsErrorDomain";

typedef NS_ENUM (NSInteger, TTRStationsError) {
    TTRStationsErrorFileReading,
    TTRStationsErrorJsonParsing
};

@interface TTRStationFetcher ()

@property (copy, nonatomic, readonly) NSString *citiesTypeKey;

@end

@implementation TTRStationFetcher

- (instancetype)init {
    @throw [NSException
            exceptionWithName:NSInternalInconsistencyException
            reason:[NSString stringWithFormat:@"Unexpected deadly init invokation '%@', use %@ instead.",
                    NSStringFromSelector(_cmd),
                    NSStringFromSelector(@selector(initWithCitiesType:))]
            userInfo:nil];
}

- (instancetype)initWithCitiesType:(TTRCitiesType)type {
    self = [super init];
    if (self) {
        if (type == TTRCitiesTypeDeparture) {
            _citiesTypeKey = @"citiesFrom";
        } else if (type == TTRCitiesTypeDestination) {
            _citiesTypeKey = @"citiesTo";
        }
    }
    return self;
}

- (void)fetchStationsFromFileWithCompletion:(void (^)(NSArray<TTRCity *> *data, NSError *error))completionHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"allStations" ofType:@"json"];
        NSData *dataFromFile = [NSData dataWithContentsOfFile:filePath];
        NSArray<TTRCity *> *cities = nil;
        NSError *error = nil;
        if (dataFromFile) {
            cities = [self parseCities:dataFromFile error:&error];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(cities, error);
        });
    });
}

#pragma mark - Private

- (NSArray<TTRCity *> *)parseCities:(NSData *)data error:(NSError **)error {
    @try {
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error];
        NSArray *citiesFrom = JSON[self.citiesTypeKey];
        NSMutableArray<TTRCity *> *result = [[NSMutableArray alloc] init];
        for (NSDictionary *city in citiesFrom) {
            NSString *countryTitle = city[@"countryTitle"];
            NSInteger cityId = [city[@"cityId"] integerValue];
            NSString *cityTitle = city[@"cityTitle"];
            NSArray *stations = city[@"stations"];
            NSArray<TTRStation *> *resultStations = [self parseStations:stations];
            TTRCity *city = [[TTRCity alloc] initWithCountryTitle:countryTitle cityId:cityId cityTitle:cityTitle stations:resultStations];
            [result addObject:city];
        }
        return result;
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:TTRStationsErrorDomain code:TTRStationsErrorJsonParsing
                                 userInfo:@{NSLocalizedDescriptionKey: [exception reason]}];
        return nil;
    }
}

- (NSArray<TTRStation *> *)parseStations:(NSArray *)data {
    NSMutableArray<TTRStation *> *result = [[NSMutableArray alloc] init];
    for (NSDictionary *station in data) {
        NSString *countryTitle = station[@"countryTitle"];
        NSDictionary *pointDictionary = station[@"point"];
        TTRPoint point = {[pointDictionary[@"longitude"] doubleValue], [pointDictionary[@"latitude"] doubleValue]};
        NSString *districtTitle = station[@"districtTitle"];
        NSInteger cityId = [station[@"cityId"] integerValue];
        NSString *cityTitle = station[@"cityTitle"];
        NSString *regionTitle = station[@"regionTitle"];
        NSInteger stationId = [station[@"stationId"] integerValue];
        NSString *stationTitle = station[@"stationTitle"];
        TTRStation *resultStation = [[TTRStation alloc] initWithCountryTitle:countryTitle point:point districtTitle:districtTitle
                                                                      cityId:cityId cityTitle:cityTitle regionTitle:regionTitle
                                                                   stationId:stationId stationTitle:stationTitle];
        [result addObject:resultStation];
    }
    return result;
}

@end
