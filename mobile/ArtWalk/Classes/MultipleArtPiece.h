//
//  MultipleArtPiece.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/01/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MultipleArtPiece : UITableViewController {
	NSMutableData *responseData;
	UIScrollView *scrollView;
    UITableView *myTableView;
    NSArray *artPieces;
}

@property (nonatomic, retain) NSArray *artPieces;
@end
