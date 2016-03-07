/**
 *
 * @file      create_ply.c
 * @brief     
 * @details   
 * 
 * @author    Lars Kiesow (lkiesow), lkiesow@uos.de, Universität Osnabrück
 * @version   
 * @date      09/07/2011 12:01:05 PM
 *
 **/


#include	<stdlib.h>
#include <stdio.h> 
#include "rply.h"

/*******************************************************************************
 *         Name:  main
 *  Description:  
 ******************************************************************************/
int main( int argc, char ** argv ) {

	/* Create new PLY file. */
	p_ply oply = ply_create( "new.ply", PLY_ASCII, NULL, 0, NULL );
	if ( !oply ) {
		fprintf( stderr, "ERROR: Could not create »new.ply«\n" );
		return EXIT_FAILURE;
	}

	/* Add object information to PLY. */
	if ( !ply_add_obj_info( oply, "This is just a test." ) ) {
		fprintf( stderr, "ERROR: Could not add object info.\n" );
		return EXIT_FAILURE;
	}

	/* Add a comment, too. */
	if ( !ply_add_comment( oply, "Just some comment…" ) ) {
		fprintf( stderr, "ERROR: Could not add comment.\n" );
		return EXIT_FAILURE;
	}

	/* Add vertex element. We want to add 9999 vertices. */
	if ( !ply_add_element( oply, "vertex", 99999 ) ) {
		fprintf( stderr, "ERROR: Could not add element.\n" );
		return EXIT_FAILURE;
	}

	/* Add vertex properties: x, y, z, r, g, b */
	if ( !ply_add_property( oply, "x",     PLY_FLOAT, 0, 0 ) ) {
		fprintf( stderr, "ERROR: Could not add property x.\n" );
		return EXIT_FAILURE;
	}

	if ( !ply_add_property( oply, "y",     PLY_FLOAT, 0, 0 ) ) {
		fprintf( stderr, "ERROR: Could not add property x.\n" );
		return EXIT_FAILURE;
	}

	if ( !ply_add_property( oply, "z",     PLY_FLOAT, 0, 0 ) ) {
		fprintf( stderr, "ERROR: Could not add property x.\n" );
		return EXIT_FAILURE;
	}

	if ( !ply_add_property( oply, "red",   PLY_UCHAR, 0, 0 ) ) {
		fprintf( stderr, "ERROR: Could not add property x.\n" );
		return EXIT_FAILURE;
	}

	if ( !ply_add_property( oply, "green", PLY_UCHAR, 0, 0 ) ) {
		fprintf( stderr, "ERROR: Could not add property x.\n" );
		return EXIT_FAILURE;
	}

	if ( !ply_add_property( oply, "blue",  PLY_UCHAR, 0, 0 ) ) {
		fprintf( stderr, "ERROR: Could not add property x.\n" );
		return EXIT_FAILURE;
	}

	/* Write header to file */
	if ( !ply_write_header( oply ) ) {
		fprintf( stderr, "ERROR: Could not write header.\n" );
		return EXIT_FAILURE;
	}

	/* Now we generate random data to add to the file: */
	srand ( time( NULL ) );

	int i;
	for ( i = 0; i < 99999; i++ ) {
		ply_write( oply, (double) ( rand() % 10000 ) / 10.0 ); /* x */
		ply_write( oply, (double) ( rand() % 10000 ) / 10.0 ); /* y */
		ply_write( oply, (double) ( rand() % 10000 ) / 10.0 ); /* z */
		ply_write( oply, rand() % 256 ); /* red   */
		ply_write( oply, rand() % 256 ); /* blue  */
		ply_write( oply, rand() % 256 ); /* green */
	}

	if ( !ply_close( oply ) ) {
		fprintf( stderr, "ERROR: Could not close file.\n" );
		return EXIT_FAILURE;
	}

	return EXIT_SUCCESS;

}
