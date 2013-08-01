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
 *	Takes an array of strings and searches for it in self.
 *  Returns YES if strings where not found in string.
 *
 *	@param	exclusionArray	Only accepts NSString objects
 *
 *	@return	BOOL value
 */
-(BOOL)exclusion:(NSArray *)exclusionArray;

/**
 *	Takes an regex string and validates it.
 *
 *	@param	regexExpression	Regex expression in NSString format.
 *
 *	@return	BOOL value
 */
-(BOOL)format:(NSString *)regexExpression;

/**
 *	Takes an array of strings and searches for it in self.
 *  Returns YES if strings was found in string.
 *
 *	@param	inclusionArray	Only accepts NSString objects
 *
 *	@return	BOOL value
 */
-(BOOL)inclusion:(NSArray *)inclusionArray;

/**
 *	Validates with minimum length
 *
 *	@param	length	 minimum length
 *
 *	@return	BOOL value
 */
-(BOOL)lengthMin:(NSInteger)length;

/**
 *	Validates with maximum length
 *
 *	@param	length	maximum length
 *
 *	@return	BOOL value
 */
-(BOOL)lengthMax:(NSInteger)length;

/**
 *	Validates with range
 *
 *	@param	lengthMin	minimum length
 *	@param	lengthMax	maximum length
 *
 *	@return	BOOL value
 */
-(BOOL)lengthIn:(NSInteger)lengthMin and:(NSInteger)lengthMax;

/**
 *	Validates with exact range
 *
 *	@param	length	length
 *
 *	@return	BOOL value
 */
-(BOOL)lengthIs:(NSInteger)length;

/**
 *	Validates with if the string consists only of numbers
 *
 *	@return	BOOL value
 */
-(BOOL)numericality;

@end
