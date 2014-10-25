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

struct datum
{
    
};

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
    
    static struct Props props[] = {{.1,.9,.9,.9}, {.9,.1,.1,.1}, {.7,.7,.5,.5}};
    
    for (UITouch *touch in touches) {
        if (self.children.count >= 10)
        {
            [self removeAllChildren];
        }
        
        int ixBall = arc4random_uniform(3);
        
        _lastBall = [SKSpriteNode spriteNodeWithImageNamed:arrImages[ixBall]];
        CGPoint location = [touch locationInNode:self];
        float radius = _lastBall.size.width/2;
        
        _lastBall.position = location;
        _lastBall.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
        _lastBall.physicsBody.mass = props[ixBall].mass;
        _lastBall.physicsBody.restitution = props[ixBall].restitution;
        _lastBall.physicsBody.linearDamping = props[ixBall].linearDamping;
        _lastBall.physicsBody.friction = props[ixBall].friction;
        
        bool bBouncy = false;
        
        if (arc4random_uniform(3) > 1)
        {
            _lastBall.physicsBody.mass = 0;
            _lastBall.physicsBody.restitution = 1;
            _lastBall.physicsBody.linearDamping = 0;
            bBouncy = true;
            
            SKShapeNode *ball = [[SKShapeNode alloc] init];
            
            CGMutablePathRef myPath = CGPathCreateMutable();
            CGPathAddArc(myPath, NULL, 0,0, 15, 0, M_PI*2, YES);
            ball.path = myPath;
            
            ball.lineWidth = 1.0;
            ball.fillColor = [SKColor blueColor];
            ball.strokeColor = [SKColor whiteColor];
            ball.glowWidth = 0.5;
            
            [_lastBall addChild:ball];
        }
        
        if (arc4random_uniform(3) > 1)
        {
            self.physicsWorld.gravity = (self.physicsWorld.gravity.dy == 0)
            ? _initialGravity
            : CGVectorMake(0, 0);
        }
        
    // enumerate and add node
        _lastBall.name = @"ball";
        [self addChild:_lastBall];
        
    // apply forces and actions on node (does not seem to have to follow adding to parent)
        float thrust = 512 + arc4random_uniform(512);
        float vector = arc4random_uniform(200*M_PI)/100.0;
        
        [_lastBall.physicsBody applyForce:CGVectorMake(thrust*cosf(vector), thrust*sinf(vector))];

        if (arc4random_uniform(3) > 1)
        {
            SKAction *action = [SKAction rotateByAngle:arc4random_uniform(200*M_PI)/100.0-M_PI duration:1];
            
            [_lastBall runAction:[SKAction repeatActionForever:action]];
        }
        
    // user data
//        _lastBall.userData = [NSMutableDictionary dictionary];
//        [_lastBall.userData setValue:[NSNumber numberWithFloat:thrust] forKey:@"thrust"];
//        [_lastBall.userData setValue:[NSNumber numberWithFloat:vector] forKey:@"vector"];
//        [_lastBall.userData setValue:[NSNumber numberWithBool:bBouncy] forKey:@"bouncy"];
        
    // text node
        const int kLabelItems = 6;
        NSString *labelFormats[kLabelItems] = {
            @"mass = %.2f",
            @"boun = %.2f",
            @"flui = %.2f",
            @"fric = %.2f",
            @"thru = %.2f",
            @"vect = %.2f"};
        float labelValues[kLabelItems] = {
            _lastBall.physicsBody.mass,
            _lastBall.physicsBody.restitution,
            _lastBall.physicsBody.linearDamping,
            _lastBall.physicsBody.friction,
            thrust,
            vector};
        
        for (int i = 0; i<kLabelItems; ++i)
        {
            SKLabelNode *labelNode = [self makeLabelNode:[NSString stringWithFormat:labelFormats[i], labelValues[i]]];          // multiline \r\n do not work in SKLAbelNodes
            labelNode.position = CGPointMake(radius, radius - i * labelNode.frame.size.height);
            [_lastBall addChild:labelNode];
        }
    }
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
-(SKLabelNode*)makeLabelNode:(NSString *)text
{
    SKLabelNode *labelNode = [SKLabelNode labelNodeWithFontNamed:@"Skia"];
    
    labelNode.fontSize = 12;
    labelNode.fontColor = [SKColor redColor];
    labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    labelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeBaseline;
    labelNode.text = text;
    return labelNode;
}

- (void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"ball" usingBlock:^(SKNode *node, BOOL *stop) {
        if (NO == CGRectContainsPoint(self.frame, node.position)) {
         //   [node.userData dealloc];                                      // GC: ARC forbids explicit message send of dealloc
         //   node.userData = NULL;                                         // GC: unnecessary? auto GC anyway: node is no longer referenced?
            [node removeFromParent];
        }
    }];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self enumerateChildNodesWithName:@"ball" usingBlock:^(SKNode *node, BOOL *stop) {
      //  SKSpriteNode *ball = (SKSpriteNode*)node;
        
    }];
}

@end
