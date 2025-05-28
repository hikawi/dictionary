//
//  DTWordViewController.m
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import "DTWordViewController.h"

@interface DTWordViewController ()

@end

@implementation DTWordViewController

@synthesize entry;

- (instancetype)initWithEntry:(DTWordEntry *)entry {
    self = [self init];
    self.entry = entry;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the word's spelling.
    UILabel *spellingLabel = [[UILabel alloc] init];
    spellingLabel.text = entry.word;
    spellingLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1];
    spellingLabel.textColor = UIColor.whiteColor;
    spellingLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:spellingLabel];
    [NSLayoutConstraint activateConstraints:@[
        [spellingLabel.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
        [spellingLabel.centerYAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerYAnchor],
    ]];
}

@end
