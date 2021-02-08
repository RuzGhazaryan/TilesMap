//
//  TableViewDataSource.swift
//  TilesMap
//
//  Created by Ruzanna Ghazaryan on 2/6/21.
//

import UIKit

public class TableViewDataSource<CELL: UITableViewCell, T> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier: String!
    private var items: [T]!
    var configureCell: (CELL, T) -> () = { _, _ in }
    
    public init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CELL else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        return cell
    }
}
