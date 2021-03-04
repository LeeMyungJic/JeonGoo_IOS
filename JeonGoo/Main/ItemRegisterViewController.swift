//
//  ItemRegisterViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit

class ItemRegisterViewController: UIViewController, BackProtocol {
    
    var isOpened = false
    func deliveryData(_ data: Bool) {
        self.isOpened = data
        print("에드")
        guard let third = tabBarController?.viewControllers?[0]
        else {
            return
        }
        tabBarController?.selectedViewController = third
        isOpened = false
    }
    override func viewWillAppear(_ animated: Bool) {
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "ad") as? adViewController else {
            return
        }
        // second 뷰의 대리자는 나(first 뷰)야 !
        //vc.delegate = self
        
        present(vc, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
