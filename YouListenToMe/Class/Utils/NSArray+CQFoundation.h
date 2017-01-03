//
//  NSArray+SNFoundation.h
//  SNFoundation
//
//  Created by liukun on 14-3-2.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (CQFoundation)

- (id)safeObjectAtIndex:(NSUInteger)index;

- (id)deepCopy;
- (id)mutableDeepCopy;

- (id)trueDeepCopy;
- (id)trueDeepMutableCopy;

@end

#pragma mark -

@interface NSMutableArray (CheckIndex)

- (void)safeReplaceObjectAtIndex:(NSUInteger )index withObject:(id)object;
@end

@interface NSMutableArray (WeakReferences)

+ (id)noRetainingArray;
+ (id)noRetainingArrayWithCapacity:(NSUInteger)capacity;
+ (id)arrayClass:(Class)name withCount:(int)count;
@end

#pragma mark -

@interface NSMutableDictionary (WeakReferences)

+ (id)noRetainingDictionary;
+ (id)noRetainingDictionaryWithCapacity:(NSUInteger)capacity;

@end