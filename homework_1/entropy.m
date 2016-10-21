function e = entropy(x,y)
e = x/y*log(x/y)+ (y-x)/y*log((y-x)/y);