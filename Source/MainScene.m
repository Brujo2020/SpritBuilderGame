#import "MainScene.h"

@implementation MainScene

-(void) changeScene
{
    NSLog(@"go to gameScene");
    CCScene* scene = [CCBReader loadAsScene:@"GameScene"];
    CCTransition* transition = [CCTransition transitionRevealWithDirection:CCTransitionDirectionLeft duration:0.1f];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
}
@end
