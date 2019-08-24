function [ dop ] = convad( x )
%conVAD �˴���ʾ�йش˺�����ժҪ
%���ھ��ӵ�����ʶ��Ķ˵���
%   �˴���ʾ��ϸ˵��

%��ȡ��Ƶ�ļ�
x = audioread(x);

%��һ������%���ȹ�һ����[-1,1]
x = double(x);
x = x / max(abs(x));

%Ԥ����
y = filter([1 -0.9375],1,x);

%�������
% [x1 x2] = exvad(y,2580)
% dop{1}(1) = x1;
% dop{1}(2) = x2;

% �ִ�
judge = true;
count = 1;
start = 1;
while judge
    [x1,x2] = exvad(y,start);
    dop{count}(1) = x1;
    dop{count}(2) = x2;
    
    if x2 == -1
        judge = false;
        break;
    else
        count = count+1;
        start = round(x2);
    end
end

% subplot(311)
% plot(x)
% axis([1 length(x) -1 1])
% ylabel('Speech');
% line([dop{1}(1)*FrameInc x1*FrameInc], [-1 1], 'Color', 'red');
% line([dop{1}(2)*FrameInc x2*FrameInc], [-1 1], 'Color', 'red');

% subplot(312)
% plot(amp);
% axis([1 length(amp) 0 max(amp)])
% ylabel('Energy');
% line([x1 x1], [min(amp),max(amp)], 'Color', 'red');
% line([x2 x2], [min(amp),max(amp)], 'Color', 'red');
% 
% subplot(313)
% plot(zcr);
% axis([1 length(zcr) 0 max(zcr)])
% ylabel('ZCR');
% line([x1 x1], [min(zcr),max(zcr)], 'Color', 'red');
% line([x2 x2], [min(zcr),max(zcr)], 'Color', 'red');