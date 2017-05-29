function [ wm ] = wmean( weight,x )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

wm = sum(x*weight',2);
end

