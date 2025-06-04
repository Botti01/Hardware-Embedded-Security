CC = gcc
CFLAGS = -Wall -Wextra -O2 -mrdseed -mrdrnd
INCLUDES = -I../3_trng/ -I../2_lfsr/
SRCDIR1 = ../3_trng
SRCDIR2 = ../2_lfsr

SRCS = main.c \
       $(SRCDIR1)/trng.c \
       $(SRCDIR1)/drng.c \
       $(SRCDIR2)/lfsr.c

OBJS = $(SRCS:.c=.o)

EXEC = main

.PHONY: all clean

all: $(EXEC)

$(EXEC): $(OBJS)
	$(CC) $(CFLAGS) $(INCLUDES) $(OBJS) -o $@

%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

clean:
	rm -f $(OBJS) $(EXEC)

