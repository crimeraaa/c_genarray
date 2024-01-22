# -*- DIRECTORIES ------------------------------------------------------------*-

BINDIR = ./bin
OBJDIR = ./obj

# -*- BUILD TARGETS ----------------------------------------------------------*-

EXE = $(BINDIR)/main
SRC = $(wildcard *.c)
OBJ = $(patsubst %.c, $(OBJDIR)/%.o, $(SRC))
INCLUDE = $(wildcard *.h)

# Since %.o: %.c is an intermediate target, its result is removed automatically.
# So mark it as "PRECIOUS" to avoid that.
# Actually the real target is more like: ./obj/%.o: ./%.c
# - https://stackoverflow.com/a/15191011
.PRECIOUS: $(OBJDIR)/%.o

# -*- BEGIN RECIPES ----------------------------------------------------------*-

all: $(EXE)
	
$(BINDIR) $(OBJDIR):
	$(MKDIR) $@

$(EXE): $(OBJ) | $(BINDIR)
	$(CC) $(DEBUGFLAGS) $(CFLAGS) -o $@ $^

$(OBJDIR)/%.o: %.c $(INCLUDE) | $(OBJDIR)
	$(CC) $(DEBUGFLAGS) $(CFLAGS) -c -o $@ $<
	
clean:
	$(RM) $(OBJ) $(EXE)

# -*- END RECIPES ------------------------------------------------------------*-

.PHONY: all clean
