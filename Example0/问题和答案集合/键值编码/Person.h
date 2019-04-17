//
//  Person.h
//  Example0
//
//  Created by lmg on 2019/4/11.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (readonly) NSString *fullName;
@property NSString *firstName;
@property NSString *lastName;
- (instancetype)initWithFirstName:(NSString *)fname lastName:(NSString *)lname;

@end

NS_ASSUME_NONNULL_END
/*
 OC保留字
 变量范围：
 块，在语句块中声明的变量拥有块范围。
 文件，拥有文件范围的变量只能在声明它的文件中可见于被访问。
 函数，在函数/方法中声明的变量拥有函数范围。
 
 
 */
