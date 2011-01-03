//
//  ArtWalkAppDelegate.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 10/11/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SubmissionController;
@class SingleArtPiece;
@class EditingController;
@interface ArtWalkAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
	SubmissionController *submissionController;
	SingleArtPiece *singleArtPiece;
	EditingController *editingController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) SubmissionController *submissionController;
@property (nonatomic, retain) SingleArtPiece *singleArtPiece;
@property (nonatomic, retain) EditingController *editingController;

@end

