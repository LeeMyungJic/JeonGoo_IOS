//
//  PayViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/27.
//

import UIKit

class PayViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var lineView = UIView(frame: CGRect(x: 0, y: 50, width: self.view.frame.size.width*0.9, height: 1.8))
        lineView.backgroundColor = #colorLiteral(red: 0.7489614487, green: 0.749052465, blue: 0.7489304543, alpha: 1)
        self.firstView.addSubview(lineView)

        //lineDraw(viewLi: firstView)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
