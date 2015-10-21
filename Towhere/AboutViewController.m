//
//  AboutViewController.m
//  Towhere
//
//  Created by apple on 15/9/10.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize about = _about;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.about.text = @"“到了”是一家旨在解决校园快递配送的第三方服务公司。我们立足于各大高校，在校内建立快递服务平台，与各主流快递合作，为在校师生提供便捷，安全，优质的快递寄取服务。真正做到让快递更便捷，让校园更安全。";
    self.about.lineBreakMode = NSLineBreakByCharWrapping;    //自动换行。
    self.about.numberOfLines = 0;
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"MyselfViewController"];
    [self.navigationController pushViewController:next animated:NO];
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
