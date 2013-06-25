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
    if ([ageNumber greaterThan:@18] && [ageNumber presence]) {
        return nil;
    }
    
    return [self errorWithLocalizedMessage:NSLocalizedString(@"You should be older than 18.", @"")];
}

-(NSError *)validateNameString:(NSString *)nameString{
    if ([nameString lengthMin:4]) {
        return nil;
    }
    
    return [self errorWithLocalizedMessage:NSLocalizedString(@"Your name should be at least 4 characters long", @"")];
}

@end
