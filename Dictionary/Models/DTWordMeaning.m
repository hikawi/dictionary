//
//  DTWordMeaning.m
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import "DTWordMeaning.h"

@implementation DTWordMeaning

@synthesize partOfSpeech;
@synthesize definitions;
@synthesize synonyms;
@synthesize antonyms;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.partOfSpeech = @"";
        self.definitions = @[];
        self.synonyms = @[];
        self.antonyms = @[];
    }
    return self;
}

@end
