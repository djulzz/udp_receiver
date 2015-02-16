/**
 * Note:
 */
#include <qmainwindow>
#include "MainWindow.hpp"
#include <cstdio>
#include <cstring>
#include <QFile>
#include <QTextStream>

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
int main( int argc, char* argv[  ] )
{
	QApplication app( argc, argv );
	MainWindow *mw = new MainWindow;
	mw->show(  );
	return app.exec(  );
}
