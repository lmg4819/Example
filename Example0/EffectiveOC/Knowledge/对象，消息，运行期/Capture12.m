//
//  Capture12.m
//  Example0
//
//  Created by lmg on 2018/10/15.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture12.h"

@implementation Capture12

/**
 动态方法解析
 */
//+(BOOL)resolveInstanceMethod:(SEL)sel
//{
//
//}

/**
 备援接受者
*/
//-(id)forwardingTargetForSelector:(SEL)aSelector
//{
//
//}
/*
 完成的消息转发流程
 */
//把消息打包成NSInvocation对象，创建一个有效的方法签名
//-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
//{
//
//}
//
//-(void)forwardInvocation:(NSInvocation *)anInvocation
//{
//
//}

/*
 在ios的CoreAnimation框架中，CALayer类就用了动态增加属性的方法，这使得CALayer成为“兼容于键值编码”的容器类，能够向里面随意添加属性，然后以键值对的方式来访问。
 
 
 
 
 
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.若对象无法响应某个选择子，则进入消息转发流程。
 2.通过运行期的动态方法解析功能，我们可以在需要用到某个方法时再将其加入类中。
 3.对象可以把其无法解读的某些选择子转交给其他对象来处理。
 4.经过上述两步之后，如果还是没办法处理选择子，那就触发完整的消息转发流程。
 
 
 1.resolveInstanceMethod 返回YES-----》消息已处理
 2.返回NO，forwardingTargetForSelector,返回备援的接收者------》消息已处理
 3.返回nil，forwardInvocation------》消息已处理
 4.消息未能处理，doesNotRecognizeSelector
 
 */
@end
