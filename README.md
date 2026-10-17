# End-to-End Data Analytics: SQL, Python & Tableau Integration

A complete, production-ready guide and project template demonstrating data analysis workflows—spanning database connection, data querying via SQL, statistical analysis in Python/Jupyter, and interactive business intelligence dashboarding with Tableau.

---

## 📋 Table of Contents
1. [Overview](#overview)
2. [Tech Stack & Tools](#tech-stack--tools)
3. [Project Architecture](#project-architecture)
4. [Prerequisites & Environment Setup](#prerequisites--environment-setup)
5. [Database Connection & SQL Querying](#database-connection--sql-querying)
6. [Exploratory Data Analysis with Python](#exploratory-data-analysis-with-python)
7. [Tableau Visualizations & Dashboards](#tableau-visualizations--dashboards)
8. [Common Troubleshooting](#common-troubleshooting)
9. [License](#license)

---

## 🎯 Overview

This repository demonstrates the fundamental lifecycle of an analytics pipeline:
- **Extraction & Ingestion:** Connect to relational databases (e.g., PostgreSQL, MySQL, SQLite) using Python cursor classes and authenticate with secure credentials.
- **Transformation & Querying:** Formulate SQL queries leveraging key relational commands (`SELECT`, `FROM`, `WHERE`, `GROUP BY`, `JOIN`) to prepare datasets.
- **Exploratory Analysis (EDA):** Process and analyze large datasets inside Jupyter Notebooks.
- **Reporting & Business Intelligence:** Ingest extracted datasets into Tableau Desktop/Public, split fields into **Dimensions** and **Measures**, and construct multi-chart interactive dashboards.

---

## 🛠 Tech Stack & Tools

| Component | Tool / Library | Role |
| :--- | :--- | :--- |
| **Language** | Python 3.10+ | Core scripting and automated data extraction |
| **Interactive Computing** | Jupyter Notebook | Exploratory analysis, iterative querying, and visualization |
| **Database Connector** | `psycopg2` / `mysql-connector-python` / `sqlite3` | Managing database connections, cursor execution, and transactions |
| **Data Manipulation** | `pandas`, `numpy` | In-memory filtering, schema handling, transformations |
| **Visualization & BI** | Tableau Desktop / Public | Dimension & Measure categorization, multi-chart dashboards |
| **Advanced Analytics** | TabPy (Tableau Python Server) | Executing live Python algorithms inside Tableau calculated fields |

---

## 🏗 Project Architecture

```plaintext
data-analytics-pipeline/
│
├── data/
│   ├── raw/                 # Unprocessed flat files (CSV, Excel)
│   └── processed/           # Cleaned data ready for visualization
│
├── notebooks/
│   └── eda_analysis.ipynb   # Jupyter Notebook for statistical exploration
│
├── scripts/
│   ├── db_connection.py     # Python cursor script for database extraction
│   └── data_pipeline.py     # End-to-end extraction and transformation script
│
├── tableau/
│   └── analytics_dashboard.twbx # Tableau packaged workbook
│
├── .gitignore
├── requirements.txt         # Python dependencies
└── README.md
```

---

## ⚙️ Prerequisites & Environment Setup

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/data-analytics-pipeline.git
cd data-analytics-pipeline
```

### 2. Verify Python Installation
Ensure Python is recognized in your terminal/command prompt:
```bash
python --version
# Output should display: Python 3.x.x
```

> **Troubleshooting:** If you encounter:
> ```plaintext
> 'python' is not recognized as an internal or external command
> ```
> Ensure Python is installed and check the box **"Add Python to PATH"** during setup, or manually append your Python installation path to your system's Environment Variables.

### 3. Set Up Virtual Environment & Dependencies
```bash
# Create a virtual environment
python -m venv venv

# Activate the virtual environment
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# Install required packages
pip install -r requirements.txt
```

*Sample `requirements.txt`:*
```text
pandas>=2.0.0
numpy>=1.24.0
matplotlib>=3.7.0
seaborn>=0.12.0
notebook>=7.0.0
mysql-connector-python>=8.0.0
psycopg2-binary>=2.9.0
tabpy>=2.3.0
```

### 4. Launch Jupyter Notebook
To start the interactive computation environment, run:
```bash
jupyter notebook
```
This automatically boots a local web server (usually at `http://localhost:8888/`).

---

## 🗄 Database Connection & SQL Querying

Database connections require three core parameters: **Username**, **Password**, and **Database Name**. Tables are queried downstream using the SQL `FROM` clause.

### Python Database Cursor Example

```python
import os
import psycopg2
import pandas as pd

# Connection credentials
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_NAME = os.getenv("DB_NAME", "analytics_db")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASS = os.getenv("DB_PASS", "secure_password")

try:
    # 1. Establish connection
    connection = psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASS
    )

    # 2. Instantiate cursor
    cursor = connection.cursor()

    # 3. Formulate SQL Query
    query = """
        SELECT 
            customer_id,
            region,
            SUM(sales_amount) AS total_sales,
            COUNT(order_id) AS order_count
        FROM orders
        WHERE order_date >= '2023-01-01'
        GROUP BY customer_id, region
        ORDER BY total_sales DESC;
    """

    # 4. Execute query and fetch records
    cursor.execute(query)
    records = cursor.fetchall()

    # 5. Load into DataFrame
    columns = [desc[0] for desc in cursor.description]
    df = pd.DataFrame(records, columns=columns)

    print(f"Retrieved {len(df)} records successfully.")

except Exception as error:
    print(f"Database connection or query execution failed: {error}")

finally:
    if 'cursor' in locals():
        cursor.close()
    if 'connection' in locals():
        connection.close()
```

---

## 📊 Tableau Visualizations & Dashboards

Tableau provides powerful visual discovery by separating ingestion, structure, and dashboard compilation:

### 1. Data Connection
- Open Tableau Desktop/Public.
- Navigate to the **Connect** pane on the left navigation bar.
- Choose your source: **File Data** (CSV, Excel) or **Server Data** (PostgreSQL, MySQL, Snowflake).

### 2. Dimensions vs. Measures
Tableau splits your schema in the **Data Pane**:
- **Dimensions (Blue Fields):** Qualitative, discrete attributes that set the level of detail (e.g., `Region`, `Product Category`, `Order Date`).
- **Measures (Green Fields):** Quantitative, numerical values that can be aggregated (e.g., `SUM(Sales)`, `AVG(Profit)`, `COUNT(Orders)`).

### 3. Dashboard Compilation
Combine multiple chart types to balance accuracy and visual storytelling:
- **Bar & Line Charts:** For categorical comparisons and temporal trends.
- **Bubble Charts & Treemaps:** For hierarchical and proportional distributions.
- **Geospatial Maps:** For regional performance analysis.

### 4. Optional: Python Scripting via TabPy
To run machine learning models or custom Python logic within Tableau calculated fields:
1. Run TabPy in your terminal:
   ```bash
   tabpy
   ```
2. In Tableau, navigate to **Help > Settings and Performance > Manage External Service Connection**.
3. Point to `localhost` on port `9004`.
4. Use `SCRIPT_REAL()` or `SCRIPT_STR()` functions directly in calculated fields.

---

## ❓ Common Troubleshooting

| Issue / Error | Likely Root Cause | Resolution |
| :--- | :--- | :--- |
| `'python' is not recognized...` | PATH environment variable unset | Re-run Python installer and check **"Add Python to PATH"**. |
| `Authentication failed for user` | Invalid database credentials | Verify the `username`, `password`, and database permissions. |
| `Table does not exist` | Wrong table or schema name in `FROM` clause | Double-check table spelling and schema namespace (e.g., `public.orders`). |
| Tableau cannot connect to database | Firewall / local service closed | Confirm database service is actively listening on target port. |

---

## 📄 License

This repository is distributed under the [MIT License](LICENSE). Feel free to adapt and expand upon this codebase for your projects.