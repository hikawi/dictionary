# Dictionary App

## Description

This is a super simple, can be said to only have one single screen that shows the word's definitions and alike. This was created with UIKit and Objective-C as a learning opportunity, running against iOS 18.

## The Experience

Using OBJC to do this project, which at first I thought it would be quite small since the application only consists of one screen, but it started spiraling out as more and more components require inheritance from one of many UIKit's components.

All in all, I learned a lot of new things and it was relatively fun trying to do things in ObjC, which also surprises me that Apple still supports ObjC up into iOS 18. If any, my next project would be in Swift, or even using SwiftUI because this was not that fun to setup.

### Programmatic UI building

Instead of using Storyboard to build UIs, I initialized actual instances of UIKit components and lay them out in the view by using `NSLayoutConstraint`. This ended up being the most fun part of building.

To start this off, I cut off all references to the Main storyboard, and have `SceneDelegate` initialize my view controller class instead to make the key window.

### Naming Conventions

I don't know if it's supposed to be conventions, but I remember reading somewhere that OBJC classes should have a prefix in front of them, just like how classes from the Foundation module always start with `NS` (`NSString`, `NSArray`, `NSData`, etc.) and classes from UIKit module always starts with `UI`. I went with a shortened-version of "Dictionary" to make `DT` my prefix for this project.

### Swapping between states

There's a need to swap between states of the view, like having a valid word to show, having an internet connection error or the word doesn't exist, and even a loading state. Using SwiftUI, it looked to be pretty simple to have some `if`-`else` statement to separate views, but with UIKit and OBJC, I went with having a **child view controller**.

That means, the main controller holds an instance of a child view controller (or `UIViewController`), and swaps in and out when necessary.

### Persistent Data

Since I don't have a need to utilize the SQLite implementation, because, no data with proper relations. I went with a simple key-value map present within `NSUserDefaults`, akin to Android's `SharedPreferences'. I used this to store simple values like the current override theme or the current font style.

### Font Switching

At first, I chose to change the font faces of the UI by reloading the UI, but this makes it pretty awkward, or I wasn't able to implement it clearly. I chose to reload the font faces by keeping an array of labels, inherited from `UILabel` called `DTFontSensitiveLabel`, that has a method to change the font. Once the font is selected, I call this method.

### Theme Switcher

As you may know, iOS and also Android provides its own theme for the device, and usually, you should obey by the user's device settings. But to better show the theme switch in action, I overrode the theme for the view.

Also, the switch toggle is fully custom, as the `UISwitch` provided by UIKit does not support scaling with layout constraints.

## Features

- [x] Dark Mode Switcher
- [x] Font Switcher
- [x] API-based fetch
- [x] Loading state
- [x] No word state
- [x] Error state

