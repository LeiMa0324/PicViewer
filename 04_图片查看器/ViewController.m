//
//  ViewController.m
//  04_图片查看器
//
//  Created by APPLE on 15/11/4.
//  Copyright (c) 2015年 big nerd ranch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/*用纯代码开发的过程
 1、确定界面元素，要有什么内容
 2、用代码搭建界面
 3、编写代码
 */

@property(nonatomic,strong) UILabel *noLabel ;  //图片序号label
@property(nonatomic,strong) UIImageView *iconImage; //图片控件
@property (nonatomic,strong) UIButton *leftBtn; //向左的button
@property(nonatomic,strong) UIButton *rightBtn; //向右的button
@property(nonatomic,strong) UILabel *descLabel; //图片描述的label

//UIImageView是用来加载图片的控件，父类为UIView，UIImage是图片，父类是NSObject




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1、设置nolabel
    self.noLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width,40 )];
    //设置label的frame
    self.noLabel.text=@"1/5";//设置text内容
    self.noLabel.textAlignment=NSTextAlignmentCenter;   //设置text居中
    self.noLabel.backgroundColor=[UIColor whiteColor];    //设置背景颜色为白色
    [self.view addSubview:self.noLabel];//加到界面上
    
    
    //2、设置图片控件
    CGFloat imageW=200;  //设置图片宽度
    CGFloat imageH=200;  //设置图片高度
    CGFloat imageX=(self.view.frame.size.width-imageW)*0.5;  //通过frame获取image的居中位置X
    CGFloat imageY=CGRectGetMaxY(self.noLabel.frame)+20;  //通过上面的label获取image的最大Y，再往下下一点
    self.iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    
    self.iconImage.image=[UIImage imageNamed:@"biaoqingdi"];  //用imagenamed找到相应的image
    
    
    
    [self.view addSubview:self.iconImage];
    
    
    //3、描述文字
    CGFloat descX=imageX;//与图片的X相同
    CGFloat descY= CGRectGetMaxY(self.iconImage.frame)+20;//比图片的最大Y低20
    CGFloat descW=imageW;
    CGFloat descH=100;
    
    self.descLabel=[[UILabel alloc]initWithFrame:CGRectMake(descX, descY, descW, descH)];//设置desc的frame
    self.descLabel.text=@"你瞅啥";//设置desc的文字
    self.descLabel.textAlignment=NSTextAlignmentCenter;//设置文字居中
    
    [self.view addSubview:self.descLabel];
    
    
    //4、设置向左的button
    CGFloat leftW=30;
    CGFloat leftH=30;
    CGFloat leftX=self.iconImage.frame.origin.x*0.5-leftW*0.5; //左边button的中心位置在左边空白的中间
    CGFloat leftY=self.iconImage.center.y;  //左边的button的Y在image的中心位置

    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(leftX, leftY, leftW, leftH)];//设置leftbutton的frame
    
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"left_normal"] forState:UIControlStateNormal];
    //设置正常情况下的background图片
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"left_highlighted"] forState:UIControlStateHighlighted ];
    //设置高亮情况下的background图片
    
    [self.view addSubview:self.leftBtn];
    
    
    //4、设置向右的button
    CGFloat rightW=30;
    CGFloat rightH=30;
    CGFloat rightX=self.view.frame.size.width-2*leftX; //右边button的中心位置在右边空白的中间
    CGFloat rightY=self.iconImage.center.y;  //左边的button的Y在image的中心位置
    
    self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(rightX, rightY, rightW, rightH)];//设置rightbutton的frame
    
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateNormal];
    //设置正常情况下的background图片
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"right_highlighted"] forState:UIControlStateHighlighted ];
    //设置高亮情况下的background图片
    
    [self.view addSubview:self.rightBtn];
    
}



@end
