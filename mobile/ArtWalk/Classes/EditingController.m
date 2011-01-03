//
//  EditingController.m
//  ArtWalk
//
//  Created by Nicole Aptekar on 11/01/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EditingController.h"


@implementation EditingController

@synthesize artPieceTitle;
@synthesize artPieceArtist;
@synthesize	artPieceNote;
@synthesize artPieceTags;
@synthesize artPieceId;
@synthesize imageView;
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
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		takePictureButton.hidden = YES;
	}
}

//populate fields with viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	artPieceArtist = 
	artPieceTitle =
	artPieceTags =
	artPieceNote =
	imageView =
	[super viewWillAppear:animated];

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

//Keyboard return method
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	if (theTextField == artPieceTitle || artPieceArtist || artPieceTags || artPieceNote) {
		[artPieceTitle resignFirstResponder];
		[artPieceArtist resignFirstResponder];
		[artPieceTags resignFirstResponder];
		[artPieceNote resignFirstResponder];
	}
	
	return YES;
}

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
	[artPieceTags release];
	[artPieceNote release];
	[artPieceId release];
	[latitudeString release];
	[longitudeString release];
	[imageView release];
	[takePictureButton release];
	[startingPoint release];
    [super dealloc];
}


@end
