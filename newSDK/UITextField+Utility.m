//
//  UITextField+Utility.m
//  TA-Libraries : Ashish Chauhan
//
//  Created by Ashish Chauhan on 17/10/14.
//  Copyright (c) 2014 TechAhead Software. All rights reserved.
//

#import "UITextField+Utility.h"
//#import "TAButton.h"

@implementation UITextField (Utility)

+ (UITextField *)createTextFieldWithTag:(NSInteger)aTag startX:(CGFloat)aX startY:(CGFloat)aY width:(CGFloat)aW height:(CGFloat)aH placeHolder:(NSString *)aPl keyBoard:(BOOL)isNumber
{
    UITextField *aTextField=[[UITextField alloc] init];
    aTextField.frame = CGRectMake(aX,aY ,aW ,aH);
    aTextField.tag = aTag;
    aTextField.placeholder = aPl;
    aTextField.backgroundColor=[UIColor whiteColor];
    aTextField.textColor = [UIColor blackColor];
    aTextField.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    aTextField.borderStyle = UITextBorderStyleRoundedRect ;
    if (isNumber)
        aTextField.keyboardType = UIKeyboardTypeNumberPad;
    else
        aTextField.keyboardType = UIKeyboardTypeDefault;
    aTextField.returnKeyType = UIReturnKeyDone;
    aTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //aTextField.text = aPl;
    aTextField.textAlignment = NSTextAlignmentLeft;
    return aTextField;
}

+ (void)setPloceHolderTextColor:(NSArray *)array color:(UIColor *)color
{
    
    for (UITextField *textField in array) {
        NSString *placeholderText = textField.placeholder;
        
        if (placeholderText) {
            if ([textField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
                textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderText attributes:@{NSForegroundColorAttributeName: color}];
            } else {
                
                NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
                // TODO: Add call-back code to set placeholder color.
            }
        }
    }
    
}

+ (void)setLeftPadding:(NSArray *)arrayTxt margin:(CGFloat)margin
{
    for (NSInteger i = 0; i < arrayTxt.count; i ++) {
        UITextField *txtField = [arrayTxt objectAtIndex:i];
        UIView *viewLeft = [[UIView alloc]
                            initWithFrame:CGRectMake(0, 0, margin, txtField.frame.size.height)];
        [txtField setLeftView:viewLeft];
        [txtField setLeftViewMode:UITextFieldViewModeAlways];
    }
}

- (void)shake {
    
    [self _shake:10
       direction:1
    currentTimes:0
       withDelta:5.f
        andSpeed:0.04
  shakeDirection:ShakeDirectionHorizontal
      completion:nil];
}

- (void)shakeWithCount:(int)times withDelta:(CGFloat)detla withSpeed:(NSTimeInterval)speed withDirection:(ShakeDirection)direction complietion:(void(^)())handler {
    
    [self _shake:times
       direction:1
    currentTimes:0
       withDelta:detla
        andSpeed:speed
  shakeDirection:direction
      completion:handler];
    
}


- (void)_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completion:(void(^)())handler
{
    
    [UIView animateWithDuration:interval animations:^{
        self.transform = (shakeDirection == ShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (handler) {
                    handler();
                }
            }];
            return;
        }
        
        [self _shake:(times - 1)
           direction:direction * -1
        currentTimes:current + 1
           withDelta:delta
            andSpeed:interval
      shakeDirection:shakeDirection completion:handler];
        
    }];
}

-(void)addToolbarWithButtonTitled:(NSString *)title
                        forTarget:(id)target
                         selector:(SEL)selector {
    
    //Add flexible space to left
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                          target:nil
                                          action:nil];
    
    // Create the button with the parameters passed in
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:title
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:target
                                                                  action:selector];
    
    // Set up and add the toolbar to the textField
    UIToolbar *toolbar = [[UIToolbar alloc]
                          initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, 40.0)];
    [toolbar sizeToFit];
    [toolbar setItems:@[flexibleSpaceLeft, doneButton]];
    [self setInputAccessoryView:toolbar];
}

- (void)setInputViewDatePickerOfType:(UIDatePickerMode)pickerMode
                           forTarget:(id)target
                            selector:(SEL)seledtor {
    
    NSInteger widht = [UIScreen mainScreen].bounds.size.width;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widht, 210)];
    [view setBackgroundColor:[UIColor colorWithRed:220.f/255.0
                                             green:220.f/255.0
                                              blue:220.f/255.0
                                             alpha:1.0]];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 48, widht, 162)];
    [datePicker setDatePickerMode:pickerMode];
    [view addSubview:datePicker];
    [self setInputView:view];
    
    
    //Button color : change it according to your requirment
    UIColor *colorBtn = [UIColor colorWithRed:18.0/255.0
                                        green:59.0/255.0
                                         blue:99.0/255.0
                                        alpha:1.0];
    
    // Done Button
//    TAButton *btnDone = [TAButton buttonWithType:UIButtonTypeCustom];
//    [btnDone setFrame:CGRectMake(widht-75, 7, 70, 35)];
//    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
//    [btnDone setDatePicker:datePicker];
//    [view addSubview:btnDone];
//    [btnDone addTarget:target action:seledtor forControlEvents:UIControlEventTouchUpInside];
//    [btnDone setBackgroundColor:colorBtn];
//
//    // Cancel button
//    TAButton *btnCancel = [TAButton buttonWithType:UIButtonTypeCustom];
//    [btnCancel setFrame:CGRectMake(5, 7, 70, 35)];
//    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
//    [btnCancel setDatePicker:nil];
//    [view addSubview:btnCancel];
//    [btnCancel addTarget:target action:seledtor forControlEvents:UIControlEventTouchUpInside];
//    [btnCancel setBackgroundColor:colorBtn];
    
}


@end
