//
//  ViewController.m
//  CreativeCodingClass01
//
//  Created by Quincy Bock on 1/28/14.
//  Copyright (c) 2014 Quincy Bock. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize myLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    //this is how you send a console message
    NSLog(@"message out");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [myLabel setText:@"Touch"];
    [myLabel setTextColor: [UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myButton:(id)sender {
    [myLabel setText:@"Quincy"];
    [myLabel setTextColor: [UIColor whiteColor]];
}
@end
