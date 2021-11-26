//
//  TransferMedia.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/22.
//

import Foundation
import RealmSwift

final class TransferedMedia: Object, ObjectKeyIdentifiable {
  @Persisted(primaryKey: true) var id: UUID
  @Persisted var code: Int
  @Persisted var type: String
  @Persisted var fav = false
  @Persisted var date = Date()
  @Persisted(originProperty: "media") var log: LinkingObjects<TransferLog>
}
