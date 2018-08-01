[![](https://img.shields.io/docker/pulls/lapinlabs/watcom.svg)](https://hub.docker.com/r/lapinlabs/watcom/)

# Watcom Docker Build Environment

The purpose of this image is to provide a pre-built environment for the [OpenWatcom V2](https://github.com/open-watcom/open-watcom-v2/blob/master/projects.txt) packages.

For most use case just pull from Dockerhub or use as a base image.


To explore the environment:
```
$ docker run -it lapinlabs/watcom sh
```

To build something:
```
$ echo -e '#include <stdio.h>\nint main() { printf("Hello World\\n"); }' > hello.c
$ docker run --rm -v `pwd`:/tmp lapinlabs/watcom bwcc /tmp/hello.c -fo=/tmp/hello
```

Tools included:
```
aliasgen      -
bcwc          -
bdmpobj       -
bedbind       -
bide2mak      -
bmp2eps       -
boot.log      -
bootx.log     -
builder       -
bwasaxp       -
bwasm         -
bwasmps       -
bwasppc       -
bwbind        -
bwcc          -
bwcc386       -
bwcl          -
bwcl386       -
bwdis         -
bwhc          -
bwipfc        -
bwlib         -
bwlink        -
bwpp          -
bwpp386       -
bwrc          -
bwstrip       -
comstrip      - strip comments from packing manifests
crlf          -
dlgprs        -
errsrc        -
findhash      -
genverrc      -
hcdos         - help compiler for .ihp help files used by whelp
langdat       -
mkexezip      -
mkinf         -
msgencod      -
objchg        -
objfind       -
objlist       -
objxdef       -
objxref       -
optencod      -
parsectl      -
parsedlg      - Windows to OS/2 dialog resource convertor
parsedyn      -
re2c          - regexp-to-c lexer generator
ssl           - expression parser generator for debugger
sweep         - run given command in directory tree
uzip          -
vicomp        -
wcpp          -
whpcvt        - convert WHP files (WATCOM Help) into OS dependent help files.
wmake         - watcom make
wsplice       - text file processor
yacc          - yet another compiler-compiler
```
