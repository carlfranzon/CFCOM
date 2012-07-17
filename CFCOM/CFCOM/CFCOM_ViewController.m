//
//  CFCOM_ViewController.m
//  CFCOM
//
//  Created by Carl Franzon on 2012-06-29.
//  Copyright (c) 2012 Atea SE. All rights reserved.
//

#import "CFCOM_ViewController.h"
#import "Element.h"
#import "DocumentRoot.h"


@implementation CFCOM_ViewController



@synthesize lblPost;
@synthesize lblPostTitle;
@synthesize lblPostText;
@synthesize imgPostImage;
@synthesize image = _image;


- (IBAction)getResponse:(id)sender{
    NSArray *args = [NSArray arrayWithObjects:@"1",@"admin",@"cyubers1",nil];   // the param(s)
	NSString *server = @"http://carlfranzon.com/xmlrpc.php";         // the server
	NSString *method = @"wp.getPosts";                        // the method
	XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:server]];
	[request setMethod:method withObjects:args];
	NSArray *response = [self executeXMLRPCRequest:request];
    //NSLog(@"Response: %@", response);
	[request release];
    
    for (int i = 0; i < [response count]; i += 1) {
        //resDic
        //[resOutput appendString:[[result objectAtIndex:i] valueForKey:@"post_title"]];
        //if (i < ([result count] -1)) {
        //    [resOutput appendString:@", "];
        //}
        //NSLog(@"Result [%d], post_title: %@", i, [[response objectAtIndex:i] valueForKey:@"post_title"]);
    }
    NSLog(@"Response[%i], Title: %@", ([[lblPost text] intValue]-1), [[response objectAtIndex:([[lblPost text] intValue])-1] valueForKey: @"post_title"]);
    
	if( [response isKindOfClass:[NSString class]] ) {
		lblPostText.text = @"error";
	}
    
    NSString *post_html = [[response objectAtIndex:([[lblPost text] intValue])-1] valueForKey: @"post_content"]; //Gets the value from the 'post_content' key from WP, in html format
    
    lblPostTitle.text = [[response objectAtIndex:([[lblPost text] intValue])-1] valueForKey: @"post_title"];
    //lblPostText.text = post_html; // the response key
    
	
    
    DocumentRoot *document = [Element parseHTML: post_html];
    
    NSString *post_text = [document contentsText]; //
    
    //NSLog(@"Text: %@", post_text);
    
    lblPostText.text = post_text;
    
    NSArray *post_image_elements = [document selectElements:@"a img[src]"];
    
    NSLog(@"Post_html: %@", post_html);
    
    NSLog(@"imageElement: %@", post_image_elements);
    
    NSMutableArray *post_image_links = [[NSMutableArray alloc] init];
    //NSMutableArray *post_images = [[NSMutableArray alloc] init];
    
    if (post_image_elements) {
        
    
    for (Element *element in post_image_elements) {
        NSString *imglink = [element attribute:@"src"];
        [post_image_links addObject:imglink];
        //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imglink]]];
        NSOperationQueue *queue = [NSOperationQueue new];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadImage:) object:imglink];
        [queue addOperation:operation];
        [operation release];
        //[post_images addObject:_image];
    }
    NSLog(@"Img_links: %@", post_image_links);
    
    //if ([post_images count] != 0) imgPostImage.image = [post_images objectAtIndex:0];
    }
    
    
    
    
}

- (IBAction)changeValue:(id)sender {
    lblPost.text = [NSString stringWithFormat:@"%g", [stepper value]];
}

- (void) loadImage:(id)url{
    NSLog(@"from loadImage, url: %@", url);
    UIImage *curImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:url]]];
    _image = curImage;
    NSMutableArray *post_images = [[NSMutableArray alloc] init];
    [post_images addObject:_image];
    if ([post_images count] != 0) imgPostImage.image = [post_images objectAtIndex:0];
    
}

- (id) executeXMLRPCRequest:(XMLRPCRequest *)req {
    XMLRPCResponse *userInfoResponse = [XMLRPCConnection sendSynchronousXMLRPCRequest:req];
    return [userInfoResponse object];
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:@"CFCOM_ViewController" bundle:nil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [lblPostTitle release];
    lblPostTitle = nil;
    [lblPostText release];
    lblPostText = nil;
    [self setLblPostTitle:nil];
    [self setLblPostText:nil];
    [stepper release];
    stepper = nil;
    //[self setStepper:nil];
    [imgPostImage release];
    imgPostImage = nil;
    [self setImgPostImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

- (void)dealloc {
    [lblPostTitle release];
    [lblPostText release];
    [lblPostTitle release];
    [lblPostText release];
    [stepper release];
    [stepper release];
    [imgPostImage release];
    [imgPostImage release];
    [super dealloc];
}
@end