.PHONY: dist clean 

## - if you have multiple versions, pick the highest one
OTP_LIB_DIR:= $(shell erl -noshell -eval 'io:format("~s", [code:lib_dir()])' -s erlang halt)
EI=$(shell ls -d $(OTP_LIB_DIR)/erl_interface* | sort -n |tail -1)
VER=1.0.1
DIST=../libgeoip-$(VER)
LIBGEOIP=geoipport

## - default macports install location for libgeoip
GEOIP_LIBS=/opt/local

.SUFFIXES: .beam .erl
ERL_FILES=$(wildcard *.erl)
DIST_ERL=$(ERL_FILES:%erl=$(DIST)/ebin/%beam)


dist: $(DIST) $(DIST_ERL) $(LIBGEOIP) $(DIST)/ebin/libgeoip_app.app \
$(DIST)/priv/$(LIBGEOIP) $(DIST)/include/libgeoip.hrl

## - Setting up directory structure

$(DIST):
	mkdir -p $(DIST)/{src,ebin,priv,include}

$(DIST)/priv/$(LIBGEOIP): $(LIBGEOIP)
	cp $(LIBGEOIP) $(DIST)/priv

$(DIST)/include/libgeoip.hrl: libgeoip.hrl
	cp libgeoip.hrl $(DIST)/include

$(DIST)/ebin/libgeoip_app.app: libgeoip_app.app
	cp $< $(dir $@)

## - Compiling erl and the port

$(DIST)/ebin/%.beam: %.erl Makefile
	erlc -W +debug_info -o $(dir $@)  $<
	cp $< $(DIST)/src

$(LIBGEOIP): geoipport.c erl_comm.c geohash.c Makefile
	gcc -Wall -Os -L$(GEOIP_LIBS)/lib -I$(GEOIP_LIBS)/include \
-L$(EI)/lib/ -I$(EI)/include/ \
-o $(LIBGEOIP) erl_comm.c geoipport.c geohash.c -lerl_interface -lei -lGeoIP \
-lpthread

## - Comments are fun

clean:
	rm -rf $(LIBGEOIP) $(DIST)
