Objective-C Model Validator
=====

Objective-C Model Validator is a collection of classes and categories to add easy model validation to your application.

## Idea

This project is inspired from the famous [ActiveRecord](http://api.rubyonrails.org/classes/ActiveRecord/Base.html) Ruby framework.

Validation in Objective-C requires some effort to do and I needed it hardly. Knowing ActiveRecord made me do this.

## How to use

Import using cocoapods
    
    pod 'ObjcModelValidation', '~> 0.2'
    
### Create your model

    #import "ValidationModel.h"

    @interface SampleModel : ValidationModel

    @property (nonatomic, strong) NSString *nameString;
    @property (nonatomic, strong) NSNumber *ageNumber;

    @end
    
Note that it inherits from ValidationModel.

All properties used in this model are used to validate depending on their class.

    #import "SampleModel.h"

    @implementation SampleModel

    -(NSError *)validateAgeNumber:(NSNumber *)ageNumber{
        if ([ageNumber greaterThan:@18] && [ageNumber presence]) {
            return nil;
        }
    
        return [self errorWithLocalizedMessage:NSLocalizedString(@"You should be older than 18.", @"")];
    }
    
    -(NSError *)validateNameString:(NSString *)nameString{
        if ([nameString lengthMin:4]) {
            return nil;
        }
    
        return [self errorWithLocalizedMessage:NSLocalizedString(@"Your name should be at least 4 characters long", @"")];
    }

    @end
    
    
Note how the syntax of each validation method is: `-(NSError *)validate<CapitalizedVariableName>:(<VariableClass> *)<variableName>;`
This only works for objects at the moment. So if you store `NSInteger` or `BOOL` anywhere use `NSNumber` instead.

### Implement a save method

To start validating your models create them and save. Each model has its own save method, which returns a `NSArray` containing `NSError` objects. 

Example: 

    SampleModel *sample = [[SampleModel alloc] init];
    sample.nameString = @"Piet";
    sample.ageNumber = @22;
    
    NSArray *errors = [sample save];
    if (errors.count != 0) {
        
        PBLog(@"I got some errors here.");
        
        for (NSError *error in errors) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"Hide" otherButtonTitles:nil];
            [alertView show];
            
        }
    }

Note when overriding `save` you have to call `[super save];`. Otherwise validations are not called.

If everything fits you will see a log in the console.

### Use validators

#### NSObject validators

Checks for value to exist or not.

This method should be overriden by other validation classes to get
specific presence validation for a class.
 
    -(BOOL)presence;


Checks for the speicified method and executes custom validation.

    -(BOOL)validatesWithSelector:(SEL)selector;
    
#### NSNumber validators

Checks if the referenceNumber is greater than self

    -(BOOL)greaterThan:(NSNumber *)referenceNumber;
    
Checks if the referenceNumber is smaller than self

    -(BOOL)lessThan:(NSNumber *)referenceNumber;

#### NSString validators

Takes an array of strings and searches for it in self.

Returns YES if strings where not found in string.

    -(BOOL)exclusion:(NSArray *)exclusionArray;


Takes an regex string and validates it.

    -(BOOL)format:(NSString *)regexExpression;


Takes an array of strings and searches for it in self.

Returns YES if strings was found in string.

    -(BOOL)inclusion:(NSArray *)inclusionArray;


Validates with minimum length

    -(BOOL)lengthMin:(NSInteger)length;


Validates with maximum length

    -(BOOL)lengthMax:(NSInteger)length;


Validates with range
 
    -(BOOL)lengthIn:(NSInteger)lengthMin and:(NSInteger)lengthMax;


Validates with exact range

    -(BOOL)lengthIs:(NSInteger)length;


Validates with if the string consists only of numbers

    -(BOOL)numericality;
    
    
### Contributers highly welcome

Fork the Repository, write a test and send a pull request.

### Contact

[nerdish by nature](http://nerdishbynature.com)

[@piet_nbn](https://twitter.com/piet_nbn)