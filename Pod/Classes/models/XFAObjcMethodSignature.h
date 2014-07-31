//
//  XFAMethodSignature.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/30/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Mantle.h>


@interface XFAObjcMethodSignature : MTLModel <MTLJSONSerializing>

@property (nonatomic,strong) NSString * signatureName;

@property (nonatomic,strong) NSString * signatureEncoding;

@end
