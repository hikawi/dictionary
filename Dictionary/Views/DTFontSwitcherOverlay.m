//
//  DTFontSwitcherOverlay.m
//  Dictionary
//
//  Created by Luna on 2025/06/01.
//

#import "DTFontSwitcherOverlay.h"
#import "DTFontSwitcherChoice.h"
#import "Utils/DTFontManager.h"

@interface DTFontSwitcherOverlay () <DTFontSwitcherChoiceDelegate> {
    UIView *fontSwitcher;
}

@end

@implementation DTFontSwitcherOverlay

- (instancetype)initWithView:(UIView *)view {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self->fontSwitcher = view;
        [self setup];
    }
    return self;
}

- (void)handleChoice:(DTFontType)choice {
    UIView *superview = self.superview;
    [self removeFromSuperview];
    [superview layoutIfNeeded];

    // Bubble up delegates.
    if(self.delegate) {
        [self.delegate handleChoice:choice];
    }
}

- (UIView *)makeChoiceFor:(DTFontType)type font:(NSString *)fontName label:(NSString *)text {
    DTFontSwitcherChoice *choice = [[DTFontSwitcherChoice alloc] initWithType:type label:text fontName:fontName];
    choice.delegate = self;
    return choice;
}

- (void)setup {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.userInteractionEnabled = YES;
    self.clipsToBounds = YES;

    [self->fontSwitcher.superview addSubview:self];

    // Setup the stack view.
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.backgroundColor = [UIColor colorNamed:@"DictionaryPopupBackground"];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 12;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.layoutMarginsRelativeArrangement = YES;
    stackView.layoutMargins = UIEdgeInsetsMake(16, 16, 16, 16);
    [self addSubview:stackView];
    [NSLayoutConstraint activateConstraints:@[
        [stackView.topAnchor constraintEqualToAnchor:self->fontSwitcher.bottomAnchor constant:18],
        [stackView.trailingAnchor constraintEqualToAnchor:self->fontSwitcher.trailingAnchor],
    ]];

    // Setup the shadow and corner radius.
    stackView.clipsToBounds = YES;
    stackView.layer.cornerRadius = 16;
    stackView.layer.masksToBounds = NO;
    stackView.layer.shadowColor = [UIColor colorNamed:@"DictionaryPopupShadow"].CGColor;
    stackView.layer.shadowOffset = CGSizeMake(0, 5);
    stackView.layer.shadowRadius = 30;
    stackView.layer.shouldRasterize = YES;
    stackView.layer.rasterizationScale = UIScreen.mainScreen.scale;

    // Add buttons to the stack view.
    [stackView addArrangedSubview:[self makeChoiceFor:DTFontTypeSansSerif
                                                 font:@"Inter-Regular_Bold"
                                                label:@"Sans-Serif"]];
    [stackView addArrangedSubview:[self makeChoiceFor:DTFontTypeSerif font:@"Lora-Regular_Bold" label:@"Serif"]];
    [stackView addArrangedSubview:[self makeChoiceFor:DTFontTypeMonospaced
                                                 font:@"Inconsolata-Regular_Bold"
                                                label:@"Mono"]];

    // Add the tap gesture recognizer for the view to handle closing the overlay.
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(viewDidTap)];
    [self addGestureRecognizer:tapGesture];
}

- (void)viewDidTap {
    [self removeFromSuperview];
}

@end
