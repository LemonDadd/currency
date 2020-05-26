//
//  BaseViewController.m
//  customer_rebuild
//
//  Created by quanqiuwa on 2019/3/1.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //    // 隐藏自带导航栏
    //    self.navigationController.navigationBarHidden = YES;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //    if (@available(iOS 11.0, *)) {
    //        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    //    } else {
    //        self.automaticallyAdjustsScrollViewInsets = NO;
    //    }
    //    // 添加导航栏
    //    [self.view addSubview:self.navbar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    DLog(@"当前页面: %@", [self class]);
}

-(void)viewDidDisappear:(BOOL)animated {
}

- (void)setNavRightItem:(id)item {
    if ([item isKindOfClass:[NSString class]]) {
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:item style:UIBarButtonItemStylePlain target:self action:@selector(rightEvent)];
        self.navigationItem.rightBarButtonItem = right;
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithHex:kTitleColor]];
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
    }
    if ([item isKindOfClass:[UIImage class]]) {
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:item style:UIBarButtonItemStylePlain target:self action:@selector(rightEvent)];
        self.navigationItem.rightBarButtonItem = right;
    }
    if ([item isKindOfClass:[UIView class]]) {
        UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithCustomView:item];
        self.navigationItem.rightBarButtonItem = right;
    }
}

- (void)setNavLeftItem:(id)item {
    if ([item isKindOfClass:[NSString class]]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:item style:UIBarButtonItemStylePlain target:self action:@selector(leftEvent)];
        self.navigationItem.leftBarButtonItem = left;
    }
    if ([item isKindOfClass:[UIImage class]]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithImage:item style:UIBarButtonItemStylePlain target:self action:@selector(leftEvent)];
        self.navigationItem.leftBarButtonItem = left;
    }
    if ([item isKindOfClass:[UIView class]]) {
        UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithCustomView:item];
        self.navigationItem.leftBarButtonItem = left;
    }
}

- (void)rightEvent {
    
}

- (void)leftEvent {
    
}

- (void)popToSpecifiedViewController:(NSArray *)classList
{
    NSArray * controllers = self.navigationController.childViewControllers;
    [controllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (NSString * classStr in classList) {
            if ([obj isKindOfClass:NSClassFromString(classStr)]) {
                *stop = YES;
                [self.navigationController popToViewController:obj animated:YES];
            }
        }
        if (idx == controllers.count - 1) {
            *stop = YES;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}


@end
