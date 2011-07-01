//
//  ArtPiecesViewController.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/05/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ArtPiecesViewController : UITableViewController 

//the parade in this case, is the list of art pieces that are currently being displayed in the tableview.
@property (nonatomic, retain) NSArray *artPiecesOnParade;
@property (nonatomic, retain) NSManagedObjectContext *artPiecesContext;
@property (nonatomic, retain) NSOperationQueue *imageLoadingQueue;

- (void)syncDatabase;
- (void)refreshParade;

@end
