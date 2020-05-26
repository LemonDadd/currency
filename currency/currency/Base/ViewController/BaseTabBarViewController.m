//
//  BaseTabBarViewController.m
//  customer_rebuild
//
//  Created by quanqiuwa on 2019/3/1.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "SelfPickViewController.h"
#import "ListViewController.h"
#import "EssayViewController.h"

@interface BaseTabBarViewController ()<UITabBarControllerDelegate>

@property (nonatomic, weak) UIButton *selectedCover;
@property (nonatomic, strong) BaseNavigationViewController *thirdNavigationController;

@end

@implementation BaseTabBarViewController

- (instancetype)init
{
    self = [super initWithViewControllers:[self viewControllersForTabBar] tabBarItemsAttributes:[self tabBarItemsAttributesForTabBar] imageInsets:UIEdgeInsetsZero titlePositionAdjustment: UIOffsetMake(0, -3.5) context:@""];
    if (self) {
        [self customizeTabBarAppearance];
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    
}

- (NSArray *)viewControllersForTabBar {
   
    SelfPickViewController *firstViewController = [SelfPickViewController new];
    BaseNavigationViewController *firstNavigationController = [[BaseNavigationViewController alloc]
                                                   initWithRootViewController:firstViewController];
    // [firstViewController cyl_setNavigationBarHidden:YES];
    
    ListViewController *secondViewController = [[ListViewController alloc] init];
    BaseNavigationViewController *secondNavigationController = [[BaseNavigationViewController alloc]
                                                    initWithRootViewController:secondViewController];
    
    
    EssayViewController *thirdViewController = [[EssayViewController alloc] init];
    BaseNavigationViewController *thirdNavigationController = [[BaseNavigationViewController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController
                                 ];
    
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForTabBar {
    //CGFloat firstXOffset = -12/2;
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : [UIImage imageNamed:@"tab_home"],  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : [UIImage imageNamed:@"tab_home"]
//                                                 CYLTabBarItemSelectedImage : @"tab_shouye_tab_selected",  /* NSString and UIImage are supported*/
//                                                CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tabbar_home" ofType:@"json"]],
                                                 };
    //CGFloat secondXOffset = (-25+2)/2;
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"分类",
                                                  CYLTabBarItemImage : [UIImage imageNamed:@"tab_home"],
                                                  CYLTabBarItemSelectedImage : [UIImage imageNamed:@"tab_home"]
//                                                  CYLTabBarItemSelectedImage : @"tab_xiaoxi_selected",
//                                                  CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tabbar_mark" ofType:@"json"]],
                                                  };
    
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"购物车",
                                                 CYLTabBarItemImage : [UIImage imageNamed:@"tab_home"],
                                                 CYLTabBarItemSelectedImage : [UIImage imageNamed:@"tab_home"]
//                                                 CYLTabBarItemSelectedImage : @"tab_gouwuchei_selected",
//                                                 CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tabbar_shopCar" ofType:@"json"]],
                                                 };
    
    
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

- (void)customizeTabBarAppearance {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    // tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
    
    [self rootWindow].backgroundColor = [UIColor cyl_systemBackgroundColor];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHex:kPlaceholderColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHex:0x222222];
    
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor colorWithHex:0xffffff]];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    
    
    
//    UIButton *button = CYLExternPlusButton;
//    BOOL isPlusButton = [control cyl_isPlusButton];
//    // 即使 PlusButton 也添加了点击事件，点击 PlusButton 后也会触发该代理方法。
//    if (isPlusButton) {
//        NSMutableArray*imageArr = [NSMutableArray array];
//        for (int i = 0;i<10;i++){
//            NSString *imageName = [NSString stringWithFormat:@"tab_vip_%d",i];
//            UIImage *image = [UIImage imageNamed:imageName];
//            [imageArr addObject:image];
//        }
//        button.imageView.animationImages = imageArr;
//        button.imageView.animationRepeatCount = 1;
//        button.imageView.animationDuration = 1.0;
//        [button.imageView startAnimating];
//    }
   
}


@end
