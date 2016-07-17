#!/usr/bin/env python

from subprocess import call

import argparse


#Get command line options
parser = argparse.ArgumentParser(description='APB Run Script Options')

#Get APB testnames from command
parser.add_argument('-t', type=str, help='Enter APB testname')

parser.add_argument('--clean', action='store_true', help='Clean LOGs..')
parser.add_argument('--gui', action='store_true', help='GUI Simulation')

args = parser.parse_args()


def create_lib():
    call(['vlib work'], shell=True)
    call(['vmap work work'], shell=True)

def compile_files():
    call(['vlog -work work -f apb_inc.f +define+UVM_NO_DPI'], shell=True)

def simulate():
    if args.gui:
        call(['vsim work.top -do "run -all;" -sv_seed random +UVM_TESTNAME={0}'.format(args.t)], shell=True)
    else:
        call(['vsim work.top -c -do "run -all; exit;" -sv_seed random +UVM_TESTNAME={0}'.format(args.t)], shell=True)


def clean():
    call(['rm -r modelsim.ini transcript vsim.wlf work'], shell=True)


def main():

    if args.clean:
        clean()
    else:
        create_lib()
        compile_files()
        simulate()


if __name__ == '__main__':
    main()

