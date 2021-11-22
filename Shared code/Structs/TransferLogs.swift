//
//  TransferLogs.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/22.
//

import SwiftUI
import RealmSwift

final class TransferLog: Object, ObjectKeyIdentifiable {
  @Persisted(primaryKey: true) var id: UUID
  @Persisted var date: Date
  @Persisted var note: String?
  @Persisted var fav = false
  @Persisted(originProperty: "logs") var list: LinkingObjects<TransferLogList>
}

final class TransferLogList: Object, ObjectKeyIdentifiable {
  @Persisted(primaryKey: true) var id: UUID
  @Persisted var logs = RealmSwift.List<TransferLog>()
}
