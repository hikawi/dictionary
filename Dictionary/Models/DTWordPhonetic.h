//
//  DTWordPhonetic.h
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Represents a phonetic for a word entry. This object contains
/// a phonetic string for the pronunication, and a URL to the audio file
/// for that pronunciation.
@interface DTWordPhonetic : NSObject

@property NSString *text;
@property(nullable) NSURL *audio;

/// Instantiates a phonetic with the IPA text.
///
/// - Parameters:
///   - text: The IPA text of the phonetic.
- (instancetype)initWithText:(NSString *)text;

/// Instantiates a phonetic with the IPA text.
///
/// - Parameters:
///   - text: The IPA text of the phonetic.
///   - urlString: The String representation of the URL to the audio file.
- (instancetype)initWithText:(NSString *)text audio:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
