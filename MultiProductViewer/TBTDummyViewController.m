//
//  RBSDummyViewController.m
//  MultiProductViewer
//
//  Created by JN on 2014-3-20.
//  Copyright (c) 2014 thoughtbot, inc.. All rights reserved.
//

#import <StoreKit/StoreKit.h>
#import "TBTDummyViewController.h"
#import "TBTMultiProductViewController.h"
#import "TBTProductCluster.h"

@interface TBTDummyViewController () <RBSMultiProductViewControllerDelegate>

@end

@implementation TBTDummyViewController

- (IBAction)run:(id)sender {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"example" withExtension:@"json"];
    NSError *error;
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    if (jsonData) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (dict) {
            NSArray *specs = dict[@"productSpecs"];
            NSArray *productClusters = [TBTProductCluster productClustersFromSpecs:specs];
            [TBTMultiProductViewController runWithTitle:@"Other Apps"
                                        productClusters:productClusters
                                               delegate:self];
        }
    }
}

#pragma mark Store Kit delegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    NSLog(@"SKStoreProductViewController finished");
    [viewController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)multiProductViewControllerDidFinish:(TBTMultiProductViewController *)viewController {
    NSLog(@"RBSMultiProductViewController finished");
    [viewController dismissViewControllerAnimated:YES completion:^{
    }];
}
@end
