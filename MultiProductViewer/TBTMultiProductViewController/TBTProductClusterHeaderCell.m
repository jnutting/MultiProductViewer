//
//  TBTProductClusterHeaderCell.m
//  MultiProductViewer
//
//  Created by JN on 2014-3-19.
//  Copyright (c) 2014 thoughtbot, inc. All rights reserved.
//

#import "TBTProductClusterHeaderCell.h"

@interface TBTProductClusterHeaderCell ()

@property (strong, nonatomic) IBOutlet UILabel *detailsLabel;

@end

@implementation TBTProductClusterHeaderCell

- (void)setHeaderText:(NSString *)headerText {
    if (![headerText isEqual:_headerText]) {
        _headerText = headerText;
        self.detailsLabel.text = _headerText;
    }
}

@end
