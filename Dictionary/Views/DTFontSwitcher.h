//
//  DTFontSwitcher.h
//  Dictionary
//
//  Created by Luna on 2025/05/31.
//

#import <UIKit/UIKit.h>
#import "DTFontSwitcherChoice.h"

NS_ASSUME_NONNULL_BEGIN

/// The dropdown holder for the font switcher.
@interface DTFontSwitcher : UIView

@property id<DTFontSwitcherChoiceDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
