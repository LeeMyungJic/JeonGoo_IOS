//
//  adViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit

class adViewController: UINavigationController {

    var changeView : (() -> ())?
    var delegateDate : DeliveryDataProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegateDate?.deliveryData("값 넘김")
    }
}
