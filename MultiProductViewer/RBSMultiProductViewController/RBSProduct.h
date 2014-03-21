//
//  RBSProduct.h
//  MultiProductViewer
//
//  Created by JN on 2014-3-18.
//  Copyright (c) 2014 Rebisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBSProduct : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *details;
@property (copy, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSURL *imageURL;

+ (instancetype)productWithDictionary:(NSDictionary *)dict;
+ (NSArray *)productsWithArray:(NSArray *)array;

@end
