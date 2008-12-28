.PHONY: dist clean 

## - if you have multiple versions, pick the highest one
EI=$(shell ls -d /usr/local/lib/erlang/lib/erl_interface* | sort -n |tail -1)
DIST=../dist
LIBGEOIP=geoipport

## - default macports install location for libgeoip
GEOIP_LIBS=/opt/local


dist: ../dist/ $(LIBGEOIP) $(DIST)/ebin/libgeoip.beam \
$(DIST)/priv/$(LIBGEOIP) $(DIST)/include/libgeoip.hrl $(DIST)/src/libgeoip.erl

## - Setting up directory structure

../dist/:
	mkdir -p $(DIST)/{src,ebin,priv,include}

$(DIST)/priv/$(LIBGEOIP): $(LIBGEOIP)
	cp $(LIBGEOIP) $(DIST)/priv

$(DIST)/include/libgeoip.hrl: libgeoip.hrl
	cp libgeoip.hrl $(DIST)/include

$(DIST)/src/libgeoip.erl: libgeoip.erl
	cp libgeoip.erl $(DIST)/src

## - Compiling erl and the port

$(DIST)/ebin/libgeoip.beam: libgeoip.erl
	erlc -W +debug_info -o $(DIST)/ebin libgeoip.erl

$(LIBGEOIP): geoipport.c erl_comm.c geohash.c Makefile
	gcc -Wall -Os -L$(GEOIP_LIBS)/lib -I$(GEOIP_LIBS)/include \
-L$(EI)/lib/ -I$(EI)/include/ \
-o $(LIBGEOIP) erl_comm.c geoipport.c geohash.c -lerl_interface -lei -lgeoip

## - Comments are fun

clean:
	rm -rf $(LIBGEOIP) $(DIST)
