//
//  ValidationModel.m
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "ValidationModel.h"
#import <objc/runtime.h>

@implementation ValidationModel

-(NSArray *)save{
    [self properties];
    
    return @[];
}


-(NSArray *)properties{
    NSMutableArray *propertiesArray = [[NSMutableArray alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for(i = 0; i < outCount; i++) {
    	objc_property_t property = properties[i];
    	const char *propName = property_getName(property);
    	if(propName) {
    		const char *propType = getPropertyType(property);
    		NSString *propertyName = [NSString stringWithUTF8String:propName];
    		NSString *propertyType = [NSString stringWithUTF8String:propType];

            [propertiesArray addObject:@{propertyName: propertyType}];
            
    	}
    }
    free(properties);
    
    return propertiesArray;
}

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T') {
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "@";
}

@end
