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
	var realmFlag = false//上書きするかどうかのフラグ
	var temptime:Double?

	@IBOutlet weak var memoLabel: UITextView!
	@IBAction func backbutton(_ sender: Any) {
		
		let realm = try! Realm()
		
		if(!realmFlag) {
			let memo1 = memo()
			memo1.memo = memoLabel.text
			memo1.date_num = self.numdate
			memo1.jugyou_name = self.jugyou_name
			memo1.year = self.year
			memo1.semester = self.semester
			memo1.number_times = self.num_of_class
			memo1.time = Double(time(nil))
			try! realm.write {
				realm.add(memo1)
			}
		} else {
			let objs = realm.objects(memo.self).filter("date_num == %@ AND year == %@ AND semester == %@ AND jugyou_name = %@ AND number_times = %@ AND time = %@"  ,self.numdate,self.year,self.semester,self.jugyou_name,self.num_of_class,self.temptime!)
			if let obj = objs.last {
				try! realm.write {
					obj.memo = memoLabel.text
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
	
		if(temptime != nil) {
			realmFlag = true
			let objs = realm.objects(memo.self).filter("date_num == %@ AND year == %@ AND semester == %@ AND jugyou_name = %@ AND number_times = %@ AND time = %@"  ,self.numdate,self.year,self.semester,self.jugyou_name,self.num_of_class,self.temptime!)
			if let obj = objs.last {
				memoLabel.text = obj.memo
			}
		}
		
	}
}
