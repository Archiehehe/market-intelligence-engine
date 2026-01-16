-- Narrative-Centric Market Intelligence System
-- Core Database Schema

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- NARRATIVES TABLE (Core Object)
-- ============================================
CREATE TABLE narratives (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  summary TEXT NOT NULL,
  confidence_score DECIMAL(5,4) NOT NULL DEFAULT 0.5 CHECK (confidence_score >= 0 AND confidence_score <= 1),
  confidence_trend TEXT NOT NULL DEFAULT 'flat' CHECK (confidence_trend IN ('up', 'down', 'flat')),
  decay_half_life_days INTEGER NOT NULL DEFAULT 30,
  last_reinforced_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================
-- ASSUMPTIONS TABLE
-- ============================================
CREATE TABLE assumptions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  narrative_id UUID NOT NULL REFERENCES narratives(id) ON DELETE CASCADE,
  text TEXT NOT NULL,
  fragility_score DECIMAL(5,4) NOT NULL DEFAULT 0.5 CHECK (fragility_score >= 0 AND fragility_score <= 1),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_assumptions_narrative ON assumptions(narrative_id);

-- ============================================
-- EVIDENCE TABLE
-- ============================================
CREATE TABLE evidence (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  narrative_id UUID NOT NULL REFERENCES narratives(id) ON DELETE CASCADE,
  type TEXT NOT NULL CHECK (type IN ('supporting', 'contradicting')),
  source TEXT NOT NULL,
  description TEXT NOT NULL,
  weight DECIMAL(5,4) NOT NULL DEFAULT 0.5 CHECK (weight >= 0 AND weight <= 1),
  timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_evidence_narrative ON evidence(narrative_id);
CREATE INDEX idx_evidence_type ON evidence(type);

-- ============================================
-- BELIEF EDGES (Graph Relationships)
-- ============================================
CREATE TABLE belief_edges (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  from_narrative_id UUID NOT NULL REFERENCES narratives(id) ON DELETE CASCADE,
  to_narrative_id UUID NOT NULL REFERENCES narratives(id) ON DELETE CASCADE,
  relationship TEXT NOT NULL CHECK (relationship IN ('reinforces', 'conflicts', 'depends_on')),
  strength DECIMAL(5,4) NOT NULL DEFAULT 0.5 CHECK (strength >= 0 AND strength <= 1),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(from_narrative_id, to_narrative_id)
);

CREATE INDEX idx_belief_edges_from ON belief_edges(from_narrative_id);
CREATE INDEX idx_belief_edges_to ON belief_edges(to_narrative_id);

-- ============================================
-- ASSETS TABLE
-- ============================================
CREATE TABLE assets (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  ticker TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  sector TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_assets_ticker ON assets(ticker);

-- ============================================
-- NARRATIVE-ASSET EXPOSURE MAPPING
-- ============================================
CREATE TABLE narrative_asset_exposure (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  narrative_id UUID NOT NULL REFERENCES narratives(id) ON DELETE CASCADE,
  asset_id UUID NOT NULL REFERENCES assets(id) ON DELETE CASCADE,
  exposure_weight DECIMAL(5,4) NOT NULL DEFAULT 0.5 CHECK (exposure_weight >= 0 AND exposure_weight <= 1),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(narrative_id, asset_id)
);

CREATE INDEX idx_nae_narrative ON narrative_asset_exposure(narrative_id);
CREATE INDEX idx_nae_asset ON narrative_asset_exposure(asset_id);

-- ============================================
-- NARRATIVE EVENTS (Event Sourcing)
-- ============================================
CREATE TABLE narrative_events (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  narrative_id UUID NOT NULL REFERENCES narratives(id) ON DELETE CASCADE,
  event_type TEXT NOT NULL CHECK (event_type IN (
    'created', 'evidence_added', 'contradiction_added', 
    'reinforced', 'decayed', 'linked', 'summary_updated'
  )),
  payload JSONB NOT NULL DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_events_narrative ON narrative_events(narrative_id);
CREATE INDEX idx_events_type ON narrative_events(event_type);
CREATE INDEX idx_events_created ON narrative_events(created_at DESC);

-- ============================================
-- NARRATIVE HISTORY (Snapshots)
-- ============================================
CREATE TABLE narrative_history (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  narrative_id UUID NOT NULL REFERENCES narratives(id) ON DELETE CASCADE,
  confidence_score DECIMAL(5,4) NOT NULL,
  summary_snapshot TEXT NOT NULL,
  recorded_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_history_narrative ON narrative_history(narrative_id);
CREATE INDEX idx_history_recorded ON narrative_history(recorded_at DESC);

-- ============================================
-- PORTFOLIOS TABLE
-- ============================================
CREATE TABLE portfolios (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL DEFAULT 'My Portfolio',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================
-- PORTFOLIO HOLDINGS
-- ============================================
CREATE TABLE portfolio_holdings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  portfolio_id UUID NOT NULL REFERENCES portfolios(id) ON DELETE CASCADE,
  asset_id UUID NOT NULL REFERENCES assets(id) ON DELETE CASCADE,
  weight DECIMAL(5,4) NOT NULL CHECK (weight >= 0 AND weight <= 1),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(portfolio_id, asset_id)
);

CREATE INDEX idx_holdings_portfolio ON portfolio_holdings(portfolio_id);
CREATE INDEX idx_holdings_asset ON portfolio_holdings(asset_id);

-- ============================================
-- PORTFOLIO SNAPSHOTS (For Drift Detection)
-- ============================================
CREATE TABLE portfolio_snapshots (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  portfolio_id UUID NOT NULL REFERENCES portfolios(id) ON DELETE CASCADE,
  narrative_exposures JSONB NOT NULL DEFAULT '[]',
  total_fragility DECIMAL(5,4) NOT NULL DEFAULT 0,
  recorded_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_snapshots_portfolio ON portfolio_snapshots(portfolio_id);
CREATE INDEX idx_snapshots_recorded ON portfolio_snapshots(recorded_at DESC);

-- ============================================
-- FUNCTION: Update timestamps
-- ============================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_narratives_updated_at
  BEFORE UPDATE ON narratives
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_portfolios_updated_at
  BEFORE UPDATE ON portfolios
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
