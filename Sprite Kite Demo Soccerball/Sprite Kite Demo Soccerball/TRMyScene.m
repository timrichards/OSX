//
//  TRMyScene.m
//  Sprite Kite Demo Soccerball
//
//  Created by Tim on 10/2/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

#import "TRMyScene.h"

@implementation TRMyScene
{
    SKSpriteNode *_ball;
    int _count;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];

        _ball = [SKSpriteNode spriteNodeWithImageNamed:@"SoccerBall"];
        _ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ball.size.width/2];
        _ball.physicsBody.dynamic = NO;
        _ball.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:_ball];
        
        [_ball runAction:[SKAction moveToX:500 duration:2]];
        
        _count = 0;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"SoccerBall"];

        ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width/2];
        ball.position = location;
        [self addChild:ball];
    }
}

-(void)log_ball:(NSString *)str
{
    if (_count < 5)
    {
        NSLog(@"%s: x %f y %f", [str cStringUsingEncoding:NSASCIIStringEncoding], _ball.position.x, _ball.position.y);
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    [self log_ball:@"Update"];
}

-(void)didEvaluateActions
{
    [self log_ball:@"Action"];
}

-(void)didSimulatePhysics
{
    [self log_ball:@"Physic"];
    ++_count;
}

@end
