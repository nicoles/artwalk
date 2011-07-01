//
//  ArtPieceDetailController.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/05/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtPiece.h"
#define kNumberOfTotalRows      4   
#define kNumberOfMainRows       4
#define kTitleRowIndex          0
#define kArtistRowIndex         1
#define kDetailsRowIndex        2
#define kHistoryRowIndex        3


#define kLabelTag               4096

@interface ArtPieceDetailController : UITableViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, retain) ArtPiece *theArt;
@property (nonatomic, retain) NSArray *fieldLabels;
@property (nonatomic, retain) NSMutableDictionary *tempValues;
@property (nonatomic, retain) UITextField *textFieldBeingEdited;
@property (nonatomic, retain) NSManagedObjectContext *thisArtPieceContext;

- (IBAction)edit:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)textFieldDone:(id)sender;


@end
