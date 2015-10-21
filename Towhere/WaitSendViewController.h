//
//  WaitSendViewController.h
//  Towhere
//
//  Created by apple on 15/7/28.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitSend.h"
#import "HttpClient.h"

@interface WaitSendViewController : UIViewController<DataLoadStateDelegate>{
    
}

-(IBAction)back:(id)sender;

@property (nonatomic , strong) WaitSend *waitSend;

@property (nonatomic , weak) IBOutlet UILabel *daname;       //收件人。
@property (nonatomic , weak) IBOutlet UILabel *daaddress;    //收件人地址。
@property (nonatomic , weak) IBOutlet UILabel *paname;       //寄件人。
@property (nonatomic , weak) IBOutlet UILabel *weight;       //重量。
@property (nonatomic , weak) IBOutlet UILabel *companyname;  //快递公司。
@property (nonatomic , weak) IBOutlet UILabel *price;        //金额。
@property (nonatomic , weak) IBOutlet UILabel *paphone;      //寄件人电话。

-(IBAction)edit:(id)sender;           //编辑。
-(IBAction)deleteid:(id)sender;       //删除。
-(IBAction)sure:(id)sender;           //底部按钮。
@property (nonatomic , strong) IBOutlet UIButton *sure;
@end
