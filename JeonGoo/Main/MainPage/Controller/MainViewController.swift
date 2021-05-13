//
//  MainViewController.swift
//  JeonGoo
//
//  Created by 이명직 on 2021/03/04.
//

import UIKit
import Moya

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK:- Component(Outlet)
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarStack: UIStackView!
    @IBOutlet weak var TableMain: UITableView!
    
    // MARK: -
    var searchData : [productData]!
    var getProducts = [productData]()
    var productViewModel = ProductViewModel()
    
    // MARK: --
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBar()
        
        TableMain.delegate = self
        TableMain.dataSource = self
        searchBar.delegate = self
        
        self.searchData = self.getProducts
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    // MARK: -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchData.count
    }
    
    func getData() {
        getProducts = [productData]()
        productViewModel.findAll() { state in
            
            self.getProducts = self.productViewModel.Products
            self.searchData = self.getProducts
            self.TableMain.reloadData()
        }
    }
    
    func setSearchBar(){
        
        searchBar.placeholder = "Search"
        //왼쪽 서치아이콘 이미지 세팅하기
        searchBar.setImage(ImageResize(getImage: UIImage(named: "search")!, size: 20), for: UISearchBar.Icon.search, state: .normal)
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            //서치바 백그라운드 컬러
            textfield.backgroundColor = UIColor.white
            //플레이스홀더 글씨 색 정하기
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            //서치바 텍스트입력시 색 정하기
            textfield.textColor = UIColor.black
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableMain.dequeueReusableCell(withIdentifier: "ItemsCell") as! ItemsCell
        if getProducts[indexPath.row].productDetailDto.productGrade == "NONE" {
            cell.grade.text = setGrade(value: getProducts[indexPath.row].productDetailDto.certificationStatus)
        }
        else {
            cell.grade.text = setGrade(value: getProducts[indexPath.row].productDetailDto.productGrade)
        }
        cell.item.text = searchData[indexPath.row].productDetailDto.name
        cell.price.text = "\(searchData[indexPath.row].productDetailDto.price)원"
        cell.like.text = "\(searchData[indexPath.row].interestCount)"
        
        // cell.itemImage.image = ImageResize(getImage: UIImage(named: image[indexPath.row])!, size: 70)
        
        return cell
    }
    
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        dismissKeyboard()
        
        guard let searchStr = searchBar.text, searchStr.isEmpty == false else {
            self.searchData = self.getProducts
            DispatchQueue.main.async {
                self.TableMain.reloadData()
            }
            return
        }
        
        self.searchData = self.getProducts.filter{
            (product: productData) -> Bool in
            product.productDetailDto.name.lowercased().contains(searchStr.lowercased())
        }
        DispatchQueue.main.async {
            self.TableMain.reloadData()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "detail" == id {
            if let controller = segue.destination as? DetailViewController {
                if let indexPath = TableMain.indexPathForSelectedRow {
                    DetailViewController.productId = searchData[indexPath.row].productDetailDto.id
                    
                }
            }
        }
    }
    
    // MARK: --
    @IBAction func cancel(_ sender: Any) {
        self.searchData = self.getProducts
        DispatchQueue.main.async {
            self.TableMain.reloadData()
            self.searchBar.text = ""
        }
    }
}
