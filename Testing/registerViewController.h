//
//  registerViewController.h
//  Testing
//
//  Created by Raul Danglade on 9/14/15.
//  Copyright (c) 2015 Raul Danglade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface registerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
- (IBAction)submit:(id)sender;

@end
