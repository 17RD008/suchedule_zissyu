//
//  setting.swift
//  Schedule001
//
//  Created by 田村大樹 on 2019/04/29.
//  Copyright © 2019 Tamura Daiki. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift

class setting: UIViewController {
    var numdate:Int = 0//numdate受け取り
    var year:Int = 0//year受け取り
    var semester:String = ""//semeste受け取り
    
    let cons = constant()
    var jugyou_name_del:String?
    let realm = try! Realm()
    
   
    @IBOutlet weak var jugyou_name: UILabel!
    
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var titleLabel: UINavigationItem!//タイトル
    
    //前の画面に戻る
    @IBAction func backButton(_ sender: Any) {
        
        if let controller = self.presentingViewController as? ViewController {
            controller.titleChange()
        }
        if let controller = self.presentingViewController as? saturday {
            controller.titleChange()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //授業を削除する
    @IBAction func deleteButton(_ sender: Any) {
        let alert : UIAlertController = UIAlertController(title: jugyou_name_del, message: "削除してよろしいですか?", preferredStyle: UIAlertController.Style.alert)
        
        let defaultAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action : UIAlertAction!) -> Void in print("OK")
            
            let objs = self.realm.objects(risyuu.self).filter("date_num == %@ AND year == %@ AND semester == %@",self.numdate,self.year,self.semester)
            //if let obj = objs.last {
                try! self.realm.write {
                    self.realm.delete(objs)
                }
                self.dismiss(animated: true, completion: nil)
                if let controller = self.presentingViewController as? ViewController {
                    controller.titleChange()
                }
                if let controller = self.presentingViewController as? saturday {
                    controller.titleChange()
                }
            //}
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func toAdd(_ sender: Any) {
        self.performSegue(withIdentifier: "SettingToScheduleAdd",sender: nil)
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.identifier == "SettingToScheduleAdd") {
			let next = segue.destination as! UINavigationController
			let nextc = next.topViewController as! scheduleAdd
			nextc.year = self.year
			nextc.numdate = self.numdate
			nextc.semester = self.semester
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        jugyou_name.numberOfLines = 0
        // Do any additional setup after loading the view.
        if(numdate < 31 ) {
            titleLabel.title = cons.numToDay(num: numdate,tag:1 )
        }
        else {titleLabel.title = cons.numToDay(num: numdate,tag:2 )}
        
        print("ここにいるよ")
        print(numdate)
        print(year)
        print(semester)
        redraw()
    }
    
    //授業追加画面から戻る時に情報を更新する
    func redraw() {
        jugyou_name.isHidden = true
        deleteButton.isHidden = true
        let objs = realm.objects(risyuu.self).filter("date_num == %@ AND year == %@ AND semester == %@",self.numdate,self.year,self.semester)
        print("履修しているのは")
        print(numdate)
        print(year)
        print("セッティング完了")
        if let obj = objs.last {
            jugyou_name_del = obj.jugyou_name
            jugyou_name.text = obj.jugyou_name
            jugyou_name.isHidden = false
            deleteButton.isHidden = false
            print("きてる？")
        }
    }
}


