//
//  TBTProductCluster.h
//  MultiProductViewer
//
//  Created by JN on 2014-3-19.
//  Copyright (c) 2014 thoughtbot, inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBTProductCluster : UICollectionViewController

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSArray *products;

/*! Creates a product cluster with a given titel and an array of products.
 * \param title The title to be displayed for this cluster of products.
 * \param products An array of TBTProduct instances.
 */
+ (instancetype)productClusterWithTitle:(NSString *)title products:(NSArray *)products;

/*! Creates an array of product clusters from an array of specifications.
 * \param specs Each object in this array should be a dictionary containing
 * values for "title" and "products". The value associated with "products"
 * should be an NSArray containing a list of product specifications, as
 * descroibed in the documentation for TBTProduct.
 */
+ (NSArray *)productClustersFromSpecs:(NSArray *)specs;

@end
