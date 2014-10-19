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

    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    static NSString *arrImages[] = {@"BeachBall", @"8Ball", @"SoccerBall"};
    
    struct Props
    {
        float restitution;
        float linearDamping;
        float friction;
    };
    
    static struct Props props[] = {{1,1,1}, {0,0,0}, {.5,.5,.5}};
    
    for (UITouch *touch in touches) {
        int ixBall = arc4random_uniform(3);
        
        SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:arrImages[ixBall]];
        CGPoint location = [touch locationInNode:self];
        
        ball.position = location;
        ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width/2];
        ball.physicsBody.restitution = props[ixBall].restitution;
        ball.physicsBody.linearDamping = props[ixBall].linearDamping;
        ball.physicsBody.friction = props[ixBall].friction;
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [ball runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:ball];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
