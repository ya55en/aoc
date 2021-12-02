#! /usr/bin/env python3

import os
import sys
from functools import reduce

sys.path.append(os.path.dirname(__file__))
from util import chunks

print(reduce(
    lambda c, a: c + int(a[1] > a[0]),
    chunks((sum(e) for e in chunks((int(l) for l in sys.stdin), 3)), 2),
    0,
))
