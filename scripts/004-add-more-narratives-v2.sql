-- Fixed column names to match actual schema
-- Add more narratives using correct column names from 001-create-tables.sql
-- The correct columns are: name, summary, confidence_score, confidence_trend, decay_half_life_days, last_reinforced_at

-- Japan Monetary Policy Normalization
INSERT INTO narratives (id, name, summary, confidence_score, confidence_trend, decay_half_life_days, last_reinforced_at, created_at, updated_at)
VALUES (
  gen_random_uuid(),
  'Japan Monetary Policy Normalization',
  'Bank of Japan ending decades of ultra-loose monetary policy, with implications for global bond markets and carry trades. Rising Japanese rates could trigger unwinding of yen-funded positions globally.',
  0.72,
  'up',
  45,
  NOW(),
  NOW(),
  NOW()
)
ON CONFLICT DO NOTHING;

-- US Manufacturing Reshoring
INSERT INTO narratives (id, name, summary, confidence_score, confidence_trend, decay_half_life_days, last_reinforced_at, created_at, updated_at)
VALUES (
  gen_random_uuid(),
  'US Manufacturing Reshoring',
  'Supply chain security concerns and government incentives driving manufacturing back to North America. CHIPS Act, IRA, and national security priorities accelerating the trend.',
  0.78,
  'up',
  60,
  NOW(),
  NOW(),
  NOW()
)
ON CONFLICT DO NOTHING;

-- Commercial Real Estate Distress
INSERT INTO narratives (id, name, summary, confidence_score, confidence_trend, decay_half_life_days, last_reinforced_at, created_at, updated_at)
VALUES (
  gen_random_uuid(),
  'Commercial Real Estate Distress',
  'Office and retail property values declining due to remote work shifts and higher interest rates. Regional banks with CRE exposure face potential stress.',
  0.81,
  'flat',
  40,
  NOW(),
  NOW(),
  NOW()
)
ON CONFLICT DO NOTHING;

-- Healthcare AI Revolution
INSERT INTO narratives (id, name, summary, confidence_score, confidence_trend, decay_half_life_days, last_reinforced_at, created_at, updated_at)
VALUES (
  gen_random_uuid(),
  'Healthcare AI Revolution',
  'AI transforming drug discovery, diagnostics, and clinical workflows. FDA approvals accelerating for AI-enabled medical devices and treatments.',
  0.74,
  'up',
  55,
  NOW(),
  NOW(),
  NOW()
)
ON CONFLICT DO NOTHING;

-- Global Defense Spending Surge
INSERT INTO narratives (id, name, summary, confidence_score, confidence_trend, decay_half_life_days, last_reinforced_at, created_at, updated_at)
VALUES (
  gen_random_uuid(),
  'Global Defense Spending Surge',
  'Geopolitical tensions driving NATO and allied nations to increase defense budgets. Focus on modernization, cyber capabilities, and supply chain resilience.',
  0.85,
  'up',
  50,
  NOW(),
  NOW(),
  NOW()
)
ON CONFLICT DO NOTHING;

-- Consumer Credit Deterioration
INSERT INTO narratives (id, name, summary, confidence_score, confidence_trend, decay_half_life_days, last_reinforced_at, created_at, updated_at)
VALUES (
  gen_random_uuid(),
  'Consumer Credit Deterioration',
  'Rising delinquencies in credit cards and auto loans signaling consumer stress. Excess pandemic savings depleted while debt servicing costs increase.',
  0.69,
  'up',
  35,
  NOW(),
  NOW(),
  NOW()
)
ON CONFLICT DO NOTHING;

-- Semiconductor Cycle Recovery
INSERT INTO narratives (id, name, summary, confidence_score, confidence_trend, decay_half_life_days, last_reinforced_at, created_at, updated_at)
VALUES (
  gen_random_uuid(),
  'Semiconductor Cycle Recovery',
  'Memory and logic chip inventory correction ending, with AI demand driving new capacity investments. Leading indicators suggest cyclical upturn beginning.',
  0.76,
  'up',
  45,
  NOW(),
  NOW(),
  NOW()
)
ON CONFLICT DO NOTHING;

-- Private Credit Expansion
INSERT INTO narratives (id, name, summary, confidence_score, confidence_trend, decay_half_life_days, last_reinforced_at, created_at, updated_at)
VALUES (
  gen_random_uuid(),
  'Private Credit Expansion',
  'Banks retreating from middle-market lending creates opportunity for private credit funds. Higher yields attracting institutional capital despite liquidity concerns.',
  0.71,
  'flat',
  50,
  NOW(),
  NOW(),
  NOW()
)
ON CONFLICT DO NOTHING;

-- India Economic Emergence
INSERT INTO narratives (id, name, summary, confidence_score, confidence_trend, decay_half_life_days, last_reinforced_at, created_at, updated_at)
VALUES (
  gen_random_uuid(),
  'India Economic Emergence',
  'India emerging as manufacturing alternative to China with favorable demographics, infrastructure investments, and policy reforms driving sustained growth.',
  0.77,
  'up',
  60,
  NOW(),
  NOW(),
  NOW()
)
ON CONFLICT DO NOTHING;

-- Commodity Supercycle
INSERT INTO narratives (id, name, summary, confidence_score, confidence_trend, decay_half_life_days, last_reinforced_at, created_at, updated_at)
VALUES (
  gen_random_uuid(),
  'Commodity Supercycle',
  'Energy transition metals (copper, lithium, rare earths) facing structural supply deficits. Underinvestment in traditional commodities creating price pressures.',
  0.73,
  'up',
  55,
  NOW(),
  NOW(),
  NOW()
)
ON CONFLICT DO NOTHING;
