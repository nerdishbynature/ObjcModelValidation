//
//  ValidationModel.m
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "ValidationModel.h"
#import <objc/runtime.h>
#import "NSString+Capitalization.h"

#define kPropertyNameKey @"propertyName"
#define kPropertyTypeKey @"propertyKey"
#define kSelectorPlaceHolder @"validate%@:"

@interface ValidationModel ()

@property (nonatomic, strong) NSArray *properties;
@property (nonatomic, strong) NSMutableArray *errors;

@end

@implementation ValidationModel

-(NSArray *)save{
    [self validateProperties];
    self.errors = [NSMutableArray array];
    return self.errors;
}

/**
 A simple for loop iterating through the properties fetched from the model (@see loadProperties).
 Reads the type and name and checks whether a validation method is implemented or not.
 If a validation method exists it runs it and receives an error object or nil.
 If an error object exists it stores this into the errors property.
 @see http://stackoverflow.com/questions/11895287/performselector-arc-warning
 */
-(void)validateProperties{
    if (!self.properties) {
        self.properties = [self loadProperties];
    }
    
    for (NSDictionary *property in self.properties) {
        NSString *propertyName = [property valueForKey:kPropertyNameKey];
        NSString *propertyType = [property valueForKey:kPropertyTypeKey];
        NSString *selectorName = [NSString stringWithFormat:kSelectorPlaceHolder, [propertyName stringByCapitalizeFirstLetter]];

        SEL selector = NSSelectorFromString(selectorName);
        
        if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            NSError *error = [self performSelector:selector withObject:[self valueForKey:propertyName]];
#pragma clang diagnostic pop
            if (error) {
                PBLog(@"got error %@", error);
                [self.errors addObject:error];
            } else{
                PBLog(@"no error found %@ is valid.", propertyName);
            }
        } else{
            PBLog(@"not validating %@ withType %@.\nImplement -(NSError *)%@(%@ *)%@ to validate a property.", propertyName, propertyType, selectorName, propertyType, propertyName);
        }
    }
    
}

/**
 Loads all properties from self (subclass)
 @return Array containing Dictionaries as described in propertyDictForIndex:andProperties:
 */
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

/**
 This creates a dictionary with the property name and type
 @param index Current index of for-loop
 @param properties objc_property_t object containing the properties
 @return Initialized and filles NSDictionary as described above
 */
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

#pragma mark - Error helper

-(NSError *)errorWithLocalizedMessage:(NSString *)errorMessage{
    NSDictionary *dict = @{NSLocalizedDescriptionKey: errorMessage};
    return [NSError errorWithDomain:NSStringFromClass([self class]) code:0 userInfo:dict];
}

-(NSError *)errorWithErrorDomain:(NSString *)errorDomain andLocalizedMessage:(NSString *)localizedErrorMessage{
    return [NSError errorWithDomain:errorDomain code:0 userInfo:@{NSLocalizedDescriptionKey: localizedErrorMessage}];
}

-(NSError *)errorWithErrorDomain:(NSString *)errorDomain code:(NSInteger)errorCode andUserInfoDictionary:(NSDictionary *)userInfoDict{
    return [NSError errorWithDomain:errorDomain code:errorCode userInfo:userInfoDict];
}

#pragma mark - C stuff

/**
 Reads the properties.
 */
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
