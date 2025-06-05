//
//  DTFontSensitiveLabel.m
//  Dictionary
//
//  Created by Luna on 2025/06/06.
//

#import "DTFontSensitiveLabel.h"

@implementation DTFontSensitiveLabel

- (instancetype)initWithSize:(CGFloat)size {
    return [self initWithSize:size weight:DTFontWeightRegular];
}

- (instancetype)initWithSize:(CGFloat)size weight:(DTFontWeight)weight {
    self = [super init];
    if (self) {
        self.size = size;
        self.weight = weight;
        self.italics = NO;
        [self setup];
    }
    return self;
}

- (instancetype)initItalicWithSize:(CGFloat)size weight:(DTFontWeight)weight {
    self = [super init];
    if (self) {
        self.size = size;
        self.weight = weight;
        self.italics = YES;
        [self setup];
    }
    return self;
}

- (void)handleChoice:(DTFontType)choice {
    if(self.italics) {
        self.font = [DTFontManager italicFontOfSize:self.size weight:self.weight];
    } else {
        self.font = [DTFontManager fontOfSize:self.size weight:self.weight];
    }
}

- (void)setup {
    // Doesn't matter what you pass in.
    [self handleChoice:DTFontTypeSansSerif];
}

@end
