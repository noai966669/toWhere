//
//  AgreementViewController.h
//  Towhere
//
//  Created by apple on 15/10/21.
//  Copyright © 2015年 elephant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgreementViewController : UIViewController

-(IBAction)back:(id)sender;

@property (weak , nonatomic) IBOutlet UITextView *agreement;   //用户协议。
@end
