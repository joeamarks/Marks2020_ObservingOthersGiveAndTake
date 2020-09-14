%% Run mixed models on Feelings and Punishment Data
clear all
close all
clc
load('Experiment1.mat')
%% Set up
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
sublength = (length(unique(FeelingsData1.ID)));
%% Run analysis on means of raw feelings data
%Feelings means
[meanfeelings,grps] = grpstats(FeelingsData1.Feel1,{FeelingsData1.Allocator,FeelingsData1.ID},{'mean','gname'});
grps=cellfun(@str2double,grps);
for i = [2 0 1]
    meanfeelings2(1:sublength,i+1) = meanfeelings((grps(:,1))==i);
end
grps(:,1) = grps(:,1)+1;
rmANOVAs.feelings1 = [meanfeelings grps];
RMAOV1(rmANOVAs.feelings1)
rmANOVAs.partialeta.feelings1 = 97.594 / (97.594 + 67.892);
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

% Plot
figure
boxplot(meanfeelings2,'Colors',[0.5 0.5 0.5],'Symbol','')
sz = 4;
hold on
scatter(grps(:,1)-.1+rand(length(grps(:,1)),1)/5,meanfeelings,sz,'filled','MarkerEdgeColor',[.5 .5 .5],...
              'MarkerFaceColor',[.5 .5 .5])
ax = gca;
%ax.XLim = [0 4];
ax.YLim = [-3 3];
xticks([1,2,3]);
xticklabels({' ',' ',' '})
set(gca,'box','off');
set(gcf,'color','w');
hold on
plot(1:3,mean(meanfeelings2), 'dr','MarkerSize',8,'MarkerFaceColor','r')
plot(1:3,mean(meanfeelings2),'--')
hold off
%% Model Feelings
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
%% Create individual best-fit model
for i = 1:10
    [AICs.Experiment1.BestFeelings{i}(:,1), AICs.Experiment1.BestFeelings{i}(:,2)] = mink(cell2mat(Models.Experiment1.Feelings{1,i}(2:end,1)),1);
    AICs.Experiment1.Feelings(:,i) = nanmean(cell2mat(Models.Experiment1.Feelings{1,i}(2:end,1)));
    AICs.Experiment1.Feelings_R2(:,i) = nanmean(cell2mat(Models.Experiment1.Feelings{1,i}(2:end,2)));
end
figure
barh(AICs.Experiment1.Feelings)
figure
barh(AICs.Experiment1.Feelings_R2)
%% Graph all feelings data model 4
Split = 10:10:100;
Xnew(:,1) = Selfishness;
Xnew(:,2) = Inequality;
Xnew(:,3) = Endowment;
[ynew,ynewci] = predict(mdl.Experiment1.Feelings{4}{AICs.Experiment1.BestFeelings{4}(2)},Xnew);
[meanfeel,grps] = grpstats(FeelingsData1.Feel1Z,{FeelingsData1.Selfishness,FeelingsData1.ID},{'mean','gname'});
[meanfeel2,Fsem,Fstd,Fci] = grpstats(meanfeel,grps(:,1),{'mean','sem','std','meanci'});
grps=cellfun(@str2double,grps);
figure
rgb_fill = [.4900, .1800, .5500];
rgb_line = [0.9414 0.9414 0.3359];
plot_ci(Xnew(:,1),[ynew,ynewci(:,1),ynewci(:,2)], 'PatchColor', 'r', 'PatchAlpha', 0.2, ...
    'MainLineStyle', 'none', ...
    'LineStyle','none');
hold on
scatter(Split, meanfeel2,'MarkerFaceColor','r');
errorbar(Split, meanfeel2,Fsem, 'LineStyle','none', 'Color', 'k');
plot(Xnew(:,1),ynew,'LineWidth',2,'Color','r')
ax = gca;
ax.XLim = [10 100];
ax.YLim = [-3 3];
%% Run analysis on punishment 
AllPunishmentData1 = [PunishmentData1; FeelingsData1(:,[1:3 11:12 6:8 13:14])];
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
rmANOVAs.partialeta.punishmentBinary1 = 8.569 / (8.569 + 3.189);

[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,1))
CohensD.Punishment1.Frequency.SelfishGenerous = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,2))
CohensD.Punishment1.Frequency.SelfishEqual = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,1),meanpun2(:,2))
CohensD.Punishment1.Frequency.GenerousEqual = stats.tstat/sqrt(sublength);

figure
boxplot(meanpun2,'Colors',[0.5 0.5 0.5],'Symbol','')
sz = 4;
hold on
scatter(grps(:,1)-.1+rand(length(grps(:,1)),1)/5,meanpun,sz,'filled','MarkerEdgeColor',[.5 .5 .5],...
              'MarkerFaceColor',[.5 .5 .5])
ax = gca;
%ax.XLim = [0 4];
ax.YLim = [0 1];
xticks([1,2,3]);
xticklabels({' ',' ',' '})
set(gca,'box','off');
set(gcf,'color','w');
hold on
plot(1:3,mean(meanpun2), 'dr','MarkerSize',8,'MarkerFaceColor','r')
plot(1:3,mean(meanpun2),'--')
hold off

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
rmANOVAs.partialeta.punishment1 = 5.563 / (5.563 + 1.039);

[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,1))
CohensD.Punishment1.Amount.SelfishGenerous = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,2))
CohensD.Punishment1.Amount.SelfishEqual = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,1),meanpun2(:,2))
CohensD.Punishment1.Amount.GenerousEqual = stats.tstat/sqrt(sublength);

figure
boxplot(meanpun2,'Colors',[0.5 0.5 0.5],'Symbol','')
sz = 4;
hold on
scatter(grps(:,1)-.1+rand(length(grps(:,1)),1)/5,meanpun,sz,'filled','MarkerEdgeColor',[.5 .5 .5],...
              'MarkerFaceColor',[.5 .5 .5])
ax = gca;
%ax.XLim = [0 4];
ax.YLim = [0 1];
xticks([1,2,3]);
xticklabels({' ',' ',' '})
set(gca,'box','off');
set(gcf,'color','w');
hold on
plot(1:3,mean(meanpun2), 'dr','MarkerSize',8,'MarkerFaceColor','r')
plot(1:3,mean(meanpun2),'--')
hold off
%% Model Punishment
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
%% Create individual best-fit model
for i = 1:10
    [AICs.Experiment1.BestPunishment{i}(:,1), AICs.Experiment1.BestPunishment{i}(:,2)] = mink(cell2mat(Models.Experiment1.Punishment{1,i}(2:end,1)),1);
    AICs.Experiment1.Punishment(:,i) = nanmean(cell2mat(Models.Experiment1.Punishment{1,i}(2:end,1)));
    AICs.Experiment1.Punishment_R2(:,i) = nanmean(cell2mat(Models.Experiment1.Punishment{1,i}(2:end,2)));
end
figure
barh(AICs.Experiment1.Punishment)
figure
barh(AICs.Experiment1.Punishment_R2)
%% Graph all punishment data Model 4
Split = 10:10:100;
clear Xnew
Xnew(:,1) = Selfishness;
Xnew(:,2) = Inequality;
Xnew(:,3) = Endowment;
[ynew,ynewci] = predict(mdl.Experiment1.Punishment{4}{AICs.Experiment1.BestPunishment{4}(2)},Xnew);
[meanpun,grps] = grpstats(AllPunishmentData1.PunishmentZ,{AllPunishmentData1.Selfishness,AllPunishmentData1.ID},{'mean','gname'});
[meanpun2,Psem,Pstd,Pci] = grpstats(meanpun,grps(:,1),{'mean','sem','std','meanci'});
grps=cellfun(@str2double,grps);
figure
rgb_fill = [.4900, .1800, .5500];
rgb_line = [0.9414 0.9414 0.3359];
plot_ci(Selfishness,[ynew,ynewci(:,1),ynewci(:,2)], 'PatchColor', [.4900, .1800, .5500], 'PatchAlpha', 0.2, ...
    'MainLineStyle', 'none', ...
    'LineStyle','none');
hold on
scatter(Split, meanpun2,'MarkerFaceColor',[.49, .18, .55]);
errorbar(Split, meanpun2,Psem, 'LineStyle','none', 'Color', 'k');
plot(Selfishness,ynew,'LineWidth',2,'Color',[.49, .18, .55])
ax = gca;
ax.XLim = [10 100];
ax.YLim = [-3 3];

save('Results.mat','rmANOVAs','Models','mdl','AICs','CohensD')
%% Experiment 2
clear all
clc
load('Results.mat')
load('Experiment2.mat')
%% Set up
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

Selfishness = [10:1:100]';
Inequality = [linspace(80,0,41) linspace(2,100,50)]';
Endowment = ones(91,1)*7.5;
sublength = (length(unique(FeelingsData2.ID)));
%% Feelings ANOVAs and ttests
%Feelings means
[meanfeelings,grps] = grpstats(FeelingsData2.Feel1,{FeelingsData2.Allocator,FeelingsData2.ID},{'mean','gname'});
grps=cellfun(@str2double,grps);
for i = [2 0 1]
    meanfeelings2(1:sublength,i+1) = meanfeelings((grps(:,1))==i);
end
grps(:,1) = grps(:,1)+1;
rmANOVAs.feelings2 = [meanfeelings grps];
RMAOV1(rmANOVAs.feelings2)
rmANOVAs.partialeta.feelings2 = 123.108 / (123.108 + 122.328);

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

figure
boxplot(meanfeelings2,'Colors',[0.5 0.5 0.5],'Symbol','')
sz = 4;
hold on
scatter(grps(:,1)-.1+rand(length(grps(:,1)),1)/5,meanfeelings,sz,'filled','MarkerEdgeColor',[.5 .5 .5],...
              'MarkerFaceColor',[.5 .5 .5])
ax = gca;
%ax.XLim = [0 4];
ax.YLim = [-3 3];
xticks([1,2,3]);
xticklabels({' ',' ',' '})
set(gca,'box','off');
set(gcf,'color','w');
hold on
plot(1:3,mean(meanfeelings2), 'dr','MarkerSize',8,'MarkerFaceColor','r')
plot(1:3,mean(meanfeelings2),'--')
hold off
%% Model Feelings
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
%% Create individual best-fit model
for i = 1:10
    [AICs.Experiment2.BestFeelings{i}(:,1), AICs.Experiment2.BestFeelings{i}(:,2)] = mink(cell2mat(Models.Experiment2.Feelings{1,i}(2:end,1)),1);
    AICs.Experiment2.Feelings(:,i) = nanmean(cell2mat(Models.Experiment2.Feelings{1,i}(2:end,1)));
    AICs.Experiment2.Feelings_R2(:,i) = nanmean(cell2mat(Models.Experiment2.Feelings{1,i}(2:end,2)));
end
figure
barh(AICs.Experiment2.Feelings)
figure
barh(AICs.Experiment2.Feelings_R2)
%% Graph all feelings data model 4
Split = 10:10:100;
Xnew(:,1) = Selfishness;
Xnew(:,2) = Inequality;
Xnew(:,3) = Endowment;
[ynew,ynewci] = predict(mdl.Experiment2.Feelings{4}{AICs.Experiment2.BestFeelings{4}(2)},Xnew);
[meanfeel,grps] = grpstats(FeelingsData2.Feel1Z,{FeelingsData2.Selfishness,FeelingsData2.ID},{'mean','gname'});
[meanfeel2,Fsem,Fstd,Fci] = grpstats(meanfeel,grps(:,1),{'mean','sem','std','meanci'});
grps=cellfun(@str2double,grps);
figure
rgb_fill = [.4900, .1800, .5500];
rgb_line = [0.9414 0.9414 0.3359];
plot_ci(Xnew(:,1),[ynew,ynewci(:,1),ynewci(:,2)], 'PatchColor', 'r', 'PatchAlpha', 0.2, ...
    'MainLineStyle', 'none', ...
    'LineStyle','none');
hold on
scatter(Split, meanfeel2,'MarkerFaceColor','r');
errorbar(Split, meanfeel2,Fsem, 'LineStyle','none', 'Color', 'k');
plot(Xnew(:,1),ynew,'LineWidth',2,'Color','r')
ax = gca;
ax.XLim = [10 100];
ax.YLim = [-3 3];
%% Run analysis on punishment data
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
rmANOVAs.partialeta.punishmentBinary2 = 11.532 / (11.532 + 2.318);

[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,1))
CohensD.Punishment2.Frequency.SelfishGenerous = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,2))
CohensD.Punishment2.Frequency.SelfishEqual = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,1),meanpun2(:,2))
CohensD.Punishment2.Frequency.GenerousEqual = stats.tstat/sqrt(sublength);

figure
boxplot(meanpun2,'Colors',[0.5 0.5 0.5],'Symbol','')
sz = 4;
hold on
scatter(grps(:,1)-.1+rand(length(grps(:,1)),1)/5,meanpun,sz,'filled','MarkerEdgeColor',[.5 .5 .5],...
              'MarkerFaceColor',[.5 .5 .5])
ax = gca;
%ax.XLim = [0 4];
ax.YLim = [0 1];
xticks([1,2,3]);
xticklabels({' ',' ',' '})
set(gca,'box','off');
set(gcf,'color','w');
hold on
plot(1:3,mean(meanpun2), 'dr','MarkerSize',8,'MarkerFaceColor','r')
plot(1:3,mean(meanpun2),'--')
hold off

%Punishment amount
[meanpun,grps] = grpstats(PunishmentData2.Punishment,{PunishmentData2.Allocator,PunishmentData2.ID},{'mean','gname'});
grps=cellfun(@str2double,grps);
for i = [2 0 1]
    meanpun2(1:sublength,i+1) = meanpun((grps(:,1))==i);
end
grps(:,1) = grps(:,1)+1;
rmANOVAs.punishment2 = [meanpun grps];
RMAOV1(rmANOVAs.punishment2)
rmANOVAs.partialeta.punishment2 = 3.691 / (3.691 + 1.383);

[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,1))
CohensD.Punishment2.Amount.SelfishGenerous = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,3),meanpun2(:,2))
CohensD.Punishment2.Amount.SelfishEqual = stats.tstat/sqrt(sublength);
[h,p,ci,stats] = ttest(meanpun2(:,1),meanpun2(:,2))
CohensD.Punishment2.Amount.GenerousEqual = stats.tstat/sqrt(sublength);

figure
boxplot(meanpun2,'Colors',[0.5 0.5 0.5],'Symbol','')
sz = 4;
hold on
scatter(grps(:,1)-.1+rand(length(grps(:,1)),1)/5,meanpun,sz,'filled','MarkerEdgeColor',[.5 .5 .5],...
              'MarkerFaceColor',[.5 .5 .5])
ax = gca;
%ax.XLim = [0 4];
ax.YLim = [0 1];
xticks([1,2,3]);
xticklabels({' ',' ',' '})
set(gca,'box','off');
set(gcf,'color','w');
hold on
plot(1:3,mean(meanpun2), 'dr','MarkerSize',8,'MarkerFaceColor','r')
plot(1:3,mean(meanpun2),'--')
hold off
%% Model Punishment
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
%% Create individual best-fit model
for i = 1:10
    [AICs.Experiment2.BestPunishment{i}(:,1), AICs.Experiment2.BestPunishment{i}(:,2)] = mink(cell2mat(Models.Experiment2.Punishment{1,i}(2:end,1)),1);
    AICs.Experiment2.Punishment(:,i) = nanmean(cell2mat(Models.Experiment2.Punishment{1,i}(2:end,1)));
    AICs.Experiment2.Punishment_R2(:,i) = nanmean(cell2mat(Models.Experiment2.Punishment{1,i}(2:end,2)));
end
figure
barh(AICs.Experiment2.Punishment)
figure
barh(AICs.Experiment2.Punishment_R2)
%% Graph all punishment data Model 4
Split = 10:10:100;
clear Xnew
Xnew(:,1) = Selfishness;
Xnew(:,2) = Inequality;
Xnew(:,3) = Endowment;
[ynew,ynewci] = predict(mdl.Experiment2.Punishment{4}{AICs.Experiment2.BestPunishment{4}(2)},Xnew);
[meanpun,grps] = grpstats(PunishmentData2.PunishmentZ,{PunishmentData2.Selfishness,PunishmentData2.ID},{'mean','gname'});
[meanpun2,Psem,Pstd,Pci] = grpstats(meanpun,grps(:,1),{'mean','sem','std','meanci'});
grps=cellfun(@str2double,grps);
figure
rgb_fill = [.4900, .1800, .5500];
rgb_line = [0.9414 0.9414 0.3359];
plot_ci(Selfishness,[ynew,ynewci(:,1),ynewci(:,2)], 'PatchColor', [.4900, .1800, .5500], 'PatchAlpha', 0.2, ...
    'MainLineStyle', 'none', ...
    'LineStyle','none');
hold on
scatter(Split, meanpun2,'MarkerFaceColor',[.49, .18, .55]);
errorbar(Split, meanpun2,Psem, 'LineStyle','none', 'Color', 'k');
plot(Selfishness,ynew,'LineWidth',2,'Color',[.49, .18, .55])
ax = gca;
ax.XLim = [10 100];
ax.YLim = [-3 3];

save('Results.mat','rmANOVAs','Models','mdl','AICs','CohensD') 
%% Feelings relate to punishment Experiment1
clear all
load('Results.mat')
load('Experiment1.mat')
load('Experiment2.mat')

for i = 1:length(unique(FeelingsData1.ID))
    FeelingsData_ID_i = FeelingsData1(FeelingsData1.ID==i,:);
    rho{1}(i,1) = corr(FeelingsData_ID_i.Feel1Z, FeelingsData_ID_i.PunishmentZ);
end
mean(rho{1})
[h,p,ci,stats] = ttest(rho{1})
CohensD.Feelings_Punishment.DirectCorrelation = stats.tstat/sqrt(length(unique(FeelingsData1.ID)));
clear FeelingsData_ID_i
%% Model Validation
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
AllPunishmentData1 = [PunishmentData1; FeelingsData1(:,[1:3 11:12 6:8 13:14])];
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
%% Differential impact of selfishness and inequity on feelings and punishment
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
rmANOVAs.partialeta.Response_Value = 132.57/(132.57+20);
rmANOVAs.partialeta.Response_Value_Experiment = 13.4879/(13.4879+20);
rmANOVAs.Comparisons.Response_Value = multcompare(rm,'Response','By','Value');
rmANOVAs.Comparisons.Response_Value_Means = margmean(rm,{'Response' 'Value'});
rmANOVAs.Comparisons.Response_Value_tValue1 = table2array(rmANOVAs.Comparisons.Response_Value(2,4)) / table2array(rmANOVAs.Comparisons.Response_Value(2,5));
rmANOVAs.Comparisons.Response_Value_tValue2 = table2array(rmANOVAs.Comparisons.Response_Value(3,4)) / table2array(rmANOVAs.Comparisons.Response_Value(3,5));
rmANOVAs.Comparisons.Response_Value_Experiment_Means = margmean(rm,{'Response' 'Value' 'Experiment'});
save('Results.mat','rmANOVAs','Models','mdl','AICs','CohensD','rho') 