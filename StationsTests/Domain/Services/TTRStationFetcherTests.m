//
//  TTRStationFetcherTests.m
//  Stations
//
//  Created by Nikolay Evstigneev on 28.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TTRStationFetcher.h"
#import "TTRCity.h"
#import "TTRStation.h"

@interface TTRStationFetcher (Testing)

- (NSArray<TTRCity *> *)parseCities:(NSData *)data error:(NSError **)error;

@end

@interface TTRStationFetcherTests : XCTestCase

@end

@implementation TTRStationFetcherTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testImpossibleToCreateStationFetcherWithoutCitiesType {
    XCTAssertThrows([[TTRStationFetcher alloc] init]);
}

- (void)testAllDepartureCitiesFetched {
    TTRStationFetcher *fetcherFrom = [[TTRStationFetcher alloc] initWithCitiesType:TTRCitiesTypeDeparture];
    XCTestExpectation *expectation = [self expectationWithDescription:@"block not call"];
    NSTimeInterval timeout = 5.0f;
    [fetcherFrom fetchStationsFromFileWithCompletion:^(NSArray<TTRCity *> *data, NSError *error) {
        XCTAssertEqual(data.count, 439);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:timeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error.localizedDescription);
        }
    }];
}

- (void)testAllDestinationCitiesFetched {
    TTRStationFetcher *fetcherFrom = [[TTRStationFetcher alloc] initWithCitiesType:TTRCitiesTypeDestination];
    XCTestExpectation *expectation = [self expectationWithDescription:@"block not call"];
    NSTimeInterval timeout = 5.0f;
    [fetcherFrom fetchStationsFromFileWithCompletion:^(NSArray<TTRCity *> *data, NSError *error) {
        XCTAssertEqual(data.count, 2681);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:timeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error.localizedDescription);
        }
    }];
}

- (void)testThrowAbsensceWithBadDataParsing {
    TTRStationFetcher *fetcherFrom = [[TTRStationFetcher alloc] initWithCitiesType:TTRCitiesTypeDeparture];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"badData" ofType:@"json"];
    NSData *dataFromFile = [NSData dataWithContentsOfFile:filePath];
    XCTAssertNoThrow([fetcherFrom parseCities:dataFromFile error:nil]);
}

- (void)testParsingCorrect {
    TTRCity *city = [[TTRCity alloc] initWithCountryTitle:@"Австрия" cityId:2352 cityTitle:@"Вена" stations:nil];
    TTRStationFetcher *fetcherFrom = [[TTRStationFetcher alloc] initWithCitiesType:TTRCitiesTypeDeparture];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"simpleData" ofType:@"json"];
    NSData *dataFromFile = [NSData dataWithContentsOfFile:filePath];
    NSArray<TTRCity *> *cities = [fetcherFrom parseCities:dataFromFile error:nil];
    TTRCity *resultCity = cities[0];
    XCTAssertTrue([city isEqual:resultCity]);
    TTRPoint point = {16.36879539489746, 48.20253753662109};
    TTRStation *station = [[TTRStation alloc] initWithCountryTitle:@"Австрия" point:point districtTitle:@""
                                                            cityId:2352 cityTitle:@"город Вена" regionTitle:@""
                                                         stationId:10154 stationTitle:@"International Busterminal, Edbergstarsse 200 A"];
    TTRStation *resultStation = resultCity.stations[0];
    XCTAssertTrue([station isEqual:resultStation]);
}

@end
