#############################################################################
# Makefile for building: udp_receiver
# Generated by qmake (2.01a) (Qt 4.8.6) on: Sun Feb 15 09:06:04 2015
# Project:  udp_receiver.pro
# Template: app
# Command: c:\usr\sdk\qt\4.8.6\bin\qmake.exe -o Makefile udp_receiver.pro
#############################################################################

first: debug
install: debug-install
uninstall: debug-uninstall
MAKEFILE      = Makefile
QMAKE         = c:\usr\sdk\qt\4.8.6\bin\qmake.exe
DEL_FILE      = del
CHK_DIR_EXISTS= if not exist
MKDIR         = mkdir
COPY          = copy /y
COPY_FILE     = $(COPY)
COPY_DIR      = xcopy /s /q /y /i
INSTALL_FILE  = $(COPY_FILE)
INSTALL_PROGRAM = $(COPY_FILE)
INSTALL_DIR   = $(COPY_DIR)
DEL_FILE      = del
SYMLINK       = 
DEL_DIR       = rmdir
MOVE          = move
CHK_DIR_EXISTS= if not exist
MKDIR         = mkdir
SUBTARGETS    =  \
		debug \
		release

debug: $(MAKEFILE).Debug FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Debug
debug-make_default: $(MAKEFILE).Debug FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Debug 
debug-make_first: $(MAKEFILE).Debug FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Debug first
debug-all: $(MAKEFILE).Debug FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Debug all
debug-clean: $(MAKEFILE).Debug FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Debug clean
debug-distclean: $(MAKEFILE).Debug FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Debug distclean
debug-install: $(MAKEFILE).Debug FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Debug install
debug-uninstall: $(MAKEFILE).Debug FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Debug uninstall
release: $(MAKEFILE).Release FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Release
release-make_default: $(MAKEFILE).Release FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Release 
release-make_first: $(MAKEFILE).Release FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Release first
release-all: $(MAKEFILE).Release FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Release all
release-clean: $(MAKEFILE).Release FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Release clean
release-distclean: $(MAKEFILE).Release FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Release distclean
release-install: $(MAKEFILE).Release FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Release install
release-uninstall: $(MAKEFILE).Release FORCE
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Release uninstall

Makefile: udp_receiver.pro  ..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\win32-msvc2012\qmake.conf ..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\qconfig.pri \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\modules\qt_webkit_version.pri \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\qt_functions.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\qt_config.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\exclusive_builds.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\default_pre.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\default_pre.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\debug.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\debug_and_release.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\default_post.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\default_post.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\rtti.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\exceptions.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\stl.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\shared.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\embed_manifest_exe.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\embed_manifest_dll.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\warn_on.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\qt.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\thread.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\moc.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\windows.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\resources.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\uic.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\yacc.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\lex.prf \
		..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\include_source_dir.prf \
		c:\usr\sdk\qt\4.8.6\lib\qtmaind.prl
	$(QMAKE) -o Makefile udp_receiver.pro
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\qconfig.pri:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\modules\qt_webkit_version.pri:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\qt_functions.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\qt_config.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\exclusive_builds.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\default_pre.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\default_pre.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\debug.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\debug_and_release.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\default_post.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\default_post.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\rtti.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\exceptions.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\stl.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\shared.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\embed_manifest_exe.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\embed_manifest_dll.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\warn_on.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\qt.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\thread.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\moc.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\win32\windows.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\resources.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\uic.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\yacc.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\lex.prf:
..\..\..\..\usr\sdk\qt\4.8.6\mkspecs\features\include_source_dir.prf:
c:\usr\sdk\qt\4.8.6\lib\qtmaind.prl:
qmake: qmake_all FORCE
	@$(QMAKE) -o Makefile udp_receiver.pro

qmake_all: FORCE

make_default: debug-make_default release-make_default FORCE
make_first: debug-make_first release-make_first FORCE
all: debug-all release-all FORCE
clean: debug-clean release-clean FORCE
	-$(DEL_FILE) udp_receiver.exp
	-$(DEL_FILE) udp_receiver.ilk
	-$(DEL_FILE) vc*.pdb
	-$(DEL_FILE) vc*.idb
distclean: debug-distclean release-distclean FORCE
	-$(DEL_FILE) Makefile
	-$(DEL_FILE) udp_receiver.pdb

check: first

debug-mocclean: $(MAKEFILE).Debug
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Debug mocclean
release-mocclean: $(MAKEFILE).Release
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Release mocclean
mocclean: debug-mocclean release-mocclean

debug-mocables: $(MAKEFILE).Debug
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Debug mocables
release-mocables: $(MAKEFILE).Release
	@set MAKEFLAGS=$(MAKEFLAGS)
	$(MAKE) -f $(MAKEFILE).Release mocables
mocables: debug-mocables release-mocables
FORCE:

$(MAKEFILE).Debug: Makefile
$(MAKEFILE).Release: Makefile