/**
 * @file MainWindow.hpp
 * @author Julien Esposito
 */

#include "MainWindow.hpp"
#include <cstdio>
#include <cstring>
#include <QFile>
#include <QTextStream>
#include <QDateTime>

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
MainWindow::~MainWindow( void )
{
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
MainWindow::MainWindow( QWidget* parent, Qt::WindowFlags flags )
	: QMainWindow( parent, flags ), m_enabled( false )
{
	p_setup_ui(  );
	p_instantiate(  );
	p_create_connections(  );

}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void MainWindow::p_setup_ui( void )
{
	gui = new Ui_MainWindow;
	gui->setupUi( this );
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void MainWindow::p_create_connections( void )
{
	connect( gui->pushButton_connect, SIGNAL( clicked( bool ) ), this, SLOT( onConnect(  ) ) );
    connect( m_udp, SIGNAL( readyRead(  ) ), this, SLOT( readPendingDatagrams(  ) ) );
	return;
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void MainWindow::p_instantiate( void )
{
	m_udp = new QUdpSocket( this );
	return;
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void MainWindow::p_update_label_udp_status( QString& str )
{
	gui->label_Udp_status->setText( str );
	return;
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void MainWindow::p_process_datagram( QByteArray& datagram )
{
	static const int idx_id = 0;
	static const int idx_counter = 1;
	static const int idx_time = 2;

	static const int idx_data_1 = 3;
	static const int idx_data_2 = 4;
	static const int idx_data_3 = 5;

	QString string( datagram );
	QStringList stringList = string.split( ", ", QString::SkipEmptyParts );

	if( ( stringList.isEmpty(  ) == false ) && ( stringList.count(  ) == 6 ) )
	{
		QString id		= stringList[ idx_id ];
		QString counter = stringList[ idx_counter ];
		QString time	= stringList[ idx_time ];

		QString data_1 = stringList[ idx_data_1 ];
		QString data_2 = stringList[ idx_data_2 ];
		QString data_3 = stringList[ idx_data_3 ];

		QString val_id = id;
		int		val_counter = counter.toInt(  );

		bool ok;
		qlonglong		val_time = time.toLongLong( &ok );

		QString str_date = "";
		if( false == ok )
			str_date = "FUCK";
		else
		{
			QDateTime dateTime = QDateTime::fromMSecsSinceEpoch ( val_time );
			str_date = dateTime.toString( Qt::ISODate );
		}

		double	val_data_1 = data_1.toDouble(  );
		double	val_data_2 = data_2.toDouble(  );
		double	val_data_3 = data_3.toDouble(  );



		m_textstream << id << ", " << val_time << ", " << val_counter << ", " << val_data_1 << ", " << val_data_2 << ", "<< val_data_3 << "\n";
	}
	char* data = datagram.data(  );
	gui->label_Received_Text->setText( data );
	return;
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
QString MainWindow::p_generate_filename( void )
{
	QString s = QString( "data_" ) + QDateTime::currentDateTime(  ).toString(  ) + QString( ".txt" );
	int len = s.length(  );
	for( int i = 0; i < len; i++ )
		if( s.at( i ) == ':' )
			s[ i ] = '_';
	return s;
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void MainWindow::readPendingDatagrams( void )
{
	while( m_udp->hasPendingDatagrams(  ) ) {
        QByteArray datagram;
        datagram.resize( m_udp->pendingDatagramSize(  ) );
        QHostAddress sender;
        quint16 senderPort;
        m_udp->readDatagram( datagram.data(  ), datagram.size(  ), &sender, &senderPort );
		p_process_datagram( datagram );
	}
	return;
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void MainWindow::onConnect( void )
{
	if( m_enabled == false )	{
		QString ip = gui->line_ip_phone->text(  );
		QString port = gui->lineEdit_port->text(  );
		QHostAddress hostaddress( ip );
		quint16 port_number = ( quint16 )( port.toInt(  ) );
		bool tf = m_udp->bind( hostaddress, port_number, QUdpSocket::ShareAddress | QUdpSocket::ReuseAddressHint );
		if( true == tf ) {
			m_enabled = true;
			p_update_label_udp_status( QString( "Connected" ) );
			gui->pushButton_connect->setText( "Disconnect" );

			QString filename = p_generate_filename(  ); // generate a unique filename based on date

			m_file.setFileName( filename ); // setting the file name to "filename"

			QString udp_status = ( QString( "Data writting to \"" ) + filename  + QString ( "\"" ) ); // create a status message for Udp connection

			p_update_label_udp_status( udp_status ); // update udp status

			bool open_status = m_file.open(QFile::WriteOnly );
			if( false == open_status )	{
				QString error_str = QString( "Failed to open file \"" ) + filename + QString( "\"" );
				p_update_label_udp_status( error_str );
			}
			m_textstream.setDevice( &m_file );
			return;
		} else {
			QString error = m_udp->errorString(  );
			p_update_label_udp_status( error );
		}
	} else {
		if( m_udp->isOpen(  ) )	{
			m_udp->close(  );
		}
		m_enabled = false;
		p_update_label_udp_status( QString( "Disconnected" ) );
		gui->pushButton_connect->setText( "Connect" );
		m_file.close(  );
		m_udp->close(  );
		return;
	}
	return;
}
