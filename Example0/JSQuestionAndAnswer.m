//
//  JSQuestionAndAnswer.m
//  Example0
//
//  Created by lmg on 2018/10/25.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "JSQuestionAndAnswer.h"

@implementation JSQuestionAndAnswer
/*
 
 1.用C语言来实现API的优缺点：
 
 优点：可以绕过OC的运行期系统，从而提升运行速度
 缺点：ARC只负责OC对象的内存管理，需要自己注意这些API的内存管理问题
 
 2.实现缓存时选用NSCache比NSDictionary好在哪里
 NSCache可以提供优雅的自动删减功能，NSCache是线程安全的，NSCache不会拷贝建，而是持有键，NSCache对象不拷贝键的原因在于：很多时候，键都是由不支持copy操作的对象来充当的。
 
 
 
 */
@end
