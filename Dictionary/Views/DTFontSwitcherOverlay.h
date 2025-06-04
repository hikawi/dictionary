//
//  DTFontSwitcherOverlay.h
//  Dictionary
//
//  Created by Luna on 2025/06/01.
//

#import <UIKit/UIKit.h>
#import "DTFontSwitcherChoice.h"

NS_ASSUME_NONNULL_BEGIN

/// Represents the overlay that appears over the screen when the font switcher is tapped.
@interface DTFontSwitcherOverlay : UIView

/// The menu that opens with the font switcher.
@property UIView *menu;

/// The delegate for this font switcher.
@property id<DTFontSwitcherChoiceDelegate> delegate;

/// Initializes with the view to be positioned onto. This view should be the font switcher itself
/// so this overlay can be positioned right below it.
///
/// - Parameters:
///   - view: The UIView to position below.
- (instancetype)initWithView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
