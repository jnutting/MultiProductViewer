//
//  RBSProductCell.h
//  MultiProductViewer
//
//  Created by JN on 2014-3-19.
//  Copyright (c) 2014 Rebisoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RBSProduct;

@interface RBSProductCell : UICollectionViewCell

@property (strong, nonatomic) RBSProduct *product;

// These methods let you customize the names of the UIImage instances
// used for the default icon and failed icon. The default icon is used
// until the specified image has been loaded, and the failed icon is
// used in case the specified image can't be loaded
+ (void)setDefaultIconName:(NSString *)name;
+ (void)setFailedIconName:(NSString *)name;

@end
