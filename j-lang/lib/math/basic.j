// Math library - Basic operations

fn | abs(int | x) > {
    cond(x):
        x < 0: -x
        _: x
}

fn | max(int | a, int | b) > {
    cond(a > b):
        true: a
        false: b
}

fn | min(int | a, int | b) > {
    cond(a < b):
        true: a
        false: b
}

fn | pow(int | base, int | exp) > {
    int | result -> 1
    int | i -> 0
    
    while(i < exp):
        result = result * base
        i = i + 1
    
    result
}
