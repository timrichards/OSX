//
//  TRMyScene.m
//  Ball Challenge
//
//  Created by Tim on 10/18/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

#import "TRMyScene.h"

@implementation TRMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    NSString *arrImages[] = {@"BeachBall", @"8Ball", @"SoccerBall"};
    
    for (UITouch *touch in touches) {
        SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:arrImages[arc4random_uniform(3)]];
        CGPoint location = [touch locationInNode:self];
        
        ball.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [ball runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:ball];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
