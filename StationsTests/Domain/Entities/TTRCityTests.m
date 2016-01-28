//
//  TTRCityTests.m
//  Stations
//
//  Created by Nikolay Evstigneev on 28.01.16.
//  Copyright © 2016 Nikolay Evstigneev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TTRCity.h"

@interface TTRCityTests : XCTestCase

@end

@implementation TTRCityTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testImpossibleToCreateCityWithoutProperties {
    XCTAssertThrows([[TTRCity alloc] init]);
}

@end
