//
//  TTRStationFetcher.m
//  Stations
//
//  Created by Nikolay Evstigneev on 26.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import "TTRStationFetcher.h"

@implementation TTRStationFetcher

- (void)fetchStationsFromFileWithCompletion:(void (^)(NSDictionary *data, NSError *error))completionHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"allStations" ofType:@"json"];
        NSData *dataFromFile = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:dataFromFile options:kNilOptions error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                completionHandler(data, nil);
            } else {
                completionHandler(nil, error);
            }
        });
    });
}

@end
