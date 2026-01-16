-- Fixed column references and relationship values to match actual schema
-- The narratives table has 'name' not 'title', and 'confidence_trend' not 'direction'
-- Valid relationships are: 'reinforces', 'conflicts', 'depends_on' (not 'supports', 'contradicts')

-- AI and Tech relationships using correct column names
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT 
  n1.id, 
  n2.id, 
  'reinforces',
  0.85
FROM narratives n1, narratives n2
WHERE n1.name ILIKE '%AI%' AND n2.name ILIKE '%tech%' AND n1.id != n2.id
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- Create some conflicting relationships
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT 
  n1.id, 
  n2.id, 
  'conflicts',
  0.7
FROM narratives n1, narratives n2
WHERE n1.name ILIKE '%inflation%' AND n2.name ILIKE '%growth%' AND n1.id != n2.id
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- Fed policy relationships
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT 
  n1.id, 
  n2.id, 
  'depends_on',
  0.9
FROM narratives n1, narratives n2
WHERE n1.name ILIKE '%rate%' AND n2.name ILIKE '%fed%' AND n1.id != n2.id
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- Add generic relationships between all narratives to ensure graph connectivity
-- Uses confidence_trend (the correct column) instead of 'direction'
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT DISTINCT
  n1.id,
  n2.id,
  CASE 
    WHEN n1.confidence_trend = n2.confidence_trend THEN 'reinforces'
    WHEN n1.confidence_trend != n2.confidence_trend AND n1.confidence_trend != 'flat' AND n2.confidence_trend != 'flat' THEN 'conflicts'
    ELSE 'depends_on'
  END,
  0.5 + (random() * 0.4)
FROM narratives n1
CROSS JOIN narratives n2
WHERE n1.id != n2.id
  AND n1.id < n2.id
  AND NOT EXISTS (
    SELECT 1 FROM belief_edges be 
    WHERE (be.from_narrative_id = n1.id AND be.to_narrative_id = n2.id)
       OR (be.from_narrative_id = n2.id AND be.to_narrative_id = n1.id)
  )
LIMIT 20
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- Additional specific relationships for major narratives
-- AI Capex -> Semiconductor Cycle Recovery (reinforces)
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'reinforces', 0.88
FROM narratives n1, narratives n2
WHERE n1.name ILIKE '%AI Capex%' AND n2.name ILIKE '%Semiconductor%'
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- Energy Transition -> Commodity Supercycle (depends_on)
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'depends_on', 0.82
FROM narratives n1, narratives n2
WHERE n1.name ILIKE '%Energy Transition%' AND n2.name ILIKE '%Commodity%'
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- US Soft Landing -> Consumer Credit Deterioration (conflicts)
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'conflicts', 0.75
FROM narratives n1, narratives n2
WHERE n1.name ILIKE '%Soft Landing%' AND n2.name ILIKE '%Consumer Credit%'
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- Japan Monetary Policy -> Dollar Dominance (reinforces)
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'reinforces', 0.65
FROM narratives n1, narratives n2
WHERE n1.name ILIKE '%Japan%' AND n2.name ILIKE '%Dollar%'
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- Commercial Real Estate -> US Soft Landing (conflicts)
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'conflicts', 0.72
FROM narratives n1, narratives n2
WHERE n1.name ILIKE '%Commercial Real Estate%' AND n2.name ILIKE '%Soft Landing%'
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- India Economic Emergence -> China Property Deleveraging (reinforces)
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'reinforces', 0.68
FROM narratives n1, narratives n2
WHERE n1.name ILIKE '%India%' AND n2.name ILIKE '%China Property%'
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- US Manufacturing Reshoring -> Global Defense Spending (depends_on)
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'depends_on', 0.71
FROM narratives n1, narratives n2
WHERE n1.name ILIKE '%Reshoring%' AND n2.name ILIKE '%Defense%'
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- Healthcare AI -> AI Capex (depends_on)
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'depends_on', 0.85
FROM narratives n1, narratives n2
WHERE n1.name ILIKE '%Healthcare AI%' AND n2.name ILIKE '%AI Capex%'
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;

-- Private Credit -> Consumer Credit Deterioration (reinforces)
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT n1.id, n2.id, 'reinforces', 0.62
FROM narratives n1, narratives n2
WHERE n1.name ILIKE '%Private Credit%' AND n2.name ILIKE '%Consumer Credit%'
ON CONFLICT (from_narrative_id, to_narrative_id) DO NOTHING;
