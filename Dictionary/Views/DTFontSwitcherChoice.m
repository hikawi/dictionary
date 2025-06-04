//
//  DTFontSwitcherChoice.m
//  Dictionary
//
//  Created by Luna on 2025/06/02.
//

#import "DTFontSwitcherChoice.h"

@interface DTFontSwitcherChoice () {
    NSString *label;
    NSString *fontName;
    DTFontType type;
}

@end

@implementation DTFontSwitcherChoice

- (instancetype)initWithType:(DTFontType)type label:(NSString *)label fontName:(nonnull NSString *)fontName {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self->type = type;
        self->fontName = fontName;
        self->label = label;
        [self setup];
    }
    return self;
}

- (void)setup {
    // Setup the title and color.
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeading;
    [self setTitle:self->label forState:UIControlStateNormal];

    if (DTFontManager.fontType == self->type) {
        [self setTitleColor:[UIColor colorNamed:@"DictionaryPrimary"] forState:UIControlStateNormal];
    } else {
        [self setTitleColor:[UIColor colorNamed:@"DictionaryPrimaryLabel"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorNamed:@"DictionaryPrimary"] forState:UIControlStateHighlighted];
    }

    self.titleLabel.font = [UIFont fontWithName:self->fontName size:16];
    [self addTarget:self action:@selector(handleTap:) forControlEvents:UIControlEventTouchDown];
    self.userInteractionEnabled = YES;
    [NSLayoutConstraint activateConstraints:@[
        [self.widthAnchor constraintGreaterThanOrEqualToConstant:100],
    ]];
}

- (void)handleTap:(UILongPressGestureRecognizer *)gesture {
    DTFontManager.fontType = self->type;
    if (self.delegate) {
        [self.delegate handleChoice:self->type];
    }
}

@end
