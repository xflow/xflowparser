//
//  XFAObjcPointerType.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/28/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#ifndef xflow_XFPObjcPointerType_h
#define xflow_XFPObjcPointerType_h

typedef NS_ENUM(NSInteger, XFPObjcPointerType) {
    XFPObjcPointerTypeNone = 0 ,
    XFPObjcPointerTypeKnown = 1,
    XFPObjcPointerTypeUnknown = 2,
    XFPObjcPointerTypeInstanceType = 3,
    XFPObjcPointerTypeClass = 4,
    XFPObjcPointerTypeSelector = 5 ,
    XFPObjcPointerTypeBlock =6
};


#endif
