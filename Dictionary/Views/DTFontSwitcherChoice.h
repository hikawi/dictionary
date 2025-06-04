//
//  DTFontSwitcherChoice.h
//  Dictionary
//
//  Created by Luna on 2025/06/02.
//

#import <UIKit/UIKit.h>
#import "Utils/DTFontManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DTFontSwitcherChoiceDelegate <NSObject>

/// Handles when the choice gets selected.
///
/// - Parameters:
///   - choice: The choice that the user selected.
- (void)handleChoice:(DTFontType)choice;

@end

/// Represents a simple text button that can be clicked on to change the application's main font face
/// to use.
@interface DTFontSwitcherChoice : UIButton

@property id<DTFontSwitcherChoiceDelegate> delegate;

/// Initializes with the type of the font to switch to and the label
/// to display on the button.
///
/// - Parameters:
///   - type: The font type.
///   - label: The button label.
///   - fontName: The font name to use for this button.
- (instancetype)initWithType:(DTFontType)type label:(NSString *)label fontName:(NSString *)fontName;

@end

NS_ASSUME_NONNULL_END
