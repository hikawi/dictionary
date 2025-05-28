//
//  DTWordDefinition.h
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// The object that holds content for a word definition, containing a single string explaining
/// the definition and maybe an example along with it.
@interface DTWordDefinition : NSObject

@property NSString *definition;
@property(nullable) NSString *example;

/// Initializes a definition with the definition text;
///
/// - Parameters:
///   - definition: The definition text.
- (instancetype)initWithDefinition:(NSString *)definition;

/// Initializes a definition with the definition text;
///
/// - Parameters:
///   - definition: The definition text.
///   - example: The example for this definition.
- (instancetype)initWithDefinition:(NSString *)definition example:(NSString *_Nullable)example;

@end

NS_ASSUME_NONNULL_END
