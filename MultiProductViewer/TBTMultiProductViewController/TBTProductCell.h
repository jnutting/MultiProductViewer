//
//  TBTProductCell.h
//  MultiProductViewer
//
//  Created by JN on 2014-3-19.
//  Copyright (c) 2014 thoughtbot, inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TBTProduct;

@interface TBTProductCell : UICollectionViewCell

@property (strong, nonatomic) TBTProduct *product;

// These methods let you customize the names of the UIImage instances
// used for the default icon and failed icon. The default icon is used
// until the specified image has been loaded, and the failed icon is
// used in case the specified image can't be loaded
+ (void)setDefaultIconName:(NSString *)name;
+ (void)setFailedIconName:(NSString *)name;

@end
