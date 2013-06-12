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
    return [(NSNull *)self isMemberOfClass:[NSNull class]] ? NO : YES;
}

@end
