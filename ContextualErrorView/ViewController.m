//
//  ViewController.m
//  ContextualErrorView
//
//  Created by Eduardo Sanches Bocato on 25/02/17.
//  Copyright © 2017 bocato. All rights reserved.
//

#import "ViewController.h"
#import "ErrorView.h"
#import "Masonry.h"

typedef NS_ENUM(NSInteger, ViewContext) {
    FullView = 0,
    LowerView
};

@interface ViewController () <ErrorViewDelegate>
@property (strong) ErrorView *errorView;
@property (weak, nonatomic) IBOutlet UIView *upperView;
@property (weak, nonatomic) IBOutlet UIView *lowerView;
@end

@implementation ViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureErrorView];
}


#pragma mark - ErrorView
- (void)configureErrorView {
    self.errorView = [ErrorView new];
    self.errorView.frame = CGRectMake(0, 0, 320, 400);
    [self.errorView addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.errorView];
    [self.errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.bottom.right.equalTo(self.lowerView);
    }];
    self.errorView.delegate = self;
}

- (void)showErrorViewForContext:(ViewContext)viewContext {
    switch (viewContext) {
        case FullView: {
            [self.errorView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.bottom.right.equalTo(self.view);
            }];
            break;
        }
        case LowerView: {
            [self.errorView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(64);
                make.left.bottom.right.equalTo(self.lowerView);
            }];
            break;
        }
    }
    [self viewWillLayoutSubviews];
    [self.view layoutSubviews];
    [self viewDidLayoutSubviews];
    [self.errorView.delegate showErrorView:self.errorView];
}


- (void)reloadData{
    //TODO: Do something to reload view
    [self.errorView.delegate hideErrorView:self.errorView];
}

#pragma mark - Button Actions
- (IBAction)showErrorViewOnFullViewTouchUpInside:(id)sender {
//    [self showErrorViewForContext:LowerView];
    [self showErrorViewForContext:FullView];
}

- (IBAction)showErrorViewOnLowerViewTouchUpInside:(id)sender {
    [self showErrorViewForContext:LowerView];
}

@end
