//
//  Coders.h
//  Example0
//
//  Created by lmg on 2019/4/12.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Coder;

@interface Coders : NSObject

@property NSSet *developers;

@end

NS_ASSUME_NONNULL_END
/*
 id类型是所有OC类型对象，用于存储对任何OC对象的引用
 id仅是一个指向objc_ocject标识符的C语言结构的指针

 
 typedef struct objc_object{
    Class isa;
 }*id;
 
 
 typedef struct objc_class *Class;
 Class数据类型是一种指针，这种指针指向带objc_class标识符的不透明类型。
 当编译器解析OC对象的代码时，会生成创建运行时对象类型的代码，即objc_object类型。
 
 
 struct objc_object{
 Class isa;
 }
 objc_object类型含有一个变量，该变量的类型是Class，名称为isa；换言之，它是一个指向objc_class类型变量的指针。
 
 */
