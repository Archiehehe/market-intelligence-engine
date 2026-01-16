-- Add belief edges to populate the belief graph with relationships between narratives
-- This will make the belief graph visualization functional

-- First, get some narrative IDs to work with
-- Note: In production, you would use actual IDs from your narratives

-- Create relationships between narratives
-- Using subqueries to find narratives by name

-- AI narratives support tech sector growth
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT 
  n1.id,
  n2.id,
  'reinforces',
  0.75
FROM narratives n1
CROSS JOIN narratives n2
WHERE n1.name = 'Healthcare AI Revolution'
  AND n2.name = 'Semiconductor Cycle Recovery'
  AND NOT EXISTS (
    SELECT 1 FROM belief_edges 
    WHERE from_narrative_id = n1.id AND to_narrative_id = n2.id
  );

-- Manufacturing reshoring supports semiconductor recovery
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT 
  n1.id,
  n2.id,
  'reinforces',
  0.68
FROM narratives n1
CROSS JOIN narratives n2
WHERE n1.name = 'US Manufacturing Reshoring'
  AND n2.name = 'Semiconductor Cycle Recovery'
  AND NOT EXISTS (
    SELECT 1 FROM belief_edges 
    WHERE from_narrative_id = n1.id AND to_narrative_id = n2.id
  );

-- Defense spending reinforces geopolitical risks
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT 
  n1.id,
  n2.id,
  'reinforces',
  0.82
FROM narratives n1
CROSS JOIN narratives n2
WHERE n1.name = 'Global Defense Spending Surge'
  AND n2.name = 'US Manufacturing Reshoring'
  AND NOT EXISTS (
    SELECT 1 FROM belief_edges 
    WHERE from_narrative_id = n1.id AND to_narrative_id = n2.id
  );

-- Consumer credit stress contradicts economic strength
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT 
  n1.id,
  n2.id,
  'conflicts',
  0.64
FROM narratives n1
CROSS JOIN narratives n2
WHERE n1.name = 'Consumer Credit Deterioration'
  AND n2.name = 'India Economic Emergence'
  AND NOT EXISTS (
    SELECT 1 FROM belief_edges 
    WHERE from_narrative_id = n1.id AND to_narrative_id = n2.id
  );

-- CRE distress depends on Japan policy normalization
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT 
  n1.id,
  n2.id,
  'depends_on',
  0.58
FROM narratives n1
CROSS JOIN narratives n2
WHERE n1.name = 'Commercial Real Estate Distress'
  AND n2.name = 'Japan Monetary Policy Normalization'
  AND NOT EXISTS (
    SELECT 1 FROM belief_edges 
    WHERE from_narrative_id = n1.id AND to_narrative_id = n2.id
  );

-- Commodity supercycle reinforces India emergence
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT 
  n1.id,
  n2.id,
  'reinforces',
  0.71
FROM narratives n1
CROSS JOIN narratives n2
WHERE n1.name = 'Commodity Supercycle'
  AND n2.name = 'India Economic Emergence'
  AND NOT EXISTS (
    SELECT 1 FROM belief_edges 
    WHERE from_narrative_id = n1.id AND to_narrative_id = n2.id
  );

-- Private credit expansion depends on credit deterioration
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT 
  n1.id,
  n2.id,
  'depends_on',
  0.66
FROM narratives n1
CROSS JOIN narratives n2
WHERE n1.name = 'Private Credit Expansion'
  AND n2.name = 'Consumer Credit Deterioration'
  AND NOT EXISTS (
    SELECT 1 FROM belief_edges 
    WHERE from_narrative_id = n1.id AND to_narrative_id = n2.id
  );

-- Healthcare AI supports semiconductor recovery
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT 
  n1.id,
  n2.id,
  'reinforces',
  0.79
FROM narratives n1
CROSS JOIN narratives n2
WHERE n1.name = 'Semiconductor Cycle Recovery'
  AND n2.name = 'Healthcare AI Revolution'
  AND NOT EXISTS (
    SELECT 1 FROM belief_edges 
    WHERE from_narrative_id = n1.id AND to_narrative_id = n2.id
  );

-- Japan policy affects commodity markets
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT 
  n1.id,
  n2.id,
  'conflicts',
  0.55
FROM narratives n1
CROSS JOIN narratives n2
WHERE n1.name = 'Japan Monetary Policy Normalization'
  AND n2.name = 'Commodity Supercycle'
  AND NOT EXISTS (
    SELECT 1 FROM belief_edges 
    WHERE from_narrative_id = n1.id AND to_narrative_id = n2.id
  );

-- Manufacturing reshoring supports defense spending
INSERT INTO belief_edges (from_narrative_id, to_narrative_id, relationship, strength)
SELECT 
  n1.id,
  n2.id,
  'reinforces',
  0.73
FROM narratives n1
CROSS JOIN narratives n2
WHERE n1.name = 'US Manufacturing Reshoring'
  AND n2.name = 'Global Defense Spending Surge'
  AND NOT EXISTS (
    SELECT 1 FROM belief_edges 
    WHERE from_narrative_id = n1.id AND to_narrative_id = n2.id
  );
