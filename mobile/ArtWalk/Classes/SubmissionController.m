//
//  SubmissionController.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 10/11/23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SubmissionController.h"
#import "extThree20JSON/extThree20JSON.h"

@implementation SubmissionController

@synthesize artPieceTitle;
@synthesize artPieceArtist;
@synthesize string;
@synthesize imageView;
@synthesize takePictureButton;
@synthesize sendArtPieceButton;
@synthesize locationManager;
@synthesize startingPoint;
@synthesize latitudeString;
@synthesize longitudeString;

- (id)init{
	if (self = [super init]) {
		self.title = @"Submit New";
		self.tabBarItem.image = [UIImage imageNamed:@"168-upload-photo-2.png"];
	}
	return self;
}

- (void)viewDidLoad {
	self.locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		takePictureButton.hidden = YES;
	}
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	if (theTextField == artPieceTitle || artPieceArtist) {
		[artPieceTitle resignFirstResponder];
		[artPieceArtist resignFirstResponder];
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
	self.locationManager = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[artPieceTitle release];
	[artPieceArtist release];
	[string release];
	[latitudeString release];
	[longitudeString release];
	[imageView release];
	
	[takePictureButton release];
	[startingPoint release];
    [super dealloc];
}

#pragma mark Get Camera/Select Existing

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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	//access original image
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	imageView.image = image;
	
	//TODO: save image	
    
	[picker dismissModalViewControllerAnimated:YES];
		
}

#pragma mark send data to server

- (IBAction)sendArtPiece{

	// Prep. the request
	
	NSLog(@"totally button pressed");
    TTURLRequest* request = [TTURLRequest requestWithURL: @"http://75.101.166.190/upload/" delegate: self];
    request.httpMethod = @"POST";
    request.cachePolicy = TTURLRequestCachePolicyNoCache; 
	NSLog(@"request: %@", request);
	
    // Response will be JSON ... BUT WHY DO I NEED TO DO THIS HERE???
	request.response = [[[TTURLJSONResponse alloc] init] autorelease];
	
    // Set a header value
    [request setValue:[[UIDevice currentDevice] uniqueIdentifier] forHTTPHeaderField:@"Device-UID"];
	
	// Add the image to the request
	[request addFile:UIImageJPEGRepresentation(imageView.image,0.0) 
			mimeType:@"image/jpeg" 
			fileName:@"photo_test.jpeg"];
	
	// Add the current location to the request
	[request.parameters setObject:self.latitudeString forKey:@"latitude"];
	[request.parameters setObject:self.longitudeString forKey:@"longitude"];
	[request.parameters setObject:self.artPieceTitle.text forKey:@"title"];
	[request.parameters setObject:self.artPieceArtist.text forKey:@"artist"];
	
	// Send the request
    [request sendSynchronously];
	NSLog(@"request: %@", request);
	UIAlertView *alert;
	
	alert = [[UIAlertView alloc] initWithTitle:@"Success" 
										   message:@"Image sent to ArtWalk." 
										  delegate:self cancelButtonTitle:@"Ok" 
								 otherButtonTitles:nil];
	[alert show];
	[alert release];
	
	
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
