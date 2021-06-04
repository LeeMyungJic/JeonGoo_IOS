//
//  PaymentViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/06/04.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var subView: UIView!
    
    var webView: WKWebView!
    
    let bridgeName = "tt"
    var pg_token = ""
    var tid = ""
    let productViewModel = ProductViewModel()
    
    var getProductName = "Null"
    var getProductPrice = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("getPrice : \(getProductPrice)")
        setPaymentReady()
        // Do any additional setup after loading the view.
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        
        //현재 로딩 URL을 String으로 가져오기
        let loadUrl : String = navigationAction.request.url!.absoluteString
        
        if loadUrl.contains("fail") {
            let popup = UIAlertController(title: "결제 실패", message: "다시 시도해주세요.", preferredStyle: .alert)
            let yes = UIAlertAction(title: "확인", style: .cancel){_ in
                self.navigationController?.popToRootViewController(animated: true)
                
            }
            popup.addAction(yes)
            self.present(popup, animated: true)
            return
        }
        else if loadUrl.contains("cancel") {
            
            let popup = UIAlertController(title: "결제 실패", message: "전구로 돌아갑니다", preferredStyle: .alert)
            let yes = UIAlertAction(title: "확인", style: .cancel){_ in
                self.navigationController?.popToRootViewController(animated: true)
                
            }
            popup.addAction(yes)
            self.present(popup, animated: true)
            decisionHandler(.cancel)
            return
        }
        
        if loadUrl.hasPrefix("http:") || loadUrl.hasPrefix("https") {
            if loadUrl.contains("pg_token=") {
                let parsed = loadUrl.replacingOccurrences(of: "https://www.naver.com/success?pg_token=", with: "")
                pg_token = parsed
                paymentApprove()
            }
            decisionHandler(.allow)
        }
        else {
            decisionHandler(.cancel)
        }
    }
    
    func setUI(getUrl: String) {
        HTTPCookieStorage.shared.cookieAcceptPolicy = HTTPCookie.AcceptPolicy.always  // 현대카드 등 쿠키설정 이슈 해결을 위해 필요
        let configuration = WKWebViewConfiguration() //wkwebview <-> javasscript function(bootpay callback)
        configuration.userContentController.add(self, name: bridgeName)
        webView = WKWebView(frame: self.subView.bounds, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.subView.addSubview(webView)
        
        let url = URL(string: getUrl)
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
    }
    
    func setPaymentReady() {
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK 5de8c1bcab425b5cd90022391d41b65b"
        ]
        
        let parameters: [String: Any] = [
            "cid": "TC0ONETIME",
            "partner_order_id" : "partner_order_id",
            "partner_user_id" : "partner_user_id",
            "item_name" : self.getProductName,
            "quantity" : 1,
            "total_amount" : self.getProductPrice,
            "tax_free_amount" : 0,
            "approval_url" : "https://www.naver.com/success",
            "cancel_url" : "https://www.naver.com/cancel",
            "fail_url" : "https://www.naver.com/fail"
            
        ]
        
        AF.request("https://kapi.kakao.com/v1/payment/ready", method: .post,
                   parameters: parameters, headers: headers)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let getUrlString = JSON(value)["next_redirect_app_url"].stringValue
                    self.tid = JSON(value)["tid"].stringValue
                    self.setUI(getUrl: getUrlString)
                    
                    let kakaoTalkURL = NSURL(string: JSON(value)["ios_app_scheme"].stringValue)
                    
                    UIApplication.shared.open(kakaoTalkURL! as URL)
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    func paymentApprove() {
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK 5de8c1bcab425b5cd90022391d41b65b"
        ]
        
        let parameters: [String: Any] = [
            "cid": "TC0ONETIME",
            "tid": self.tid,
            "partner_order_id" : "partner_order_id",
            "partner_user_id" : "partner_user_id",
            "item_name" : "테스트 상품",
            "pg_token" : self.pg_token
            
        ]
        
        AF.request("https://kapi.kakao.com/v1/payment/approve", method: .post,
                   parameters: parameters, headers: headers)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    self.productViewModel.purchaseProduct() { state in
                        let popup = UIAlertController(title: "결제 성공", message: "결제가 완료되었습니다.", preferredStyle: .alert)
                        let yes = UIAlertAction(title: "확인", style: .cancel){_ in
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                        popup.addAction(yes)
                        self.present(popup, animated: true)
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }
}

extension PaymentViewController:  WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler  {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if(message.name == bridgeName) {
            guard let body = message.body as? [String: Any] else {
                if message.body as? String == "close" {
                    print("close")
                }
                return
            }
            guard let action = body["action"] as? String else {
                return
            }
            print("action")
        }
    }
    
    
}
