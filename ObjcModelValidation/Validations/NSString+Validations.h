//
//  NSString+Validations.h
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validations)

/**
 Takes an array of strings and searches for it in self.
 @param exlusionArray Only accepts NSString objects
 @return BOOL value 
 */
-(BOOL)exclusion:(NSArray *)exclusionArray;

@end
