//
//  MyPageViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit

class MyPageViewController: UIViewController {

    @IBOutlet weak var sale: UIButton!
    @IBOutlet weak var buying: UIButton!
    @IBOutlet weak var like: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setImage(name: "list", button: sale)
        setImage(name: "sale", button: buying)
        setImage(name: "like2", button: like)
        // Do any additional setup after loading the view.
    }
    
    func setImage(name: String, button: UIButton) {
        button.setImage(resize(getImage: UIImage(named: name)!, size: 50), for: .normal)
    }
    
    func resize(getImage:UIImage, size:Double) -> UIImage {
        
        var new_image : UIImage!
        let size = CGSize(width:  size  , height: size )

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)

        getImage.draw(in: rect)

        new_image = UIGraphicsGetImageFromCurrentImageContext()!

        UIGraphicsEndImageContext()

        return new_image
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
