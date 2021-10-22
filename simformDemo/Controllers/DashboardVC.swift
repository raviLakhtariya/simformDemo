//
//  DashboardVC.swift
//  simformDemo
//
//  Created by ravi lakhtariya on 21/10/21.
//

import UIKit

class DashboardVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var arrBookList : [BookModel]?
    var searchBookList : [BookModel]?
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    var isSearch = false;
    fileprivate var expandedIndexSet = Set<IndexPath>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    func initialSetup(){
        tblView.register(UINib.init(nibName: "BookCells", bundle: nil), forCellReuseIdentifier:"BookCells")
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
extension DashboardVC : UITableViewDelegate,UITableViewDataSource{
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
        let cell : BookCells = (tblView.dequeueReusableCell(withIdentifier: "BookCells") as? BookCells)!
        var object : BookModel = (arrBookList?[indexPath.row])!
        if(btnSearch.isSelected == true){
            object = (searchBookList?[indexPath.row])!
        }

        
        cell.lblBookName.text = object.name
        cell.lblAuthorName.text = String(format: "Author: %@", object.author!)
        cell.lblPrice.text = String(format: "Price: %@ %.2f",Constants.currency,object.price ?? 0.0)
        cell.lblDescription.text = object.longDescription
        
        if(object.purchaseDate != nil){
            cell.btnPurchase.isSelected = true
        }else{
            cell.btnPurchase.isSelected = false
        }
        
        
        cell.onClickPurchase = {
            print("purchased")
            let book = BookModel(_id: object.id, _name:object.name,_author: object.author,_synopsis: object.synopsis,_price: object.price,_longDescription: object.longDescription,_quantity: object.quantity,_purchaseDate: Date())

            if(BookViewModel.purchaseBook(book))
            {
                Utils.displayAlert(alertMessage: "Book Purchased",viewController: self)
                self.fetchCall()
            }else
            {
                Utils.displayErrorAlert(viewController: self)
            }
        }
        cell.onClickOpenExpanded = {
            if self.expandedIndexSet.contains(indexPath) {
                self.expandedIndexSet.remove(indexPath)
                cell.btncollpaseExpands.isSelected = false
                cell.lblDescription.numberOfLines = 2
                } else {
                    self.expandedIndexSet.insert(indexPath)
                    cell.btncollpaseExpands.isSelected = true
                    cell.lblDescription.numberOfLines = 0
                }
                tableView.reloadRows(at: [indexPath], with: .fade)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            var object : BookModel = (arrBookList?[indexPath.row])!
            if(btnSearch.isSelected == true){
                object = (searchBookList?[indexPath.row])!
            }
            if(BookViewModel.deleteBookObject(object))
             {
                 Utils.displayAlert(alertMessage: "Book Deleted",viewController: self)
                 self.fetchCall()
             }else
             {
                 Utils.displayErrorAlert(viewController: self)
             }
        }
    }
}
extension DashboardVC {
    func fetchCall(){
        BookViewModel.getBookList { bookData in
            self.arrBookList = bookData;
            self.tblView.dataSource = self
            self.tblView.delegate = self
            
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
}

extension DashboardVC : UITextFieldDelegate{
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
