//
//  EOCSecondViewController.h
//  Example0
//
//  Created by lmg on 2018/10/25.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EOCSecondViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
/*
 static修饰局部变量，改变变量的存储方式，使变量成为局部的静态变量。
 即编译时就为变量分配内存，直到程序退出才释放存储变量。这样，使得该局部变量有记忆功能，可以记忆上次的数据，不过由于仍是局部变量，因而只能在代码块内部使用。
 
 static声明外部变量
 外部变量指在代码块{}之外定义的变量，它缺醒为静态变量，编译时分配内存，程序结束时才释放内存单元。同时，其作用域很广，整个文件都有效，甚至别的文件也能引用它。为了限制某些局部变量的作用域，使其指在本文件中有效，而不能被其他文件引用，可以用static关键字对其作出声明。
 
 */
