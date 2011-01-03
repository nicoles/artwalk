//
//  EditingController.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/01/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EditingController.h"
#import "JSON.h"
#import "extThree20JSON/extThree20JSON.h"

@implementation EditingController

@synthesize artPieceTitle;
@synthesize artPieceArtist;
@synthesize	artPieceNote;
@synthesize artPieceTags;
@synthesize artPieceId;
@synthesize artPieceImageView;
@synthesize takePictureButton;
@synthesize updateArtPieceButton;
@synthesize locationManager;
@synthesize startingPoint;
@synthesize latitudeString;
@synthesize longitudeString;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"Update Page Loaded");
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		takePictureButton.hidden = YES;
	}
	//TODO: Split this out, so that the data comes from a delegate?
	responseData = [[NSMutableData data] retain];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://75.101.166.190/art_piece/36/?mode=json"]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

/*
//TODO: populate fields with viewWillAppear, rather than viewDidLoad
- (void)viewWillAppear:(BOOL)animated {
	artPieceArtist.text = [artPiece objectForKey:@"title"];

	//[super viewWillAppear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

//Keyboard return method
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	if (theTextField == artPieceTitle || artPieceTags || artPieceArtist || artPieceNote) {
		[theTextField resignFirstResponder];
	}
	return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.artPieceImageView = nil;
	self.takePictureButton = nil;
	self.locationManager = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[artPieceTitle release];
	[artPieceArtist release];
	[artPieceTags release];
	[artPieceNote release];
	[artPieceId release];
	[latitudeString release];
	[longitudeString release];
	[artPieceImageView release];
	[takePictureButton release];
	[startingPoint release];
	[responseData release];
    [super dealloc];
}

#pragma mark JSON UrlConnection
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
	NSLog(@"didrecieveresponse");
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
	NSLog(@"didrecievedata");
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	//	label.text = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	NSLog(@"DidFinishLoading: %@", responseData);
	// Store incoming data into a string
	NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	// Create a dictionary from the JSON string
	NSDictionary *artPiece = [jsonString JSONValue];
	
	artPieceTitle.text = [artPiece objectForKey:@"title"];
	
	NSArray *media = [artPiece objectForKey:@"media"];
	NSArray *artists = [artPiece objectForKey:@"artists"];
	
	for (NSDictionary *medium in media){
		//TODO: make this a carousel of the available images, and have it click to embiggen
		NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[medium objectForKey:@"url"]]];
		
		artPieceImageView.image = [UIImage imageWithData:imageData];
		
	}
	
	for (NSDictionary *artist in artists){
		artPieceArtist.text = [artPiece objectForKey:@"name"];
	}
	
	NSLog(@"objectforkey: %@", [artPiece objectForKey:@"title"]);

	[jsonString release];
	
	//TODO: this leaks memory. fix it.
	//	[results release];
	//	[imageData release];
	
	
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
	artPieceImageView.image = image;
	[picker dismissModalViewControllerAnimated:YES];
	
}

#pragma mark send data to server
- (IBAction)updateArtPiece{
	
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
	
    // Post a string
    //[request.parameters setObject:self.entity_title forKey:@"entity_title"];
	
	// Add the image to the request
	[request addFile:UIImageJPEGRepresentation(artPieceImageView.image,0.0) 
			mimeType:@"image/jpeg" 
			fileName:@"photo_test.jpeg"];
	
	// Add the current location to the request
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

@end
