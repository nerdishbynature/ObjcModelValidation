//
//  NSObject+Validations.h
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Validations)

/**
 Checks for value to exist or not.
 This method should be overriden by other validation classes to get
 specific presence validation for a class.
 @return BOOL value
 */
-(BOOL)presence;

@end
