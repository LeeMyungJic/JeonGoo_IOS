//
//  PersonalInformationViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/15.
//

import UIKit

class PersonalInformationViewController: UIViewController {
    
    @IBOutlet weak var check1: UIButton!
    @IBOutlet weak var check2: UIButton!
    @IBOutlet weak var check3: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var nextBtn: CustomButton!
    
    var isClick1 = false
    var isClick2 = false
    var isClick3 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        nextBtn.isEnabled = false
        
        var attributedStr = NSMutableAttributedString(string: self.label1.text!)
        attributedStr.addAttribute(.foregroundColor, value: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), range: (self.label1.text as! NSString).range(of: "(필수)"))
        label1.attributedText = attributedStr
        
        attributedStr = NSMutableAttributedString(string: self.label2.text!)
        attributedStr.addAttribute(.foregroundColor, value: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), range: (self.label2.text as! NSString).range(of: "(필수)"))
        label2.attributedText = attributedStr
        
        attributedStr = NSMutableAttributedString(string: self.label3.text!)
        attributedStr.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), range: (self.label3.text as! NSString).range(of: "(선택)"))
        label3.attributedText = attributedStr
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func click1btn(_ sender: Any) {
        if !isClick1 {
            isClick1 = true
            check1.setImage(UIImage(named: "check2"), for: .normal)
        }
        else {
            isClick1 = false
            check1.setImage(UIImage(named: "check1"), for: .normal)
        }
        if isClick1 && isClick2 {
            nextBtn.backgroundColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
            nextBtn.isEnabled = true
        }
        else {
            nextBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            nextBtn.isEnabled = false
        }
    }
    
    @IBAction func click2btn(_ sender: Any) {
        if !isClick2 {
            isClick2 = true
            check2.setImage(UIImage(named: "check2"), for: .normal)
        }
        else {
            isClick2 = false
            check2.setImage(UIImage(named: "check1"), for: .normal)
        }
        if isClick1 && isClick2 {
            nextBtn.backgroundColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
            nextBtn.isEnabled = true
        }
        else {
            nextBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            nextBtn.isEnabled = false
        }
    }
    
    @IBAction func click3btn(_ sender: Any) {
        if !isClick3 {
            isClick3 = true
            check3.setImage(UIImage(named: "check2"), for: .normal)
        }
        else {
            isClick3 = false
            check3.setImage(UIImage(named: "check1"), for: .normal)
        }
        
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
