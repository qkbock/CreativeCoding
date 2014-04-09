//
//  MyScene.m
//  XBlaster
//
//  Created by Quincy Bock on 3/22/14.
//  Copyright (c) 2014 Quincy Bock. All rights reserved.
//

#import "MyScene.h"
#import "PlayerShip.h"
#import "Bullet.h"

@implementation MyScene {
    SKNode *_playerLayerNode;
    SKNode *_hudLayerNode;
    SKAction *_scoreFlashAction;
    SKLabelNode *_playerHealthLabel;
    NSString *_healthBar;
    PlayerShip *_playerShip;
    CGPoint _deltaPoint;
    float _bulletInterval;
    CFTimeInterval _lastUpdateTime;
    NSTimeInterval _dt;
}

//-------------------------------------------------------------------------

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        [self setupSceneLayers];
        [self setupUI];
        [self setupEntities];
    }
    return self;
}

//-------------------------------------------------------------------------

- (void)setupSceneLayers
{
    _playerLayerNode = [SKNode node];
    [self addChild:_playerLayerNode];
    _hudLayerNode = [SKNode node];
    [self addChild:_hudLayerNode];
}

//-------------------------------------------------------------------------

- (void)setupUI
{
    //draw the background black box to contain the scores
    int barHeight = 45;
    CGSize backgroundSize = CGSizeMake(self.size.width, barHeight);
    SKColor *backgroundColor = [SKColor colorWithRed:0 green:0 blue:0.05 alpha:1.0];
    SKSpriteNode *hudBarBackground = [SKSpriteNode spriteNodeWithColor:backgroundColor size:backgroundSize];
    hudBarBackground.position = CGPointMake(0, self.size.height - barHeight);
    hudBarBackground.anchorPoint = CGPointZero;
    [_hudLayerNode addChild:hudBarBackground];
    
    //draw score
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Thirteen Pixel Fonts"];
    scoreLabel.fontSize = 20.0;
    scoreLabel.text = @"Score: 0";
    scoreLabel.name = @"scoreLabel";
    scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    scoreLabel.position = CGPointMake(self.size.width / 2, self.size.height - scoreLabel.frame.size.height + 3);
    [_hudLayerNode addChild:scoreLabel];
    
    //run action to make the score flash
    _scoreFlashAction = [SKAction sequence: @[[SKAction scaleTo:1.5 duration:0.1], [SKAction scaleTo:1.0 duration:0.1]]];
    [scoreLabel runAction: [SKAction repeatAction:_scoreFlashAction count:10]];
    
    //Draw the health bar
    _healthBar = @"===================================================";
    float testHealth = 75;
    NSString * actualHealth = [_healthBar substringToIndex: (testHealth / 100 * _healthBar.length)];
    
    SKLabelNode *playerHealthBackground = [SKLabelNode labelNodeWithFontNamed:@"Thirteen Pixel Fonts"];
    playerHealthBackground.name = @"playerHealthBackground";
    playerHealthBackground.fontColor = [SKColor darkGrayColor];
    playerHealthBackground.fontSize = 10.0f;
    playerHealthBackground.text = _healthBar;
    
    playerHealthBackground.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    playerHealthBackground.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    playerHealthBackground.position = CGPointMake(0, self.size.height - barHeight + playerHealthBackground.frame.size.height);
    [_hudLayerNode addChild:playerHealthBackground];
    
    _playerHealthLabel = [SKLabelNode labelNodeWithFontNamed:@"Thirteen Pixel Fonts"];
    _playerHealthLabel.name = @"playerHealth";
    _playerHealthLabel.fontColor = [SKColor whiteColor];
    _playerHealthLabel.fontSize = 10.0f;
    _playerHealthLabel.text = actualHealth;
    _playerHealthLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    _playerHealthLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    _playerHealthLabel.position = CGPointMake(0, self.size.height - barHeight + _playerHealthLabel.frame.size.height);
    [_hudLayerNode addChild:_playerHealthLabel];
}

//-------------------------------------------------------------------------

- (void)setupEntities
{
    _playerShip = [[PlayerShip alloc]
     initWithPosition:CGPointMake(self.size.width / 2, 100)];
    [_playerLayerNode addChild:_playerShip];
}

//-------------------------------------------------------------------------

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];

    }
}

//-------------------------------------------------------------------------

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint currentPoint = [[touches anyObject] locationInNode:self];
    CGPoint previousPoint = [[touches anyObject] previousLocationInNode:self];
    _deltaPoint = CGPointSubtract(currentPoint, previousPoint);
}

//-------------------------------------------------------------------------

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _deltaPoint = CGPointZero;
}

//-------------------------------------------------------------------------

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _deltaPoint = CGPointZero;
}

//-------------------------------------------------------------------------

-(void)update:(CFTimeInterval)currentTime {
    CGPoint newPoint = CGPointAdd(_playerShip.position, _deltaPoint);
    newPoint.x = Clamp(newPoint.x, _playerShip.size.width / 2, self.size.width - _playerShip.size.width / 2);
    newPoint.y = Clamp(newPoint.y, _playerShip.size.height / 2, self.size.height - _playerShip.size.height / 2);
    _playerShip.position = newPoint;
    _deltaPoint = CGPointZero;
    
    if (_lastUpdateTime) {
        _dt = currentTime - _lastUpdateTime;
    } else {
        _dt = 0;
    }
    _lastUpdateTime = currentTime;
    _bulletInterval += _dt;
    if (_bulletInterval > 0.15) {
        _bulletInterval = 0;
        
        Bullet *bullet = [[Bullet alloc] initWithPosition:_playerShip.position];
        [self addChild:bullet];
        
        [bullet runAction:[SKAction sequence:@[
          [SKAction moveByX:0 y:self.size.height duration:1.0],
          [SKAction removeFromParent]
        ]]];
    }
}

//-------------------------------------------------------------------------

@end
