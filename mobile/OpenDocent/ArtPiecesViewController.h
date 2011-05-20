//
//  ArtPiecesViewController.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/05/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ArtPiecesViewController : UITableViewController {
    NSArray *artPiecesInStore;
}

@property (nonatomic, retain) NSArray *artPiecesInStore;

- (void)refresh;

@end
