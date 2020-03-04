//
//  JwcViewModel.swift
//  MyFirstApp
//
//  Created by 张啸宇 on 2020/2/22.
//  Copyright © 2020 xiaoyuu. All rights reserved.
//

import Foundation
import Regex
import SwiftyJSON
import HandyJSON

class JwcViewModel: NSObject {
    var getGradeBlock: XYBlock?
    var gradeList: [GradeModel?]?
    var studentName: String?
    var studentId: String?
    var gpa: Double?
}

extension JwcViewModel {
    
    func getGPA()  {
        guard gradeList != nil else {
            return
        }
        var creditSum = 0.0
        var sum = 0.0
        for grade in gradeList! {
            if grade!.kclbmc!.contains("选修") && grade!.kcxzmc!.contains("通识教育"){
                continue
            }
            creditSum += grade!.xf!
            sum += grade!.xf! * grade!.jd!
        }
        
        self.gpa =  sum / creditSum
    }
    
    func getGradeList(studentId: String) {
        self.studentId = studentId
        JwcAPIProvider.request(.getStudentGrade(studentId: studentId)) { [weak self] (result) in
            if case let .success(response) = result {
                
                if let data = try? response.mapString() {
                    
                    let greeting = Regex(#"\[\S*\]"#)
                    if let matched = greeting.firstMatch(in: data),  let object = [GradeModel].deserialize(from: JSON(matched.matchedString).description) {
                        self?.gradeList = object
                        self?.studentName = object[0]?.xm
                        self?.getGPA()
                 
                    }
                }
            }
            
            
            self?.getGradeBlock?()
        }
    }
}
