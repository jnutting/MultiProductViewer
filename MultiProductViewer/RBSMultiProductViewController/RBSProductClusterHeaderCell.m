//
//  RBSProductClusterHeaderCell.m
//  MultiProductViewer
//
//  Created by JN on 2014-3-19.
//  Copyright (c) 2014 Rebisoft. All rights reserved.
//

#import "RBSProductClusterHeaderCell.h"

@interface RBSProductClusterHeaderCell ()

@property (strong, nonatomic) IBOutlet UILabel *detailsLabel;

@end

@implementation RBSProductClusterHeaderCell

- (void)setHeaderText:(NSString *)headerText {
    if (![headerText isEqual:_headerText]) {
        _headerText = headerText;
        self.detailsLabel.text = _headerText;
    }
}

@end
