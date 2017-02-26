//
//  ErrorView.m
//  ContextualErrorView
//
//  Created by Eduardo Sanches Bocato on 25/02/17.
//  Copyright © 2017 bocato. All rights reserved.
//

#import "ErrorView.h"
#import "Masonry.h"

#pragma mark - Delegate Default Implemetation
@implementation NSObject(ErrorViewDelegate)

- (void)checkIfTheClassConformsWithErrorViewDelegate {
    if (![self conformsToProtocol:@protocol(ErrorViewDelegate)]){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must conform to protocol ErrorViewDelegate to access this method."] userInfo:nil];
    }
}

- (void)showErrorView:(ErrorView *)errorView {
    [self checkIfTheClassConformsWithErrorViewDelegate];
    errorView.hidden = false;
}

- (void)hideErrorView:(ErrorView *)errorView {
    [self checkIfTheClassConformsWithErrorViewDelegate];
    errorView.hidden = true;
}

@end

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
    self = [super init];
    if (self) {
        [self configureViewElements];
    }
    return self;
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
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

@end
