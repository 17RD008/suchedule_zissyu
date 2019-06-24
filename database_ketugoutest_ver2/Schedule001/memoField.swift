//
//  memoField.swift
//  Schedule001
//
//  Created by 田村大樹 on 2019/06/23.
//  Copyright © 2019 Tamura Daiki. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class memoField: UIViewController {
	var numdate:Int = 0//numdate受け取り
	var year:Int = 0//year受け取り
	var semester:String = ""//semeste受け取り
	var jugyou_name = ""
	var num_of_class = 0
	var overwriteFlag = false//上書きするかどうかのフラグ
	var temp_make_time:Double?
	var timeString = ""
	var tempMemo = ""

	@IBOutlet weak var memoLabel: UITextView!
	@IBAction func backbutton(_ sender: Any) {
		
		let realm = try! Realm()
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		let date = Date()
		timeString = dateFormatter.string(from: date)
		
		if(!overwriteFlag) {//上書きフラグが立っていないとき追加
			let memo1 = memo()
			memo1.memo = memoLabel.text
			memo1.date_num = self.numdate
			memo1.jugyou_name = self.jugyou_name
			memo1.year = self.year
			memo1.semester = self.semester
			memo1.number_times = self.num_of_class
			memo1.timeString = self.timeString
			memo1.make_time = Double(time(nil))
			memo1.last_chenge_time = Double(time(nil))
			
			try! realm.write {
				realm.add(memo1)
			}
		} else {
			let objs = realm.objects(memo.self).filter("date_num == %@ AND year == %@ AND semester == %@ AND jugyou_name = %@ AND number_times = %@ AND make_time = %@"  ,self.numdate,self.year,self.semester,self.jugyou_name,self.num_of_class,self.temp_make_time!)
			if let obj = objs.last {
				try! realm.write {
					obj.memo = memoLabel.text
					if(obj.memo != tempMemo) {
						obj.timeString = self.timeString
						obj.last_chenge_time = Double(time(nil))
					}
				}
			}
		}
		
		if let controller = self.presentingViewController as? classMemo {
			controller.reload()
		}
		self.dismiss(animated: true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let realm = try! Realm()
	
		if(overwriteFlag) {//遷移前に上書きフラグを立てているとき
			let objs = realm.objects(memo.self).filter("date_num == %@ AND year == %@ AND semester == %@ AND jugyou_name = %@ AND number_times = %@ AND make_time = %@"  ,self.numdate,self.year,self.semester,self.jugyou_name,self.num_of_class,self.temp_make_time!)
			if let obj = objs.last {
				memoLabel.text = obj.memo
				tempMemo = obj.memo
			}
		}
	}
}
