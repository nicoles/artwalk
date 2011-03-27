//
//  ArtWalkAppDelegate.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/03/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArtWalkAppDelegate.h"
#import "SubmissionController.h"
#import "MultipleArtPiece.h"
#import "MapView.h"

@implementation ArtWalkAppDelegate



@synthesize window=_window;

@synthesize navigationController=_navigationController;
@synthesize tabBarController=_tabBarController;
@synthesize submissionController;
@synthesize editingController=_editingController;
@synthesize multipleArtPiece;
@synthesize mapView;
@synthesize singleArtPieceView=_singleArtPieceView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _tabBarController = [[UITabBarController alloc] init];
	_navigationController = [[UINavigationController alloc] init];
    
	
	multipleArtPiece = [[MultipleArtPiece alloc] init];

	submissionController = [[SubmissionController alloc] init];
	mapView = [[MapView alloc] init];
	
	_tabBarController.viewControllers = [NSArray arrayWithObjects:_navigationController, mapView, submissionController, nil];
	[_window addSubview:_tabBarController.view];
	[_navigationController pushViewController:multipleArtPiece animated:NO];

    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    //self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [submissionController release];
	[multipleArtPiece release];
	[mapView release];
	[_tabBarController release];
	[_editingController release];
    [super dealloc];
}

@end
