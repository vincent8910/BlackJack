//
//  BJCard.m
//  HW3_BlackJack
//
//  Created by VincentChen on 2015/5/10.
//  Copyright (c) 2015年 VincentChen. All rights reserved.
//

#import "BJCard.h"

@implementation BJCard
-(BOOL) isAnAce
{
    if(self.digit == 1)return YES;
    return NO;
}

-(BOOL) isAFaceOrTenCard
{
    if(self.digit>9)return YES;
    return NO;
}

-(UIImage *)getCardImage
{
    NSString *suit;
    switch (self.suit){
        case BJCardSuitClub:
            suit = @"club";
            break;
        case BJCardSuitSpade:
            suit = @"spade";
            break;
        case BJCardSuitDiamond:
            suit = @"diamond";
            break;
        case BJCardSuitHeart:
            suit = @"heart";
            break;
            
    }
    
    NSString *filename = [NSString stringWithFormat:@"%@-%d.png",suit,self.digit];
    return [UIImage imageNamed:filename];
}

+(NSMutableArray *) generateAPackOfCards{
    NSMutableArray *arr = [NSMutableArray array];
    BJCard *card;
    int suit,digit;
    for (suit=0;suit<4;suit++){
        for(digit=1;digit<=13;digit++){
            card = [[BJCard alloc] init];
            card.suit=suit;
            card.digit=digit;
            [arr addObject:card];
        }
    }
    
    return arr;
}

@end
