from foo.bar import primes


def test_simple():
    inp = primes(10)
    ref = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
    
    for ii, rr in zip(inp, ref):
        assert ii == rr

