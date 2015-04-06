# RT-thread on STM32F103C8 minimal board

## Build

export RTT\_ROOT=$(PWD)/rt-thread
scons

## Flash

st-flash rtthread.bin 0x8000000
