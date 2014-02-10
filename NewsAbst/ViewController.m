//
//  ViewController.m
//  NewsAbst
//
//  Created by 遠藤 豪 on 2014/02/08.
//  Copyright (c) 2014年 endo.news. All rights reserved.
//

#define DispDatabaseLog

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

UIImageView *imvBackground;
CGPoint pntStartDrag;
int noStatus;//現在の状態(どの区切りか)を判別:最初は一番左の状態

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    NSMutableArray *newTutorials = [[NSMutableArray alloc] initWithCapacity:0];
//    for (TFHppleElement *element in tutorialsNodes) {
//        // 5
//        Tutorial *tutorial = [[Tutorial alloc] init];
//        [newTutorials addObject:tutorial];
//        
//        // 6
//        tutorial.title = [[element firstChild] content];
//        
//        // 7
//        tutorial.url = [element objectForKey:@"href"];
//    }
    
    
    
//    @"id",
//    @"datetime",
//    @"blog_id",
//    @"title",
//    @"url",
//    @"body_with_tags",
//    @"body",
//    @"hatebu",
//    @"saveddate",
    
    //表示コンポーネントやデータの初期化等
    
    //背景画像の名称
    NSArray *arrStrBackground =
    [NSArray arrayWithObjects:
     @"aman.png",
     @"bird.png",
     @"building.png",
     @"building2.png",
     @"desk.png",
     @"light.png",
     @"street.png",
     @"sunset.png",
     @"wood.png",
     nil];
    
//    NSMutableArray *arrImvBackground;
//    arrImvBackground = [NSMutableArray array];
    @autoreleasepool {
        UIImageView *imvTmp;
        int _width = [[UIScreen mainScreen] bounds].size.width;
        int _height = [[UIScreen mainScreen] bounds].size.height;
        
        //背景オブジェクト
        imvBackground =
        [[UIImageView alloc]
         initWithFrame:
         CGRectMake(0, 0, _width * [arrStrBackground count], _height)];
        
        //個別背景画像
        for(int i = 0;i < [arrStrBackground count];i++){
            imvTmp = [[UIImageView alloc]initWithImage:[UIImage imageNamed:arrStrBackground[i]]];
            imvTmp.frame = CGRectMake(i * _width, 0, _width, _height);
//            [arrImvBackground addObject:imvTmp];
            [imvBackground addSubview:imvTmp];
        }
        
        
    }//autoreleasepool
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.view addSubview:imvBackground];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //背景やコンポーネントの配置
    
    
    UIPanGestureRecognizer *panGesture;
    panGesture = [[UIPanGestureRecognizer alloc]
                  initWithTarget:self
                  action:@selector(onFlickedFrame:)];
    NSLog(@"onflickedframe");
    [imvBackground addGestureRecognizer:panGesture];
    imvBackground.userInteractionEnabled = YES;
    NSLog(@"imvbackground=%@", imvBackground);
    
    
}


//常に定位置にいるように設定
-(void)onFlickedFrame:(UIPanGestureRecognizer *)gr{
    //画像の枚数
    int numOfImage = imvBackground.bounds.size.width / [UIScreen mainScreen].bounds.size.width;
    
    int frameSize = [UIScreen mainScreen].bounds.size.width;
    
    
    
    
    
    
    //移動幅:コンマ数秒間隔でサンプリングされた際の移動幅(タッチしてからの移動幅ではない)
    CGPoint movingPoint = [gr translationInView:imvBackground];
    //移動後の中心位置
    CGPoint movedPoint = CGPointMake(imvBackground.center.x + movingPoint.x,
                                     imvBackground.center.y);
    
//    NSLog(@"onFlickedFrame : %f, %f", movedPoint.x, movedPoint.y);
    
    
    //画像を一枚毎に定位置に表示する(定位置：各画像の中心が画面の中心となるように)
    //フリック幅がある程度の大きさになったら
//    if(abs(movedPoint.x) > 100){//移動した後の
//        //移動した後の定位置を取得
//        //具体的にはfor文を回して、中心点が各「区切り」の範囲内にあるかどうか判定し、中心点が存在する範囲の中心に画像の中心を設置
//        
//        
//        for(int i = 0 ;i < numOfImage;i++){
//            
//        }
//        
//        //ちがう！：隣の区切りに移動するだけ
//        if(movedPoint.x * -1 < 0){//右移動の場合
//            //右隣の画像を画面の中心に配置
////            imvBackground.center =
////            CGPointMake(現在状態noStatusの定位置に対する右隣定位置の中心に配置, <#CGFloat y#>)
//        }else{//左移動の場合
//            
//        }
//        
//    }else{
        //通常のフリック
        //基準点(screen center)から左側へimvBackground横幅まで移動可能にする
//        if(movedPoint.x - imvBackground.bounds.size.width + [[UIScreen mainScreen] bounds].size.width/2 <= frameSize/2 &&
//           movedPoint.x - imvBackground.bounds.size.width + [[UIScreen mainScreen] bounds].size.width/2 >= frameSize/2 - imvBackground.bounds.size.width){
            //中心位置に表示する
            imvBackground.center = movedPoint;
            [gr setTranslation:CGPointZero inView:imvBackground];
            
//        }

//    }
    
    
    
    if (gr.state == UIGestureRecognizerStateBegan) {
        pntStartDrag = CGPointMake(imvBackground.center.x,
                                   imvBackground.center.y);
        //現在位置の判定
        int xOfRightImageCenter = imvBackground.frame.origin.x + imvBackground.bounds.size.width - frameSize/2;//一番右の画像の中心位置
        for(int i = 0;i < numOfImage;i++){
            if(xOfRightImageCenter >= i * frameSize &&
               xOfRightImageCenter < (i + 1) * frameSize){
                
                noStatus = numOfImage - i - 1;//左の画像(の中心)が見えている状態を０、右隣の画像(中心)が画面上に見えている場合は１、。。。
                //            NSLog(@"nostatus=%d", noStatus);
            }
        }
        NSLog(@"from status = %d", noStatus);
//        NSLog(@"start drag from %f", [gr locationInView:imvBackground].x);
    }else if (gr.state == UIGestureRecognizerStateChanged) {//移動中
//        NSLog(@"dragging : status%d", noStatus);
    }
    // 指が離されたとき、ビューを元に位置に戻して、ラベルの文字列を変更する
    else if (gr.state == UIGestureRecognizerStateEnded) {//指を離した時
        NSLog(@"released : at %f, status%d", [gr locationInView:imvBackground].x, noStatus);
        //移動幅が小さければ元の位置にアニメーションで戻す
        NSLog(@"moving width = %d, start=%f, end=%f",
              abs(pntStartDrag.x - [gr locationInView:imvBackground].x),
              pntStartDrag.x,
              [gr locationInView:imvBackground].x);

        
        if(pntStartDrag.x - imvBackground.center.x > 100){//左にドラッグ
            if(noStatus < numOfImage-1)
                noStatus++;
        }else if(pntStartDrag.x - imvBackground.center.x < -100){
            if(noStatus > 0)
                noStatus--;
        }else{
            //do nothing
        }
        NSLog(@"to status = %d", noStatus);
        [UIView
         animateWithDuration:0.25f
         delay:0.0f
         options:UIViewAnimationOptionCurveEaseIn
         animations:^{
             
             imvBackground.frame =
             CGRectMake(frameSize * -noStatus, 0, imvBackground.bounds.size.width,
                        imvBackground.bounds.size.height);
             NSLog(@"animated to x=%f", (float)frameSize * - noStatus);
         }
         completion:^(BOOL finished){
             
         }];
    }
}

// ドラッグジェスチャー処理２：http://qiita.com/yuch_i/items/f9d6efb8ba165313427c
//- (void)panGesture:(UIPanGestureRecognizer *)sender {
//    // ドラッグ開始
//    if (sender.state == UIGestureRecognizerStateBegan) {
//        _startPt = [sender locationInView:self];
//    }
//    // ドラッグ移動
//    if (sender.state == UIGestureRecognizerStateChanged) {
//        CGPoint pt = [sender locationInView:self];
//        self.contentView.center = CGPointMake(self.frame.size.width / 2 - (_startPt.x - pt.x), self.contentView.center.y);
//    }
//    // ドラッグ移動 or ドラッグ終了
//    if (sender.state == UIGestureRecognizerStateChanged ||
//        sender.state == UIGestureRecognizerStateEnded) {
//        
//        // ドラッグ移動量 閾値判定
//        BOOL changing = (fabs(self.frame.origin.x - self.contentView.frame.origin.x) > 100);
//        
//        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
//                         animations:^{
//                             // セル位置を元に戻す
//                             if (sender.state == UIGestureRecognizerStateEnded) {
//                                 self.contentView.center = CGPointMake(self.frame.size.width / 2, self.contentView.center.y);
//                             }
//                             if (changing) {
//                                 // セル色変更
//                                 if (! self.task.done) {
//                                     self.backgroundColor = [UIColor grayColor];
//                                 } else {
//                                     self.backgroundColor = [UIColor clearColor];
//                                 }
//                                 // 状態を反転
//                                 if (sender.state == UIGestureRecognizerStateEnded) {
//                                     self.task.done = ! self.task.done;
//                                 }
//                             } else {
//                                 // セル色変更
//                                 if (sender.state == UIGestureRecognizerStateChanged) {
//                                     if (! self.task.done) {
//                                         self.backgroundColor = [UIColor clearColor];
//                                     } else {
//                                         self.backgroundColor = [UIColor grayColor];
//                                     }
//                                 }
//                             }
//                         } completion:^(BOOL finished) {
//                         }];
//    }
//}


-(void)getDataFromDB{
    //databasemanageクラスからデータを取得(引数なしだと最大100記事を取得)
    NSArray *array = [DatabaseManage getValueFromDB];//100個取得
    
    NSString *strId = nil;
    NSString *strBody = nil;
    NSString *strSaved = nil;
    NSString *strDate = nil;
    NSDictionary *_dict = nil;
    for(int i = 0;i < [array count];i++){
        _dict = array[i];
        strId = [_dict objectForKey:@"id"];
        strBody = [_dict objectForKey:@"body"];
        strSaved = [_dict objectForKey:@"saveddate"];
        strDate = [_dict objectForKey:@"datetime"];
#ifdef DispDatabaseLog
        NSLog(@"id=%@",strId);
        
        NSLog(@"id=%@",strBody);
        NSLog(@"id=%@",strSaved);
        NSLog(@"id=%@",strDate);
#endif
    }
}


@end
