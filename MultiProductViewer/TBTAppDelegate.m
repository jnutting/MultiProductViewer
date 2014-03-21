//
//  RBSAppDelegate.m
//  MultiProductViewer
//
//  Created by JN on 2014-3-18.
//  Copyright (c) 2014 thoughtbot, inc. All rights reserved.
//

#import "TBTAppDelegate.h"
#import "TBTMultiProductViewController.h"
#import "TBTProduct.h"
#import "TBTProductCluster.h"
#import "TBTDummyViewController.h"

@implementation TBTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    TBTDummyViewController *controller = [[TBTDummyViewController alloc] initWithNibName:@"RBSDummyViewController" bundle:nil];
    self.window.rootViewController = controller;
    return YES;
}

@end
