//
//  EditingController.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/01/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	<CoreLocation/CoreLocation.h>

@interface EditingController : UIViewController <CLLocationManagerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
	UITextField *artPieceTitle;
	UITextField *artPieceArtist;
	UITextView *artPieceNote;
	UITextField *artPieceTags;
	UIImageView *imageView;
	UIButton *takePictureButton;
	UIButton *updateArtPieceButton;
	NSString *latitudeString;
	NSString *longitudeString;
	CLLocationManager *locationManager;
	CLLocation *startingPoint;
	NSString *artPieceId;
	
}

@property (nonatomic, retain) IBOutlet UITextField *artPieceTitle;
@property (nonatomic, retain) IBOutlet UITextField *artPieceArtist;
@property (nonatomic, retain) IBOutlet UITextView *artPieceNote;
@property (nonatomic, retain) IBOutlet UITextField *artPieceTags;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *takePictureButton;
@property (nonatomic, retain) IBOutlet UIButton *updateArtPieceButton;
@property (nonatomic, retain) NSString *latitudeString;
@property (nonatomic, retain) NSString *longitudeString;
@property (nonatomic, retain) NSString *artPieceId;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *startingPoint;

- (IBAction)getCameraPicture:(id)sender;
- (IBAction)selectExistingPicture;
- (IBAction)updateArtPiece;

@end
