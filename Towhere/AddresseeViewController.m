//
//  AddresseeViewController.m
//  Towhere
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import "AddresseeViewController.h"
#import "AppDelegate.h"

@interface AddresseeViewController ()

@end

@implementation AddresseeViewController
@synthesize saveAdd;
@synthesize titleLabel = _titleLabel;
@synthesize nameLabel = _nameLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize addressLabel = _addressLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate.sendid isEqualToString:@"1"]) {
        self.titleLabel.text = @"添加收件人";
        appDelegate.addid = saveAdd.addID;
    }
    else if([appDelegate.sendid isEqualToString:@"2"]) {
        self.titleLabel.text = @"添加寄件人";
        appDelegate.postid = saveAdd.addID;
    }
    self.nameLabel.text = saveAdd.name;
    self.phoneLabel.text = saveAdd.phone;
    self.addressLabel.text = saveAdd.address;
    
//    name.text = saveAdd.name;
//    phone.text = saveAdd.phone;
//    address.text = saveAdd.address;
    int a = [saveAdd.cityid intValue];
    if (a != 0) {
        [self.sf setTitle:saveAdd.provincename forState:UIControlStateNormal];
        [self.sq setTitle:saveAdd.cityname forState:UIControlStateNormal];
    }
    else if ([appDelegate.sendid isEqualToString:@"2"]){
        [self.sf setTitle:@"浙江省" forState:UIControlStateNormal];
        [self.sq setTitle:@"宁波市" forState:UIControlStateNormal];
    }
    else{
        [self.sf setTitle:@"选择省份" forState:UIControlStateNormal];
        [self.sq setTitle:@"选择市区" forState:UIControlStateNormal];
    }
//    name.enabled = NO;
//    phone.enabled = NO;
//    address.enabled = NO;
    _sf.enabled = NO;
    _sq.enabled = NO;
}

-(IBAction)back:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SaveAddViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)sf:(id)sender{
    
}

-(IBAction)sq:(id)sender{
    
}

-(IBAction)saveadd:(id)sender{
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"SaveAddViewController"];
    [self.navigationController pushViewController:next animated:NO];
}

-(IBAction)finish:(id)sender{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate.sendid isEqualToString:@"1"]) {
        appDelegate.addname = saveAdd.name;
        appDelegate.addcityid = saveAdd.cityid;
        appDelegate.addid = saveAdd.addID;
    }
    else if([appDelegate.sendid isEqualToString:@"2"]) {
        appDelegate.postname = saveAdd.name;
        appDelegate.postcityid = saveAdd.addID;
        appDelegate.postid = saveAdd.addID;
    }
    UIViewController *next = [[self storyboard]instantiateViewControllerWithIdentifier:@"WantSendViewController"];
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
