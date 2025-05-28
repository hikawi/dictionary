//
//  DTMainViewController.m
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import "DTMainViewController.h"
#import "DTWordViewController.h"

@interface DTMainViewController ()

@end

@implementation DTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Put the child view controller.
    DTWordViewController *wordController = [[DTWordViewController alloc] initWithEntry:DTWordEntry.testWord];
    wordController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:wordController];
    [self.view addSubview:wordController.view];
    [NSLayoutConstraint activateConstraints:@[
        [wordController.view.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:16],
        [wordController.view.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor
                                                         constant:-16],
        [wordController.view.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor
                                                          constant:16],
        [wordController.view.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor
                                                           constant:-16],
    ]];
    [wordController didMoveToParentViewController:self];
}

@end
