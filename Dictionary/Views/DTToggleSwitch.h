//
//  DTToggleSwitch.h
//  Dictionary
//
//  Created by Luna on 2025/05/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// The delegate protocol that binds the switch with some events.
@protocol DTToggleSwitchDelegate <NSObject>

/// Called when the switch got toggled successfully, with the state it gets toggled to. Since
/// it's a binary choice, the previous state is easily derived.
///
/// - Parameters:
///   - state: The state that the switch got toggled to.
- (void)switchDidToggle:(BOOL)state;

@end

/// This application's UISwitch implementation as the native implementation did not allow
/// moving and changing height and width as you please.
///
/// And also, just good practice to add accessibility elements to custom interactive element,
/// I think.
@interface DTToggleSwitch : UIView

/// Whether the switch is toggled on.
@property BOOL on;

/// The delegate of this switch.
@property id<DTToggleSwitchDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
