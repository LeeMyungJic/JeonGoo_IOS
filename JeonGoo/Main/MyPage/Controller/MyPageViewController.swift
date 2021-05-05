//
//  MyPageViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit

class MyPageViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var sale: UIButton!
    @IBOutlet weak var buying: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var userInfo: UIButton!
    
    public static var userId: Int?
    
    let userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userViewModel.getUserInfo(userId: MyPageViewController.userId!) { state in
            self.userName.text = "\(String(describing: self.userViewModel.user!.name)) 님"
        
        }

        self.firstView.addSubview(MakeUnderLineInView(target: firstView))
        self.secondView.addSubview(MakeUnderLineInView(target: secondView))
        
        setImage(name: "list", button: sale)
        setImage(name: "sale", button: buying)
        setImage(name: "like2", button: like)
        // Do any additional setup after loading the view.
    }
    
    func setImage(name: String, button: UIButton) {
        button.setImage(ImageResize(getImage: UIImage(named: name)!, size: 50), for: .normal)
    }
    
}
