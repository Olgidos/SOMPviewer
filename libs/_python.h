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
static void runPy(const char* string){
    Py_Initialize();
    PyRun_SimpleString(string);
    Py_Finalize();
}

/*!
 * \brief runPyScript executs a Python script
 * \param file (the path of the script)
 */
static void runPyScript(const char* file){
    FILE* fp;
    Py_Initialize();
    fp = _Py_fopen(file, "r");
    PyRun_SimpleFile(fp, file);
    Py_Finalize();
}

/*!
 * \brief runPyScriptArgs executs a Python script and passes arguments
 * \param file (the path of the script)
 * \param argc amount of arguments
 * \param argv array of arguments with size of argc
 */
static void runPyScriptArgs(const char* file, int argc, char *argv[]){
    FILE* fp;
    wchar_t** wargv = new wchar_t*[argc];
    for(int i = 0; i < argc; i++)
    {
        wargv[i] = Py_DecodeLocale(argv[i], nullptr);
        if(wargv[i] == nullptr)
        {
            return;
        }
    }
    Py_SetProgramName(wargv[0]);

    Py_Initialize();
    PySys_SetArgv(argc, wargv);
    fp = _Py_fopen(file, "r");
    PyRun_SimpleFile(fp, file);
    Py_Finalize();

    for(int i = 0; i < argc; i++)
    {
        PyMem_RawFree(wargv[i]);
        wargv[i] = nullptr;
    }

    delete[] wargv;
    wargv = nullptr;
}



#endif // _PYTHON_H
