//
//  UITextField+Utility.h
//  TA-Libraries : Ashish Chauhan
//
//  Created by Ashish Chauhan on 17/10/14.
//  Copyright (c) 2014 TechAhead Software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShakeDirection) {
    ShakeDirectionHorizontal = 0,
    ShakeDirectionVertical
};


@interface UITextField (Utility)

+ (UITextField *)createTextFieldWithTag:(NSInteger)aTag
                                 startX:(CGFloat)aX
                                 startY:(CGFloat)aY
                                  width:(CGFloat)aW
                                 height:(CGFloat)aH
                            placeHolder:(NSString *)aPl
                               keyBoard:(BOOL)isNumber;

+ (void)setPloceHolderTextColor:(NSArray *)array color:(UIColor *)color;
+ (void)setLeftPadding:(NSArray *)arrayTxt margin:(CGFloat)margin;

// Shake ---
- (void)shake;

- (void)shakeWithCount:(int)times
             withDelta:(CGFloat)detla
             withSpeed:(NSTimeInterval)speed
         withDirection:(ShakeDirection)direction
           complietion:(void(^)())handler;

-(void)addToolbarWithButtonTitled:(NSString *)title
                        forTarget:(id)target
                         selector:(SEL)selector;

- (void)setInputViewDatePickerOfType:(UIDatePickerMode)pickerMode
                           forTarget:(id)target
                            selector:(SEL)seledtor;

@end
