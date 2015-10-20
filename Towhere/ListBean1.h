//
//  ListBean1.h
//  Towhere
//
//  Created by apple on 15/7/21.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListBean1 : NSObject

@property (nonatomic , retain) NSString *name;          //大学名称。
@property (nonatomic , retain) NSString *uid;           //大学编号。

@property (nonatomic , retain) NSString *detail;        //收快递详情。
@property (nonatomic , retain) NSString *time;          //收快递时间。

//待寄快递
@property (nonatomic , retain) NSString *daname;        //收件人姓名。
@property (nonatomic , retain) NSString *daaddress;     //收件人地址。
@property (nonatomic , retain) NSString *daid;          //收件人id。
@property (nonatomic , retain) NSString *waittime;      //待寄时间。
@property (nonatomic , retain) NSString *paname;        //寄件人姓名。
@property (nonatomic , retain) NSString *paid;          //寄件人id。
@property (nonatomic , retain) NSString *weight;        //重量。
@property (nonatomic , retain) NSString *companyname;   //快递公司。
@property (nonatomic , retain) NSString *companyid;     //快递公司编号。
@property (nonatomic , retain) NSString *price;         //价格。
@property (nonatomic , retain) NSString *paphone;       //寄件人电话。
@property (nonatomic , retain) NSString *waitsendID;    //待寄的id。
@property (nonatomic , retain) NSString *kdnumber;      //快递单号。
@property (nonatomic , retain) NSString *daphone;       //收件人电话。
@property (nonatomic , retain) NSString *status;        //快递状态。

//收件人/寄件人
@property (nonatomic , retain) NSString *addID;         //编号。
@property (nonatomic , retain) NSString *phone;         //电话。
@property (nonatomic , retain) NSString *address;       //地址。
@property (nonatomic , retain) NSString *cityid;        //地区id。
@property (nonatomic , retain) NSString *cityname;      //市区。
@property (nonatomic , retain) NSString *provincename;  //省份。

//查询。
@property (nonatomic , retain) NSString *code;          //快递代码。
@property (nonatomic , retain) NSString *expTextName;   //快递名称。
@end
