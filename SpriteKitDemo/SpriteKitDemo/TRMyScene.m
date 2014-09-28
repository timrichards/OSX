//
//  TRMyScene.m
//  SpriteKitDemo
//
//  Created by Tim on 9/28/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

#import "TRMyScene.h"

@implementation TRMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"Space"];
        background.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:background];
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        NSArray *myArray = [NSArray arrayWithObjects: [SKAction rotateByAngle:M_PI duration:1],
                   [SKAction moveByX:0.0f y: 200.0f duration:1],
                   nil];
        SKAction *action3 = [SKAction group:myArray];
        
        [sprite runAction:[SKAction repeatActionForever:action3]];
        
        [self addChild:sprite];
        
        
        SKSpriteNode *square = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(20, 20)];
        [sprite addChild:square];
        [square runAction:[SKAction repeatActionForever:action3]];
        

        SKSpriteNode *leftFlame = [SKSpriteNode spriteNodeWithImageNamed:@"Flame"];
        leftFlame.anchorPoint = CGPointMake(.5, 1);
        leftFlame.position = CGPointMake(-12, -87);
        [sprite addChild:leftFlame];

        SKSpriteNode *rightFlame = [leftFlame copy];
        rightFlame.position = CGPointMake(12, -87);
        [sprite addChild:rightFlame];

    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */;
}

@end
