function [ wc ] = wcov(weight,x,y)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

n = size(x,2);
mux = wmean(weight,x);
muy = wmean(weight,y);


wc = (x - mux * ones(1 , n)) * diag(weight)...
    *(y - muy * ones(1 , n))' ;

end

