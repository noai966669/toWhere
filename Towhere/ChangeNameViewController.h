//
//  ChangeNameViewController.h
//  Towhere
//
//  Created by apple on 15/8/14.
//  Copyright (c) 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"

@interface ChangeNameViewController : UIViewController<DataLoadStateDelegate>{
    IBOutlet UITextField *name;    //姓名。
}

-(IBAction)back:(id)sender;
-(IBAction)finish:(id)sender;    //完成。

@end
