//
//  TRMyScene.m
//  Sprite Kite Demo Soccerball
//
//  Created by Tim on 10/2/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

#import "TRMyScene.h"

@implementation TRMyScene

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

        SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"SoccerBall"];
        ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width/2];
        ball.physicsBody.dynamic = NO;
        ball.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:ball];
        
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

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
