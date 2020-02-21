//
//  JwcModel.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/22.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import HandyJSON

struct GradeModel: HandyJSON {
    var xh: String? // 学号
    var xm: String? //姓名
    var kkxq: String? //开课学期
    var kcxzmc: String? //课程性质名称
    var ksxzmc: String? //考试性质名称
    var xq: String?
    var jd: Double? // 绩点
    var cjbsmc: String? // 成绩标示名称
    var zcj: String? //总成绩 A 90
    var kclbmc: String? //课程类别名称
    var zxs: Int? //总学时
    var kcmc: String? //课程名称
    var xf: Double? //学分
}
