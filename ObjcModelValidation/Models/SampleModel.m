//
//  SampleModel.m
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "SampleModel.h"

@implementation SampleModel

-(NSError *)validateAgeNumber:(NSNumber *)ageNumber{
    if ([ageNumber floatValue] > 18.f) {
        return nil;
    }
    
    return [self errorWithLocalizedMessage:NSLocalizedString(@"You should be older than 18.", @"")];
}

@end
