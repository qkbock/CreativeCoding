//
//  MyScene.m
//  Gestures
//
//  Created by Quincy Bock on 2/11/14.
//  Copyright (c) 2014 Quincy Bock. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene{
    SKSpriteNode* _mySquare2;
}

-(void) didMoveToView:(SKView *)view {
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGestureRecognizer)];
    pinchRecognizer.delegate = self;
    
    
    
    
    [self setBackgroundColor:[SKColor whiteColor]];
//    SKSpriteNode* _mySquare = [[SKSpriteNode alloc]initWithColor:[SKColor blueColor] size:CGSizeMake(50, 50)];

    _mySquare2 = [[SKSpriteNode alloc]init];
    
    [_mySquare2 setColor: [SKColor blueColor]];
    [_mySquare2 setSize: CGSizeMake(50, 50)];
    [_mySquare2 setPosition: CGPointMake(self.size.width/2, self.size.height/2)];
    [self addChild:_mySquare2];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
   
    [_mySquare2 setScale: .5];
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        [_mySquare2 setPosition: location];
    }
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    [_mySquare2 setScale: .25];
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        [_mySquare2 setPosition: location];
    }
    
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    /* Called when a touch begins */
    
    [_mySquare2 setScale: 1.5];
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        [_mySquare2 setPosition: location];
    }
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
