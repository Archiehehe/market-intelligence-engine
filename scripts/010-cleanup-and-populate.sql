-- Comprehensive cleanup and population script
-- This fixes duplicates and ensures proper data relationships

-- Step 1: Remove duplicate narratives (keep the oldest one)
DELETE FROM narratives n1
USING narratives n2
WHERE n1.id > n2.id 
AND n1.name = n2.name;

-- Step 2: Add direction column if it doesn't exist
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'narratives' AND column_name = 'direction'
  ) THEN
    ALTER TABLE narratives ADD COLUMN direction TEXT DEFAULT 'neutral' CHECK (direction IN ('bullish', 'bearish', 'neutral'));
  END IF;
END $$;

-- Step 3: Add tags column if it doesn't exist  
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'narratives' AND column_name = 'tags'
  ) THEN
    ALTER TABLE narratives ADD COLUMN tags TEXT[] DEFAULT ARRAY['Macro'];
  END IF;
END $$;

-- Step 4: Update existing narratives with direction based on confidence trend
UPDATE narratives 
SET direction = CASE 
  WHEN confidence_trend = 'up' THEN 'bullish'
  WHEN confidence_trend = 'down' THEN 'bearish'
  ELSE 'neutral'
END
WHERE direction IS NULL OR direction = 'neutral';

-- Step 5: Clear existing belief edges and add fresh ones
DELETE FROM belief_edges;

-- Step 6: Insert belief edges based on existing narratives
-- AI narratives reinforce each other
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'reinforces', 0.75
FROM narratives n1, narratives n2
WHERE n1.name LIKE '%AI%' 
AND n2.name LIKE '%AI%'
AND n1.id != n2.id
AND n1.id < n2.id
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- Defense narratives reinforce each other
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'reinforces', 0.8
FROM narratives n1, narratives n2
WHERE (n1.name LIKE '%Defense%' OR n1.name LIKE '%defence%')
AND (n2.name LIKE '%Defense%' OR n2.name LIKE '%defence%')
AND n1.id != n2.id
AND n1.id < n2.id
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- India narratives reinforce each other
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'reinforces', 0.7
FROM narratives n1, narratives n2
WHERE n1.name LIKE '%India%' 
AND n2.name LIKE '%India%'
AND n1.id != n2.id
AND n1.id < n2.id
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- Real Estate conflicts with certain growth narratives
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'conflicts', 0.6
FROM narratives n1, narratives n2
WHERE n1.name LIKE '%Real Estate%'
AND (n2.name LIKE '%Growth%' OR n2.name LIKE '%Spending%')
AND n1.id != n2.id
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- Semiconductor depends on AI
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'depends_on', 0.85
FROM narratives n1, narratives n2
WHERE n1.name LIKE '%Semiconductor%'
AND n2.name LIKE '%AI%'
AND n1.id != n2.id
LIMIT 3
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- Manufacturing reshoring reinforces defense
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'reinforces', 0.65
FROM narratives n1, narratives n2
WHERE n1.name LIKE '%Manufacturing%'
AND n2.name LIKE '%Defense%'
AND n1.id != n2.id
LIMIT 2
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- Step 7: Ensure we have some assets
INSERT INTO assets (ticker, name, sector)
VALUES 
  ('NVDA', 'NVIDIA Corporation', 'Technology'),
  ('MSFT', 'Microsoft Corporation', 'Technology'),
  ('GOOGL', 'Alphabet Inc', 'Technology'),
  ('AMD', 'Advanced Micro Devices', 'Technology'),
  ('LMT', 'Lockheed Martin', 'Defense'),
  ('RTX', 'RTX Corporation', 'Defense'),
  ('RELIANCE.NS', 'Reliance Industries', 'Energy'),
  ('INFY', 'Infosys Limited', 'Technology'),
  ('SPG', 'Simon Property Group', 'Real Estate'),
  ('O', 'Realty Income Corp', 'Real Estate'),
  ('TSM', 'Taiwan Semiconductor', 'Technology'),
  ('INTC', 'Intel Corporation', 'Technology')
ON CONFLICT (ticker) DO NOTHING;

-- Step 8: Create asset exposures for narratives
-- AI narratives affect AI stocks
INSERT INTO narrative_asset_exposure (narrative_id, asset_id, exposure_weight)
SELECT n.id, a.id, 0.8
FROM narratives n, assets a
WHERE n.name LIKE '%AI%' 
AND a.ticker IN ('NVDA', 'MSFT', 'GOOGL', 'AMD')
ON CONFLICT (narrative_id, asset_id) DO NOTHING;

-- Defense narratives affect defense stocks
INSERT INTO narrative_asset_exposure (narrative_id, asset_id, exposure_weight)
SELECT n.id, a.id, 0.75
FROM narratives n, assets a
WHERE (n.name LIKE '%Defense%' OR n.name LIKE '%defence%')
AND a.ticker IN ('LMT', 'RTX')
ON CONFLICT (narrative_id, asset_id) DO NOTHING;

-- India narratives affect India stocks
INSERT INTO narrative_asset_exposure (narrative_id, asset_id, exposure_weight)
SELECT n.id, a.id, 0.7
FROM narratives n, assets a
WHERE n.name LIKE '%India%'
AND a.ticker IN ('RELIANCE.NS', 'INFY')
ON CONFLICT (narrative_id, asset_id) DO NOTHING;

-- Real Estate narratives affect REITs
INSERT INTO narrative_asset_exposure (narrative_id, asset_id, exposure_weight)
SELECT n.id, a.id, 0.85
FROM narratives n, assets a
WHERE n.name LIKE '%Real Estate%'
AND a.ticker IN ('SPG', 'O')
ON CONFLICT (narrative_id, asset_id) DO NOTHING;

-- Semiconductor narratives affect chip stocks
INSERT INTO narrative_asset_exposure (narrative_id, asset_id, exposure_weight)
SELECT n.id, a.id, 0.8
FROM narratives n, assets a
WHERE n.name LIKE '%Semiconductor%'
AND a.ticker IN ('TSM', 'INTC', 'NVDA', 'AMD')
ON CONFLICT (narrative_id, asset_id) DO NOTHING;

-- Step 9: Add sample evidence for narratives
INSERT INTO evidence (narrative_id, type, source, description, weight)
SELECT n.id, 'supporting', 'NVIDIA Q4 2024 Earnings', 'Data center revenue up 409% YoY, guidance beat expectations significantly', 0.9
FROM narratives n WHERE n.name LIKE '%AI Capex%' OR n.name LIKE '%AI%' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO evidence (narrative_id, type, source, description, weight)
SELECT n.id, 'supporting', 'Microsoft Azure', 'Cloud AI services revenue growth accelerating, capex guidance raised', 0.85
FROM narratives n WHERE n.name LIKE '%AI Capex%' OR n.name LIKE '%AI%' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO evidence (narrative_id, type, source, description, weight)
SELECT n.id, 'contradicting', 'AMD Guidance', 'AI chip guidance below expectations, suggesting potential demand softness', 0.4
FROM narratives n WHERE n.name LIKE '%AI Capex%' OR n.name LIKE '%AI%' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO evidence (narrative_id, type, source, description, weight)
SELECT n.id, 'supporting', 'NATO Defense Budget', 'NATO members increasing defense spending to 2%+ of GDP target', 0.8
FROM narratives n WHERE n.name LIKE '%Defense%' LIMIT 1
ON CONFLICT DO NOTHING;

INSERT INTO evidence (narrative_id, type, source, description, weight)
SELECT n.id, 'supporting', 'CHIPS Act Implementation', 'Major semiconductor fabs being built in US with government subsidies', 0.75
FROM narratives n WHERE n.name LIKE '%Manufacturing%' OR n.name LIKE '%Semiconductor%' LIMIT 1
ON CONFLICT DO NOTHING;

-- Step 10: Update narratives with proper updated_at timestamps
UPDATE narratives SET updated_at = NOW() - (random() * interval '60 minutes');
