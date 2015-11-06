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

@property(nonatomic,assign) int index;  //照片的索引

@property(nonatomic,strong) NSArray *imageList;  //存放照片信息的数组

//UIImageView是用来加载图片的控件，父类为UIView，UIImage是图片，父类是NSObject




@end

@implementation ViewController

/*懒加载，通过getter实现
 效果：让对象在最需要的时候才出现，解决代码前后顺序依赖问题
 */


//重写了imagelist的get方法，在第一次调用该属性的时候，才开始实例化该属性，如果已经实例化过，则直接跳出

-(NSArray *)imageList
{
    NSLog(@"读取图像信息");
    if (_imageList==nil) {
        NSLog(@"实例化图像数组");
        
        //获取plist的文件路径,bundle是一个目录，mainBundle是编辑安装之后程序包的目录
        //“包” bundle 程序名.app的目录

        NSString *path=[[NSBundle mainBundle] pathForResource:@"ImageList" ofType:@"plist"];
        NSLog(@"%@",path);  //输出文件路径
        
        //在OC中ContentsOfFile通常需要完整的路径
        //目前的plist是本地的数据，该方法可以通过网络获取数据
        _imageList=[NSArray arrayWithContentsOfFile:path];  //用plist文件的路径去初始化该数组
        NSLog(@"%@",_imageList);
        
//        NSDictionary *dic1=@{@"name":@"biaoqingdi",@"desc":@"表情帝1"};
//        NSDictionary *dic2=@{@"name":@"bingli",@"desc":@"病历"};
//        NSDictionary *dic3=@{@"name":@"chiniupa",@"desc":@"吃牛扒"};
//        NSDictionary *dic4=@{@"name":@"danteng",@"desc":@"蛋疼"};
//        NSDictionary *dic5=@{@"name":@"wangba",@"desc":@"王八"};
        
        
       // _imageList=@[dic1,dic2,dic3,dic4,dic5];

    }
    return _imageList;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1、设置nolabel
    self.noLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width,40 )];
    //设置label的frame
  //  self.noLabel.text=@"1/5";//设置text内容
    self.noLabel.textAlignment=NSTextAlignmentCenter;   //设置text居中
    self.noLabel.backgroundColor=[UIColor whiteColor];    //设置背景颜色为白色
    [self.view addSubview:self.noLabel];//加到界面上
    
    
    //2、设置图片控件
    CGFloat imageW=200;  //设置图片宽度
    CGFloat imageH=200;  //设置图片高度
    CGFloat imageX=(self.view.frame.size.width-imageW)*0.5;  //通过frame获取image的居中位置X
    CGFloat imageY=CGRectGetMaxY(self.noLabel.frame)+20;  //通过上面的label获取image的最大Y，再往下下一点
    self.iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    
    //self.iconImage.image=[UIImage imageNamed:@"biaoqingdi"];  //用imagenamed找到相应的image
    
    
    
    [self.view addSubview:self.iconImage];
    
    
    //3、描述文字
    CGFloat descX=imageX;//与图片的X相同
    CGFloat descY= CGRectGetMaxY(self.iconImage.frame)+20;//比图片的最大Y低20
    CGFloat descW=imageW;
    CGFloat descH=100;
    
    self.descLabel=[[UILabel alloc]initWithFrame:CGRectMake(descX, descY, descW, descH)];//设置desc的frame
    self.descLabel.textAlignment=NSTextAlignmentCenter;//设置文字居中
    
    //需要Label具有足够的高度，不限制文本的行数,0表示不限制行数，即自动换行
    //默认的numberoflines是一行
    self.descLabel.numberOfLines=0;
    
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
    
    self.leftBtn.tag=0; //设置左边button的tag为0
    
    [self.view addSubview:self.leftBtn];
    
    [self.leftBtn addTarget:self action:@selector(clickbutton: )forControlEvents:UIControlEventTouchUpInside];
    //@selector()中只需要写方法名，无需写参数
    

    
    
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
    
    self.leftBtn.tag=1; //设置右边button的tag为1
    
    [self.view addSubview:self.rightBtn];
    
    [self.rightBtn addTarget:self action:@selector(clickbutton:) forControlEvents:UIControlEventTouchUpInside];    //建立连线。addTarget-给button添加事件
    

    
    
    //5、定义照片字典与数组
//        NSDictionary *dic1=@{@"name":@"biaoqingdi",@"desc":@"表情帝1"};
//        NSDictionary *dic2=@{@"name":@"bingli",@"desc":@"病历"};
//        NSDictionary *dic3=@{@"name":@"chiniupa",@"desc":@"吃牛扒"};
//        NSDictionary *dic4=@{@"name":@"danteng",@"desc":@"蛋疼"};
//        NSDictionary *dic5=@{@"name":@"wangba",@"desc":@"王八"};
//        self.imageList=@[dic1,dic2,dic3,dic4,dic5];
    
        [self showPhoto];   //一开始显示照片信息
        //代码的先后顺序存在依赖，如果该句在字典前面，则一开始不显示图片，使用懒加载解决
    
}



//=====VERSION 2.0


//将左右photo集成为clickbutton共同处理
-(void)clickbutton:(UIButton *)button
{
    
    (button.tag==0)?self.index++:self.index--;
    [self showPhoto];
    
}


-(void)showPhoto
{

    //设置序号
    self.noLabel.text=[NSString stringWithFormat:@"%d/5",self.index+1];
    
    //设置序号
//    效率太低，每次调用都要创建和删除字典和数组
//    如何解决？定义property
//    NSDictionary *dic1=@{@"name":@"biaoqingdi",@"desc":@"表情帝1"};
//    NSDictionary *dic2=@{@"name":@"bingli",@"desc":@"病历"};
//    NSDictionary *dic3=@{@"name":@"chiniupa",@"desc":@"吃牛扒"};
//    NSDictionary *dic4=@{@"name":@"danteng",@"desc":@"蛋疼"};
//    NSDictionary *dic5=@{@"name":@"wangba",@"desc":@"王八"};
//    
//    NSArray *array=@[dic1,dic2,dic3,dic4,dic5];
    
    //设置图片和描述，用数组取代switch
    
    self.iconImage.image=[UIImage imageNamed:self.imageList[self.index][@"name"]];//用array中第index个元素的name取出图片名称
    self.descLabel.text=self.imageList[self.index][@"desc"];
    
    
    //控制按钮状态2
    self.rightBtn.enabled=(self.index!=4);
    self.leftBtn.enabled=(self.index!=0);
}





@end
