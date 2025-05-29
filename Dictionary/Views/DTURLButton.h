//
//  DTURLButton.h
//  Dictionary
//
//  Created by Luna on 2025/05/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Represents a button that can be clicked to open up a link.
@interface DTURLButton : UIButton

@property NSURL *url;

/// Creates a URL button with the provided URL.
///
/// - Parameters:
///   - url: The URL to initialize with.
- (instancetype)initWithURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
