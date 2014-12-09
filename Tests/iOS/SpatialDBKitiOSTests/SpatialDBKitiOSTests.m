//
//  SpatialDBKitiOSTests.m
//  SpatialDBKitiOSTests
//
//  Created by David Chiles on 12/8/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

@import XCTest;

#import <SpatialDBKit/SpatialDatabase.h>

@interface SpatialDBKitiOSTests : XCTestCase

@property (nonatomic, strong) SpatialDatabase *database;

@end

@implementation SpatialDBKitiOSTests

- (void)setUp {
    [super setUp];
    
    self.database = [SpatialDatabase databaseWithPath: [[NSBundle mainBundle] pathForResource:@"test-2.3" ofType:@"sqlite"]];
    BOOL opened = [self.database open];
    XCTAssertTrue(opened,@"Failed to open database");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testVersion {
    NSString *version = [SpatialDatabase spatialiteLibVersion];
    XCTAssertTrue([version length] > 0,@"Could not find spatialite lib version");
    
    version = [SpatialDatabase sqliteLibVersion];
    XCTAssertTrue([version length] > 0,@"Could not find sqlite lib version");
}

- (void)testAsText
{
    FMResultSet *resultSet = [self.database executeQuery:@"select AsText(geometry) AS text FROM Regions WHERE PK_UID = 106"];
    XCTAssertNotNil(resultSet,@"No results");
    while ([resultSet next]) {
        NSDictionary *dictionary = [resultSet resultDictionary];
        XCTAssertTrue([dictionary count] > 0, @"Empty Dictionary");
    }
}

@end
