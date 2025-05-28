//
//  DTWordMeaning.h
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import <Foundation/Foundation.h>
#import "DTWordDefinition.h"

NS_ASSUME_NONNULL_BEGIN

/// An object holding the word's meaning.
@interface DTWordMeaning : NSObject

@property NSString *partOfSpeech;
@property NSArray<DTWordDefinition *> *definitions;
@property NSArray<NSString *> *synonyms;
@property NSArray<NSString *> *antonyms;

@end

NS_ASSUME_NONNULL_END
