#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Kori)
- (nullable UIViewController*) _viewControllerForAncestor;
@end

// LS main controller
@interface CSCoverSheetViewController : UIViewController
@end

@interface SBCoverSheetPresentationManager : NSObject
+(SBCoverSheetPresentationManager *) sharedInstance;
-(void)setCoverSheetPresented:(BOOL)arg1 animated:(BOOL)arg2 withCompletion:(nullable id)arg3 ;
@end

// Notifications ScrollView
@interface CSCombinedListViewController : UIViewController
@end



// Blur
@interface MTMaterialView : UIView
+(UIView *)materialViewWithRecipe:(long long)arg1 configuration:(unsigned long long)arg2;
@end

NS_ASSUME_NONNULL_END
