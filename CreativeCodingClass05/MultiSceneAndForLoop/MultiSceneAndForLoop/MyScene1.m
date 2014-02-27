//
//  MyScene1.m
//  MultiSceneAndForLoop
//
//  Created by Quincy Bock on 2/25/14.
//  Copyright (c) 2014 Quincy Bock. All rights reserved.
//

#import "MyScene1.h"

@implementation MyScene1

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor purpleColor];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"TimesNewRoman"];
        
        myLabel.text = @"Scene 1";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.size.height-40);
        
        [self addChild:myLabel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
