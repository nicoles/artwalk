//
//  MultipleArtPiece.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/01/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <dispatch/dispatch.h>

@interface MultipleArtPiece : UITableViewController {
	NSMutableData *responseData;
	UIScrollView *scrollView;
    UITableView *myTableView;
    NSArray *artPieces;
	NSMutableArray *artPieceViews;
    UIBarButtonItem *refreshButton;
    dispatch_queue_t loadingQueue;
	
}

@property (nonatomic, retain) NSArray *artPieces;
@property (nonatomic, retain) NSMutableArray *artPieceViews;
@property (nonatomic, retain) UIBarButtonItem *refreshButton;

- (void)refresh;

@end
