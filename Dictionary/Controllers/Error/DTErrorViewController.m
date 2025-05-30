//
//  DTErrorViewController.m
//  Dictionary
//
//  Created by Luna on 2025/05/30.
//

#import "DTErrorViewController.h"

@interface DTErrorViewController ()

@end

@implementation DTErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Create the main view to put in the middle of this view.
    UIView *mainView = [[UIView alloc] init];
    mainView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:mainView];
    [NSLayoutConstraint activateConstraints:@[
        [mainView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
        [mainView.centerYAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerYAnchor],
        [mainView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [mainView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
    ]];

    // Add the sad emoji label.
    UILabel *sadEmojiLabel = [[UILabel alloc] init];
    sadEmojiLabel.text = @"😵";
    sadEmojiLabel.font = [UIFont systemFontOfSize:64];
    sadEmojiLabel.textColor = [UIColor colorNamed:@"DictionaryPrimaryLabel"];
    sadEmojiLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [mainView addSubview:sadEmojiLabel];
    [NSLayoutConstraint activateConstraints:@[
        [sadEmojiLabel.topAnchor constraintEqualToAnchor:mainView.topAnchor],
        [sadEmojiLabel.centerXAnchor constraintEqualToAnchor:mainView.centerXAnchor],
    ]];

    // Add the "Error" label.
    UILabel *errorLabel = [[UILabel alloc] init];
    errorLabel.text = @"An error occurred";
    errorLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    errorLabel.textColor = [UIColor colorNamed:@"DictionaryPrimaryLabel"];
    errorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [mainView addSubview:errorLabel];
    [NSLayoutConstraint activateConstraints:@[
        [errorLabel.topAnchor constraintEqualToAnchor:sadEmojiLabel.bottomAnchor constant:48],
        [errorLabel.centerXAnchor constraintEqualToAnchor:sadEmojiLabel.centerXAnchor],
    ]];

    // Add the paragraph explaining what that means.
    UILabel *detailsLabel = [[UILabel alloc] init];
    detailsLabel.text =
        @"There was a problem loading the definition, could be because of Internet issues, the server being "
        @"down or the code was poorly written. Hopefully try again later?";
    detailsLabel.font = [UIFont systemFontOfSize:18];
    detailsLabel.numberOfLines = 0;
    detailsLabel.textColor = [UIColor colorNamed:@"DictionarySecondaryLabel"];
    detailsLabel.textAlignment = NSTextAlignmentCenter;
    detailsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [mainView addSubview:detailsLabel];
    [NSLayoutConstraint activateConstraints:@[
        [detailsLabel.leadingAnchor constraintEqualToAnchor:mainView.leadingAnchor],
        [detailsLabel.trailingAnchor constraintEqualToAnchor:mainView.trailingAnchor],
        [detailsLabel.topAnchor constraintEqualToAnchor:errorLabel.bottomAnchor constant:16],
        [detailsLabel.bottomAnchor constraintEqualToAnchor:mainView.bottomAnchor],
    ]];
}

@end
