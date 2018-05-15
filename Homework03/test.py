#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: gianpcr
"""
import os
import filecmp
import sys

path = ''
testFolder = path + 'testhw'
inFolder = testFolder + '/in'
outFolder = testFolder + '/out'

testNames = []

# Crea le cartelle se non esistono

if not os.path.exists(inFolder):
    os.makedirs(inFolder)

if not os.path.exists(outFolder):
    os.makedirs(outFolder)

# Genera i file .txt per i test

for f in os.listdir(testFolder):
    if os.path.isfile(testFolder + '/' + f):
        try:
            splt = f.split('.')
            fname =  splt[0] + '.txt'
            savePath = (inFolder if splt[1] == 'in' else outFolder) + '/' + fname
            if splt[1] == 'in':
                testNames.append(fname)
            with open(testFolder + '/' + f) as b:
                with open(savePath, 'w+') as w: 
                    w.write(b.read())
        except: pass
    

programName = ''
try:
    programName = str(sys.argv[1])
    marsJar = str(sys.argv[2])
except: 
    print('Nome del file .asm errato')
    sys.exit(1)

successCount = 0

# avvia i test
for test in testNames:
    inFile = inFolder + '/' + test
    outFile = outFolder + '/' + 'run_' + test
    res = os.system('java -jar ' + marsJar + ' me nc sm ic ' + programName + ' < ' + inFile + ' > ' + outFile)

    if filecmp.cmp(outFile, outFolder + '/' + test):
        print("TEST " + test + " OK")
        successCount += 1
    else:
        print("TEST " + test + " ERRORE")

print(str(successCount) + " Test su " + str(len(testNames)) + " eseguiti correttamente")
