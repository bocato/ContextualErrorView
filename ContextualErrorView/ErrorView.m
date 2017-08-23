//
//  ErrorView.m
//  ContextualErrorView
//
//  Created by Eduardo Sanches Bocato on 25/02/17.
//  Copyright © 2017 bocato. All rights reserved.
//

#import "ErrorView.h"
#import "Masonry.h"

#pragma mark - Constants
static NSString *kApplicationDataDownloadTouchToRetryErrorViewMessage = @"Houve um erro ao carregar os dados da aplicação. Toque no botão abaixo para tentar novamente.";

@interface ErrorView ()
#pragma mark - View Elements
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIButton *footerButton;
@end

@implementation ErrorView

#pragma mark - View LifeCycle
- (instancetype)init {
    if (self = [super init]) {
        [self configureViewElements];
        return self;
    }
    return nil;
}

#pragma mark - Instantiation
+ (instancetype)instanciateNewInView:(UIView *)view {
    ErrorView *errorView = [ErrorView new];
    errorView.frame = view.frame;
    [view addSubview:errorView];
    [view bringSubviewToFront:errorView];
    [errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(view);
    }];
    [errorView addTarget:self action:@selector(footerButtonDidReceiveTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    errorView.alpha = 0;
    return errorView;
}

#pragma mark - Behavior
+ (void)showInView:(UIView *)view withDelegate:(id <ErrorViewDelegate> )delegate {
    ErrorView *errorView = [ErrorView instanciateNewInView:view];
    errorView.delegate = delegate;
    [errorView show];
}

+ (NSPredicate *)errorViewPredicate {
    return [NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {
        return [object isKindOfClass:ErrorView.class];
    }];
}

+ (void)hideForView:(UIView *)view {
    ErrorView *currentVisibleErrorView = [view.subviews filteredArrayUsingPredicate:[ErrorView errorViewPredicate]].firstObject;
    if (currentVisibleErrorView) {
        [currentVisibleErrorView hideWithCompletion:nil];
        [currentVisibleErrorView removeFromSuperview];
    }
}

- (void)hideWithCompletion:(void (^)(void))completion {
    if ([self isValidDelegateAndConformsToProtocol] && [self.delegate respondsToSelector:@selector(errorViewWillHide)]) {
        [self.delegate errorViewWillHide];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        self.hidden = YES;
    } completion:^(BOOL finished) {
        if (finished) {
            if ([self isValidDelegateAndConformsToProtocol] && [self.delegate respondsToSelector:@selector(errorViewDidHide)]) {
                [self.delegate errorViewDidHide];
            }
        }
        if (completion) {
            completion();
        }
    }];
}

- (void)show {
    if ([self isValidDelegateAndConformsToProtocol] && [self.delegate respondsToSelector:@selector(errorViewWillShow)]) {
        [self.delegate errorViewWillShow];
    }
    self.hidden = false;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            if ([self isValidDelegateAndConformsToProtocol] && [self.delegate respondsToSelector:@selector(errorViewDidShow)]) {
                [self.delegate errorViewDidShow];
            }
        }
    }];
}

#pragma mark - Helpers
- (BOOL)isValidDelegateAndConformsToProtocol {
    return self.delegate && [self conformsToProtocol:@protocol(ErrorViewDelegate)];
}

#pragma mark - Layout Configuration
- (void)configureImageView {
    // TODO: Change image asset
    self.imageView = [UIImageView new];
    UIImage *image = [UIImage imageNamed:@"tardis_icon"]; // [[UIImage imageNamed:@"tardis_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]; // set render template if we have a vector image
    self.imageView.image = image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.tintColor = [UIColor grayColor];
    [self addSubview:self.imageView];
}

- (void)configureTextLabel {
    self.textLabel = [UILabel new];
    self.textLabel.text = kApplicationDataDownloadTouchToRetryErrorViewMessage;
    self.textLabel.textColor = [UIColor grayColor];
    self.textLabel.numberOfLines = 0;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textLabel];
}

- (void)configureFooterButton {
    self.footerButton = [UIButton new];
    [self.footerButton setTitle:@"TENTAR NOVAMENTE" forState:UIControlStateNormal];
    self.footerButton.backgroundColor = [UIColor lightGrayColor]; // TODO: Set Project Button Default Color
    [self.footerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.footerButton addTarget:self action:@selector(footerButtonDidReceiveTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.footerButton];
}

- (void)makeConstraints {
    int height = 90.0;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-90);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(height * 0.914);
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(20);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
    }];
    
    [self.footerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.bottom.mas_equalTo(-20);
        make.height.mas_equalTo(54);
    }];
}

- (void) configureViewElements {
    self.backgroundColor = [UIColor whiteColor];
    self.hidden = YES;
    [self configureImageView];
    [self configureTextLabel];
    [self configureFooterButton];
    [self makeConstraints];
}

#pragma mark - Button Actions
- (void)footerButtonDidReceiveTouchUpInside {
    [self hideWithCompletion:^{
        if ([self isValidDelegateAndConformsToProtocol] && [self.delegate respondsToSelector:@selector(errorViewDidReceiveTouchUpInside)]) {
            [self.delegate errorViewDidReceiveTouchUpInside];
        }
    }];
}

@end
