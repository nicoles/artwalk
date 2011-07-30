//
//  ArtPiecesViewController.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/05/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ArtPiecesViewController : UITableViewController 

@property (nonatomic, retain) NSArray *artPieces;
@property (nonatomic, retain) NSManagedObjectContext *artPiecesContext;
@property (nonatomic, retain) NSOperationQueue *imageLoadingQueue;

- (void)syncDatabase;
- (void)refreshPieces;
- (void)switchToMap;

@end
