#
# This file is generated automatically.  Do not edit.
# Your changes will be lost.  See sys/unix/NewInstall.unx.
# Identify this file:
MAKEFILE_TOP=1

###
### Start hints/devnull PRE
###
# (new segment at source line 6 )
# hints file for devnull game server.
# target environment is a debian "jessie" docker container.
# hackdir is /devnull/nethackdir
# adapted from the "linux" hints file in the dist.


PREFIX=/opt/nethack/hardfought.org
HACKDIR=/devnull36
SHELLDIR = /tmp
INSTDIR=$(PREFIX)$(HACKDIR)
VARDIR = $(INSTDIR)/var



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

GAMEUID  = games
GAMEGRP  = games
VARDIRPERM = 0755
VARFILEPERM = 0600
GAMEPERM = 0755


# Permissions - some places use setgid instead of setuid, for instance
# See also the option "SECURE" in include/config.h
#GAMEPERM = 06755
FILEPERM = 0644
#VARFILEPERM = 0664
EXEPERM  = 0755
DIRPERM  = 0755
#VARDIRPERM = 0755


### End hints/devnull PRE

###
### Start Makefile.top
###
#	NetHack Makefile.
# NetHack 3.6  Makefile.top	$NHDT-Date: 1447844578 2015/11/18 11:02:58 $  $NHDT-Branch: master $:$NHDT-Revision: 1.32 $

# Root of source tree:
NHSROOT=.

# newer makes predefine $(MAKE) to 'make' and do smarter processing of
# recursive make calls if $(MAKE) is used
# these makes allow $(MAKE) to be overridden by the environment if someone
# wants to (or has to) use something other than the standard make, so we do
# not want to unconditionally set $(MAKE) here
#
# unfortunately, some older makes do not predefine $(MAKE); if you have one of
# these, uncomment the following line
# (you will know that you have one if you get complaints about unable to
# execute things like 'data' and 'rumors')
# MAKE = make

# make NetHack
#PREFIX	 = /usr
GAME     = nethack
# GAME     = nethack.prg
#GAMEUID  = games
#GAMEGRP  = bin

# Permissions - some places use setgid instead of setuid, for instance
# See also the option "SECURE" in include/config.h
#GAMEPERM = 04755
FILEPERM = 0644
# VARFILEPERM = 0644
EXEPERM  = 0755
DIRPERM  = 0755
# VARDIRPERM = 0755

# VARDIR may also appear in unixconf.h as "VAR_PLAYGROUND" else HACKDIR
#
# note that 'make install' believes in creating a nice tidy HACKDIR for
# installation, free of debris from previous NetHack versions --
# therefore there should not be anything in HACKDIR that you want to keep
# (if there is, you'll have to do the installation by hand or modify the
# instructions)
#HACKDIR  = $(PREFIX)/games/lib/$(GAME)dir
#VARDIR  = $(HACKDIR)
# Where nethack.sh in installed.  If this is not defined, the wrapper is not used.
#SHELLDIR = $(PREFIX)/games

# per discussion in Install.X11 and Install.Qt
#VARDATND = 
# VARDATND = x11tiles NetHack.ad pet_mark.xbm pilemark.xpm
# VARDATND = x11tiles NetHack.ad pet_mark.xbm pilemark.xpm rip.xpm
# for Atari/Gem
# VARDATND = nh16.img title.img GEM_RSC.RSC rip.img
# for BeOS
# VARDATND = beostiles
# for Gnome
# VARDATND = x11tiles pet_mark.xbm pilemark.xpm rip.xpm mapbg.xpm

VARDATD = bogusmon data engrave epitaph oracles options quest.dat rumors
VARDAT = $(VARDATD) $(VARDATND)

# Some versions of make use the SHELL environment variable as the shell
# for running commands.  We need this to be a Bourne shell.
# SHELL = /bin/sh
# for Atari
# SHELL=E:/GEMINI2/MUPFEL.TTP

# Commands for setting the owner and group on files during installation.
# Some systems fail with one or the other when installing over NFS or for
# other permission-related reasons.  If that happens, you may want to set the
# command to "true", which is a no-op. Note that disabling chown or chgrp
# will only work if setuid (or setgid) behavior is not desired or required.
#CHOWN = chown
#CHGRP = chgrp

#
# end of configuration
#

DATHELP = help hh cmdhelp history opthelp wizhelp

#CONTAINS GRUE/PACMAN/DIGDUG/JOUST CHALLENGE CODE
SPEC_LEVS = asmodeus.lev baalz.lev bigrm-*.lev castle.lev fakewiz?.lev \
	juiblex.lev knox.lev medusa-?.lev minend-?.lev minefill.lev \
	minetn-?.lev oracle.lev orcus.lev sanctum.lev soko?-?.lev \
	tower?.lev valley.lev wizard?.lev \
	astral.lev air.lev earth.lev fire.lev water.lev \
	gruelair.lev pmaze.lev dmaze.lev pool1.lev joust.lev

QUEST_LEVS = ???-goal.lev ???-fil?.lev ???-loca.lev ???-strt.lev

DATNODLB = $(VARDATND) license
DATDLB = $(DATHELP) dungeon tribute $(SPEC_LEVS) $(QUEST_LEVS) $(VARDATD)
DAT = $(DATNODLB) $(DATDLB)

$(GAME):
	( cd src ; $(MAKE) )

all:	$(GAME) recover Guidebook $(VARDAT) dungeon spec_levs check-dlb
	true; $(MOREALL)
	@echo "Done."

# Note: many of the dependencies below are here to allow parallel make
# to generate valid output

Guidebook:
	( cd doc ; $(MAKE) Guidebook )

manpages:
	( cd doc ; $(MAKE) manpages )

data: $(GAME)
	( cd dat ; $(MAKE) data )

engrave: $(GAME)
	( cd dat ; $(MAKE) engrave )

bogusmon: $(GAME)
	( cd dat ; $(MAKE) bogusmon )

epitaph: $(GAME)
	( cd dat ; $(MAKE) epitaph )

rumors: $(GAME)
	( cd dat ; $(MAKE) rumors )

oracles: $(GAME)
	( cd dat ; $(MAKE) oracles )

#	Note: options should have already been made with make, but...
options: $(GAME)
	( cd dat ; $(MAKE) options )

quest.dat: $(GAME)
	( cd dat ; $(MAKE) quest.dat )

spec_levs: dungeon
	( cd util ; $(MAKE) lev_comp )
	( cd dat ; $(MAKE) spec_levs )
	( cd dat ; $(MAKE) quest_levs )

dungeon: $(GAME)
	( cd util ; $(MAKE) dgn_comp )
	( cd dat ; $(MAKE) dungeon )

nhtiles.bmp: $(GAME)
	( cd dat ; $(MAKE) nhtiles.bmp )

x11tiles: $(GAME)
	( cd util ; $(MAKE) tile2x11 )
	( cd dat ; $(MAKE) x11tiles )

beostiles: $(GAME)
	( cd util ; $(MAKE) tile2beos )
	( cd dat ; $(MAKE) beostiles )

NetHack.ad: $(GAME)
	( cd dat ; $(MAKE) NetHack.ad )

pet_mark.xbm:
	( cd dat ; $(MAKE) pet_mark.xbm )

pilemark.xbm:
	( cd dat ; $(MAKE) pilemark.xbm )

rip.xpm:
	( cd dat ; $(MAKE) rip.xpm )

mapbg.xpm:
	(cd dat ; $(MAKE) mapbg.xpm )

nhsplash.xpm:
	( cd dat ; $(MAKE) nhsplash.xpm )

nh16.img: $(GAME)
	( cd util ; $(MAKE) tile2img.ttp )
	( cd dat ; $(MAKE) nh16.img )

rip.img:
	( cd util ; $(MAKE) xpm2img.ttp )
	( cd dat ; $(MAKE) rip.img )
GEM_RSC.RSC:
	( cd dat ; $(MAKE) GEM_RSC.RSC )

title.img:
	( cd dat ; $(MAKE) title.img )

check-dlb: options
	@if egrep -s librarian dat/options ; then $(MAKE) dlb ; else true ; fi

dlb:
	( cd util ; $(MAKE) dlb )
	( cd dat ; ../util/dlb cf nhdat $(DATDLB) )

# recover can be used when INSURANCE is defined in include/config.h
# and the checkpoint option is true
recover: $(GAME)
	( cd util ; $(MAKE) recover )

dofiles:
	target=`sed -n					\
		-e '/librarian/{' 			\
		-e	's/.*/dlb/p' 			\
		-e	'q' 				\
		-e '}' 					\
	  	-e '$$s/.*/nodlb/p' < dat/options` ;	\
	$(MAKE) dofiles-$${target-nodlb}
	(cd dat ; cp symbols $(INSTDIR) )
	cp src/$(GAME) $(INSTDIR)
	cp util/recover $(INSTDIR)
	-if test -n '$(SHELLDIR)'; then rm -f $(SHELLDIR)/$(GAME); fi
	if test -n '$(SHELLDIR)'; then \
		sed -e 's;/usr/games/lib/nethackdir;$(HACKDIR);' \
		-e 's;HACKDIR/nethack;HACKDIR/$(GAME);' \
		< sys/unix/nethack.sh \
		> $(SHELLDIR)/$(GAME) ; fi
# set up their permissions
	-( cd $(INSTDIR) ; $(CHOWN) $(GAMEUID) $(GAME) recover ; \
			$(CHGRP) $(GAMEGRP) $(GAME) recover )
	chmod $(GAMEPERM) $(INSTDIR)/$(GAME)
	chmod $(EXEPERM) $(INSTDIR)/recover
	-if test -n '$(SHELLDIR)'; then \
		$(CHOWN) $(GAMEUID) $(SHELLDIR)/$(GAME); fi
	if test -n '$(SHELLDIR)'; then \
		$(CHGRP) $(GAMEGRP) $(SHELLDIR)/$(GAME); \
		chmod $(EXEPERM) $(SHELLDIR)/$(GAME); fi
	-( cd $(INSTDIR) ; $(CHOWN) $(GAMEUID) symbols ; \
			$(CHGRP) $(GAMEGRP) symbols ; \
			chmod $(FILEPERM) symbols )

dofiles-dlb: check-dlb
	( cd dat ; cp nhdat $(DATNODLB) $(INSTDIR) )
# set up their permissions
	-( cd $(INSTDIR) ; $(CHOWN) $(GAMEUID) nhdat $(DATNODLB) ; \
			$(CHGRP) $(GAMEGRP) nhdat $(DATNODLB) ; \
			chmod $(FILEPERM) nhdat $(DATNODLB) )

dofiles-nodlb:
# copy over the game files
	( cd dat ; cp $(DAT) $(INSTDIR) )
# set up their permissions
	-( cd $(INSTDIR) ; $(CHOWN) $(GAMEUID) $(DAT) ; \
			$(CHGRP) $(GAMEGRP) $(DAT) ; \
			chmod $(FILEPERM) $(DAT) )

update: $(GAME) recover $(VARDAT) dungeon spec_levs
#	(don't yank the old version out from under people who're playing it)
	-mv $(INSTDIR)/$(GAME) $(INSTDIR)/$(GAME).old
#	quest.dat is also kept open and has the same problems over NFS
#	(quest.dat may be inside nhdat if dlb is in use)
	-mv $(INSTDIR)/quest.dat $(INSTDIR)/quest.dat.old
	-mv $(INSTDIR)/nhdat $(INSTDIR)/nhdat.old
# set up new versions of the game files
	( $(MAKE) dofiles )
# touch time-sensitive files
	-touch -c $(VARDIR)/bones* $(VARDIR)/?lock* $(VARDIR)/wizard*
	-touch -c $(VARDIR)/save/*
	touch $(VARDIR)/perm $(VARDIR)/record
# and a reminder
	@echo You may also want to install the man pages via the doc Makefile.

rootcheck:
	@true; $(ROOTCHECK)

install: rootcheck $(GAME) recover $(VARDAT) dungeon spec_levs
	true; $(PREINSTALL)
# set up the directories
# not all mkdirs have -p; those that don't will create a -p directory
	-if test -n '$(SHELLDIR)'; then \
		mkdir -p $(SHELLDIR); fi
	rm -rf $(INSTDIR) $(VARDIR)
	-mkdir -p $(INSTDIR) $(VARDIR) $(VARDIR)/save
	if test -d ./-p; then rmdir ./-p; fi
	-$(CHOWN) $(GAMEUID) $(INSTDIR) $(VARDIR) $(VARDIR)/save
	$(CHGRP) $(GAMEGRP) $(INSTDIR) $(VARDIR) $(VARDIR)/save
# order counts here:
	chmod $(DIRPERM) $(INSTDIR)
	chmod $(VARDIRPERM) $(VARDIR) $(VARDIR)/save
# set up the game files
	( $(MAKE) dofiles )
# set up some additional files
	touch $(VARDIR)/perm $(VARDIR)/record $(VARDIR)/logfile $(VARDIR)/xlogfile
	-( cd $(VARDIR) ; $(CHOWN) $(GAMEUID) perm record logfile xlogfile ; \
			$(CHGRP) $(GAMEGRP) perm record logfile xlogfile ; \
			chmod $(VARFILEPERM) perm record logfile xlogfile )
	true; $(POSTINSTALL)
# and a reminder
	@echo You may also want to reinstall the man pages via the doc Makefile.


# 'make clean' removes all the .o files, but leaves around all the executables
# and compiled data files
clean:
	( cd src ; $(MAKE) clean )
	( cd util ; $(MAKE) clean )
	( cd doc ; $(MAKE) clean )

# 'make spotless' returns the source tree to near-distribution condition.
# it removes .o files, executables, and compiled data files
spotless:
	( cd src ; $(MAKE) spotless )
	( cd util ; $(MAKE) spotless )
	( cd dat ; $(MAKE) spotless )
	( cd doc ; $(MAKE) spotless )
### End Makefile.top

###
### Start hints/devnull POST
###
### End hints/devnull POST