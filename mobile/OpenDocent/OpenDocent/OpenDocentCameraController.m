//
//  OpenDocentCameraController.m
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/05/25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OpenDocentCameraController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "ArtPieceDetailController.h"

/*@interface OpenDocentCameraController()
static UIImage *shrinkImage(UIImage *original, CGSize size);
- (void)updateDisplay;
- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType;
@end
*/
@implementation OpenDocentCameraController

@synthesize lastChosenMediaType;
@synthesize imageView;
//@synthesize moviePlayerController;
@synthesize image;
@synthesize mediaURL;


- (void)viewDidLoad{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
//    imageFrame = imageView.frame;

}

- (void)viewDidAppear:(BOOL)animated{
    //[super viewDidAppear:animated];
    ArtPieceDetailController *createArtPiece = [[ArtPieceDetailController alloc] initWithStyle:UITableViewStyleGrouped];
    createArtPiece.title = @"New Art";
    [self.navigationController pushViewController:createArtPiece animated:NO];
    [createArtPiece release];
}

- (void)viewDidUnload{
    self.imageView = nil;
    [super viewDidUnload];
}

- (void)dealloc{
    [imageView release];
    [mediaURL release];
    [image release];
    [lastChosenMediaType release];
    [super dealloc];
    
}

#pragma mark - 
#pragma mark UIImagePickerController delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.lastChosenMediaType = [info objectForKey:UIImagePickerControllerMediaType];
    self.mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
    //NSLog(@"url! @%", mediaURL);
    NSLog(@"Scheme: %@", [mediaURL scheme]); 
    NSLog(@"Host: %@", [mediaURL host]); 
    NSLog(@"Port: %@", [mediaURL port]);     
    NSLog(@"Path: %@", [mediaURL path]);     
    NSLog(@"Relative path: %@", [mediaURL relativePath]);
    NSLog(@"Path components as array: %@", [mediaURL pathComponents]);        
    NSLog(@"Parameter string: %@", [mediaURL parameterString]);   
    NSLog(@"Query: %@", [mediaURL query]);       
    NSLog(@"Fragment: %@", [mediaURL fragment]);
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0) {
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];
        [picker release];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Error accessing media" message:@"Device doesn't support that media source." delegate:nil cancelButtonTitle:@"Sorry" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}
@end
