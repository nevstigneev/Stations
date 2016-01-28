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
    @throw [NSException
            exceptionWithName:NSInternalInconsistencyException
            reason:[NSString stringWithFormat:@"Unexpected deadly init invokation '%@', use %@ instead.",
                    NSStringFromSelector(_cmd),
                    NSStringFromSelector(@selector(initWithCountryTitle:cityId:cityTitle:stations:))]
            userInfo:nil];
}

- (instancetype)initWithCountryTitle:(NSString *)countryTitle cityId:(NSInteger)cityId cityTitle:(NSString *)cityTitle 
                            stations:(NSArray<TTRStation *> *)stations {
    self = [super init];
    if (self) {
        _countryTitle = [countryTitle copy];
        _cityId = cityId;
        _cityTitle = [cityTitle copy];
        _stations = stations;
    }
    return self;
}

@end
