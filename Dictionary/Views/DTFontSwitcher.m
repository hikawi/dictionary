//
//  DTFontSwitcher.m
//  Dictionary
//
//  Created by Luna on 2025/05/31.
//

#import "DTFontSwitcher.h"
#import "DTFontSwitcherOverlay.h"
#import "Utils/DTFontManager.h"

@interface DTFontSwitcher () <DTFontSwitcherChoiceDelegate> {
    UILabel *fontLabel;
    DTFontSwitcherOverlay *overlay;
}

@end

@implementation DTFontSwitcher

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setup];
    }
    return self;
}

/// This delegate function is bubbled up from `DTFontSwitcherOverlay`. Set from using a long press recognizer
/// to this object to be the delegate.
///
/// Updates the label of the font switcher and delegates up to the main view controller.
- (void)handleChoice:(DTFontType)choice {
    [self updateLabel];
}

- (void)updateLabel {
    switch (DTFontManager.fontType) {
    case DTFontTypeSerif:
        self->fontLabel.text = @"Serif";
        break;
    case DTFontTypeMonospaced:
        self->fontLabel.text = @"Mono";
        break;
    default:
        self->fontLabel.text = @"Sans-Serif";
        break;
    }
    self->fontLabel.font = [DTFontManager fontOfSize:14 weight:DTFontWeightBold];
}

- (void)setup {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.userInteractionEnabled = YES;

    // Load from UserPreferences.
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    if ([defaults objectForKey:@"font"] == NULL) {
        DTFontManager.fontType = DTFontTypeSansSerif;
    } else {
        DTFontManager.fontType = (NSUInteger)[defaults objectForKey:@"font"];
    }

    // Setup the font display.
    self->fontLabel = [[UILabel alloc] init];
    [self updateLabel];
    self->fontLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self->fontLabel];
    [NSLayoutConstraint activateConstraints:@[
        [self->fontLabel.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self->fontLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self->fontLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
    ]];

    // Setup the chevron icon.
    UIImage *chevronImage = [UIImage systemImageNamed:@"chevron.down"];
    UIImageView *chevronView = [[UIImageView alloc] initWithImage:chevronImage];
    chevronView.tintColor = [UIColor colorNamed:@"DictionaryPrimary"];
    chevronView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:chevronView];
    [NSLayoutConstraint activateConstraints:@[
        [chevronView.heightAnchor constraintEqualToConstant:12],
        [chevronView.centerYAnchor constraintEqualToAnchor:self->fontLabel.centerYAnchor],
        [chevronView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [chevronView.leadingAnchor constraintEqualToAnchor:self->fontLabel.trailingAnchor constant:16],
    ]];

    // Setup the tap gesture for this to animate and open a simple popup menu.
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] init];
    longPressGesture.minimumPressDuration = 0;
    [longPressGesture addTarget:self action:@selector(handlePressGesture:)];
    [self addGestureRecognizer:longPressGesture];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(0, 14);
}

- (void)handlePressGesture:(UILongPressGestureRecognizer *)gesture {
    UIView *view = gesture.view;

    void (^animateBlock)(void) = ^{
      if (gesture.state == UIGestureRecognizerStateBegan) {
          // Animate the icon scaling down.
          view.transform = CGAffineTransformScale(view.transform, 0.8, 0.8);
      } else {
          // Revert the transformation.
          view.transform = CGAffineTransformIdentity;

          // Sets up the delegate to open the popup.
          DTFontSwitcherOverlay *overlay = [[DTFontSwitcherOverlay alloc] initWithView:self];
          overlay.delegate = self;
          [NSLayoutConstraint activateConstraints:@[
            [overlay.leadingAnchor constraintEqualToAnchor:self.superview.leadingAnchor],
            [overlay.trailingAnchor constraintEqualToAnchor:self.superview.trailingAnchor],
            [overlay.topAnchor constraintEqualToAnchor:self.superview.topAnchor],
            [overlay.bottomAnchor constraintEqualToAnchor:self.superview.bottomAnchor],
          ]];
      }
    };

    [UIView animateWithDuration:0.2 animations:animateBlock];
}

@end
