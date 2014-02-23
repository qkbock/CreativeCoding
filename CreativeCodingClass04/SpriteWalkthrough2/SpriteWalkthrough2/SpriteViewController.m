//
//  SpriteViewController.m
//  SpriteWalkthrough2
//
//  Created by Quincy Bock on 2/18/14.
//  Copyright (c) 2014 Quincy Bock. All rights reserved.
//


//How to add sprite kit framework to a non-spritekit project?




#import "SpriteViewController.h"
#import "HelloScene.h"

@implementation SpriteViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    SKView *spriteView = (SKView *) self.view;
    spriteView.showsDrawCount = YES;
    spriteView.showsNodeCount = YES;
    spriteView.showsFPS = YES;
}


- (void)viewWillAppear:(BOOL)animated
{
    HelloScene* hello = [[HelloScene alloc] initWithSize:CGSizeMake(768,1024)];
    SKView *spriteView = (SKView *) self.view;
    [spriteView presentScene: hello];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
