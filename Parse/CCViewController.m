//
//  CCViewController.m
//  Parse
//
//  Created by Eliot Arntz on 8/13/13.
//  Copyright (c) 2013 Eliot Arntz. All rights reserved.
//

#import "CCViewController.h"
#import <Parse/Parse.h>
#import "CCParseViewController.h"

@interface CCViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"foo"];
    [testObject save];
    
    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
    NSArray *testObjects = [query findObjects];
    NSLog(@"%@", testObjects);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginWithFacebookButtonPressed:(UIButton *)sender
{
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        NSLog(@"*** %@", user);
        [self.activityIndicator stopAnimating]; // Hide loading indicato
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"*** Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [self userSignedIn];
        } else {
            NSLog(@"User with facebook logged in!");
            [self userSignedIn];
        }
    }];
    
    [self.activityIndicator startAnimating]; // Show loading indicator until login is finished
}

-(void)userSignedIn
{
    CCParseViewController *parseVC = [[CCParseViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:parseVC animated:YES completion:nil];
}

@end
