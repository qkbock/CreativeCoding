//
//  MyScene.m
//  PhysicsBodyCreature
//
//  Created by Quincy Bock on 2/18/14.
//  Copyright (c) 2014 Quincy Bock. All rights reserved.
//

//<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

#import "MyScene.h"

@interface MyScene()
@property SKSpriteNode* myShelf1;
@property SKSpriteNode* myShelf2;
@property SKSpriteNode* myShelf3;
@property SKSpriteNode* mySquare1;
@property SKSpriteNode* mySquare2;
@property SKSpriteNode* mySquare3;
@property SKSpriteNode* mySquare4;
@property SKSpriteNode* mySquare5;
@property SKSpriteNode* mySquare6;
@property SKSpriteNode* mySquare7;
@property SKPhysicsJoint* myJoint1;
@property SKPhysicsJoint* myJoint2;
@property SKPhysicsJoint* myJoint3;
@property SKPhysicsJoint* myJoint4;
@property SKPhysicsJoint* myJoint5;
@property SKPhysicsJoint* myJoint6;
@end


//***********************************************************************************************

@implementation MyScene

-(void)spawnBackgroundWorld{
    self.scaleMode = SKSceneScaleModeAspectFit;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect: self.frame];
    [self.physicsBody setRestitution:1.0]; //bounciness
}

//----------------------------------------------------------------------------------------------

-(void)spawnSquares{
    NSLog(@"Entered SpawnSquares");
    _mySquare1 = [[SKSpriteNode alloc]
                  initWithColor: [SKColor colorWithRed:0.556 green:0.612 blue:0.85 alpha:1.0]
                  size:CGSizeMake(80, 80)];
    [_mySquare1 setPosition: CGPointMake(600, 150)];
    _mySquare1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare1.size];
    [self addChild:_mySquare1];
    
    _mySquare2 = [[SKSpriteNode alloc]
                  initWithColor: [SKColor colorWithRed:0.494 green:0.624 blue:0.835 alpha:1.0]
                  size:CGSizeMake(70, 70)];
    [_mySquare2 setPosition: CGPointMake(525, 150)];
    _mySquare2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare2.size];
    [self addChild:_mySquare2];
    
    _mySquare3 = [[SKSpriteNode alloc]
                  initWithColor: [SKColor colorWithRed:0.463 green:0.65 blue:0.831 alpha:1.0]
                  size:CGSizeMake(60, 60)];
    [_mySquare3 setPosition: CGPointMake(460, 150)];
    _mySquare3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare3.size];
    [self addChild:_mySquare3];
    
    _mySquare4 = [[SKSpriteNode alloc]
                  initWithColor: [SKColor colorWithRed:0.443 green:0.702 blue:0.827 alpha:1.0]
                  size:CGSizeMake(50, 50)];
    [_mySquare4 setPosition: CGPointMake(405, 150)];
    _mySquare4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare4.size];
    [self addChild:_mySquare4];
    
    _mySquare5 = [[SKSpriteNode alloc]
                  initWithColor: [SKColor colorWithRed:0.431 green:0.722 blue:0.82 alpha:1.0]
                  size:CGSizeMake(40, 40)];
    [_mySquare5 setPosition: CGPointMake(360, 150)];
    _mySquare5.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare5.size];
    [self addChild:_mySquare5];
    
    _mySquare6 = [[SKSpriteNode alloc]
                  initWithColor: [SKColor colorWithRed:0.42 green:0.757 blue:0.824 alpha:1.0]
                  size:CGSizeMake(30, 30)];
    [_mySquare6 setPosition: CGPointMake(325, 150)];
    _mySquare6.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare6.size];
    [self addChild:_mySquare6];
    
    _mySquare7 = [[SKSpriteNode alloc]
                  initWithColor: [SKColor colorWithRed:0.416 green:0.82 blue:0.816 alpha:1.0]
                  size:CGSizeMake(20, 20)];
    [_mySquare7 setPosition: CGPointMake(300, 150)];
    _mySquare7.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare7.size];
    [self addChild:_mySquare7];
    
}

//----------------------------------------------------------------------------------------------

-(void)spawnJoints{
    _myJoint1 = [SKPhysicsJointLimit jointWithBodyA:_mySquare1.physicsBody bodyB:_mySquare2.physicsBody anchorA:_mySquare1.position anchorB:_mySquare2.position];
    _myJoint2 = [SKPhysicsJointLimit jointWithBodyA:_mySquare2.physicsBody bodyB:_mySquare3.physicsBody anchorA:_mySquare2.position anchorB:_mySquare3.position];
    _myJoint3 = [SKPhysicsJointLimit jointWithBodyA:_mySquare3.physicsBody bodyB:_mySquare4.physicsBody anchorA:_mySquare3.position anchorB:_mySquare4.position];
    _myJoint4 = [SKPhysicsJointLimit jointWithBodyA:_mySquare4.physicsBody bodyB:_mySquare5.physicsBody anchorA:_mySquare4.position anchorB:_mySquare5.position];
    _myJoint5 = [SKPhysicsJointLimit jointWithBodyA:_mySquare5.physicsBody bodyB:_mySquare6.physicsBody anchorA:_mySquare5.position anchorB:_mySquare6.position];
    _myJoint6 = [SKPhysicsJointSpring jointWithBodyA:_mySquare6.physicsBody bodyB:_mySquare7.physicsBody anchorA:_mySquare6.position anchorB:_mySquare7.position];
 
    [self.physicsWorld addJoint:_myJoint1];
    [self.physicsWorld addJoint:_myJoint2];
    [self.physicsWorld addJoint:_myJoint3];
    [self.physicsWorld addJoint:_myJoint4];
    [self.physicsWorld addJoint:_myJoint5];
    [self.physicsWorld addJoint:_myJoint6];
}

//----------------------------------------------------------------------------------------------

-(void)spawnShelves{
    _myShelf1 = [[SKSpriteNode alloc]
                  initWithColor: [SKColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0]
                  size:CGSizeMake(self.size.width/2, 20)];
    [_myShelf1 setPosition: CGPointMake(self.size.width/2, self.size.height/3)];
    _myShelf1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myShelf1.size];
    [_myShelf1.physicsBody setDynamic:NO];
    [self addChild:_myShelf1];
    
    _myShelf2 = [[SKSpriteNode alloc]
                  initWithColor: [SKColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0]
                  size:CGSizeMake(self.size.width/4, 20)];
    [_myShelf2 setPosition: CGPointMake(self.size.width/4, 2*self.size.height/3)];
    _myShelf2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myShelf2.size];
    [_myShelf2.physicsBody setDynamic:NO];
    [self addChild:_myShelf2];
    
    _myShelf3 = [[SKSpriteNode alloc]
                 initWithColor: [SKColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0]
                 size:CGSizeMake(self.size.width/4, 20)];
    [_myShelf3 setPosition: CGPointMake(3*self.size.width/4, 2*self.size.height/3)];
    _myShelf3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_myShelf3.size];
    [_myShelf3.physicsBody setDynamic:NO];
    [self addChild:_myShelf3];
}

//----------------------------------------------------------------------------------------------

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self spawnBackgroundWorld];
        [self spawnShelves];
        [self spawnSquares];
        [self spawnJoints];
    }
    return self;
}

//----------------------------------------------------------------------------------------------

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        [_mySquare1 setPosition:location];
        [_mySquare1.physicsBody setDynamic:NO]; //stop gravity
    }
}

//----------------------------------------------------------------------------------------------

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        [_mySquare1 setPosition:location];
        [_mySquare1.physicsBody setDynamic:NO]; //stop gravity
    }
}

//----------------------------------------------------------------------------------------------

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        [_mySquare1.physicsBody setDynamic:YES]; //start gravity
    }
}

//----------------------------------------------------------------------------------------------

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
