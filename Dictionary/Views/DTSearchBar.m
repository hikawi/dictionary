//
//  DTSearchBar.m
//  Dictionary
//
//  Created by Luna on 2025/05/29.
//

#import "DTSearchBar.h"
#import "Utils/DTFontManager.h"

@interface DTSearchBar () <UITextFieldDelegate>

@property UITextField *field;

@end

@implementation DTSearchBar

@synthesize field;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = [UIColor colorNamed:@"DictionarySecondaryBackground"];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 16;

    // Setup the end icon image.
    UIImage *searchImage = [UIImage systemImageNamed:@"magnifyingglass"];
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setImage:[searchImage imageWithTintColor:[UIColor colorNamed:@"DictionaryPrimary"]
                                             renderingMode:UIImageRenderingModeAlwaysOriginal]
                  forState:UIControlStateNormal];
    searchButton.translatesAutoresizingMaskIntoConstraints = NO;
    [searchButton addTarget:self action:@selector(searchButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:searchButton];
    [NSLayoutConstraint activateConstraints:@[
        [searchButton.heightAnchor constraintEqualToConstant:16],
        [searchButton.widthAnchor constraintEqualToConstant:16],
        [searchButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-24],
        [searchButton.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
    ]];

    // Setup the text field.
    self.field = [[UITextField alloc] init];
    self.field.backgroundColor = UIColor.clearColor;
    self.field.layoutMargins = UIEdgeInsetsZero;
    self.field.textColor = [UIColor colorNamed:@"DictionaryPrimaryLabel"];
    self.field.font = [DTFontManager fontOfSize:16 weight:DTFontWeightBold];
    self.field.delegate = self;
    self.field.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.field];
    [NSLayoutConstraint activateConstraints:@[
        [self.field.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.field.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:24],
        [self.field.trailingAnchor constraintEqualToAnchor:searchButton.leadingAnchor constant:-8],
    ]];

    // Setup the tap gesture recognizer.
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(viewDidTap)];
    [self addGestureRecognizer:tapGesture];
}

- (void)viewDidTap {
    [self.field becomeFirstResponder];
}

- (void)searchButtonDidPress {
    if(self.delegate != NULL) {
        [self.delegate searchDidPress:self.field.text];
        [self.field resignFirstResponder];
    }
}

- (BOOL)resignFirstResponder {
    [self.field resignFirstResponder];
    return [super resignFirstResponder];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(0, 48);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchButtonDidPress];
    return YES;
}

@end
