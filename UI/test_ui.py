"""UI smoke tests for the project output.
These verify that the SQL scripts can be compiled into a small in-memory database
and that the core reporting view is usable for simple app logic.
"""

import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parent


def build_example_db() -> sqlite3.Connection:
    conn = sqlite3.connect(':memory:')
    for name in ['CreateTables.sql', 'InsertData.sql', 'ProgrammingObjects.sql']:
        path = ROOT / name
        if not path.exists():
            raise FileNotFoundError(path)
        conn.executescript(path.read_text(encoding='utf-8'))
    return conn


def test_ui_can_load_data():
    conn = build_example_db()
    teams = conn.execute('SELECT school_name, conference_id FROM Teams ORDER BY school_name').fetchall()
    assert len(teams) >= 4


def test_ui_can_query_reporting_view():
    conn = build_example_db()
    rows = conn.execute('SELECT school_name, wins, losses FROM vw_team_records ORDER BY wins DESC, losses ASC').fetchall()
    assert len(rows) >= 4
