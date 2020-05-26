//
//  EssayViewController.m
//  currency
//
//  Created by 关云秀 on 2020/5/27.
//  Copyright © 2020 guanyunxiu. All rights reserved.
//

#import "EssayViewController.h"

@interface EssayViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tab;

@end

@implementation EssayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tab  =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tab.delegate =self;
    _tab.dataSource = self;
    [self.view addSubview:_tab];
    [_tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [AllNet requestBriefWithPage:0 request:^(NSArray * _Nonnull List, NSString * _Nonnull errorMsg) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}



@end
