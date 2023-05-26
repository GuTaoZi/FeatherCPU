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
        if(ofile.length() <= 1) {
            ofile = "prgmip32.coe";
        }
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
    int cnt = 0;
    if(afile.is_open()){
        std::string line;
        while (!afile.eof()) {
            getline(afile, line);
            if(line.length()==8){
                if(flg) coe_header += ",\n";
                flg = true;
                coe_header += line;
                cnt += 1;
            }
        }
        afile.close();
    } else {
        cerr<<"Cannot open file"<<endl;
        return -1;
    }
    for(; cnt<16384; cnt++){
        coe_header += ",\n00000000";
    }
    coe_header += ";\n";
    ofstream ofs(ofile);
    ofs<<coe_header;
    ofs.close();
    return 0;
}