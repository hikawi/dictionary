//
//  DTWordViewController.h
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import <UIKit/UIKit.h>
#import "Models/DTWordEntry.h"

NS_ASSUME_NONNULL_BEGIN

/// The view controller that is responsible for displaying a word entry's data.
@interface DTWordViewController : UIViewController

@property DTWordEntry *entry;

/// Initializes the word view controller with a word entry.
///
/// - Parameters:
///   - entry: The word entry.
- (instancetype)initWithEntry:(DTWordEntry *)entry;

@end

NS_ASSUME_NONNULL_END
