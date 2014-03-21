//
//  TBTProductCell.m
//  MultiProductViewer
//
//  Created by JN on 2014-3-19.
//  Copyright (c) 2014 Rebisoft. All rights reserved.
//

#import "TBTProductCell.h"
#import "TBTProduct.h"

@interface TBTProductCell ()

@property (strong, nonatomic) IBOutlet UILabel *detailsLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *iconView;

@end

static NSString *defaultIconName = @"defaultIcon";
static NSString *failedIconName = @"failedIcon";

@implementation TBTProductCell

+ (void)setDefaultIconName:(NSString *)name {
    defaultIconName = name;
}

+ (void)setFailedIconName:(NSString *)name; {
    failedIconName = name;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = [UIColor whiteColor];
    
    UIView* selectedBGView = [[UIView alloc] initWithFrame:self.bounds];
    selectedBGView.backgroundColor = self.tintColor;
    self.selectedBackgroundView = selectedBGView;
    
    self.iconView.layer.cornerRadius = 16;
    self.iconView.layer.masksToBounds = YES;
}

- (void)setProduct:(TBTProduct *)product {
    if (![product isEqual:_product]) {
        _product = product;
        self.detailsLabel.text = _product.details;
        self.titleLabel.text = _product.name;
        self.iconView.image = [UIImage imageNamed:defaultIconName];
        NSURLRequest *request = [NSURLRequest requestWithURL:_product.imageURL];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
        {
            // This includes an extra check to make sure we're still showing the same
            // product, in case this cell has been re-used.
            UIImage *image = nil;
            if (data &&
                ((NSHTTPURLResponse *)response).statusCode == 200 &&
                product == _product &&
                (image = [UIImage imageWithData:data])) {
                    self.iconView.image = image;
            } else {
                self.iconView.image = [UIImage imageNamed:failedIconName];
            }
        }];
    }
}

@end
