//
//  scheduleAdd.swift
//  Schedule001
//
//  Created by 田村大樹 on 2019/04/30.
//  Copyright © 2019 Tamura Daiki. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift

class scheduleAdd: FormViewController{

    var numdate:Int?
    var year:Int?
    var semester:String?
    var class_title:String?
    var class_memo:String?
    var course_name:String?
    
    let risyuu_touroku = risyuu()
    
    //授業設定画面に戻る
    @IBAction func backButton(_ sender: Any) {
        if let controller = self.presentingViewController as? setting {
            controller.redraw()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //遷移前のストーリーボードから値を取得、授業をデータベースに登録
    @IBAction func addButton(_ sender: Any) {
        if let controller = self.presentingViewController as? setting {
            print("ここに")
            self.numdate = controller.numdate
            self.year = controller.year
            self.semester = controller.semester
        }
        
        if(class_title == nil) {
            return;
        }

        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        risyuu_touroku.date_num = numdate!
        risyuu_touroku.year = year!
        risyuu_touroku.semester = semester!
        risyuu_touroku.jugyou_name = class_title!
        if(class_memo != nil) {
            risyuu_touroku.jugyou_memo = class_memo!
        }
        if(course_name != nil) {
            risyuu_touroku.course_name = course_name!
        }
        
        
        try! realm.write() {
            realm.add(risyuu_touroku)
        }
        
        if let controller = self.presentingViewController as? setting {
            controller.redraw()
        }
        self.dismiss(animated: true, completion: nil)
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        form
            +++ Section("授業登録/変更")
            <<< TextRow { ret in
                ret.title = "授業名"
                ret.placeholder = "タイトルを入力"
                }.onChange{ ret in
                    self.class_title = ret.value
                    //print(memovalue!)
            }
            <<< TextAreaRow { row in
                row.title = "メモ"
                row.placeholder = "メモを入力"
                }.onChange{ row in
                    self.class_memo = row.value
                    //print(memovalue!)
            }
            +++ Section("コース")
            <<< PickerInlineRow<String>() { row in
                row.title = "コース"
                row.options = ["コンピュータソフトウェア","ネットワークシステム","アミューズメントデザイン",
                "社会コミュニケーション","コンピュータサイエンス"]
                row.value = row.options.first
                }.onChange { row in
                    self.course_name = row.value
            }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
