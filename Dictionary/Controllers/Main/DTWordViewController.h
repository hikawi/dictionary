//
//  DTWordViewController.h
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import "Models/DTWordEntry.h"
#import "Views/DTFontSwitcherChoice.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// The view controller that is responsible for displaying a word entry's data.
@interface DTWordViewController : UIViewController <DTFontSwitcherChoiceDelegate>

@property DTWordEntry *entry;

/// Initializes the word view controller with word entries.
///
/// - Parameters:
///   - entries: The word entries.
- (instancetype)initWithEntries:(NSArray<DTWordEntry *> *)entries;

@end

NS_ASSUME_NONNULL_END
