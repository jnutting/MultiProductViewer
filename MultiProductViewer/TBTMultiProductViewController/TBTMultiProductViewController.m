//
//  TBTMultiProductViewController.m
//  MultiProductViewer
//
//  Created by JN on 2014-3-19.
//  Copyright (c) 2014 thoughtbot, inc. All rights reserved.
//

#import "TBTMultiProductViewController.h"
#import "TBTProductCluster.h"
#import "TBTProduct.h"
#import "TBTProductCell.h"
#import "TBTProductClusterHeaderCell.h"
#import <StoreKit/StoreKit.h>

@interface TBTMultiProductViewController () <SKStoreProductViewControllerDelegate>

@property (copy, nonatomic) NSArray *productClusters;
@property (copy, nonatomic) NSString *title;
@property (weak, nonatomic) id <TBTMultiProductViewControllerDelegate> delegate;
@property (strong, nonatomic) UIViewController *parent;

@end

@implementation TBTMultiProductViewController

+ (void)runWithTitle:(NSString *)title
     productClusters:(NSArray *)clusters
            delegate:(id <TBTMultiProductViewControllerDelegate>)delegate {
    TBTMultiProductViewController *c = [[self alloc] init];
    c.title = title;
    c.productClusters = clusters;
    c.delegate = delegate;
    [c run];
}

- (void)run {
    UINavigationController *navCon = [[UINavigationController alloc] init];
    navCon.viewControllers = @[self];
    [self.parent presentViewController:navCon animated:YES completion:nil];
}

- (instancetype)init {
    if (!(self = [self initWithCollectionViewLayout:
                  [[UICollectionViewFlowLayout alloc] init]])) return nil;
    
    self.parent = [[UIApplication sharedApplication].windows.firstObject rootViewController];
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                  target:self
                                                                                  action:@selector(cancel:)];
    [cancelButton setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17]}
                                forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cells and supplementary views
    [self.collectionView registerNib:[UINib nibWithNibName:@"TBTProductCell" bundle:nil]
          forCellWithReuseIdentifier:@"Product"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TBTProductClusterHeaderCell" bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"SectionHeader"];
    
    // Configure flow layout
    UICollectionViewFlowLayout *layout = (id)[self collectionViewLayout];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 20, 0);
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(100, 30);
    
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark Collection View delegate & datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.productClusters count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TBTProductCluster *productCluster = self.productClusters[section];
    return [productCluster.products count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TBTProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Product"
                                                                     forIndexPath:indexPath];
    TBTProductCluster *cluster = self.productClusters[indexPath.section];
    cell.product = cluster.products[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    SKStoreProductViewController *productViewController = [[SKStoreProductViewController alloc] init];
    productViewController.delegate = self;
    
    NSString *identifier = [self productAtIndexPath:indexPath].identifier;
    NSDictionary *params = @{SKStoreProductParameterITunesItemIdentifier : identifier};
    [productViewController loadProductWithParameters:params
                                     completionBlock:^(BOOL result, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
#if TARGET_IPHONE_SIMULATOR
        if (YES)  // In the simulator, pretend this always works (it really never does)
#else
        if (result)
#endif
        {
            [self presentViewController:productViewController animated:YES completion:nil];
        } else {
            // The default store GUI isn't going to display. Give the user some feedback.
            [[[UIAlertView alloc] initWithTitle:@"App Store Error"
                                        message:[NSString stringWithFormat:
                                                 @"An error occurred while trying to show an app with identifier '%@': %@",
                                                 identifier, [error localizedDescription]]
                                       delegate:self
                              cancelButtonTitle:@"That's too bad."
                              otherButtonTitles:nil] show];
        }
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }];
}

- (BOOL)collectionView:(UICollectionView *)collectionView
shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath; {
    return YES;
}

#pragma mark - Flow Layout Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 116);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        TBTProductClusterHeaderCell *cell = [self.collectionView
                                             dequeueReusableSupplementaryViewOfKind:kind
                                             withReuseIdentifier:@"SectionHeader"
                                             forIndexPath:indexPath];
        
        cell.headerText = [self.productClusters[indexPath.section] title];
        return cell;
    }
    return nil;
}

#pragma mark SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark private

- (TBTProduct *)productAtIndexPath:(NSIndexPath *)indexPath {
    TBTProductCluster *cluster = self.productClusters[indexPath.section];
    return cluster.products[indexPath.row];
}

- (IBAction)cancel:(id)sender {
    [self.parent dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(multiProductViewControllerDidFinish:)]) {
            [self.delegate multiProductViewControllerDidFinish:self];
        }
    }];
}

@end
