// Collections library - List utilities

fn | map_list(list | items, fn | transform) > {
    list | result -> []
    
    for(item in items):
        result.push(transform(item))
    
    result
}

fn | filter_list(list | items, fn | predicate) > {
    list | result -> []
    
    for(item in items):
        cond(predicate(item)):
            true: result.push(item)
    
    result
}

fn | reduce_list(list | items, any | initial, fn | reducer) > {
    any | acc -> initial
    
    for(item in items):
        acc = reducer(acc, item)
    
    acc
}
