//
//  ContentViewController.h
//  Towhere
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"

@interface ContentViewController : UIViewController<DataLoadStateDelegate>

-(IBAction)back:(id)sender;
-(IBAction)finish:(id)sender;   //提交。

@property (weak , nonatomic) IBOutlet UITextView *content;   //意见建议。

@end
