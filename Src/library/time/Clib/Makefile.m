AR= lib
CC = cl
CFLAGS = -Ox -nologo  -I$(EIFFEL4)\bench\spec\$(PLATFORM)\include
LIBS = 
MAKE = nmake
MV = copy
RANLIB = echo
RM = del

all:: clean datetime.lib

.c.obj:
	$(CC) $(CFLAGS) -c $<

OBJECTS = datetime.obj

datetime.lib: $(OBJECTS)
	$(RM) $@
	$(AR) -OUT:$@ $(OBJECTS)
	if not exist ..\spec mkdir ..\spec
	if not exist ..\spec\msc mkdir ..\spec\msc
	if not exist ..\spec\msc\lib mkdir ..\spec\msc\lib
	$(MV) $@ ..\spec\msc\lib

clean:
	$(RM) datetime.lib $(OBJECTS)
