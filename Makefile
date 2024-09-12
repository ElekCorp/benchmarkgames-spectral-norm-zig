CXX :=g++
CFLAGS := -O3 -Wall

HEADERS := $(wildcard *.h)
SOURCES := $(wildcard *.c)
OBJECTS := $(SOURCES:%.c=%.o)

 
main: $(OBJECTS)
	$(CXX) $(CFLAGS) -o main $(OBJECTS) -lm
 
%.o: %.cpp
	$(CXX) -c $(CFLAGS) $< -o $@
 
clean:
	$(RM) $(OBJECTS)
	#O4 -fast -acc=gpu -gpu=cc61,fastmath -Mipa=fast -Minfo=all  -I/usr/include/SDL2
