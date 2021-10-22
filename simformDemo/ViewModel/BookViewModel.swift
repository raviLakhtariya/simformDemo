//
//  BookViewModel.swift
//  simformDemo
//
//  Created by ravi lakhtariya on 21/10/21.
//

import Foundation

typealias ValidationCompletion = (Bool, String?) -> Void

class BookViewModel{

    let bookNameEmptyMessage = "Please Enter book name"
    let authornameEmptyMessage = "Please Enter author name"
    let synopsisEmptyMessage = "Please Enter synopsis"
    let priceEmptyMessage = "Please Enter price"
    let lognDescriptionEmptyMessage = "Please Enter message"
    
    static var arrBookModel : [BookModel]?
    static var bookRepo = BookRepository()
    
    func validateInput(_ bookModel: BookModel)->(Bool,String?) {
        if let bname = bookModel.name {
            if bname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return(false, bookNameEmptyMessage)
            }
        } else {
            return(false, bookNameEmptyMessage)
        }
        
        if let authorName = bookModel.author {
            if authorName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return(false, authornameEmptyMessage)
            }
        } else {
            return(false, authornameEmptyMessage)
        }
        if let price = bookModel.price {
            if price == nil {
                return(false, priceEmptyMessage)
            }
        } else {
            return(false, priceEmptyMessage)
        }
        
        
        if let synopsis = bookModel.synopsis {
            if synopsis.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return(false, synopsisEmptyMessage)
            }
        } else {
            return(false, synopsisEmptyMessage)
        }
       
        if let longDesc = bookModel.longDescription {
            if longDesc.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return(false, lognDescriptionEmptyMessage)
            }
        } else {
            return(false, lognDescriptionEmptyMessage)
        }
          // Validated successfully.
        return(true, nil)
      }

    
    class func createBookList(_ bookModel:BookModel){
        let bookModelObject = BookModel(_id: bookModel.id ?? UUID(), _name: bookModel.name, _author: bookModel.author, _synopsis: bookModel.synopsis, _price: bookModel.price, _longDescription: bookModel.longDescription, _quantity: bookModel.quantity ?? 0, _purchaseDate: bookModel.purchaseDate)
        bookRepo.create(record: bookModelObject)
    }
    
    class func deleteBookObject(_ bookModel:BookModel)->Bool {
        return bookRepo.delete(id: bookModel.id!)
    }
    class func purchaseBook(_ bookModel:BookModel)->Bool{
        return bookRepo.update(book: bookModel)
    }
    
    
    
    class func getBookList(completionHandler:@escaping(_ result:[BookModel]?)->Void){
        if let bookData = bookRepo.fetch(){
            completionHandler(bookData)
        }else{
            completionHandler([])
        }
    }

    
}
