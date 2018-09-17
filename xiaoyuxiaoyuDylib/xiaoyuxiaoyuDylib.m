//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  xiaoyuxiaoyuDylib.m
//  xiaoyuxiaoyuDylib
//
//  Created by perfay on 2018/9/17.
//  Copyright (c) 2018年 perfay. All rights reserved.
//

#import "xiaoyuxiaoyuDylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import <MDCycriptManager.h>

CHConstructor{
    NSLog(INSERT_SUCCESS_WELCOME);
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
#ifndef __OPTIMIZE__
        CYListenServer(6666);

        MDCycriptManager* manager = [MDCycriptManager sharedInstance];
        [manager loadCycript:NO];

        NSError* error;
        NSString* result = [manager evaluateCycript:@"UIApp" error:&error];
        NSLog(@"result: %@", result);
        if(error.code != 0){
            NSLog(@"error: %@", error.localizedDescription);
        }
#endif
        
    }];
}


CHDeclareClass(CustomViewController)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"

//add new method
CHDeclareMethod1(void, CustomViewController, newMethod, NSString*, output){
    NSLog(@"This is a new method : %@", output);
}

#pragma clang diagnostic pop

CHOptimizedClassMethod0(self, void, CustomViewController, classMethod){
    NSLog(@"hook class method");
    CHSuper0(CustomViewController, classMethod);
}

CHOptimizedMethod0(self, NSString*, CustomViewController, getMyName){
    //get origin value
    NSString* originName = CHSuper(0, CustomViewController, getMyName);
    
    NSLog(@"origin name is:%@",originName);
    
    //get property
    NSString* password = CHIvar(self,_password,__strong NSString*);
    
    NSLog(@"password is %@",password);
    
    [self newMethod:@"output"];
    
    //set new property
    self.newProperty = @"newProperty";
    
    NSLog(@"newProperty : %@", self.newProperty);
    
    //change the value
    return @"perfay";
    
}
//add new property
CHPropertyRetainNonatomic(CustomViewController, NSString*, newProperty, setNewProperty);

CHConstructor{
    CHLoadLateClass(CustomViewController);
    CHClassHook0(CustomViewController, getMyName);
    CHClassHook0(CustomViewController, classMethod);
    
    CHHook0(CustomViewController, newProperty);
    CHHook1(CustomViewController, setNewProperty);
}
//////////////////////////////////////////////////////////////////

CHDeclareClass(AppDelegate)

CHOptimizedMethod0(self, BOOL, AppDelegate, isJailBreak){
   BOOL  isjail =  CHSuper(0, AppDelegate, isJailBreak);
    return NO;
}
//////////////////////////////////////////////////////////////////

CHConstructor{
    CHLoadLateClass(AppDelegate);
    CHClassHook0(AppDelegate, isJailBreak);
}
//////////////////////////////LKProxyDetection////////////////////////////////////
#pragma mark - LKProxyDetection

CHDeclareClass(LKProxyDetection)

CHOptimizedClassMethod0(self, BOOL, LKProxyDetection, getProxyStatus){
    BOOL  isProxy =  CHSuper(0, LKProxyDetection, getProxyStatus);
    return NO;
}

CHConstructor{
    CHLoadLateClass(LKProxyDetection);
    CHClassHook0(LKProxyDetection, getProxyStatus);
}
#pragma mark - MSKeychain
///////////////////////////////MSKeychain///////////////////////////////////

CHDeclareClass(MSKeychain)

CHOptimizedClassMethod1(self, NSString *, MSKeychain, load,NSString *,arg1){
    NSString * udid =  CHSuper1(MSKeychain, load,arg1);
    NSLog(@"========%@:%@",arg1,udid);
//    return nil;
    return @"d80f18cc92fe48716bf31537153c636c73f846d5";
}
CHOptimizedClassMethod1(self,void, MSKeychain, delete,NSString *,arg1){
      CHSuper1(MSKeychain, delete,arg1);

}
CHConstructor{
    CHLoadLateClass(MSKeychain);
    CHClassHook1(MSKeychain, load);
    CHClassHook1(MSKeychain, delete);

}
//////////////////////////////XYWebViewJSObject////////////////////////////////////
#pragma mark - XYWebViewJSObject

CHDeclareClass(XYWebViewJSObject)

CHOptimizedMethod1(self, id, XYWebViewJSObject, xycheckudid,id ,arg1){
    id  udid =  CHSuper1(XYWebViewJSObject, xycheckudid,arg1);
    NSLog(@"check udid<<<<<<<<<<<<%@",udid);
    return udid;
}

CHConstructor{
    CHLoadLateClass(XYWebViewJSObject);
    CHClassHook1(XYWebViewJSObject, xycheckudid);
}
//////////////////////////////////////////////////////////////////
#pragma mark - XYWebViewJSObject
CHDeclareClass(HttpRequest)
CHOptimizedClassMethod0(self, id, HttpRequest, defaultHeadDictionary){
    id  obj =  CHSuper(0, HttpRequest, defaultHeadDictionary);
    return obj;
}

CHConstructor{
    CHLoadLateClass(HttpRequest);
    CHClassHook0(HttpRequest, defaultHeadDictionary);
}
//////////////////////////////CertViewController////////////////////////////////////
#pragma mark - CertViewController

CHDeclareClass(CertViewController)

CHOptimizedMethod2(self, void, CertViewController, userContentController,id ,arg1,didReceiveScriptMessage,id,arg2){
   CHSuper2(CertViewController, userContentController,arg1,didReceiveScriptMessage,arg2);
    NSLog(@"CertViewController>>>>>>>>>>>>controller:%@>>>>>>>>>>>message:%@",arg1,arg2);
}
CHConstructor{
    CHLoadLateClass(CertViewController);
    CHClassHook2(CertViewController, userContentController,didReceiveScriptMessage);
}
//////////////////////////////XYViewController////////////////////////////////////
#pragma mark - XYViewController

CHDeclareClass(XYViewController)

CHOptimizedMethod2(self, void, XYViewController, userContentController,id ,arg1,didReceiveScriptMessage,id,arg2){
    CHSuper2(XYViewController, userContentController,arg1,didReceiveScriptMessage,arg2);
    NSLog(@"XYViewController>>>>>>>>>>>>controller:%@>>>>>>>>>>>message:%@",arg1,arg2);
}
CHConstructor{
    CHLoadLateClass(XYViewController);
    CHClassHook2(XYViewController, userContentController,didReceiveScriptMessage);
}
/////////////////////////////NetServiceResponseDispatch/////////////////////////////////////
#pragma mark - NetServiceResponseDispatch
CHDeclareClass(NetServiceResponseDispatch)
CHOptimizedClassMethod0(self, id, NetServiceResponseDispatch, handlerMap){
    id  obj =  CHSuper(0, NetServiceResponseDispatch, handlerMap);
    NSLog(@"handlerMap=======%@",obj);
    return obj;
}

CHConstructor{
    CHLoadLateClass(NetServiceResponseDispatch);
    CHClassHook0(NetServiceResponseDispatch, handlerMap);
}


//////////////////////////////HTTPSServer////////////////////////////////////
#pragma mark - HTTPSServer

CHDeclareClass(HTTPSServer)

CHOptimizedMethod2(self, void, HTTPSServer, responseToStream,id ,arg1,requestData,id,arg2){
    CHSuper2(HTTPSServer, responseToStream,arg1,requestData,arg2);
    NSLog(@"HTTPSServer>>>>>>>>>>>>responseToStream:%@>>>>>>>>>>>requestData:%@",arg1,arg2);
}
CHConstructor{
    CHLoadLateClass(HTTPSServer);
    CHClassHook2(HTTPSServer, responseToStream,requestData);
}

