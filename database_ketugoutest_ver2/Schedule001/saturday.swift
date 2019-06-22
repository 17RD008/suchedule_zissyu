//
//  saturday.swift
//  Schedule001
//
//  Created by 田村大樹 on 2019/05/26.
//  Copyright © 2019 Tamura Daiki. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import RealmSwift

class saturday:UIViewController  {
    
    var year:Int = 0;
    var semester:String = "";
    var numdate:Int = 0;
    
    var checkButton = UIButton()
    
    @IBOutlet weak var button26: UIButton!
    @IBOutlet weak var button27: UIButton!
    @IBOutlet weak var button28: UIButton!
    @IBOutlet weak var button29: UIButton!
    @IBOutlet weak var button30: UIButton!

	@IBOutlet weak var button31: UIButton!
    @IBOutlet weak var button32: UIButton!
    @IBOutlet weak var button33: UIButton!
    @IBOutlet weak var button34: UIButton!
    @IBOutlet weak var button35: UIButton!
    
    
    @IBAction func backbutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        buttonInit()
        titleChange()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SaturdayToSetting") {
            let next = segue.destination as! setting
            next.numdate = checkButton.tag//sender as? Int
            next.year = self.year
            next.semester = self.semester
        }
    }
    
	@IBAction func button(_ sender: Any) {
        if let button = sender as? UIButton {
            checkButton = button
            self.performSegue(withIdentifier:"SaturdayToSetting",sender: nil)
        }
    }
    //ボタンの設定を準備する
    func buttonPrepare(button:UIButton) {
        let rgba = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        button.backgroundColor = rgba
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5.0
		
		button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
		button.titleLabel?.textAlignment = NSTextAlignment.center
		button.titleLabel?.numberOfLines = 0
    }
    
    //ボタンの初期化関数
    func buttonInit() {
        buttonPrepare(button: button26)
        buttonPrepare(button: button27)
        buttonPrepare(button: button28)
        buttonPrepare(button: button29)
        buttonPrepare(button: button30)
        buttonPrepare(button: button31)
        buttonPrepare(button: button32)
        buttonPrepare(button: button33)
        buttonPrepare(button: button34)
        buttonPrepare(button: button35)
    }
    
    //ボタンのタイトルを変更
    func titleChange() {
        let realm = try! Realm()
        
        for i in 26..<36 {
            let button = btnret(num: i)
            let title_tmp:Int
            if(i%5 == 0) {title_tmp = 5} else {title_tmp = i%5}
            button.setTitle(title_tmp.description, for: .normal)
            let objs = realm.objects(risyuu.self).filter("date_num == %@ AND year == %@ AND semester == %@",i,year,semester)
            if let obj = objs.last {
                if(obj.year == self.year && obj.semester == self.semester) {
                    print(obj)
                    title = obj.jugyou_name
                    button.setTitle(title, for: .normal)
                }
            }
        }
    }
    
    //数字から対応するボタンを返す
    func btnret(num:Int) -> UIButton {
        switch num {
        case 26: return self.button26
        case 27: return self.button27
        case 28: return self.button28
        case 29: return self.button29
        case 30: return self.button30
        case 31: return self.button31
        case 32: return self.button32
        case 33: return self.button33
        case 34: return self.button34
        case 35: return self.button35
        default:
            print("error")
            return button26
        }
    }
}

