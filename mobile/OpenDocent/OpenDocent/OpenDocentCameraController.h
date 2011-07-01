//
//  OpenDocentCameraController.h
//  OpenDocent
//
//  Created by Nicole Aptekar on 11/05/25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface OpenDocentCameraController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImageView *imageView;
//    MPMoviePlayerController *moviePlayerController;
    UIImage *image;
    NSURL *mediaURL;
    NSString *lastChosenMediaType;
//    CGRect imageFrame;
    
}

@property (nonatomic, retain) UIImageView *imageView;
//@property (nonatomic, retain) MPMoviePlayerController *moviePlayerController;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSURL *mediaURL;
@property (nonatomic, copy) NSString *lastChosenMediaType;


@end
