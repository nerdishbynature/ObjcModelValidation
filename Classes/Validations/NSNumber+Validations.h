//
//  NSNumber+Validations.h
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Validations)

/**
 *	Checks if the referenceNumber is greater than self
 *
 *	@param	referenceNumber Number used to validate self.
 *
 *	@return	BOOL value
 */
-(BOOL)greaterThan:(NSNumber *)referenceNumber;

/**
 *	Checks if the referenceNumber is smaller than self
 *
 *	@param	referenceNumber	Number used to validate self.
 *
 *	@return	BOOL value
 */
-(BOOL)lessThan:(NSNumber *)referenceNumber;

@end
