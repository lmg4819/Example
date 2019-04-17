//
//  Capture14.m
//  Example0
//
//  Created by lmg on 2018/10/15.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "Capture14.h"

@implementation Capture14

/*
 typedef struct objc_object{
    Class isa;
 }*id;
 
 typedef struct objc_class *Class;
 struct objc_class{
 Class isa;
 Class super_class;
 const char *name;
 long version;
 long info;
 long instance_size;
 struct objc_ivar_list *ivars;
 struct objc_method_lis **methodLists;
 struct objc_cache *cache;
 struct objc_protocol_list *protocols;
 };
 
 isMemberOfClass:能够判断对象是否为某个特定类的实例
 isKindOfClass:能够判断对象是否为某类或者其派生类的实例
 
 比较类对象是否等同的办法来做，使用==操作符，而不要使用比较Objective-C时常用的isEqual:方法，原因在于，类对象是单利，在应用程序范围内，每个类的Class仅有一个实例。
 
 我们应该尽量使用类型信息查询方法，而不应该直接比较两个类对象信息是否相同：
 因为前者可以正确的处理那些使用了消息传递机制的对象。比方说，某个兑现可能会把其受到的所有选择子都转发给另外一个对象，这样的对象叫做代理（proxy）,此种对象均以NSProxy为根类。通常情况下，如果在此种class对象上调用class方法，那么返回的是代理对象本身，而非接受代理的对象所属的类。然而，若是采用isMemberOfClass：这样的类型信息查询方法，那么代理对象就会把这条消息转发给接受代理的对象。也就是说，这条消息的返回值与直接在接受代理的对象上面查询其类型所得到的结果相同。因此，这样查出来的类对象与通过class方法所返回的类对象不同，class所返回的类表示发起代理的对象，而非接受代理的对象。
 
 
 JSCombination *combination = [[JSCombination alloc]init];
 
 [combination performSelector:@selector(test)];
 if ([combination class] == [JSCombination class]) {
 NSLog(@"555555555555555555");
 }
 
 if ([combination isKindOfClass:[JSCommonTool class]]) {
 NSLog(@"333333333333333333");
 }
 -----------------------------------------------------------------
 //总结
 -----------------------------------------------------------------
 1.每个实例都有一个指向Class对象的指针，用以表明其类型，而这些class对象则构成了类的继承体系。
 2.如果对象类型无法在编译器确定，那么就应该用类型信息查询方法来探知。
 3.尽量使用类型信息查询方法来确定对象类型，而不要直接比较类对象，因为某些对象可能实现了消息转发功能。
 
 */
@end
