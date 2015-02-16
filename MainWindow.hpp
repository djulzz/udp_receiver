/**
 * @file MainWindow.hpp
 * @author Julien Esposito
 */

#ifndef MAINWINDOW_HPP
#define MAINWINDOW_HPP

#include <QMainWindow>

//#include "MW_Udp_Receiver.hpp"
#include "ui_MW_Udp_Receiver.h"
#include <QUdpSocket>
#include <QFile>
#include <QTextStream>

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class MainWindow : public QMainWindow
{
	Q_OBJECT

public:
	MainWindow( QWidget * parent = 0, Qt::WindowFlags flags = 0 );
	virtual ~MainWindow( void );

public slots:
	void onConnect( void );
	void readPendingDatagrams( void );

protected:
	QString p_generate_filename( void );
	void p_update_label_udp_status( QString& str );
	void p_process_datagram( QByteArray& datargam );

protected:
	void p_setup_ui( void );
	void p_instantiate( void );
	void p_create_connections( void );

protected:
	Ui_MainWindow*		gui;
	QUdpSocket*			m_udp;
	bool				m_enabled;

	QFile				m_file;
	QTextStream			m_textstream;

};

#endif // MAINWINDOW_HPP defined


