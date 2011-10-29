CC = upcc 
UPCC = upcc
FLAGS = -I./src/headers -I./src -I./common 
LDFLAGS =
CCFLAGS = -g
UPCCFLAGS = -g 

OBJECT_DIRECTORY := common/obj
SOURCE_DIRECTORY := src
DEMO_DIRECTORY := $(SOURCE_DIRECTORY)/demos
TEST_DIRECTORY := $(SOURCE_DIRECTORY)/tests
VPATH := $(OBJECT_DIRECTORY) $(SOURCE_DIRECTORY) $(DEMO_DIRECTORY) $(TEST_DIRECTORY)

OBJECTS := $(patsubst $(SOURCE_DIRECTORY)/%.upc, $(OBJECT_DIRECTORY)/%.o, $(wildcard $(SOURCE_DIRECTORY)/*.upc))
DEMO_OBJECTS := $(OBJECTS) $(patsubst $(DEMO_DIRECTORY)/%.upc, $(OBJECT_DIRECTORY)/%.o, $(wildcard $(DEMO_DIRECTORY)/*.upc))
TEST_OBJECTS := $(OBJECTS) $(patsubst $(TEST_DIRECTORY)/%.upc, $(OBJECT_DIRECTORY)/%.o, $(wildcard $(TEST_DIRECTORY)/*.upc))

DEMO := demo
TEST := test

#
# UPC and C/C++ compilation rules, with 
# dependency generation: 
#
$(OBJECT_DIRECTORY)/%.o : %.c 
	$(CC) -c $^ $(CCFLAGS) $(FLAGS) -o $@ 
	$(CC) -M $^ $(CCFLAGS) $(FLAGS) > $@.dep 
$(OBJECT_DIRECTORY)/%.o : %.upc 
	$(UPCC) -c $^ $(UPCCFLAGS) $(FLAGS) -o $@ 
	$(UPCC) -M $^ $(UPCCFLAGS) $(FLAGS)  > $@.dep
#
# Pick up generated dependency files, and
# add /dev/null because gmake does not consider 
# an empty list to be a list: 
#
include  $(wildcard *.dep) /dev/null 


$(DEMO) : $(DEMO_OBJECTS) 
	$(UPCC) $(DEMO_OBJECTS) $(LDFLAGS) -o $@ 

$(TEST) : $(TEST_OBJECTS)
	$(UPCC) $(TEST_OBJECTS) $(LDFLAGS) -o $@

clean :  
	$(RM) $(DEMO_OBJECTS) $(TEST_OBJECTS) $(OBJECT_DIRECTORY)/*.dep $(DEMO) $(TEST) 



