//
//  ItemRegister2ViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit
import Alamofire

import Photos

class ItemRegister2ViewController: UIViewController {

    // MARK: --
    @IBOutlet weak var nextButton: CustomButton!
    
    @IBOutlet weak var newButton: RadioButton!
    @IBOutlet weak var oldButton: RadioButton!

    @IBOutlet weak var nameStr: UITextField!
    @IBOutlet weak var functionStr: UITextField!
    
    @IBOutlet weak var detailStr: UITextView!
    @IBOutlet weak var priceStr: UITextField!
    
    @IBOutlet weak var errorStr: UILabel!
    
    var imageDatas = [UIImage]()
    let productViewModel = ProductViewModel()
    
    var getData : NSData?
    // MARK: --
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailStr.layer.cornerRadius = 8
        self.detailStr.layer.borderWidth = 1
        self.detailStr.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        newButton?.alternateButton = [oldButton!]
        oldButton?.alternateButton = [newButton!]
        setEnabledButton(nextButton)
        
        // sample video test URL
        let videoImageUrl = ""

        print("DownLoad ...")
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: videoImageUrl),
                let urlData = NSData(contentsOf: url) {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                let filePath="\(documentsPath)/tempFile.mp4"
                DispatchQueue.main.async {
                    urlData.write(toFile: filePath, atomically: true)
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                    }) { completed, error in
                        if completed {
                            print("Video is saved!")
                        }
                        else {
                            print("Video Save Error")
                        }
                    }
                }
                self.getData = urlData
            }
        }
    }
    
    // MARK: --
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
        if nameStr.text != "" && functionStr.text != "" && detailStr.text != "" && priceStr.text != "" {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = #colorLiteral(red: 1, green: 0.674518168, blue: 0, alpha: 1)
            self.errorStr.text = ""
        }
        else {
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            self.errorStr.text = "모든 항목을 입력해 주세요!"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var productStatus = "USED"
        if newButton.isSelected {
            productStatus = "DISUSED"
        }
        if let id = segue.identifier, "lastAdd" == id {
            if let controller = segue.destination as? ItemRegister3ViewController {
                controller.getName = self.nameStr.text
                controller.getPrice = Int(self.priceStr.text!)
                controller.getDescription = self.detailStr.text
                controller.getUseStatus = productStatus
            }
        }
    }
    
    // MARK: --
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
