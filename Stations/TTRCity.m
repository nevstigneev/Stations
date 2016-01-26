//
//  TTRCity.m
//  Stations
//
//  Created by Nikolay Evstigneev on 26.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import "TTRCity.h"
#import "TTRStation.h"

@implementation TTRCity

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Precondition failed." userInfo:nil];
}

- (instancetype)initWithCountryTitle:(NSString *)countryTitle point:(TTRPoint)point districtTitle:(NSString *)districtTitle
                              cityId:(NSInteger)cityId cityTitle:(NSString *)cityTitle regionTitle:(NSString *)regionTitle
                            stations:(NSArray<TTRStation *> *)stations {
    self = [super init];
    if (self) {
        _countryTitle = [countryTitle copy];
        _point = point;
        _districtTitle = [districtTitle copy];
        _cityId = cityId;
        _cityTitle = [cityTitle copy];
        _regionTitle = [regionTitle copy];
        _stations = stations;
    }
    return self;
}

@end
