//
//  TRDog.h
//  Man's Best Friend
//
//  Created by Tim on 10/7/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRDog : NSObject

@property (nonatomic) int age;
@property (nonatomic, strong) NSString *breed;
@property (strong, nonatomic) UIImage *image;
@property (nonatomic, strong) NSString *name;

-(void)bark;
-(void)bark:(int)numberOfTimes;
-(NSString*)bark:(int)numberOfTimes loudly:(BOOL)isLoud;
-(void)transmogrify;

@end
