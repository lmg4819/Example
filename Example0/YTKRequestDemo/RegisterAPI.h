//
//  RegisterAPI.h
//  Example0
//
//  Created by lmg on 2018/9/29.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "YTKRequest.h"


NS_ASSUME_NONNULL_BEGIN

@interface RegisterAPI : YTKRequest

- (id)initWithUsername:(NSString *)username password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
/*
 C++版本：
 C++98 1998
 C++11 2011
 C++14 2014
 C++17 2017
 C++20 2020(to be determined)
 
 
 IOS的C++动态库：
 
 libstdc++.dylib : 所代表的就是C++98版本的标准库实现动态库
 
 libc++.dylib : 所代表的就是C++11版本的标准库实现动态库
 
 libc++abi.dylib : 这个库主要是对C++的new/delete,try/catch/throw,typeid等关键字的实现支持，
 这个库是一个支持C++语法的核心库
 
 XCode10不在支持老版本的标准库libstdc++实现，而是只支持新版本的标准库libc++实现了
 
 
 Xcode对C++的支持和设置:
 
 Build Settings->Apple Clang - Language - C++->
 C++ Language Dialect:C++方言类型
 C++ Standard Library：C++标准库的版本
 
 XCode中对于C++标准库C++ Stadard Library选项的选择影响的是链接的标准库动态库的版本以及对应的头文件的搜索路径
 
 libc++:
 头文件的搜索路径是：/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1
 链接的动态库是：libc++.dylib
 
 libstdc++：
 头文件的搜索路径是：/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/c++/4.2.1
 链接的动态库是：libstdc++.dylib
 
 
 
 
 */
