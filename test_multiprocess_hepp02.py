#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 16 14:05:44 2024

@author: gert
"""


# from joblib import Parallel, delayed

from multiprocessing import Process
import time



def testfunc(secs):
    
    time.sleep(secs)
    print("hey", flush=0)

class Timer():
    
    def __init__(self):
        self.start_time = None
        self.stop_time = None
    
    def start(self):
        self.start_time = time.time()
        
    def stop(self,what="Elapsed time"):
        self.stop_time = time.time()
        h,m,s = Timer.process_time(self.stop_time-self.start_time)
        print(what + ": "+str(h)+" h, "+str(m)+" min, "+str(s)+" sec.")
    
    @staticmethod
    def process_time(s):
        h = int(s/3600)
        m = int((s-3600*h)/60)
        s = int(s-3600*h-60*m)
        return h, m, s


secs = 10
n_jobs = 5
parallel = 0

T = Timer()

processes = []

if __name__ == "__main__":

    T.start()

    if parallel:
        for _ in range(n_jobs):
            print("Starting new job")
            processes.append(Process(target=testfunc,args=(secs/n_jobs,)))
            processes[-1].start()
        
        for p in processes:
            p.join()

    else:
        for _ in range(n_jobs):
            print("Starting new job")
            testfunc(secs/n_jobs)
    
    T.stop()

