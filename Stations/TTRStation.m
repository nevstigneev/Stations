//
//  TTRStation.m
//  Stations
//
//  Created by Nikolay Evstigneev on 26.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import "TTRStation.h"

@implementation TTRStation

- (instancetype)init {
    @throw [NSException
            exceptionWithName:NSInternalInconsistencyException
            reason:[NSString stringWithFormat:@"Unexpected deadly init invokation '%@', use %@ instead.",
                    NSStringFromSelector(_cmd),
                    NSStringFromSelector(@selector(initWithCountryTitle:point:districtTitle:cityId:cityTitle:regionTitle:stationId:stationTitle:))]
            userInfo:nil];
}

- (instancetype)initWithCountryTitle:(NSString *)countryTitle point:(TTRPoint)point districtTitle:(NSString *)districtTitle
                              cityId:(NSInteger)cityId cityTitle:(NSString *)cityTitle regionTitle:(NSString *)regionTitle
                           stationId:(NSInteger)stationId stationTitle:(NSString *)stationTitle {
    self = [super init];
    if (self) {
        _countryTitle = [countryTitle copy];
        _point = point;
        _districtTitle = [districtTitle copy];
        _cityId = cityId;
        _cityTitle = [cityTitle copy];
        _regionTitle = [regionTitle copy];
        _stationId = stationId;
        _stationTitle = [stationTitle copy];
    }
    return self;
}

@end
