//
//  AVIndexPath.h
//  AVPickerDimView
//
//  Created by Angelo Villegas on 7/22/12.
//  Copyright (c) 2012 Angelo Villegas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVIndexPath : NSObject

@property ( assign , nonatomic , readonly ) NSInteger row;
@property ( assign , nonatomic , readonly ) NSInteger component;

- (id)initWithRow:(NSInteger)row inComponent:(NSInteger)component;

+ (AVIndexPath *)indexPathForRow:(NSInteger)row inComponent:(NSInteger)component;

@end
