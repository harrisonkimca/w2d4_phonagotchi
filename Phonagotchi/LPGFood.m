//
//  LPGFood.m
//  Phonagotchi
//
//  Created by Seantastic31 on 05/07/2017.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "LPGFood.h"

@implementation LPGFood

- (instancetype)initWithImage:(NSString *)image
{
    self = [super init];
    if (self) {
        _currentImageName = image;
    }
    return self;
}

@end
