//
//  WantSendViewController.h
//  Towhere
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Express.h"
#import "HttpClient.h"

@interface WantSendViewController : UIViewController<DataLoadStateDelegate>

-(IBAction)back:(id)sender;
-(IBAction)addressee:(id)sender;   //添加收件人。
-(IBAction)post:(id)sender;        //添加寄件人。
-(IBAction)express:(id)sender;     //添加快递公司。
-(IBAction)call:(id)sender;        //一键拨号。

@property (nonatomic , weak) IBOutlet UILabel *addname;     //收件人。
@property (nonatomic , weak) IBOutlet UILabel *postname;    //寄件人。
@property (nonatomic , weak) IBOutlet UILabel *weight;      //重量。
@property (nonatomic , weak) IBOutlet UILabel *express;     //快递公司。
@property (nonatomic , weak) IBOutlet UILabel *price;       //价格。

-(IBAction)plus:(id)sender;            //加+。
-(IBAction)subtraction:(id)sender;     //减-。

@property (nonatomic , strong) Express *expres;

-(IBAction)submit:(id)sender;          //提交。

@end
