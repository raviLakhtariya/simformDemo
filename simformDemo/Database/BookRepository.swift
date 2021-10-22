//
//  BookRepository.swift
//  simformDemo
//
//  Created by ravi lakhtariya on 21/10/21.
//

import Foundation
import CoreData

protocol BookRepoProtocol {
    func create(record:BookModel)
    func fetch()->[BookModel]?
    func update(book: BookModel) -> Bool
    func delete(id: UUID) -> Bool
}


struct BookRepository : BookRepoProtocol{
    func create(record: BookModel) {
        let bookData = BookPurchase(context: PersistantStorage.shared.context)
        bookData.bookid = record.id
        bookData.bookname = record.name
        bookData.bookauthor = record.author
        bookData.bookprice = record.price ?? 0.0
        bookData.bookshortdesc = record.synopsis
        bookData.bookquantity = String(record.quantity ?? 0)
        bookData.booklongdesc = record.longDescription
        PersistantStorage.shared.saveContext()
    }
    
    func fetch() -> [BookModel]? {
        let fetchRequest = NSFetchRequest<BookPurchase>(entityName: "BookPurchase")
        fetchRequest.returnsObjectsAsFaults = false
             do {
                let result = try PersistantStorage.shared.context.fetch(fetchRequest)//context.fetch(request)
                var arrBookModel : [BookModel] = [BookModel]()
                for data in result {
                    arrBookModel.append(data.convertBookModel()!)
                 }
                return arrBookModel
                 
             } catch {
                 
                 print("Failed")
             }
        return nil
    }
    
    
    func update(book: BookModel) -> Bool {

        var bookObject = getBookById(byIdentifier: book.id!)
        guard bookObject != nil else {return false}
       // let bookObject = (bookObj?.convertBookModel())!
        bookObject?.bookid = book.id
        bookObject?.bookname = book.name
        bookObject?.bookauthor = book.author
        bookObject?.bookprice = book.price ?? 0.0
        bookObject?.bookshortdesc = book.synopsis
        bookObject?.booklongdesc = book.longDescription
        bookObject?.bookquantity = String(book.quantity ?? 0)
        bookObject?.purchasedate = book.purchaseDate

        PersistantStorage.shared.saveContext()
        return true
    }

    func delete(id: UUID) -> Bool {

        let bookObject = getBookById(byIdentifier: id)
        guard bookObject != nil else {return false}

        PersistantStorage.shared.context.delete(bookObject!)
        PersistantStorage.shared.saveContext()
        return true
    }


    private func getBookById(byIdentifier id: UUID) -> BookPurchase?
    {
        let fetchRequest = NSFetchRequest<BookPurchase>(entityName: "BookPurchase")
        let predicate = NSPredicate(format: "bookid==%@", id as CVarArg)

        fetchRequest.predicate = predicate
        do {
            let result = try PersistantStorage.shared.context.fetch(fetchRequest).first

            guard result != nil else {return nil}
            
            return result
            

        } catch let error {
            debugPrint(error)
        }

        return nil
    }

}
extension BookPurchase{
    func convertBookModel()->BookModel?{
        return BookModel(_id:self.bookid,_name: self.bookname, _author: self.bookauthor, _synopsis: self.bookshortdesc, _price: self.bookprice, _longDescription: self.booklongdesc, _quantity: Int(self.bookquantity ?? "0"), _purchaseDate: self.purchasedate != nil ? Utils.convertDateFormater(self.purchasedate!): nil)
    }
    
}
