//
//  MyViewController.h
//  ArtWalk
//
//  Created by Nicole Aptekar on 10/11/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	UITextField *textField;
	
	UILabel *label;
	
	NSString *string;
	UIImageView *imageview;
	UIButton *takePictureButton;
	UIButton *selectFromCameraRollButton;
}

@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UIImageView *imageview;
@property (nonatomic, retain) IBOutlet UIButton *takePictureButton;
@property (nonatomic, retain) IBOutlet UIButton *selectFromCameraRollButton;
@property (nonatomic, copy) NSString *string;

- (IBAction)getCameraPicture:(id)sender;
- (IBAction)selectExistingPicture;
- (IBAction)changeGreeting:(id)sender;

@end
