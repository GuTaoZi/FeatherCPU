#include <iostream>
#include <cstdio>
#include <string>
#include <filesystem>
#include <fstream>
using namespace std;

string coe_header = "memory_initialization_radix = 16;\n"
                    "memory_initialization_vector =\n";

int main(int argc, char **argv){
    string ifile, ofile;
    if(argc == 1){
        cout<<"input file name:";
        getline(cin, ifile);
        cout<<"output file name:";
        getline(cin, ofile);
    } else if(argc == 3){
        ifile = argv[1];
        ofile = argv[2];
    } else {
        cout<<"error command.\n";
        return 0;
    }
    std::ifstream afile;
    afile.open(ifile, std::ios::in);
    bool flg = false;
    if(afile.is_open()){
        std::string  line;
        while (!afile.eof()) {
            getline(afile, line);
            if(line.length()==8){
                if(flg) coe_header += ",\n";
                flg = true;
                coe_header += line;
            }
        }
        afile.close();
    } else {
        cerr<<"Cannot open file"<<endl;
        return -1;
    }
    ofstream ofs(ofile);
    ofs<<coe_header;
    ofs.close();
    return 0;
}