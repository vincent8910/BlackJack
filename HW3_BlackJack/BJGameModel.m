//
//  BJGameModel.m
//  HW3_BlackJack
//
//  Created by VincentChen on 2015/5/10.
//  Copyright (c) 2015年 VincentChen. All rights reserved.
//

#import "BJGameModel.h"
#import "BJCard.h"
#import "NSMutableArray+Shuffle.h"

@interface BJGameModel()
@property (nonatomic,strong) NSMutableArray *cards;
@property (nonatomic,strong) NSMutableArray *playerCards;
@property (nonatomic,strong) NSMutableArray *dealerCards;
@property (readwrite) BOOL didDealerWin;

@end


@implementation BJGameModel

-(id) init
{
    self = [super init];
    if (self) {
        self.maxPlayerCards = 5;
        [self resetGame];
    }
    
    return self;
}

-(void) resetGame
{
    self.cards = [BJCard generateAPackOfCards];
    [self.cards shuffle];
    
    self.playerCards = [NSMutableArray array];
    self.dealerCards = [NSMutableArray array];
    self.gameStage = BJGameStagePlayer;
}

-(void) updateGameStage
{
    if (self.gameStage == BJGameStagePlayer) {
        if ([self areCardsBust:self.playerCards]) {
            self.gameStage = BJGameStageGameOver;
            self.didDealerWin = YES;
            [self notifyGameDidEnd];
        }else if ([self.playerCards count] == self.maxPlayerCards) {
            self.gameStage = BJGameStageDealer;
        }
    }else if (self.gameStage == BJGameStageDealer) {
        //check if we're done now?
        if ([self areCardsBust:self.dealerCards]) {
            self.gameStage = BJGameStageGameOver;
            self.didDealerWin = NO;
            [self notifyGameDidEnd];
        }else if ([self.dealerCards count] == self.maxPlayerCards) {
            self.gameStage = BJGameStageGameOver;
            [self calculateWinner];
            [self notifyGameDidEnd];
        }else {
            //should the dealer stop, has he won?
            int dealerScore = [self calculateBestScore:self.dealerCards];
            if (dealerScore < 17) {
                //keep playing, dealer can't stand on less than 17
            }else {
                int playerScore = [self calculateBestScore:self.playerCards];
                if (playerScore > dealerScore) {
                    
                    //dealer must play again as he's not equal or better to the player's score
                    //keep playing, dealer will play another card
                }else {
                    //dealer has equalled or beaten the player so the game is over
                    self.didDealerWin = YES;
                    self.gameStage = BJGameStageGameOver;
                    [self notifyGameDidEnd];
                }
            }
        }
    }
}

-(void) notifyGameDidEnd
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    NSNumber *didDealerWin = @(self.didDealerWin);
    NSDictionary *dict = @{@"didDealerWin":didDealerWin};
    [notificationCenter postNotificationName:BJNotificationGameDidEnd object:self userInfo:dict];
}

-(void) calculateWinner
{
    int dealerScore = [self calculateBestScore:self.dealerCards];
    int playerScore = [self calculateBestScore:self.playerCards];
    if (playerScore > dealerScore){
        self.didDealerWin = NO;
    }else{
        self.didDealerWin = YES;
    }
}

-(int) areCardsBust:(NSMutableArray *)cards
{
    BJCard *card;
    int lowestScore = 0;
    int maxLoop = (int) [cards count];
    for(int i = 0; i < maxLoop ; i++){
        card = cards[i];
        if(card.isAnAce){
            lowestScore +=1;
        }else if (card.isAFaceOrTenCard){
            lowestScore +=10;
        }else{
            lowestScore += card.digit;
        }
    }
    if(lowestScore > 21)return YES;
    return NO;
}

-(int) calculateBestScore:(NSMutableArray *)cards
{
    if([self areCardsBust:cards]){
        return 0;
    }
    BJCard *card;
    int highestScore =0;
    int maxLoop = (int)[cards count];
    for(int i = 0; i < maxLoop ; i++){
        card = cards[i];
        if(card.isAnAce){
            highestScore +=11;
        }else if(card.isAFaceOrTenCard){
            highestScore +=10;
        }else{
            highestScore += card.digit;
        }
    }
    while(highestScore > 21){
        highestScore -=10;
    }
    return highestScore;
}

-(BJCard *) nextDealerCard
{
    BJCard *card = [self nextCard];
    [self.dealerCards addObject:card];
    
    return card;
}
-(BJCard *) nextPlayerCard
{
    BJCard *card = [self nextCard];
    [self.playerCards addObject:card];
    
    return card;
}

-(BJCard *) playerCardAtIndex:(int)index
{
    if (index < [self.playerCards count]){
        return self.playerCards[index];
    }
    return nil;
}

-(BJCard *) dealerCardAtIndex:(int)index
{
    if (index < [self.dealerCards count]){
        return self.dealerCards[index];
    }
    return nil;
}

-(BJCard *) lastDealerCard
{
    if ([self.dealerCards count] >0) return [self.dealerCards lastObject];
    return nil;
}

-(BJCard *) lastPlayerCard
{
    if ([self.playerCards count] >0) return [self.playerCards lastObject];
    return nil;
}

-(BJCard *)nextCard
{
    BJCard *card = self.cards[0];
    [self.cards removeObjectAtIndex:0];
    return card;
}

@end
