//
//  DoublyLinkedList.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 1/26/22.
//

import Foundation


class DoublyLinkedList<T> {
    
    
    class Node<T> {
        var payload: T
        var previous: Node<T>?
        var next: Node<T>?
        
        init(payload: T) {
            self.payload = payload
        }
    }
    
    private(set) var count: Int = 0
    private var head: Node<T>?
    private var tail: Node<T>?

}









