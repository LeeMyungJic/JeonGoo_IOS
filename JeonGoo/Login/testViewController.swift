//
//  TestViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/06/02.
//

import UIKit
import Alamofire
import SwiftyJSON
import WebKit

class TestViewController: UIViewController{
    
    @IBOutlet weak var subView: UIView!
    
    var webView: WKWebView!
    
    let bridgeName = "tt"
    var pg_token = ""
    var tid = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setPaymentReady()
    }
    
    
    // WKWebView URL Loading 요청 시 호출되는 델리게이트 함수
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        
        //현재 로딩 URL을 String으로 가져오기
        let loadUrl : String = navigationAction.request.url!.absoluteString
        
        if loadUrl.hasPrefix("http:") || loadUrl.hasPrefix("https") {
            if loadUrl.contains("fail") {
                self.showPaymentErrorMessage()
                print("결제 실패")
                decisionHandler(.cancel)
                return
            }
            else if loadUrl.contains("cancel") {
                self.showPaymentCancelMessage()
                print("결제 중단")
                decisionHandler(.cancel)
                return
            }
            if loadUrl.contains("pg_token=") {
                let parsed = loadUrl.replacingOccurrences(of: "https://www.naver.com/?pg_token=", with: "")
                pg_token = parsed
                print("pg_token : \(pg_token)")
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
    
    fileprivate func showPaymentCancelMessage() {
        showAlertController(withTitle: "결제 실패", message: "결제를 취소하였습니다", completion: nil)
        
    }
    fileprivate func showPaymentErrorMessage() {
        showAlertController(withTitle: "결제 실패", message: "다시 시도해주세요", completion: nil)
    }
    
    @IBAction func reloadTab(_ sender: Any) {
        webView.reload()
    }
    @IBAction func backTab(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setPaymentReady() {
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK 5de8c1bcab425b5cd90022391d41b65b"
        ]
        
        let parameters: [String: Any] = [
            "cid": "TC0ONETIME",
            "partner_order_id" : "partner_order_id",
            "partner_user_id" : "partner_user_id",
            "item_name" : "테스트 상품",
            "quantity" : 1,
            "total_amount" : 28000,
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
                    let getUrlString = JSON(value)["next_redirect_mobile_url"].stringValue
                    self.tid = JSON(value)["tid"].stringValue
                    print("tid : \(self.tid)")
                    self.setUI(getUrl: getUrlString)
                    
                    let kakaoTalkURL = NSURL(string: JSON(value)["ios_mobile_scheme"].stringValue)
                    
                    //canOpenURL(_:) 메소드를 통해서 URL 체계를 처리하는 데 앱을 사용할 수 있는지 여부를 확인
                    if (UIApplication.shared.canOpenURL(kakaoTalkURL! as URL)) {
                        
                        //open(_:options:completionHandler:) 메소드를 호출해서 카카오톡 앱 열기
                        //UIApplication.shared.open(kakaoTalkURL! as URL)
                        UIApplication.shared.open(kakaoTalkURL! as URL, options: [:], completionHandler: {
                            (bool) -> Void in
                            
                            print("bool : \(bool)")
                        })
                    }
                    //사용 불가능한 URLScheme일 때(카카오톡이 설치되지 않았을 경우)
                    else {
                        print("No kakaotalk installed.")
                    }
                    
                    print(value)
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
                    
                    print("결제 성공")
                    print(value)
                    let popup = UIAlertController(title: "결제 성공", message: "결제가 완료되었습니다.", preferredStyle: .alert)
                    let yes = UIAlertAction(title: "확인", style: .cancel){_ in
                        self.navigationController?.popToRootViewController(animated: true)
                        
                    }
                    popup.addAction(yes)
                    self.present(popup, animated: true)
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    //"http://" 문자열이 없을 경우 자동으로 삽입
    func checkUrl(_ url: String) -> String {
        var strUrl = url
        let flag = strUrl.hasPrefix("http://")
        if !flag {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }
}
extension TestViewController:  WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler  {
    
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
