//
//  BookPurchase+CoreDataProperties.swift
//  simformDemo
//
//  Created by ravi lakhtariya on 21/10/21.
//
//

import Foundation
import CoreData


extension BookPurchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookPurchase> {
        return NSFetchRequest<BookPurchase>(entityName: "BookPurchase")
    }

    @NSManaged public var bookname: String?
    @NSManaged public var bookauthor: String?
    @NSManaged public var bookshortdesc: String?
    @NSManaged public var bookprice: Double
    @NSManaged public var booklongdesc: String?
    @NSManaged public var bookquantity: String?
    @NSManaged public var purchasedate: Date?
    @NSManaged public var bookid: UUID?

}

extension BookPurchase : Identifiable {

}
