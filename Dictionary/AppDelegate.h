//
//  AppDelegate.h
//  Dictionary
//
//  Created by Luna on 2025/05/28.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@end
