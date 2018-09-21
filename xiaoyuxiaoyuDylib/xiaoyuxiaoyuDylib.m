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
#import "TaskBean.h"

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
    return udid;
//    return @"d80f18cc92fe48716bf31537153c636c73f846d5"; //iphone6p
//    return @"c7f21f432c84b38f9607bba5b3f16eb64e60f8f1"; //ipad

}
CHConstructor{
    CHLoadLateClass(MSKeychain);
    CHClassHook1(MSKeychain, load);
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
/////////////////////////////NetServiceInterfaceCopy/////////////////////////////////////

#pragma mark - 拷贝关键词
CHDeclareClass(NetServiceInterfaceCopy)
CHOptimizedClassMethod1(self, id, NetServiceInterfaceCopy, getResponseToRequest,id,arg1){
    id  obj =  CHSuper1(NetServiceInterfaceCopy, getResponseToRequest,arg1);
    id conten = [obj valueForKeyPath:@"content"];
    id queryDictionary = [arg1 valueForKeyPath:@"queryDictionary"];
    NSLog(@"NetServiceInterfaceCopy=======%@",obj);
    NSLog(@"queryDictionary=======%@",queryDictionary);

    return obj;
}

CHConstructor{
    CHLoadLateClass(NetServiceInterfaceCopy);
    CHClassHook1(NetServiceInterfaceCopy, getResponseToRequest);
}
/////////////////////////////NetServiceInterfacePing/////////////////////////////////////

#pragma mark - ping
CHDeclareClass(NetServiceInterfacePing)
CHOptimizedClassMethod1(self, id, NetServiceInterfacePing, getResponseToRequest,id,arg1){
    id  obj =  CHSuper1(NetServiceInterfacePing, getResponseToRequest,arg1);
    id conten = [obj valueForKeyPath:@"content"];
    NSLog(@"NetServiceInterfacePing=======%@",obj);
    return obj;
}

CHConstructor{
    CHLoadLateClass(NetServiceInterfacePing);
    CHClassHook1(NetServiceInterfacePing, getResponseToRequest);
}

/////////////////////////////NetServiceInterfaceApply/////////////////////////////////////

#pragma mark -  申请任务
/*
 {
 "return_code" = 200;
 "return_data" =     {
 "ad_type" = 1;
 "bundle_id" = "com.xx2r45s.jogxhxg";
 expire = 1537242004;
 keyword = "\U8d64\U6708\U9738\U4e1a";
 logo = "http://xyimg.xy599.com/pub_258351_1537239266_8857376.jpg";
 rank = 1;
 "short_link" = "https://itunes.apple.com/cn/app/id1418429074";
 title = "\U8d64\U6708\U9738\U4e1a";
 "try_play" = 180;
 };
 "return_msg" = SUCCESS;
 }
 */
CHDeclareClass(NetServiceInterfaceApply)
CHOptimizedClassMethod1(self, id, NetServiceInterfaceApply, getResponseToRequest,id,arg1){
    id  obj =  CHSuper1(NetServiceInterfaceApply, getResponseToRequest,arg1);
    NSLog(@"NetServiceInterfaceApply=======%@",obj);

    return obj;
}

CHConstructor{
    CHLoadLateClass(NetServiceInterfaceApply);
    CHClassHook1(NetServiceInterfaceApply, getResponseToRequest);
}
/////////////////////////////NetServiceInterfaceApply/////////////////////////////////////

#pragma mark -  打开
/*
 {
 msg = "APP\U672a\U5b89\U88c5"; 未安装
 result = 3001;
 }
 */
CHDeclareClass(NetServiceInterfaceOpenApp)
CHOptimizedClassMethod1(self, id, NetServiceInterfaceOpenApp, getResponseToRequest,id,arg1){
    id  obj =  CHSuper1(NetServiceInterfaceOpenApp, getResponseToRequest,arg1);
    return obj;
}

CHConstructor{
    CHLoadLateClass(NetServiceInterfaceOpenApp);
    CHClassHook1(NetServiceInterfaceOpenApp, getResponseToRequest);
}

#pragma mark -  信息
/*
 {
 {
 bundleId = "com.xiaoyu.qian";
 "ios_version" = "9.3.2";
 msg = "\U6210\U529f";
 "now_idfa" = "34392D94-56FD-4C04-997B-697C3736CBEF";
 result = 200;
 version = "9.2.6";
 }
 */
#pragma mark - NetServiceInterfaceInfo

CHDeclareClass(NetServiceInterfaceInfo)
CHOptimizedClassMethod1(self, id, NetServiceInterfaceInfo, getResponseToRequest,id,arg1){
    id  obj =  CHSuper1(NetServiceInterfaceInfo, getResponseToRequest,arg1);
    NSDictionary *conten = [obj valueForKeyPath:@"content"];
    NSLog(@"NetServiceInterfaceInfo=======%@",obj);
    return obj;
}

CHConstructor{
    CHLoadLateClass(NetServiceInterfaceInfo);
    CHClassHook1(NetServiceInterfaceInfo, getResponseToRequest);
}

#pragma mark - NetServiceInterfaceStartTask

CHDeclareClass(NetServiceInterfaceStartTask)
CHOptimizedClassMethod1(self, id, NetServiceInterfaceStartTask, getResponseToRequest,id,arg1){
    id  obj =  CHSuper1(NetServiceInterfaceStartTask, getResponseToRequest,arg1);
    NSDictionary *conten = [obj valueForKeyPath:@"content"];
    NSLog(@"NetServiceInterfaceStartTask=======%@",obj);
    return obj;
}

CHConstructor{
    CHLoadLateClass(NetServiceInterfaceStartTask);
    CHClassHook1(NetServiceInterfaceStartTask, getResponseToRequest);
}

#pragma mark - HTTPSRequest

CHDeclareClass(HTTPSRequest)
CHOptimizedClassMethod1(self, id, HTTPSRequest, queryDictionaryOfURL,id,arg1){
    id  obj =  CHSuper1(HTTPSRequest, queryDictionaryOfURL,arg1);
    NSLog(@"HTTPSRequest=======%@",obj);
    return obj;
}

CHConstructor{
    CHLoadLateClass(HTTPSRequest);
    CHClassHook1(HTTPSRequest, queryDictionaryOfURL);
}

/*
 {
 callback = "jQuery33001451563856098801_1537255085855";
 xyurl = "https://www.xiaoyuzhuanqian.com/api/auth/list";
 }
 */
#pragma mark - NetServiceInterfaceURL

CHDeclareClass(NetServiceInterfaceURL)
CHOptimizedClassMethod1(self, id, NetServiceInterfaceURL, getResponseToRequest,id,arg1){
    id  obj =  CHSuper1(NetServiceInterfaceURL, getResponseToRequest,arg1);
    NSData *conten = [obj valueForKeyPath:@"content"];
    NSLog(@"NetServiceInterfaceURL=======%@",obj);
    return obj;
}

CHConstructor{
    CHLoadLateClass(NetServiceInterfaceURL);
    CHClassHook1(NetServiceInterfaceURL, getResponseToRequest);
}
#pragma mark - TaskManager
CHDeclareClass(TaskManager)
CHOptimizedClassMethod1(self, void, TaskManager, taskComplete,id,arg1){
    CHSuper1(TaskManager, taskComplete,arg1);
    NSLog(@"taskComplete=======");
}

CHOptimizedClassMethod0(self, void, TaskManager, succeedInOpeningApp){
    CHSuper0(TaskManager, succeedInOpeningApp);
    NSLog(@"succeedInOpeningApp=======");
}

CHConstructor{
    CHLoadLateClass(TaskManager);
    CHClassHook1(TaskManager, taskComplete);
    CHClassHook0(TaskManager, succeedInOpeningApp);

}




//////////////////////////////LSAW_model////////////////////////////////////


#pragma mark - LSAW_model
CHDeclareClass(LSAW_model)
CHOptimizedMethod1(self, BOOL, LSAW_model, openAppWithIdentifier,id ,arg1){
    
    NSString*ls_aw =  @"TaskManager";
    NSString*default_W =  @"currentTask";
    Class v7 = NSClassFromString(ls_aw);
    SEL  selector = NSSelectorFromString(default_W);
    IMP imp = [v7 methodForSelector:selector];
    NSObject * (*func)(id, SEL) = (void *)imp;
    TaskBean  *task =  func(v7, selector);
    if(task&& [task.bundleId isEqualToString:arg1]){
        return YES;
    }
    else{
        return   CHSuper1(LSAW_model,openAppWithIdentifier,arg1);
    }
}
CHConstructor{
    CHLoadLateClass(LSAW_model);
    CHClassHook1(LSAW_model,openAppWithIdentifier);
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

