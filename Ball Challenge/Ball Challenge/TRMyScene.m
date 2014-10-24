//
//  TRMyScene.m
//  Ball Challenge
//
//  Created by Tim on 10/18/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

#import "TRMyScene.h"

@implementation TRMyScene
{
    SKSpriteNode *_lastBall;
    CGVector _initialGravity;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
    }

    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    _initialGravity = self.physicsWorld.gravity;
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    static NSString *arrImages[] = {@"BeachBall", @"8Ball", @"SoccerBall"};
    
    struct Props
    {
        float mass;
        float restitution;          // bounciness
        float linearDamping;        // fluid effect of e.g. air friction
        float friction;
    };
    
    static struct Props props[] = {{.1,.9,.9,.9}, {.9,.1,.1,.1}, {.7,.5,.5,.5}};
    
    for (UITouch *touch in touches) {
        if (self.children.count >= 10)
        {
            [self removeAllChildren];
        }
        
        int ixBall = arc4random_uniform(3);
        
        _lastBall = [SKSpriteNode spriteNodeWithImageNamed:arrImages[ixBall]];
        CGPoint location = [touch locationInNode:self];
        
        _lastBall.position = location;
        _lastBall.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_lastBall.size.width/2];
        _lastBall.physicsBody.mass = props[ixBall].mass;
        _lastBall.physicsBody.restitution = props[ixBall].restitution;
        _lastBall.physicsBody.linearDamping = props[ixBall].linearDamping;
        _lastBall.physicsBody.friction = props[ixBall].friction;
        
        if (arc4random_uniform(3) > 1)
        {
            _lastBall.physicsBody.mass = 0;
            _lastBall.physicsBody.restitution = 1;
            _lastBall.physicsBody.linearDamping = 0;
        }
        
        if (arc4random_uniform(3) > 1)
        {
            self.physicsWorld.gravity = (self.physicsWorld.gravity.dy == 0)
                ? _initialGravity
                : CGVectorMake(0, 0);
        }
        
        [self addChild:_lastBall];
        
        float thrust = 512 + arc4random_uniform(512);
        float vector = arc4random_uniform(200*M_PI)/100.0;
        
        printf("%f %f\n", thrust, vector);
        [_lastBall.physicsBody applyForce:CGVectorMake(thrust*cosf(vector), thrust*sinf(vector))];

        if (arc4random_uniform(3) > 1)
        {
            SKAction *action = [SKAction rotateByAngle:arc4random_uniform(200*M_PI)/100.0-M_PI duration:1];
            
            [_lastBall runAction:[SKAction repeatActionForever:action]];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
