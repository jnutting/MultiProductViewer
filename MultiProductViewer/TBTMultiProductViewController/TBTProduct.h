//
//  TBTProduct.h
//  MultiProductViewer
//
//  Created by JN on 2014-3-18.
//  Copyright (c) 2014 thoughtbot, inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBTProduct : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *details;
@property (copy, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSURL *imageURL;

+ (instancetype)productWithDictionary:(NSDictionary *)dict;
+ (NSArray *)productsWithArray:(NSArray *)array;

@end
