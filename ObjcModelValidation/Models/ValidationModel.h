//
//  ValidationModel.h
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSNumber+Validations.h"
#import "NSObject+Validations.h"
#import "NSString+Validations.h"
#import "NSDictionary+Validations.h"
#import "NSArray+Validations.h"

@interface ValidationModel : NSObject

/**
 Method that starts validation. And this should be overriden by the Model
 to support saving e.g. in a database using Magical Record.
 @return errors property containing NSError objects
 */
-(NSArray *)save;

/**
 Simple error with localized message status code 0 and className as error domain.
 @return Returns Error object
 */
-(NSError *)errorWithLocalizedMessage:(NSString *)errorMessage;

/**
 Error with custom error domain and localized error message
 @return Error object
 */
-(NSError *)errorWithErrorDomain:(NSString *)errorDomain andLocalizedMessage:(NSString *)localizedErrorMessage;

/**
 Error with custom error domain, error code and localized error message. 
 You could simply call this method on NSError but why not.
 @return Error object
 */
-(NSError *)errorWithErrorDomain:(NSString *)errorDomain code:(NSInteger)errorCode andUserInfoDictionary:(NSDictionary *)userInfoDict;

@end
