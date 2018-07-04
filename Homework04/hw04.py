def left(i):
    return i*2+1

def right(i):
    return i*2+3

def percorri(a,i,path):

    if left(i)<len(a) and a[left(i)] == path[0]:
        return percorri(a,left(i),path[1:])
    if right(i)<len(a) and a[right(i)] == path[0]:
        return percorri(a, right(i),path[1:])
    return i


def inserisci_nodo(a, path, e_v, sdx):
    indx = left(percorri(a,1,path[1:])) if sdx else right(percorri(a,1,path[1:]))
    a[indx], a[indx + 1] = e_v[0], e_v[1]
    return a



t = "-a9b0c2d1..e3f7..g1....h6......"
path = "aceh"

print(percorri(t,1,path[1:]))
print(inserisci_nodo(t,path,"z4",1))
