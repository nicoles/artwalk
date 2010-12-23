//
//  MyViewController.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 10/11/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyViewController.h"
#import "extThree20JSON/extThree20JSON.h"

@implementation MyViewController

@synthesize textField;
@synthesize label;
@synthesize string;
@synthesize imageView;
@synthesize takePictureButton;
@synthesize selectFromCameraRollButton;
@synthesize locationManager;
@synthesize startingPoint;
@synthesize latitudeString;
@synthesize longitudeString;

- (void)viewDidLoad {
	self.locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
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
	self.imageView = nil;
	self.takePictureButton = nil;
	self.selectFromCameraRollButton = nil;
	self.locationManager = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[textField release];
	[label release];
	[string release];
	[latitudeString release];
	[longitudeString release];
	[imageView release];
	[takePictureButton release];
	[startingPoint release];
	[selectFromCameraRollButton release];
    [super dealloc];
}

#pragma mark -
- (IBAction)getCameraPicture:(id)sender{
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate=self;
	//picker.allowsEditing = YES;
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
	//access original image
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	imageView.image = image;
	//save image
	UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
	
	//display edited image in view
	//UIImage *image2 = [info objectForKey:@"UIImagePickerControllerEditedImage"];
	
	
	//imageview.image = [info objectForKey:UIImagePickerControllerOriginalImage];
	//UIImage *myImage = [info objectForKey:UIImagePickerControllerEditedImage];
	//UIImageWriteToSavedPhotosAlbum([info objectForKey:UIImagePickerControllerOriginalImage], nil, nil, nil);
		
	
    // Prep. the request
    TTURLRequest* request = [TTURLRequest requestWithURL: @"http://127.0.0.1:8000/upload/" delegate: self];
    request.httpMethod = @"POST";
    request.cachePolicy = TTURLRequestCachePolicyNoCache; 
	
    // Response will be JSON ... BUT WHY DO I NEED TO DO THIS HERE???
	request.response = [[[TTURLJSONResponse alloc] init] autorelease];
	
    // Set a header value
    [request setValue:[[UIDevice currentDevice] uniqueIdentifier] forHTTPHeaderField:@"Device-UID"];
	
    // Post a string
    //[request.parameters setObject:self.entity_title forKey:@"entity_title"];
	
	// Add the image to the request
	[request addFile:UIImageJPEGRepresentation(image,0.0) 
                mimeType:@"image/jpeg" 
                fileName:@"photo_test.jpeg"];
	
	// Add the current location to the request
	[request.parameters setObject:self.latitudeString forKey:@"latitude"];
	[request.parameters setObject:self.longitudeString forKey:@"longitude"];
	
	// Send the request
    [request sendSynchronously];

	[picker dismissModalViewControllerAnimated:YES];
		
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
	UIAlertView *alert;
	
	// Unable to save the image  
	if (error)
		alert = [[UIAlertView alloc] initWithTitle:@"Error" 
										   message:@"Unable to save image to Photo Album." 
										  delegate:self cancelButtonTitle:@"Ok" 
								 otherButtonTitles:nil];
	else // All is well
		alert = [[UIAlertView alloc] initWithTitle:@"Success" 
										   message:@"Image saved to Photo Album." 
										  delegate:self cancelButtonTitle:@"Ok" 
								 otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissModalViewControllerAnimated:YES];
}

#pragma mark CLLocationManagerDelegate Methods
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	if (startingPoint == nil) {
		self.startingPoint = newLocation;
	}
	
	[latitudeString autorelease];
	[longitudeString autorelease];
	latitudeString = [[NSString alloc] initWithFormat:@"%g", newLocation.coordinate.latitude];
	longitudeString = [[NSString alloc] initWithFormat:@"%g", newLocation.coordinate.longitude];
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSString *errorType = (error.code == kCLErrorDenied) ? @"Access Denied" : @"Unknown Error";
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error getting Location" message:errorType delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

@end
