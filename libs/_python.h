#ifndef _PYTHON_H
#define _PYTHON_H

#pragma push_macro("slots")
#undef slots
#include <Python.h>
#pragma pop_macro("slots")



/*!
 * \brief runPy can execut a Python string
 * \param string (Python code)
 */
static void runPy(const char* i_string){
    Py_Initialize();
    PyRun_SimpleString(i_string);
    Py_Finalize();
}

/*!
 * \brief runPyScript executs a Python script
 * \param file (the path of the script)
 */
static void runPyScript(const char* i_file){
    FILE* fp;
    Py_Initialize();
    fp = _Py_fopen(i_file, "r");
    PyRun_SimpleFile(fp, i_file);
    Py_Finalize();
}

/*!
 * \brief runPyScriptArgs executs a Python script and passes arguments
 * \param file (the path of the script)
 * \param argc amount of arguments
 * \param argv array of arguments with size of argc
 */
static void runPyScriptArgs(const char* i_file, int i_argc, char *i_argv[]){
    FILE* fp;
    wchar_t** wargv = new wchar_t*[i_argc];
    for(int i = 0; i < i_argc; i++)
    {
        wargv[i] = Py_DecodeLocale(i_argv[i], nullptr);
        if(wargv[i] == nullptr)
        {
            return;
        }
    }
    Py_SetProgramName(wargv[0]);

    Py_Initialize();
    PySys_SetArgv(i_argc, wargv);
    fp = _Py_fopen(i_file, "r");
    PyRun_SimpleFile(fp, i_file);
    Py_Finalize();

    for(int i = 0; i < i_argc; i++)
    {
        PyMem_RawFree(wargv[i]);
        wargv[i] = nullptr;
    }

    delete[] wargv;
    wargv = nullptr;
}



#endif // _PYTHON_H
