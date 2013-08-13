//
//  CCParseViewController.m
//  Parse
//
//  Created by Eliot Arntz on 8/13/13.
//  Copyright (c) 2013 Eliot Arntz. All rights reserved.
//

#import "CCParseViewController.h"
#import <Parse/Parse.h>

@interface CCParseViewController ()

@end

@implementation CCParseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    [query includeKey:@"user"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects){
            NSLog(@"%@", objects);
            
            //    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            //UIImage *image = [UIImage imageWithData:data];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)choosePhotoButtonPressed:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    //By changing the source type we can have the users add a Camera.
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (BOOL)shouldUploadImage:(UIImage *)anImage
{
    NSData *imageData = UIImageJPEGRepresentation(anImage, 0.8f);

    PFObject *photo = [PFObject objectWithClassName:@"Photo"];
    [photo setObject:[PFUser currentUser] forKey:@"user"];
    
    PFFile *photoFile = [PFFile fileWithData:imageData];
    [photo setObject:photoFile forKey:@"image"];

    [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Photo uploaded successfully");
                
            } else {
                
                NSLog(@"error");
            }
        }];
    }];

    return YES;
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];    
    //
    [self shouldUploadImage:originalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
