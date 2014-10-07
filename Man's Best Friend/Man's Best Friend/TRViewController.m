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
  //  myDog = nil;
    [myDog transmogrify];
    NSLog(@"%@", myDog.breed);      // reference to a null object does not crash
    NSLog(@"barking");
    [myDog bark];                   // method call on null object does not invoke
    NSLog(@"barked");
    [myDog bark:23];                // method overload
    [myDog bark:44 loudly:YES];     // ignoring return
    [myDog bark:44 loudly:NO];
    NSLog(@"%@",[myDog bark:345 loudly:YES]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
