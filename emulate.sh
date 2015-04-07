#!/bin/sh

QEMU_STM32=../qemu_stm32/arm-softmmu/qemu-system-arm
KERNEL=rtthread.bin

emulate () {
    $QEMU_STM32 -M stm32-p103 \
	    -monitor stdio \
	    -kernel $KERNEL \
	    -semihosting
}

emulate_dbg () {
    $QEMU_STM32 -M stm32-p103 \
	    -monitor stdio \
	    -gdb tcp::3333 -S \
	    -kernel $KERNEL -semihosting 2>&1>/dev/null & \
	echo $$! > qemu_pid && \
	arm-none-eabi-gdb -x gdbscript && \
	cat qemu_pid | `xargs kill 2>/dev/null || test true` && \
	rm -f qemu_pid
}

if [ $1 == "-d" ]; then
    emulate_dbg
else
    emulate
fi
