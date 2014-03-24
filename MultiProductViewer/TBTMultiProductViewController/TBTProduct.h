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

/*! Creates a new instance from a dictionary.
 * \param dict A dictionary containing proper values for a given product:
 * 'name', 'details', 'identifier', and either 'imageURL' or 'imageURLString'
 */
+ (instancetype)productWithDictionary:(NSDictionary *)dict;

/*! Creates an array of new instances from an array of dictionaries. The
 * required dictionary values are the same as described for the
 * productWithDictionary: method.
 * \param array An array of specification dictionaries.
 */
+ (NSArray *)productsWithArray:(NSArray *)array;

@end
