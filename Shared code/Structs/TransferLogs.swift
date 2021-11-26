//
//  TransferLogs.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/22.
//

import Foundation
import RealmSwift

final class TransferLog: Object, ObjectKeyIdentifiable {
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var date: Date
  @Persisted var media = RealmSwift.List<TransferedMedia>()
  @Persisted(originProperty: "logs") var list: LinkingObjects<TransferLogList>
  
  override init() {
    super.init()
    self.date = Date()
  }
}

final class TransferLogList: Object, ObjectKeyIdentifiable {
  @Persisted(primaryKey: true) var id = UUID()
  @Persisted var logs = RealmSwift.List<TransferLog>()
}
