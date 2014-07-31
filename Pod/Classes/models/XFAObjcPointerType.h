//
//  XFAObjcPointerType.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/28/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#ifndef xflow_XFAObjcPointerType_h
#define xflow_XFAObjcPointerType_h

typedef NS_ENUM(NSInteger, XFAObjcPointerType) {
    XFAObjcPointerTypeNone = 0 ,
    XFAObjcPointerTypeKnown = 1,
    XFAObjcPointerTypeUnknown = 2,
    XFAObjcPointerTypeInstanceType = 3,
    XFAObjcPointerTypeClass = 4,
    XFAObjcPointerTypeSelector = 5 ,
    XFAObjcPointerTypeBlock =6
};


#endif
