%This tool attempts to generalize a tool I used to compare the total annual 
%cost of the health insurance plans at my old job as a function of total 
%annual billed medical service
%
%Notes:
%--"total billed cost" assumed to not include "not subject to deductible"
%   costs such as preventive care, birth control, immunizations, etc.
%--Some plans offer different coverage % for different services; this assumes
%   all charges are covered at the most typical % for that plan
%--All plans assume all costs incurred in-network
%--ppoInd is same as ppo, but if only 1 family member incurs all costs
%--hsa out-of-pocket limit includes drugs, others don't; billed medical
%   costs here ignores pharmacy benefits
%--hmo and ppo plans represent copays as a constant percentage of total
%   billed costs; tweak this for your personal situation
%--hsa, ppo, and hmoBlue plans share network, different from hmoKai network
%--"moop" means "Maximum Out-Of-Pocket" limit
%--Differing tax ramifications are not taken into account


%----------------------------------------
%Setup parameters from plan documentation
%----------------------------------------

%Consumer Choice HSA
hsa = InsurancePlan();
hsa.name = 'Consumer Choice HSA';
hsa.premium = 258;
hsa.deductible = 4400;
hsa.moop = 7400; 
hsa.coverage = .8;
hsa.copayFactor = 0; %Should be 0 for HSAs
hsa.hsaContribution = 750;

%Comprehensive Care
ppo = InsurancePlan();
ppo.name = 'Comprehensive Care';
ppo.premium = 554;
ppo.deductible = 2250;
ppo.moop = 3500;
ppo.coverage = .9;
ppo.copayFactor = .1; 

%Comprehensive Care (Single family member incurs all costs)
ppoInd = InsurancePlan();
ppoInd.name = 'Comprehensive Care (One member sick)';
ppoInd.premium = 554;
ppoInd.deductible = 750; 
ppoInd.moop = 3500;
ppoInd.coverage = .9;
ppoInd.copayFactor = .1; 

%BlueChoice HMO
hmoBlue = InsurancePlan();
hmoBlue.name = 'BlueChoice HMO';
hmoBlue.premium = 640;
hmoBlue.deductible = 0;
hmoBlue.moop = 9900;
hmoBlue.coverage = 1;
hmoBlue.copayFactor = .2;

%Kaiser Permanente HMO
hmoKai = InsurancePlan();
hmoKai.name = 'Kaiser Permanente HMO';
hmoKai.premium = 487;
hmoKai.deductible = 0;
hmoKai.moop = 12700;
hmoKai.coverage = 1;
hmoKai.copayFactor = .2;

%Uninsured
none = InsurancePlan();
none.name = 'Uninsured';
none.premium = 0;
none.deductible = 0;
none.moop = Inf;
none.coverage = 0;
none.copayFactor = 0;
%----------------------------------------
%Produce Figure
%----------------------------------------

figure
hsa.plotCost('b','linewidth',3);
hold on
ppo.plotCost('r','linewidth',3)
ppoInd.plotCost('g','linewidth',3);
hmoBlue.plotCost('c','linewidth',3);
hmoKai.plotCost('k','linewidth',3);
none.plotCost('k--','linewidth',.5);

grid on
%     legend(hsa.name,ppo.name,ppoInd.name,hmoBlue.name,hmoKai.name,'location','southeast')
legend(hsa.name,ppo.name,ppoInd.name,hmoBlue.name,hmoKai.name,none.name,'location','southeast')
axis([0,30,0,14000]);
ax = gca;

title('Total Annual Healthcare Cost vs. Annual Medical Bills')
xlabel('Total Billed Medical Expense (in $1000)')
ylabel('Total Healthcare Cost (in $)')
