/*
 When to use: different types of clients need to be handled by an injector. Allows injector to apply policies over the clients.
 
 ✓ Pros:
 - Allows to set dependencies later.
 - Allows injector to apply its policies over a client.
 - Injector can handle any client, which implements the required protocol.
 
 ✕ Cons:
 - Client becomes a dependency itself, which complicates the flow of control.
 
*/

import UIKit

let a = ""

if a.isEmpty {
    print("ok")
}
