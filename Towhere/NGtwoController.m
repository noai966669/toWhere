//
//  NGtwoController.m
//  Towhere
//
//  Created by apple on 15/9/20.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "NGtwoController.h"
#import "ICSDrawerController.h"
#import "MyselfViewController.h"
#import "QueryViewController.h"

@interface NGtwoController ()

@end

@implementation NGtwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    QueryViewController *QueryVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"QueryViewController"];
    MyselfViewController *MyselfVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MyselfViewController"];
    
    ICSDrawerController * draw=[[ICSDrawerController alloc]initWithLeftViewController:MyselfVC centerViewController:QueryVC];
    
    [self addChildViewController:draw];
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
