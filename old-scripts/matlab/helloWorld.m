%Author: Travis Gall
%Description: Simple hello world program for introduction to MATLAB
function [] = helloWorld()
    %Clear Command Window
    clc();
    
    %Request User Input
    name = input('Please Enter Your Name: ', 's');
    
    %Concatenate Strings
    print = ['Hello, ', name, '. Welcome to MATLAB']; %Allows spacing
    %print = strcat('Hello: ', name, '. Welcome to MATLAB'); %Trims spacing
    
    %Print Concatenated Strings
    fprintf(1, print);
    fprintf(1, '\n');
end