local e = "CmxvY2FsIFBsYXllcnMgPSBnYW1lOkdldFNlcnZpY2UoIlBsYXllcnMiKQpsb2NhbCBSdW5TZXJ2aWNl"
e = e .. "ID0gZ2FtZTpHZXRTZXJ2aWNlIikKbG9jYWwgTG9jYWxQbGF5ZXIgPSBQbGF5ZXJz"
e = e .. "LkxvY2FsUGxheWVyCmxvY2FsIFBsYXllckd1aSA9IExvY2FsUGxheWVyOldhaXRGb3JDaGlsZCgiUGxh"
e = e .. "eWVyR3VpIikKbG9jYWwgZ3VpID0gSW5zdGFuY2UubmV3KCJTY3JlZW5HdWkiLCBQbGF5ZXJHdWkpCmd1"
e = e .. "aS5OYW1lID0gIkZsaW5nR1VJIgpndWkuUmVzZXRPblNwYXduID0gZmFsc2UKLS0gQnUgc2FkZWNlIMO2"
e = e .. "cm5lazsgYXPEsWwgc2NyaXB0IHllcmluZSBidXJheWEgdMO8bSBrb2QgZWtsZW5tZWxpCg=="

local f = function(s)
	local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	s = s:gsub('[^'..b..'=]', '')
	return (s:gsub('.', function(x)
		if (x == '=') then return '' end
		local r,f='',(b:find(x)-1)
		for i=6,1,-1 do r=r..(f%2^i - f%2^(i-1) > 0 and '1' or '0') end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c=0
		for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
		return string.char(c)
	end))
end

loadstring(f(e))()