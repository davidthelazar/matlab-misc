classdef InsurancePlan<handle
   
	properties
        name
        premium %monthly
        deductible
        moop
        coverage
        copayFactor
        billedRange = 0:100:30000;
        hsaContribution = 0;
    end
    methods
        function[cost] = getCost(obj,expense)
    
            expenseBelow = min(obj.deductible,expense); %How much of this billed cost is below our deductible
            expenseAbove = max(expense-obj.deductible,0); %How much of this billed cost is above our deductible
            expenseCopay = expense.*obj.copayFactor;

            cost = obj.annualPremium()-obj.hsaContribution + min(obj.moop,expenseBelow+(1-obj.coverage)*expenseAbove+expenseCopay);  
        end
        function[prem] = annualPremium(obj)
            prem = obj.premium*12;
        end
        function[totalCost] = totalCost(obj)
            totalCost = obj.getCost(obj.billedRange);
        end
        function[h] = plotCost(obj,varargin)
             h = plot(obj.billedRange./1000,obj.totalCost(),varargin{:});
        end
    end
end