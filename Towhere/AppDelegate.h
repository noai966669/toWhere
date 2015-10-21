//
//  AppDelegate.h
//  Towhere
//
//  Created by apple on 15/7/15.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic , retain) NSString *token;       //区分不同用户的标准。
@property (nonatomic , retain) NSString *waitsendID;  //待寄快递信息ID。
@property (nonatomic , retain) NSString *addname;     //收件人姓名。
@property (nonatomic , retain) NSString *addcityid;   //收件人城市id。
@property (nonatomic , retain) NSString *postname;    //寄件人姓名。
@property (nonatomic , retain) NSString *postcityid;  //寄件人城市id。
@property (nonatomic , retain) NSString *sendid;      //我要寄快递---sendid=1添加收件人---sendid=2添加寄件人。
@property (nonatomic , retain) NSString *companyid;   //快递公司id。
@property (nonatomic , retain) NSString *companyname; //快递公司名称。
@property (nonatomic , retain) NSString *weight;      //重量。
@property (nonatomic , retain) NSNumber *price;       //价格。
@property (nonatomic , retain) NSString *addid;       //收件人id。
@property (nonatomic , retain) NSString *postid;      //寄件人id。
@property (nonatomic , retain) NSString *username;    //用户名字。
@property (nonatomic , retain) NSString *userphone;   //用户手机。
@property (nonatomic , retain) NSString *userID;      //用户id。
@property (nonatomic , retain) NSString *useruname;   //用户大学名称。
@property (nonatomic , retain) NSString *useruid;     //用户大学id。
@property (nonatomic , retain) NSString *login;       //修改学校的时候判断是否登录。 1-登录，2-未登录。
@property (nonatomic , retain) NSString *personnel;   //收寄人管理。   1-收件人。   2-寄件人。
@property (nonatomic , retain) NSString *sfid;        //省份id。
@property (nonatomic , retain) NSString *sfname;      //省份名字。
@property (nonatomic , retain) NSString *code;        //快递代码。
@property (nonatomic , retain) NSString *comname;     //快递名字。
@property (nonatomic , retain) NSString *back;        //查询跳转。
@property (nonatomic , retain) NSString *addpsid;     //添加收寄件人跳转id，1-我要寄快递，2-个人中心。
@property (nonatomic , retain) NSString *kddh;        //快递单号。
@property (nonatomic , retain) NSString *kdback;      //快递返回。
@property (nonatomic , retain) NSString *edit;        //区分收寄件人管理的编辑和新增。 1-编辑，2-新增。
@property (nonatomic , retain) NSString *sqname;      //城市名称。
@property (nonatomic , retain) NSString *sqid;        //城市id。
@property (nonatomic , retain) NSString *editname;    //编辑人的名字。
@property (nonatomic , retain) NSString *editid;      //编辑人id。
@property (nonatomic , retain) NSString *editphone;   //编辑人电话。
@property (nonatomic , retain) NSString *editaddress; //编辑人地址。
@property (nonatomic , retain) NSString *logout;      //登出跳转id，1-登出重新登录，否则从头登录。
//查询。
@property (nonatomic , retain) NSString *mailNo;      //快递单号。
@property (nonatomic , retain) NSString *expTextName; //快递名称。
@property (nonatomic , retain) NSString *expSpellName;//快递拼音。

@property (nonatomic , retain) NSString *status;      //待寄三状态，0-待接单，1-已接单，未揽收，2-待付款。
@property (nonatomic , retain) NSString *edit2;       //待寄编辑。

@property (nonatomic , retain) NSString *cellhight;   //收快递-查询界面cell高度，1-收快递，2-查询。
@property (nonatomic , retain) NSString *password;    //修改密码，判断原密码。

@end

