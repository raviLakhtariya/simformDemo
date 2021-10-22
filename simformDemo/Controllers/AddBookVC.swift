//
//  AddBookVC.swift
//  simformDemo
//
//  Created by ravi lakhtariya on 21/10/21.
//

import UIKit

class AddBookVC: UIViewController {


    
    @IBOutlet weak var scrView: UIScrollView!
    
    @IBOutlet weak var txtBookName: UITextField!
    @IBOutlet weak var lblBookName: UILabel!
    
    @IBOutlet weak var lblBookAuthor: UILabel!
    @IBOutlet weak var txtBookAuthor: UITextField!
    
    @IBOutlet weak var lblBookPrice: UILabel!
    @IBOutlet weak var txtBookPrice: UITextField!
    
    @IBOutlet weak var lblBookSynopsis: UILabel!
    @IBOutlet weak var txtBookSynopsis: UITextField!
    
    @IBOutlet weak var lblBookQuantity: UILabel!
    @IBOutlet weak var txtBookQuantity: UITextField!
  
    @IBOutlet weak var lblBookDescription: UILabel!
    @IBOutlet weak var txtBookDescription: UITextView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    var bookViewModel = BookViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        self.hideKeyboardWhenTappedAround()
    }
    
    func initialSetup(){
        txtBookName.setupBorder()
        txtBookAuthor.setupBorder()
        txtBookSynopsis.setupBorder()
        txtBookPrice.setupBorder()
        txtBookDescription.setupBorder()
        txtBookQuantity.setupBorder()
        txtBookPrice.setupBorder()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        observeKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        
    }
    

    @IBAction func onClickBtnSaveBook(_ sender: Any) {
        self.view.endEditing(true)
        let bookModel = BookModel.init(_id: UUID(), _name: txtBookName.text, _author: txtBookAuthor.text, _synopsis: txtBookSynopsis.text, _price: Double(txtBookPrice.text ?? "0.0"), _longDescription: txtBookDescription.text, _quantity: Int(txtBookQuantity.text ?? "0"), _purchaseDate: nil)
        let validatation = bookViewModel.validateInput(bookModel)
        if(validatation.0 == true){
            BookViewModel.createBookList(bookModel)
            txtBookName.text = ""
            txtBookAuthor.text = ""
            txtBookSynopsis.text = ""
            txtBookPrice.text = ""
            txtBookDescription.text = ""
            txtBookQuantity.text = ""
            txtBookPrice.text = ""
        }else{
            self.toast(validatation.1 ?? "")
        }
    
    }
}

extension AddBookVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(textField == txtBookSynopsis || textField == txtBookDescription){
            var maxLength = 1
            if(textField == txtBookSynopsis){
                maxLength = 50
            }
            if(textField == txtBookDescription){
                maxLength = 300
            }
             let currentString: NSString = textField.text! as NSString
             let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            let components = newString.components(separatedBy: .whitespacesAndNewlines)
            let words = components.filter { !$0.isEmpty }
             return words.count <= maxLength
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtBookName {
            txtBookAuthor.becomeFirstResponder()
        } else if textField == txtBookAuthor {
            txtBookPrice.becomeFirstResponder()
        } else if textField == txtBookPrice {
            txtBookSynopsis.becomeFirstResponder()
        } else if textField == txtBookSynopsis {
            txtBookQuantity.becomeFirstResponder()
        } else if textField == txtBookQuantity {
            txtBookSynopsis.becomeFirstResponder()
        }
        return true
    }
}

extension AddBookVC{
    //Adding observer to keyboard notifications
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name:  UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    fileprivate func observeKeyboardRemoveNotifcation(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
       
    }
    

    @objc func keyboardHide(notification:NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
          scrView.contentInset = contentInset
    }
   
    @objc func keyboardShow(notification:NSNotification) {
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
           keyboardFrame = self.view.convert(keyboardFrame, from: nil)

           var contentInset:UIEdgeInsets = self.scrView.contentInset
           contentInset.bottom = keyboardFrame.size.height
           scrView.contentInset = contentInset
    }
}
