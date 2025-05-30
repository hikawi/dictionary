//
//  DTFontManager.h
//  Dictionary
//
//  Created by Luna on 2025/05/31.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Represents the type of the font that should be used to display the UI in.
typedef NS_ENUM(NSUInteger, DTFontType) {
    /// The sans-serif font, this uses the Inter typeface.
    DTFontTypeSansSerif,

    /// The serif font, this uses the Lora typeface.
    DTFontTypeSerif,

    /// The monospaced font, this uses the Inconsolata typeface.
    DTFontTypeMonospaced,
};

/// Represents the font weight to accept in as `UIFontWeight` is just a placeholder for some number
/// instead of being enumerable in switch cases.
typedef NS_ENUM(NSInteger, DTFontWeight) {
    DTFontWeightExtraLight = 100,
    DTFontWeightLight = 200,
    DTFontWeightThin = 300,
    DTFontWeightRegular = 400,
    DTFontWeightMedium = 500,
    DTFontWeightSemiBold = 600,
    DTFontWeightBold = 700,
    DTFontWeightExtraBold = 800,
    DTFontWeightBlack = 900,
};

/// Represents the font manager for the application to provide fonts, corresponding to
/// the font currently set by the user.
@interface DTFontManager : NSObject

/// Sets the application's currently used font face.
///
/// - Parameters:
///   - type: The type to set to.
+ (void)setFontType:(DTFontType)type;

/// Gets the application's currently used font face.
///
/// - Returns: The font type.
+ (DTFontType)fontType;

/// Retrieves a `UIFont` instance of the currently used font of a specified size.
///
/// - Parameters:
///   - size: The font size.
+ (UIFont *)fontOfSize:(CGFloat)size;

/// Retrieves a `UIFont` instance of the currently used font of a specified size and weight.
///
/// - Parameters:
///   - size: The font size.
///   - weight: The font weight.
+ (UIFont *)fontOfSize:(CGFloat)size weight:(DTFontWeight)weight;

/// Retrieves an italicized version of `UIFont` of the currently used font of a specified
/// size.
///
/// - Parameters:
///   - size: The font size.
+ (UIFont *)italicFontOfSize:(CGFloat)size;

/// Retrieves an italicized version of `UIFont` of the currently used font of a specified
/// size and weight.
///
/// - Parameters:
///   - size: The font size.
///   - weight: The font weight.
+ (UIFont *)italicFontOfSize:(CGFloat)size weight:(DTFontWeight)weight;

@end

NS_ASSUME_NONNULL_END
