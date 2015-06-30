//
//  BJGameModel.h
//  HW3_BlackJack
//
//  Created by VincentChen on 2015/5/10.
//  Copyright (c) 2015年 VincentChen. All rights reserved.
//


#define BJNotificationGameDidEnd @"BJNotificationGameDidEnd"

typedef enum:int{
    BJGameStagePlayer,
    BJGameStageDealer,
    BJGameStageGameOver
}BJGameStage;

#import "ViewController.h"
#import <Foundation/Foundation.h>
@class BJCard;


@interface BJGameModel : NSObject

@property (nonatomic) BJGameStage gameStage;
@property (nonatomic) int maxPlayerCards;

-(void) resetGame;
-(void) updateGameStage;

-(void) notifyGameDidEnd;
-(void) calculateWinner;
-(int) areCardsBust:(NSMutableArray *)cards;
-(int) calculateBestScore:(NSMutableArray *)cards;

-(BJCard *) nextDealerCard;
-(BJCard *) nextPlayerCard;

-(BJCard *) playerCardAtIndex:(int)index;
-(BJCard *) dealerCardAtIndex:(int)index;
-(BJCard *) lastDealerCard;
-(BJCard *) lastPlayerCard;

-(BJCard *) nextCard;

@end
