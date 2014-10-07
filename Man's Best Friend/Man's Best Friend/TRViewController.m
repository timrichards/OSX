//
//  TRViewController.m
//  Man's Best Friend
//
//  Created by Tim on 10/7/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

#import "TRViewController.h"
#import "TRDog.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    TRDog *myDog = [[TRDog alloc] init];
    myDog.name = @"Spud";
    myDog.breed = @"Cat";
    myDog.age = 13;
    myDog = NULL;
    NSLog(@"%@", myDog.name);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
