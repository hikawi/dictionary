//
//  DTWordDefinition.m
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import "DTWordDefinition.h"

@implementation DTWordDefinition

@synthesize definition;
@synthesize example;

- (instancetype)initWithDefinition:(NSString *)definition {
    return [self initWithDefinition:definition example:NULL];
}

- (instancetype)initWithDefinition:(NSString *)definition example:(NSString *)example {
    DTWordDefinition *inst = [self init];
    inst.definition = definition;
    inst.example = example;
    return inst;
}

@end
