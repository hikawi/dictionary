//
//  DTURLButton.m
//  Dictionary
//
//  Created by Luna on 2025/05/29.
//

#import "DTURLButton.h"

@implementation DTURLButton

@synthesize url;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)url {
    self = [self init];
    self.url = url;
    return self;
}

- (void)handleChoice:(DTFontType)choice {
    self.titleLabel.font = [DTFontManager fontOfSize:14];
}

- (void)setup {
    [self handleChoice:DTFontTypeSansSerif];
    [self addTarget:self action:@selector(buttonDidClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonDidClick {
    [UIApplication.sharedApplication openURL:self.url
                                     options:@{}
                           completionHandler:^(BOOL completed){
                           }];
}

@end
