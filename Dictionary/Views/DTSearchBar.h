//
//  DTSearchBar.h
//  Dictionary
//
//  Created by Luna on 2025/05/29.
//

#import <UIKit/UIKit.h>
#import "DTFontSwitcherChoice.h"

NS_ASSUME_NONNULL_BEGIN

/// The delegate for `DTSearchBar`.
@protocol DTSearchBarDelegate <NSObject>

/// Calls when the search button was pressed, provided with the search query
/// currently in the search box.
///
/// - Parameters:
///   - query: The query to pass.
- (void)searchDidPress:(NSString *)query;

@end

/// The UIView component that displays the customized search bar.
@interface DTSearchBar : UIView <DTFontSwitcherChoiceDelegate>

@property id<DTSearchBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
