//
//  MineViewController.h
//  Towhere
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface MineViewController : UIViewController<DataLoadStateDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate>

-(IBAction)back:(id)sender;
-(IBAction)logout:(id)sender;      //登出。

@property (nonatomic , weak) IBOutlet UILabel *name1;      //上面的名字。
@property (nonatomic , weak) IBOutlet UILabel *name2;      //下面的名字。
@property (nonatomic , weak) IBOutlet UILabel *phone;      //手机。
@property (nonatomic , weak) IBOutlet UILabel *school;     //学校。

-(IBAction)name:(id)sender;       //修改名字。
-(IBAction)phone:(id)sender;      //修改手机。
-(IBAction)school:(id)sender;     //学校。
-(IBAction)password:(id)sender;   //修改密码。

@property (nonatomic, strong) UIImageView *portraitImageView;   //头像。

@end
