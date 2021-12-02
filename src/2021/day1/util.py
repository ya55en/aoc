def chunks(sequence, size, offset=1):
    iter_ = iter(sequence)
    try:
        chunk = [next(iter_) for _ in range(size)]
        while True:
            yield chunk.copy()
            for _ in range(offset):
                del chunk[0]
                chunk.append(next(iter_))
    except StopIteration:
        return


if __name__ == '__main__':
    import unittest


    class TestChunksIter(unittest.TestCase):

        def test_pairs_offset_1(self):
            alist = [0, 1, 2, 3, 4, 5]
            res = list(e for e in chunks(alist, 2, 1))
            expected = [[0, 1], [1, 2], [2, 3], [3, 4], [4, 5]]
            assert res == expected, f'{res!r} != {expected!r}'

        def test_triads_offset_1(self):
            alist = [0, 1, 2, 3, 4, 5]
            res = list(e for e in chunks(alist, 3, 1))
            expected = [[0, 1, 2], [1, 2, 3], [2, 3, 4], [3, 4, 5]]
            assert res == expected, f'{res!r} != {expected!r}'

        def test_tetrads_offset_2(self):
            alist = [0, 1, 2, 3, 4, 5, 6, 7, 8]
            res = list(e for e in chunks(alist, 4, 2))
            expected = [[0, 1, 2, 3], [2, 3, 4, 5], [4, 5, 6, 7]]
            assert res == expected, f'{res!r} != {expected!r}'

        def test_tetrads_offset_2__insufficient_input_yields_nothing(self):
            alist = [0, 1, 2, 3]
            res = list(e for e in chunks(alist, 5, 2))
            assert res == [], f'{res!r} != {expected!r}'


    unittest.main()
