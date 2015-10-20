//
//  NavigationController.m
//  Towhere
//
//  Created by apple on 15/9/20.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "NavigationController.h"
#import "ICSDrawerController.h"
#import "MyselfViewController.h"
#import "ReceiveViewController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ReceiveViewController *ReceiveVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"ReceiveViewController"];
    MyselfViewController *MyselfVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MyselfViewController"];
    
    ICSDrawerController * draw=[[ICSDrawerController alloc]initWithLeftViewController:MyselfVC centerViewController:ReceiveVC];
    
    [self addChildViewController:draw];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
