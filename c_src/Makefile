.PHONY: dist clean 

## - if you have multiple versions, pick the highest one
OTP_LIB_DIR:= $(shell erl -noshell -eval 'io:format("~s", [code:lib_dir()])' -s erlang halt)
EI=$(shell ls -d $(OTP_LIB_DIR)/erl_interface* | sort -n |tail -1)
LIBGEOIP=../priv/libgeoip

## - default macports install location for libgeoip
GEOIP_LIBS=/opt/local

dist: $(LIBGEOIP)

$(LIBGEOIP): geoipport.c erl_comm.c geohash.c Makefile
	@mkdir -p ../priv
	gcc -Wall -Os -L$(GEOIP_LIBS)/lib -I$(GEOIP_LIBS)/include \
-L$(EI)/lib/ -I$(EI)/include/ \
-o $(LIBGEOIP) erl_comm.c geoipport.c geohash.c -lerl_interface -lei -lGeoIP \
-lpthread

## - Comments are fun

clean:
	rm -f $(LIBGEOIP)
