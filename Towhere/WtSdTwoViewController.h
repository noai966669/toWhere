//
//  WtSdTwoViewController.h
//  Towhere
//
//  Created by apple on 15/8/10.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"

@interface WtSdTwoViewController : UIViewController<DataLoadStateDelegate>{
    //打钩。
    IBOutlet UIImageView *zfbImage;      //选择支付宝。
    IBOutlet UIImageView *wxImage;       //选择微信。
    IBOutlet UIImageView *yhkImage;      //选择银行卡。
}

-(IBAction)back:(id)sender;

@property (nonatomic , weak) IBOutlet UILabel *kdnumber;      //快递单号。
@property (nonatomic , weak) IBOutlet UILabel *daname;        //收件人。
@property (nonatomic , weak) IBOutlet UILabel *daphone;       //收件人电话。
@property (nonatomic , weak) IBOutlet UILabel *daaddress;     //收件人地址。
@property (nonatomic , weak) IBOutlet UILabel *paname;        //寄件人。
@property (nonatomic , weak) IBOutlet UILabel *paphone;       //寄件人电话。
@property (nonatomic , weak) IBOutlet UILabel *weight;        //重量。
@property (nonatomic , weak) IBOutlet UILabel *cname;         //天天快递。
@property (nonatomic , weak) IBOutlet UILabel *price;         //价格。

-(IBAction)zfb:(id)sender;     //支付宝。
-(IBAction)wx:(id)sender;      //微信。
-(IBAction)yhk:(id)sender;     //银行卡。
-(IBAction)pay:(id)sender;     //支付。

@property (nonatomic , retain) UIImageView *zfbImage;
@property (nonatomic , retain) UIImageView *wxImage;
@property (nonatomic , retain) UIImageView *yhkImage;

@end
