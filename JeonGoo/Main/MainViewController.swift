//
//  MainViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var TableMain: UITableView!
    var image = ["macbookAir", "macbookPro", "iphone"]
    var products = [Product]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = TableMain.dequeueReusableCell(withIdentifier: "ItemsCell") as! ItemsCell
        if products[indexPath.row].grade == "new" {
            cell.grade.textColor = #colorLiteral(red: 0.9094272256, green: 0.2923271656, blue: 0.2339404225, alpha: 1)
            cell.grade.text = "미개봉"
        }
        else {
            cell.grade.text = products[indexPath.row].grade
        }
        if products[indexPath.row].isGenuine {
            cell.grade.text! = cell.grade.text! + "  정품인증"
            let attributedStr = NSMutableAttributedString(string: cell.grade.text!)
            attributedStr.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.1567805707, green: 0.5004235506, blue: 0.7245382667, alpha: 1), range: (cell.grade.text as! NSString).range(of: "정품인증"))

            cell.grade.attributedText = attributedStr
        }
        cell.item.text = products[indexPath.row].name
        
        if products[indexPath.row].isReserved {
            cell.item.text! = "예약중  " + cell.item.text!
            let attributedStr = NSMutableAttributedString(string: cell.item.text!)
            attributedStr.addAttribute(.foregroundColor, value: #colorLiteral(red: 0, green: 0.5935456157, blue: 0.04135202616, alpha: 1), range: (cell.item.text as! NSString).range(of: "예약중"))

            cell.item.attributedText = attributedStr
        }
        cell.itemImage.image = resize(getImage: UIImage(named: image[indexPath.row])!)
        cell.price.text = "\(products[indexPath.row].price)원"
        cell.like.text = "\(products[indexPath.row].likes)"
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        TableMain.delegate = self
        TableMain.dataSource = self
        
        products.append(Product(name: "macbookAir", price: 900000, likes: 16, grade: "A등급", isReserved: false, isGenuine: true))
        products.append(Product(name: "macbookPro", price: 3000000, likes: 8, grade: "B등급", isReserved: false, isGenuine: false))
        products.append(Product(name: "iphone", price: 800000, likes: 26, grade: "new", isReserved: true, isGenuine: true))
        // Do any additional setup after loading the view.
    }
    
    func resize(getImage:UIImage) -> UIImage {
        
        let wif = 70
        var new_image : UIImage!
        let size = CGSize(width:  70  , height: 70 )

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
