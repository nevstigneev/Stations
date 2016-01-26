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

@implementation TTRStationFetcher

- (void)fetchStationsFromFileWithCompletion:(void (^)(NSArray<TTRCity *> *data, NSError *error))completionHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"allStations" ofType:@"json"];
        NSData *dataFromFile = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:dataFromFile options:kNilOptions error:&error];
        NSArray<TTRCity *> *cities = nil;
        if (!error) {
            cities = [self parseCities:data error:&error];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                completionHandler(cities, nil);
            } else {
                completionHandler(nil, error);
            }
        });
    });
}

#pragma mark - Private

- (NSArray<TTRCity *> *)parseCities:(NSDictionary *)data error:(NSError **)error {
    NSArray *citiesFrom = data[@"citiesFrom"];
    NSMutableArray<TTRCity *> *result = [[NSMutableArray alloc] init];
    for (NSDictionary *city in citiesFrom) {
        NSString *countryTitle = city[@"countryTitle"];
        NSDictionary *pointDictionary = city[@"point"];
        TTRPoint point = {[pointDictionary[@"longitude"] doubleValue], [pointDictionary[@"latitude"] doubleValue]};
        NSString *districtTitle = city[@"districtTitle"];
        NSInteger cityId = [city[@"cityId"] integerValue];
        NSString *cityTitle = city[@"cityTitle"];
        NSString *regionTitle = city[@"regionTitle"];
        NSArray *stations = city[@"stations"];
        NSArray<TTRStation *> *resultStations = [self parseStations:stations error:error];
        TTRCity *city = [[TTRCity alloc] initWithCountryTitle:countryTitle point:point districtTitle:districtTitle cityId:cityId
                                                    cityTitle:cityTitle regionTitle:regionTitle stations:resultStations];
        [result addObject:city];
    }
    return result;
}

- (NSArray<TTRStation *> *)parseStations:(NSArray *)data error:(NSError **)error {
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
