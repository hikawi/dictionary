//
//  DTWordEntry.h
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import <Foundation/Foundation.h>
#import "DTWordPhonetic.h"
#import "DTWordMeaning.h"

NS_ASSUME_NONNULL_BEGIN

/// Represents a word entry, indexed by the word spelling. A word can have multiple
/// entries, for example an entry for nouns and an entry for verbs version of that word,
/// usually separated by how you pronounce it.
@interface DTWordEntry : NSObject

@property NSString *word;
@property NSArray<DTWordPhonetic *> *phonetics;
@property NSArray<DTWordMeaning *> *meanings;
@property NSArray<NSURL *> *sources;

/// Retrieves the first phonetic with a phonetic text and a link to the audio file.
///
/// - Returns: The first "usable" phonetic pointer.
- (DTWordPhonetic *)firstUsablePhonetic;

/// Retrieves the entry for the word used for testing (keyboard).
///
/// - Returns: The word entry for "keyboard".
+ (DTWordEntry *)testWord;

@end

NS_ASSUME_NONNULL_END
