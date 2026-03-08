-- ============================================================
-- UniRate - Supabase Setup Script
-- Run this in the Supabase SQL Editor: https://supabase.com/dashboard
-- Project: gdtgazxqkbqdgiejmfjh
-- ============================================================

-- 1. Create the universities table
CREATE TABLE IF NOT EXISTS universities (
    id            BIGSERIAL PRIMARY KEY,
    name          TEXT NOT NULL,
    location      TEXT,
    country       TEXT,
    city          TEXT,
    rating        NUMERIC(3,1),
    reviews_count INTEGER DEFAULT 0,
    placement_rate INTEGER,
    ranking_label TEXT,
    emoji         TEXT DEFAULT 'graduation',
    programs      TEXT[],
    category      TEXT[],
    description   TEXT,
    tuition       TEXT,
    slug          TEXT UNIQUE,
    created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Enable Row Level Security
ALTER TABLE universities ENABLE ROW LEVEL SECURITY;

-- 3. Public read policy (anyone can read)
CREATE POLICY "Public read access"
    ON universities
    FOR SELECT
    USING (true);

-- 4. Create indexes for fast search
CREATE INDEX IF NOT EXISTS idx_universities_name ON universities USING gin(to_tsvector('english', name));
CREATE INDEX IF NOT EXISTS idx_universities_country ON universities (country);
CREATE INDEX IF NOT EXISTS idx_universities_category ON universities USING gin(category);

-- 5. Insert 20 top international universities
INSERT INTO universities (name, location, country, city, rating, reviews_count, placement_rate, ranking_label, emoji, programs, category, description, tuition, slug) VALUES

('Harvard University',
 'Cambridge, USA', 'USA', 'Cambridge', 5.0, 892, 99, '#1 World',
 'graduation',
 ARRAY['MBA', 'JD', 'MD', 'PhD', 'Executive Education'],
 ARRAY['Business', 'Law', 'Medicine', 'Sciences'],
 'The world''s most prestigious university, offering unmatched academic excellence across disciplines.',
 '$75,000-$80,000/year', 'harvard'),

('Stanford University',
 'Stanford, USA', 'USA', 'Stanford', 5.0, 741, 99, '#2 World',
 'tree',
 ARRAY['MBA', 'MSc Computer Science', 'MSx', 'PhD', 'Design Programs'],
 ARRAY['Business', 'Engineering', 'Technology'],
 'The heart of Silicon Valley - a hub for entrepreneurship, technology and innovation.',
 '$77,000/year', 'stanford'),

('MIT',
 'Cambridge, USA', 'USA', 'Cambridge', 4.9, 654, 99, '#1 Engineering',
 'gear',
 ARRAY['MSc Engineering', 'PhD', 'MBA (Sloan)', 'Computer Science'],
 ARRAY['Engineering', 'Technology', 'Sciences'],
 'The world''s leading engineering and technology university, home to groundbreaking research.',
 '$59,000/year', 'mit'),

('University of Oxford',
 'Oxford, UK', 'UK', 'Oxford', 4.9, 620, 97, '#1 UK',
 'building',
 ARRAY['BA', 'MSc', 'MBA (Said)', 'DPhil', 'MPhil'],
 ARRAY['Business', 'Law', 'Sciences', 'Humanities'],
 'One of the oldest and most prestigious universities in the world, founded in 1096.',
 '30,000-45,000 GBP/year', 'oxford'),

('University of Cambridge',
 'Cambridge, UK', 'UK', 'Cambridge', 4.9, 589, 97, '#2 UK',
 'lion',
 ARRAY['BA', 'MPhil', 'MBA (Judge)', 'PhD'],
 ARRAY['Business', 'Engineering', 'Sciences', 'Humanities'],
 'A world-renowned university with an 800-year history of academic excellence.',
 '32,000-48,000 GBP/year', 'cambridge'),

('London School of Economics',
 'London, UK', 'UK', 'London', 4.7, 412, 95, '#1 Social Sciences',
 'chart',
 ARRAY['BSc Economics', 'MSc Finance', 'MSc Management', 'PhD'],
 ARRAY['Business', 'Economics', 'Law'],
 'The world''s leading social science university, with exceptional economics and finance programs.',
 '25,000-35,000 GBP/year', 'lse'),

('Wharton School - UPenn',
 'Philadelphia, USA', 'USA', 'Philadelphia', 4.9, 521, 98, '#1 Business USA',
 'graph',
 ARRAY['MBA', 'Executive MBA', 'BS Economics', 'PhD'],
 ARRAY['Business', 'Finance', 'Economics'],
 'The world''s first collegiate business school, consistently ranked #1 globally for finance.',
 '$82,000/year', 'wharton'),

('Columbia University',
 'New York, USA', 'USA', 'New York', 4.8, 498, 97, '#3 Ivy League',
 'statue',
 ARRAY['MBA', 'JD', 'MSc', 'BA', 'PhD'],
 ARRAY['Business', 'Law', 'Journalism', 'Sciences'],
 'An Ivy League institution in the heart of New York City, offering unparalleled networking opportunities.',
 '$65,000/year', 'columbia'),

('HEC Paris',
 'Jouy-en-Josas, France', 'France', 'Paris', 4.8, 387, 96, '#1 Europe Business',
 'croissant',
 ARRAY['Grande Ecole', 'MBA', 'Executive MBA', 'MSc'],
 ARRAY['Business', 'Management', 'Finance'],
 'Europe''s top business school, ranked #1 in Europe by the Financial Times multiple times.',
 '40,000-65,000 EUR/year', 'hec-paris'),

('INSEAD',
 'Fontainebleau, France', 'France', 'Fontainebleau', 4.8, 364, 97, '#1 Global MBA',
 'globe',
 ARRAY['MBA', 'Executive MBA', 'GEMBA', 'PhD in Management'],
 ARRAY['Business', 'Management', 'Finance'],
 'The Business School for the World - with campuses in France, Singapore, Abu Dhabi and San Francisco.',
 '92,000 EUR/year', 'insead'),

('Bocconi University',
 'Milan, Italy', 'Italy', 'Milan', 4.8, 892, 98, '#1 Italy',
 'building',
 ARRAY['BSc Economics', 'MSc Finance', 'MSc Marketing', 'MBA', 'Executive MBA'],
 ARRAY['Business', 'Economics', 'Finance'],
 'Italy''s top business and economics university, with an exceptional global network.',
 '14,000-30,000 EUR/year', 'bocconi'),

('LUISS Guido Carli',
 'Rome, Italy', 'Italy', 'Rome', 4.5, 421, 95, '#3 Italy',
 'stadium',
 ARRAY['BA Economics', 'MSc Management', 'MBA', 'Executive MBA', 'LLM'],
 ARRAY['Business', 'Law', 'Economics'],
 'A leading Italian private university with strong corporate connections and modern campus in Rome.',
 '14,000-25,000 EUR/year', 'luiss'),

('Politecnico di Milano',
 'Milan, Italy', 'Italy', 'Milan', 4.7, 623, 96, '#1 Engineering Italy',
 'gear',
 ARRAY['MSc Engineering', 'MSc Architecture', 'MSc Design', 'PhD', 'MBA'],
 ARRAY['Engineering', 'Technology', 'Design'],
 'Italy''s top technical university, globally recognized for engineering, architecture and design.',
 '3,900-13,000 EUR/year', 'polimi'),

('Universita di Bologna',
 'Bologna, Italy', 'Italy', 'Bologna', 4.3, 312, 88, 'Oldest University',
 'books',
 ARRAY['BA', 'MSc', 'LLM', 'MBA', 'PhD'],
 ARRAY['Law', 'Sciences', 'Humanities', 'Medicine'],
 'The world''s oldest university (est. 1088), offering high-quality education at an accessible cost.',
 '1,000-3,500 EUR/year', 'unibo'),

('Fudan University',
 'Shanghai, China', 'China', 'Shanghai', 4.3, 267, 92, '#1 East China',
 'globe-asia',
 ARRAY['IMBA', 'MBA', 'EMBA', 'MSc Finance', 'PhD'],
 ARRAY['Business', 'Sciences', 'Technology'],
 'China''s most prestigious comprehensive university - the gateway to Asian markets.',
 '200,000-300,000 CNY/year', 'fudan'),

('London Business School',
 'London, UK', 'UK', 'London', 4.8, 398, 97, '#2 Europe Business',
 'city',
 ARRAY['MBA', 'Executive MBA', 'MiM', 'MiF', 'PhD'],
 ARRAY['Business', 'Finance', 'Management'],
 'One of the world''s elite business schools in the heart of London''s financial district.',
 '92,000 GBP/year', 'lbs'),

('Yale University',
 'New Haven, USA', 'USA', 'New Haven', 4.8, 456, 97, '#4 Ivy League',
 'bear',
 ARRAY['BA', 'JD', 'MBA (SOM)', 'MD', 'MFA', 'PhD'],
 ARRAY['Law', 'Business', 'Arts', 'Medicine', 'Sciences'],
 'An Ivy League institution renowned for its law school, arts programs and vibrant campus culture.',
 '$62,000/year', 'yale'),

('IE Business School',
 'Madrid, Spain', 'Spain', 'Madrid', 4.6, 289, 93, '#4 Europe Business',
 'sun',
 ARRAY['MBA', 'Executive MBA', 'Master in Management', 'MSc Finance'],
 ARRAY['Business', 'Management', 'Finance'],
 'Spain''s leading business school, known for diversity and entrepreneurial culture.',
 '65,000 EUR/year', 'ie-business'),

('ETH Zurich',
 'Zurich, Switzerland', 'Switzerland', 'Zurich', 4.8, 334, 97, '#1 Europe Engineering',
 'microscope',
 ARRAY['MSc Engineering', 'MSc Computer Science', 'PhD', 'BSc Science'],
 ARRAY['Engineering', 'Technology', 'Sciences'],
 'Europe''s top technical university and one of the world''s leading STEM institutions.',
 'CHF 730/semester', 'eth-zurich'),

('Sciences Po Paris',
 'Paris, France', 'France', 'Paris', 4.5, 241, 92, '#1 Social Sciences EU',
 'tower',
 ARRAY['BA', 'Master in International Affairs', 'MBA', 'Executive Education', 'PhD'],
 ARRAY['Law', 'Economics', 'Humanities', 'Business'],
 'France''s most prestigious school for social sciences, international affairs and public policy.',
 '14,000-22,000 EUR/year', 'sciences-po')

ON CONFLICT (slug) DO NOTHING;

-- Verify the data:
-- SELECT name, country, category, rating FROM universities ORDER BY rating DESC;
