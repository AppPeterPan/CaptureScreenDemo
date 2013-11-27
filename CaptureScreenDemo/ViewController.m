//
//  ViewController.m
//  CaptureScreenDemo
//
//  Created by Peter Pan on 11/27/13.
//  Copyright (c) 2013 Peter Pan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *orangeView;


@end

@implementation ViewController


- (UIImage *)captureView:(UIView *)targetView cropFrame:(CGRect)frame
{
    CALayer *layer;
    layer = targetView.layer;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(targetView.frame.size, NO, 0);
    else
        UIGraphicsBeginImageContext(targetView.frame.size);
    [targetView drawViewHierarchyInRect:targetView.bounds afterScreenUpdates:NO];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(screenImage.CGImage, frame);
    UIImage *cropImage = [UIImage imageWithCGImage:imageRef];

    return cropImage;
}

- (UIImage *)captureView:(UIView *)targetView
{
    CALayer *layer;
    layer = targetView.layer;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(targetView.frame.size, NO, 0);
    else
        UIGraphicsBeginImageContext(targetView.frame.size);
    [targetView drawViewHierarchyInRect:targetView.bounds afterScreenUpdates:NO];
    UIImage *captureImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return captureImage;
}

- (IBAction)captureButtonPressed:(id)sender {
    
    UIImage *image = [self captureView:self.orangeView];
    UIImageView *captureView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, self.orangeView.frame.size.width, self.orangeView.frame.size.height)];
    captureView.image = image;
    [self.view addSubview:captureView];
}


- (IBAction)cropButtonPressed:(id)sender {
    
    
    
    UIImage *snapshotImage;
    
    if([UIScreen mainScreen].scale > 1.0)
    {
        snapshotImage = [self captureView:self.orangeView cropFrame:CGRectMake(0, 100, 200, 200)];

    }
    else
    {
        snapshotImage = [self captureView:self.orangeView cropFrame:CGRectMake(0, 50, 100, 100)];

    }
    [self.orangeView removeFromSuperview];
    
    
    UIImageView *cropView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    cropView.image = snapshotImage;
    [self.view addSubview:cropView];

}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
