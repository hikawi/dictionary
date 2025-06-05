//
//  DTFontSensitiveLabel.h
//  Dictionary
//
//  Created by Luna on 2025/06/06.
//

#import <UIKit/UIKit.h>
#import "DTFontSwitcherChoice.h"

NS_ASSUME_NONNULL_BEGIN

/// Represents a simple label that is sensitive to the font change operation.
@interface DTFontSensitiveLabel : UILabel <DTFontSwitcherChoiceDelegate>

@property CGFloat size;
@property DTFontWeight weight;
@property BOOL italics;

/// Initializes the label with a size and a regular weight.
///
/// - Parameters:
///   - size: The font size in px.
- (instancetype)initWithSize:(CGFloat)size;

/// Initializes the label with a size and a weight.
///
/// - Parameters:
///   - size: The floating point number representing the font size.
///   - weight: The weight of the font.
- (instancetype)initWithSize:(CGFloat)size weight:(DTFontWeight)weight;

/// Initializes the label with an italicized font face and a size and weight.
///
/// - Parameters:
///   - size: The font size in px.
///   - weight: The weight of the font.
- (instancetype)initItalicWithSize:(CGFloat)size weight:(DTFontWeight)weight;

@end

NS_ASSUME_NONNULL_END
