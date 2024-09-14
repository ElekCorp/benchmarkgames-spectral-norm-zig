CXX :=g++
CFLAGS := -O3 -Wall

#HEADERS := $(wildcard *.h)
SOURCES := $(wildcard *.c)
OBJECTS := $(SOURCES:%.c=%.o)

 
main: $(OBJECTS) main_static
	$(CXX) $(CFLAGS) -o main main.o -lm

main_static: $(OBJECTS) 
	$(CXX) $(CFLAGS) -o main_static main_static.o -lm 

%.o: %.cpp
	$(CXX) -c $(CFLAGS) $< -o $@
 
clean:
	$(RM) $(OBJECTS)
	$(RM) main main_static
	#O4 -fast -acc=gpu -gpu=cc61,fastmath -Mipa=fast -Minfo=all  -I/usr/include/SDL2
