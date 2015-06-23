all: lib


SOURCESCPP = RESTEngine.cpp RESTCallBack.cpp RESTParameters.cpp
SOURCESTEST = main.cpp
OBJECTS=$(SOURCESCPP:.cpp=.o)
OBJECTSTEST=$(SOURCESTEST:.cpp=.o)
JSONFOLDER = ../json
CFLAGS=-I $(JSONFOLDER) -g -std=c++11
LDFLAGS=
STATICMODULE=rest.a

clean:
	-rm *.o
	-rm *.a
	-rm a.out

.cpp.o:
	$(CXX) -c $(CFLAGS) $< -o $@

.PHONY: json
json:
	cd $(JSONFOLDER) && make
	cp $(JSONFOLDER)/json.a ./

lib: json $(OBJECTS) main.cpp
	$(AR) rcs $(STATICMODULE) $(OBJECTS)
	$(CXX) $(CFLAGS) main.cpp $(STATICMODULE) $(JSONFOLDER)/json.a

