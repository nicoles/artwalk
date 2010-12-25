//
//  SearchResultsView.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 10/12/22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchResultsView : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	NSMutableArray *photoTitles;
	NSMutableArray *photoImage;
	NSMutableData *responseData;
	IBOutlet UITableView *theTableView;
}
@property (nonatomic, retain) IBOutlet UITableView *theTableView;

@end
