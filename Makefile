.PHONY: all clean

all:
	$(MAKE) -C src dist

clean:
	$(MAKE) -C src clean
