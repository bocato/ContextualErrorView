//
//  ErrorView.h
//  ContextualErrorView
//
//  Created by Eduardo Sanches Bocato on 25/02/17.
//  Copyright © 2017 bocato. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ErrorView;

#pragma mark - Delegate
@protocol ErrorViewDelegate <NSObject>
@optional
- (void)errorViewWillShow;
- (void)errorViewDidShow;
- (void)errorViewWillHide;
- (void)errorViewDidHide;
- (void)errorViewDidReceiveTouchUpInside;
@end

@interface ErrorView : UIControl

#pragma mark - Properties
@property (strong, nonatomic) id<ErrorViewDelegate> delegate;

#pragma mark - Instantiation
+ (instancetype)instanciateNewInView:(UIView *)view;

#pragma mark - Behavior
+ (void)showInView:(UIView *)view withDelegate:(id <ErrorViewDelegate> )delegate;
+ (void)hideForView:(UIView *)view;

@end
