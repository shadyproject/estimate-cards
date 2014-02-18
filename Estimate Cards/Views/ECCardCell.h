//
//  ECCardCell.h
//  Estimate Cards
//
//  Created by Christopher Martin on 2/17/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECCardCell : UICollectionViewCell
@property (nonatomic, copy) NSString *displayValue;

+(NSString*)cellReuseId;
@end
