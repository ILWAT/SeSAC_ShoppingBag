//
//  RealmManager.swift
//  SeSAC_ShoppingBag
//
//  Created by 문정호 on 2023/09/11.
//

import Foundation
import RealmSwift

final class RealmManager{
    static let shared = RealmManager()
    
    private var realm: Realm?
    
    private init() {
        do{
            try realm = Realm()
            print(realm?.configuration.fileURL)
        } catch {
            print("error")
        }
    }
    
    func readShoppingRealmData() -> Results<SearchShoppingRealmModel>? {
        guard let realm else {return nil}
        return realm.objects(SearchShoppingRealmModel.self)
    }
    
    ///데이터를 데이터베이스에 저장한다. 성공시 true를 반환하고 실패시 false를 반환한다.
    func insertShoppingRealmData(data: Item) -> Bool{
        guard let realm else{ return false }
        do{
            try realm.write({
                let newValue = SearchShoppingRealmModel(title: data.title, link: data.link, image: data.image, lprice: data.lprice, hprice: data.hprice, mallName: data.mallName, productID: data.productID, productType: data.productType, brand: data.brand, maker: data.maker, category1: data.category1, category2: data.category2, category3: data.category3, category4: data.category4)
                realm.add(newValue)
            })
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    ///변경할 데이터를 받아 데이터베이스에 저장을 성공하면 변경된 값을 반환하고, 실패했을 경우에는 원래 값을 반환한다.
    func changeShoppingRealmLikeData(data: SearchShoppingRealmModel, isLiked: Bool) -> Bool{
        guard let realm else{ return isLiked }
        do{
            
            try realm.write({
                realm.create(SearchShoppingRealmModel.self,
                             value: ["_id": data._id, "like": isLiked],
                             update: .modified)
            })
            return !isLiked
        } catch {
            print(error)
            return isLiked
        }
    }
    
    ///주어진 데이터를 삭제한다. 성공시 true를 반환하고 실패시 false를 반환한다.
    func removeShoppingRealmData(data: SearchShoppingRealmModel) -> Bool{
        guard let realm else {return false}
        
        guard let targetData = realm.object(ofType: SearchShoppingRealmModel.self, forPrimaryKey: data._id) else {return false}
        
        do{
            try realm.write({
                realm.delete(targetData)
            })
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    ///해당 데이터가 데이터베이스에 있는지 탐색한후 결과를 반환한다.
    ///true이면 데이터가 있는 것이고, false이면 데이터가 데이터베이스에 존재하지 않거나, 탐색하는데 실패한 것이다.
    func checkDataInRealm(productID: String) -> Bool{
        guard let realm else {return false}
        if let findData = realm.objects(SearchShoppingRealmModel.self).where({ $0.productID == productID }).first {
            return true
        } else {
            return false
        }
    }
    
    func getDataInRealm(productID: String) -> SearchShoppingRealmModel? {
        guard let realm else { return nil }
        let findData = realm.objects(SearchShoppingRealmModel.self).where { $0.productID == productID }.first
        return findData
    }
    
    func getSearchResultsInRealm(productName: String) -> Results<SearchShoppingRealmModel>? {
        guard let realm else {return nil}
        let findData = realm.objects(SearchShoppingRealmModel.self).where { $0.title.contains(productName) }
        return findData
    }
    
    
}
