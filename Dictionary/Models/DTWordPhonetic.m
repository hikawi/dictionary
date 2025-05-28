//
//  DTWordPhonetic.m
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import "DTWordPhonetic.h"

@implementation DTWordPhonetic

@synthesize text;
@synthesize audio;

- (instancetype)initWithText:(NSString *)text {
    DTWordPhonetic *inst = [self init];
    inst.text = text;
    inst.audio = NULL;
    return inst;
}

- (instancetype)initWithText:(NSString *)text audio:(NSString *)urlString {
    DTWordPhonetic *inst = [self initWithText:text];
    inst.audio = [NSURL URLWithString:urlString];
    return inst;
}

@end
