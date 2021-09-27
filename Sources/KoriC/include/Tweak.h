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
- (UIEdgeInsets)_listViewDefaultContentInsets;
-(void)layoutListView;
@end

@interface NCNotificationStructuredListViewController : UIViewController
@end

// Notifications History
@interface NCNotificationListView : UIScrollView
@property (nonatomic) BOOL revealed;
@end

@interface NCNotificationListSectionHeaderView : UIView
@end

// Older notifications
@interface NCNotificationListSectionRevealHintView : UIView
@end

@interface NCNotificationListCoalescingHeaderCell : UIView
@end

@interface NCNotificationListCoalescingControlsCell : UIView
@end

// Date
@interface SBFLockScreenDateView : UIView
-(nullable UILabel *) _timeLabel;
@end

// Blur
@interface MTMaterialView : UIView
+(UIView *)materialViewWithRecipe:(long long)arg1 configuration:(unsigned long long)arg2;
@end

NS_ASSUME_NONNULL_END
