import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parent


def load_database(db_path: str = ':memory:') -> sqlite3.Connection:
    conn = sqlite3.connect(db_path)
    scripts = [
        ROOT / 'CreateTables.sql',
        ROOT / 'InsertData.sql',
        ROOT / 'ProgrammingObjects.sql',
    ]
    for script in scripts:
        if not script.exists():
            raise FileNotFoundError(f'Missing required SQL file: {script.name}')
        conn.executescript(script.read_text(encoding='utf-8'))
    return conn


def test_database_has_expected_tables():
    conn = load_database(':memory:')
    tables = conn.execute(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' ORDER BY name"
    ).fetchall()
    names = {row[0] for row in tables}
    expected = {'Teams', 'Conferences', 'Players', 'Coaches', 'Stadiums', 'Games'}
    assert expected.issubset(names)


def test_seed_data_is_present():
    conn = load_database(':memory:')
    assert conn.execute('SELECT COUNT(*) FROM Teams').fetchone()[0] >= 4
    assert conn.execute('SELECT COUNT(*) FROM Games').fetchone()[0] >= 3
    assert conn.execute('SELECT COUNT(*) FROM Coaches').fetchone()[0] >= 2


def test_team_record_view_works():
    conn = load_database(':memory:')
    row = conn.execute('SELECT COUNT(*) FROM vw_team_records').fetchone()
    assert row[0] >= 4


def test_trigger_updates_records_on_game_insert():
    conn = load_database(':memory:')
    home_team = conn.execute('SELECT team_id FROM Teams WHERE school_name = "West Virginia"').fetchone()[0]
    away_team = conn.execute('SELECT team_id FROM Teams WHERE school_name = "Pittsburgh"').fetchone()[0]
    conn.execute(
        'INSERT INTO Games (game_id, season, week, home_team_id, away_team_id, home_score, away_score, stadium_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        (999, 2026, 1, home_team, away_team, 38, 17, 1),
    )
    conn.commit()
    home_row = conn.execute('SELECT wins, losses FROM Teams WHERE team_id = ?', (home_team,)).fetchone()
    away_row = conn.execute('SELECT wins, losses FROM Teams WHERE team_id = ?', (away_team,)).fetchone()
    assert home_row[0] >= 1
    assert away_row[1] >= 1
