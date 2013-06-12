//
//  NSString+Capitalization.m
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "NSString+Capitalization.h"

@implementation NSString (Capitalization)

-(NSString *)stringByCapitalizeFirstLetter{
    NSString *firstLetter = [self substringToIndex:1];
    firstLetter = [firstLetter uppercaseString];
    
    return [NSString stringWithFormat:@"%@%@", firstLetter, [self substringFromIndex:1]];
}

@end
