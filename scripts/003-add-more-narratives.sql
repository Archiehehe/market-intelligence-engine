-- Add more narratives to expand the narrative universe

-- Insert additional narratives
INSERT INTO narratives (id, name, summary, confidence_score, confidence_trend, decay_half_life_days, last_reinforced_at)
VALUES
  ('66666666-6666-6666-6666-666666666666', 
   'Japan Monetary Normalization', 
   'Bank of Japan gradually exits yield curve control and negative interest rates. The yen strengthens from multi-decade lows as rate differentials narrow. Japanese equities face headwinds from currency appreciation but benefit from corporate governance reforms.',
   0.73, 'up', 30, NOW() - INTERVAL '3 days'),
   
  ('77777777-7777-7777-7777-777777777777', 
   'Reshoring & Supply Chain Diversification', 
   'Companies accelerate manufacturing reshoring to US and nearshoring to Mexico amid geopolitical tensions. Industrial policy support through CHIPS Act and IRA drives domestic capacity buildout. Higher costs partially offset by supply chain resilience benefits.',
   0.68, 'up', 45, NOW() - INTERVAL '5 days'),
   
  ('88888888-8888-8888-8888-888888888888', 
   'Commercial Real Estate Distress', 
   'Office vacancy rates remain elevated as hybrid work becomes permanent. Regional banks face pressure from CRE loan exposure. Distress creates selective opportunities in well-located assets while suburban office faces permanent impairment.',
   0.75, 'flat', 30, NOW() - INTERVAL '6 days'),
   
  ('99999999-9999-9999-9999-999999999999', 
   'Healthcare AI Revolution', 
   'AI accelerates drug discovery, diagnostic imaging, and personalized medicine. Large language models transform clinical documentation and patient engagement. Regulatory frameworks evolve to enable broader AI adoption in healthcare.',
   0.64, 'up', 60, NOW() - INTERVAL '4 days'),
   
  ('aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee', 
   'Defense Spending Supercycle', 
   'NATO rearmament and Indo-Pacific tensions drive sustained defense budget increases globally. Backlog visibility extends to 5+ years for major contractors. Ammunition and missile production ramp creates supply chain bottlenecks.',
   0.82, 'up', 60, NOW() - INTERVAL '2 days'),
   
  ('bbbbbbbb-cccc-dddd-eeee-ffffffffffff', 
   'Consumer Credit Deterioration', 
   'Subprime auto and credit card delinquencies rise to post-GFC highs. Lower-income consumers exhaust pandemic savings. Buy-now-pay-later platforms face rising default rates. Credit tightening creates drag on consumer spending.',
   0.58, 'up', 21, NOW() - INTERVAL '4 days'),
   
  ('cccccccc-dddd-eeee-ffff-111111111111', 
   'Semiconductor Cyclical Recovery', 
   'Memory chip pricing bottoms as inventory destocking completes. PC and smartphone replacement cycles begin after prolonged pause. Auto chip shortage resolves but structural demand for advanced nodes persists.',
   0.69, 'up', 30, NOW() - INTERVAL '8 days'),
   
  ('dddddddd-eeee-ffff-1111-222222222222', 
   'Private Credit Expansion', 
   'Direct lending and private credit AUM continues explosive growth as banks retreat from lending. Higher rates benefit floating-rate portfolios. Concerns about underwriting standards and liquidity in downturn scenarios mount.',
   0.61, 'flat', 45, NOW() - INTERVAL '9 days'),
   
  ('eeeeeeee-ffff-1111-2222-333333333333', 
   'India Structural Growth', 
   'India emerges as fastest growing major economy with demographics, digitization, and manufacturing diversification driving sustained expansion. Infrastructure investment and formalization of economy accelerate. Premium valuations justified by growth visibility.',
   0.77, 'up', 90, NOW() - INTERVAL '5 days'),
   
  ('ffffffff-1111-2222-3333-444444444444', 
   'Commodity Supercycle', 
   'Chronic underinvestment in commodity production meets green transition demand surge. Copper, uranium, and critical minerals face structural deficits. Inflation persistence tied to commodity scarcity.',
   0.52, 'down', 60, NOW() - INTERVAL '12 days');

-- Insert assumptions for new narratives
INSERT INTO assumptions (narrative_id, text, fragility_score)
VALUES
  -- Japan Monetary Normalization
  ('66666666-6666-6666-6666-666666666666', 'BOJ maintains gradual pace of policy normalization', 0.45),
  ('66666666-6666-6666-6666-666666666666', 'Inflation remains sustainably above 2% target', 0.55),
  ('66666666-6666-6666-6666-666666666666', 'Corporate governance reforms continue improving ROE', 0.35),
  
  -- Reshoring
  ('77777777-7777-7777-7777-777777777777', 'Industrial policy support remains bipartisan', 0.5),
  ('77777777-7777-7777-7777-777777777777', 'Labor availability supports manufacturing expansion', 0.65),
  ('77777777-7777-7777-7777-777777777777', 'US-China tensions sustain reshoring incentive', 0.4),
  
  -- CRE Distress
  ('88888888-8888-8888-8888-888888888888', 'Hybrid work patterns stabilize at current levels', 0.35),
  ('88888888-8888-8888-8888-888888888888', 'Regional bank failures remain contained', 0.6),
  ('88888888-8888-8888-8888-888888888888', 'Refinancing wave creates distressed opportunities', 0.45),
  
  -- Healthcare AI
  ('99999999-9999-9999-9999-999999999999', 'FDA accelerates AI medical device approvals', 0.55),
  ('99999999-9999-9999-9999-999999999999', 'Healthcare providers adopt AI despite liability concerns', 0.5),
  ('99999999-9999-9999-9999-999999999999', 'AI models achieve clinical accuracy thresholds', 0.45),
  
  -- Defense Spending
  ('aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee', 'Geopolitical tensions persist through 2027', 0.35),
  ('aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee', 'NATO 2% GDP commitments honored', 0.45),
  ('aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee', 'Supply chain scales to meet demand', 0.55),
  
  -- Consumer Credit
  ('bbbbbbbb-cccc-dddd-eeee-ffffffffffff', 'Lower income consumers continue to deteriorate', 0.4),
  ('bbbbbbbb-cccc-dddd-eeee-ffffffffffff', 'Credit card rates remain elevated', 0.3),
  ('bbbbbbbb-cccc-dddd-eeee-ffffffffffff', 'Charge-offs return to pre-pandemic levels', 0.5),
  
  -- Semiconductor Cycle
  ('cccccccc-dddd-eeee-ffff-111111111111', 'Memory inventory normalization completes', 0.45),
  ('cccccccc-dddd-eeee-ffff-111111111111', 'AI chip demand sustains advanced node utilization', 0.4),
  ('cccccccc-dddd-eeee-ffff-111111111111', 'PC refresh cycle materializes', 0.6),
  
  -- Private Credit
  ('dddddddd-eeee-ffff-1111-222222222222', 'Default rates remain manageable', 0.55),
  ('dddddddd-eeee-ffff-1111-222222222222', 'Institutional capital continues flowing to private credit', 0.4),
  ('dddddddd-eeee-ffff-1111-222222222222', 'No forced selling in downturn scenario', 0.7),
  
  -- India Growth
  ('eeeeeeee-ffff-1111-2222-333333333333', 'Political stability continues', 0.35),
  ('eeeeeeee-ffff-1111-2222-333333333333', 'Infrastructure bottlenecks ease', 0.5),
  ('eeeeeeee-ffff-1111-2222-333333333333', 'Foreign capital flows remain supportive', 0.45),
  
  -- Commodity Supercycle
  ('ffffffff-1111-2222-3333-444444444444', 'Mining capex remains insufficient', 0.55),
  ('ffffffff-1111-2222-3333-444444444444', 'Green transition demand exceeds forecasts', 0.6),
  ('ffffffff-1111-2222-3333-444444444444', 'China demand stabilizes', 0.5);

-- Insert evidence for new narratives
INSERT INTO evidence (narrative_id, type, source, description, weight, timestamp)
VALUES
  -- Japan Normalization
  ('66666666-6666-6666-6666-666666666666', 'supporting', 'BOJ Minutes', 'Board discusses further rate increases if wage growth sustains', 0.75, NOW() - INTERVAL '4 days'),
  ('66666666-6666-6666-6666-666666666666', 'supporting', 'Shunto Negotiations', 'Major unions secure 5%+ wage increases for third consecutive year', 0.8, NOW() - INTERVAL '6 days'),
  
  -- Reshoring
  ('77777777-7777-7777-7777-777777777777', 'supporting', 'TSMC Arizona', 'Second fab construction accelerates, third fab announced', 0.85, NOW() - INTERVAL '3 days'),
  ('77777777-7777-7777-7777-777777777777', 'supporting', 'Census Data', 'Manufacturing construction spending hits record levels', 0.7, NOW() - INTERVAL '7 days'),
  
  -- CRE Distress
  ('88888888-8888-8888-8888-888888888888', 'supporting', 'CBRE Report', 'Office vacancy rate hits 19.6%, highest since 1991', 0.8, NOW() - INTERVAL '5 days'),
  ('88888888-8888-8888-8888-888888888888', 'contradicting', 'Blackstone Deal', 'Major office-to-residential conversions gain traction', 0.45, NOW() - INTERVAL '8 days'),
  
  -- Healthcare AI
  ('99999999-9999-9999-9999-999999999999', 'supporting', 'Nature Medicine', 'AI diagnostic accuracy matches specialists in 12 conditions', 0.75, NOW() - INTERVAL '10 days'),
  ('99999999-9999-9999-9999-999999999999', 'supporting', 'Epic Systems', 'AI scribe feature reaches 50% adoption among clients', 0.65, NOW() - INTERVAL '6 days'),
  
  -- Defense Spending
  ('aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee', 'supporting', 'NATO Summit', 'Alliance reaffirms 2.5% GDP spending target by 2030', 0.85, NOW() - INTERVAL '2 days'),
  ('aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee', 'supporting', 'Lockheed Earnings', 'Backlog reaches $165B, multi-year visibility', 0.8, NOW() - INTERVAL '5 days'),
  
  -- Consumer Credit
  ('bbbbbbbb-cccc-dddd-eeee-ffffffffffff', 'supporting', 'Fed Data', 'Credit card delinquencies reach 3.1%, highest since 2011', 0.75, NOW() - INTERVAL '3 days'),
  ('bbbbbbbb-cccc-dddd-eeee-ffffffffffff', 'contradicting', 'Visa Earnings', 'Payment volumes remain resilient across income cohorts', 0.5, NOW() - INTERVAL '6 days'),
  
  -- Semiconductor Cycle
  ('cccccccc-dddd-eeee-ffff-111111111111', 'supporting', 'Samsung Guidance', 'Memory pricing inflection confirmed, capacity cuts taking effect', 0.7, NOW() - INTERVAL '9 days'),
  ('cccccccc-dddd-eeee-ffff-111111111111', 'supporting', 'IDC Data', 'PC shipments return to growth after 8 quarters of decline', 0.65, NOW() - INTERVAL '7 days'),
  
  -- Private Credit
  ('dddddddd-eeee-ffff-1111-222222222222', 'supporting', 'Apollo AUM', 'Private credit AUM reaches $600B, 40% YoY growth', 0.7, NOW() - INTERVAL '11 days'),
  ('dddddddd-eeee-ffff-1111-222222222222', 'contradicting', 'Moody''s Report', 'Private credit default rates rising, recovery rates uncertain', 0.55, NOW() - INTERVAL '8 days'),
  
  -- India Growth
  ('eeeeeeee-ffff-1111-2222-333333333333', 'supporting', 'IMF Forecast', 'India GDP growth projected at 6.8%, fastest major economy', 0.8, NOW() - INTERVAL '4 days'),
  ('eeeeeeee-ffff-1111-2222-333333333333', 'supporting', 'Apple Supply Chain', 'India iPhone production reaches 15% of global output', 0.7, NOW() - INTERVAL '6 days'),
  
  -- Commodity Supercycle
  ('ffffffff-1111-2222-3333-444444444444', 'supporting', 'IEA Warning', 'Copper supply gap of 8Mt by 2030 without new projects', 0.75, NOW() - INTERVAL '15 days'),
  ('ffffffff-1111-2222-3333-444444444444', 'contradicting', 'China PMI', 'Manufacturing contraction weighs on industrial metals demand', 0.6, NOW() - INTERVAL '10 days');

-- Add new belief edges
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
VALUES
  -- Japan <-> Dollar Dominance
  ('66666666-6666-6666-6666-666666666666', '55555555-5555-5555-5555-555555555555', 'reinforces', 0.4),
  
  -- Reshoring <-> AI Capex (semis)
  ('77777777-7777-7777-7777-777777777777', '11111111-1111-1111-1111-111111111111', 'reinforces', 0.5),
  
  -- CRE <-> Soft Landing (financial stability)
  ('88888888-8888-8888-8888-888888888888', '22222222-2222-2222-2222-222222222222', 'conflicts', 0.55),
  
  -- Healthcare AI <-> AI Capex
  ('99999999-9999-9999-9999-999999999999', '11111111-1111-1111-1111-111111111111', 'depends_on', 0.6),
  
  -- Defense <-> Reshoring
  ('aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee', '77777777-7777-7777-7777-777777777777', 'reinforces', 0.45),
  
  -- Consumer Credit <-> Soft Landing
  ('bbbbbbbb-cccc-dddd-eeee-ffffffffffff', '22222222-2222-2222-2222-222222222222', 'conflicts', 0.65),
  
  -- Semis <-> AI Capex
  ('cccccccc-dddd-eeee-ffff-111111111111', '11111111-1111-1111-1111-111111111111', 'depends_on', 0.7),
  
  -- Private Credit <-> CRE Distress
  ('dddddddd-eeee-ffff-1111-222222222222', '88888888-8888-8888-8888-888888888888', 'reinforces', 0.5),
  
  -- India <-> China Property (manufacturing shift)
  ('eeeeeeee-ffff-1111-2222-333333333333', '44444444-4444-4444-4444-444444444444', 'reinforces', 0.4),
  
  -- Commodities <-> Energy Transition
  ('ffffffff-1111-2222-3333-444444444444', '33333333-3333-3333-3333-333333333333', 'depends_on', 0.65);

-- Add new assets
INSERT INTO assets (id, ticker, name, sector)
VALUES
  ('bbbb1111-2222-3333-4444-555555555555', 'EWJ', 'iShares MSCI Japan', 'International'),
  ('bbbb2222-3333-4444-5555-666666666666', 'CAT', 'Caterpillar Inc', 'Industrials'),
  ('bbbb3333-4444-5555-6666-777777777777', 'VNQ', 'Vanguard Real Estate', 'Real Estate'),
  ('bbbb4444-5555-6666-7777-888888888888', 'ISRG', 'Intuitive Surgical', 'Healthcare'),
  ('bbbb5555-6666-7777-8888-999999999999', 'LMT', 'Lockheed Martin', 'Industrials'),
  ('bbbb6666-7777-8888-9999-aaaaaaaaaaaa', 'AXP', 'American Express', 'Financials'),
  ('bbbb7777-8888-9999-aaaa-bbbbbbbbbbbb', 'MU', 'Micron Technology', 'Technology'),
  ('bbbb8888-9999-aaaa-bbbb-cccccccccccc', 'BX', 'Blackstone Inc', 'Financials'),
  ('bbbb9999-aaaa-bbbb-cccc-dddddddddddd', 'INDA', 'iShares MSCI India', 'International'),
  ('bbbbaaaa-bbbb-cccc-dddd-eeeeeeeeeeee', 'FCX', 'Freeport-McMoRan', 'Materials');

-- Map new assets to narratives
INSERT INTO narrative_asset_exposure (narrative_id, asset_id, exposure_weight)
VALUES
  -- Japan Normalization
  ('66666666-6666-6666-6666-666666666666', 'bbbb1111-2222-3333-4444-555555555555', 0.90),
  
  -- Reshoring
  ('77777777-7777-7777-7777-777777777777', 'bbbb2222-3333-4444-5555-666666666666', 0.75),
  ('77777777-7777-7777-7777-777777777777', 'aaaa1111-1111-1111-1111-111111111111', 0.65),
  
  -- CRE Distress
  ('88888888-8888-8888-8888-888888888888', 'bbbb3333-4444-5555-6666-777777777777', 0.85),
  
  -- Healthcare AI
  ('99999999-9999-9999-9999-999999999999', 'bbbb4444-5555-6666-7777-888888888888', 0.80),
  ('99999999-9999-9999-9999-999999999999', 'aaaa1111-1111-1111-1111-111111111111', 0.55),
  
  -- Defense Spending
  ('aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee', 'bbbb5555-6666-7777-8888-999999999999', 0.90),
  
  -- Consumer Credit
  ('bbbbbbbb-cccc-dddd-eeee-ffffffffffff', 'bbbb6666-7777-8888-9999-aaaaaaaaaaaa', 0.75),
  
  -- Semiconductor Cycle
  ('cccccccc-dddd-eeee-ffff-111111111111', 'bbbb7777-8888-9999-aaaa-bbbbbbbbbbbb', 0.85),
  ('cccccccc-dddd-eeee-ffff-111111111111', 'aaaa1111-1111-1111-1111-111111111111', 0.70),
  
  -- Private Credit
  ('dddddddd-eeee-ffff-1111-222222222222', 'bbbb8888-9999-aaaa-bbbb-cccccccccccc', 0.85),
  
  -- India Growth
  ('eeeeeeee-ffff-1111-2222-333333333333', 'bbbb9999-aaaa-bbbb-cccc-dddddddddddd', 0.90),
  
  -- Commodity Supercycle
  ('ffffffff-1111-2222-3333-444444444444', 'bbbbaaaa-bbbb-cccc-dddd-eeeeeeeeeeee', 0.85),
  ('ffffffff-1111-2222-3333-444444444444', 'aaaa7777-7777-7777-7777-777777777777', 0.60);
