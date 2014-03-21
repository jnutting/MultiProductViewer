//
//  RBSProductCluster.m
//  MultiProductViewer
//
//  Created by JN on 2014-3-19.
//  Copyright (c) 2014 Rebisoft. All rights reserved.
//

#import "RBSProductCluster.h"
#import "RBSProduct.h"

@implementation RBSProductCluster

+ (instancetype)productClusterWithTitle:(NSString *)title products:(NSArray *)products {
    RBSProductCluster *cluster = [[self alloc] init];
    cluster.title = title;
    cluster.products = products;
    return cluster;
}

+ (NSArray *)productClustersFromSpecs:(NSArray *)specs {
    NSMutableArray *clusters = [NSMutableArray arrayWithCapacity:[specs count]];
    for (NSDictionary *spec in specs) {
        NSString *title = spec[@"title"];
        NSArray *productSpecs = spec[@"products"];
        RBSProductCluster *cluster = [self productClusterWithTitle:title
                                                          products:[RBSProduct productsWithArray:productSpecs]];
        [clusters addObject:cluster];
    }
    return clusters;
}
@end
