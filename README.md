# Airline Passenger Satisfaction Prediction

Predicting whether airline passengers are satisfied using **factor analysis** and **logistic regression** in R.

## Objective
Airline surveys contain many correlated service ratings (seat comfort, wifi, boarding, cleanliness and so on). This project reduces those ratings into a small number of underlying factors and then uses them, together with passenger and flight details, to predict passenger satisfaction.

## Dataset
Airline passenger satisfaction survey data (`airplane.csv`) with passenger details (gender, customer type, age, type of travel, class), flight delays, numeric service ratings, and a `satisfaction` label (satisfied / neutral or dissatisfied).

Source: [add the link to where you downloaded the dataset]

## Tools
- **Language:** R
- **Libraries:** `readr`, `ggplot2`, `corrplot`, `factoextra`, `FactoMineR`, `psych`, `DescTools`, `pROC`

## Methodology
1. **Data preparation:** converted categorical columns to factors, removed missing values and dropped ID columns.
2. **Scaling:** standardized all numeric variables.
3. **Correlation analysis:** built a correlation matrix and visualized it with `corrplot`.
4. **Suitability tests:** Kaiser-Meyer-Olkin (KMO) measure and Bartlett's test of sphericity to confirm the data suits factor analysis.
5. **Choosing factors:** scree plot of eigenvalues.
6. **Factor analysis:** `factanal()` with varimax rotation; loadings shown with a factor diagram (`fa.diagram`); factor scores extracted by regression.
7. **Logistic regression:** satisfaction modelled using the factor scores plus gender, customer type, age, type of travel, class, departure delay and arrival delay.
8. **Evaluation:** accuracy, confusion matrix and ROC curve with AUC.

## Results
| Metric | Value |
|---|---|
| KMO | XX |
| Number of factors retained | XX |
| Accuracy | XX% |
| ROC-AUC | 0.XX |

**Key findings**
- XX (which factors were most associated with satisfaction)
- XX (effect of delays, class or type of travel)

## Visualizations


![Correlation plot](correlation_plot.png)




![Scree plot](scree_plot.png)




![Factor diagram](factor_diagram.png)




![Confusion matrix](confusion_matrix.png)




![ROC curve](roc_curve.png)



## How to run
1. Install R and RStudio.
2. Install the packages:
   ```r
   install.packages(c("readr", "ggplot2", "corrplot", "factoextra",
                      "FactoMineR", "psych", "DescTools", "pROC"))
   ```
3. Place `airplane.csv` in the project folder and update the file path in the script.
4. Run the script from top to bottom.

## Files
- `airline_satisfaction.R`: full analysis script
- `airplane.csv`: dataset (omit if too large; link the source instead)
- `README.md`: project description

## Author
Sanjana Gupta, M.Sc. Data Science and AI
[GitHub](https://github.com/guptasanjana0911) | [LinkedIn](https://linkedin.com/in/sanjana-gupta)
