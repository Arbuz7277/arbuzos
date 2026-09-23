ASM     := nasm
CXX     := g++
AFLAGS  := -f elf32
CFLAGS  := -m32 -ffreestanding -nostdlib -fno-pie -fno-stack-protector -fno-exceptions -fno-rtti -fno-asynchronous-unwind-tables -Ikernel/include -O2 -Wall -Wextra -c

TARGET  := arbuzos.img
BUILD   := build

# Список объектных файлов для линковки
OBJS    := $(BUILD)/pmode.o $(BUILD)/kernel.o $(BUILD)/kernel_panic.o $(BUILD)/print.o $(BUILD)/idt.o $(BUILD)/idt_handlers.o

all: $(TARGET)

# Создаем папку build, если её нет
$(BUILD):
	mkdir -p $(BUILD)

# 1. Линковка всех объектных файлов в ELF
$(BUILD)/kernel.elf: $(OBJS) link.ld | $(BUILD)
	ld -m elf_i386 -T link.ld -o $@ $(OBJS)

# 2. Превращение ELF в плоский бинарник
$(BUILD)/kernel.bin: $(BUILD)/kernel.elf
	objcopy -O binary $< $@

# 3. Сборка загрузчика (остается плоским бинарником)
$(BUILD)/boot.bin: boot.asm | $(BUILD)
	$(ASM) -f bin $< -o $@

# 4. Создание образа диска
$(TARGET): $(BUILD)/boot.bin $(BUILD)/kernel.bin
	dd if=/dev/zero of=$@ bs=1M count=1
	dd if=$(BUILD)/boot.bin of=$@ conv=notrunc
	dd if=$(BUILD)/kernel.bin of=$@ bs=512 seek=1 conv=notrunc

# Правила компиляции
$(BUILD)/pmode.o: pmode.asm | $(BUILD)
	$(ASM) $(AFLAGS) $< -o $@

$(BUILD)/idt_handlers.o: kernel/idt/idt.asm | $(BUILD)
	$(ASM) $(AFLAGS) $< -o $@

$(BUILD)/kernel.o: kernel/kernel.cpp | $(BUILD)
	$(CXX) $(CFLAGS) $< -o $@

$(BUILD)/kernel_panic.o: kernel/kernel_panic.cpp | $(BUILD)
	$(CXX) $(CFLAGS) $< -o $@

$(BUILD)/print.o: kernel/drivers/print.cpp kernel/include/print.hpp | $(BUILD)
	$(CXX) $(CFLAGS) $< -o $@

$(BUILD)/idt.o: kernel/idt/idt.cpp kernel/include/idt.hpp | $(BUILD)
	$(CXX) $(CFLAGS) $< -o $@

clean:
	rm -rf $(BUILD) $(TARGET)
