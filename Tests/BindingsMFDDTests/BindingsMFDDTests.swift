import XCTest
@testable import BindingsMFDD
import Interpreter
import AST
import DDKit

final class BindingsMFDDTests: XCTestCase {
  
  func testExample() {
    
    let net = Binding(values: Array(0...10), variables: ["x","y","z"])
    let factory = MFDDFactory<String,Int>()
    
    let s: Stopwatch = Stopwatch()
    
    let bindings = net.computeBindings(factory: factory)
    print(bindings)
    
    print("----------------------------------")
    print(s.elapsed.humanFormat)
    print("----------------------------------")

  }
  
  func testBindings() {

    let module: String = """
      
    func add(_ x: Int, _ y: Int) -> Int ::
      x + y

    func test(_ b: Bool) -> Bool ::
      not(b)
    """
    
    
    var interpreter = Interpreter()
    try! interpreter.loadModule(fromString: module)
    
    let code: String = "not(true) = test(false)"
    let value = try! interpreter.eval(string: code)
//    print(type(of:value))
//    print(value)
  }
  
  func testo() {
    let factory = MFDDFactory<String, Int>()
    var diagram = factory.encode(family: [[:]])
    //print(diagram)
    //print(type(of:diagram))

    // let morphism = factory.morphisms.insert(assignments: [2: "baz"])
    // print(morphism.apply(on: diagram))


    let one = factory.one.pointer

    var dic: [Int: MFDDFactory<String, Int>.DD.Pointer] = [:]
    // dic.reserveCapacity(borne_sup - borne_inf)
    
    let z = factory.node(key: "z", take: [1:one], skip: factory.zero.pointer)

    let y = factory.node(key: "y", take: [1:z], skip: factory.zero.pointer)

    let x = factory.node(key: "x", take: [1:one ,2:y], skip: factory.zero.pointer)
           
//  print(Array(MFDD(pointer: x, factory: factory)))
     
//  diagram = factory.encode(family: [["c": 1], ["c": 2]])
//  print(diagram)

  }
  
  func testTime() {
    
//    let s: Stopwatch = Stopwatch()
//
//    let x = combos(elements: Array(1...100), k: 4)
//
//    print("----------------------------------")
//    print(s.elapsed.humanFormat)
//    print("----------------------------------")

  }

  static var allTests = [
      ("testExample", testExample),
  ]
}
