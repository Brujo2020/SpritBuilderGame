//
//  GameScene.m
//  Uno
//
//  Created by Mario Alejandro Ramos on 04-04-15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene
{
__weak CCNode* _levelNode;
__weak CCPhysicsNode* _physicsNode;
__weak CCNode* _playerNode;
    __weak CCNode* _bufaloNode;
__weak CCNode* _backgroundNode;
}

-(void) didLoadFromCCB
{
    
    NSLog(@"_levelNode = %@", _levelNode);
    // enable receiving input events
    self.userInteractionEnabled= YES;    // load the current level
    [self loadLevelNamed:nil];
}

-(void) loadLevelNamed:(NSString*)levelCCB
{
    // get the current level's player in the scene by searching for it recursively
        _playerNode = [self getChildByName:@"player" recursively:YES];
        _bufaloNode = [self getChildByName:@"bufalo" recursively:YES];
   NSAssert1(_playerNode, @"player node not found in level: %@", levelCCB);
     NSAssert1( _bufaloNode, @"player node not found in level: %@", levelCCB);
}



-(void) runBufalo{

    // timelines can be referenced and run by name
    [_bufaloNode.animationManager runAnimationsForSequenceNamed:@"Corre"];
   // [self.animationManager runAnimationsForSequenceNamed:@"outro"];
}

-(void) stopBufalo{
    
    // timelines can be referenced and run by name
    [_bufaloNode.animationManager runAnimationsForSequenceNamed:@"Para"];
    // [self.animationManager runAnimationsForSequenceNamed:@"outro"];
}


- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [_playerNode stopActionByTag:1];
    CGPoint pos = [touch locationInNode:_levelNode];
    CCAction* move = [CCActionMoveTo actionWithDuration:1 position:pos];
    move.tag = 1;
    [_playerNode runAction:move];
}



-(void) backToMenu
{
     NSLog(@"changeScene pressed");
    CCScene* scene = [CCBReader loadAsScene:@"MainScene"];
    CCTransition* transition = [CCTransition transitionFadeWithDuration:0.5];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
}


-(void) scrollToTarget:(CCNode*)target
{
    CGSize viewSize = [CCDirector sharedDirector].viewSize;
    CGPoint viewCenter = CGPointMake(viewSize.width / 2.0, viewSize.height / 2.0);
    CGPoint viewPos = ccpSub(target.positionInPoints, viewCenter);
    CGSize levelSize = _levelNode.contentSizeInPoints;
    viewPos.x = MAX(0.0, MIN(viewPos.x, levelSize.width - viewSize.width));
    viewPos.y = MAX(0.0, MIN(viewPos.y, levelSize.height - viewSize.height));
    _levelNode.positionInPoints = ccpNeg(viewPos);
}

-(void) update:(CCTime)delta
{
    // update scroll node position to player node, with offset to center player in the view
    [self scrollToTarget:_playerNode];
}
@end

