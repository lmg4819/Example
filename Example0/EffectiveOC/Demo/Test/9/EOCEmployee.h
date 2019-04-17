//
//  EOCEmployee.h
//  Example0
//
//  Created by lmg on 2018/10/12.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,EOCEmployeeType) {
    
    EOCEmployeeTypeDeveloper,
    EOCEmployeeTypeDesigner,
    EOCEmployeeTypeFinance
};

@interface EOCEmployee : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSUInteger salary;

+ (EOCEmployee *)employeeWithType:(EOCEmployeeType)type;

- (void)doADaysWork;

@end

NS_ASSUME_NONNULL_END
