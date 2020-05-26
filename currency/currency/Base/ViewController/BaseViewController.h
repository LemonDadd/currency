//
//  BaseViewController.h
//  customer_rebuild
//
//  Created by quanqiuwa on 2019/3/1.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BACK_IMAGE [UIImage imageNamed:@"system_btn_back"]

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController


- (void)setNavRightItem:(id)item;
- (void)setNavLeftItem:(id)item;

- (void)rightEvent;
- (void)leftEvent;


/**
 *  返回指定控制器
 */
- (void)popToSpecifiedViewController:(NSArray *)classList;

@end

NS_ASSUME_NONNULL_END
