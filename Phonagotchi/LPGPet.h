//
//  LPGPet.h
//  Phonagotchi
//
//  Created by Seantastic31 on 05/07/2017.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPGPet : NSObject

@property (nonatomic, readonly) BOOL isGrumpy;
@property (nonatomic, readonly) BOOL isSleeping;
@property (strong, nonatomic) NSString *currentImageName;
@property (nonatomic) NSTimeInterval restfulness;

- (instancetype)initWithImage:(NSString*)image;
- (void)petMe:(CGPoint)velocity;
- (void)sleepMe;

@end
