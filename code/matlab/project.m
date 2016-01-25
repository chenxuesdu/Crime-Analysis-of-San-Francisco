clear;clc
[a b c ] = xlsread('crimedata.xls','sheet2');

for i=1:20833
crime_type{i}=c{i,2};
end

A=tabulate(crime_type);

t=1;
for i=[4;7;1;5;2;10;13;3;8;11;12;6;16;19;17;18;27;20;21;22;14;24;9;31;26;15;25;23;28;30;33;32;34;29;35]'%1:35
    i
crime_freq(t)=A{i,3};
t=t+1;
end
t=1;
for i=[4;7;1;5;2;10;13;3;8;11;12;6;16;19;17;18;27;20;21;22;14;24;9;31;26;15;25;23;28;30;33;32;34;29;35]'%1:35
crime_name{t}=A{i,1};
t=t+1;
end



bar(crime_freq,0.8)

set(gca,'XTickLabel',crime_name)
set(get(gca,'xlabel'),'rotation',90)

h = get(gca,'xlabel');
xlabelstring = get(h,'string');
xlabelposition = get(h,'position');


yposition = xlabelposition(2);
yposition = repmat(yposition,35,1);


set(gca,'xtick',[]);


hnew = text([1:35], yposition, crime_name);
set(hnew,'rotation',90,'horizontalalignment','right');
axis([-1 36  -25 35])
%%
for i=1:20833
tmp=round(c{i,6}*23);
crime_time(i)=tmp;
end

A=tabulate(crime_time);

crime_time_freq=A(:,3);



bar([0.5:1:23.5],crime_time_freq)
axis([0 24 0 8])
ylabel('crime rate');xlabel('time')
%%
for i=1:20833
crime_location{i}=c{i,7};
crime_date{i}=c{i,5};
crime_day{i}=c{i,4};
end


A=tabulate(crime_day);
t=1;
for i=[4 6 5 1 3 2 7]
crime_loc_freq(t)=A{i,3};
t=t+1;
end
t=1;
for i=[4 6 5 1 3 2 7]
crime_loc_name{t}=A{i,1};
t=t+1
end



bar(crime_loc_freq)

set(gca,'XTickLabel',crime_loc_name)
set(get(gca,'xlabel'),'rotation',90)

h = get(gca,'xlabel');
xlabelstring = get(h,'string');
xlabelposition = get(h,'position');


yposition = xlabelposition(2);
yposition = repmat(yposition,7,1);


set(gca,'xtick',[]);


hnew = text([1:7], yposition, crime_loc_name);
set(hnew,'rotation',90,'horizontalalignment','right');
axis([-0.5 11  -10 25])























A=tabulate(crime_location);
t=1;
for i=[1 6 5 4  9 2 8  3 7 10]
crime_loc_freq(t)=A{i,3};
t=t+1;
end
t=1;
for i=[1 6 5 4  9 2 8  3 7 10]
crime_loc_name{t}=A{i,1};
t=t+1;
end



bar(crime_loc_freq)

set(gca,'XTickLabel',crime_loc_name)
set(get(gca,'xlabel'),'rotation',90)

h = get(gca,'xlabel');
xlabelstring = get(h,'string');
xlabelposition = get(h,'position');


yposition = xlabelposition(2);
yposition = repmat(yposition,10,1);


set(gca,'xtick',[]);


hnew = text([1:10], yposition, crime_loc_name);
set(hnew,'rotation',90,'horizontalalignment','right');
axis([0.5 10.5  -0 25])





%%
for i=1:20833
tmp1=c{i,10};
tmp2=c{i,11};
crime_map(i,:)=[tmp1,tmp2];
geoshow(crime_map(i,1),crime_map(i,2))
hold on
end

 [C,ia,ic] = unique(crime_date);
 k=1;B={};
 idx=[48,49,60,71,73:78,50:59,61:70,72,1,12,23,26:31,2:11,13:22,24,25,32,39,41:47]%,33:38,40];
 for i=idx
     
 B{k}=C{i};
 k=k+1;
 end
datetable=tabulate(ic);
 bar(datetable(idx(1:71),2))

set(gca,'XTickLabel',crime_loc_name)
set(get(gca,'xlabel'),'rotation',90)

h = get(gca,'xlabel');
xlabelstring = get(h,'string');
xlabelposition = get(h,'position');


yposition = xlabelposition(2);
yposition = repmat(yposition,71,1);


set(gca,'xtick',[]);


hnew = text([1:71], yposition, B);
set(hnew,'rotation',90,'horizontalalignment','right');
axis([-0.5 79  -10 490]);ylabel('crime rate')
%%
idx=find(crime_freq*20833/100<50);


for i =setdiff(1:35,idx)
    tt_time=[];
    tt_loc={};
    tt_date={};
     id=1;
    for k=1:20833
        
       
    if strcmp(c{k,2},crime_name{i})==1
      tt_time=[tt_time;crime_time(k)];
      tt_loc{id}=crime_location{k};
      tt_date{id}=c{k,4};
      id=id+1;
    end
    end
     [C,ia,ic] = unique(tt_date);
    entropy_date(i)=entropy(ic);
    [C,ia,ic] = unique(tt_loc);
    entropy_loc(i)=entropy(ic);
    entropy_time(i)=entropy(tt_time);
    
end

figure;
stem(setdiff(1:35,idx),entropy_time(setdiff(1:35,idx)))
figure;
stem(setdiff(1:35,idx),entropy_loc(setdiff(1:35,idx)))
figure;
stem(setdiff(1:35,idx),entropy_date(setdiff(1:35,idx)))

