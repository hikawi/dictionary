//
//  DTToggleSwitch.m
//  Dictionary
//
//  Created by Luna on 2025/05/31.
//

#import "DTToggleSwitch.h"

@interface DTToggleSwitch () {
    BOOL on;
}

@property NSLayoutConstraint *leadingConstraint;

@property UIView *switchBackground;
@property UIView *switchThumb;

@end

@implementation DTToggleSwitch

@synthesize delegate;

@synthesize switchBackground;
@synthesize switchThumb;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
        self.on = NO;
    }
    return self;
}

- (BOOL)on {
    return self->on;
}

- (void)setOn:(BOOL)on {
    self->on = on;

    // Triggers updates.
    // I moved this into a separate block because it looks cleaner with clang format.
    void (^animateBlock)(void) = ^{
      if (on) {
          self.switchBackground.backgroundColor = [UIColor colorNamed:@"DictionaryPrimary"];
          self.leadingConstraint.constant = 23;
          self.accessibilityValue = @"On";
          self.superview.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
      } else {
          self.switchBackground.backgroundColor = [UIColor colorNamed:@"DictionarySecondaryLabel"];
          self.leadingConstraint.constant = 3;
          self.accessibilityValue = @"Off";
          self.superview.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
      }
      [self layoutIfNeeded];
    };

    // Animate that block.
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:animateBlock
                     completion:NULL];
}

- (void)setup {
    // Setup accessibility elements.
    self.accessibilityLabel = @"Dark Mode Switcher";
    self.accessibilityValue = self.on ? @"Dark" : @"Light";
    self.userInteractionEnabled = YES;

    self.translatesAutoresizingMaskIntoConstraints = NO;

    // Setup the background for the switch, which has 40w 20h, and holds the primary color if on,
    // and the secondary label color if off.
    self.switchBackground = [[UIView alloc] init];
    self.switchBackground.translatesAutoresizingMaskIntoConstraints = NO;
    self.switchBackground.clipsToBounds = YES;
    self.switchBackground.layer.cornerRadius = 10;
    [self addSubview:self.switchBackground];
    [NSLayoutConstraint activateConstraints:@[
        [self.switchBackground.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.switchBackground.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.switchBackground.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.switchBackground.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.switchBackground.heightAnchor constraintEqualToConstant:20],
        [self.switchBackground.widthAnchor constraintEqualToConstant:40],
    ]];

    // Setup the switch thumb, which is a circle that has a radius of 7px. Inset in the background
    // by 3px.
    self.switchThumb = [[UIView alloc] init];
    self.switchThumb.translatesAutoresizingMaskIntoConstraints = NO;
    self.switchThumb.clipsToBounds = YES;
    self.switchThumb.layer.cornerRadius = 7;
    self.switchThumb.backgroundColor = UIColor.whiteColor;
    [self.switchBackground addSubview:self.switchThumb];
    self.leadingConstraint = [self.switchThumb.leadingAnchor constraintEqualToAnchor:self.switchBackground.leadingAnchor
                                                                            constant:3];
    [NSLayoutConstraint activateConstraints:@[
        [self.switchThumb.heightAnchor constraintEqualToConstant:14],
        [self.switchThumb.widthAnchor constraintEqualToConstant:14],
        [self.switchThumb.centerYAnchor constraintEqualToAnchor:self.switchBackground.centerYAnchor],
        self.leadingConstraint,
    ]];

    // Now we set up the moon icon image.
    UIImage *moonImage = [UIImage systemImageNamed:@"moon"];
    UIImageView *moonImageView = [[UIImageView alloc] initWithImage:moonImage];
    moonImageView.tintColor = [UIColor colorNamed:@"DictionaryPrimary"];
    moonImageView.translatesAutoresizingMaskIntoConstraints = NO;
    moonImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:moonImageView];
    [NSLayoutConstraint activateConstraints:@[
        [moonImageView.leadingAnchor constraintEqualToAnchor:self.switchBackground.trailingAnchor constant:8],
        [moonImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [moonImageView.centerYAnchor constraintEqualToAnchor:self.switchBackground.centerYAnchor],
    ]];

    // Finally, the tap gesture recognizer.
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleTap)];
    [self addGestureRecognizer:tapGesture];
}

- (void)handleTap {
    self.on = !self.on;
}

@end
