//
//  ValidationModel.m
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "ValidationModel.h"
#import <objc/runtime.h>

#define kPropertyNameKey @"propertyName"
#define kPropertyTypeKey @"propertyName"
#define kSelectorPlaceHolder @"validate%@:"

@interface ValidationModel ()

@property (nonatomic, strong) NSArray *properties;

@end

@implementation ValidationModel

-(NSArray *)save{
    [self validateProperties];
    return @[];
}

-(void)validateProperties{
    if (!self.properties) {
        self.properties = [self loadProperties];
    }
    
    for (NSDictionary *property in self.properties) {
        NSString *propertyName = [property valueForKey:kPropertyNameKey];
        NSString *propertyType = [property valueForKey:kPropertyTypeKey];
        NSString *selectorName = [NSString stringWithFormat:kSelectorPlaceHolder, propertyName];
        //TODO: capitalize first letter -(NSError *)validateageNumber:
        SEL selector = NSSelectorFromString(selectorName);
        
        if ([self respondsToSelector:selector]) {
            
        } else{
            PBLog(@"not validating %@ withType %@.\nImplement -(NSError *)%@ to validate a property.", propertyName, propertyType, selectorName);
        }
    }
    
}

-(NSArray *)loadProperties{
    NSMutableArray *propertiesArray = [[NSMutableArray alloc] init];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for(i = 0; i < outCount; i++) {
        NSDictionary *dict = [self propertyDictForIndex:i andProperties:properties];
        if (dict) {
            [propertiesArray addObject:dict];
        }
    }
    free(properties);
    
    return propertiesArray;
}

-(NSDictionary *)propertyDictForIndex:(unsigned int)index andProperties:(objc_property_t *)properties{
    objc_property_t property = properties[index];
    const char *propName = property_getName(property);
    if(propName) {
        const char *propType = getPropertyType(property);
        NSString *propertyName = [NSString stringWithUTF8String:propName];
        NSString *propertyType = [NSString stringWithUTF8String:propType];
        
        return @{kPropertyNameKey: propertyName, kPropertyTypeKey: propertyType};
    }
    
    return nil;
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
