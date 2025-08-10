-- schema.sql
-- D1 Database Schema for Artist Portfolio

-- Enable foreign key constraints
PRAGMA foreign_keys = ON;

-- Subscribers table
CREATE TABLE IF NOT EXISTS subscribers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT NOT NULL,
  type TEXT NOT NULL DEFAULT 'art-updates',
  confirmation_token TEXT,
  token_expires_at TEXT,
  confirmed INTEGER NOT NULL DEFAULT 0,
  confirmed_at TEXT,
  created_at TEXT NOT NULL
);

-- Add index for faster lookups
CREATE INDEX IF NOT EXISTS idx_subscribers_email_type ON subscribers(email, type);
CREATE INDEX IF NOT EXISTS idx_subscribers_token ON subscribers(confirmation_token);
CREATE INDEX IF NOT EXISTS idx_subscribers_confirmed ON subscribers(confirmed);
