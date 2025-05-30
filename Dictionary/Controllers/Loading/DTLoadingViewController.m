//
//  DTLoadingViewController.m
//  Dictionary
//
//  Created by Luna on 2025/05/30.
//

#import "DTLoadingViewController.h"

@interface DTLoadingViewController ()

@end

@implementation DTLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Setup the simple stack view that holds the progress indicator.
    UIStackView *mainStackView = [[UIStackView alloc] init];
    mainStackView.axis = UILayoutConstraintAxisVertical;
    mainStackView.spacing = 4;
    mainStackView.alignment = UIStackViewAlignmentCenter;
    mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:mainStackView];
    [NSLayoutConstraint activateConstraints:@[
        [mainStackView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
        [mainStackView.centerYAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerYAnchor],
    ]];

    // Setup the progress indicator image.
    UIImage *progressImage =
        [[UIImage systemImageNamed:@"progress.indicator"] imageWithTintColor:[UIColor colorNamed:@"DictionarySecondaryLabel"]
                                                         renderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView *progressImageView = [[UIImageView alloc] initWithImage:progressImage];
    progressImageView.contentMode = UIViewContentModeScaleAspectFit;
    [NSLayoutConstraint activateConstraints:@[
        [progressImageView.heightAnchor constraintEqualToConstant:24],
        [progressImageView.widthAnchor constraintEqualToConstant:24],
    ]];
    [mainStackView addArrangedSubview:progressImageView];

    // Setup the "Loading" text.
    UILabel *loadingLabel = [[UILabel alloc] init];
    loadingLabel.text = @"Loading...";
    loadingLabel.textColor = [UIColor colorNamed:@"DictionarySecondaryLabel"];
    loadingLabel.font = [UIFont systemFontOfSize:16];
    [mainStackView addArrangedSubview:loadingLabel];

    // Setup the animation cycle for the progress indicator.
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.keyPath = @"transform.rotation.z";
    animation.fromValue = 0;
    animation.toValue = @(M_2_PI * 2);
    animation.duration = 1;
    animation.repeatDuration = INFINITY;
    [progressImageView.layer addAnimation:animation forKey:@"90rotation"];
    [progressImageView startAnimating];
}

@end
