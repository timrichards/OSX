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
{
    int _thisDog;
}

- (void) addDog:(NSString *) name Breed:(NSString *) breed Image:(NSString *) image
{
    TRDog *theDog = [[TRDog alloc] init];
    theDog.name = name;
    theDog.breed = breed;
    theDog.image = [UIImage imageNamed:image];
    
    [self.myDogs addObject:theDog];
}

-(void) displayDog
{
    TRDog *theDog = [self.myDogs objectAtIndex:_thisDog];
    self.myImageView.image = theDog.image;
    self.breedLabel.text = theDog.breed;
    self.nameLabel.text = theDog.name;
}

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
    NSLog(@"%@", myDog.breed);      // reference to member of null object does not crash
    NSLog(@"barking");
    [myDog bark];                   // call non-static method of null object does not invoke
    NSLog(@"barked");
    [myDog bark:23];                // method overload
    [myDog bark:44 loudly:YES];     // ignoring return
    [myDog bark:44 loudly:NO];
    NSLog(@"%@",[myDog bark:345 loudly:YES]);
    
    self.myDogs = [[NSMutableArray alloc] init];
    [self addDog:@"Nana" Breed:@"St. Bernard" Image:@"St.Bernard.JPG"];
    [self addDog:@"Wishbone" Breed:@"Jack Russell Terrier" Image:@"JRT.jpg"];
    [self addDog:@"Lassie" Breed:@"Collie" Image:@"BorderCollie.jpg"];
    [self addDog:@"Angel" Breed:@"Greyhound" Image:@"ItalianGreyhound.jpg"];
    
    _thisDog = 0;
    [self displayDog];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newDogButtonItemPressed:(UIBarButtonItem *)sender {
    int numberOfDogs = [self.myDogs count];
    int randomIndex = 0;
    
    do {
        randomIndex = arc4random() %  numberOfDogs;
    } while(randomIndex == _thisDog);
    
    _thisDog = randomIndex;
    [self displayDog];
    sender.title = @"And Another";
}
@end
