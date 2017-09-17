#
# This file is generated automatically.  Do not edit.
# Your changes will be lost.  See sys/unix/NewInstall.unx.
# Identify this file:
MAKEFILE_DOC=1

###
### Start hints/devnull PRE
###
# (new segment at source line 6 )
# hints file for devnull game server.
# target environment is a debian "jessie" docker container.
# hackdir is /devnull/nethackdir
# adapted from the "linux" hints file in the dist.


PREFIX=/opt/devnull
HACKDIR=$(PREFIX)/$(GAME)dir
SHELLDIR = $(PREFIX)/bin
INSTDIR=$(HACKDIR)
VARDIR = $(HACKDIR)



POSTINSTALL=cp -n sys/unix/sysconf $(INSTDIR)/sysconf; $(CHOWN) $(GAMEUID) $(INSTDIR)/sysconf; $(CHGRP) $(GAMEGRP) $(INSTDIR)/sysconf; chmod $(VARFILEPERM) $(INSTDIR)/sysconf;

CFLAGS=-g -O -I../include -DNOTPARMDECL $(CFLAGS1) -DDLB -DLINUX
CFLAGS1=-DCOMPRESS=\"/bin/gzip\" -DCOMPRESS_EXTENSION=\".gz\"
CFLAGS+=-DSYSCF -DSYSCF_FILE=\"$(HACKDIR)/sysconf\" -DSECURE
CFLAGS+=-DHACKDIR=\"$(HACKDIR)\"

LINK=$(CC)
# Only needed for GLIBC stack trace:
LFLAGS=-rdynamic

WINSRC = $(WINTTYSRC)
WINOBJ = $(WINTTYOBJ)
WINLIB = $(WINTTYLIB)

WINTTYLIB=-lcurses

CHOWN=chown
CHGRP=chgrp

GAMEUID  = nethack
GAMEGRP  = nethack

# Permissions - some places use setgid instead of setuid, for instance
# See also the option "SECURE" in include/config.h
GAMEPERM = 06755
FILEPERM = 0644
VARFILEPERM = 0664
EXEPERM  = 0755
DIRPERM  = 0755
VARDIRPERM = 0755


### End hints/devnull PRE

###
### Start Makefile.doc
###
#	NetHack Makefile.
# NetHack 3.6  Makefile.doc	$NHDT-Date: 1432512789 2015/05/25 00:13:09 $  $NHDT-Branch: master $:$NHDT-Revision: 1.14 $

# Root of source tree:
NHSROOT=..

# for Atari
# SHELL=E:/GEMINI2/MUPFEL.TTP

MAKEDEFS = ../util/makedefs

# Which version do we want to build?  (XXX These are not used anywhere.)
GUIDEBOOK = Guidebook		# regular ASCII file
#GUIDEBOOK = Guidebook.ps	# PostScript file
#GUIDEBOOK = Guidebook.dvi	# TeX device-independent file

# Some versions of col need -x to keep them from converting spaces to tabs;
# some versions of col don't do the conversion by default and don't
# recognize the option.  Sigh.
COLCMD = col -bx
#COLCMD = col -b

# The command to use to generate a PostScript file
# PSCMD = ditroff | psdit
PSCMD = groff

# Use the "cat" GUIDECMD if nroff and/or tbl and/or col are not installed
# Not appropriate for creating Guidebook.txt.
# GUIDECMD = cat Guidebook.txt
# The following works better with groff-1.18, eg on Linux
# GUIDECMD = $(GUIDE_PREFORMAT) | nroff -c -Tascii | $(COLCMD)
GUIDECMD = $(GUIDE_PREFORMAT) | nroff | $(COLCMD)

# Only generate output for the current configuration:
NHGREP = $(MAKEDEFS) --grep --input - --output -
# Generate output for all configurations:
#NHGREP = $(MAKEDEFS) --grep --input - --output - --grep-define ALLDOCS
# Fallback:
#NHGREP = cat

GUIDE_PREFORMAT = cat Guidebook.mn | $(NHGREP) | tbl tmac.n -

# the basic guidebook
Guidebook:	Guidebook.mn
	$(GUIDECMD) > Guidebook

# Fancier output for those with ditroff, psdit and a PostScript printer.
Guidebook.ps:	Guidebook.mn
	$(GUIDE_PREFORMAT) | $(PSCMD) > Guidebook.ps

# Guidebook.tex is the same as Guidebook.mn but formatted with LaTeX.
# - The invocation command for LaTeX may vary in different installations.
# - To print Guidebook.dvi you need to use a suitable dvi-driver.
# - LaTeX needs to be run twice; second pass uses Guidebook.aux made by first.
Guidebook.dvi:	Guidebook.tex
	latex Guidebook.tex
	latex Guidebook.tex


GAME	= nethack
MANDIR	= /usr/man/man6
MANEXT	= 6

# manual installation for most BSD-style systems
GAMEMANCREATE = cat nethack.6 | $(NHGREP) >
LEVMANCREATE = cat lev_comp.6 | $(NHGREP) >
DGNMANCREATE = cat dgn_comp.6 | $(NHGREP) >
RCVRMANCREATE = cat recover.6 | $(NHGREP) >
DLBMANCREATE = cat dlb.6 | $(NHGREP) >
MDMANCREATE = cat makedefs.6 | $(NHGREP) >
# manual installation for most SYSV-style systems
# GAMEMANCREATE = cat nethack.6 | $(NHGREP) | nroff -man - >
# LEVMANCREATE = cat lev_comp.6 | $(NHGREP) | nroff -man - >
# DGNMANCREATE = cat dgn_comp.6 | $(NHGREP) | nroff -man - >
# RCVRMANCREATE = cat recover.6 | $(NHGREP) | nroff -man - >
# DLBMANCREATE = cat dlb.6 | $(NHGREP) | nroff -man - >
# MDMANCREATE = cat makedefs.6 | $(NHGREP) | nroff -man - >

manpages:
	-$(GAMEMANCREATE) $(MANDIR)/$(GAME).$(MANEXT)
	-$(LEVMANCREATE) $(MANDIR)/lev_comp.$(MANEXT)
	-$(DGNMANCREATE) $(MANDIR)/dgn_comp.$(MANEXT)
	-$(RCVRMANCREATE) $(MANDIR)/recover.$(MANEXT)
	-$(DLBMANCREATE) $(MANDIR)/dlb.$(MANEXT)
	-$(MDMANCREATE) $(MANDIR)/makedefs.$(MANEXT)

# manual creation for distribution
DISTRIB = Guidebook.txt nethack.txt lev_comp.txt dgn_comp.txt recover.txt \
	dlb.txt makedefs.txt

distrib: $(DISTRIB)
	@echo "Plain text documentation is up to date."

Guidebook.txt	: Guidebook.mn tmac.n
	$(GUIDECMD) > Guidebook.txt
MAN2TXT = $(NHGREP) | nroff -man - | $(COLCMD)
nethack.txt	: nethack.6
	cat nethack.6 | $(MAN2TXT) > nethack.txt
lev_comp.txt	: lev_comp.6
	cat lev_comp.6 | $(MAN2TXT) > lev_comp.txt
dgn_comp.txt	: dgn_comp.6
	cat dgn_comp.6 | $(MAN2TXT) > dgn_comp.txt
recover.txt	: recover.6
	cat recover.6 | $(MAN2TXT) > recover.txt
dlb.txt		: dlb.6
	cat dlb.6 | $(MAN2TXT) > dlb.txt
makedefs.txt		: makedefs.6
	cat makedefs.6 | $(MAN2TXT) > makedefs.txt

clean:
	-rm -f Guidebook.aux Guidebook.log

spotless: clean
	-rm -f Guidebook Guidebook.ps Guidebook.dvi

maintainer-clean: spotless
	-rm -f $(DISTRIB)
#	-rm -f Makefile
### End Makefile.doc

###
### Start hints/devnull POST
###
### End hints/devnull POST
