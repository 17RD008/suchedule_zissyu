//
//  ViewController.swift
//  Schedule001
//
//  Created by 田村大樹 on 2019/04/24.
//  Copyright © 2019 Tamura Daiki. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    @IBOutlet weak var label1: UITextField!
    @IBOutlet weak var label2: UITextField!
    @IBOutlet weak var label3: UITextField!
    @IBOutlet weak var label4: UITextField!
    @IBOutlet weak var label5: UITextField!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!
    @IBOutlet weak var button16: UIButton!
    @IBOutlet weak var button17: UIButton!
    @IBOutlet weak var button18: UIButton!
    @IBOutlet weak var button19: UIButton!
    @IBOutlet weak var button20: UIButton!
    @IBOutlet weak var button21: UIButton!
    @IBOutlet weak var button22: UIButton!
    @IBOutlet weak var button23: UIButton!
    @IBOutlet weak var button24: UIButton!
    @IBOutlet weak var button25: UIButton!
    
    @IBOutlet weak var yearLabel: UITextField!
    
    @IBOutlet weak var profile: UIButton!
    
    let myUIPicker = UIPickerView()
    let list = ["2019前期","2019後期"]
    
    var year:Int = 2019
    var semester : String = "前期"
    
    var checkButton = UIButton()
    
    //設定画面に移動
    @IBAction func button(_ sender: Any) {
        if let button = sender as? UIButton {
			
			checkButton = button
			let realm = try! Realm()
			let objs = realm.objects(risyuu.self).filter("date_num == %@",button.tag)
			if let obj = objs.last {
				self.performSegue(withIdentifier: "MainToScroll",sender: nil)//授業が設定されているときは閲覧
			}else{
				self.performSegue(withIdentifier: "MainToSetting",sender: nil)//授業が設定されていないときは設定
			}
			
            //self.performSegue(withIdentifier: "MainToSetting",sender: nil)
        }
    }
    @IBAction func goToSaturday(_ sender: Any) {
            self.performSegue(withIdentifier: "MainToSaturday",sender: nil)
    }
    
	@IBAction func goToScroll(_ sender: Any) {
		self.performSegue(withIdentifier: "MainToScroll",sender: nil)
	}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myUIPicker.delegate = self
        myUIPicker.dataSource = self
        myUIPicker.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        yearLabel.inputView = myUIPicker
        yearLabel.inputAccessoryView = toolbar
        
        myUIPicker.selectRow(0, inComponent: 0, animated: false)
        yearLabel.text = list[0]
        
        buttonInit()
        //resize()
        titleChange()
        //profile.isHidden = true
    }
    
    //ボタンのタイトルを変更
    func titleChange() {
        let realm = try! Realm()
        
        for i in 1..<26 {
            let button = btnret(num: i)
            let title_tmp:Int
            if(i%5 == 0) {title_tmp = 5} else {title_tmp = i%5}
            button.setTitle(title_tmp.description, for: .normal)
            let objs = realm.objects(risyuu.self).filter("date_num == %@ AND year == %@ AND semester == %@",i,self.year,self.semester)
            if let obj = objs.last {
                if(obj.year == self.year && obj.semester == self.semester) {
                    print(obj)
                    title = obj.jugyou_name
                    button.setTitle(title, for: .normal)
                }
            }
        }
    }
    
    //遷移の準備。次の画面へのセグエにsenderを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "MainToSetting") {
            let next = segue.destination as! setting
            next.numdate = checkButton.tag//sender as? Int
            next.year = self.year
            next.semester = self.semester
        }
        if(segue.identifier == "MainToSaturday") {
            let next = segue.destination as! saturday
            next.year = self.year
            next.semester = self.semester
        }
		if(segue.identifier == "MainToScroll") {
			let next = segue.destination as! scroll
			next.numdate = checkButton.tag
			next.year = self.year
			next.semester = self.semester
		}
			
    }
    
    @objc func done() {
        yearLabel.endEditing(true)
        yearLabel.text = "\(list[myUIPicker.selectedRow(inComponent: 0)])"
        print("こここ")
        let yearStr = list[myUIPicker.selectedRow(inComponent: 0)]
        year = Int(yearStr.prefix(4))!
        semester = String(yearStr.suffix(2))
        print(year)
        print(semester)
        titleChange()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
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
        buttonPrepare(button: button1)
        buttonPrepare(button: button2)
        buttonPrepare(button: button3)
        buttonPrepare(button: button4)
        buttonPrepare(button: button5)
        buttonPrepare(button: button6)
        buttonPrepare(button: button7)
        buttonPrepare(button: button8)
        buttonPrepare(button: button9)
        buttonPrepare(button: button10)
        buttonPrepare(button: button11)
        buttonPrepare(button: button12)
        buttonPrepare(button: button13)
        buttonPrepare(button: button14)
        buttonPrepare(button: button15)
        buttonPrepare(button: button16)
        buttonPrepare(button: button17)
        buttonPrepare(button: button18)
        buttonPrepare(button: button19)
        buttonPrepare(button: button20)
        buttonPrepare(button: button21)
        buttonPrepare(button: button22)
        buttonPrepare(button: button23)
        buttonPrepare(button: button24)
        buttonPrepare(button: button25)
    }
    
    func resize() {
        label1.frame = CGRect(x: 0,y: 100,width: 82,height: 30)
        label2.frame = CGRect(x: 83,y: 100,width: 82,height: 30)
        label3.frame = CGRect(x: 166,y: 100,width: 82,height: 30)
        label4.frame = CGRect(x: 249,y: 100,width: 82,height: 30)
        label5.frame = CGRect(x: 332,y: 100,width: 82,height: 30)
        
        button1.frame = CGRect(x: 0,y: 130,width: 82,height: 100)
        button2.frame = CGRect(x: 0,y: 230,width: 82,height: 100)
        button3.frame = CGRect(x: 0,y: 330,width: 82,height: 100)
        button4.frame = CGRect(x: 0,y: 430,width: 82,height: 100)
        button5.frame = CGRect(x: 0,y: 530,width: 82,height: 100)
        button6.frame = CGRect(x: 83,y: 130,width: 82,height: 100)
        button7.frame = CGRect(x: 83,y: 230,width: 82,height: 100)
        button8.frame = CGRect(x: 83,y: 330,width: 82,height: 100)
        button9.frame = CGRect(x: 83,y: 430,width: 82,height: 100)
        button10.frame = CGRect(x: 83,y: 530,width: 82,height: 100)
        button11.frame = CGRect(x: 166,y: 130,width: 82,height: 100)
        button12.frame = CGRect(x: 166,y: 230,width: 82,height: 100)
        button13.frame = CGRect(x: 166,y: 330,width: 82,height: 100)
        button14.frame = CGRect(x: 166,y: 430,width: 82,height: 100)
        button15.frame = CGRect(x: 166,y: 530,width: 82,height: 100)
        button16.frame = CGRect(x: 249,y: 130,width: 82,height: 100)
        button17.frame = CGRect(x: 249,y: 230,width: 82,height: 100)
        button18.frame = CGRect(x: 249,y: 330,width: 82,height: 100)
        button19.frame = CGRect(x: 249,y: 430,width: 82,height: 100)
        button20.frame = CGRect(x: 249,y: 530,width: 82,height: 100)
        button21.frame = CGRect(x: 332,y: 130,width: 82,height: 100)
        button22.frame = CGRect(x: 332,y: 230,width: 82,height: 100)
        button23.frame = CGRect(x: 332,y: 330,width: 82,height: 100)
        button24.frame = CGRect(x: 332,y: 430,width: 82,height: 100)
        button25.frame = CGRect(x: 332,y: 530,width: 82,height: 100)
    }
    
    //数字から対応するボタンを返す
    func btnret(num:Int) -> UIButton {
        switch num {
        case 1: return self.button1
        case 2: return self.button2
        case 3: return self.button3
        case 4: return self.button4
        case 5: return self.button5
        case 6: return self.button6
        case 7: return self.button7
        case 8: return self.button8
        case 9: return self.button9
        case 10: return self.button10
        case 11: return self.button11
        case 12: return self.button12
        case 13: return self.button13
        case 14: return self.button14
        case 15: return self.button15
        case 16: return self.button16
        case 17: return self.button17
        case 18: return self.button18
        case 19: return self.button19
        case 20: return self.button20
        case 21: return self.button21
        case 22: return self.button22
        case 23: return self.button23
        case 24: return self.button24
        case 25: return self.button25
            
        default:
            print("error")
            return button1
        }
    }
	
	@IBAction func reveal(_ sender: Any) {
		let realm = try! Realm()
		let objs1 = realm.objects(risyuu.self)
		let objs2 = realm.objects(memo.self)
		print(objs1)
		print(objs2)
	}
}

