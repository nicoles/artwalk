//
//  MapViewControllerTests.m
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/07/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewControllerTests.h"

@implementation MapViewControllerTests

- (void)setUp
{
    [super setUp];
    mapViewController = [[[MapViewController alloc] init] autorelease];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.

    [super tearDown];
}

- (void) testViewDidLoadShouldCreateMapView{
    [mapViewController viewDidLoad];
    STAssertNotNil(mapViewController.mapView, @"didn't work!");

}

@end
