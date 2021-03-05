//
//  ItemRegisterViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit

class ItemRegisterViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "ad") as? adViewController else {
            return
        }
        present(vc, animated: true) {
            guard let second = self.tabBarController?.viewControllers?[0] else {
                return
            }
    
            self.tabBarController?.selectedViewController = second
        }
    }
    
    func YesClick()
    {
        
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
