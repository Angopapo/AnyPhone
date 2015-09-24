//
//  registerViewController.m
//  Testing
//
//  Created by Raul Danglade on 9/14/15.
//  Copyright (c) 2015 Raul Danglade. All rights reserved.
//

#import "registerViewController.h"
#import <Parse/Parse.h>

@interface registerViewController ()

@end

@implementation registerViewController
{
    NSString *phoneNumber;
    NSInteger myInt;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.submitButton.layer.cornerRadius = 3;
    [self.phoneNumber becomeFirstResponder];
    self.submitButton.tag = 1;
}

- (IBAction)submit:(UIButton *)sender  {
    if (sender.tag == 1) {
        // perform your 1st functionality
        [self sendCode];
        self.submitButton.tag = 2;   //To perform 2nd functionality
        
    }
    else if (sender.tag == 2) {
        // perform your Second functionality
        [self logIn];
        
    }
}

- (void) sendCode
{
    NSLog(@"Button pressed...");
    [self.view endEditing:YES];

    phoneNumber = self.phoneNumber.text;
    myInt = [phoneNumber integerValue];

    [PFCloud callFunctionInBackground:@"sendCode" withParameters:@{@"phoneNumber": @(myInt)}
                                block:^(NSNumber *results, NSError *error) {
                                    
                                    if (!error) {
                                        [self step2];
                                        
                                    }
                                    else {
                                        NSLog(@"%@", error);
                                        [self showAlert:error.localizedDescription];
                                        self.submitButton.tag = 1;

                                    }
                                }];
}

- (void) step2
{
    NSString *label2 = [NSString stringWithFormat:@"It was sent in an SMS message to +1%@", self.phoneNumber.text];
    self.label2.text = label2;
    self.phoneNumber.text = @"";
    self.label1.text = @"Enter the 4-digit confirmation code:";
    self.phoneNumber.placeholder = @"1234";
    
}

- (void) logIn
{
    
    NSString *pinNumber = self.phoneNumber.text;
    NSInteger pinInt = [pinNumber integerValue];
    
    NSLog(@"Phone number is %@ and pin is %@", @(myInt), @(pinInt));

    [PFCloud callFunctionInBackground:@"logIn" withParameters:@{@"phoneNumber": @(myInt), @"codeEntry": @(pinInt)}
                                block:^(NSString *user, NSError *error) {
                                    if (!error) {
                                        NSLog(@"%@", user);
                                        [PFUser becomeInBackground:user block:^(PFUser * _Nullable user, NSError * _Nullable error) {
                                            if (!error) {
                                                NSLog(@"Completo!!");
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                            }
                                            else {
                                                NSLog(@"%@", error);
                                                [self showAlert:error.localizedDescription];
                                            }
                                        }];
                                    }
                                    else {
                                        NSLog(@"%@", error);
                                        [self showAlert:error.localizedDescription];
                                    }
                                }];
}

- (void) showAlert
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Warning"
                                          message:@"You must enter a 10-digit US phone number including area code."
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) showAlert:(NSString*)withText
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Warning"
                                          message:withText
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                               }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
