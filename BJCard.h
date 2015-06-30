//
//  BJCard.h
//  HW3_BlackJack
//
//  Created by VincentChen on 2015/5/10.
//  Copyright (c) 2015年 VincentChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ViewController.h"

typedef enum : int
{
    BJCardSuitClub =0,
    BJCardSuitSpade,
    BJCardSuitDiamond,
    BJCardSuitHeart
}BJCardSuit;

@interface BJCard : NSObject
@property (nonatomic) BJCardSuit suit;
@property (nonatomic) int digit;
@property (nonatomic) BOOL isFaceUp;

-(BOOL) isAnAce;
-(BOOL) isAFaceOrTenCard;

-(UIImage *)getCardImage;

+(NSMutableArray *) generateAPackOfCards;

@end
