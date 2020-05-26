//
//  BaseNavigationViewController.m
//  customer_rebuild
//
//  Created by quanqiuwa on 2019/3/1.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation BaseNavigationViewController

+(void)initialize {
    // 导航
    UINavigationBar *navBar = [UINavigationBar appearance];
    NSDictionary *dict = @{NSForegroundColorAttributeName :[UIColor colorWithHex:kTitleColor]};
    [navBar  setBackgroundImage:[UIImage imageNamed:@"navbg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[[UIImage alloc] init]];
    [navBar setTitleTextAttributes:dict];
    
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    UIFont *font = [UIFont systemFontOfSize:15];
    NSDictionary *normalAttr = @{
                                 NSForegroundColorAttributeName: [UIColor colorWithHex:kTitleColor],
                                 NSFontAttributeName: font
                                 };
    [item setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    
    NSDictionary *highlightedAttr = @{
                                 NSForegroundColorAttributeName: [UIColor colorWithHex:kTitleColor],
                                 NSFontAttributeName: font
                                 };
    [item setTitleTextAttributes:highlightedAttr forState:UIControlStateHighlighted];
    
    // 设置不可用状态
    NSDictionary *disableAttr = @{
                                  NSForegroundColorAttributeName: [UIColor whiteColor],
                                  NSFontAttributeName: font
                                  };
    [item setTitleTextAttributes:disableAttr forState:UIControlStateDisabled];
//    // 返回按钮
//    [item setBackButtonBackgroundImage:[[UIImage imageNamed:@"backitem"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 40, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [item setTintColor:[UIColor colorWithHex:kTitleColor]];
//    // 设置文字，水平偏移到看不见的位置
//    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(-500, 0) forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance]setTintColor:[UIColor colorWithHex:kTitleColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    // 自定义返回图片(在返回按钮旁边) 这个效果由navigationBar控制
    [self.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"system_btn_back"]];
    [self.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"system_btn_back"]];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
    viewController.navigationItem.backBarButtonItem = item;
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 点击
- (void)backButtonTapClick {
    
    [self popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
