import sys
import os.path
import csv
import math 
import types
import pyodbc
import time
from collections import defaultdict, Iterable
import itertools

class Apriori:
    def __init__(self, data, minSup, minConf):
        self.dataset = data
        self.transList = defaultdict(list)
        self.freqList = defaultdict(int)
        self.itemset = set()
        self.highSupportList = list()
        self.numItems = 0
        self.prepData()             # initialize the above collections

        self.F = defaultdict(list)

        self.minSup = minSup
        self.minConf = minConf

    def genAssociations(self):
        candidate = {}
        count = {}

        self.F[1] = self.firstPass(self.freqList, 1)
        k=2
        while len(self.F[k-1]) != 0:
            candidate[k] = self.candidateGen(self.F[k-1], k)
            for t in self.transList.iteritems():
                for c in candidate[k]:
                    if set(c).issubset(t[1]):
                        self.freqList[c] += 1

            self.F[k] = self.prune(candidate[k], k)
            if k > 2:
                self.removeSkyline(k, k-1)
            k += 1

        return self.F

    def removeSkyline(self, k, kPrev):
        for item in self.F[k]:
            subsets = self.genSubsets(item)
            for subset in subsets:
                if subset in (self.F[kPrev]):
                    self.F[kPrev].remove(subset)
                    

        subsets = self.genSubsets

    def prune(self, items, k):
        f = []
        for item in items:
            count = self.freqList[item]
            support = self.support(count)
            if support >= .95:
                self.highSupportList.append(item)
            elif support >= self.minSup:
                f.append(item)

        return f

    def candidateGen(self, items, k):
        candidate = []
        print ("enter candidategen",k)
        if k == 2:
            candidate = [tuple(sorted([x, y])) for x in items for y in items if len((x, y)) == k and x != y]
        else:
            candidate = [tuple(set(x).union(y)) for x in items for y in items if len(set(x).union(y)) == k and x != y]
        
        for c in candidate:
            subsets = self.genSubsets(c)
            if any([ x not in items for x in subsets ]):
                candidate.remove(c)
        print ("fnish candidategen", k)
        return set(candidate)

    def genSubsets(self, item):
        #print ("enter gensubset",item)
        subsets = []
        for i in range(1,len(item)):
            subsets.extend(itertools.combinations(item, i))
        #print ("finish gensubset", item)
        return subsets

    def genRules(self, F):
        H = []

        for k, itemset in F.iteritems():
            if k >= 2:
                for item in itemset:
                    subsets = self.genSubsets(item)
                    for subset in subsets:
                        if len(subset) == 1:
                            subCount = self.freqList[subset[0]]
                        else:
                            subCount = self.freqList[subset]
                        itemCount = self.freqList[item]
                        if subCount != 0:
                            confidence = self.confidence(subCount, itemCount)
                            if confidence >= self.minConf:
                                support = self.support(self.freqList[item])
                                rhs = self.difference(item, subset)
                                if len(rhs) == 1:
                                    H.append((subset, rhs, support, confidence))

        return H

    def difference(self, item, subset):
        return tuple(x for x in item if x not in subset)

    def confidence(self, subCount, itemCount):
        return float(itemCount)/subCount

    def support(self, count):
        return float(count)/self.numItems

    def firstPass(self, items, k):
        f = []
        for item, count in items.iteritems():
            support = self.support(count)
            if support == 1:
                self.highSupportList.append(item)
            elif support >= self.minSup:
                f.append(item)

        return f

    def prepData(self):
        key = 0
        for basket in self.dataset:
            self.numItems += 1
            key = basket[0]
            for i, item in enumerate(basket):
                if i != 0:
                    self.transList[key].append(item.strip())
                    self.itemset.add(item.strip())
                    self.freqList[(item.strip())] += 1

def main():

    if sys.version_info[0] == 2:  # Not named on 2.6
        access = 'wb'
        kwargs = {}
    else:
        access = 'wt'
        kwargs = {'newline':''}

    cnxn = pyodbc.connect('DRIVER={SQL Server Native Client 11.0};SERVER=localhost;DATABASE=Boostix;UID=sa;PWD=boostix102030')
    cursor = cnxn.cursor()
    prev_size = 0

    while True:
        curr_size = cursor.execute("Select count(*) from [dbo].[SearchHistory]").fetchone()[0]
        print prev_size
        if ((curr_size*0.9) > prev_size):
            prev_size = cursor.execute("Select count(*) from [dbo].[SearchHistory]").fetchone()[0]
            print prev_size
            print ("   " , curr_size)
            rows = cursor.execute("SELECT Words from [dbo].[SearchHistory]")

            with open(r'vectors.csv', 'wt', **kwargs) as csvfile:
                 i = 0
                 for row in rows:
                      csvfile.write(str(i) + ',' + row[0] + '\n')
                      i = i + 1

            goods = defaultdict(list)
            minSup = 0.01
            minConf = 0.3
            noRules = False


            dataset = csv.reader(open('vectors.csv', "r"))

            a = Apriori(dataset, minSup, minConf)
            print "step1"
            frequentItemsets = a.genAssociations()
            print "step2"
            cursor.execute("DELETE FROM [dbo].[AprioriRules]")
            cursor.commit()
            if not noRules:
                rules = a.genRules(frequentItemsets)
                for i, rule in enumerate(rules):
                    str1 = str(rule[0]).replace("(","").replace("'","").replace(")","").replace(" ","")
                    str2 = str(rule[1]).replace("(","").replace("'","").replace(")","").replace(" ","")
                    if str1.endswith(","):
                        str1 = str1[:-1]
                    if str2.endswith(","):
                        str2 = str2[:-1]
                    cursor.execute("INSERT into [dbo].[AprioriRules](Source,Dest) values(?,?)", str1, str2)
                    cursor.commit()
                    print ("Rule",i+1,": ",str1,"-->",str2," [sup=",rule[2]," conf=",rule[3],"]")
            print "done"
        print "sleeping"
        time.sleep(60)


if __name__ == '__main__':
    main()
