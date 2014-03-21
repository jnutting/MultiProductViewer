MultiProductViewer implements a GUI for displaying multiple App Store products in a scrolling list.
By tapping on a product, the user is taken to a page where they can see more info about the app and
purchase it, using SKStoreProductViewController.

Background:
-----

This functionality was originally (in iOS 5 and iOS 6) implemented by SKStoreProductViewController
itself. You could just pass it your company identifier, and it would present all of your company's
products in a list, and let the user drill down to get more info and purchase apps. Starting with
iOS 7, that functionality is no longer supported, so we wrote this class to add it back.

What it does:
-----

Not content with just imitating the old behavior, we've improved it by showing a larger icon, and
giving the user the ability to include a small piece of text for each app. In this way, you can
give a little more info on the list view. Also, we let you pick exactly which apps you want to show,
and group them together.

In the old Apple way of doing things, you would just provide a company identifier, and Apple would
do the rest. Since that's not really feasible from the client side using public APIs, here we're
requiring you to provide the list of apps you want to show, and provide four pieces of data for each
of them: A name, Apple identifier, icon URL, and a text string with additional descriptive content.
The configuration can be easily specified using JSON or a dictionary.

Usage:
-----

Create a JSON file with the following structure:

```
{ "productSpecs" : [
        {
            "title" : "Awesome Games",
            "products" : [
                    {
                          "name" : "FlippyBit",
                          "details" : "Party like it's 1979! Flippy Bit takes the great action of early 2014, and makes it look like it's on an old Atari.",
                          "identifier" : "825459863",
                          "imageURLString" : "http://rebisoft.com/appicons/flippybit512.png"
                    },
                    {
                          "name" : "Scribattle",
                          "details" : "Put your finger-flicking abilities to the test in this all-but-forgotten 2009 App Store hit game!",
                          "identifier" : "301618970",
                          "imageURLString" : "http://rebisoft.com/appicons/scribattle100.png"
                    },
                    {
                          "name" : "Diabolotros",
                          "details" : "Imagine Space Invaders designed for people with keen eyesight and excellent balance.",
                          "identifier" : "315350668",
                          "imageURLString" : "http://rebisoft.com/appicons/diabolotros512.png"
                    },
            ]
        },
        {
            "title" : "Free Games",
            "products" : [
                    {
                          "name" : "Scribattle Lite",
                          "details" : "The free cousin of Scribattle. Try before you buy! And then, buy!",
                          "identifier" : "306058202",
                          "imageURLString" : "http://rebisoft.com/appicons/scribattle100.png"
                    },
                    {
                          "name" : "Diabolotros Lite",
                          "details" : "This free version of Diabolotros lets you come to grips with the Supergun and, perhaps, THE BOMB.",
                          "identifier" : "315938586",
                          "imageURLString" : "http://rebisoft.com/appicons/diabolotros512.png"
                    },
            ]
        },
    ]
}
```

Then, in your application, import a couple of classes:

```
#import "TBTMultiProductViewController.h"
#import "TBTProductCluster.h"
```

When you want to display the view, do something like this:
```
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"example" withExtension:@"json"];
    NSError *error;
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    if (jsonData) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (dict) {
            NSArray *specs = dict[@"productSpecs"];
            NSArray *productClusters = [TBTProductCluster productClustersFromSpecs:specs];
            [TBTMultiProductViewController runWithTitle:@"Other Apps"
                                        productClusters:productClusters
                                               delegate:self];
        }
    }
```

You will also need to implement a couple of delegate methods. These will tell you when nothing
more is happening. You must dismiss the view controller passed into either of these methods.

```
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    NSLog(@"SKStoreProductViewController finished");
    [viewController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)multiProductViewControllerDidFinish:(TBTMultiProductViewController *)viewController {
    NSLog(@"RBSMultiProductViewController finished");
    [viewController dismissViewControllerAnimated:YES completion:^{
    }];
}
```

See the included example application for full usage details.

Installation
-----
If you're using Cocoapods, just add the following line to your Podfile:
```
pod 'MultiProductViewer'
```






