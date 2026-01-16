-- Add sample portfolio data for the portfolio section

-- Create a default portfolio
INSERT INTO portfolios (id, name) 
VALUES ('00000000-0000-0000-0000-000000000001', 'My Portfolio')
ON CONFLICT DO NOTHING;

-- Add portfolio holdings using existing assets
INSERT INTO portfolio_holdings (portfolio_id, asset_id, weight)
SELECT 
  '00000000-0000-0000-0000-000000000001',
  a.id,
  CASE 
    WHEN a.ticker = 'NVDA' THEN 0.15
    WHEN a.ticker = 'AAPL' THEN 0.12
    WHEN a.ticker = 'MSFT' THEN 0.10
    WHEN a.ticker = 'GOOGL' THEN 0.08
    WHEN a.ticker = 'AMZN' THEN 0.08
    WHEN a.ticker = 'META' THEN 0.07
    WHEN a.ticker = 'JPM' THEN 0.06
    WHEN a.ticker = 'V' THEN 0.05
    WHEN a.ticker = 'JNJ' THEN 0.05
    WHEN a.ticker = 'XOM' THEN 0.04
    ELSE 0.02
  END
FROM assets a
WHERE a.ticker IN ('NVDA', 'AAPL', 'MSFT', 'GOOGL', 'AMZN', 'META', 'JPM', 'V', 'JNJ', 'XOM', 'TSLA', 'AMD', 'UNH', 'CVX', 'PG')
ON CONFLICT (portfolio_id, asset_id) DO UPDATE SET weight = EXCLUDED.weight;
