#import "MainScene.h"

@implementation MainScene

-(void) changeScene
{
    NSLog(@"Back to menu");
    CCScene* scene = [CCBReader loadAsScene:@"GameScene"];
    CCTransition* transition = [CCTransition transitionFadeWithDuration:0.6];
    [[CCDirector sharedDirector] presentScene:scene withTransition:transition];
}
@end
