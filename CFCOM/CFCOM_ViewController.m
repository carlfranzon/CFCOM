//
//  CFCOM_ViewController.m
//  CFCOM
//
//  Created by Carl Franzon on 2012-06-29.
//  Copyright (c) 2012 Atea SE. All rights reserved.
//

#import "CFCOM_ViewController.h"

@implementation CFCOM_ViewController

@synthesize lblPost;
@synthesize lblPostTitle;
@synthesize webPostContent;
@synthesize lblPostText;


- (IBAction)getResponse:(id)sender{
    NSArray *args = [NSArray arrayWithObjects:@"1",@"admin",@"cyubers1",nil];   // the param(s)
	NSString *server = @"http://carlfranzon.com/xmlrpc.php";         // the server
	NSString *method = @"wp.getPosts";                        // the method
	XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:server]];
	[request setMethod:method withObjects:args];
	NSArray *response = [self executeXMLRPCRequest:request];
    NSLog(@"Response: %@", response);
	[request release];
    
    for (int i = 0; i < [response count]; i += 1) {
        //resDic
        //[resOutput appendString:[[result objectAtIndex:i] valueForKey:@"post_title"]];
        //if (i < ([result count] -1)) {
        //    [resOutput appendString:@", "];
        //}
        NSLog(@"Result [%d], post_title: %@", i, [[response objectAtIndex:i] valueForKey:@"post_title"]);
    }
    NSLog(@"Response[%i], Title: %@", ([[lblPost text] intValue]-1), [[response objectAtIndex:([[lblPost text] intValue])-1] valueForKey: @"post_title"]);
    
	if( [response isKindOfClass:[NSString class]] ) {
		lblPostText.text = @"error";
	}
    
    lblPostTitle.text = [[response objectAtIndex:([[lblPost text] intValue])-1] valueForKey: @"post_title"];
    lblPostText.text = [[response objectAtIndex:([[lblPost text] intValue])-1] valueForKey: @"post_content"]; // the response key
    [webPostContent loadHTMLString:lblPostText.text baseURL:nil];
	
}

- (IBAction)changeValue:(id)sender {
    lblPost.text = [NSString stringWithFormat:@"%g", [stepper value]];
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
    [self setlblPostTitle:nil];
    [self setLblPostText:nil];
    [stepper release];
    stepper = nil;
    [self setStepper:nil];
    [webPostContent release];
    webPostContent = nil;
    [self setWebPostContent:nil];
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
    [webPostContent release];
    [webPostContent release];
    [super dealloc];
}
@end
