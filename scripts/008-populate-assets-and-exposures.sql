-- Populate assets and narrative asset exposures for proper data display

-- Insert common assets if they don't exist
INSERT INTO assets (ticker, name, sector) VALUES
  ('NVDA', 'NVIDIA Corporation', 'Technology'),
  ('AAPL', 'Apple Inc.', 'Technology'),
  ('MSFT', 'Microsoft Corporation', 'Technology'),
  ('GOOGL', 'Alphabet Inc.', 'Technology'),
  ('AMZN', 'Amazon.com Inc.', 'Consumer Cyclical'),
  ('META', 'Meta Platforms Inc.', 'Technology'),
  ('TSLA', 'Tesla Inc.', 'Consumer Cyclical'),
  ('AMD', 'Advanced Micro Devices', 'Technology'),
  ('AVGO', 'Broadcom Inc.', 'Technology'),
  ('CRM', 'Salesforce Inc.', 'Technology'),
  ('JPM', 'JPMorgan Chase & Co.', 'Financial Services'),
  ('V', 'Visa Inc.', 'Financial Services'),
  ('JNJ', 'Johnson & Johnson', 'Healthcare'),
  ('UNH', 'UnitedHealth Group', 'Healthcare'),
  ('XOM', 'Exxon Mobil Corporation', 'Energy'),
  ('CVX', 'Chevron Corporation', 'Energy'),
  ('PG', 'Procter & Gamble Co.', 'Consumer Defensive'),
  ('KO', 'Coca-Cola Company', 'Consumer Defensive'),
  ('DIS', 'Walt Disney Company', 'Communication Services'),
  ('NFLX', 'Netflix Inc.', 'Communication Services')
ON CONFLICT (ticker) DO NOTHING;

-- Create narrative asset exposures - link assets to relevant narratives
-- AI/Tech narratives get tech stocks
INSERT INTO narrative_asset_exposure (narrative_id, asset_id, exposure_weight)
SELECT n.id, a.id, 0.6 + (random() * 0.3)
FROM narratives n
CROSS JOIN assets a
WHERE (n.name ILIKE '%AI%' OR n.name ILIKE '%tech%' OR n.name ILIKE '%semiconductor%')
  AND a.sector = 'Technology'
  AND NOT EXISTS (
    SELECT 1 FROM narrative_asset_exposure nae 
    WHERE nae.narrative_id = n.id AND nae.asset_id = a.id
  )
ON CONFLICT (narrative_id, asset_id) DO NOTHING;

-- Financial narratives get financial stocks
INSERT INTO narrative_asset_exposure (narrative_id, asset_id, exposure_weight)
SELECT n.id, a.id, 0.5 + (random() * 0.4)
FROM narratives n
CROSS JOIN assets a
WHERE (n.name ILIKE '%rate%' OR n.name ILIKE '%fed%' OR n.name ILIKE '%banking%' OR n.name ILIKE '%inflation%')
  AND a.sector = 'Financial Services'
  AND NOT EXISTS (
    SELECT 1 FROM narrative_asset_exposure nae 
    WHERE nae.narrative_id = n.id AND nae.asset_id = a.id
  )
ON CONFLICT (narrative_id, asset_id) DO NOTHING;

-- Energy narratives get energy stocks
INSERT INTO narrative_asset_exposure (narrative_id, asset_id, exposure_weight)
SELECT n.id, a.id, 0.55 + (random() * 0.35)
FROM narratives n
CROSS JOIN assets a
WHERE (n.name ILIKE '%energy%' OR n.name ILIKE '%oil%' OR n.name ILIKE '%commodity%')
  AND a.sector = 'Energy'
  AND NOT EXISTS (
    SELECT 1 FROM narrative_asset_exposure nae 
    WHERE nae.narrative_id = n.id AND nae.asset_id = a.id
  )
ON CONFLICT (narrative_id, asset_id) DO NOTHING;

-- Consumer narratives get consumer stocks
INSERT INTO narrative_asset_exposure (narrative_id, asset_id, exposure_weight)
SELECT n.id, a.id, 0.5 + (random() * 0.4)
FROM narratives n
CROSS JOIN assets a
WHERE (n.name ILIKE '%consumer%' OR n.name ILIKE '%spending%' OR n.name ILIKE '%retail%')
  AND (a.sector = 'Consumer Cyclical' OR a.sector = 'Consumer Defensive')
  AND NOT EXISTS (
    SELECT 1 FROM narrative_asset_exposure nae 
    WHERE nae.narrative_id = n.id AND nae.asset_id = a.id
  )
ON CONFLICT (narrative_id, asset_id) DO NOTHING;

-- Add some general exposures for narratives that don't have any yet
INSERT INTO narrative_asset_exposure (narrative_id, asset_id, exposure_weight)
SELECT n.id, a.id, 0.4 + (random() * 0.3)
FROM narratives n
CROSS JOIN (SELECT id FROM assets ORDER BY random() LIMIT 3) a
WHERE NOT EXISTS (
    SELECT 1 FROM narrative_asset_exposure nae 
    WHERE nae.narrative_id = n.id
  )
ON CONFLICT (narrative_id, asset_id) DO NOTHING;
