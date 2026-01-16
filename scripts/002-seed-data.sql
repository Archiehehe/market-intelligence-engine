-- Seed initial narratives for testing

-- Insert sample narratives
INSERT INTO narratives (id, name, summary, confidence_score, confidence_trend, decay_half_life_days, last_reinforced_at)
VALUES
  ('11111111-1111-1111-1111-111111111111', 
   'AI Capex Supercycle', 
   'Hyperscalers and enterprises are entering a multi-year infrastructure investment cycle driven by AI workloads. Data center buildout, GPU procurement, and energy infrastructure spending will remain elevated through 2027. This cycle differs from previous tech buildouts in its intensity and breadth across the value chain.',
   0.85, 'up', 45, NOW() - INTERVAL '2 days'),
   
  ('22222222-2222-2222-2222-222222222222', 
   'US Soft Landing', 
   'The Federal Reserve will successfully navigate inflation back to target without triggering a recession. Labor markets remain resilient, consumer spending holds up, and rate cuts begin mid-2026. Credit markets stay orderly throughout the transition.',
   0.62, 'down', 30, NOW() - INTERVAL '7 days'),
   
  ('33333333-3333-3333-3333-333333333333', 
   'Energy Transition Acceleration', 
   'Global decarbonization efforts are accelerating faster than consensus expects. Policy support, declining renewable costs, and grid modernization create sustained demand for clean energy infrastructure. Fossil fuel demand peaks within the decade.',
   0.71, 'flat', 60, NOW() - INTERVAL '4 days'),
   
  ('44444444-4444-4444-4444-444444444444', 
   'China Property Deleveraging', 
   'China''s property sector continues multi-year deleveraging with limited systemic risk. Government intervention prevents disorderly collapse while allowing gradual deflation. Consumer confidence remains subdued but stable.',
   0.55, 'down', 30, NOW() - INTERVAL '10 days'),
   
  ('55555555-5555-5555-5555-555555555555', 
   'Dollar Dominance Erosion', 
   'De-dollarization accelerates as BRICS nations develop alternative payment systems. Central bank gold buying continues at elevated levels. While USD remains dominant, its share of global reserves steadily declines.',
   0.38, 'flat', 90, NOW() - INTERVAL '14 days');

-- Insert assumptions for each narrative
INSERT INTO assumptions (narrative_id, text, fragility_score)
VALUES
  -- AI Capex Supercycle assumptions
  ('11111111-1111-1111-1111-111111111111', 'GPU supply constraints ease sufficiently to meet demand', 0.4),
  ('11111111-1111-1111-1111-111111111111', 'Energy infrastructure can scale to power data centers', 0.6),
  ('11111111-1111-1111-1111-111111111111', 'AI model improvements continue at current pace', 0.5),
  ('11111111-1111-1111-1111-111111111111', 'Enterprise ROI from AI justifies continued spending', 0.45),
  
  -- US Soft Landing assumptions
  ('22222222-2222-2222-2222-222222222222', 'Inflation continues gradual decline without reacceleration', 0.55),
  ('22222222-2222-2222-2222-222222222222', 'Labor market softens without mass layoffs', 0.5),
  ('22222222-2222-2222-2222-222222222222', 'No major credit event or financial stress', 0.65),
  ('22222222-2222-2222-2222-222222222222', 'Fed timing on rate cuts is appropriate', 0.6),
  
  -- Energy Transition assumptions
  ('33333333-3333-3333-3333-333333333333', 'Policy support remains bipartisan and global', 0.7),
  ('33333333-3333-3333-3333-333333333333', 'Grid infrastructure keeps pace with renewable buildout', 0.55),
  ('33333333-3333-3333-3333-333333333333', 'Battery storage costs continue declining', 0.35),
  
  -- China Property assumptions
  ('44444444-4444-4444-4444-444444444444', 'Government maintains policy support without over-stimulating', 0.5),
  ('44444444-4444-4444-4444-444444444444', 'Local government debt remains manageable', 0.65),
  ('44444444-4444-4444-4444-444444444444', 'No major developer defaults trigger contagion', 0.6),
  
  -- Dollar Dominance assumptions
  ('55555555-5555-5555-5555-555555555555', 'BRICS payment alternatives gain meaningful adoption', 0.75),
  ('55555555-5555-5555-5555-555555555555', 'Geopolitical tensions sustain de-dollarization incentives', 0.4),
  ('55555555-5555-5555-5555-555555555555', 'No viable single alternative currency emerges', 0.3);

-- Insert evidence
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
VALUES
  -- AI Capex evidence
  ('11111111-1111-1111-1111-111111111111', 'supporting', 'NVIDIA Q4 Earnings', 'Data center revenue up 409% YoY, guidance beat expectations significantly', 0.9, NOW() - INTERVAL '3 days'),
  ('11111111-1111-1111-1111-111111111111', 'supporting', 'Microsoft Azure', 'Cloud AI services revenue growth accelerating, capex guidance raised', 0.85, NOW() - INTERVAL '5 days'),
  ('11111111-1111-1111-1111-111111111111', 'contradicting', 'AMD Guidance', 'AI chip guidance below expectations, suggesting potential demand softness', 0.4, NOW() - INTERVAL '2 days'),
  
  -- Soft Landing evidence
  ('22222222-2222-2222-2222-222222222222', 'supporting', 'BLS Jobs Report', 'Unemployment remains at 4.1%, wage growth moderating', 0.7, NOW() - INTERVAL '6 days'),
  ('22222222-2222-2222-2222-222222222222', 'contradicting', 'ISM Manufacturing', 'Manufacturing PMI contracted for third consecutive month', 0.55, NOW() - INTERVAL '4 days'),
  ('22222222-2222-2222-2222-222222222222', 'contradicting', 'Consumer Credit', 'Credit card delinquencies rising to 2019 levels', 0.6, NOW() - INTERVAL '8 days'),
  
  -- Energy Transition evidence
  ('33333333-3333-3333-3333-333333333333', 'supporting', 'IEA Report', 'Solar installations exceeded forecasts by 20% globally in 2025', 0.75, NOW() - INTERVAL '10 days'),
  ('33333333-3333-3333-3333-333333333333', 'supporting', 'Tesla Energy', 'Megapack orders backlogged through 2027', 0.65, NOW() - INTERVAL '7 days'),
  
  -- China Property evidence
  ('44444444-4444-4444-4444-444444444444', 'supporting', 'PBOC Policy', 'Additional rate cuts and property support measures announced', 0.6, NOW() - INTERVAL '5 days'),
  ('44444444-4444-4444-4444-444444444444', 'contradicting', 'Evergrande Update', 'Liquidation proceedings accelerating, bondholder recovery minimal', 0.7, NOW() - INTERVAL '3 days'),
  
  -- Dollar Dominance evidence
  ('55555555-5555-5555-5555-555555555555', 'supporting', 'BRICS Summit', 'New payment system pilot launched among member nations', 0.5, NOW() - INTERVAL '20 days'),
  ('55555555-5555-5555-5555-555555555555', 'contradicting', 'IMF Data', 'USD share of global reserves stable at 58%, no meaningful decline', 0.8, NOW() - INTERVAL '15 days');

-- Insert belief edges (relationships between narratives)
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
VALUES
  -- AI Capex <-> Soft Landing
  ('11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'reinforces', 0.6),
  
  -- AI Capex <-> Energy Transition (AI needs power)
  ('11111111-1111-1111-1111-111111111111', '33333333-3333-3333-3333-333333333333', 'depends_on', 0.5),
  
  -- Soft Landing <-> China Property (global stability)
  ('22222222-2222-2222-2222-222222222222', '44444444-4444-4444-4444-444444444444', 'depends_on', 0.4),
  
  -- Dollar Dominance <-> China Property (geopolitical link)
  ('55555555-5555-5555-5555-555555555555', '44444444-4444-4444-4444-444444444444', 'reinforces', 0.35),
  
  -- Energy Transition <-> Dollar Dominance (petrodollar implications)
  ('33333333-3333-3333-3333-333333333333', '55555555-5555-5555-5555-555555555555', 'reinforces', 0.3);

-- Insert sample assets
INSERT INTO assets (id, ticker, name, sector)
VALUES
  ('aaaa1111-1111-1111-1111-111111111111', 'NVDA', 'NVIDIA Corporation', 'Technology'),
  ('aaaa2222-2222-2222-2222-222222222222', 'MSFT', 'Microsoft Corporation', 'Technology'),
  ('aaaa3333-3333-3333-3333-333333333333', 'GOOGL', 'Alphabet Inc', 'Technology'),
  ('aaaa4444-4444-4444-4444-444444444444', 'TSLA', 'Tesla Inc', 'Consumer Discretionary'),
  ('aaaa5555-5555-5555-5555-555555555555', 'ENPH', 'Enphase Energy', 'Energy'),
  ('aaaa6666-6666-6666-6666-666666666666', 'NEE', 'NextEra Energy', 'Utilities'),
  ('aaaa7777-7777-7777-7777-777777777777', 'GLD', 'SPDR Gold Trust', 'Commodities'),
  ('aaaa8888-8888-8888-8888-888888888888', 'TLT', 'iShares 20+ Year Treasury', 'Fixed Income'),
  ('aaaa9999-9999-9999-9999-999999999999', 'FXI', 'iShares China Large-Cap', 'International'),
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'SPY', 'SPDR S&P 500', 'Index');

-- Map assets to narratives
INSERT INTO narrative_asset_exposure (narrative_id, asset_id, exposure_weight)
VALUES
  -- AI Capex exposures
  ('11111111-1111-1111-1111-111111111111', 'aaaa1111-1111-1111-1111-111111111111', 0.95), -- NVDA
  ('11111111-1111-1111-1111-111111111111', 'aaaa2222-2222-2222-2222-222222222222', 0.75), -- MSFT
  ('11111111-1111-1111-1111-111111111111', 'aaaa3333-3333-3333-3333-333333333333', 0.70), -- GOOGL
  
  -- Soft Landing exposures
  ('22222222-2222-2222-2222-222222222222', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 0.80), -- SPY
  ('22222222-2222-2222-2222-222222222222', 'aaaa8888-8888-8888-8888-888888888888', 0.65), -- TLT
  
  -- Energy Transition exposures
  ('33333333-3333-3333-3333-333333333333', 'aaaa4444-4444-4444-4444-444444444444', 0.70), -- TSLA
  ('33333333-3333-3333-3333-333333333333', 'aaaa5555-5555-5555-5555-555555555555', 0.90), -- ENPH
  ('33333333-3333-3333-3333-333333333333', 'aaaa6666-6666-6666-6666-666666666666', 0.75), -- NEE
  
  -- China Property exposures
  ('44444444-4444-4444-4444-444444444444', 'aaaa9999-9999-9999-9999-999999999999', 0.85), -- FXI
  
  -- Dollar Dominance exposures
  ('55555555-5555-5555-5555-555555555555', 'aaaa7777-7777-7777-7777-777777777777', 0.80); -- GLD

-- Create a sample portfolio
INSERT INTO portfolios (id, name)
VALUES ('bbbb1111-1111-1111-1111-111111111111', 'Tech-Heavy Growth');

-- Add holdings to portfolio
INSERT INTO portfolio_holdings (portfolio_id, asset_id, weight)
VALUES
  ('bbbb1111-1111-1111-1111-111111111111', 'aaaa1111-1111-1111-1111-111111111111', 0.25), -- NVDA
  ('bbbb1111-1111-1111-1111-111111111111', 'aaaa2222-2222-2222-2222-222222222222', 0.20), -- MSFT
  ('bbbb1111-1111-1111-1111-111111111111', 'aaaa3333-3333-3333-3333-333333333333', 0.15), -- GOOGL
  ('bbbb1111-1111-1111-1111-111111111111', 'aaaa4444-4444-4444-4444-444444444444', 0.15), -- TSLA
  ('bbbb1111-1111-1111-1111-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 0.15), -- SPY
  ('bbbb1111-1111-1111-1111-111111111111', 'aaaa8888-8888-8888-8888-888888888888', 0.10); -- TLT
