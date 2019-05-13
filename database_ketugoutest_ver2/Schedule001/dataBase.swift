//
//  dataBase.swift
//  Schedule001
//
//  Created by 田村大樹 on 2019/05/03.
//  Copyright © 2019 Tamura Daiki. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Teacher : Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
}

class Jugyou : Object {
    @objc dynamic var jugyou_id = ""
    @objc dynamic var jugyou_name = ""
    @objc dynamic var gakunen = 0
    @objc dynamic var jugyou_nendo = 0
    @objc dynamic var teacher_id = ""
    @objc dynamic var hyoukakijun = ""
    @objc dynamic var course = ""
    @objc dynamic var gaiyou = ""
}

class risyuu : Object {
    @objc dynamic var year = 0
    @objc dynamic var semester = ""
    @objc dynamic var date_num = 0
    @objc dynamic var jugyou_name = ""
    @objc dynamic var jugyou_memo = ""
}

class constant {
    
    //タグ番号をString型の曜日+時限に変換する
    func numToDay(num:Int) ->String{
        var msg = ""
        switch num {
        case 1,2,3,4,5: msg = "月曜"
        case 6,7,8,9,10: msg = "火曜"
        case 11,12,13,14,15: msg = "水曜"
        case 16,17,18,19,20: msg = "木曜"
        case 21,22,23,24,25: msg = "金曜"
        default: msg = "null"
        }
        
        switch num%5 {
            
        case 1: msg += "1限"
        case 2: msg += "2限"
        case 3: msg += "3限"
        case 4: msg += "4限"
        case 0: msg += "5限"
        default:msg += "null"
        }
        return msg
    }
}
