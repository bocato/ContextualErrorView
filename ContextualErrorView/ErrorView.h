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
- (void)showErrorView:(ErrorView *)errorView;
- (void)hideErrorView:(ErrorView *)errorView;
@end

@interface ErrorView : UIControl

#pragma mark - Properties
@property (strong, nonatomic) id<ErrorViewDelegate> delegate;

@end
