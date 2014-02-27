//
//  ECDeckViewController.m
//  Estimate Cards
//
//  Created by Christopher Martin on 2/17/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

//view controllers
#import "ECDeckViewController.h"
#import "ECBigCardViewController.h"

//cells
#import "ECCardCell.h"

//animations
#import "ECZoomTransition.h"

@interface ECDeckViewController ()  <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) NSArray *cards;
@property (nonatomic) CGRect transitionStartRect;
@end

@implementation ECDeckViewController

@synthesize transitionStartRect = _transitionStartRect;

- (CGRect)transitionStartRect {
  if (!_transitionStartRect.size.width || !_transitionStartRect.size.height) {
    _transitionStartRect = CGRectMake(0, 0, 40, 40);
  }
  return _transitionStartRect;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"ECCardCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:[ECCardCell cellReuseId]];
    
    self.cards = @[@"2", @"4", @"8", @"??"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cards.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ECCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ECCardCell cellReuseId] forIndexPath:indexPath];
    
    [cell setDisplayValue:self.cards[indexPath.item]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"User tapped card %@", self.cards[indexPath.item]);
  
  UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
  self.transitionStartRect = cell.frame;
  
  
    ECBigCardViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BigCardViewController"];
    
    vc.transitioningDelegate = self;
    vc.cards = self.cards;
    vc.pathToView = indexPath;
    
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
 sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(150, 266.5);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5.0, 5.0, 1.0, 5.0);
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source{
  
//    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:nil];
    return [[ECZoomTransition alloc] initWithZoomMode:ECZoomModeIn startRect:self.transitionStartRect];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return nil; //no custom dismissal yet
}

#pragma mark - Touch Stuff
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    self.lastTouchLocation = [[touches anyObject] locationInView:self.view];
//}
@end
