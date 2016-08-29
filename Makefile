RM=rm -f
PORT=/dev/ttyUSB0

LCD.hex: LCD.elf
	avr-objcopy -O ihex LCD.elf LCD.hex


LCD.elf: LCD.o
	avr-gcc -DF_CPU=16000000UL -mmcu=atmega328p -o LCD.elf LCD.o

LCD.o: LCD.c
	avr-gcc -Os -DF_CPU=16000000UL -mmcu=atmega328p -c -o LCD.o LCD.c

install: LCD.hex
	avrdude -F -V -c arduino -p ATMEGA328P -P $(PORT) -b 57600 -U flash:w:LCD.hex
clean:
	$(RM) LCD.elf LCD.hex LCD.o
	
