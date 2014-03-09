//
//  MyScene.m
//  VoiceSynAndContactDetection
//
//  Created by Quincy Bock on 3/4/14.
//  Copyright (c) 2014 Quincy Bock. All rights reserved.
//

#import "MyScene.h"
@import AVFoundation; //this is how you import a framework

//Category BitMasks
static const uint32_t RED_CATEGORY = 0x1 << 0;
static const uint32_t BLUE_CATEGORY = 0x1 << 1;
static const uint32_t GREEN_CATEGORY = 0x1 << 2;
static const uint32_t SCREENEDGE_CATEGORY = 0x1 << 3;

//-------------------------------------------------------------------------------------------

@interface MyScene()<SKPhysicsContactDelegate>

@property SKSpriteNode* redSquare;
@property SKSpriteNode* blueSquare;
@property SKSpriteNode* greenSquare;

@end

//-------------------------------------------------------------------------------------------

@implementation MyScene

//-------------------------------------------------------------------------------------------

-(void) speakThis:(NSString*) myLocalString{
    AVSpeechSynthesizer* mySyn = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance* myUtterance = [[AVSpeechUtterance alloc]initWithString: myLocalString];
//    [myUtterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"es-MX"]];  //change language
    [mySyn speakUtterance:myUtterance];
}

//-------------------------------------------------------------------------------------------

-(void) screenSettings{
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
}

//-------------------------------------------------------------------------------------------

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        [self speakThis: @"Started up"];
        self.physicsWorld.contactDelegate = self;
        [self screenSettings];
        [self spawnRedSquare];
        [self spawnBlueSquare];
        [self spawnGreenSquare];
    }
    return self;
}

//-------------------------------------------------------------------------------------------

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self speakThis: @"Touch!"];
//    for ((CGPoint)touch in touches){
//        CGPoint location = touch;
//    }
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    [_redSquare setPosition:touchLocation];
}

//-------------------------------------------------------------------------------------------

-(void) didBeginContact:(SKPhysicsContact *)contact{
//    uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
//    if(collision == (RED_CATEGORY | BLUE_CATEGORY)){
//        [self speakThis: @"Blue touches Red!"];
//    }
    
//    if((contact.bodyA.categoryBitMask == RED_CATEGORY) || (contact.bodyB.categoryBitMask == RED_CATEGORY)){
//        NSLog(@"red");
//    }
    
    if((contact.bodyA.categoryBitMask == GREEN_CATEGORY) && (contact.bodyB.categoryBitMask == RED_CATEGORY)){
        NSLog(@"red and green touched");
        [contact.bodyA.node.physicsBody applyImpulse:CGVectorMake(-1, 10)];
    }
    
    if((contact.bodyA.categoryBitMask == RED_CATEGORY) && (contact.bodyB.categoryBitMask == GREEN_CATEGORY)){
        NSLog(@"red and green touched");
        [contact.bodyB.node.physicsBody applyImpulse:CGVectorMake(1, 10)];
    }
    
    if((contact.bodyA.categoryBitMask == GREEN_CATEGORY) && (contact.bodyB.categoryBitMask == BLUE_CATEGORY)){
        NSLog(@"red and green touched");
        [contact.bodyA.node removeFromParent];
    }
    
    if((contact.bodyA.categoryBitMask == BLUE_CATEGORY) && (contact.bodyB.categoryBitMask == GREEN_CATEGORY)){
        NSLog(@"red and green touched");
        [contact.bodyB.node removeFromParent];
    }
    
    
    
}

//-------------------------------------------------------------------------------------------

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

//-------------------------------------------------------------------------------------------

-(void)spawnRedSquare {
    _redSquare = [[SKSpriteNode alloc]init];
    [_redSquare setSize: CGSizeMake(50, 50)];
    [_redSquare setColor: [SKColor redColor]];
    [_redSquare setPosition: CGPointMake(self.size.width/2, self.size.height/2)];
    _redSquare.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_redSquare.size];
    _redSquare.physicsBody.categoryBitMask = RED_CATEGORY;
    _redSquare.physicsBody.contactTestBitMask = GREEN_CATEGORY | BLUE_CATEGORY;
    [self addChild:_redSquare];
//    [self speakThis: @"Red!"];
}

//. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

-(void)spawnBlueSquare {
    _blueSquare = [[SKSpriteNode alloc]init];
    [_blueSquare setSize: CGSizeMake(80, 80)];
    [_blueSquare setColor: [SKColor blueColor]];
    [_blueSquare setPosition: CGPointMake(self.size.width/2, self.size.height/2)];
    _blueSquare.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_blueSquare.size];
    [_blueSquare.physicsBody setCategoryBitMask:BLUE_CATEGORY];
    _blueSquare.physicsBody.categoryBitMask = BLUE_CATEGORY;
    _blueSquare.physicsBody.contactTestBitMask = GREEN_CATEGORY | RED_CATEGORY;
    [self addChild:_blueSquare];
//    [self speakThis: @"Blue!"];
}

//. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

-(void)spawnGreenSquare {
    for(int i = 0; i < 80; i++){
        _greenSquare = [[SKSpriteNode alloc]init];
        [_greenSquare setSize: CGSizeMake(10, 10)];
        [_greenSquare setColor: [SKColor greenColor]];
        [_greenSquare setPosition: CGPointMake(self.size.width/2, self.size.height-20)];
        _greenSquare.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_greenSquare.size];
        [_greenSquare.physicsBody setCategoryBitMask:GREEN_CATEGORY];
        _greenSquare.physicsBody.categoryBitMask = GREEN_CATEGORY;
        _greenSquare.physicsBody.contactTestBitMask =  BLUE_CATEGORY | RED_CATEGORY;
        [self addChild:_greenSquare];
//        [self speakThis: @"Green!"];
    }
}




//-------------------------------------------------------------------------------------------

@end
