%% Supplementary Analyses
clear all
close all
clc
%% Check for systematic differences in endowment between conditions
load('Experiment1.mat')
load('Experiment2.mat')

% Feelings Data1
[meanendowment,grps] = grpstats(FeelingsData1.Endow,{FeelingsData1.Allocator,FeelingsData1.ID},{'mean','gname'});
GrpEndowment{1} = [meanendowment(1:32,1) meanendowment(33:64,1) meanendowment(65:end,1)]; 
mean(GrpEndowment{1})
std(GrpEndowment{1})
[h,p,ci,stats] = ttest(GrpEndowment{1}(:,1),GrpEndowment{1}(:,2))
[h,p,ci,stats] = ttest(GrpEndowment{1}(:,1),GrpEndowment{1}(:,3))
[h,p,ci,stats] = ttest(GrpEndowment{1}(:,2),GrpEndowment{1}(:,3))

% Punishment Data1
[meanendowment,grps] = grpstats(PunishmentData1.Endow,{PunishmentData1.Allocator,PunishmentData1.ID},{'mean','gname'});
GrpEndowment{2} = [meanendowment(1:32,1) meanendowment(33:64,1) meanendowment(65:end,1)]; 
mean(GrpEndowment{2})
std(GrpEndowment{2})
[h,p,ci,stats] = ttest(GrpEndowment{2}(:,1),GrpEndowment{2}(:,2))
[h,p,ci,stats] = ttest(GrpEndowment{2}(:,1),GrpEndowment{2}(:,3))
[h,p,ci,stats] = ttest(GrpEndowment{2}(:,2),GrpEndowment{2}(:,3))

% Feelings Data2
[meanendowment,grps] = grpstats(FeelingsData2.Endow,{FeelingsData2.Allocator,FeelingsData2.ID},{'mean','gname'});
GrpEndowment{3} = [meanendowment(1:35,1) meanendowment(36:70,1) meanendowment(71:end,1)]; 
mean(GrpEndowment{3})
std(GrpEndowment{3})
[h,p,ci,stats] = ttest(GrpEndowment{3}(:,1),GrpEndowment{3}(:,2))
[h,p,ci,stats] = ttest(GrpEndowment{3}(:,1),GrpEndowment{3}(:,3))
[h,p,ci,stats] = ttest(GrpEndowment{3}(:,2),GrpEndowment{3}(:,3))

% Punishment Data2
[meanendowment,grps] = grpstats(PunishmentData2.Endow,{PunishmentData2.Allocator,PunishmentData2.ID},{'mean','gname'});
GrpEndowment{4} = [meanendowment(1:35,1) meanendowment(36:70,1) meanendowment(71:end,1)];  
mean(GrpEndowment{4})
std(GrpEndowment{4})
[h,p,ci,stats] = ttest(GrpEndowment{4}(:,1),GrpEndowment{4}(:,2))
[h,p,ci,stats] = ttest(GrpEndowment{4}(:,1),GrpEndowment{4}(:,3))
[h,p,ci,stats] = ttest(GrpEndowment{4}(:,2),GrpEndowment{4}(:,3))

%% Run analyses on Punishment Data with only blocks 1 and 3
Models.Experiment1.Punishment{1} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Alt' 'Rho Fair' 'Endowment'};
Models.Experiment1.Punishment{2} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho' 'Endowment'};
Models.Experiment1.Punishment{3} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Alt' 'Endowment'};
Models.Experiment1.Punishment{4} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Inequity' 'Endowment'};
Models.Experiment1.Punishment{5} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Endowment'};
Models.Experiment1.Punishment{6} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Rho' 'Endowment'};
Models.Experiment1.Punishment{7} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Endowment'};
Models.Experiment1.Punishment{8} = {'AIC' 'R2' 'Intercept' 'Beta Inequity' 'Rho' 'Endowment'};
Models.Experiment1.Punishment{9} = {'AIC' 'R2' 'Intercept' 'Beta Inequity' 'Endowment'};
Models.Experiment1.Punishment{10} = {'AIC' 'R2' 'Intercept'};
Models.Experiment1.Punishment{11} = {'AIC' 'R2'};

Selfishness = [10:1:100]';
Inequality = [linspace(80,0,41) linspace(2,100,50)]';
Endowment = ones(91,1)*7.5;
sublength = (length(unique(FeelingsData1.ID)));

% Punishment as a binary variable
[meanpun,grps] = grpstats(PunishmentData1.PunBinary,{PunishmentData1.Allocator,PunishmentData1.ID},{'mean','gname'});
grps=cellfun(@str2double,grps);
for i = [2 0 1]
    meanpun2(1:sublength,i+1) = meanpun((grps(:,1))==i);
end
grps(:,1) = grps(:,1)+1;
rmANOVAs.punishmentBinary1 = [meanpun grps];
RMAOV1(rmANOVAs.punishmentBinary1)
rmANOVAs.partialeta.punishmentBinary1 = 8.488 / (8.488 + 3.267);

[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,1))
CohensD.Punishment1.Frequency.SelfishGenerous = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,2))
CohensD.Punishment1.Frequency.SelfishEqual = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,1),meanpun2(:,2))
CohensD.Punishment1.Frequency.GenerousEqual = stats.tstat/sqrt(sublength);

%Punishment amount
[meanpun,grps] = grpstats(PunishmentData1.Punishment,{PunishmentData1.Allocator,PunishmentData1.ID},{'mean','gname'});
grps=cellfun(@str2double,grps);
for i = [2 0 1]
    meanpun2(1:sublength,i+1) = meanpun((grps(:,1))==i);
end
grps(:,1) = grps(:,1)+1;
rmANOVAs.punishment1 = [meanpun grps];
RMAOV1(rmANOVAs.punishment1)
rmANOVAs.partialeta.punishment1 = 5.449 / (5.449 + 1.09);

[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,1))
CohensD.Punishment1.Frequency.SelfishGenerous = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,2))
CohensD.Punishment1.Frequency.SelfishEqual = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,1),meanpun2(:,2))
CohensD.Punishment1.Frequency.GenerousEqual = stats.tstat/sqrt(sublength);

for i = 1:10
    % PunishmentModel1
    mdl.Experiment1.Punishment{1}{i} = {};
    X = double(PunishmentData1(:,[6,8,7]));
    y = double(PunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2).^b(5) + b(6)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Punishment{1}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Punishment{1}{i}) == 0
        Models.Experiment1.Punishment{1}(1+i,:)=[mdl.Experiment1.Punishment{1}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{1}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{1}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Punishment{1}{i}) == 1
        Models.Experiment1.Punishment{1}(1+i,:) = {NaN};
    end
    disp(['Punishment Model 1 ' num2str(i)])
    
    %PunishmentModel2
    mdl.Experiment1.Punishment{2}{i} = {};
    X = double(PunishmentData1(:,[6,8,7]));
    y = double(PunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2).^b(4) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Punishment{2}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Punishment{2}{i}) == 0
        Models.Experiment1.Punishment{2}(1+i,:)=[mdl.Experiment1.Punishment{2}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{2}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{2}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Punishment{2}{i}) == 1
        Models.Experiment1.Punishment{2}(1+i,:) = {NaN};
    end
    disp(['Punishment Model 2 ' num2str(i)])   
    
    % PunishmentModel3
    mdl.Experiment1.Punishment{3}{i} = {};
    X = double(PunishmentData1(:,[6,8,7]));
    y = double(PunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Punishment{3}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Punishment{3}{i}) == 0
        Models.Experiment1.Punishment{3}(1+i,:)=[mdl.Experiment1.Punishment{3}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{3}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{3}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Punishment{3}{i}) == 1
        Models.Experiment1.Punishment{3}(1+i,:) = {NaN};
    end
    disp(['Punishment Model 3 ' num2str(i)])   
    
    % PunishmentModel4
    mdl.Experiment1.Punishment{4}{i} = {};
    X = double(PunishmentData1(:,[6,8,7]));
    y = double(PunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2).^b(4) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Punishment{4}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Punishment{4}{i}) == 0
        Models.Experiment1.Punishment{4}(1+i,:)=[mdl.Experiment1.Punishment{4}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{4}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{4}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Punishment{4}{i}) == 1
        Models.Experiment1.Punishment{4}(1+i,:) = {NaN};
    end
    disp(['Punishment Model 4 ' num2str(i)])
    
    %PunishmentModel5
    mdl.Experiment1.Punishment{5}{i} = {};
    X = double(PunishmentData1(:,[6,8,7]));
    y = double(PunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2) + b(4)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment1.Punishment{5}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment1.Punishment{5}(1+i,:)=[mdl.Experiment1.Punishment{5}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{5}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{5}{i}.Coefficients(:,1))'];
    disp(['Punishment Model 5 ' num2str(i)])
    
    % PunishmentModel6
    mdl.Experiment1.Punishment{6}{i} = {};
    X = double(PunishmentData1(:,[6,7]));
    y = double(PunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(3) + b(4)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Punishment{6}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Punishment{6}{i}) == 0
        Models.Experiment1.Punishment{6}(1+i,:)=[mdl.Experiment1.Punishment{6}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{6}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{6}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Punishment{6}{i}) == 1
        Models.Experiment1.Punishment{6}(1+i,:)={NaN};
    end
    disp(['Punishment Model 6 ' num2str(i)])
    
    % PunishmentModel7
    mdl.Experiment1.Punishment{7}{i} = {};
    X = double(PunishmentData1(:,[6,7]));
    y = double(PunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment1.Punishment{7}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment1.Punishment{7}(1+i,:)=[mdl.Experiment1.Punishment{7}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{7}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{7}{i}.Coefficients(:,1))'];
    disp(['Punishment Model 7 ' num2str(i)])
    
    % PunishmentModel8
    mdl.Experiment1.Punishment{8}{i} = {};
    X = double(PunishmentData1(:,[8,7]));
    y = double(PunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(3) + b(4)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Punishment{8}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Punishment{8}{i}) == 0
        Models.Experiment1.Punishment{8}(1+i,:)=[mdl.Experiment1.Punishment{8}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{8}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{8}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Punishment{8}{i}) == 1
        Models.Experiment1.Punishment{8}(1+i,:)={NaN};
    end
    disp(['Punishment Model 8 ' num2str(i)])
    
    % PunishmentModel9
    mdl.Experiment1.Punishment{9}{i} = {};
    X = double(PunishmentData1(:,[8,7]));
    y = double(PunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment1.Punishment{9}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment1.Punishment{9}(1+i,:)=[mdl.Experiment1.Punishment{9}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{9}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{9}{i}.Coefficients(:,1))'];
    disp(['Punishment Model 9 ' num2str(i)])
    
    % PunishmentModel0
    mdl.Experiment1.Punishment{10}{i} = {};
    X = double(PunishmentData1(:,[8,7]));
    y = double(PunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + 0*x(:,1);
    beta0 = rand()-.5;
    mdl.Experiment1.Punishment{10}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment1.Punishment{10}(1+i,:)=[mdl.Experiment1.Punishment{10}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{10}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{10}{i}.Coefficients(:,1))'];
    disp(['Punishment Model 10 ' num2str(i)])
end

for i = 1:10
    [AICs.Experiment1.BestPunishment{i}(:,1), AICs.Experiment1.BestPunishment{i}(:,2)] = mink(cell2mat(Models.Experiment1.Punishment{1,i}(2:end,1)),1);
    AICs.Experiment1.Punishment(:,i) = nanmean(cell2mat(Models.Experiment1.Punishment{1,i}(2:end,1)));
    AICs.Experiment1.Punishment_R2(:,i) = nanmean(cell2mat(Models.Experiment1.Punishment{1,i}(2:end,2)));
end
save('SupplementaryResults1.mat','rmANOVAs','Models','mdl','AICs','CohensD') 
%% Run analyses with suspicious participants excluded
clear all
load('Experiment1.mat')

Models.Experiment1.Feelings{1} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Alt' 'Rho Fair' 'Endowment'};
Models.Experiment1.Feelings{2} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho' 'Endowment'};
Models.Experiment1.Feelings{3} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Alt' 'Endowment'};
Models.Experiment1.Feelings{4} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Inequity' 'Endowment'};
Models.Experiment1.Feelings{5} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Endowment'};
Models.Experiment1.Feelings{6} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Rho' 'Endowment'};
Models.Experiment1.Feelings{7} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Endowment'};
Models.Experiment1.Feelings{8} = {'AIC' 'R2' 'Intercept' 'Beta Inequity' 'Rho' 'Endowment'};
Models.Experiment1.Feelings{9} = {'AIC' 'R2' 'Intercept' 'Beta Inequity' 'Endowment'};
Models.Experiment1.Feelings{10} = {'AIC' 'R2' 'Intercept'};
Models.Experiment1.Feelings{11} = {'AIC' 'R2'};

Models.Experiment1.Punishment{1} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Alt' 'Rho Fair' 'Endowment'};
Models.Experiment1.Punishment{2} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho' 'Endowment'};
Models.Experiment1.Punishment{3} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Alt' 'Endowment'};
Models.Experiment1.Punishment{4} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Inequity' 'Endowment'};
Models.Experiment1.Punishment{5} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Endowment'};
Models.Experiment1.Punishment{6} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Rho' 'Endowment'};
Models.Experiment1.Punishment{7} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Endowment'};
Models.Experiment1.Punishment{8} = {'AIC' 'R2' 'Intercept' 'Beta Inequity' 'Rho' 'Endowment'};
Models.Experiment1.Punishment{9} = {'AIC' 'R2' 'Intercept' 'Beta Inequity' 'Endowment'};
Models.Experiment1.Punishment{10} = {'AIC' 'R2' 'Intercept'};
Models.Experiment1.Punishment{11} = {'AIC' 'R2'};

Selfishness = [10:1:100]';
Inequality = [linspace(80,0,41) linspace(2,100,50)]';
Endowment = ones(91,1)*7.5;

% Remove suspicious participants
FeelingsData1.SuspiciousSubjects = repelem(SuspiciousSubjects1,120,1);
FeelingsData1(FeelingsData1.SuspiciousSubjects == 1,:) = [];
sublength = (length(unique(FeelingsData1.ID)));
FeelingsData1.ID = repelem(1:sublength, 1,120)';

PunishmentData1.SuspiciousSubjects = repelem(SuspiciousSubjects1,120,1);
PunishmentData1(PunishmentData1.SuspiciousSubjects == 1,:) = [];
sublength = (length(unique(PunishmentData1.ID)));
PunishmentData1.ID = repelem(1:sublength, 1,120)';

%Feelings means
[meanfeelings,grps] = grpstats(FeelingsData1.Feel1,{FeelingsData1.Allocator,FeelingsData1.ID},{'mean','gname'});
grps=cellfun(@str2double,grps);
for i = [2 0 1]
    meanfeelings2(1:sublength,i+1) = meanfeelings((grps(:,1))==i);
end
mean(meanfeelings2)
std(meanfeelings2)
grps(:,1) = grps(:,1)+1;
rmANOVAs.feelings1 = [meanfeelings grps];
RMAOV1(rmANOVAs.feelings1)
rmANOVAs.partialeta.feelings1 = 70.521 / (70.521 + 53.949);
% One-sample t-tests
[h,p,ci,stats] = ttest(meanfeelings2(:,3))
CohensD.Feelings1.OneSample.Selfish = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanfeelings2(:,2))
CohensD.Feelings1.OneSample.Equal = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanfeelings2(:,1))
CohensD.Feelings1.OneSample.Generous = stats.tstat/sqrt(sublength);
% Paired-samples t-tests
[h,p,ci,stats] = ttest(meanfeelings2(:,1),meanfeelings2(:,2))
CohensD.Feelings1.PairedSamples.GenerousEqual = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanfeelings2(:,1),meanfeelings2(:,3))
CohensD.Feelings1.PairedSamples.GenerousSelfish = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanfeelings2(:,2),meanfeelings2(:,3))
CohensD.Feelings1.PairedSamples.EqualSelfish = stats.tstat/sqrt(sublength);

% Model Feelings
for i = 1:10
    %FeelingsModel1
    mdl.Experiment1.Feelings{1}{i} = {};
    X = double(FeelingsData1(:,[6,8,7]));
    y = double(FeelingsData1.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2).^b(5) + b(6)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Feelings{1}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Feelings{1}{i}) == 0
        Models.Experiment1.Feelings{1}(1+i,:)=[mdl.Experiment1.Feelings{1}{i}.ModelCriterion.AIC mdl.Experiment1.Feelings{1}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Feelings{1}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Feelings{1}{i}) == 1        
        Models.Experiment1.Feelings{1}(1+i,:)={NaN};
    end
    disp(['Feelings Model 1 ' num2str(i)])
    
    %FeelingsModel2
    mdl.Experiment1.Feelings{2}{i} = {};
    X = double(FeelingsData1(:,[6,8,7]));
    y = double(FeelingsData1.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2).^b(4) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Feelings{2}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Feelings{2}{i}) == 0
        Models.Experiment1.Feelings{2}(1+i,:)=[mdl.Experiment1.Feelings{2}{i}.ModelCriterion.AIC mdl.Experiment1.Feelings{2}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Feelings{2}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Feelings{2}{i}) == 1
        Models.Experiment1.Feelings{2}(1+i,:)={NaN};
    end
    disp(['Feelings Model 2 ' num2str(i)])
    
    % FeelingsModel3
    mdl.Experiment1.Feelings{3}{i} = {};
    X = double(FeelingsData1(:,[6,8,7]));
    y = double(FeelingsData1.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Feelings{3}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Feelings{3}{i}) == 0
        Models.Experiment1.Feelings{3}(1+i,:)=[mdl.Experiment1.Feelings{3}{i}.ModelCriterion.AIC mdl.Experiment1.Feelings{3}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Feelings{3}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Feelings{3}{i}) == 1
        Models.Experiment1.Feelings{3}(1+i,:)={NaN};
    end
    disp(['Feelings Model 3 ' num2str(i)])
    
    % FeelingsModel4
    mdl.Experiment1.Feelings{4}{i} = {};
    X = double(FeelingsData1(:,[6,8,7]));
    y = double(FeelingsData1.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2).^b(4) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Feelings{4}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Feelings{4}{i}) == 0
        Models.Experiment1.Feelings{4}(1+i,:)=[mdl.Experiment1.Feelings{4}{i}.ModelCriterion.AIC mdl.Experiment1.Feelings{4}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Feelings{4}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Feelings{4}{i}) == 1
        Models.Experiment1.Feelings{4}(1+i,:)={NaN};
    end
    disp(['Feelings Model 4 ' num2str(i)])
    
    %FeelingsModel5
    mdl.Experiment1.Feelings{5}{i} = {};
    X = double(FeelingsData1(:,[6,8,7]));
    y = double(FeelingsData1.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2) + b(4)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment1.Feelings{5}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment1.Feelings{5}(1+i,:)=[mdl.Experiment1.Feelings{5}{i}.ModelCriterion.AIC mdl.Experiment1.Feelings{5}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Feelings{5}{i}.Coefficients(:,1))'];
    disp(['Feelings Model 5 ' num2str(i)])
    
    % FeelingsModel6
    mdl.Experiment1.Feelings{6}{i} = {};
    X = double(FeelingsData1(:,[6,7]));
    y = double(FeelingsData1.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(3) + b(4)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Feelings{6}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Feelings{6}{i}) == 0
        Models.Experiment1.Feelings{6}(1+i,:)=[mdl.Experiment1.Feelings{6}{i}.ModelCriterion.AIC mdl.Experiment1.Feelings{6}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Feelings{6}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Feelings{6}{i}) == 1
        Models.Experiment1.Feelings{6}(1+i,:)={NaN};
    end
    disp(['Feelings Model 6 ' num2str(i)])
    
    % FeelingsModel7
    mdl.Experiment1.Feelings{7}{i} = {};
    X = double(FeelingsData1(:,[6,7]));
    y = double(FeelingsData1.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment1.Feelings{7}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment1.Feelings{7}(1+i,:)=[mdl.Experiment1.Feelings{7}{i}.ModelCriterion.AIC mdl.Experiment1.Feelings{7}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Feelings{7}{i}.Coefficients(:,1))'];
    disp(['Feelings Model 7 ' num2str(i)])
    
    % FeelingsModel8
    mdl.Experiment1.Feelings{8}{i} = {};
    X = double(FeelingsData1(:,[8,7]));
    y = double(FeelingsData1.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(3) + b(4)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()+.5 rand()-.5];    
    try
        mdl.Experiment1.Feelings{8}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Feelings{8}{i}) == 0
        Models.Experiment1.Feelings{8}(1+i,:)=[mdl.Experiment1.Feelings{8}{i}.ModelCriterion.AIC mdl.Experiment1.Feelings{8}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Feelings{8}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Feelings{8}{i}) == 1
        Models.Experiment1.Feelings{8}(1+i,:)={NaN};
    end    
    disp(['Feelings Model 8 ' num2str(i)])
    
    % FeelingsModel9
    mdl.Experiment1.Feelings{9}{i} = {};
    X = double(FeelingsData1(:,[8,7]));
    y = double(FeelingsData1.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment1.Feelings{9}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment1.Feelings{9}(1+i,:)=[mdl.Experiment1.Feelings{9}{i}.ModelCriterion.AIC mdl.Experiment1.Feelings{9}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Feelings{9}{i}.Coefficients(:,1))'];
    disp(['Feelings Model 9 ' num2str(i)])
    
    % FeelingsModel10
    mdl.Experiment1.Feelings{10}{i} = {};
    X = double(FeelingsData1(:,[8,7]));
    y = double(FeelingsData1.Feel1Z);
    modelfun = @(b,x)b(1) + 0*x(:,1);
    beta0 = rand()-.5;
    mdl.Experiment1.Feelings{10}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment1.Feelings{10}(1+i,:)=[mdl.Experiment1.Feelings{10}{i}.ModelCriterion.AIC mdl.Experiment1.Feelings{10}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Feelings{10}{i}.Coefficients(:,1))'];
    disp(['Feelings Model 10 ' num2str(i)])
end

% Create best-fit model
for i = 1:10
    [AICs.Experiment1.BestFeelings{i}(:,1), AICs.Experiment1.BestFeelings{i}(:,2)] = mink(cell2mat(Models.Experiment1.Feelings{1,i}(2:end,1)),1);
    AICs.Experiment1.Feelings(:,i) = nanmean(cell2mat(Models.Experiment1.Feelings{1,i}(2:end,1)));
    AICs.Experiment1.Feelings_R2(:,i) = nanmean(cell2mat(Models.Experiment1.Feelings{1,i}(2:end,2)));
end

% Run analysis on punishment 
AllPunishmentData1 = [PunishmentData1; FeelingsData1(:,[1:3 11:12 6:8 13:15])];

% Punishment as a binary variable
[meanpun,grps] = grpstats(AllPunishmentData1.PunBinary,{AllPunishmentData1.Allocator,AllPunishmentData1.ID},{'mean','gname'});
grps=cellfun(@str2double,grps);
for i = [2 0 1]
    meanpun2(1:sublength,i+1) = meanpun((grps(:,1))==i);
end
mean(meanpun2)
std(meanpun2)
grps(:,1) = grps(:,1)+1;
rmANOVAs.punishmentBinary1 = [meanpun grps];
RMAOV1(rmANOVAs.punishmentBinary1)
rmANOVAs.partialeta.punishmentBinary1 = 5.204 / (5.204 + 2.708);

[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,1))
CohensD.Punishment1.Frequency.SelfishGenerous = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,2))
CohensD.Punishment1.Frequency.SelfishEqual = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,1),meanpun2(:,2))
CohensD.Punishment1.Frequency.GenerousEqual = stats.tstat/sqrt(sublength);

%Punishment amount
[meanpun,grps] = grpstats(AllPunishmentData1.Punishment,{AllPunishmentData1.Allocator,AllPunishmentData1.ID},{'mean','gname'});
grps=cellfun(@str2double,grps);
for i = [2 0 1]
    meanpun2(1:sublength,i+1) = meanpun((grps(:,1))==i);
end
mean(meanpun2)
std(meanpun2)
grps(:,1) = grps(:,1)+1;
rmANOVAs.punishment1 = [meanpun grps];
RMAOV1(rmANOVAs.punishment1);
rmANOVAs.partialeta.punishment1 = 4.098 / (4.098 + .913);

[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,1))
CohensD.Punishment1.Amount.SelfishGenerous = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,2))
CohensD.Punishment1.Amount.SelfishEqual = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,1),meanpun2(:,2))
CohensD.Punishment1.Amount.GenerousEqual = stats.tstat/sqrt(sublength);

% Model Punishment
for i = 1:10
    % PunishmentModel1
    mdl.Experiment1.Punishment{1}{i} = {};
    X = double(AllPunishmentData1(:,[6,8,7]));
    y = double(AllPunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2).^b(5) + b(6)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Punishment{1}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Punishment{1}{i}) == 0
        Models.Experiment1.Punishment{1}(1+i,:)=[mdl.Experiment1.Punishment{1}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{1}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{1}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Punishment{1}{i}) == 1
        Models.Experiment1.Punishment{1}(1+i,:) = {NaN};
    end
    disp(['Punishment Model 1 ' num2str(i)])
    
    %PunishmentModel2
    mdl.Experiment1.Punishment{2}{i} = {};
    X = double(AllPunishmentData1(:,[6,8,7]));
    y = double(AllPunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2).^b(4) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Punishment{2}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Punishment{2}{i}) == 0
        Models.Experiment1.Punishment{2}(1+i,:)=[mdl.Experiment1.Punishment{2}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{2}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{2}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Punishment{2}{i}) == 1
        Models.Experiment1.Punishment{2}(1+i,:) = {NaN};
    end
    disp(['Punishment Model 2 ' num2str(i)])   
    
    % PunishmentModel3
    mdl.Experiment1.Punishment{3}{i} = {};
    X = double(AllPunishmentData1(:,[6,8,7]));
    y = double(AllPunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Punishment{3}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Punishment{3}{i}) == 0
        Models.Experiment1.Punishment{3}(1+i,:)=[mdl.Experiment1.Punishment{3}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{3}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{3}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Punishment{3}{i}) == 1
        Models.Experiment1.Punishment{3}(1+i,:) = {NaN};
    end
    disp(['Punishment Model 3 ' num2str(i)])   
    
    % PunishmentModel4
    mdl.Experiment1.Punishment{4}{i} = {};
    X = double(AllPunishmentData1(:,[6,8,7]));
    y = double(AllPunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2).^b(4) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Punishment{4}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Punishment{4}{i}) == 0
        Models.Experiment1.Punishment{4}(1+i,:)=[mdl.Experiment1.Punishment{4}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{4}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{4}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Punishment{4}{i}) == 1
        Models.Experiment1.Punishment{4}(1+i,:) = {NaN};
    end
    disp(['Punishment Model 4 ' num2str(i)])
    
    %PunishmentModel5
    mdl.Experiment1.Punishment{5}{i} = {};
    X = double(AllPunishmentData1(:,[6,8,7]));
    y = double(AllPunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2) + b(4)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment1.Punishment{5}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment1.Punishment{5}(1+i,:)=[mdl.Experiment1.Punishment{5}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{5}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{5}{i}.Coefficients(:,1))'];
    disp(['Punishment Model 5 ' num2str(i)])
    
    % PunishmentModel6
    mdl.Experiment1.Punishment{6}{i} = {};
    X = double(AllPunishmentData1(:,[6,7]));
    y = double(AllPunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(3) + b(4)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Punishment{6}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Punishment{6}{i}) == 0
        Models.Experiment1.Punishment{6}(1+i,:)=[mdl.Experiment1.Punishment{6}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{6}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{6}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Punishment{6}{i}) == 1
        Models.Experiment1.Punishment{6}(1+i,:)={NaN};
    end
    disp(['Punishment Model 6 ' num2str(i)])
    
    % PunishmentModel7
    mdl.Experiment1.Punishment{7}{i} = {};
    X = double(AllPunishmentData1(:,[6,7]));
    y = double(AllPunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment1.Punishment{7}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment1.Punishment{7}(1+i,:)=[mdl.Experiment1.Punishment{7}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{7}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{7}{i}.Coefficients(:,1))'];
    disp(['Punishment Model 7 ' num2str(i)])
    
    % PunishmentModel8
    mdl.Experiment1.Punishment{8}{i} = {};
    X = double(AllPunishmentData1(:,[8,7]));
    y = double(AllPunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(3) + b(4)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment1.Punishment{8}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment1.Punishment{8}{i}) == 0
        Models.Experiment1.Punishment{8}(1+i,:)=[mdl.Experiment1.Punishment{8}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{8}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{8}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment1.Punishment{8}{i}) == 1
        Models.Experiment1.Punishment{8}(1+i,:)={NaN};
    end
    disp(['Punishment Model 8 ' num2str(i)])
    
    % PunishmentModel9
    mdl.Experiment1.Punishment{9}{i} = {};
    X = double(AllPunishmentData1(:,[8,7]));
    y = double(AllPunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment1.Punishment{9}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment1.Punishment{9}(1+i,:)=[mdl.Experiment1.Punishment{9}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{9}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{9}{i}.Coefficients(:,1))'];
    disp(['Punishment Model 9 ' num2str(i)])
    
    % PunishmentModel0
    mdl.Experiment1.Punishment{10}{i} = {};
    X = double(AllPunishmentData1(:,[8,7]));
    y = double(AllPunishmentData1.PunishmentZ);
    modelfun = @(b,x)b(1) + 0*x(:,1);
    beta0 = rand()-.5;
    mdl.Experiment1.Punishment{10}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment1.Punishment{10}(1+i,:)=[mdl.Experiment1.Punishment{10}{i}.ModelCriterion.AIC mdl.Experiment1.Punishment{10}{i}.Rsquared.Adjusted table2cell(mdl.Experiment1.Punishment{10}{i}.Coefficients(:,1))'];
    disp(['Punishment Model 10 ' num2str(i)])
end

% Create individual best-fit model
for i = 1:10
    [AICs.Experiment1.BestPunishment{i}(:,1), AICs.Experiment1.BestPunishment{i}(:,2)] = mink(cell2mat(Models.Experiment1.Punishment{1,i}(2:end,1)),1);
    AICs.Experiment1.Punishment(:,i) = nanmean(cell2mat(Models.Experiment1.Punishment{1,i}(2:end,1)));
    AICs.Experiment1.Punishment_R2(:,i) = nanmean(cell2mat(Models.Experiment1.Punishment{1,i}(2:end,2)));
end

% Experiment 2
load('Experiment2.mat')
Models.Experiment2.Feelings{1} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Alt' 'Rho Fair' 'Endowment'};
Models.Experiment2.Feelings{2} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho' 'Endowment'};
Models.Experiment2.Feelings{3} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Alt' 'Endowment'};
Models.Experiment2.Feelings{4} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Inequity' 'Endowment'};
Models.Experiment2.Feelings{5} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Endowment'};
Models.Experiment2.Feelings{6} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Rho' 'Endowment'};
Models.Experiment2.Feelings{7} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Endowment'};
Models.Experiment2.Feelings{8} = {'AIC' 'R2' 'Intercept' 'Beta Inequity' 'Rho' 'Endowment'};
Models.Experiment2.Feelings{9} = {'AIC' 'R2' 'Intercept' 'Beta Inequity' 'Endowment'};
Models.Experiment2.Feelings{10} = {'AIC' 'R2' 'Intercept'};
Models.Experiment2.Feelings{11} = {'AIC' 'R2'};

Models.Experiment2.Punishment{1} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Alt' 'Rho Fair' 'Endowment'};
Models.Experiment2.Punishment{2} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho' 'Endowment'};
Models.Experiment2.Punishment{3} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Alt' 'Endowment'};
Models.Experiment2.Punishment{4} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Rho Inequity' 'Endowment'};
Models.Experiment2.Punishment{5} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Beta Inequity' 'Endowment'};
Models.Experiment2.Punishment{6} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Rho' 'Endowment'};
Models.Experiment2.Punishment{7} = {'AIC' 'R2' 'Intercept' 'Beta Selfishness' 'Endowment'};
Models.Experiment2.Punishment{8} = {'AIC' 'R2' 'Intercept' 'Beta Inequity' 'Rho' 'Endowment'};
Models.Experiment2.Punishment{9} = {'AIC' 'R2' 'Intercept' 'Beta Inequity' 'Endowment'};
Models.Experiment2.Punishment{10} = {'AIC' 'R2' 'Intercept'};
Models.Experiment2.Punishment{11} = {'AIC' 'R2'};

% Remove suspicious participants
FeelingsData2.SuspiciousSubjects = repelem(SuspiciousSubjects2,120,1);
FeelingsData2(FeelingsData2.SuspiciousSubjects == 1,:) = [];
sublength = (length(unique(FeelingsData2.ID)));
FeelingsData2.ID = repelem(1:sublength, 1,120)';
PunishmentData2.SuspiciousSubjects = repelem(SuspiciousSubjects2,120,1);
PunishmentData2(PunishmentData2.SuspiciousSubjects == 1,:) = [];
PunishmentData2.ID = repelem(1:sublength, 1,120)';

% Feelings ANOVAs and ttests
[meanfeelings,grps] = grpstats(FeelingsData2.Feel1,{FeelingsData2.Allocator,FeelingsData2.ID},{'mean','gname'});
grps=cellfun(@str2double,grps);
for i = [2 0 1]
    meanfeelings2(1:sublength,i+1) = meanfeelings((grps(:,1))==i);
end
mean(meanfeelings2)
std(meanfeelings2)
grps(:,1) = grps(:,1)+1;
rmANOVAs.feelings2 = [meanfeelings grps];
RMAOV1(rmANOVAs.feelings2)
rmANOVAs.partialeta.feelings2 = 86.911 / (86.911 + 84.731);
% One-sample t-tests
[h,p,ci,stats] = ttest(meanfeelings2(:,3))
CohensD.Feelings2.OneSample.Selfish = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanfeelings2(:,2))
CohensD.Feelings2.OneSample.Equal = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanfeelings2(:,1))
CohensD.Feelings2.OneSample.Generous = stats.tstat/sqrt(sublength);
% Paired-samples t-tests
[h,p,ci,stats] = ttest(meanfeelings2(:,1),meanfeelings2(:,2))
CohensD.Feelings2.PairedSamples.GenerousEqual = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanfeelings2(:,1),meanfeelings2(:,3))
CohensD.Feelings2.PairedSamples.GenerousSelfish = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanfeelings2(:,2),meanfeelings2(:,3))
CohensD.Feelings2.PairedSamples.EqualSelfish = stats.tstat/sqrt(sublength);

% Model Feelings
for i = 1:10
    %FeelingsModel1
    mdl.Experiment2.Feelings{1}{i} = {};
    X = double(FeelingsData2(:,[6,8,7]));
    y = double(FeelingsData2.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2).^b(5) + b(6)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment2.Feelings{1}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment2.Feelings{1}{i}) == 0
        Models.Experiment2.Feelings{1}(1+i,:)=[mdl.Experiment2.Feelings{1}{i}.ModelCriterion.AIC mdl.Experiment2.Feelings{1}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Feelings{1}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment2.Feelings{1}{i}) == 1        
        Models.Experiment2.Feelings{1}(1+i,:)={NaN};
    end
    disp(['Feelings Model 1 ' num2str(i)])
    
    %FeelingsModel2
    mdl.Experiment2.Feelings{2}{i} = {};
    X = double(FeelingsData2(:,[6,8,7]));
    y = double(FeelingsData2.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2).^b(4) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment2.Feelings{2}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment2.Feelings{2}{i}) == 0
        Models.Experiment2.Feelings{2}(1+i,:)=[mdl.Experiment2.Feelings{2}{i}.ModelCriterion.AIC mdl.Experiment2.Feelings{2}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Feelings{2}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment2.Feelings{2}{i}) == 1
        Models.Experiment2.Feelings{2}(1+i,:)={NaN};
    end
    disp(['Feelings Model 2 ' num2str(i)])
    
    % FeelingsModel3
    mdl.Experiment2.Feelings{3}{i} = {};
    X = double(FeelingsData2(:,[6,8,7]));
    y = double(FeelingsData2.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment2.Feelings{3}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment2.Feelings{3}{i}) == 0
        Models.Experiment2.Feelings{3}(1+i,:)=[mdl.Experiment2.Feelings{3}{i}.ModelCriterion.AIC mdl.Experiment2.Feelings{3}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Feelings{3}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment2.Feelings{3}{i}) == 1
        Models.Experiment2.Feelings{3}(1+i,:)={NaN};
    end
    disp(['Feelings Model 3 ' num2str(i)])
    
    % FeelingsModel4
    mdl.Experiment2.Feelings{4}{i} = {};
    X = double(FeelingsData2(:,[6,8,7]));
    y = double(FeelingsData2.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2).^b(4) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment2.Feelings{4}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment2.Feelings{4}{i}) == 0
        Models.Experiment2.Feelings{4}(1+i,:)=[mdl.Experiment2.Feelings{4}{i}.ModelCriterion.AIC mdl.Experiment2.Feelings{4}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Feelings{4}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment2.Feelings{4}{i}) == 1
        Models.Experiment2.Feelings{4}(1+i,:)={NaN};
    end
    disp(['Feelings Model 4 ' num2str(i)])
    
    %FeelingsModel5
    mdl.Experiment2.Feelings{5}{i} = {};
    X = double(FeelingsData2(:,[6,8,7]));
    y = double(FeelingsData2.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2) + b(4)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment2.Feelings{5}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment2.Feelings{5}(1+i,:)=[mdl.Experiment2.Feelings{5}{i}.ModelCriterion.AIC mdl.Experiment2.Feelings{5}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Feelings{5}{i}.Coefficients(:,1))'];
    disp(['Feelings Model 5 ' num2str(i)])
    
    % FeelingsModel6
    mdl.Experiment2.Feelings{6}{i} = {};
    X = double(FeelingsData2(:,[6,7]));
    y = double(FeelingsData2.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(3) + b(4)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment2.Feelings{6}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment2.Feelings{6}{i}) == 0
        Models.Experiment2.Feelings{6}(1+i,:)=[mdl.Experiment2.Feelings{6}{i}.ModelCriterion.AIC mdl.Experiment2.Feelings{6}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Feelings{6}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment2.Feelings{6}{i}) == 1
        Models.Experiment2.Feelings{6}(1+i,:)={NaN};
    end
    disp(['Feelings Model 6 ' num2str(i)])
    
    % FeelingsModel7
    mdl.Experiment2.Feelings{7}{i} = {};
    X = double(FeelingsData2(:,[6,7]));
    y = double(FeelingsData2.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment2.Feelings{7}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment2.Feelings{7}(1+i,:)=[mdl.Experiment2.Feelings{7}{i}.ModelCriterion.AIC mdl.Experiment2.Feelings{7}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Feelings{7}{i}.Coefficients(:,1))'];
    disp(['Feelings Model 7 ' num2str(i)])
    
    % FeelingsModel8
    mdl.Experiment2.Feelings{8}{i} = {};
    X = double(FeelingsData2(:,[8,7]));
    y = double(FeelingsData2.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(3) + b(4)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()+.5 rand()-.5];    
    try
        mdl.Experiment2.Feelings{8}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment2.Feelings{8}{i}) == 0
        Models.Experiment2.Feelings{8}(1+i,:)=[mdl.Experiment2.Feelings{8}{i}.ModelCriterion.AIC mdl.Experiment2.Feelings{8}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Feelings{8}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment2.Feelings{8}{i}) == 1
        Models.Experiment2.Feelings{8}(1+i,:)={NaN};
    end    
    disp(['Feelings Model 8 ' num2str(i)])
    
    % FeelingsModel9
    mdl.Experiment2.Feelings{9}{i} = {};
    X = double(FeelingsData2(:,[8,7]));
    y = double(FeelingsData2.Feel1Z);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment2.Feelings{9}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment2.Feelings{9}(1+i,:)=[mdl.Experiment2.Feelings{9}{i}.ModelCriterion.AIC mdl.Experiment2.Feelings{9}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Feelings{9}{i}.Coefficients(:,1))'];
    disp(['Feelings Model 9 ' num2str(i)])
    
    % FeelingsModel10
    mdl.Experiment2.Feelings{10}{i} = {};
    X = double(FeelingsData2(:,[8,7]));
    y = double(FeelingsData2.Feel1Z);
    modelfun = @(b,x)b(1) + 0*x(:,1);
    beta0 = rand()-.5;
    mdl.Experiment2.Feelings{10}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment2.Feelings{10}(1+i,:)=[mdl.Experiment2.Feelings{10}{i}.ModelCriterion.AIC mdl.Experiment2.Feelings{10}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Feelings{10}{i}.Coefficients(:,1))'];
    disp(['Feelings Model 10 ' num2str(i)])
end

% Create best-fit model
for i = 1:10
    [AICs.Experiment2.BestFeelings{i}(:,1), AICs.Experiment2.BestFeelings{i}(:,2)] = mink(cell2mat(Models.Experiment2.Feelings{1,i}(2:end,1)),1);
    AICs.Experiment2.Feelings(:,i) = nanmean(cell2mat(Models.Experiment2.Feelings{1,i}(2:end,1)));
    AICs.Experiment2.Feelings_R2(:,i) = nanmean(cell2mat(Models.Experiment2.Feelings{1,i}(2:end,2)));
end

% Run analysis on punishment data
% Punishment as a binary variable
[meanpun,grps] = grpstats(PunishmentData2.PunBinary,{PunishmentData2.Allocator,PunishmentData2.ID},{'mean','gname'});
grps=cellfun(@str2double,grps);
for i = [2 0 1]
    meanpun2(1:sublength,i+1) = meanpun((grps(:,1))==i);
end
mean(meanpun2)
std(meanpun2)
grps(:,1) = grps(:,1)+1;
rmANOVAs.punishmentBinary2 = [meanpun grps];
RMAOV1(rmANOVAs.punishmentBinary2)
rmANOVAs.partialeta.punishmentBinary2 = 9.36 / (9.36 + 1.369);

[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,1))
CohensD.Punishment2.Frequency.SelfishGenerous = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,2))
CohensD.Punishment2.Frequency.SelfishEqual = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,1),meanpun2(:,2))
CohensD.Punishment2.Frequency.GenerousEqual = stats.tstat/sqrt(sublength);

%Punishment amount
[meanpun,grps] = grpstats(PunishmentData2.Punishment,{PunishmentData2.Allocator,PunishmentData2.ID},{'mean','gname'});
grps=cellfun(@str2double,grps);
for i = [2 0 1]
    meanpun2(1:sublength,i+1) = meanpun((grps(:,1))==i);
end
mean(meanpun2)
std(meanpun2)
grps(:,1) = grps(:,1)+1;
rmANOVAs.punishment2 = [meanpun grps];
RMAOV1(rmANOVAs.punishment2)
rmANOVAs.partialeta.punishment2 = 2.835 / (2.835 + .511);

[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,1))
CohensD.Punishment2.Amount.SelfishGenerous = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,2))
CohensD.Punishment2.Amount.SelfishEqual = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,1),meanpun2(:,2))
CohensD.Punishment2.Amount.GenerousEqual = stats.tstat/sqrt(sublength);

% Model Punishment
for i = 1:10
    % PunishmentModel1
    mdl.Experiment2.Punishment{1}{i} = {};
    X = double(PunishmentData2(:,[6,8,7]));
    y = double(PunishmentData2.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2).^b(5) + b(6)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment2.Punishment{1}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment2.Punishment{1}{i}) == 0
        Models.Experiment2.Punishment{1}(1+i,:)=[mdl.Experiment2.Punishment{1}{i}.ModelCriterion.AIC mdl.Experiment2.Punishment{1}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Punishment{1}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment2.Punishment{1}{i}) == 1
        Models.Experiment2.Punishment{1}(1+i,:) = {NaN};
    end
    disp(['Punishment Model 1 ' num2str(i)])
    
    %PunishmentModel2
    mdl.Experiment2.Punishment{2}{i} = {};
    X = double(PunishmentData2(:,[6,8,7]));
    y = double(PunishmentData2.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2).^b(4) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment2.Punishment{2}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment2.Punishment{2}{i}) == 0
        Models.Experiment2.Punishment{2}(1+i,:)=[mdl.Experiment2.Punishment{2}{i}.ModelCriterion.AIC mdl.Experiment2.Punishment{2}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Punishment{2}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment2.Punishment{2}{i}) == 1
        Models.Experiment2.Punishment{2}(1+i,:) = {NaN};
    end
    disp(['Punishment Model 2 ' num2str(i)])   
    
    % PunishmentModel3
    mdl.Experiment2.Punishment{3}{i} = {};
    X = double(PunishmentData2(:,[6,8,7]));
    y = double(PunishmentData2.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(4) + b(3)*x(:,2) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment2.Punishment{3}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment2.Punishment{3}{i}) == 0
        Models.Experiment2.Punishment{3}(1+i,:)=[mdl.Experiment2.Punishment{3}{i}.ModelCriterion.AIC mdl.Experiment2.Punishment{3}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Punishment{3}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment2.Punishment{3}{i}) == 1
        Models.Experiment2.Punishment{3}(1+i,:) = {NaN};
    end
    disp(['Punishment Model 3 ' num2str(i)])   
    
    % PunishmentModel4
    mdl.Experiment2.Punishment{4}{i} = {};
    X = double(PunishmentData2(:,[6,8,7]));
    y = double(PunishmentData2.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2).^b(4) + b(5)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment2.Punishment{4}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment2.Punishment{4}{i}) == 0
        Models.Experiment2.Punishment{4}(1+i,:)=[mdl.Experiment2.Punishment{4}{i}.ModelCriterion.AIC mdl.Experiment2.Punishment{4}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Punishment{4}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment2.Punishment{4}{i}) == 1
        Models.Experiment2.Punishment{4}(1+i,:) = {NaN};
    end
    disp(['Punishment Model 4 ' num2str(i)])
    
    %PunishmentModel5
    mdl.Experiment2.Punishment{5}{i} = {};
    X = double(PunishmentData2(:,[6,8,7]));
    y = double(PunishmentData2.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2) + b(4)*x(:,3);
    beta0 = [rand()-.5 rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment2.Punishment{5}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment2.Punishment{5}(1+i,:)=[mdl.Experiment2.Punishment{5}{i}.ModelCriterion.AIC mdl.Experiment2.Punishment{5}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Punishment{5}{i}.Coefficients(:,1))'];
    disp(['Punishment Model 5 ' num2str(i)])
    
    % PunishmentModel6
    mdl.Experiment2.Punishment{6}{i} = {};
    X = double(PunishmentData2(:,[6,7]));
    y = double(PunishmentData2.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(3) + b(4)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment2.Punishment{6}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment2.Punishment{6}{i}) == 0
        Models.Experiment2.Punishment{6}(1+i,:)=[mdl.Experiment2.Punishment{6}{i}.ModelCriterion.AIC mdl.Experiment2.Punishment{6}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Punishment{6}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment2.Punishment{6}{i}) == 1
        Models.Experiment2.Punishment{6}(1+i,:)={NaN};
    end
    disp(['Punishment Model 6 ' num2str(i)])
    
    % PunishmentModel7
    mdl.Experiment2.Punishment{7}{i} = {};
    X = double(PunishmentData2(:,[6,7]));
    y = double(PunishmentData2.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment2.Punishment{7}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment2.Punishment{7}(1+i,:)=[mdl.Experiment2.Punishment{7}{i}.ModelCriterion.AIC mdl.Experiment2.Punishment{7}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Punishment{7}{i}.Coefficients(:,1))'];
    disp(['Punishment Model 7 ' num2str(i)])
    
    % PunishmentModel8
    mdl.Experiment2.Punishment{8}{i} = {};
    X = double(PunishmentData2(:,[8,7]));
    y = double(PunishmentData2.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(3) + b(4)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()+.5 rand()-.5];
    try
        mdl.Experiment2.Punishment{8}{i} = fitnlm(X,y,modelfun,beta0);
    catch
    end
    if isempty(mdl.Experiment2.Punishment{8}{i}) == 0
        Models.Experiment2.Punishment{8}(1+i,:)=[mdl.Experiment2.Punishment{8}{i}.ModelCriterion.AIC mdl.Experiment2.Punishment{8}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Punishment{8}{i}.Coefficients(:,1))'];
    elseif isempty(mdl.Experiment2.Punishment{8}{i}) == 1
        Models.Experiment2.Punishment{8}(1+i,:)={NaN};
    end
    disp(['Punishment Model 8 ' num2str(i)])
    
    % PunishmentModel9
    mdl.Experiment2.Punishment{9}{i} = {};
    X = double(PunishmentData2(:,[8,7]));
    y = double(PunishmentData2.PunishmentZ);
    modelfun = @(b,x)b(1) + b(2)*x(:,1) + b(3)*x(:,2);
    beta0 = [rand()-.5 rand()-.5 rand()-.5];
    mdl.Experiment2.Punishment{9}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment2.Punishment{9}(1+i,:)=[mdl.Experiment2.Punishment{9}{i}.ModelCriterion.AIC mdl.Experiment2.Punishment{9}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Punishment{9}{i}.Coefficients(:,1))'];
    disp(['Punishment Model 9 ' num2str(i)])
    
    % PunishmentModel10
    mdl.Experiment2.Punishment{10}{i} = {};
    X = double(PunishmentData2(:,[8,7]));
    y = double(PunishmentData2.PunishmentZ);
    modelfun = @(b,x)b(1) + 0*x(:,1);
    beta0 = rand()-.5;
    mdl.Experiment2.Punishment{10}{i} = fitnlm(X,y,modelfun,beta0);
    Models.Experiment2.Punishment{10}(1+i,:)=[mdl.Experiment2.Punishment{10}{i}.ModelCriterion.AIC mdl.Experiment2.Punishment{10}{i}.Rsquared.Adjusted table2cell(mdl.Experiment2.Punishment{10}{i}.Coefficients(:,1))'];
    disp(['Punishment Model 10 ' num2str(i)])
end

% Create individual best-fit model
for i = 1:10
    [AICs.Experiment2.BestPunishment{i}(:,1), AICs.Experiment2.BestPunishment{i}(:,2)] = mink(cell2mat(Models.Experiment2.Punishment{1,i}(2:end,1)),1);
    AICs.Experiment2.Punishment(:,i) = nanmean(cell2mat(Models.Experiment2.Punishment{1,i}(2:end,1)));
    AICs.Experiment2.Punishment_R2(:,i) = nanmean(cell2mat(Models.Experiment2.Punishment{1,i}(2:end,2)));
end

% Feelings relate to punishment
for i = 1:length(unique(FeelingsData1.ID))
    FeelingsData_ID_i = FeelingsData1(FeelingsData1.ID==i,:);
    rho{1}(i,1) = corr(FeelingsData_ID_i.Feel1Z, FeelingsData_ID_i.PunishmentZ);
end
mean(rho{1})
[h,p,ci,stats] = ttest(rho{1})
CohensD.Feelings_Punishment.DirectCorrelation = stats.tstat/sqrt(length(unique(FeelingsData1.ID)));
clear FeelingsData_ID_i

% Model Validation
% Exp 2 Feelings Model is predictive of Exp 1 Feelings and vice versa 
X = double(FeelingsData1(:,[6,8,7]));
ynew = predict(mdl.Experiment2.Feelings{4}{AICs.Experiment2.BestFeelings{4}(2)},X);
FeelingsData1.Feel_pr = ynew;
for i = 1:length(unique(FeelingsData1.ID))
    FeelingsData_ID_i = FeelingsData1(FeelingsData1.ID==i,:);
    rho{2}(i,1) = corr(FeelingsData_ID_i.Feel_pr, FeelingsData_ID_i.Feel1Z);
end
mean(rho{2})
[h,p,ci,stats] = ttest(rho{2})
CohensD.Validation.Feelings1 = stats.tstat/sqrt(length(unique(FeelingsData1.ID)));
clear X ynew FeelingsData_ID_i

FeelingsData2(isnan(FeelingsData2.Feel1Z),:) = [];
X = double(FeelingsData2(:,[6,8,7]));
ynew = predict(mdl.Experiment1.Feelings{4}{AICs.Experiment1.BestFeelings{4}(2)},X);
FeelingsData2.Feel_pr = ynew;
for i = 1:length(unique(FeelingsData2.ID))
    FeelingsData_ID_i = FeelingsData2(FeelingsData2.ID==i,:);
    rho{3}(i,1) = corr(FeelingsData_ID_i.Feel_pr, FeelingsData_ID_i.Feel1Z);
end
mean(rho{3})
[h,p,ci,stats] = ttest(rho{3})
CohensD.Validation.Feelings2 = stats.tstat/sqrt(length(unique(FeelingsData2.ID)));
clear X ynew FeelingsData_ID_i

% Exp 2 Punishment Model is predictive of Exp 1 Punishment and vice versa
X = double(AllPunishmentData1(:,[6,8,7]));
ynew = predict(mdl.Experiment2.Punishment{4}{AICs.Experiment2.BestPunishment{4}(2)},X);
AllPunishmentData1.Pun_pr = ynew;
for i = 1:length(unique(AllPunishmentData1.ID))
    PunishmentData_ID_i = AllPunishmentData1(AllPunishmentData1.ID==i,:);
    rho{4}(i,1) = corr(PunishmentData_ID_i.Pun_pr, PunishmentData_ID_i.PunishmentZ);
end
mean(rho{4})
[h,p,ci,stats] = ttest(rho{4})
CohensD.Validation.Punishment1 = stats.tstat/sqrt(length(unique(AllPunishmentData1.ID)));
clear X ynew PunishmentData_ID_i

X = double(PunishmentData2(:,[6,8,7]));
ynew = predict(mdl.Experiment1.Punishment{4}{AICs.Experiment1.BestPunishment{4}(2)},X);
PunishmentData2.Pun_pr = ynew;
for i = 1:length(unique(PunishmentData2.ID))
    PunishmentData_ID_i = PunishmentData2(PunishmentData2.ID==i,:);
    rho{5}(i,1) = corr(PunishmentData_ID_i.Pun_pr, PunishmentData_ID_i.PunishmentZ);
end
mean(rho{5})
[h,p,ci,stats] = ttest(rho{5})
CohensD.Validation.Punishment2 = stats.tstat/sqrt(length(unique(PunishmentData2.ID)));
clear X ynew PunishmentData_ID_i

%Feel_pr predicting actual punishment both experiments
X = double(AllPunishmentData1(:,[6,8,7]));
ynew = predict(mdl.Experiment2.Feelings{4}{AICs.Experiment2.BestFeelings{4}(2)},X);
AllPunishmentData1.Feel_pr = ynew;
for i = 1:length(unique(AllPunishmentData1.ID))
    PunishmentData_ID_i = AllPunishmentData1(AllPunishmentData1.ID==i,:);
    rho{6}(i,1) = corr(PunishmentData_ID_i.Feel_pr, PunishmentData_ID_i.PunishmentZ);
end
mean(rho{6})
[h,p,ci,stats] = ttest(rho{6})
CohensD.Validation.Feelpr_Punishment1 = stats.tstat/sqrt(length(unique(AllPunishmentData1.ID)));
clear X ynew PunishmentData_ID_i

X = double(PunishmentData2(:,[6,8,7]));
ynew = predict(mdl.Experiment1.Feelings{4}{AICs.Experiment1.BestFeelings{4}(2)},X);
PunishmentData2.Feel_pr = ynew;
for i = 1:length(unique(PunishmentData2.ID))
    PunishmentData_ID_i = PunishmentData2(PunishmentData2.ID==i,:);
    rho{7}(i,1) = corr(PunishmentData_ID_i.Feel_pr, PunishmentData_ID_i.PunishmentZ);
end
mean(rho{7})
[h,p,ci,stats] = ttest(rho{7})
CohensD.Validation.Feelpr_Punishment2 = stats.tstat/sqrt(length(unique(PunishmentData2.ID)));
clear X ynew PunishmentData_ID_i

%Pun_pr predicting actual feelings both experiments
X = double(FeelingsData1(:,[6,8,7]));
ynew = predict(mdl.Experiment2.Punishment{4}{AICs.Experiment2.BestPunishment{4}(2)},X);
FeelingsData1.Pun_pr = ynew;
for i = 1:length(unique(FeelingsData1.ID))
    FeelingsData_ID_i = FeelingsData1(FeelingsData1.ID==i,:);
    rho{8}(i,1) = corr(FeelingsData_ID_i.Pun_pr, FeelingsData_ID_i.Feel1Z);
end
mean(rho{8})
[h,p,ci,stats] = ttest(rho{8})
CohensD.Validation.Punpr_Feelings1 = stats.tstat/sqrt(length(unique(FeelingsData1.ID)));
clear X ynew FeelingsData_ID_i

X = double(FeelingsData2(:,[6,8,7]));
ynew = predict(mdl.Experiment1.Punishment{4}{AICs.Experiment1.BestPunishment{4}(2)},X);
FeelingsData2.Pun_pr = ynew;
for i = 1:length(unique(FeelingsData2.ID))
    FeelingsData_ID_i = FeelingsData2(FeelingsData2.ID==i,:);
    rho{9}(i,1) = corr(FeelingsData_ID_i.Pun_pr, FeelingsData_ID_i.Feel1Z);
end
mean(rho{9})
[h,p,ci,stats] = ttest(rho{9})
CohensD.Validation.Punpr_Feelings2 = stats.tstat/sqrt(length(unique(FeelingsData2.ID)));
clear X ynew FeelingsData_ID_i

% Differential impact of selfishness and inequity on feelings and punishment
Split = [0:10:100]';
Inequality = [100 80 60 40 20 0 20 40 60 80 100]';

% Experiment 1
Impact.Selfishness_Feelings = table2array(mdl.Experiment1.Feelings{4}{AICs.Experiment1.BestFeelings{4}(2)}.Coefficients(2,1)).*-Split;
Impact.Inequity_Feelings = table2array(mdl.Experiment1.Feelings{4}{AICs.Experiment1.BestFeelings{4}(2)}.Coefficients(3,1)).*-Inequality.^table2array(mdl.Experiment1.Feelings{4}{AICs.Experiment1.BestFeelings{4}(2)}.Coefficients(4,1));
Impact.Selfishness_Punishment = table2array(mdl.Experiment1.Punishment{4}{AICs.Experiment1.BestPunishment{4}(2)}.Coefficients(2,1)).*Split;
Impact.Inequity_Punishment = table2array(mdl.Experiment1.Punishment{4}{AICs.Experiment1.BestPunishment{4}(2)}.Coefficients(3,1)).*Inequality.^table2array(mdl.Experiment1.Punishment{4}{AICs.Experiment1.BestPunishment{4}(2)}.Coefficients(4,1));

% Experiment 2
Impact.Selfishness_Feelings2 = table2array(mdl.Experiment2.Feelings{4}{AICs.Experiment2.BestFeelings{4}(2)}.Coefficients(2,1)).*-Split;
Impact.Inequity_Feelings2 = table2array(mdl.Experiment2.Feelings{4}{AICs.Experiment2.BestFeelings{4}(2)}.Coefficients(3,1)).*-Inequality.^table2array(mdl.Experiment2.Feelings{4}{AICs.Experiment2.BestFeelings{4}(2)}.Coefficients(4,1));
Impact.Selfishness_Punishment2 = table2array(mdl.Experiment2.Punishment{4}{AICs.Experiment2.BestPunishment{4}(2)}.Coefficients(2,1)).*Split;
Impact.Inequity_Punishment2 = table2array(mdl.Experiment2.Punishment{4}{AICs.Experiment2.BestPunishment{4}(2)}.Coefficients(3,1)).*Inequality.^table2array(mdl.Experiment2.Punishment{4}{AICs.Experiment2.BestPunishment{4}(2)}.Coefficients(4,1));

% 2x2x2 rmANOVA
t = table(categorical([ones(length(Impact.Selfishness_Punishment),1); ones(length(Impact.Selfishness_Punishment),1)*2]),...
    [Impact.Selfishness_Feelings; Impact.Selfishness_Feelings2], [Impact.Inequity_Feelings;Impact.Inequity_Feelings2],...
    [Impact.Selfishness_Punishment; Impact.Selfishness_Punishment2], [Impact.Inequity_Punishment;Impact.Inequity_Punishment2],...
    'VariableNames',{'Experiment','SelfAv_F','InAv_F','SelfAv_P','InAv_P'});
within = table(categorical([1 1 2 2]'),categorical([1 2 1 2]'),'VariableNames',{'Response','Value'});
rm = fitrm(t,'SelfAv_F-InAv_P~Experiment','WithinDesign',within);
rm.Coefficients
ranovatbl = ranova(rm,'WithinModel','Response*Value')
rmANOVAs.partialeta.Response_Value = 121.81/(121.81+20);
rmANOVAs.partialeta.Response_Value_Experiment = 8.2853/(8.2853+20);
rmANOVAs.Comparisons.Response_Value = multcompare(rm,'Response','By','Value');
rmANOVAs.Comparisons.Response_Value_Means = margmean(rm,{'Response' 'Value'});
rmANOVAs.Comparisons.Response_Value_tValue1 = table2array(rmANOVAs.Comparisons.Response_Value(2,4)) / table2array(rmANOVAs.Comparisons.Response_Value(2,5));
rmANOVAs.Comparisons.Response_Value_tValue2 = table2array(rmANOVAs.Comparisons.Response_Value(3,4)) / table2array(rmANOVAs.Comparisons.Response_Value(3,5));
rmANOVAs.Comparisons.Response_Value_Experiment_Means = margmean(rm,{'Response' 'Value' 'Experiment'});

save('SupplementaryResults2.mat','rmANOVAs','Models','mdl','AICs','CohensD','rho') 
%% Feelings about own decision
clear all
load('Experiment1.mat')
load('Experiment2.mat')
load('Results.mat')

FeelingsData1.FeelBin = NaN(3840,1);
PunishmentData2.FeelBin = NaN(4200,1);

% Interaction between Feelings1 and Punishment, Exp 1
for i = 1:length(unique(FeelingsData1.ID))
    FeelingsData_ID_i = FeelingsData1(FeelingsData1.ID==i,:);    
    mdl.Experiment1.Feelings2{i} = fitlm(FeelingsData_ID_i,'Feel2Z~Feel1Z+PunishmentZ+Feel1Z*PunishmentZ+Endow');
    Models.Experiment1.Feelings2(i,1:5)=table2cell(mdl.Experiment1.Feelings2{i}.Coefficients(:,1))'; %Int, Feel1Z, Endow, PunishmentZ, interaction
    
    %median split for graph
    FeelingsData_ID_i.FeelBin(FeelingsData_ID_i.Feel1Z > quantile(FeelingsData_ID_i.Feel1Z,.5)) = 1;
    FeelingsData_ID_i.FeelBin(FeelingsData_ID_i.Feel1Z <= quantile(FeelingsData_ID_i.Feel1Z,.5)) = 0;
    FeelingsData1.FeelBin(FeelingsData1.ID==i) = FeelingsData_ID_i.FeelBin;
end
mean(cell2mat(Models.Experiment1.Feelings2))
std(cell2mat(Models.Experiment1.Feelings2))
[h,p,ci,stats] = ttest(cell2mat(Models.Experiment1.Feelings2))

% Interaction between Feel1 and Punishment, Exp 2
X = double(PunishmentData2(:,[6,8,7]));
[ynew,ynewci] = predict(mdl.Experiment1.Feelings{4}{AICs.Experiment1.BestFeelings{4}(2)},X);
PunishmentData2.Feel_pr = ynew;
for i = 1:(length(unique(FeelingsData2.ID)))
    PunishmentData_ID_i = PunishmentData2(PunishmentData2.ID==i,:);
    mdl.Experiment2.Feelings2{i} = fitlm(PunishmentData_ID_i,'Feel2Z~Feel_pr+PunishmentZ+Feel_pr*PunishmentZ+Endow');
    Models.Experiment2.Feelings2(i,1:5)=table2cell(mdl.Experiment2.Feelings2{i}.Coefficients(:,1))'; %Int, Feel1Z, Endow, PunishmentZ, interaction
    
    %median split for graph
    PunishmentData_ID_i.FeelBin(PunishmentData_ID_i.Feel_pr > quantile(PunishmentData_ID_i.Feel_pr,.5)) = 1;
    PunishmentData_ID_i.FeelBin(PunishmentData_ID_i.Feel_pr <= quantile(PunishmentData_ID_i.Feel_pr,.5)) = 0;    
    PunishmentData2.FeelBin(PunishmentData2.ID==i) = PunishmentData_ID_i.FeelBin;
end
mean(cell2mat(Models.Experiment2.Feelings2))
std(cell2mat(Models.Experiment1.Feelings2))
[h,p,ci,stats] = ttest(cell2mat(Models.Experiment2.Feelings2))

% Make Graph
figure
scatter(FeelingsData1.PunishmentZ(FeelingsData1.FeelBin == 0), FeelingsData1.Feel2Z(FeelingsData1.FeelBin == 0))
lsline

figure
scatter(FeelingsData1.PunishmentZ(FeelingsData1.FeelBin == 1), FeelingsData1.Feel2Z(FeelingsData1.FeelBin == 1))
lsline

figure
scatter(PunishmentData2.PunishmentZ(PunishmentData2.FeelBin == 0), PunishmentData2.Feel2Z(PunishmentData2.FeelBin == 0))
lsline

figure
scatter(PunishmentData2.PunishmentZ(PunishmentData2.FeelBin == 1), PunishmentData2.Feel2Z(PunishmentData2.FeelBin == 1))
lsline


