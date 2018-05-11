
def funzRic1(l):
    n = l[0]
    _f1(l,1)
def _f1(l, i, flag=False):
    left = 2*i
    right = left+1
    if isFoglia(l, i):
        return print("("+str(l[i])+")", end="")
    else:
        print("(", end="")
        _f1(l, left, flag)
        if l[i] == -1:
            print("*", end="")
        if l[i] == -2:
            print("+", end="")
        if l[i] == -3:
            print("-", end="")
        if l[i] == -4:
            print("^", end="")
            flag = True
        _f1(l, right, flag)
        print(")", end="")
    return

def funzRic2(l):
    _f2(l,1)

def _f2(l, i):
    left = 2*i
    right = left+1
    if isFoglia(l, i): return
    if isFoglia(l, left) and isFoglia(l, right):
        if l[i] == -1:
            l[i] = l[left]*l[right]
        if l[i] == -2:
            l[i] = l[left]+l[right]
        if l[i] == -3:
            l[i] = l[left]-l[right]
        if l[i] == -4:
            l[i] = pow(l[left],abs(l[right]))
        l[left], l[right] = -666, -666

    _f2(l, left)
    _f2(l, right)


def isFoglia(l, i):
    left = 2 * i
    right = left + 1
    return left > l[0] or l[left] == -666


if __name__ == "__main__":
    l3jnjn = [15, -1,-2, -3,3, -1, 7, -3,-666, -666, 5, 8, -666, -666, 6, 9]
    l2dsjn = [15, -1, -2, -3, 3, 40, 7, -3, -666, -666, -666, -666, -666, -666, -666, -666]
    l3asas = [16,-2,-4,-2,-666,-666,10,-3,-666,-666,-666,-666,-666,-666,1,1,-666]
    l3asd = [3,-3,5000,-7000]
    l3sx = [6,-42,-666,-666,-666,-666,-666]
    l3 = [1,42]
    funzRic1(l3)
    print()
    while l3[0] >1 and l3[2] != -666:
        funzRic2(l3)
        funzRic1(l3)
        print()
    #funzRic1(l3)

    #while True:
    #    funzRic1(l3)
    #    funzRic2(l3)
    #    print()
    #    if l3[0] == 1: break
        #if l3[2] == -666 and l3[3] == -666: break
    #    elif l3[2] == -666:
    #        funzRic1(l3)
    #        break