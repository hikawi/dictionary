//
//  DTFontManager.m
//  Dictionary
//
//  Created by Luna on 2025/05/31.
//

#import "DTFontManager.h"

static DTFontType fontType = DTFontTypeSansSerif;

@implementation DTFontManager

+ (DTFontType)fontType {
    return fontType;
}

+ (void)setFontType:(DTFontType)type {
    fontType = type;
}

+ (UIFont *)fontOfSize:(CGFloat)size {
    return [self fontOfSize:size weight:DTFontWeightRegular];
}

+ (UIFont *)fontOfSize:(CGFloat)size weight:(DTFontWeight)weight {
    NSString *fontName = @"Inter-Regular";
    switch (fontType) {
    case DTFontTypeSerif:
        switch (weight) {
        case DTFontWeightMedium:
            fontName = @"Lora-Regular_Medium";
            break;
        case DTFontWeightSemiBold:
            fontName = @"Lora-Regular_SemiBold";
            break;
        case DTFontWeightBold:
            fontName = @"Lora-Regular_Bold";
            break;
        default:
            fontName = @"Lora-Regular"; // No support for other weights.
            break;
        }
        break;
    case DTFontTypeMonospaced: // This typeface allows condensed, expanded versions too but we don't care.
        switch (weight) {
        case DTFontWeightExtraLight:
            fontName = @"Inconsolata-Regular_ExtraLight";
            break;
        case DTFontWeightLight:
            fontName = @"Inconsolata-Regular_Light";
            break;
        case DTFontWeightMedium:
            fontName = @"Inconsolata-Regular_Medium";
            break;
        case DTFontWeightSemiBold:
            fontName = @"Inconsolata-Regular_SemiBold";
            break;
        case DTFontWeightBold:
            fontName = @"Inconsolata-Regular_Bold";
            break;
        case DTFontWeightExtraBold:
            fontName = @"Inconsolata-Regular_ExtraBold";
            break;
        case DTFontWeightBlack:
            fontName = @"Inconsolata-Regular_Black";
            break;
        default:
            fontName = @"Inconsolata-Regular";
            break;
        }
        break;
    default:
        switch (weight) {
        case DTFontWeightExtraLight:
            fontName = @"Inter-Regular_ExtraLight";
            break;
        case DTFontWeightLight:
            fontName = @"Inter-Regular_Light";
            break;
        case DTFontWeightThin:
            fontName = @"Inter-Regular_Thin";
            break;
        case DTFontWeightMedium:
            fontName = @"Inter-Regular_Medium";
            break;
        case DTFontWeightSemiBold:
            fontName = @"Inter-Regular_SemiBold";
            break;
        case DTFontWeightBold:
            fontName = @"Inter-Regular_Bold";
            break;
        case DTFontWeightExtraBold:
            fontName = @"Inter-Regular_ExtraBold";
            break;
        case DTFontWeightBlack:
            fontName = @"Inter-Regular_Black";
            break;
        default:
            fontName = @"Inter-Regular";
            break;
        }
        break;
    }

    return [UIFont fontWithName:fontName size:size];
}

+ (UIFont *)italicFontOfSize:(CGFloat)size {
    return [self italicFontOfSize:size weight:DTFontWeightRegular];
}

+ (UIFont *)italicFontOfSize:(CGFloat)size weight:(DTFontWeight)weight {
    NSString *fontName = @"Inter-Italic";
    switch (fontType) {
    case DTFontTypeSerif:
        switch (weight) {
        case DTFontWeightMedium:
            fontName = @"Lora-Italic_Medium-Italic";
            break;
        case DTFontWeightSemiBold:
            fontName = @"Lora-Italic_SemiBold-Italic";
            break;
        case DTFontWeightBold:
            fontName = @"Lora-Italic_Bold-Italic";
            break;
        default:
            fontName = @"Lora-Italic"; // No support for other weights.
            break;
        }
        break;
    case DTFontTypeMonospaced: // This one doesn't support italicized versions.
        switch (weight) {
        case DTFontWeightExtraLight:
            fontName = @"Inconsolata-Regular_ExtraLight";
            break;
        case DTFontWeightLight:
            fontName = @"Inconsolata-Regular_Light";
            break;
        case DTFontWeightMedium:
            fontName = @"Inconsolata-Regular_Medium";
            break;
        case DTFontWeightSemiBold:
            fontName = @"Inconsolata-Regular_SemiBold";
            break;
        case DTFontWeightBold:
            fontName = @"Inconsolata-Regular_Bold";
            break;
        case DTFontWeightExtraBold:
            fontName = @"Inconsolata-Regular_ExtraBold";
            break;
        case DTFontWeightBlack:
            fontName = @"Inconsolata-Regular_Black";
            break;
        default:
            fontName = @"Inconsolata-Regular";
            break;
        }
        break;
    default:
        switch (weight) {
        case DTFontWeightExtraLight:
            fontName = @"Inter-Italic_ExtraLight-Italic";
            break;
        case DTFontWeightLight:
            fontName = @"Inter-Italic_Light-Italic";
            break;
        case DTFontWeightThin:
            fontName = @"Inter-Italic_Thin-Italic";
            break;
        case DTFontWeightMedium:
            fontName = @"Inter-Italic_Medium-Italic";
            break;
        case DTFontWeightSemiBold:
            fontName = @"Inter-Italic_SemiBold-Italic";
            break;
        case DTFontWeightBold:
            fontName = @"Inter-Italic_Bold-Italic";
            break;
        case DTFontWeightExtraBold:
            fontName = @"Inter-Italic_ExtraBold-Italic";
            break;
        case DTFontWeightBlack:
            fontName = @"Inter-Italic_Black-Italic";
            break;
        default:
            fontName = @"Inter-Italic";
            break;
        }
        break;
    }

    return [UIFont fontWithName:fontName size:size];
}

@end
