//
//  DTEmptyViewController.m
//  Dictionary
//
//  Created by Luna on 2025/05/30.
//

#import "DTEmptyViewController.h"

@interface DTEmptyViewController ()

@end

@implementation DTEmptyViewController

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
    sadEmojiLabel.text = @"😕";
    sadEmojiLabel.font = [UIFont systemFontOfSize:64];
    sadEmojiLabel.textColor = [UIColor colorNamed:@"DictionaryPrimaryLabel"];
    sadEmojiLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [mainView addSubview:sadEmojiLabel];
    [NSLayoutConstraint activateConstraints:@[
        [sadEmojiLabel.topAnchor constraintEqualToAnchor:mainView.topAnchor],
        [sadEmojiLabel.centerXAnchor constraintEqualToAnchor:mainView.centerXAnchor],
    ]];

    // Add the "No Definitions" label.
    UILabel *noDefinitionsLabel = [[UILabel alloc] init];
    noDefinitionsLabel.text = @"No Definitions Found";
    noDefinitionsLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    noDefinitionsLabel.textColor = [UIColor colorNamed:@"DictionaryPrimaryLabel"];
    noDefinitionsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [mainView addSubview:noDefinitionsLabel];
    [NSLayoutConstraint activateConstraints:@[
        [noDefinitionsLabel.topAnchor constraintEqualToAnchor:sadEmojiLabel.bottomAnchor constant:48],
        [noDefinitionsLabel.centerXAnchor constraintEqualToAnchor:sadEmojiLabel.centerXAnchor],
    ]];

    // Add the paragraph explaining what that means.
    UILabel *detailsLabel = [[UILabel alloc] init];
    detailsLabel.text = @"Sorry pal, we couldn't find definitions for the word you were looking for. You can try the "
                        @"search again at later time or head to the web instead.";
    detailsLabel.font = [UIFont systemFontOfSize:18];
    detailsLabel.numberOfLines = 0;
    detailsLabel.textColor = [UIColor colorNamed:@"DictionarySecondaryLabel"];
    detailsLabel.textAlignment = NSTextAlignmentCenter;
    detailsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [mainView addSubview:detailsLabel];
    [NSLayoutConstraint activateConstraints:@[
        [detailsLabel.leadingAnchor constraintEqualToAnchor:mainView.leadingAnchor],
        [detailsLabel.trailingAnchor constraintEqualToAnchor:mainView.trailingAnchor],
        [detailsLabel.topAnchor constraintEqualToAnchor:noDefinitionsLabel.bottomAnchor constant:16],
        [detailsLabel.bottomAnchor constraintEqualToAnchor:mainView.bottomAnchor],
    ]];
}

@end
