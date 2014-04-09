//
//  Bullet.m
//  XBlaster
//
//  Created by Quincy Bock on 3/22/14.
//  Copyright (c) 2014 Quincy Bock. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

- (instancetype)initWithPosition:(CGPoint)position
{
    if (self = [super initWithPosition:position]) {
        self.name = @"bulletSprite";
    }
    return self;
}

+ (SKTexture *)generateTexture
{
    // 1
    static SKTexture *texture = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 2
        SKLabelNode *bullet = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        bullet.name = @"bullet";
        bullet.fontSize = 20.0f;
        bullet.fontColor = [SKColor redColor];
        bullet.text = @"*";
        
        SKView *textureView = [SKView new];
        texture = [textureView textureFromNode:bullet];
        texture.filteringMode = SKTextureFilteringNearest;
    });
    return texture;
}

@end
