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
typedef NS_ENUM(NSInteger, MTMaterialRecipe) {
    MTMaterialRecipeNone,
    MTMaterialRecipeNotifications,
    MTMaterialRecipeWidgetHosts,
    MTMaterialRecipeWidgets,
    MTMaterialRecipeControlCenterModules,
    MTMaterialRecipeSwitcherContinuityItem,
    MTMaterialRecipePreviewBackground,
    MTMaterialRecipeNotificationsDark,
    MTMaterialRecipeControlCenterModulesSheer
};

typedef NS_OPTIONS(NSUInteger, MTMaterialOptions) {
    MTMaterialOptionsNone             = 0,
    MTMaterialOptionsGamma            = 1 << 0,
    MTMaterialOptionsBlur             = 1 << 1,
    MTMaterialOptionsZoom             = 1 << 2,
    MTMaterialOptionsLuminanceMap     = 1 << 3,
    MTMaterialOptionsBaseOverlay      = 1 << 4,
    MTMaterialOptionsPrimaryOverlay   = 1 << 5,
    MTMaterialOptionsSecondaryOverlay = 1 << 6,
    MTMaterialOptionsAuxiliaryOverlay = 1 << 7,
    MTMaterialOptionsCaptureOnly      = 1 << 8
};

@interface MTMaterialView : UIView
+(UIView *)materialViewWithRecipe:(long long)arg1 configuration:(unsigned long long)arg2 ;
@end

NS_ASSUME_NONNULL_END
