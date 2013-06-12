//
//  NSString+Validations.m
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "NSString+Validations.h"

@implementation NSString (Validations)

-(BOOL)exclusion:(NSArray *)exclusionArray{
    BOOL valid = YES;
    
    for (NSString *string in exclusionArray) {
        if ([string isKindOfClass:[NSString class]]) {
            if (!([self rangeOfString:string].location == NSNotFound)) {
                valid = NO;
                return valid;
            }
        }
    }
    
    // this happens if no invalid string where found
    // or array is empty
    return valid;
}

@end
