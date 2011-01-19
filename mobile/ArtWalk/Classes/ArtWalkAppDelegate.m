//
//  ArtWalkAppDelegate.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 10/11/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ArtWalkAppDelegate.h"
#import "SubmissionController.h"
#import "SingleArtPiece.h"
#import "EditingController.h"
#import "MultipleArtPiece.h"

@implementation ArtWalkAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize submissionController;
@synthesize singleArtPiece;
@synthesize editingController;
@synthesize multipleArtPiece;
@synthesize navigationController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	//SubmissionController *aViewController = [[SubmissionController alloc]
	//									 initWithNibName:@"SubmissionController" bundle:[NSBundle mainBundle]];
	
//	[self setSubmissionController:aViewController];
	
//	[aViewController release];
	
//	UIView *controllersView = [SubmissionController view];
	//navigationController = [[UINavigationController alloc] init];
	tabBarController = [[UITabBarController alloc] init];
	navigationController = [[UINavigationController alloc] init];
	multipleArtPiece = [[MultipleArtPiece alloc] init];
	multipleArtPiece.title = @"Art Pieces";
	submissionController = [[SubmissionController alloc] init];
	submissionController.title = @"Submit New";
	tabBarController.viewControllers = [NSArray arrayWithObjects:navigationController, submissionController, nil];
	[window addSubview:tabBarController.view];
	[navigationController pushViewController:multipleArtPiece animated:NO];
    //navigationController.navigationBar.barStyle = UIBarStyleDefault;
	//[navigationController pushViewController:multipleArtPiece animated:NO];
	//[window addSubview:navigationController.view];
	
	// Override point for customization after application launch.
    
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[submissionController release];
	[singleArtPiece release];
	[multipleArtPiece release];
	[navigationController release];
	[tabBarController release];
	[editingController release];
    [window release];
    [super dealloc];
}


@end
