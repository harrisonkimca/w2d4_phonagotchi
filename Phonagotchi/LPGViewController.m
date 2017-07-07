//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"
#import "LPGPet.h"
#import "LPGFood.h"

@interface LPGViewController ()

@property (nonatomic) UIImageView *petImageView;
@property (strong, nonatomic) UIImageView *foodImageView;
@property (strong, nonatomic) UIImageView *bucketImageView;
@property (strong, nonatomic) LPGPet *myPet;
@property (strong, nonatomic) LPGFood *myFood;
@property (strong, nonatomic) UIPanGestureRecognizer *petting;
@property (strong, nonatomic) UIPinchGestureRecognizer *feeding;
@property (nonatomic) CGRect startingFoodPosition;

@end

@implementation LPGViewController

{
    NSDate *startTime;
    NSDate *endTime;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    [self initializePet];
    [self initializeFood];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //self.petImageView.image = [UIImage imageNamed:@"default"];
    // now toggle between grumpy & default
    self.petImageView.image = [UIImage imageNamed:self.myPet.currentImageName];
    [self.view addSubview:self.petImageView];
    
    //make bucket image
    self.bucketImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.bucketImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bucketImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.bucketImageView.image = [UIImage imageNamed:@"bucket.png"];
    [self.view addSubview:self.bucketImageView];
    
    //make apple image
    self.foodImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.foodImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.foodImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.foodImageView.image = [UIImage imageNamed:@"apple.png"];
    [self.view addSubview:self.foodImageView];
    
    
    
    
//    [NSLayoutConstraint constraintWithItem:self.petImageView
//                                  attribute:NSLayoutAttributeCenterX
//                                  relatedBy:NSLayoutRelationEqual
//                                     toItem:self.view
//                                  attribute:NSLayoutAttributeCenterX
//                                 multiplier:1.0
//                                   constant:0.0].active = YES;
//    
//    [NSLayoutConstraint constraintWithItem:self.petImageView
//                                  attribute:NSLayoutAttributeCenterY
//                                  relatedBy:NSLayoutRelationEqual
//                                     toItem:self.view
//                                  attribute:NSLayoutAttributeCenterY
//                                 multiplier:1.0
//                                   constant:0.0].active = YES;
    
    // reset petImageView contraints to allow various images
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    // bucketImageView constraints
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:0.2
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.2
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-20]];
    
    // foodImageView constraints
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.foodImageView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:0.75
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.foodImageView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.75
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.foodImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.foodImageView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-30]];
    
    // add petting gesture to viewDidLoad
    self.petting = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(respondToPan:)];
    [self.view addGestureRecognizer:self.petting];
    // add petting gesture to viewDidLoad
    self.feeding = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(respondToPinch:)];
    [self.view addGestureRecognizer:self.feeding];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.startingFoodPosition = self.foodImageView.frame;
}

- (void)initializePet
{
    self.myPet = [[LPGPet alloc]initWithImage:@"default.png"];
}

- (void)initializeFood
{
    self.myFood = [[LPGFood alloc]initWithImage:@"apple.png"];
}

- (IBAction)respondToPan:(UIPanGestureRecognizer*)sender
{
    // when state changes check gesture speed and send to petMe
    if (sender.state == UIGestureRecognizerStateChanged)
    {
        CGPoint velocity = [self.petting velocityInView:self.petImageView];
        [self.myPet petMe:velocity];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(substractRestfulness)
                                       userInfo:nil
                                        repeats:YES];
    }
    // return to default when gesture ends (delayed)
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(setCurrentPetImageDelayed:)
                                       userInfo:@"default.png"
                                        repeats:NO];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(addRestfulness)
                                       userInfo:nil
                                        repeats:YES];
    }
    // use grumpy image when grumpy
    if (self.myPet.isGrumpy)
    {
        [self setCurrentPetImage:@"grumpy.png"];
    }
}

- (IBAction)respondToPinch:(UIPinchGestureRecognizer*)sender
{
    float frameWidth = self.foodImageView.frame.size.width;
    float frameHeight = self.foodImageView.frame.size.height;
    
    // when state changes and gesture recognized then pick up food
    if (sender.state == UIGestureRecognizerStateChanged && sender.velocity > 0)
    {
        CGPoint centerOfFood = [sender locationInView:nil];
        self.foodImageView.center = centerOfFood;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        // check if food inside pet or drops off screen
        if (CGRectIntersectsRect(self.foodImageView.frame, self.petImageView.frame))
        {
            // pet eats food
            [UIView animateWithDuration:2.0 animations:^{
                self.foodImageView.alpha = 0;
                self.foodImageView.frame = CGRectMake(self.foodImageView.frame.origin.x, self.foodImageView.frame.origin.y, 0, 0);
            }
            completion:^(BOOL finished) {
                self.foodImageView.frame = self.startingFoodPosition;
                self.foodImageView.alpha = 1;
            }];
        }
        // or food drops off screen
        else
        {
            [UIView animateWithDuration:2.0 animations:^{
                self.foodImageView.frame = CGRectMake(self.foodImageView.frame.origin.x, (self.view.bounds.size.height + 100), frameWidth, frameHeight);
            }
            completion:^(BOOL finished) {
                self.foodImageView.alpha = 0;
                self.foodImageView.frame = self.startingFoodPosition;
                self.foodImageView.alpha = 1;
            }];
        }
    }
    // redraw image
    [self.foodImageView setNeedsDisplay];
}

- (void)setCurrentPetImage:(NSString*)imageName
{
    self.myPet.currentImageName = imageName;
    self.petImageView.image = [UIImage imageNamed:self.myPet.currentImageName];
}

- (void)setCurrentPetImageDelayed:(NSTimer*)timer
{
    self.myPet.currentImageName = [timer userInfo];
    self.petImageView.image = [UIImage imageNamed:self.myPet.currentImageName];
}

- (void)substractRestfulness
{
    self.myPet.restfulness --;
}

- (void)addRestfulness
{
    self.myPet.restfulness ++;
}

@end
