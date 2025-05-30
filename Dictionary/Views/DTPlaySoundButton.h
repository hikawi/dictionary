//
//  DTPlaySoundButton.h
//  Dictionary
//
//  Created by Luna on 2025/05/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Represents a button that plays a sound associated with it when clicked.
@interface DTPlaySoundButton : UIButton

/// Initializes the button with the audio URL.
///
/// - Parameters:
///   - audio: The audio to initialize with.
- (instancetype)initWithAudio:(NSURL *_Nullable)audio;

@end

NS_ASSUME_NONNULL_END
