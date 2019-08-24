function [  ] = vadui( x )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%常数设置
x = audioread(x);
FrameLen = 240;
FrameInc = 80;

amp1 = 10;
amp2 = 2;
zcr1 = 10;
zcr2 = 5;

%计算过零率
tmp1  = enframe(x(1:end-1), FrameLen, FrameInc);
tmp2  = enframe(x(2:end)  , FrameLen, FrameInc);
signs = (tmp1.*tmp2)<0;
diffs = (tmp1 -tmp2)>0.02;
zcr   = sum(signs.*diffs, 2);

%计算短时能量
amp = sum(abs(enframe(filter([1 -0.9375], 1, x), FrameLen, FrameInc)), 2);

%调整能量门限
amp1 = min(amp1, max(amp)/4);
amp2 = min(amp2, max(amp)/8);

dop = convad(x);
num = length(dop);
for n = 1:num
    x1(n) = dop{n}(1);
    x2(n) = dop{n}(2);
    if n == num-1
        break;
    else
        continue;
    end
end

subplot(311)
plot(x)
axis([1 length(x) -1 1])
ylabel('Speech');
for n=1:length(x1)
    line([x1(n)*FrameInc x1(n)*FrameInc], [-1 1], 'Color', 'red');
    line([x2(n)*FrameInc x2(n)*FrameInc], [-1 1], 'Color', 'red');
end

subplot(312)
plot(amp);
axis([1 length(amp) 0 max(amp)])
ylabel('Energy');
for n=1:length(x1)
    line([x1(n) x1(n)], [min(amp),max(amp)], 'Color', 'red');
    line([x2(n) x2(n)], [min(amp),max(amp)], 'Color', 'red');
end

subplot(313)
plot(zcr);
axis([1 length(zcr) 0 max(zcr)])
ylabel('ZCR');
for n=1:length(x1)
    line([x1(n) x1(n)], [min(zcr),max(zcr)], 'Color', 'red');
    line([x2(n) x2(n)], [min(zcr),max(zcr)], 'Color', 'red');
end

end

