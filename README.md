# My First App

> 本项目是我在自学 iOS 时的一些练习代码，旨在理解 iOS 开发中的一些基础概念。

## 项目架构

此项目整体采用 MVVM 架构，从 Controller 中分离出 ViewModel 处理业务逻辑，网络请求等。



网络请求使用的是 Moya。



布局大量使用基于 AutoLayout 的 SnapKit，部分使用 frame 布局。



## 部分页面截图

### 通知页面

仿写 PageView

<img src="assets/Simulator Screen Shot - iPhone 8 - 2020-03-08 at 11.56.41.png" style="zoom:67%;" />

### 秀动主页

<img src="assets/showstart-main.png" alt="秀动主页" style="zoom:67%;" />

### 搜索页面

<img src="assets/Simulator Screen Shot - iPhone 8 - 2020-03-08 at 12.07.02.png" alt="搜索页面" style="zoom:67%;" />

### 选择城市页面

使用 Block 传值。

<img src="assets/Simulator Screen Shot - iPhone 8 - 2020-03-08 at 12.07.30.png" style="zoom:67%;" />

### 视频列表页面

AVFoundation

简单地封装了自己的 VideoPlayer，单例。

<img src="assets/Simulator Screen Shot - iPhone 8 - 2020-03-09 at 11.42.24.png" style="zoom:67%;" />