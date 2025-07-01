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
//@property (copy, nonatomic) NSString *title;
@property (weak, nonatomic) id <TBTMultiProductViewControllerDelegate> delegate;

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
    UIViewController *appRoot = [[UIApplication sharedApplication].windows.firstObject rootViewController];
    UINavigationController *navCon = [[UINavigationController alloc] init];
    navCon.viewControllers = @[self];
    [appRoot presentViewController:navCon animated:YES completion:nil];
}

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    return [self initWithCollectionViewLayout:layout];
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

    // Figure out where our resources live. Hope this works now!
    NSString *podBundlePath = [[NSBundle bundleForClass:self.class] pathForResource:@"MultiProductViewer" ofType:@"bundle"];
    NSBundle *podBundle = [NSBundle bundleWithPath:podBundlePath];

    // Register cells and supplementary views
    [self.collectionView registerNib:[UINib nibWithNibName:@"TBTProductCell" bundle:podBundle]
          forCellWithReuseIdentifier:@"Product"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TBTProductClusterHeaderCell" bundle:podBundle] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeader"];
    
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
#if TARGET_IPHONE_SIMULATOR
    // In the simulator, none of this actually works, it can just hang indefinitely.
    [[[UIAlertView alloc] initWithTitle:@"Simulator"
                                message:[NSString stringWithFormat:
                                         @"You need to run on a real device to see this. The simulator doesn't really do it."]
                               delegate:self
                      cancelButtonTitle:@"That's too bad."
                      otherButtonTitles:nil] show];
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
#else
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    SKStoreProductViewController *productViewController = [[SKStoreProductViewController alloc] init];
    productViewController.delegate = self;
    
    NSString *identifier = [self productAtIndexPath:indexPath].identifier;
    NSDictionary *params = @{SKStoreProductParameterITunesItemIdentifier : identifier};
    [productViewController loadProductWithParameters:params
                                     completionBlock:^(BOOL result, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (result)
        {
            [self
             presentViewController:productViewController animated:YES completion:nil];
            
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
#endif
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

#pragma mark Store Kit delegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    NSLog(@"SKStoreProductViewController finished");
    [viewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark private

- (TBTProduct *)productAtIndexPath:(NSIndexPath *)indexPath {
    TBTProductCluster *cluster = self.productClusters[indexPath.section];
    return cluster.products[indexPath.row];
}

- (IBAction)cancel:(id)sender {
    UIViewController *appRoot = [[UIApplication sharedApplication].windows.firstObject rootViewController];
    [appRoot dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(multiProductViewControllerDidFinish:)]) {
            [self.delegate multiProductViewControllerDidFinish:self];
        }
    }];
}

@end
