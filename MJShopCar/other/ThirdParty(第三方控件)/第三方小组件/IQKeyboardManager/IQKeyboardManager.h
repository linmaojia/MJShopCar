//
// IQKeyboardManager.h
// https://github.com/hackiftekhar/IQKeyboardManager
// Copyright (c) 2013-16 Iftekhar Qurashi.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "IQKeyboardManagerConstants.h"

#import <CoreGraphics/CGBase.h>

#import <Foundation/NSObject.h>
#import <Foundation/NSObjCRuntime.h>

#import <UIKit/UITextInputTraits.h>
#import <UIKit/UIView.h>

@class UIFont;

///---------------------
/// @name IQToolbar tags
///---------------------

/**
 Default tag for toolbar with Done button   -1002.
 */
extern NSInteger const kIQDoneButtonToolbarTag;

/**
 Default tag for toolbar with Previous/Next buttons -1005.
 */
extern NSInteger const kIQPreviousNextButtonToolbarTag;



/**
 Codeless drop-in universal library allows to prevent issues of keyboard sliding up and cover UITextField/UITextView. Neither need to write any code nor any setup required and much more. A generic version of KeyboardManagement. https://developer.apple.com/Library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html
 */
@interface IQKeyboardManager : NSObject

///--------------------------
/// @name UIKeyboard handling
///--------------------------

/**
 Returns the default singleton instance.
 */
+ (nonnull instancetype)sharedManager;

/**
 Enable/disable managing distance between keyboard and textField. Default is YES(Enabled when class loads in `+(void)load` method).
 */
@property(nonatomic, assign, getter = isEnabled) BOOL enable;

/**
 To set keyboard distance from textField. can't be less than zero. Default is 10.0.
 */
@property(nonatomic, assign) CGFloat keyboardDistanceFromTextField;

/**
 Prevent keyboard manager to slide up the rootView to more than keyboard height. Default is YES.
 */
@property(nonatomic, assign) BOOL preventShowingBottomBlankSpace;

/**
 Refreshes textField/textView position if any external changes is explicitly made by user.
 */
- (void)reloadLayoutIfNeeded;

///-------------------------
/// @name IQToolbar handling
///-------------------------

/**
 Automatic add IQToolbar functionality. Default is YES.
 */
@property(nonatomic, assign, getter = isEnableAutoToolbar) BOOL enableAutoToolbar;

/**
 AutoToolbar managing behaviour. Default is IQAutoToolbarBySubviews.
 */
@property(nonatomic, assign) IQAutoToolbarManageBehaviour toolbarManageBehaviour;

/**
 If YES, then uses textField's tintColor property for IQToolbar, otherwise tint color is black. Default is NO.
 */
@property(nonatomic, assign) BOOL shouldToolbarUsesTextFieldTintColor;

/**
 This is used for toolbar.tintColor when textfield.keyboardAppearance is UIKeyboardAppearanceDefault. If shouldToolbarUsesTextFieldTintColor is YES then this property is ignored. Default is nil and uses black color.
 */
@property(nullable, nonatomic, strong) UIColor *toolbarTintColor;

/**
 Toolbar done button icon, If nothing is provided then check toolbarDoneBarButtonItemText to draw done button.
 */
@property(nullable, nonatomic, strong) UIImage *toolbarDoneBarButtonItemImage;

/**
 Toolbar done button text, If nothing is provided then system default 'UIBarButtonSystemItemDone' will be used.
 */
@property(nullable, nonatomic, strong) NSString *toolbarDoneBarButtonItemText;

/**
 If YES, then it add the textField's placeholder text on IQToolbar. Default is YES.
 */
@property(nonatomic, assign) BOOL shouldShowTextFieldPlaceholder;

/**
 Placeholder Font. Default is nil.
 */
@property(nullable, nonatomic, strong) UIFont *placeholderFont;

/**
 Reload all toolbar buttons on the fly.
 */
- (void)reloadInputViews;

///--------------------------
/// @name UITextView handling
///--------------------------

/**
 Adjust textView's frame when it is too big in height. Default is NO.
 */
@property(nonatomic, assign) BOOL canAdjustTextView;

///---------------------------------------
/// @name UIKeyboard appearance overriding
///---------------------------------------

/**
 Override the keyboardAppearance for all textField/textView. Default is NO.
 */
@property(nonatomic, assign) BOOL overrideKeyboardAppearance;

/**
 If overrideKeyboardAppearance is YES, then all the textField keyboardAppearance is set using this property.
 */
@property(nonatomic, assign) UIKeyboardAppearance keyboardAppearance;

///---------------------------------------------
/// @name UITextField/UITextView Next/Previous/Resign handling
///---------------------------------------------

/**
 Resigns Keyboard on touching outside of UITextField/View. Default is NO.
 */
@property(nonatomic, assign) BOOL shouldResignOnTouchOutside;

/**
 Resigns currently first responder field.
 */
- (BOOL)resignFirstResponder;

/**
 Returns YES if can navigate to previous responder textField/textView, otherwise NO.
 */
@property (nonatomic, readonly) BOOL canGoPrevious;

/**
 Returns YES if can navigate to next responder textField/textView, otherwise NO.
 */
@property (nonatomic, readonly) BOOL canGoNext;

/**
 Navigate to previous responder textField/textView.
 */
- (BOOL)goPrevious;

/**
 Navigate to next responder textField/textView.
 */
- (BOOL)goNext;

///------------------------------------------------
/// @name UISound handling
///------------------------------------------------

/**
 If YES, then it plays inputClick sound on next/previous/done click.
 */
@property(nonatomic, assign) BOOL shouldPlayInputClicks;

///---------------------------
/// @name UIAnimation handling
///---------------------------

/**
 If YES, then uses keyboard default animation curve style to move view, otherwise uses UIViewAnimationOptionCurveEaseInOut animation style. Default is YES.
 
 @warning Sometimes strange animations may be produced if uses default curve style animation in iOS 7 and changing the textFields very frequently.
 */
@property(nonatomic, assign) BOOL shouldAdoptDefaultKeyboardAnimation;

/**
 If YES, then calls 'setNeedsLayout' and 'layoutIfNeeded' on any frame update of to viewController's view.
 */
@property(nonatomic, assign) BOOL layoutIfNeededOnUpdate;

///------------------------------------
/// @name Class Level enabling/disabling methods
///------------------------------------

/**
 Disable distance handling within the scope of disabled distance handling viewControllers classes. Within this scope, 'enabled' property is ignored. Class should be kind of UIViewController.
 */
@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *disabledDistanceHandlingClasses;

/**
 Enable distance handling within the scope of enabled distance handling viewControllers classes. Within this scope, 'enabled' property is ignored. Class should be kind of UIViewController. If same Class is added in disabledDistanceHandlingClasses list, then enabledDistanceHandlingClasses will we ignored.
 */
@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *enabledDistanceHandlingClasses;

/**
 Disable automatic toolbar creation within the scope of disabled toolbar viewControllers classes. Within this scope, 'enableAutoToolbar' property is ignored. Class should be kind of UIViewController.
 */
@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *disabledToolbarClasses;

/**
 Enable automatic toolbar creation within the scope of enabled toolbar viewControllers classes. Within this scope, 'enableAutoToolbar' property is ignored. Class should be kind of UIViewController. If same Class is added in disabledToolbarClasses list, then enabledToolbarClasses will be ignored.
 */
@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *enabledToolbarClasses;

/**
 Allowed subclasses of UIView to add all inner textField, this will allow to navigate between textField contains in different superview. Class should be kind of UIView.
 */
@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *toolbarPreviousNextAllowedClasses;

/**
 Disabled classes to ignore 'shouldResignOnTouchOutside' property, Class should be kind of UIViewController.
 */
@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *disabledTouchResignedClasses;

/**
 Enabled classes to forcefully enable 'shouldResignOnTouchOutsite' property. Class should be kind of UIViewController. If same Class is added in disabledTouchResignedClasses list, then enabledTouchResignedClasses will be ignored.
 */
@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *enabledTouchResignedClasses;


///-------------------------------------------
/// @name Third Party Library support
/// Add TextField/TextView Notifications customised NSNotifications. For example while using YYTextView https://github.com/ibireme/YYText
///-------------------------------------------

/**
 Add customised Notification for third party customised TextField/TextView. Please be aware that the NSNotification object must be idential to UITextField/UITextView NSNotification objects and customised TextField/TextView support must be idential to UITextField/UITextView.
 @param didBeginEditingNotificationName This should be identical to UITextViewTextDidBeginEditingNotification
 @param didEndEditingNotificationName This should be identical to UITextViewTextDidEndEditingNotification
 */
-(void)addTextFieldViewDidBeginEditingNotificationName:(nonnull NSString *)didBeginEditingNotificationName
                         didEndEditingNotificationName:(nonnull NSString *)didEndEditingNotificationName;

///----------------------------------------
/// @name Must not be used for subclassing.
///----------------------------------------

/**
 Unavailable. Please use sharedManager method
 */
-(nonnull instancetype)init NS_UNAVAILABLE;

/**
 Unavailable. Please use sharedManager method
 */
+ (nonnull instancetype)new NS_UNAVAILABLE;

@end

@interface IQKeyboardManager(IQKeyboardManagerDeprecated)

/**
 Disable adjusting view in disabledClass
 
 @param disabledClass Class in which library should not adjust view to show textField.
 */
-(void)disableDistanceHandlingInViewControllerClass:(nonnull Class)disabledClass __attribute__((deprecated("Use disabledDistanceHandlingClasses NSMutableSet, this will be removed in future releases.")));


/**
 Re-enable adjusting textField in disabledClass
 
 @param disabledClass Class in which library should re-enable adjust view to show textField.
 */
-(void)removeDisableDistanceHandlingInViewControllerClass:(nonnull Class)disabledClass __attribute__((deprecated("Use disabledDistanceHandlingClasses NSMutableSet, this will be removed in future releases.")));

/**
 Disable automatic toolbar creation in in toolbarDisabledClass
 
 @param toolbarDisabledClass Class in which library should not add toolbar over textField.
 */
-(void)disableToolbarInViewControllerClass:(nonnull Class)toolbarDisabledClass __attribute__((deprecated("Use disabledToolbarClasses NSMutableSet, this will be removed in future releases.")));

/**
 Re-enable automatic toolbar creation in in toolbarDisabledClass
 
 @param toolbarDisabledClass Class in which library should re-enable automatic toolbar creation over textField.
 */
-(void)removeDisableToolbarInViewControllerClass:(nonnull Class)toolbarDisabledClass __attribute__((deprecated("Use disabledToolbarClasses NSMutableSet, this will be removed in future releases.")));

/**
 Consider provided customView class as superView of all inner textField for calculating next/previous button logic.
 
 @param toolbarPreviousNextConsideredClass Custom UIView subclass Class in which library should consider all inner textField as siblings and add next/previous accordingly.
 */
-(void)considerToolbarPreviousNextInViewClass:(nonnull Class)toolbarPreviousNextConsideredClass __attribute__((deprecated("Use toolbarPreviousNextAllowedClasses NSMutableSet, this will be removed in future releases.")));

/**
 Remove Consideration for provided customView class as superView of all inner textField for calculating next/previous button logic.
 
 @param toolbarPreviousNextConsideredClass Custom UIView subclass Class in which library should remove consideration for all inner textField as superView.
 */
-(void)removeConsiderToolbarPreviousNextInViewClass:(nonnull Class)toolbarPreviousNextConsideredClass __attribute__((deprecated("Use toolbarPreviousNextAllowedClasses NSMutableSet, this will be removed in future releases.")));

@end

