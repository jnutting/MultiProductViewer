//
//  RBSAppDelegate.m
//  MultiProductViewer
//
//  Created by JN on 2014-3-18.
//  Copyright (c) 2014 Rebisoft. All rights reserved.
//

#import "RBSAppDelegate.h"
#import "RBSMultiProductViewController.h"
#import "RBSProduct.h"
#import "RBSProductCluster.h"
#import "RBSDummyViewController.h"

@implementation RBSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    /*
    NSArray *items = @[
                       @{@"identifier" : @"825459863",
                         @"name" : @"First App",
                         @"details" : @"this is an app",
                         @"imageURLString" : @"http://rebisoft.com/_Media/crunchy-copy_med.png"},
                       @{@"identifier" : @"1328473428",
                         @"name" : @"Second App",
                         @"details" : @"this is an app",
                         @"imageURLString" : @"http://foo.com/image.png"},
                       @{@"identifier" : @"1328473428",
                         @"name" : @"Third App",
                         @"details" : @"this is an 1 2 3 4 5 6 7 8 9 0 app skljflksjflksdj fkls jflk sjdflk sdklf skld jfklsajd fklsj dfkls djfkl jsdklf sdklfj ksladjf ",
                         @"imageURLString" : @"http://foo.com/image.png"},
                       @{@"identifier" : @"1328473428",
                         @"name" : @"Fourth App",
                         @"details" : @"this is an app",
                         @"imageURLString" : @"http://foo.com/image.png"},
                       @{@"identifier" : @"1328473428",
                         @"name" : @"Fifth App",
                         @"details" : @"this is an app",
                         @"imageURLString" : @"http://foo.com/image.png"},
                       @{@"identifier" : @"1328473428",
                         @"name" : @"Sixth App",
                         @"details" : @"this is an app",
                         @"imageURLString" : @"http://foo.com/image.png"},
                       ];
    NSArray *products = [RBSProduct productsWithArray:items];
    
    RBSMultiProductViewController *controller = [[RBSMultiProductViewController alloc] init];
    controller.productClusters = @[[RBSProductCluster productClusterWithTitle:@"First group" products:products],
                                   [RBSProductCluster productClusterWithTitle:@"Second Group" products:products]];
    controller.title = @"Other Apps from Rebisoft, the app company";
     */
    RBSDummyViewController *controller = [[RBSDummyViewController alloc] initWithNibName:@"RBSDummyViewController" bundle:nil];
    self.window.rootViewController = controller;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
