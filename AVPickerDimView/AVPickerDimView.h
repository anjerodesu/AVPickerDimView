//
//  AVPickerDimView.h
//  AVPickerDimView
//
//  Created by Angelo Villegas on 9/10/11.
//  Copyright (c) 2012 Angelo Villegas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AVPickerDimViewDataSource, AVPickerDimViewDelegate;

@interface AVPickerDimView : UIView

@property (assign, nonatomic) id <AVPickerDimViewDataSource> dataSource;
@property (assign, nonatomic) id <AVPickerDimViewDelegate> delegate;

// picker view holder -- a view that will be the superview of the pickerView
@property (strong, nonatomic, readonly) UIActionSheet *actionSheet;

@property (nonatomic, getter = isAVPickerPresent) BOOL AVPickerPresent;

- (void)showAVPickerDimView;
- (void)hideAVPickerDimView;

// hides the action sheet. use this method when you need to explicitly dismiss the alert.
// it does not need to be called if the user presses on a button
- (void)dismiss:(BOOL)animated;
- (void)reloadAllComponents;

@end

@protocol AVPickerDimViewDataSource <NSObject>

@optional

@required

// number of component the picker view should have
- (NSInteger)numberOfComponentsInAVPicker;
// number of rows a component should have
- (NSInteger)numberOfRowsInAVPickerComponent:(NSInteger)component;

@end

@protocol AVPickerDimViewDelegate <NSObject>

@optional

// returns width of column and height of row for each component. 
- (CGFloat)avPickerWidthForComponent:(NSInteger)component;
- (CGFloat)avPickerRowHeightForComponent:(NSInteger)component;

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
- (NSString *)avPickerTitleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (NSAttributedString *)avPickerAttributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0); // attributed title is favored if both methods are implemented
- (UIView *)avPickerViewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;

- (void)avPickerDidSelectWithComponentPaths:(NSArray *)indexPaths; // called when the user tapped the 'Select' button
- (void)avCancelButtonPressed; // called when the user tapped the 'Cancel' button

@end
