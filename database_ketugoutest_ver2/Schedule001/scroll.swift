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
	
	let cons = constant()
	var jugyou_name_del:String?
	@IBOutlet weak var scrollview: UIScrollView!
	
	let realm = try! Realm()
	
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var titlelabel: UINavigationItem!
	@IBOutlet weak var memo: CustomTextview!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		if(numdate < 31 ) {
			titlelabel.title = cons.numToDay(num: numdate,tag:1 )
		}
		else {titlelabel.title = cons.numToDay(num: numdate,tag:2 )}
		
		let objs = realm.objects(risyuu.self).filter("date_num == %@ AND year == %@ AND semester == %@",self.numdate,self.year,self.semester)

		if let obj = objs.last {
			label.text = obj.jugyou_name
		}
	
	}
	
	@IBAction func backbutton(_ sender: Any) {
		if let controller = self.presentingViewController as? ViewController {
			controller.titleChange()
		}
		if let controller = self.presentingViewController as? saturday {
			controller.titleChange()
		}
		self.dismiss(animated: true, completion: nil)
	}
}
