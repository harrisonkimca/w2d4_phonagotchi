//
//  LPGPet.m
//  Phonagotchi
//
//  Created by Seantastic31 on 05/07/2017.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "LPGPet.h"

@interface LPGPet()

@property (nonatomic, readwrite) BOOL isGrumpy;
@property (nonatomic, readwrite) BOOL isSleeping;

@end

@implementation LPGPet

- (instancetype)initWithImage:(NSString *)image
{
    self = [super init];
    if (self) {
        _currentImageName = image;
        _isGrumpy = NO;
        _isSleeping = NO;
        _restfulness = 0;
    }
    return self;
}

- (void)petMe:(CGPoint)velocity
{
    if (self.restfulness < 33)
    {
        if (velocity.x > 500 || velocity.x < -500 || velocity.y > 500 || velocity.y < -500)
        {
            self.isGrumpy = YES;
        }
        else
        {
            self.isGrumpy = NO;
        }
    }
    else if (self.restfulness < 66 && self.restfulness > 33)
    {
        if (velocity.x > 1000 || velocity.x < -1000 || velocity.y > 1000 || velocity.y < -1000)
        {
            self.isGrumpy = YES;
        }
        else
        {
            self.isGrumpy = NO;
        }
    }
    else if (self.restfulness > 66)
    {
        if (velocity.x > 2000 || velocity.x < -2000 || velocity.y > 2000 || velocity.y < -2000)
        {
            self.isGrumpy = YES;
        }
        else
        {
            self.isGrumpy = NO;
        }
    }
    else
    {
        self.isGrumpy = NO;
    }
}

- (void)sleepMe
{
    if (self.restfulness <= 0)
    {
        self.isSleeping = YES;
    }
    else
    {
        self.isSleeping = NO;
    }
}


@end
