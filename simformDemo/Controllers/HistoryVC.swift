//
//  HistoryVC.swift
//  simformDemo
//
//  Created by ravi lakhtariya on 21/10/21.
//

import UIKit

class HistoryVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var arrBookList : [BookModel]?
    var searchBookList : [BookModel]?
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    var isSearch = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    func initialSetup(){
        tblView.register(UINib.init(nibName: "HistoryCells", bundle: nil), forCellReuseIdentifier:"HistoryCells")
        tblView.tableFooterView = UIView.init()
    
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        btnSearch.isSelected = false
        txtSearch.isHidden = true
        txtSearch.text = ""
        fetchCall()
        
    }
    @IBAction func onClickBtnSearch(_ sender: Any) {
        if(isSearch == false){
            isSearch = true
            btnSearch.isSelected = true
            txtSearch.isHidden = false
        }else{
            isSearch = false
            btnSearch.isSelected = false
            txtSearch.isHidden = true
            txtSearch.text = ""
            searchBookList?.removeAll()
            fetchCall()
        }
    }
}
extension HistoryVC : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(btnSearch.isSelected == true){
            return (searchBookList?.count ?? 0)
        }else{
            return (arrBookList?.count ?? 0)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HistoryCells = (tblView.dequeueReusableCell(withIdentifier: "HistoryCells") as? HistoryCells)!
        var object : BookModel = (arrBookList?[indexPath.row])!
        if(btnSearch.isSelected == true){
            object = (searchBookList?[indexPath.row])!
        }
        
        cell.lblBookName.text = object.name
        cell.lblAuthorName.text = String(format: "Author: %@", object.author!)
        cell.lblPrice.text = String(format: "Price: %@ %.2f",Constants.currency,object.price ?? 0.0)
        cell.lblPurchaseDate.text = String(format: "Purchased Date: %@", object.purchaseDate! as CVarArg)
        cell.lblShortDesc.text = object.synopsis
        
        
        cell.onClickDelete = {
            //Removed From Purchase or cart
            print("purchased")
            let book = BookModel(_id: object.id, _name:object.name,_author: object.author,_synopsis: object.synopsis,_price: object.price,_longDescription: object.longDescription,_quantity: object.quantity,_purchaseDate: nil)

            if(BookViewModel.purchaseBook(book))
            {
                Utils.displayAlert(alertMessage: "Removed from purchased history",viewController: self)
                self.fetchCall()
            }else
            {
                Utils.displayErrorAlert(viewController: self)
            }
            
            //Removed book from History
            
           /* if(BookViewModel.deleteBookObject(object))
            {
                Utils.displayAlert(alertMessage: "Book Deleted",viewController: self)
                self.fetchCall()
            }else
            {
                Utils.displayErrorAlert(viewController: self)
            }*/
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension HistoryVC {
    func fetchCall(){
        BookViewModel.getBookList { bookData in
            self.arrBookList = bookData?.filter({$0.purchaseDate != nil});
            self.arrBookList = self.arrBookList?.sorted(by: {
                $0.purchaseDate?.compare($1.purchaseDate!) == .orderedDescending
            })
            self.tblView.dataSource = self
            self.tblView.delegate = self
            
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
}


extension HistoryVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
                searchBookList?.removeAll()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                self.searchBookList = self.arrBookList?.filter({$0.name?.lowercased().range(of: (self.txtSearch.text?.lowercased())!) != nil})
                self.tblView.reloadData()
            }
        return true
    }
    
}
