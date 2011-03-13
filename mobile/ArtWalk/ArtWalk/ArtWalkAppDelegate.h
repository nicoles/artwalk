//
//  ArtWalkAppDelegate.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/03/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SubmissionController;
@class MultipleArtPiece;
@class EditingController;
@class MapView;
@class SingleArtPieceView;

@interface ArtWalkAppDelegate : NSObject <UIApplicationDelegate> {
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) SubmissionController *submissionController;
@property (nonatomic, retain) EditingController *editingController;
@property (nonatomic, retain) MultipleArtPiece *multipleArtPiece;
@property (nonatomic, retain) MapView *mapView;
@property (nonatomic, retain) SingleArtPieceView *singleArtPieceView;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
