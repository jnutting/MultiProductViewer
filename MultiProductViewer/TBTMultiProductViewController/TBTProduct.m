//
//  TBTProduct.m
//  MultiProductViewer
//
//  Created by JN on 2014-3-18.
//  Copyright (c) 2014 Rebisoft. All rights reserved.
//

#import "TBTProduct.h"

@implementation TBTProduct

+ (instancetype)productWithDictionary:(NSDictionary *)dict {
    TBTProduct *product = [[self alloc] init];
    product.name = dict[@"name"];
    product.details = dict[@"details"];
    product.identifier = dict[@"identifier"];
    if (dict[@"imageURL"]) {
        product.imageURL = dict[@"imageURL"];
    } else if (dict[@"imageURLString"]) {
        product.imageURL = [NSURL URLWithString:dict[@"imageURLString"]];
    }
    return product;
}

+ (NSArray *)productsWithArray:(NSArray *)array {
    NSMutableArray *products = [NSMutableArray arrayWithCapacity:[array count]];
    for (NSDictionary *dict in array) {
        TBTProduct *product = [self productWithDictionary:dict];
        [products addObject:product];
    }
    return products;
}
@end
