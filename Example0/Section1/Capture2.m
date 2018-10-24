//
//  Capture2.m
//  Example0
//
//  Created by lmg on 2018/10/11.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture2.h"

@implementation Capture2
/*
 
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.除非确又必要，否则不要引入头文件，应在某个类的头文件中使用向前声明来提及别的类，并在实现文件中引入那些类的头文件。这样做可以降低类之间的耦合。
 2.有时无法使用向前声明，比如声明某个类遵循一项协议。这种情况下，尽量把“该类遵循某协议”的这条声明移至"class-continuation分类中"。如果不行的话，就把协议单独放在一个头文件中，然后将其引入。
 
 
 */
@end
