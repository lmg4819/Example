//
//  EOCEmployee.m
//  Example0
//
//  Created by lmg on 2018/10/12.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "EOCEmployee.h"
#import "EOCEmployeeDeveloper.h"
#import "EOCEmployeeDesigner.h"
#import "EOCEmployeeFinance.h"

@implementation EOCEmployee

+ (EOCEmployee *)employeeWithType:(EOCEmployeeType)type
{
    switch (type) {
        case EOCEmployeeTypeDeveloper:
            return [EOCEmployeeDeveloper new];
            break;
        case EOCEmployeeTypeDesigner:
            return [EOCEmployeeDesigner new];
            break;
        case EOCEmployeeTypeFinance:
            return [EOCEmployeeFinance new];
            break;
    }
}

- (void)doADaysWork
{
    
}

@end
