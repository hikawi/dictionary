//
//  DTMainViewController.m
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import "DTMainViewController.h"

@interface DTMainViewController ()

@end

@implementation DTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Put the text "Hello, World" in the main screen.
    UILabel *helloWorldLabel = [[UILabel alloc] init];
    helloWorldLabel.text = @"Hello, World";
    helloWorldLabel.textColor = UIColor.whiteColor;
    helloWorldLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1];
    helloWorldLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:helloWorldLabel];
    [NSLayoutConstraint activateConstraints:@[
        [helloWorldLabel.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
        [helloWorldLabel.centerYAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerYAnchor],
    ]];
}

@end
