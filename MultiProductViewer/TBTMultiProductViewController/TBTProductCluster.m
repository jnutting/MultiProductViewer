//
//  TBTProductCluster.m
//  MultiProductViewer
//
//  Created by JN on 2014-3-19.
//  Copyright (c) 2014 thoughtbot, inc. All rights reserved.
//

#import "TBTProductCluster.h"
#import "TBTProduct.h"

@implementation TBTProductCluster

+ (instancetype)productClusterWithTitle:(NSString *)title products:(NSArray *)products {
    TBTProductCluster *cluster = [[self alloc] init];
    cluster.title = title;
    cluster.products = products;
    return cluster;
}

+ (NSArray *)productClustersFromSpecs:(NSArray *)specs {
    NSMutableArray *clusters = [NSMutableArray arrayWithCapacity:[specs count]];
    for (NSDictionary *spec in specs) {
        NSString *title = spec[@"title"];
        NSArray *productSpecs = spec[@"products"];
        TBTProductCluster *cluster = [self productClusterWithTitle:title
                                                          products:[TBTProduct productsWithArray:productSpecs]];
        [clusters addObject:cluster];
    }
    return clusters;
}
@end
