//
//  TBTProductCluster.h
//  MultiProductViewer
//
//  Created by JN on 2014-3-19.
//  Copyright (c) 2014 thoughtbot, inc.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBTProductCluster : UICollectionViewController

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSArray *products;

+ (instancetype)productClusterWithTitle:(NSString *)title products:(NSArray *)products;
+ (NSArray *)productClustersFromSpecs:(NSArray *)specs;

@end
