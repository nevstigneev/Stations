//
//  TTRCity.h
//  Stations
//
//  Created by Nikolay Evstigneev on 26.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTRPoint.h"

@class TTRStation;

@interface TTRCity : NSObject

@property (copy, nonatomic, readonly) NSString *countryTitle;
@property (assign, nonatomic, readonly) NSInteger cityId;
@property (copy, nonatomic, readonly) NSString *cityTitle;
@property (strong, nonatomic, readwrite) NSArray<TTRStation *> *stations;

- (instancetype)initWithCountryTitle:(NSString *)countryTitle cityId:(NSInteger)cityId cityTitle:(NSString *)cityTitle
                            stations:(NSArray<TTRStation *> *)stations;

@end
