//
//  XFAXFATypeEncoding.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/30/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFAObjcTypeEncoding.h"
#import <RegExCategories.h>

@implementation XFAObjcTypeEncoding


+(NSDictionary*)encodings{
    NSDictionary * dicEncodings = @{
        @"char" 				: @"c",
        @"NSInteger" 			: @"i",
        @"int" 					: @"i",
        @"char" 				: @"c",
        @"short" 				: @"s",
        @"long" 				: @"l",
        @"long long" 			: @"q",
        @"unsigned char" 		: @"C",
        @"unsigned int" 		: @"I",
        @"NSUInteger" 			: @"I",
        @"unsigned short" 		: @"S",
        @"unsigned long" 		: @"L",
        @"unsigned long long" 	: @"Q",
        @"CGFloat" 				: @"f",
        @"float" 				: @"f",
        @"double" 				: @"d",
        @"bool"                 : @"B",
        @"Boolean" 				: @"C",
        @"BOOL" 				: @"c",
        @"void" 				: @"v",
        @"IBAction"     		: @"v",
        @"char *" 				: @"*",
        @"id" 					: @"@",
        @"instancetype"         : @"@",
        @"Class" 				: @"#",
        @"SEL"                  : @":",
        @"CGPoint"				: @"{CGPoint=ff}"
        };
    return dicEncodings;
}

+(NSString*)encoding_of:(NSString*)str
{
    NSDictionary * dic = [XFAObjcTypeEncoding encodings];
    NSAssert(dic, @"no encodings");
    NSString * enc = [dic objectForKey:str];
    NSAssert(enc, @"encoding_of nothing found for %@",str);
    return enc;
}


+(BOOL)isObjcType:(NSString*)name
{
    return [name isEqualToString:@"id"]
            || [name isEqualToString:@"instancetype"]
            || [name isEqualToString:@"Class"]
            || [name isEqualToString:@"SEL"]
            || [name isMatch:RX(@"\\*")];
    
}

+(NSString*)of:(NSString*)typeName
{
    
    typeName = [typeName replace:RX(@"([a-zA-Z0-9_]*)[ \\t]*(\\*)") with:@"$1 $2"];
    
    NSString * encoding = nil;
    
    NSDictionary * encodings = [XFAObjcTypeEncoding encodings];
    
    if ([encodings objectForKey:typeName])
    {
        encoding = [encodings objectForKey:typeName];
    }
    else if ([typeName isMatch:RX(@"typedef")] && [typeName isMatch:RX(@"struct")] )
    {
        encoding = [XFAObjcTypeEncoding parseStruct:typeName];
    }
    else if ([typeName isMatch:RX(@"\\[")] && [typeName isMatch:RX(@"\\]")] )
    {
        // parse_array
        encoding = [XFAObjcTypeEncoding parseCArray:typeName];
    }
    else if ([typeName isMatch:RX(@"\\*")] )
    {
        encoding = @"@";
    }
    else
    {
        encoding = @"?";
    }
    
    return encoding;
}

+(NSString*)parseCArray:(NSString*)s
{

    
    NSString * pattern = @"([a-zA-Z0-9_]*)[ \\t]+([a-zA-Z0-9_]*)\\[([0-9]+)\\]";
    RxMatch * match = [s firstMatchWithDetails:RX(pattern)];
    NSAssert(match, @"parse c array no match ");
    NSArray * groups =  match.groups;
    RxMatchGroup * grpType = [groups objectAtIndex:1];
    RxMatchGroup * grpSize = [groups objectAtIndex:3];
    NSString * typeEncoding = [XFAObjcTypeEncoding of:grpType.value];
    
    NSString * output = [NSString stringWithFormat:@"[%@^%@]",grpSize.value,typeEncoding];

    return output;
}

+(NSString*)parseStruct:(NSString*)s
{
    NSString * output = nil;;
    
    s = [s replace:RX(@"\\n") with:@" "];
    NSString * pattern1 = @"(.*)\\{(.*)\\}(.*)";
    RxMatch * match = [s firstMatchWithDetails:RX(pattern1)];
    NSAssert(match, @"parseStruct match not found");
    NSArray * matchGroups = match.groups;
    
    RxMatchGroup * groupHeader = [matchGroups objectAtIndex:1];
    NSString * header = groupHeader.value;
    
    header = [header stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSArray * header_parts = [header split:RX(@"\\W+")];
    
    NSString * struct_name = [header_parts lastObject];
    RxMatchGroup * groupBody = [matchGroups objectAtIndex:2];
    
    NSString * struct_body = groupBody.value;
    NSAssert(struct_body, @" no struct_body found");
    
//    RxMatchGroup * groupTail = [matchGroups objectAtIndex:3];
    
//    NSString * body_encoding = @"";

    NSArray * parts_encoding = @[];
    
    NSString * patternBody = @"([a-zA-Z0-9_]*)[ \\t]*(\\*?)[ \\t]*([a-zA-Z0-9_]*)[ \\t]*;";
    NSArray * matchesParts = [struct_body matchesWithDetails:RX(patternBody)];
    for (RxMatch * match  in matchesParts) {
        NSLog(@" • %@",match.value);
//        RxMatchGroup * grpType = [match.groups objectAtIndex:1];
//        RxMatchGroup * grpStar = [match.groups objectAtIndex:2];
//        NSString * target = grpType.value;
//        if (grpStar && grpStar.value.length > 0) {
//            NSAssert([grpStar.value isEqualToString:@"*"], @"expected only a star");
//            target = [target stringByAppendingString:grpStar.value];
        
        NSString * extractedType = [XFAObjcTypeEncoding extractType:match.value];
        NSString * encoding = [XFAObjcTypeEncoding of:extractedType];
        parts_encoding = [parts_encoding arrayByAddingObject:encoding];
    }
    
    NSString * parts_encoding_string = [parts_encoding componentsJoinedByString:@""];

    
    output = [NSString stringWithFormat:@"{%@=%@}",
              struct_name, parts_encoding_string];
    
    return output;
}

+(NSString*)extractType:(NSString*)varDeclaration
{
    
    varDeclaration = [varDeclaration stringByTrimmingCharactersInSet:
     [NSCharacterSet whitespaceCharacterSet]];
    NSString * pattern = @"([a-zA-Z0-9]*)[ \\t]*([\\*]?)(.*)$";

    RxMatch * match = [varDeclaration firstMatchWithDetails:RX(pattern)];
    NSAssert(match, @"extractType no match found %@", varDeclaration);
    NSString * output = @"";
    
    NSArray * groups =  match.groups;
    
    RxMatchGroup * grp1 = [groups objectAtIndex:1];
    output = [output stringByAppendingString:grp1.value];
    
    RxMatchGroup * grp2 = [groups objectAtIndex:2];
    if (grp2 && grp2.value.length > 0) {
        output = [output stringByAppendingFormat:@" %@",grp2.value];
    }

    return output;
    
}

@end
