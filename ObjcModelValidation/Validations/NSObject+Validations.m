//
//  NSObject+Validations.m
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "NSObject+Validations.h"

@implementation NSObject (Validations)

-(BOOL)presence{
    return [(NSNull *)self isKindOfClass:[NSNull class]] ? NO : YES;
}

-(BOOL)absence{
    return ![self presence];
}

-(BOOL)validatesWithSelector:(SEL)selector{
    if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return (BOOL)[self performSelector:selector];
#pragma clang diagnostic pop
    } else {
        PBLog(@"no selector found with name %@", NSStringFromSelector(selector));
        return NO;
    }
}

@end
