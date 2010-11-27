//
//  MyViewController.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 10/11/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyViewController.h"


@implementation MyViewController

@synthesize textField;
@synthesize label;
@synthesize string;
@synthesize imageview;
@synthesize takePictureButton;
@synthesize selectFromCameraRollButton;

- (void)viewDidLoad {
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		takePictureButton.hidden = YES;
		selectFromCameraRollButton.hidden = YES;
	}
}

- (IBAction)changeGreeting:(id)sender {
	self.string = textField.text;
	
	NSString *nameString = string;
	if ([nameString length] == 0) {
		nameString = @"World";
	}
	
	NSString *greeting = [[NSString alloc] initWithFormat:@"Hello, %@!", nameString];
	label.text = greeting;
	[greeting release];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	if (theTextField == textField) {
		[textField resignFirstResponder];
	}
	
	return YES;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.imageview = nil;
	self.takePictureButton = nil;
	self.selectFromCameraRollButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[textField release];
	[label release];
	[string release];
	[imageview release];
	[takePictureButton release];
	[selectFromCameraRollButton release];
    [super dealloc];
}

#pragma mark -
- (IBAction)getCameraPicture:(id)sender{
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate=self;
	picker.allowsEditing = YES;
	picker.sourceType = (sender == takePictureButton) ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	[self presentModalViewController:picker animated:YES];
	[picker release];
}

- (IBAction)selectExistingPicture{
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
		UIImagePickerController * picker = [[UIImagePickerController alloc] init];
		picker.delegate=self;
		picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
		[self presentModalViewController:picker animated:YES];
		[picker	release];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error accessing photo library" message:@"Device does not support a photo library" delegate:nil cancelButtonTitle:@"Boo!" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

#pragma mark -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	
	[picker dismissModalViewControllerAnimated:YES];
	[picker release];
	imageview.image = [info objectForKey:UIImagePickerControllerEditedImage];
	//imageview.image = [info objectForKey:UIImagePickerControllerOriginalImage];
	//UIImage *myImage = [info objectForKey:UIImagePickerControllerEditedImage];
	//UIImageWriteToSavedPhotosAlbum([info objectForKey:UIImagePickerControllerOriginalImage], nil, nil, nil);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissModalViewControllerAnimated:YES];
}
	

@end
