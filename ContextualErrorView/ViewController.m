//
//  ViewController.m
//  ContextualErrorView
//
//  Created by Eduardo Sanches Bocato on 25/02/17.
//  Copyright © 2017 bocato. All rights reserved.
//

#import "ViewController.h"
#import "ErrorView.h"

typedef NS_ENUM(NSInteger, ViewContext) {
    FullView = 0,
    LowerView
};

@interface ViewController () <ErrorViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *upperView;
@property (weak, nonatomic) IBOutlet UIView *lowerView;
@property (nonatomic, assign) ViewContext currentContext;
@end

@implementation ViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - ErrorView
- (void)showErrorViewForContext:(ViewContext)viewContext {
    self.currentContext = viewContext;
    switch (viewContext) {
        case FullView: {
            [ErrorView showInView:self.view withDelegate:self];
            break;
        }
        case LowerView: {
            [ErrorView showInView:self.lowerView withDelegate:self];
            break;
        }
    }
}

- (void)hideErrorViewForCurrentContext {
    switch (self.currentContext) {
        case FullView: {
            [ErrorView hideForView:self.view];
            break;
        }
        case LowerView: {
            [ErrorView hideForView:self.lowerView];
            break;
        }
    }
}

#pragma mark - Button Actions
- (IBAction)showErrorViewOnFullViewTouchUpInside:(id)sender {
    [self showErrorViewForContext:FullView];
}

- (IBAction)showErrorViewOnLowerViewTouchUpInside:(id)sender {
    [self showErrorViewForContext:LowerView];
}

#pragma mark - ErrorViewDelegate
- (void)errorViewWillShow {
    NSLog(@"errorViewWillShow");
}

- (void)errorViewDidShow {
    NSLog(@"errorViewWillShow");
}

- (void)errorViewWillHide {
    NSLog(@"errorViewWillShow");
}

- (void)errorViewDidHide {
    NSLog(@"errorViewWillShow");
}

- (void)errorViewDidReceiveTouchUpInside {
    NSLog(@"errorViewWillShow");
    [self hideErrorViewForCurrentContext];
}

@end
