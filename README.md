# pharma_yield_analysis_sql
SQL-based analysis of pharmaceutical manufacturing data to evaluate yield, process efficiency, and operational performance.
# Pharmaceutical Production Yield Analysis (SQL Project)

This project analyzes pharmaceutical manufacturing data to evaluate production yield, identify process inefficiencies, and assess how environmental and operational factors impact performance.

## Dataset Overview
Contains production records including batch IDs, product names, stages, input/output weights, operators, machine IDs, environmental conditions (humidity/temperature), and deviation logs.

## Analysis Performed & Key Insights
- **Yield Performance**: Average yield per stage/product, variability across batches, sub-97% threshold detection
- **Operational Analysis**: Operator and machine consistency, deviation patterns and frequency
- **Environmental Impact**: Humidity effects on yield, monthly/weekly trends
- **Quality Control**: Deviation tracking by stage, operator, and machine

## Business Recommendations
- **Process Inefficiencies**: Certain stages consistently underperform—investigate root causes
- **Quality Risks**: Sub-97% yield batches require closer monitoring
- **Resource Performance**: Specific operators/machines show higher deviation rates—training or maintenance needed
- **Environmental Control**: Higher humidity correlates with lower yield
- **Consistency Gap**: Batch-to-batch variability suggests inconsistent process execution

## Key Takeaways
Production isn't uniform across stages; deviations link to specific operators/machines; data enables efficiency improvements.

## Tools & Next Steps
**Currently using**: SQL  
**Planned**: Power BI/Tableau dashboards, root-cause analysis, predictive modeling

#SQL Analysis
[see SQL queries](pharma_yield_sql_analysis)
