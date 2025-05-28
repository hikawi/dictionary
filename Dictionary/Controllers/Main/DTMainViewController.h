//
//  DTMainViewController.h
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import <UIKit/UIKit.h>
#import "DTWordEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface DTMainViewController : UIViewController

/// The entry that the view is currently displaying, if it is null.
@property DTWordEntry *_Nullable entry;

@end

NS_ASSUME_NONNULL_END
