//
//  SubmissionController.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 10/11/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface SubmissionController : UIViewController <CLLocationManagerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	UITextField *artPieceTitle;
	UITextField *artPieceArtist;
	
	NSString *string;
	NSString *latitudeString;
	NSString *longitudeString;
	UIImageView *imageView;
	UIButton *takePictureButton;
	UIButton *sendArtPieceButton;
	CLLocationManager *locationManager;
	CLLocation *startingPoint;
}

@property (nonatomic, retain) IBOutlet UITextField *artPieceTitle;
@property (nonatomic, retain) IBOutlet UITextField *artPieceArtist;

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *takePictureButton;
@property (nonatomic, retain) IBOutlet UIButton *sendArtPieceButton;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, retain) NSString *latitudeString;
@property (nonatomic, retain) NSString *longitudeString;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *startingPoint;

- (IBAction)getCameraPicture:(id)sender;
- (IBAction)selectExistingPicture;
- (IBAction)sendArtPiece;

@end
