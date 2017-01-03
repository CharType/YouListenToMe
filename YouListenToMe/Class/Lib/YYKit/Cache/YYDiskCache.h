//
//  YYDiskCache.h
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by ibireme on 15/2/11.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 YYDiskCache is a thread-safe cache that stores key-value pairs backed by SQLite
 and file system (similar to NSURLCache's disk cache).
 
 YYDiskCache是线程安全的缓存键值存储了SQLite的支持和文件系统(类似于NSURLCache磁盘高速缓存)。
 
 特点：
 YYDiskCache has these features:
 
 * It use LRU (least-recently-used) to remove objects.
 * It can be controlled by cost, count, and age.
 * It can be configured to automatically evict objects when there's no free disk space.
 * It can automatically decide the storage type (sqlite/file) for each object to get
      better performance.
 
 You may compile the latest version of sqlite and ignore the libsqlite3.dylib in
 iOS system to get 2x~4x speed up.
 */
@interface YYDiskCache : NSObject

#pragma mark - Attribute
///=============================================================================
/// @name Attribute
///=============================================================================

/** The name of the cache. Default is nil.
   缓存的名字，默认为nil
 */
@property (nullable, copy) NSString *name;

/** The path of the cache (read-only).
 缓存的路径 只读
 */
@property (readonly) NSString *path;

/**
 If the object's data size (in bytes) is larger than this value, then object will
 be stored as a file, otherwise the object will be stored in sqlite.
 
 0 means all objects will be stored as separated files, NSUIntegerMax means all
 objects will be stored in sqlite. 
 0意味着所有对象将被存储为文件分离,NSUIntegerMax意味着所有对象将被存储在sqlite。默认值为20480(20 kb)。
 The default value is 20480 (20KB).
 如果对象的数据大小 大于20kb  那么将数据存储为文件，否则将存储在sqlite
 
 */
@property (readonly) NSUInteger inlineThreshold;

/**
 If this block is not nil, then the block will be used to archive object instead
 of NSKeyedArchiver. You can use this block to support the objects which do not
 conform to the `NSCoding` protocol.
 
 The default value is nil.
 
 如果这个块不是零,那么块将被用于归档对象NSKeyedArchiver。您可以使用此块不支持对象符合“NSCoding”协议。默认值是零。
 */
@property (nullable, copy) NSData *(^customArchiveBlock)(id object);

/**
 If this block is not nil, then the block will be used to unarchive object instead
 of NSKeyedUnarchiver. You can use this block to support the objects which do not
 conform to the `NSCoding` protocol.
 
 The default value is nil.
 如果这个块不是零,那么块将被用于归档对象NSKeyedArchiver。您可以使用此块不支持对象符合“NSCoding”协议。默认值是零。

 */
@property (nullable, copy) id (^customUnarchiveBlock)(NSData *data);

/**
 When an object needs to be saved as a file, this block will be invoked to generate
 a file name for a specified key. If the block is nil, the cache use md5(key) as 
 default file name.
 
 The default value is nil.
 
 当一个对象需要被保存为一个文件,这将调用块生成指定的文件名关键。如果块nil,缓存使用md5(关键)默认的文件名。默认值是零
 */
@property (nullable, copy) NSString *(^customFileNameBlock)(NSString *key);



#pragma mark - Limit
///=============================================================================
/// @name Limit
///=============================================================================

/**
 The maximum number of objects the cache should hold.
 
 @discussion The default value is NSUIntegerMax, which means no limit.
 This is not a strict limit — if the cache goes over the limit, some objects in the
 cache could be evicted later in background queue.
 
 对象缓存应持有的最大数量。@discussion NSUIntegerMax默认值,这意味着没有限制。这不是一个严格的限制——如果缓存超过限制,一些对象缓存可以驱逐后在后台队列。
 */
@property NSUInteger countLimit;

/**
 The maximum total cost that the cache can hold before it starts evicting objects.
 
 @discussion The default value is NSUIntegerMax, which means no limit.
 This is not a strict limit — if the cache goes over the limit, some objects in the
 cache could be evicted later in background queue.
 
 缓存可以容纳的最大总成本之前,开始驱逐对象。@discussion NSUIntegerMax默认值,这意味着没有限制。这不是一个严格的限制——如果缓存超过限制,一些对象缓存可以驱逐后在后台队列
 */
@property NSUInteger costLimit;

/**
 The maximum expiry time of objects in cache.
 
 @discussion The default value is DBL_MAX, which means no limit.
 This is not a strict limit — if an object goes over the limit, the objects could
 be evicted later in background queue.
 
 的最大对象缓存过期时间。@discussion DBL_MAX默认值,这意味着没有限制。这并不是一个严格的限制——如果一个对象超过极限,可能的对象被驱逐后在后台队列。
 缓存过期时间
 */
@property NSTimeInterval ageLimit;

/**
 The minimum free disk space (in bytes) which the cache should kept.
 
 @discussion The default value is 0, which means no limit.
 If the free disk space is lower than this value, the cache will remove objects
 to free some disk space. This is not a strict limit—if the free disk space goes
 over the limit, the objects could be evicted later in background queue.
 最小空闲磁盘空间(字节)的缓存应该保持。@discussion默认值为0,这意味着没有限制。如果空闲磁盘空间低于这个值,缓存会删除对象释放一些磁盘空间。这不是一个严格的限制一旦空闲磁盘空间限制,对象可能被驱逐后在后台队列。
 
 */
@property NSUInteger freeDiskSpaceLimit;

/**
 The auto trim check time interval in seconds. Default is 60 (1 minute).
 
 @discussion The cache holds an internal timer to check whether the cache reaches
 its limits, and if the limit is reached, it begins to evict objects.
 
 减少检查时间间隔在几秒钟内。默认是60(1分钟)。@discussion缓存包含一个内部定时器来检查缓存是否到达其局限性,如果达到极限,它开始驱逐对象
 */
@property NSTimeInterval autoTrimInterval;


#pragma mark - Initializer
///=============================================================================
/// @name Initializer
///=============================================================================
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 Create a new cache based on the specified path.
 创建一个新的缓存根据指定的路径
 @param path Full path of a directory in which the cache will write data.
     Once initialized you should not read and write to this directory.
   路径目录的完整路径缓存写入数据。一旦初始化你不应该读和写这个目录
 @return A new cache object, or nil if an error occurs.
   一个新的缓存对象,或零如果出现错误
 @warning If the cache instance for the specified path already exists in memory,
     this method will return it directly, instead of creating a new instance.
 如果缓存实例指定的路径已经存在于内存中,这个方法将返回它直接,而不是创建一个新的实例。
 */
- (nullable instancetype)initWithPath:(NSString *)path;

/**
 The designated initializer.
 初始化
 @param path       Full path of a directory in which the cache will write data.
     Once initialized you should not read and write to this directory.
 一个目录的完整路径将写入数据的高速缓存。一旦初始化你不应该读和写这个目录。
 @param threshold  The data store inline threshold in bytes. If the object's data
     size (in bytes) is larger than this value, then object will be stored as a 
     file, otherwise the object will be stored in sqlite. 0 means all objects will 
     be stored as separated files, NSUIntegerMax means all objects will be stored 
     in sqlite. If you don't know your object's size, 20480 is a good choice.
     After first initialized you should not change this value of the specified path.
 
  阈值字节的数据存储内联阈值。如果对象的数据大小(以字节为单位)大于这个值,然后将存储作为一个对象文件,否则对象将存储在sqlite。0意味着所有对象是存储为文件分离,NSUIntegerMax意味着所有对象将被存储sqlite。如果你不知道你的对象的大小,20480是一个不错的选择。首先初始化之后你不应该改变这个值指定的路径。
 
 @return A new cache object, or nil if an error occurs.
    一个新的缓存对象,或零如果出现错误。
 @warning If the cache instance for the specified path already exists in memory,
     this method will return it directly, instead of creating a new instance.
 
 如果缓存实例指定的路径已经存在于内存中,这个方法将返回它直接,而不是创建一个新的实例。
 */
- (nullable instancetype)initWithPath:(NSString *)path
                      inlineThreshold:(NSUInteger)threshold NS_DESIGNATED_INITIALIZER;


#pragma mark - Access Methods
///=============================================================================
/// @name Access Methods
///=============================================================================

/**
 Returns a boolean value that indicates whether a given key is in cache.
 This method may blocks the calling thread until file read finished.
 返回一个布尔值,指示是否一个给定的关键是在缓存中。这种方法可能会阻塞调用线程,直到文件读取完成
 @param key A string identifying the value. If nil, just return NO.
 键字符串标识值。如果为零,就没有回报
 @return Whether the key is in cache.
 关键是是否在缓存中
 
 检查这个key是否在缓存中已经缓存
 
 */
- (BOOL)containsObjectForKey:(NSString *)key;

/**
 Returns a boolean value with the block that indicates whether a given key is in cache.
 This method returns immediately and invoke the passed block in background queue 
 when the operation finished.
 
 返回一个布尔值表示的块是否一个给定的关键是在缓存中。该方法立即返回,在后台调用通过块队列当操作完成
 
 @param key   A string identifying the value. If nil, just return NO.
 键字符串标识值。如果为零,就没有回报
 @param block A block which will be invoked in background queue when finished.
 块一块完成后将在后台调用队列
 */
- (void)containsObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key, BOOL contains))block;

/**
 Returns the value associated with a given key.
 This method may blocks the calling thread until file read finished.
 返回与给定的键相关联的值。这种方法可能会阻塞调用线程,直到文件读取完成。
 @param key A string identifying the value. If nil, just return nil.
 键字符串标识值。如果为零,就返回nil
 @return The value associated with key, or nil if no value is associated with key.
 与键相关联的值,或与关键零如果没有价值。
 */
- (nullable id<NSCoding>)objectForKey:(NSString *)key;

/**
 Returns the value associated with a given key.
 This method returns immediately and invoke the passed block in background queue
 when the operation finished.
 返回与给定的键相关联的值。该方法立即返回,在后台调用通过块队列当操作完成
 
 @param key A string identifying the value. If nil, just return nil.
 
 键字符串标识值。如果为零,就返回nil
 @param block A block which will be invoked in background queue when finished.
 
 完成后在后台调用队列
 */
- (void)objectForKey:(NSString *)key withBlock:(void(^)(NSString *key, id<NSCoding> _Nullable object))block;

/**
 Sets the value of the specified key in the cache.
 This method may blocks the calling thread until file write finished.
 
 集的值指定的关键在缓存中。这种方法可能会阻塞调用线程,直到文件编写完成
 
 @param object The object to be stored in the cache. If nil, it calls `removeObjectForKey:`.
 对象的对象存储在缓存中。如果为零,它调用“removeObjectForKey:”。
 @param key    The key with which to associate the value. If nil, this method has no effect.
  与它们相关联的键的键值。如果为零,这种方法没有效果。
 */
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key;

/**
 Sets the value of the specified key in the cache.
 This method returns immediately and invoke the passed block in background queue
 when the operation finished.
 
 集的值指定的关键在缓存中。该方法立即返回,在后台调用通过块队列当操作完成
 
 @param object The object to be stored in the cache. If nil, it calls `removeObjectForKey:`.
 对象的对象存储在缓存中。如果为零,它调用“removeObjectForKey:”。
 @param block  A block which will be invoked in background queue when finished.
 
 块一块完成后将在后台调用队列。
 */
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key withBlock:(void(^)(void))block;

/**
 Removes the value of the specified key in the cache.
 This method may blocks the calling thread until file delete finished.
 在缓存中移除指定键的值。这种方法可能会阻塞调用线程,直到文件删除了。
 
 @param key The key identifying the value to be removed. If nil, this method has no effect.
 键的键识别价值被删除。如果为零,这种方法没有效果。
 */
- (void)removeObjectForKey:(NSString *)key;

/**
 Removes the value of the specified key in the cache.
 This method returns immediately and invoke the passed block in background queue
 when the operation finished.
 在缓存中移除指定键的值。该方法立即返回,在后台调用通过块队列当操作完成
 
 @param key The key identifying the value to be removed. If nil, this method has no effect.
 @param block  A block which will be invoked in background queue when finished.
 */
- (void)removeObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key))block;

/**
 Empties the cache.
 This method may blocks the calling thread until file delete finished.
 清空缓存
 */
- (void)removeAllObjects;

/**
 Empties the cache.
 This method returns immediately and invoke the passed block in background queue
 when the operation finished.
 清空缓存。该方法立即返回,在后台调用通过块队列当操作完成。

 @param block  A block which will be invoked in background queue when finished.
  块一块完成后将在后台调用队列
 */
- (void)removeAllObjectsWithBlock:(void(^)(void))block;

/**
 Empties the cache with block.
 This method returns immediately and executes the clear operation with block in background.
 清空缓存块。该方法立即返回并执行明确的操作背景块。
 
 @warning You should not send message to this instance in these blocks.
 你不应该发送消息到这个实例
 @param progress This block will be invoked during removing, pass nil to ignore.
 进步这一块将调用删除期间,通过nil,不容忽视
 @param end      This block will be invoked at the end, pass nil to ignore.
 结束这一块将调用删除期间,通过nil,不容忽视
 */
- (void)removeAllObjectsWithProgressBlock:(nullable void(^)(int removedCount, int totalCount))progress
                                 endBlock:(nullable void(^)(BOOL error))end;


/**
 Returns the number of objects in this cache.
 This method may blocks the calling thread until file read finished.
 返回此缓存中对象的数量
 @return The total objects count.  对象数量
 */
- (NSInteger)totalCount;

/**
 Get the number of objects in this cache.
 This method returns immediately and invoke the passed block in background queue
 when the operation finished.
 得到这个缓存中对象的数量，后调用队列
 @param block  A block which will be invoked in background queue when finished.  队列
 */
- (void)totalCountWithBlock:(void(^)(NSInteger totalCount))block;

/**
 Returns the total cost (in bytes) of objects in this cache.
 This method may blocks the calling thread until file read finished.
 返回对象的总成本(以字节为单位)在这个缓存。这种方法可能会阻塞调用线程,直到文件读取完成。
 @return The total objects cost in bytes.  缓存对象的总字节数
 */
- (NSInteger)totalCost;

/**
 Get the total cost (in bytes) of objects in this cache.
 This method returns immediately and invoke the passed block in background queue
 when the operation finished.
 得到的总成本(以字节为单位)的对象缓存。该方法立即返回,在后台调用通过块队列当操作完成。
 
 @param block  A block which will be invoked in background queue when finished.
 函数返回后调用的队列
 */
- (void)totalCostWithBlock:(void(^)(NSInteger totalCost))block;


#pragma mark - Trim
///=============================================================================
/// @name Trim
///=============================================================================

/**
 Removes objects from the cache use LRU, until the `totalCount` is below the specified value.
 This method may blocks the calling thread until operation finished.
 从缓存中删除对象使用LRU,直到totalCount低于指定值。这种方法可能会阻塞调用线程,直到操作完成。
 @param count  The total count allowed to remain after the cache has been trimmed.
 数总数仍允许缓存后削减了。
 */
- (void)trimToCount:(NSUInteger)count;

/**
 Removes objects from the cache use LRU, until the `totalCount` is below the specified value.
 This method returns immediately and invoke the passed block in background queue
 when the operation finished.
 
 从缓存中删除对象使用LRU,直到totalCount低于指定值。该方法立即返回,在后台调用通过块队列当操作完成。
 
 @param count  The total count allowed to remain after the cache has been trimmed.
 总数
 @param block  A block which will be invoked in background queue when finished.
 完成后调用的队列
 */
- (void)trimToCount:(NSUInteger)count withBlock:(void(^)(void))block;

/**
 Removes objects from the cache use LRU, until the `totalCost` is below the specified value.
 This method may blocks the calling thread until operation finished.
 从缓存中删除对象使用LRU,直到totalCost低于指定值。这种方法可能会阻塞调用线程,直到操作完成。
 @param cost The total cost allowed to remain after the cache has been trimmed.
 */
- (void)trimToCost:(NSUInteger)cost;

/**
 Removes objects from the cache use LRU, until the `totalCost` is below the specified value.
 This method returns immediately and invoke the passed block in background queue
 when the operation finished.
 
 @param cost The total cost allowed to remain after the cache has been trimmed.
 @param block  A block which will be invoked in background queue when finished.
 删除后调用队列
 
 */
- (void)trimToCost:(NSUInteger)cost withBlock:(void(^)(void))block;

/**
 Removes objects from the cache use LRU, until all expiry objects removed by the specified value.
 This method may blocks the calling thread until operation finished.
 从缓存中删除对象使用LRU,直到所有到期对象被指定的值。这种方法可能会阻塞调用线程,直到操作完成。@param对象的年龄最大的年龄。
 @param age  The maximum age of the object.
 */
- (void)trimToAge:(NSTimeInterval)age;

/**
 Removes objects from the cache use LRU, until all expiry objects removed by the specified value.
 This method returns immediately and invoke the passed block in background queue
 when the operation finished.
 
 @param age  The maximum age of the object.
 @param block  A block which will be invoked in background queue when finished.
 
 从缓存中删除对象使用LRU,直到所有到期对象被指定的值。该方法立即返回,在后台调用通过块队列当操作完成。@param对象的年龄最大的年龄。@param块一块完成后将在后台调用队列。
 */
- (void)trimToAge:(NSTimeInterval)age withBlock:(void(^)(void))block;


#pragma mark - Extended Data
///=============================================================================
/// @name Extended Data
///=============================================================================

/**
 Get extended data from an object.
 
 @discussion See 'setExtendedData:toObject:' for more information.
 
 @param object An object.
 @return The extended data.
 
 从一个对象获得扩展数据。@discussion看到“setExtendedData:toObject:”获得更多信息。@param对象的对象。@return扩展数据。
 */
+ (nullable NSData *)getExtendedDataFromObject:(id)object;

/**
 Set extended data to an object.
 
 @discussion You can set any extended data to an object before you save the object
 to disk cache. The extended data will also be saved with this object. You can get
 the extended data later with "getExtendedDataFromObject:".
 
 @param extendedData The extended data (pass nil to remove).
 @param object       The object.
 
 扩展数据设置为一个对象。
 @discussion可以设置任何扩展数据对象之前保存对象磁盘缓存。这个对象的扩展数据也将被保存。你可以得到与“getExtendedDataFromObject:“后来扩展数据。
 @param extendedData扩展的数据(通过nil删除)。
 @param对象的对象。
 */
+ (void)setExtendedData:(nullable NSData *)extendedData toObject:(id)object;

@end

NS_ASSUME_NONNULL_END
