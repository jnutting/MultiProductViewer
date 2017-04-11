//
//  TBTMultiProductViewController.h
//  MultiProductViewer
//
//  Created by JN on 2014-3-19.
//  Copyright (c) 2014 thoughtbot, inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@protocol TBTMultiProductViewControllerDelegate;

@interface TBTMultiProductViewController : UICollectionViewController


/*! Displays a modal GUI showing multiple products. Tapping any product will
 * display full details for the product and allow purchasing, by using the
 * SKStoreProdcutViewController class.
 * \param title The title to display at the top of the view
 * \param clusters An array of TBTProductCluster instances. Each cluster can
 * contain multiple products.
 * \param delegate This object is responsible for implementing methods to end
 * the modal session after the user has purchased something or tapped Cancel.
 */
+ (void)runWithTitle:(NSString *)title
     productClusters:(NSArray *)clusters
            delegate:(id <TBTMultiProductViewControllerDelegate>)delegate;

@end

@protocol TBTMultiProductViewControllerDelegate <SKStoreProductViewControllerDelegate>

/*! Sent if the user requests that the page be dismissed by tapping Cancel.
 * The receiver must dismiss the modal session when this method is called.
 * \param viewController The view controller that needs to be dismissed.
 */
- (void)multiProductViewControllerDidFinish:(TBTMultiProductViewController *)viewController;

@end