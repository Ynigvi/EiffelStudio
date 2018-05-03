LIB = libminizip.a

UNAME := $(shell uname -s)

ifeq ($(UNAME), Linux)
SRC = ioapi.c \
			miniunz.c \
			minizip.c \
			mztools.c \
			unzip.c \
			zip.c
else
SRC = ioapi.c \
			iowin32.c \
			miniunz.c \
			minizip.c \
			mztools.c \
			unzip.c \
			zip.c
endif

OBJ = $(SRC:%.c=%.o)

all: $(LIB)

$(LIB): $(OBJ)
	$(AR) rcs $(LIB) *.o $(ISE_LIBRARY)/C_library/zlib/libz.a

$(OBJ): %.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@ $(ISE_LIBRARY)/C_library/zlib/libz.a

clean:
	$(RM) $(LIB) $(OBJ)

