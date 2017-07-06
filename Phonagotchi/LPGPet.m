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

@end

@implementation LPGPet

- (instancetype)initWithImage:(NSString *)image
{
    self = [super init];
    if (self) {
        _currentImageName = image;
        _isGrumpy = NO;
    }
    return self;
}

- (void)petMe:(CGPoint)velocity
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

@end
