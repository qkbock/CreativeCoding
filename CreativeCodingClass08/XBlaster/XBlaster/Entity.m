//
//  Entity.m
//  XBlaster
//
//  Created by Quincy Bock on 3/22/14.
//  Copyright (c) 2014 Quincy Bock. All rights reserved.
//

#import "Entity.h"

@implementation Entity

- (instancetype)initWithPosition:(CGPoint)position
{
    if (self = [super init]) {
        self.texture = [[self class] generateTexture];
        self.size = self.texture.size;
        self.position = position;
        _direction = CGPointZero;
    }
    return self;
}
- (void)update:(CFTimeInterval)delta
{
    // Overridden by subclasses
}
+ (SKTexture *)generateTexture
{
    // Overridden by subclasses
    return nil;
}

@end
