//
//  TRDog.m
//  Man's Best Friend
//
//  Created by Tim on 10/7/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

#import "TRDog.h"

@implementation TRDog

-(void)bark
{
    NSLog(@"Mwraw!");
}

-(void)bark:(int)numberOfTimes
{
    NSLog([(YES ? @"woof" : @"mew") stringByAppendingString:@" %i!"], numberOfTimes);
}

-(NSString*)bark:(int)numberOfTimes loudly:(BOOL)isLoud
{
    NSLog([(isLoud ? @"WOOF" : @"mew") stringByAppendingString:@" %i!"], numberOfTimes);
    
    return @"barked!!";
}

-(void)transmogrify
{
    self.breed = @"Werebat";
}

@end
