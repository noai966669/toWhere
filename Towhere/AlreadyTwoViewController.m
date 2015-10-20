//
//  AlreadyTwoViewController.m
//  Towhere
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "AlreadyTwoViewController.h"

@interface AlreadyTwoViewController ()

@end

@implementation AlreadyTwoViewController
@synthesize alreadySend;
@synthesize kdnumber = _kdnumber;
@synthesize daname = _daname;
@synthesize daaddress = _daaddress;
@synthesize paname = _paname;
@synthesize paphone = _paphone;
@synthesize weight = _weight;
@synthesize companyname = _companyname;
@synthesize price = _price;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.kdnumber.text = alreadySend.kdnumber;
    self.daname.text = alreadySend.daname;
    self.daaddress.text = alreadySend.daaddress;
    self.paname.text = alreadySend.paname;
    self.weight.text = alreadySend.weight;
    self.companyname.text = alreadySend.companyname;
    self.price.text = alreadySend.price;
    self.paphone.text = alreadySend.paphone;
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"AlreadySendViewController"];
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
