//
//  OpenDocentAppDelegate.h
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/05/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenDocentAppDelegate : NSObject <UIApplicationDelegate> {

}


@property (nonatomic, retain) UITabBarController *docentTabBarController;
@property (nonatomic, retain) UINavigationController *browseNavController;
@property (nonatomic, retain) UINavigationController *spatialNavController;
@property (nonatomic, retain) UINavigationController *createNavController;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
