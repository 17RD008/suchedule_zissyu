//
//  classMemo.swift
//  Schedule001
//
//  Created by 田村大樹 on 2019/06/23.
//  Copyright © 2019 Tamura Daiki. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class classMemo: UIViewController,UITableViewDataSource,UITableViewDelegate {
	
	@IBOutlet weak var tableview: UITableView!
	
	var memolist: Results<memo>!
	
	var numdate:Int = 0//numdate受け取り
	var year:Int = 0//year受け取り
	var semester:String = ""//semeste受け取り
	var num_of_class = 0
	var jugyou_name = ""
	var time:Double?
	
	@IBAction func buckbutton(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
	@IBAction func addbutton(_ sender: Any) {
		self.performSegue(withIdentifier: "memoTomemoField",sender: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let realm = try! Realm()
		self.memolist = realm.objects(memo.self).filter("date_num == %@ AND year == %@ AND semester == %@AND number_times = %@"  ,self.numdate,self.year,self.semester,self.num_of_class)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return memolist.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
		cell.textLabel!.text = memolist[indexPath.row].memo
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.identifier == "memoTomemoField") {
			let next = segue.destination as! memoField
			next.numdate = self.numdate
			next.year = self.year
			next.semester = self.semester
			next.num_of_class = self.num_of_class
			next.jugyou_name = self.jugyou_name
			
			if(time != nil)  {
				next.temptime = self.time
			}
		}
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if(editingStyle == UITableViewCell.EditingStyle.delete) {
			do{
				let realm = try Realm()
				try! realm.write {
					realm.delete(self.memolist[indexPath.row])
				}
				tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
			}catch{
			}
			tableView.reloadData()
		}
	}
	
	func reload(){
		self.tableview.reloadData()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		self.time = memolist[indexPath.row].time
		self.performSegue(withIdentifier: "memoTomemoField",sender: nil)
	}	
}



