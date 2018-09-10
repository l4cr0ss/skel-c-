#-----------------------------------------------------------------------------#
#
# Makefile for .
# ............................................................................
#
# Builds these binaries:
#	> 
#
#-----------------------------------------------------------------------------#

#-----------------------------------------------------------------------------#
#
# Targets are:
# ............................................................................
# 	all 	- build the release and debug binaries
# 	clean - remove all binary files
# 	debug - build the debug binary into the dbg/ directory
#	  test  - build the test binary into the test/ directory
#	  release	- build the release binary into the bin/ directory
#
#-----------------------------------------------------------------------------#

#......	Compiler Flags	
CC = g++
INC = -Iinc/  
CFLAGS 	= -Wall -Wextra $(INC) -std=c++14
LDFLAGS =
#.............................................................................

#...... Install paths 
HEADERS = 
INSTALL = 
#.............................................................................

#...... Version information
VMAJ = .0
VMIN = .0
VETC = .1
VERSION = $(VMAJ)$(VMIN)$(VETC)
#.............................................................................

#......	Project files
SRCDIR = src
SRCS = 
OBJS = $(SRCS:.cpp=.o)
EXE = 
HDRNAME = $(EXE).h
SONAME = $(EXE).so
#.............................................................................

#......	Debug build settings
DBGDIR = dbg
DBGEXE = $(DBGDIR)/$(EXE)
DBGOBJS = $(addprefix $(DBGDIR)/, $(OBJS))
DBGCFLAGS = -g -O0 -DDEBUG
#.............................................................................

#......	Release build settings
RELDIR = bin
RELEXE = $(RELDIR)/$(EXE)
RELOBJS = $(addprefix $(RELDIR)/, $(OBJS))
RELCFLAGS = -O3 -DNDEBUG
#.............................................................................

#...... Test build settings
TESTDIR = test
TESTEXE = $(TESTDIR)/$(EXE)
TESTOBJS = $(addprefix $(DBGDIR)/, $(OBJS))
TESTCFLAGS = -g -O0 -DDEBUG
#.............................................................................

.PHONY: all clean debug prep release test

#------	Default build
all: prep release debug test

#------ Debug build
debug: $(DBGEXE)

$(DBGEXE): $(DBGOBJS)
	$(CC) $(CFLAGS) $(DBGCFLAGS) -o $(DBGEXE) $^ $(LDFLAGS)

$(DBGDIR)/%.o: $(SRCDIR)/%.cpp
	$(CC) -c $(CFLAGS) $(DBGCFLAGS) -o $@ $< $(LDFLAGS) 

#------ Release build
release: $(RELEXE)

$(RELEXE): $(RELOBJS)
	$(CC) $(CFLAGS) $(RELCFLAGS) -o $(RELEXE) $^ $(LDFLAGS)

$(RELDIR)/%.o: $(SRCDIR)/%.cpp
	$(CC) -c $(CFLAGS) $(RELCFLAGS) -o $@ $< $(LDFLAGS) 

#------ Test build
test: $(TESTEXE)

$(TESTEXE): $(TESTOBJS)
	$(CC) $(CFLAGS) $(TESTCFLAGS) -o $(TESTEXE) $^ $(LDFLAGS)

$(TESTDIR)/%.o: $(SRCDIR)/%.cpp
	$(CC) -c $(CFLAGS) $(TESTCFLAGS) -o $@ $< $(LDFLAGS)

#------ Internal targets
prep:
	@mkdir -p $(DBGDIR) $(RELDIR) $(TESTDIR)

remake: clean all

clean:
	rm -f $(RELEXE) $(RELOBJS) $(DBGEXE) $(DBGOBJS) $(TESTEXE) $(TESTOBJS)

