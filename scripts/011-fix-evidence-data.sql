-- Fix evidence data for all narratives
-- This script ensures each narrative has proper supporting and contradicting evidence

-- Step 1: Clear existing evidence to start fresh
DELETE FROM evidence;

-- Step 2: Add evidence for AI-related narratives
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'NVIDIA Q4 2024 Earnings', 'Data center revenue up 409% YoY, guidance beat expectations significantly', 0.9, NOW() - INTERVAL '2 days'
FROM narratives n WHERE n.name ILIKE '%AI Capex%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Microsoft Azure', 'Cloud AI services revenue growth accelerating, capex guidance raised', 0.85, NOW() - INTERVAL '5 days'
FROM narratives n WHERE n.name ILIKE '%AI Capex%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'contradicting', 'AMD Guidance', 'AI chip guidance below expectations, suggesting potential demand softness', 0.4, NOW() - INTERVAL '7 days'
FROM narratives n WHERE n.name ILIKE '%AI Capex%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Google Cloud', 'AI revenue contribution growing 45% quarter over quarter', 0.75, NOW() - INTERVAL '10 days'
FROM narratives n WHERE n.name ILIKE '%AI Capex%' LIMIT 1;

-- Healthcare AI Revolution evidence
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'FDA Approvals', 'Record number of AI-powered medical device approvals in 2024', 0.85, NOW() - INTERVAL '3 days'
FROM narratives n WHERE n.name ILIKE '%Healthcare AI%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Epic Systems', 'Major EHR provider integrating AI across 250+ health systems', 0.8, NOW() - INTERVAL '8 days'
FROM narratives n WHERE n.name ILIKE '%Healthcare AI%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'contradicting', 'Medicare Reimbursement', 'CMS slow to approve AI diagnostic reimbursement codes', 0.5, NOW() - INTERVAL '12 days'
FROM narratives n WHERE n.name ILIKE '%Healthcare AI%' LIMIT 1;

-- Semiconductor narratives
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'TSMC Earnings', 'Advanced node utilization at 100%, expanding capacity for AI chips', 0.9, NOW() - INTERVAL '4 days'
FROM narratives n WHERE n.name ILIKE '%Semiconductor%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Samsung Investment', '$300B chip investment plan through 2030 announced', 0.75, NOW() - INTERVAL '15 days'
FROM narratives n WHERE n.name ILIKE '%Semiconductor%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'contradicting', 'Memory Prices', 'DRAM spot prices declining, suggesting inventory overhang', 0.45, NOW() - INTERVAL '6 days'
FROM narratives n WHERE n.name ILIKE '%Semiconductor%' LIMIT 1;

-- Defense spending narratives
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'NATO Summit', 'NATO members commit to 2.5% GDP defense spending target', 0.85, NOW() - INTERVAL '5 days'
FROM narratives n WHERE n.name ILIKE '%Defense%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'US Defense Budget', 'FY2025 defense budget proposal up 4.5% to $895B', 0.9, NOW() - INTERVAL '20 days'
FROM narratives n WHERE n.name ILIKE '%Defense%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'European Rearmament', 'Germany approves €100B special defense fund', 0.8, NOW() - INTERVAL '30 days'
FROM narratives n WHERE n.name ILIKE '%Defense%' LIMIT 1;

-- India growth narratives
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'IMF Forecast', 'India GDP growth forecast raised to 7.2% for FY2025', 0.85, NOW() - INTERVAL '10 days'
FROM narratives n WHERE n.name ILIKE '%India%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Manufacturing PMI', 'India manufacturing PMI at 58.3, highest in 15 months', 0.75, NOW() - INTERVAL '3 days'
FROM narratives n WHERE n.name ILIKE '%India%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'contradicting', 'Rupee Weakness', 'INR depreciation pressuring import costs and inflation', 0.5, NOW() - INTERVAL '7 days'
FROM narratives n WHERE n.name ILIKE '%India%' LIMIT 1;

-- Commercial Real Estate narratives
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'CBRE Report', 'Office vacancy rates at 20%, highest since 2010', 0.8, NOW() - INTERVAL '14 days'
FROM narratives n WHERE n.name ILIKE '%Real Estate%' OR n.name ILIKE '%Commercial%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Regional Bank Stress', 'CRE loan delinquencies rising at regional banks', 0.75, NOW() - INTERVAL '21 days'
FROM narratives n WHERE n.name ILIKE '%Real Estate%' OR n.name ILIKE '%Commercial%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'contradicting', 'Return to Office', 'Major tech companies mandating 3-day office weeks', 0.4, NOW() - INTERVAL '8 days'
FROM narratives n WHERE n.name ILIKE '%Real Estate%' OR n.name ILIKE '%Commercial%' LIMIT 1;

-- Reshoring/Supply Chain narratives
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'CHIPS Act', 'CHIPS Act funding $52B for domestic semiconductor manufacturing', 0.9, NOW() - INTERVAL '60 days'
FROM narratives n WHERE n.name ILIKE '%Reshoring%' OR n.name ILIKE '%Supply Chain%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Apple Supply Chain', 'Apple diversifying 25% of production outside China by 2025', 0.8, NOW() - INTERVAL '30 days'
FROM narratives n WHERE n.name ILIKE '%Reshoring%' OR n.name ILIKE '%Supply Chain%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'contradicting', 'Labor Costs', 'US manufacturing wages 5x higher than Vietnam, limiting reshoring economics', 0.55, NOW() - INTERVAL '45 days'
FROM narratives n WHERE n.name ILIKE '%Reshoring%' OR n.name ILIKE '%Supply Chain%' LIMIT 1;

-- Energy Transition narratives
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'IRA Impact', 'Clean energy investments up 40% since Inflation Reduction Act', 0.85, NOW() - INTERVAL '25 days'
FROM narratives n WHERE n.name ILIKE '%Energy%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Solar Capacity', 'US solar installations hit record 32GW in 2024', 0.8, NOW() - INTERVAL '15 days'
FROM narratives n WHERE n.name ILIKE '%Energy%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'contradicting', 'Grid Constraints', 'Interconnection queue backlog at 2,000+ GW, limiting deployment', 0.6, NOW() - INTERVAL '20 days'
FROM narratives n WHERE n.name ILIKE '%Energy%' LIMIT 1;

-- Consumer Credit narratives
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Credit Card Delinquencies', 'Credit card 90+ day delinquencies at 10-year high', 0.85, NOW() - INTERVAL '10 days'
FROM narratives n WHERE n.name ILIKE '%Consumer%' OR n.name ILIKE '%Credit%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Auto Loan Stress', 'Subprime auto loan delinquencies exceed 2008 levels', 0.8, NOW() - INTERVAL '18 days'
FROM narratives n WHERE n.name ILIKE '%Consumer%' OR n.name ILIKE '%Credit%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'contradicting', 'Employment Strength', 'Unemployment rate remains at 3.8%, supporting debt servicing', 0.6, NOW() - INTERVAL '5 days'
FROM narratives n WHERE n.name ILIKE '%Consumer%' OR n.name ILIKE '%Credit%' LIMIT 1;

-- Japan monetary policy
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'BOJ Policy Shift', 'Bank of Japan ends negative interest rate policy after 8 years', 0.9, NOW() - INTERVAL '30 days'
FROM narratives n WHERE n.name ILIKE '%Japan%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Yen Carry Trade', 'Yen strengthening as carry trade unwinds', 0.75, NOW() - INTERVAL '14 days'
FROM narratives n WHERE n.name ILIKE '%Japan%' LIMIT 1;

-- China property narratives  
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Evergrande Liquidation', 'Hong Kong court orders Evergrande liquidation', 0.9, NOW() - INTERVAL '35 days'
FROM narratives n WHERE n.name ILIKE '%China%' AND n.name ILIKE '%Property%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Property Sales', 'New home sales down 35% YoY in top 100 cities', 0.85, NOW() - INTERVAL '12 days'
FROM narratives n WHERE n.name ILIKE '%China%' AND n.name ILIKE '%Property%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'contradicting', 'Policy Support', 'PBOC cuts mortgage rates, relaxes purchase restrictions', 0.5, NOW() - INTERVAL '8 days'
FROM narratives n WHERE n.name ILIKE '%China%' AND n.name ILIKE '%Property%' LIMIT 1;

-- US Soft Landing
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'contradicting', 'Yield Curve Inversion', 'Yield curve inversion lasted 624 days, historically precedes recession', 0.7, NOW() - INTERVAL '20 days'
FROM narratives n WHERE n.name ILIKE '%Soft Landing%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'GDP Growth', 'Q4 GDP growth at 3.3% annualized, beating expectations', 0.8, NOW() - INTERVAL '15 days'
FROM narratives n WHERE n.name ILIKE '%Soft Landing%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'contradicting', 'LEI Index', 'Conference Board LEI down for 22nd consecutive month', 0.65, NOW() - INTERVAL '10 days'
FROM narratives n WHERE n.name ILIKE '%Soft Landing%' LIMIT 1;

-- Commodity Supercycle
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Copper Demand', 'EV and grid infrastructure driving copper demand up 25% by 2030', 0.8, NOW() - INTERVAL '25 days'
FROM narratives n WHERE n.name ILIKE '%Commodity%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Mining Underinvestment', 'Mining capex down 40% from 2012 peaks despite demand growth', 0.85, NOW() - INTERVAL '40 days'
FROM narratives n WHERE n.name ILIKE '%Commodity%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'contradicting', 'China Slowdown', 'Chinese industrial production growth slowing, reducing commodity demand', 0.55, NOW() - INTERVAL '12 days'
FROM narratives n WHERE n.name ILIKE '%Commodity%' LIMIT 1;

-- Private Credit
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'AUM Growth', 'Private credit AUM reached $1.7T, up 50% since 2020', 0.85, NOW() - INTERVAL '30 days'
FROM narratives n WHERE n.name ILIKE '%Private Credit%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Bank Retreat', 'Regional banks reducing middle market lending post-SVB', 0.8, NOW() - INTERVAL '60 days'
FROM narratives n WHERE n.name ILIKE '%Private Credit%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'contradicting', 'Covenant Quality', 'Covenant-lite loans at 90% of new issuance, increasing risk', 0.5, NOW() - INTERVAL '20 days'
FROM narratives n WHERE n.name ILIKE '%Private Credit%' LIMIT 1;

-- US Manufacturing Renaissance
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'Factory Construction', 'Manufacturing construction spending up 70% YoY', 0.9, NOW() - INTERVAL '15 days'
FROM narratives n WHERE n.name ILIKE '%Manufacturing%' AND n.name ILIKE '%US%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'supporting', 'IRA Investments', '$200B in clean energy manufacturing announced since IRA', 0.85, NOW() - INTERVAL '45 days'
FROM narratives n WHERE n.name ILIKE '%Manufacturing%' AND n.name ILIKE '%US%' LIMIT 1;

INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
SELECT n.id, 'contradicting', 'Labor Shortage', 'Manufacturing job openings exceed available workers by 600K', 0.6, NOW() - INTERVAL '25 days'
FROM narratives n WHERE n.name ILIKE '%Manufacturing%' AND n.name ILIKE '%US%' LIMIT 1;

-- Step 3: Update timestamps on narratives
UPDATE narratives SET updated_at = NOW() - (random() * INTERVAL '60 minutes');
