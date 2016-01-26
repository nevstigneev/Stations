//
//  TTRStationFetcher.h
//  Stations
//
//  Created by Nikolay Evstigneev on 26.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTRCity;

@interface TTRStationFetcher : NSObject

- (void)fetchStationsFromFileWithCompletion:(void (^)(NSArray<TTRCity *> *data, NSError *error))completionHandler;

@end
