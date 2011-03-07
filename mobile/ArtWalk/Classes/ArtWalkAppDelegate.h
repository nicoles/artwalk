//
//  ArtWalkAppDelegate.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 10/11/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SubmissionController;
@class MultipleArtPiece;
@class EditingController;
@class MapView;
@class SingleArtPieceView;

@interface ArtWalkAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
	UINavigationController *navigationController;
	SubmissionController *submissionController;
	EditingController *editingController;
	MultipleArtPiece *multipleArtPiece;
	SingleArtPieceView *singleArtPieceView;
	MapView *mapView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) SubmissionController *submissionController;
@property (nonatomic, retain) EditingController *editingController;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) MultipleArtPiece *multipleArtPiece;
@property (nonatomic, retain) MapView *mapView;
@property (nonatomic, retain) SingleArtPieceView *singleArtPieceView;


@end

