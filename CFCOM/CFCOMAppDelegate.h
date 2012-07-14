//
//  CFCOMAppDelegate.h
//  CFCOM
//
//  Created by Carl Franzon on 2012-06-29.
//  Copyright (c) 2012 Atea SE. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFCOM_ViewController;

@interface CFCOMAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CFCOM_ViewController *viewController;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) IBOutlet CFCOM_ViewController *viewController;

@end
