//
//  Entity.h
//  XBlaster
//
//  Created by Quincy Bock on 3/22/14.
//  Copyright (c) 2014 Quincy Bock. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Entity : SKSpriteNode

@property (assign,nonatomic) CGPoint direction;
@property (assign,nonatomic) float health;
@property (assign,nonatomic) float maxHealth;

+ (SKTexture *)generateTexture;
- (instancetype)initWithPosition:(CGPoint)position;
- (void)update:(CFTimeInterval)delta;

@end
