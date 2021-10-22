//
//  BookModel.swift
//  simformDemo
//
//  Created by ravi lakhtariya on 21/10/21.
//

import Foundation

class BookModel{

    var id : UUID?
    var name : String?
    var author : String?
    var synopsis : String?
    var price : Double?
    var longDescription : String?
    var quantity : Int?
    var purchaseDate:Date?
    
    init() {}
    
    init(_id:UUID?,_name:String?,_author:String?,_synopsis:String?,_price:Double?,_longDescription:String?,_quantity:Int?,_purchaseDate:Date?) {
        self.id = _id;
        self.name = _name;
        self.author = _author;
        self.synopsis = _synopsis;
        self.price = _price;
        self.quantity = _quantity;
        self.longDescription = _longDescription
        self.purchaseDate = _purchaseDate;
    }

}
/*struct BookModel : Codable {
    let name : String?
    let author : String?
    let synopsis : String?
    let price : Double?
    let longDescription : String?
    let quantity : Int?

    enum CodingKeys: String, CodingKey {
        case name = "bookName"
        case author = "bookAuthor"
        case synopsis = "bookSynopsis"
        case price = "bookPrice"
        case longDescription = "bookLongDescription"
        case quantity = "bookQuantity"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        synopsis = try values.decodeIfPresent(String.self, forKey: .synopsis)
        longDescription = try values.decodeIfPresent(String.self, forKey: .longDescription)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
    }

}
*/
