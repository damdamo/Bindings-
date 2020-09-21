import Interpreter
import AST
import DDKit

struct Binding<T: Equatable> {
  
  typealias IDValues = [Int: T]
  typealias DicIntPointer = [Int: MFDD<String,Int>.Pointer]
  
  let values: [T]
  let variables: [String]
  
  func computeBindings(factory: MFDDFactory<String, Int>, vars: [String], values: [Int]) -> MFDD<String,Int>.Pointer {
    var take:DicIntPointer = [:]
    if vars.count == 0 {
      return factory.one.pointer
    }
    for i in values {
      take[i] = computeBindings(factory: factory, vars: Array(vars.dropFirst()), values: values.filter({$0 != i}))
    }
    return factory.node(key: vars.first!, take: take, skip: factory.zero.pointer)
  }
  
  // Compute the bindings for all values depending of the variables
  func computeBindings(factory: MFDDFactory<String, Int>) -> MFDD<String, Int> {
    let pointer = computeBindings(factory: factory, vars: self.variables, values: Array(0...(self.values.count-1)))
    return MFDD(pointer: pointer, factory: factory)
  }
  
  // Index all values by an Integer
  func indexValues() -> [Int: T] {
    var indexDic: [Int: T]  = [:]
    var count = 0
    for val in values {
      indexDic[count] = val
      count += 1
    }
    return indexDic
  }
  
  // Function to order keys
  func orderKeys() -> [String] {
    return variables.sorted(by: {$0 > $1})
  }
  
  func checkConditions() -> Bool {
    return true
  }
  
  
}

//  func computeBindings(){
//    let factory = MFDDFactory<String, Int>()
//    let listIndex: [Int] = Array(0...values.count-1)
//    let permutations = combos(elements: listIndex, k: variables.count)
//    var takeList: [Int] = []
//    var count = variables.count
//    var take: DicIntPointer = [:]
//    // var target = factory.one.pointer
//    // let indexVal: [Int: T] = indexValues()
//    var node = factory.one.pointer
//
//    for perm in permutations {
//      takeList = listIndex.filter({(i: Int) -> Bool in return !perm.contains(i)})
//      print(takeList)
//      for variable in self.orderKeys() {
//        take = takeList.reduce(into: [:]) {res, el in res[el] = node}
//        print(take)
//        node = factory.node(key: variable, take: take, skip: factory.zero.pointer)
//        print(MFDD(pointer: node, factory: factory))
//
//        count -= 1
//      }
//      // print(MFDD(pointer: node, factory: factory))
//      count = variables.count
//      node = factory.one.pointer
//    }
//    // var diagram = factory.encode(family: [[:]])
//  }

