//
//  MyScene.m
//  ZombieConga
//
//  Created by Quincy Bock on 2/10/14.
//  Copyright (c) 2014 Quincy Bock. All rights reserved.
//


// QUESTIONS:  why use the underline... is that a probelm?


#import "MyScene.h"

static inline CGPoint CGPointAdd(const CGPoint a, const CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}
static inline CGPoint CGPointSubtract(const CGPoint a, const CGPoint b)
{
    return CGPointMake(a.x - b.x, a.y - b.y);
}
static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b)
{
    return CGPointMake(a.x * b, a.y * b);
}
static inline CGFloat CGPointLength(const CGPoint a)
{
    return sqrtf(a.x * a.x + a.y * a.y);
}
static inline CGPoint CGPointNormalize(const CGPoint a)
{
    CGFloat length = CGPointLength(a);
    return CGPointMake(a.x / length, a.y / length);
}
static inline CGFloat CGPointToAngle(const CGPoint a)
{
    return atan2f(a.y, a.x);
}

//<*****************************************************************************************>

static const float ZOMBIE_MOVE_POINTS_PER_SEC = 120.0;

@implementation MyScene

{
    SKSpriteNode *_zombie;
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _dt;
    CGPoint _velocity;
    CGPoint _lastTouchLocation;
}

//<*****************************************************************************************>

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor whiteColor];
    }
    
//<----------------------------------------------------------------------------------------->
    
    //create background sprite
    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
    
    //set position
    bg.position = CGPointMake(self.size.width/2, self.size.height/2);
    bg.anchorPoint = CGPointMake(0.5, 0.5); // same as default
    
    //alternative setting the anchor poiont and where it is drawn on the screen
//    bg.anchorPoint = CGPointZero;
//    bg.position = CGPointZero;
    
    //how to rotate
//    bg.zRotation = M_PI / 8;
    
    //add/draw sprite
    [self addChild:bg];
    
    //extra info
    CGSize mySize = bg.size; //size attribute
//    NSLog(@"Size: %@", NSStringFromCGSize(mySize)); // send stuff to console
    
//<----------------------------------------------------------------------------------------->

    //create zombie sprite
    _zombie = [SKSpriteNode spriteNodeWithImageNamed:@"zombie1"];
    //set position
    _zombie.position = CGPointMake(100, 100);
    //add/draw sprite
    [self addChild:_zombie];
//    [_zombie setScale:2.0]; // SKNode method
    
//<----------------------------------------------------------------------------------------->
    
    return self;
}

//<*****************************************************************************************>

- (void)update:(CFTimeInterval)currentTime
{
    if (_lastUpdateTime) {
        _dt = currentTime - _lastUpdateTime;
    }
    else {
        _dt = 0;
    }
    _lastUpdateTime = currentTime;
//    NSLog(@"%0.2f milliseconds since last update", _dt * 1000);
    
    CGPoint _zombieTouchDifference = CGPointSubtract(_lastTouchLocation, _zombie.position);
    float _zombieTouchDistance = CGPointLength(_zombieTouchDifference);
    
    if (_zombieTouchDistance < ZOMBIE_MOVE_POINTS_PER_SEC * _dt) {
        _zombie.position = _lastTouchLocation;
        _velocity = CGPointZero;
    } else {
        [self moveSprite:_zombie velocity:_velocity];
        [self boundsCheckPlayer];
        [self rotateSprite:_zombie toFace:_velocity];
    }
    
    [self moveSprite:_zombie velocity:_velocity];
    [self boundsCheckPlayer];
    [self rotateSprite:_zombie toFace:_velocity];
}

//<*****************************************************************************************>

- (void)moveZombieToward:(CGPoint)location
{
    CGPoint offset = CGPointMake(location.x - _zombie.position.x, location.y - _zombie.position.y);
    CGFloat length = sqrtf(offset.x * offset.x + offset.y * offset.y);
    CGPoint direction = CGPointMake(offset.x / length, offset.y / length);
    _velocity = CGPointMake(direction.x * ZOMBIE_MOVE_POINTS_PER_SEC, direction.y * ZOMBIE_MOVE_POINTS_PER_SEC);
}

//<*****************************************************************************************>

- (void)rotateSprite:(SKSpriteNode *)sprite
              toFace:(CGPoint)direction
{
    sprite.zRotation = atan2f(direction.y, direction.x);
}

//<*****************************************************************************************>

- (void)boundsCheckPlayer
{
    // 1
    CGPoint newPosition = _zombie.position;
    CGPoint newVelocity = _velocity;
    // 2
    CGPoint bottomLeft = CGPointZero;
    CGPoint topRight = CGPointMake(self.size.width, self.size.height);
    // 3
    if (newPosition.x <= bottomLeft.x) {
        newPosition.x = bottomLeft.x;
        newVelocity.x = -newVelocity.x;
    }
    if (newPosition.x >= topRight.x) {
        newPosition.x = topRight.x;
        newVelocity.x = -newVelocity.x;
    }
    if (newPosition.y <= bottomLeft.y) {
        newPosition.y = bottomLeft.y;
        newVelocity.y = -newVelocity.y;
    }
    if (newPosition.y >= topRight.y) {
        newPosition.y = topRight.y;
        newVelocity.y = -newVelocity.y;
    }
    // 4
    _zombie.position = newPosition;
    _velocity = newVelocity;
}

//<*****************************************************************************************>

- (void)moveSprite:(SKSpriteNode *)sprite velocity:(CGPoint)velocity
{
    // 1
    CGPoint amountToMove = CGPointMake(velocity.x * _dt, velocity.y * _dt);
//    NSLog(@"Amount to move: %@", NSStringFromCGPoint(amountToMove));
    // 2
    sprite.position = CGPointMake(sprite.position.x + amountToMove.x, sprite.position.y + amountToMove.y);
}

//<*****************************************************************************************>

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    [self moveZombieToward:touchLocation];
}

//<*****************************************************************************************>

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    [self moveZombieToward:touchLocation];
}

//<*****************************************************************************************>

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    [self moveZombieToward:touchLocation];
}

//<*****************************************************************************************>


@end
