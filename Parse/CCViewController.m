//
//  CCViewController.m
//  Parse
//
//  Created by Eliot Arntz on 8/13/13.
//  Copyright (c) 2013 Eliot Arntz. All rights reserved.
//

#import "CCViewController.h"
#import <Parse/Parse.h>

@interface CCViewController ()

@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"foo"];
    [testObject saveInBackground];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
