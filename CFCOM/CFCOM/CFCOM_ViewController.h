//
//  CFCOM_ViewController.h
//  CFCOM
//
//  Created by Carl Franzon on 2012-06-29.
//  Copyright (c) 2012 Atea SE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLRPCResponse.h"
#import "XMLRPCRequest.h"
#import "XMLRPCConnection.h"

@interface CFCOM_ViewController : UIViewController {
    IBOutlet UILabel *lblPostTitle;
    IBOutlet UITextView *lblPostText;
    IBOutlet UILabel *lblPost;
    IBOutlet UIStepper *stepper;
    IBOutlet UIImageView *imgPostImage;
    UIImage *image;
}

@property (nonatomic, retain) IBOutlet UILabel *lblPost;
@property (retain, nonatomic) IBOutlet UILabel *lblPostTitle;
@property (retain, nonatomic) IBOutlet UITextView *lblPostText;
@property (retain, nonatomic) IBOutlet UIImageView *imgPostImage;
@property (nonatomic, retain) UIImage *image;

-(IBAction)getResponse:(id)sender;
- (IBAction)changeValue:(id)sender;
- (id) executeXMLRPCRequest:(XMLRPCRequest *)req;
- (void) loadImage: (id)url;

@end
