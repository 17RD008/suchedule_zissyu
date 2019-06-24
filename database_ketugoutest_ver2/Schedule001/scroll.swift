//
//  scroll.swift
//  Schedule001
//
//  Created by 田村大樹 on 2019/06/22.
//  Copyright © 2019 Tamura Daiki. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import RealmSwift

class scroll:UIViewController {
	var numdate:Int = 0//numdate受け取り
	var year:Int = 0//year受け取り
	var semester:String = ""//semeste受け取り
	var creditString:String?
	var jugyou_name = ""
	
	let cons = constant()
	var jugyou_name_del:String?
	@IBOutlet weak var scrollview: UIScrollView!
	var checkbutton = UIButton()
	
	let realm = try! Realm()
	
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var titlelabel: UINavigationItem!
	@IBOutlet weak var memoLabel: CustomTextview!
	@IBOutlet weak var jugyoubunrui: CustomLabel!
	@IBOutlet weak var credit: CustomLabel!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()

		if(numdate < 31 ) {
			titlelabel.title = cons.numToDay(num: numdate,tag:1 )
		}
		else {titlelabel.title = cons.numToDay(num: numdate,tag:2 )}
		
		let objs = realm.objects(risyuu.self).filter("date_num == %@ AND year == %@ AND semester == %@",self.numdate,self.year,self.semester)

		if let obj = objs.last {
			jugyou_name = obj.jugyou_name
			label.text = obj.jugyou_name
			jugyoubunrui.text = obj.course_name
			creditString = obj.credit.description
			creditString?.append("単位")
			credit.text = creditString
			if(obj.jugyou_memo != "") {
				memoLabel.text = obj.jugyou_memo
			}
		}
	}
	
	@IBAction func button(_ sender: Any) {
		if let button = sender as? UIButton {
			print(button.tag)
		
		let alert : UIAlertController = UIAlertController(title: "choice", message: "どちらに移行しますか", preferredStyle: UIAlertController.Style.alert)
		
		let photoAction : UIAlertAction = UIAlertAction(title: "写真", style: UIAlertAction.Style.default, handler: {(action : UIAlertAction!) -> Void in
			print("写真")
			
		})
		
		let memoAction: UIAlertAction = UIAlertAction(title: "メモ", style: UIAlertAction.Style.default, handler:{
			(action: UIAlertAction!) -> Void in
			self.checkbutton = button
			self.performSegue(withIdentifier: "scrollToclassMemo",sender: nil)
		})
		
		let cancelAction : UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {(action : UIAlertAction!) -> Void in print("キャンセル")
			
			if let controller = self.presentingViewController as? saturday {
				controller.titleChange()
			}
		})
		
		alert.addAction(photoAction)
		alert.addAction(cancelAction)
		alert.addAction(memoAction)
		
		present(alert, animated: true, completion: nil)
		}
	}
	
	
	@IBAction func backbutton(_ sender: Any) {
		let objs = realm.objects(risyuu.self).filter("date_num == %@ AND year == %@ AND semester == %@",self.numdate,self.year,self.semester)
		if let obj = objs.last {
			try! realm.write {
				obj.jugyou_memo = memoLabel.text
			}
		}
		
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func deletebutton(_ sender: Any) {
		let alert : UIAlertController = UIAlertController(title: jugyou_name_del, message: "削除してよろしいですか?", preferredStyle: UIAlertController.Style.alert)
		
		let defaultAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action : UIAlertAction!) -> Void in print("OK")
			
			let objs = self.realm.objects(risyuu.self).filter("date_num == %@ AND year == %@ AND semester == %@",self.numdate,self.year,self.semester)
			
			if objs.last != nil {
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
			}
			
			let objs2 = self.realm.objects(memo.self).filter("date_num == %@ AND year == %@ AND semester == %@ AND jugyou_name = %@",self.numdate,self.year,self.semester,self.jugyou_name)
			if objs2.last != nil {
				try! self.realm.write {
					self.realm.delete(objs2)
				}
			}
		})
		let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
			(action: UIAlertAction!) -> Void in
			print("Cancel")
		})
		
		alert.addAction(cancelAction)
		alert.addAction(defaultAction)
		
		present(alert, animated: true, completion: nil)
	}
	
	@IBAction func toSetting(_ sender: Any) {
		self.performSegue(withIdentifier: "scrollTosuchduleadd",sender: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.identifier == "scrollToclassMemo") {
			let next = segue.destination as! classMemo
			next.numdate = self.numdate
			next.year = self.year
			next.semester = self.semester
			next.num_of_class = checkbutton.tag
			next.jugyou_name = self.jugyou_name
		}
		if(segue.identifier == "scrollTosuchduleadd") {
			let objs = self.realm.objects(risyuu.self).filter("date_num == %@ AND year == %@ AND semester == %@ AND jugyou_name = %@",self.numdate,self.year,self.semester,self.jugyou_name)
			if let obj = objs.last {
				print("scroll")
				print(obj)
				let next = segue.destination as! UINavigationController
				let nextc = next.topViewController as! scheduleAdd
				nextc.numdate = obj.date_num
				nextc.year = obj.year
				nextc.semester = obj.semester
				nextc.defaultjugyou_name = obj.jugyou_name
				nextc.defaultmemo = obj.jugyou_memo
				nextc.defaultcredit = obj.credit
				nextc.defaultcourse = obj.course_name
			}			
		}
		
	}
	
}
