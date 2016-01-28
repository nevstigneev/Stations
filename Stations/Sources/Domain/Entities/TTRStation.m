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
            reason:[NSString stringWithFormat:@"Unexpected deadly init invocation '%@', use %@ instead.",
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

- (BOOL)isEqual:(id)object {
    if ([self class] != [object class]) {
        return NO;
    }
    TTRStation *otherStation = (TTRStation *)object;
    if (self.stationId != otherStation.stationId) {
        return NO;
    }
    if (self.point.longitude != otherStation.point.longitude || self.point.latitude != otherStation.point.latitude) {
        return NO;
    }
    if (![self.districtTitle isEqualToString:otherStation.districtTitle]) {
        return NO;
    }
    if (![self.cityTitle isEqualToString:otherStation.cityTitle]) {
        return NO;
    }
    if (self.cityId != otherStation.cityId) {
        return NO;
    }
    if (![self.regionTitle isEqualToString:otherStation.regionTitle]) {
        return NO;
    }
    if (![self.stationTitle isEqualToString:otherStation.stationTitle]) {
        return NO;
    }
    if (self.stationId != otherStation.stationId) {
        return  NO;
    }
    return YES;
}

@end
