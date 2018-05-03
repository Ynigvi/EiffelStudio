/*
	 Modified version of the minizip.c to work as a library.

	 --
   minizip.c
   Version 1.01e, February 12th, 2005

   Copyright (C) 1998-2005 Gilles Vollant
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <errno.h>
#include <fcntl.h>
#include <dirent.h>

#ifdef unix
# include <unistd.h>
# include <utime.h>
# include <sys/types.h>
# include <sys/stat.h>
#else
# include <direct.h>
# include <io.h>
#endif

#include "zip.h"

#ifdef WIN32
#define USEWIN32IOAPI
#include "iowin32.h"
#endif

struct List
{
    struct List *next;
    char *data;
};
typedef struct List List;	

List* create_list(const char* data) {
	List* l = malloc(sizeof(l));
	if(l) {
		l->next = NULL;
		l->data = data;
	}

	return l;
}

void append_to_list(List* l, const char* data) {
	List** p1 = &l;
	while (*p1) {
		p1 = &(*p1)->next;
	}
	*p1 = create_list(data);
}

void remove_first(List** l) {
	List *p = *l;
	*l = (*l)->next;
	free(p);
}

#define WRITEBUFFERSIZE (16384)
#define MAXFILENAME (256)

#ifdef WIN32
uLong filetime(f, tmzip, dt)
    char *f;                /* name of file to get info on */
    tm_zip *tmzip;             /* return value: access, modific. and creation times */
    uLong *dt;             /* dostime */
{
  int ret = 0;
  {
      FILETIME ftLocal;
      HANDLE hFind;
      WIN32_FIND_DATA  ff32;

      hFind = FindFirstFile(f,&ff32);
      if (hFind != INVALID_HANDLE_VALUE)
      {
        FileTimeToLocalFileTime(&(ff32.ftLastWriteTime),&ftLocal);
        FileTimeToDosDateTime(&ftLocal,((LPWORD)dt)+1,((LPWORD)dt)+0);
        FindClose(hFind);
        ret = 1;
      }
  }
  return ret;
}
#else
#ifdef unix
uLong filetime(f, tmzip, dt)
    char *f;               /* name of file to get info on */
    tm_zip *tmzip;         /* return value: access, modific. and creation times */
    uLong *dt;             /* dostime */
{
  int ret=0;
  struct stat s;        /* results of stat() */
  struct tm* filedate;
  time_t tm_t=0;

  if (strcmp(f,"-")!=0)
  {
    char name[MAXFILENAME+1];
    int len = strlen(f);
    if (len > MAXFILENAME)
      len = MAXFILENAME;

    strncpy(name, f,MAXFILENAME-1);
    /* strncpy doesnt append the trailing NULL, of the string is too long. */
    name[ MAXFILENAME ] = '\0';

    if (name[len - 1] == '/')
      name[len - 1] = '\0';
    /* not all systems allow stat'ing a file with / appended */
    if (stat(name,&s)==0)
    {
      tm_t = s.st_mtime;
      ret = 1;
    }
  }
  filedate = localtime(&tm_t);

  tmzip->tm_sec  = filedate->tm_sec;
  tmzip->tm_min  = filedate->tm_min;
  tmzip->tm_hour = filedate->tm_hour;
  tmzip->tm_mday = filedate->tm_mday;
  tmzip->tm_mon  = filedate->tm_mon ;
  tmzip->tm_year = filedate->tm_year;

  return ret;
}
#else
uLong filetime(f, tmzip, dt)
    char *f;                /* name of file to get info on */
    tm_zip *tmzip;             /* return value: access, modific. and creation times */
    uLong *dt;             /* dostime */
{
    return 0;
}
#endif
#endif


int check_exist_file(filename)
    const char* filename;
{
    FILE* ftestexist;
    int ret = 1;
    ftestexist = fopen(filename,"rb");
    if (ftestexist==NULL)
        ret = 0;
    else
        fclose(ftestexist);
    return ret;
}

int zip_folder(const char* folder_name, const char* zip_name)
{
	char buf[WRITEBUFFERSIZE];
	
	zipFile zf;
  int err;
# ifdef USEWIN32IOAPI
  zlib_filefunc_def ffunc;
  fill_win32_filefunc(&ffunc);
  zf = zipOpen2(zip_name,0,NULL,&ffunc);
# else
  zf = zipOpen(zip_name,0);
# endif

  if (zf == NULL)
  {
    return -1;
  }

	List* l = create_list(folder_name);	
  
	while(l != NULL)
	{
		FILE * fin;
		int size_read;
		char* filenameinzip = l->data;
		zip_fileinfo zi;

		zi.tmz_date.tm_sec = zi.tmz_date.tm_min = zi.tmz_date.tm_hour =
		zi.tmz_date.tm_mday = zi.tmz_date.tm_mon = zi.tmz_date.tm_year = 0;
		zi.dosDate = 0;
		zi.internal_fa = 0;
		zi.external_fa = 0;
		filetime(filenameinzip,&zi.tmz_date,&zi.dosDate);

		DIR* dir = opendir(filenameinzip);
		if (dir == NULL)
		{
			fin = fopen(filenameinzip,"rb");
			if (fin != NULL) 
			{
				
				err = zipOpenNewFileInZip(zf,&(filenameinzip[strlen(folder_name)+1]),&zi,
							           NULL,0,NULL,0,NULL /* comment*/,
							           Z_DEFLATED,
							           Z_DEFAULT_COMPRESSION);
				if (err != ZIP_OK)
		      return -1;
				else
				{
					do
					{
					    err = ZIP_OK;
					    size_read = (int)fread(buf,1,WRITEBUFFERSIZE,fin);
					    if (size_read < WRITEBUFFERSIZE)
					        if (feof(fin)==0)
					    {
      					return -1;
					    }

					    if (size_read>0)
					    {
					        err = zipWriteInFileInZip (zf,buf,size_read);
					        if (err<0)
					        {
    								return -1;
					        }

					    }
					} while ((err == ZIP_OK) && (size_read>0));
					
					err = zipCloseFileInZip(zf);
					if (err!=ZIP_OK)
			      return -1;
				}
				fclose(fin);
			}
			else 
			{
				return -1;
			}
		}
		else
		{
			struct dirent* file;

			while((file = readdir(dir)) != NULL)
			{
				if(strcmp(file->d_name,"..") != 0 && strcmp(file->d_name,".") != 0) {
					char* newfilename = malloc((strlen(filenameinzip)+strlen(file->d_name)+2)*sizeof(char)); 
					newfilename[0] = '\0';
					strcat(newfilename,filenameinzip);
					strcat(newfilename,"/");
					strcat(newfilename,file->d_name);
					append_to_list(l, newfilename);
				}
			} 	

			closedir(dir);
		}			
		
		remove_first(&l);
	}
 	
	err = zipClose(zf, NULL);
  if (err != ZIP_OK)
      return -1;
	else
		return 0;
} 


