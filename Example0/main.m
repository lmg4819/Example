//
//  main.m
//  Example0
//
//  Created by lmg on 2018/9/10.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode * addTwoNumbers(struct ListNode *l1,struct ListNode *l2)
{
    struct ListNode *p1 = l1;
    struct ListNode *p2 = l2;
    struct ListNode *result = (struct ListNode *)malloc(sizeof(struct ListNode));
    result->val = 0;
    
    struct ListNode *p = NULL;
    int c = 0;
    while (p1 != nil || p2 != nil || c!= 0) {
        if (p == NULL) {
            p = result;
        }else
        {
            p->next = (struct ListNode*)malloc(sizeof(struct ListNode));
            p->next->val = 0;
            p = p->next;
        }
        int a=(p1==NULL ? 0:p1->val);
        int b=(p2==NULL ? 0:p2->val);
        int s=(a+b+c)%10;
        c=(a+b+c)/10;
        p->val=s;
        p->next=NULL;
        
        p1=(p1==NULL ? NULL : p1->next);
        p2=(p2==NULL ? NULL : p2->next);
    }
    return result;
}


int main(int argc, char * argv[]) {
     
    @autoreleasepool {

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
