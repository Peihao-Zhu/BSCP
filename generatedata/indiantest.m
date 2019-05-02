
load('Indian_pines_corrected.mat')
load('Indian_pines_gt.mat')

label = reshape(indian_pines_gt,145*145,1);
sample = reshape(indian_pines_corrected,145*145,200);

idx = find(label>0.1);

temp = label(idx);
sample = sample(idx,:);

label = zeros(size(sample,1),max(temp(:)));

for i= 1:size(sample,1)
	label(i,temp(i)) = 1;
end

idx = randperm(numel(idx));

trainsample = sample(idx(1:ceil(0.1*numel(idx))),:);
testsample = sample(idx(1+ceil(0.1*numel(idx)):end),:);
trainlabel = label(idx(1:ceil(0.1*numel(idx))),:);
testlabel = label(idx(1+ceil(0.1*numel(idx)):end),:);

maxnum = 0;
for i = 1:16
	temp = find(trainlabel==i);
	if numel(temp) > maxnum
		maxnum =  numel(temp);
	end
end

sum(trainlabel,1);

for i = 1:16
	temp = find(trainlabel(:,i)==1);
	for j = 1:round(0.1*maxnum) - numel(temp) 
		tempidx = randperm(numel(temp));
		r = rand();
		trainsample = [trainsample; r*trainsample(temp(tempidx(1)),:)+(1-r)*trainsample(temp(tempidx(2)),:)];
		z = zeros(1,16);
		z(i) = 1;
		trainlabel = [trainlabel; z];
	end
end

meansample = mean(trainsample, 1);
stdsample = std(trainsample, 1);

for i= 1:size(trainsample,1)
	trainsample(i,:) = (trainsample(i,:)-meansample);
	trainsample(i,:) = trainsample(i,:) ./norm(trainsample(i,:));
end

for i= 1:size(testsample,1)
	testsample(i,:) = (testsample(i,:)-meansample);
	testsample(i,:) = testsample(i,:)./norm(testsample(i,:));
end

trainsample = reshape(trainsample', size(trainsample,2), 1, size(trainsample,1));
trainsample = trainsample(index(1:10),:,:);
testsample = reshape(testsample', 200, 1, 9224);
testsample = testsample(index(1:10),:,:);


trainlabel = reshape(trainlabel', size(trainlabel,2),1,size(trainlabel,1));
testlabel = reshape(testlabel' ,16 ,1,9224);


save('trainandtest10.mat','trainsample','testsample','trainlabel','testlabel');

% load('Indian_sample.mat')
% load('resindian.mat')
% idx2 = [1 61 75 88 57 90 91 85 89 40 32 83 86 87 72 2 8 30 38 28 4 29 36 31 21 93 20 27 37 73];
% 
% trainsample = trainsample(idx2,:,:);
% testsample = testsample(idx2,:,:);
% 
% 
% a = squeeze(restestlabel)';
% b = squeeze(testlabel);
% 
% 
% for i =1:size(a,2)
% 	idxa(i) = find(a(:,i)==max(a(:,i)));
% 	idxb(i) = find(b(:,i)==max(b(:,i)));
% end
% find(idxa==idxb); 
% 
% 
% A = squeeze(trainsample(:,:,1:1025))';
% b = squeeze(conv1_output(1:1025,:,:))-repmat(bias_Conv1_1,size(conv1_output(1:1025,:,:),1),1);
% 
% sumabsweight = zeros(200,1);
% for i = 1:128
% 	c=lasso(A,b(:,i),'Alpha',1);i
% 	c(find(abs(c)<0.005))=0;
% 	c(find(abs(c)>=0.005))=1;
% 	sumabsweight = sumabsweight + sum(c,2);
% end