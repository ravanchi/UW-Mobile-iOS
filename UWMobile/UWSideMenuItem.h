@interface UWSideMenuItem : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *selectedImageName;
@property (nonatomic, copy, readonly) NSString *unselectedImageName;

- (instancetype)initWithName:(NSString *)name
   selectedImageName:(NSString *)selectedImageName
 unselectedImageName:(NSString *)unselectedImageName;

@end
