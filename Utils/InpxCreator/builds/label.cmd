@echo off

IF .%1. == .. GOTO usage

svn copy http://subversion.assembla.com/svn/myhomelib/Utils/InpxCreator/trunk http://subversion.assembla.com/svn/myhomelib/Utils/InpxCreator/builds/%1 -m "Release %1"

goto FIN

:usage
ECHO label.cmd BUILD!

:FIN