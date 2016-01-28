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

// невозможно создать экземпляр модели, не передав необходимые параметры

- (instancetype)init {
    @throw [NSException
            exceptionWithName:NSInternalInconsistencyException
            reason:[NSString stringWithFormat:@"Unexpected deadly init invocation '%@', use %@ instead.",
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

// подробное сравнение для корректного unit-тестирования

- (BOOL)isEqual:(id)object {
    if ([self class] != [object class]) {
        return NO;
    }
    TTRCity *otherCity = (TTRCity *)object;
    if (self.cityId != otherCity.cityId) {
        return NO;
    }
    if (![self.countryTitle isEqualToString:otherCity.countryTitle]) {
        return NO;
    }
    if (![self.cityTitle isEqualToString:otherCity.cityTitle]) {
        return NO;
    }
    return YES;
}

@end
