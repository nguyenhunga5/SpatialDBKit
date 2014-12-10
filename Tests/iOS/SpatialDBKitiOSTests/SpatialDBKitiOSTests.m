//
//  SpatialDBKitiOSTests.m
//  SpatialDBKitiOSTests
//
//  Created by David Chiles on 12/8/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

@import XCTest;

#import <SpatialDBKit/SpatialDatabase.h>
#import "ShapeKitGeometry.h"

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
    [self.database close];
    //Error dealoc not cleaning up properly
    //self.database = nil;
    [super tearDown];
}

- (void)testVersion {
    NSString *version = [SpatialDatabase spatialiteLibVersion];
    XCTAssertTrue([version length] > 0,@"Could not find spatialite lib version");
    
    version = [SpatialDatabase sqliteLibVersion];
    XCTAssertTrue([version length] > 0,@"Could not find sqlite lib version");
}

- (void)testFetch
{
    FMResultSet *restultSet = [self.database executeQuery:@"select geometry FROM Regions WHERE PK_UID = 106"];
    id geometry = nil;
    while ([restultSet next])
    {
        geometry = [restultSet objectForColumnName:@"geometry"];
        XCTAssertNotNil(geometry,@"Nil geometry");
        XCTAssertTrue([geometry isKindOfClass:[ShapeKitGeometry class]],@"Is not ShapeKitGeometry");
    }
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

- (void)testNetwork
{
    SpatialDatabase *networkDatabase = [[SpatialDatabase alloc] initWithPath:[[NSBundle mainBundle] pathForResource:@"test-network-2.3" ofType:@"sqlite"]];
    [networkDatabase open];
    FMResultSet *resutlSet = [networkDatabase executeQuery:@"SELECT * FROM Roads_net WHERE NodeFrom = 1 AND NodeTo = 512"];
    XCTAssertNotNil(resutlSet, @"No results");
    while ([resutlSet next]) {
        NSDictionary *dictionary = [resutlSet resultDictionary];
        XCTAssertTrue([dictionary count],@"Empty results dictionary");
    }
}

@end
