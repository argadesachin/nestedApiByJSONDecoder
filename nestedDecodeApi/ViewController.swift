//
//  ViewController.swift
//  nestedDecodeApi
//
//  Created by Mac on 15/12/22.
//

import UIKit

class ViewController: UIViewController {
//MARK - IBOutlet connection of tableView
    @IBOutlet weak var tableView: UITableView!
    
    var productApi = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       initDataSourceAndDelegate()
       registerNib()
        fetchingApi(){
            self.tableView.reloadData()
        }
    }
  //MARK - init datasource and deletgete method
    func initDataSourceAndDelegate(){
        tableView.dataSource = self
        tableView.delegate = self
    }
//MARK - register XIB
    func registerNib(){
        let nibName = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    func fetchingApi(complete:@escaping () -> ()){
        
        let urlString = "https://dummyjson.com/products"
        guard let url = URL(string: urlString) else {
            print("URL not created")
            return
        }
        URLSession.shared.dataTask(with: url){data,res,error in
            if(error == nil){
                do{
                    let result = try JSONDecoder().decode(apiResponse.self, from: data!)
                    self.productApi = result.products
                }catch{
                    print("error\(error)")
                }
                DispatchQueue.main.async {
                    complete()
                }
            }
        }.resume()
    }
}

//MARK - conform tableViewDataSource method
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productApi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        tableViewCell.idLabel.text = String(productApi[indexPath.row].id)
        tableViewCell.titleLabel.text = productApi[indexPath.row].title
        tableViewCell.decriptionLabel.text = productApi[indexPath.row].description
        tableViewCell.priceLabel.text = String(productApi[indexPath.row].price)
        tableViewCell.discountperLabel.text = String(productApi[indexPath.row].discountPercentage)
        
        return tableViewCell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
    }
}

