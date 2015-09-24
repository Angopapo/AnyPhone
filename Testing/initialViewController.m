//
//  initialViewController.m
//  
//
//  Created by Raul Danglade on 9/14/15.
//
//

#import "initialViewController.h"
#import <Parse/Parse.h>

@interface initialViewController ()

@end

@implementation initialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser) {
        [self performSegueWithIdentifier:@"goRegister" sender:self];
    }
    
    else{
        [self performSegueWithIdentifier:@"goNext" sender:self];
    }
    
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
