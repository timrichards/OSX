//
//  TRMyScene.m
//  Space Cannon
//
//  Created by Tim on 9/30/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

#import "TRMyScene.h"

@implementation TRMyScene
{
    SKNode *_mainLayer;
    SKSpriteNode *_cannon;
    
    /* Scene Update Processing:
    Since -touchesBegan is evaluated at "SKView renders the scene", too late to render the ball, move the
    evaluation to the next scene so the ball appears to emit closer to the end of the cannon. */
    BOOL _didShoot;
}

static const CGFloat SHOOT_SPEED = 1000.0f;

static inline CGVector radiansToVector(CGFloat radians)
{
    CGVector vector;
    
    vector.dx = cosf(radians);
    vector.dy = sinf(radians);
    
    return vector;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        _didShoot = NO;
        
        // Turn off gravity.
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        // Add background.
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"Starfield"];
        background.position = CGPointZero;
        background.anchorPoint = CGPointZero;
        background.blendMode = SKBlendModeReplace;                          // PERFORMANCE
        [self addChild:background];
        
        // Add main layer.
        _mainLayer = [[SKNode alloc] init];
        [self addChild:_mainLayer];
        
        // Add cannon.
        _cannon = [SKSpriteNode spriteNodeWithImageNamed:@"Cannon"];
        _cannon.position = CGPointMake(self.size.width/2, 0);
        [_mainLayer addChild:_cannon];
        
        // Create cannon rotation actions.
        SKAction *rotateCannon = [SKAction sequence:@[[SKAction rotateByAngle:M_PI duration:2],
                                                     [SKAction rotateByAngle:-M_PI duration:2]]];
        [_cannon runAction:[SKAction repeatActionForever:rotateCannon]];
        
        // Add edges.
        SKNode *leftEdge = [[SKNode alloc] init];
        leftEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointZero toPoint:CGPointMake(0, self.size.height)];
        leftEdge.position = CGPointZero;
        [self addChild:leftEdge];
        
        SKNode *rightEdge = [leftEdge copy];
        rightEdge.position = CGPointMake(self.size.width, 0);   // dot notation; property; is a e.g. _size var wrapped in a message call
        [self addChild:rightEdge];
    }

    return self;
}

-(void)shoot
{
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
    ball.name = @"ball";
    CGVector rotationVector = radiansToVector(_cannon.zRotation);
    float width = _cannon.size.width/2;
    ball.position = CGPointMake(_cannon.position.x + (width*rotationVector.dx),
                                _cannon.position.y + (width*rotationVector.dy));
    [_mainLayer addChild:ball];
    
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:6];
    ball.physicsBody.velocity = CGVectorMake(rotationVector.dx * SHOOT_SPEED, rotationVector.dy * SHOOT_SPEED);
    ball.physicsBody.restitution = 1;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.friction = 0;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        _didShoot = YES;
    }
}

- (void)didSimulatePhysics
{
    if (_didShoot) {
        [self shoot];
        _didShoot = NO;
    }
    
    [_mainLayer enumerateChildNodesWithName:@"ball" usingBlock:^(SKNode *node, BOOL *stop) {
        if (NO == CGRectContainsPoint(self.frame, node.position)) {
            [node removeFromParent];
        }
    }];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
