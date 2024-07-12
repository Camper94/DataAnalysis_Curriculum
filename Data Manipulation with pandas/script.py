#Script_Name : script.py
#Description : Data Manipulation with Pandas
#Author : Sofiane Boumelit
#Date : June 30, 2024

#Inspecting a DataFrame
'''
When you get a new DataFrame to work with, 
the first thing you need to do is explore it and see what it contains. 
There are several useful methods and attributes for this.

    .head() returns the first few rows (the “head” of the DataFrame).
    .info() shows information on each of the columns, 
    such as the data type and number of missing values.
    .shape returns the number of rows and columns of the DataFrame.
    .describe() calculates a few summary statistics for each column.

homelessness is a DataFrame containing estimates of homelessness in each U.S. 
state in 2018. The individual column is the number of homeless individuals 
not part of a family with children. 
The family_members column is the number of homeless individuals part 
of a family with children. 
The state_pop column is the state's total population.

pandas is imported for you.
'''
# Print the head of the homelessness data
print(homelessness.head())

# Print information about homelessness
print(homelessness.info())

# Print the shape of homelessness
print(homelessness.shape)

# Print a description of homelessness
print(homelessness.describe())

#Parts if a DataFrame

'''
To better understand DataFrame objects, 
it's useful to know that they consist of three components, 
stored as attributes:

    .values: A two-dimensional NumPy array of values.
    .columns: An index of columns: the column names.
    .index: An index for the rows: either row numbers or row names.

You can usually think of indexes as a list of strings or numbers, though the pandas Index data type allows for more sophisticated options. (These will be covered later in the course.)

homelessness is available.
'''
# Import pandas using the alias pd
import pandas as pd

# Print the values of homelessness
print(homelessness.values)

# Print the column index of homelessness
print(homelessness.columns)

# Print the row index of homelessness
print(homelessness.index)

#Sorting rows
'''
Finding interesting bits of data in a DataFrame is often easier 
if you change the order of the rows. 
You can sort the rows by passing a column name to .sort_values().

In cases where rows have the same value 
(this is common if you sort on a categorical variable), 
you may wish to break the ties by sorting on another column. 
You can sort on multiple columns in this way by passing a list of column names.
Sort on … 	Syntax
one column 	df.sort_values("breed")
multiple columns 	df.sort_values(["breed", "weight_kg"])

By combining .sort_values() with .head(), you can answer questions in the form, 
"What are the top cases where…?".
homelessness is available and pandas is loaded as pd.
'''
# Sort homelessness by individuals
homelessness_ind = homelessness.sort_values("individuals")
# Print the top few rows
print(homelessness_ind.head())

# Sort homelessness by descending family members
homelessness_fam = homelessness.sort_values("family_members", ascending=False)
# Print the top few rows
print(homelessness_fam.head())

# Sort homelessness by region, then descending family members
homelessness_reg_fam = homelessness.sort_values(["region","family_members"], ascending=[True,False])
# Print the top few rows
print(homelessness_reg_fam.head())

#Subsetting columns

'''
When working with data, you may not need all of the variables in your dataset.
Square brackets ([]) can be used to select only the columns that matter 
to you in an order that makes sense to you. 
To select only "col_a" of the DataFrame df, use

df["col_a"]

To select "col_a" and "col_b" of df, use

df[["col_a", "col_b"]]

homelessness is available and pandas is loaded as pd.
'''
# Select the individuals column
individuals = homelessness["individuals"]
# Print the head of the result
print(individuals.head())

# Select the state and family_members columns
state_fam = homelessness[["state","family_members"]]
# Print the head of the result
print(state_fam.head())

# Select only the individuals and state columns, in that order
ind_state = homelessness[['individuals','state']]
# Print the head of the result
print(ind_state.head())

#Subsetting rows
'''
A large part of data science is about finding which bits of your 
dataset are interesting. 
One of the simplest techniques for this is to find a subset of rows 
that match some criteria. This is sometimes known as filtering rows 
or selecting rows.
There are many ways to subset a DataFrame, perhaps the most common is 
to use relational operators to return True or False for each row, 
then pass that inside square brackets.
dogs[dogs["height_cm"] > 60]
dogs[dogs["color"] == "tan"]
You can filter for multiple conditions at once by using 
the "bitwise and" operator, &.
dogs[(dogs["height_cm"] > 60) & (dogs["color"] == "tan")]
homelessness is available and pandas is loaded as pd.
'''

# Filter for rows where individuals is greater than 10000
ind_gt_10k = homelessness[(homelessness["individuals"] > 10000)]
# See the result
print(ind_gt_10k)

# Filter for rows where region is Mountain
mountain_reg = homelessness[(homelessness["region"]== "Mountain")]
# See the result
print(mountain_reg)

# Filter for rows where family_members is less than 1000 
# and region is Pacific
fam_lt_1k_pac = homelessness[(homelessness["family_members"] < 1000) & (homelessness["region"]== "Pacific")]
# See the result
print(fam_lt_1k_pac)

#Subsetting rows by categorical variables
'''
Subsetting data based on a categorical variable often involves using 
the "or" operator (|) to select rows from multiple categories. 
This can get tedious when you want all states in one of three different regions,
for example. Instead, use the .isin() method, 
which will allow you to tackle this problem by writing one 
condition instead of three separate ones.

colors = ["brown", "black", "tan"]
condition = dogs["color"].isin(colors)
dogs[condition]

homelessness is available and pandas is loaded as pd.
'''
# Subset for rows in South Atlantic or Mid-Atlantic regions
south_mid_atlantic = homelessness[(homelessness["region"]=="South Atlantic")|(homelessness["region"]=="Mid-Atlantic")]
# See the result
print(south_mid_atlantic)

# The Mojave Desert states
canu = ["California", "Arizona", "Nevada", "Utah"]
# Filter for rows in the Mojave Desert states
mojave_homelessness = homelessness[homelessness["state"].isin(canu)]
# See the result
print(mojave_homelessness)

#Adding new columns
'''
You aren't stuck with just the data you are given. 
Instead, you can add new columns to a DataFrame. 
This has many names, such as transforming, mutating, and feature engineering.

You can create new columns from scratch, 
but it is also common to derive them from other columns, 
for example, by adding columns together or by changing their units.

homelessness is available and pandas is loaded as pd.
'''
# Add total col as sum of individuals and family_members
homelessness["total"]= homelessness["individuals"]+homelessness["family_members"]

# Add p_individuals col as proportion of total that are individuals
homelessness["p_individuals"] = homelessness["individuals"]/homelessness["total"]
# See the result
print(homelessness)

#Combo-attack!
'''
You've seen the four most common types of data manipulation: 
sorting rows, subsetting columns, subsetting rows, 
and adding new columns. In a real-life data analysis, 
you can mix and match these four manipulations to answer a multitude 
of questions.
In this exercise, you'll answer the question, 
"Which state has the highest number of homeless individuals per 10,000 people 
in the state?" Combine your new pandas skills to find out.
'''

# Create indiv_per_10k col as homeless individuals per 10k state pop
homelessness["indiv_per_10k"] = 10000 * homelessness["individuals"] / homelessness["state_pop"] 
# Subset rows for indiv_per_10k greater than 20
high_homelessness = homelessness[(homelessness["indiv_per_10k"]>20)]
# Sort high_homelessness by descending indiv_per_10k
high_homelessness_srt = high_homelessness.sort_values("indiv_per_10k",ascending = False)
# From high_homelessness_srt, select the state and indiv_per_10k cols
result = high_homelessness_srt[["state","indiv_per_10k"]]
# See the result
print(result)

#Mean and Median
'''
Summary statistics are exactly what they sound like - 
they summarize many numbers in one statistic. 
For example, mean, median, minimum, maximum, and standard deviation are summary statistics.
Calculating summary statistics allows you to get a better sense of your data, 
even if there's a lot of it.
sales is available and pandas is loaded as pd.
'''

# Print the head of the sales DataFrame
print(sales.head())
# Print the info about the sales DataFrame
print(sales.info())
# Print the mean of weekly_sales
print(sales["weekly_sales"].mean())
# Print the median of weekly_sales
print(sales["weekly_sales"].median())

#Summarizing dates
'''
Summary statistics can also be calculated on date columns that have values with the data
type datetime64. Some summary statistics — like mean — don't make a ton of sense on dates, 
but others are super helpful, for example, minimum and maximum, 
which allow you to see what time range your data covers.
sales is available and pandas is loaded as pd.
'''

# Print the maximum of the date column
print(sales["date"].max())
# Print the minimum of the date column
print(sales["date"].min())

#efficient summaries
'''
While pandas and NumPy have tons of functions, sometimes, 
you may need a different function to summarize your data.

The .agg() method allows you to apply your own custom functions to a DataFrame, 
as well as apply functions to more than one column of a DataFrame at once, 
making your aggregations super-efficient. For example,

df['column'].agg(function)
In the custom function for this exercise, "IQR" is short for inter-quartile range, 
which is the 75th percentile minus the 25th percentile. 
It's an alternative to standard deviation that is helpful if your data contains outliers.

sales is available and pandas is loaded as pd.
'''
# Import NumPy and create custom IQR function
import numpy as np
def iqr(column):
    return column.quantile(0.75) - column.quantile(0.25)

# Update to print IQR and median of temperature_c, fuel_price_usd_per_l, & unemployment
print(sales[["temperature_c", "fuel_price_usd_per_l", "unemployment"]].agg([iqr, np.median]))

#cumulative statistics
'''
Cumulative statistics can also be helpful in tracking summary statistics over time.
In this exercise, you'll calculate the cumulative sum and cumulative max of a department's weekly sales, 
which will allow you to identify what the total sales were so far as well as what the highest weekly 
sales were so far.

A DataFrame called sales_1_1 has been created for you, 
which contains the sales data for department 1 of store 1. pandas is loaded as pd.
'''

# Sort sales_1_1 by date
sales_1_1 = sales_1_1.sort_values("date",ascending = True)

# Get the cumulative sum of weekly_sales, add as cum_weekly_sales col
sales_1_1["cum_weekly_sales"] = sales_1_1["weekly_sales"].cumsum()

# Get the cumulative max of weekly_sales, add as cum_max_sales col
sales_1_1["cum_max_sales"] = sales_1_1["weekly_sales"].cummax()

# See the columns you calculated
print(sales_1_1[["date", "weekly_sales", "cum_weekly_sales", "cum_max_sales"]])

#dropping duplicates
'''
Removing duplicates is an essential skill to get accurate counts because often, 
you don't want to count the same thing multiple times. 
In this exercise, you'll create some new DataFrames using unique values from sales.

sales is available and pandas is imported as pd.
'''
# Drop duplicate store/type combinations
store_types = sales.drop_duplicates(subset=["store","type"])
print(store_types.head())
# Drop duplicate store/department combinations
store_depts = sales.drop_duplicates(subset=["store","department"])
print(store_depts.head())
# Subset the rows where is_holiday is True and drop duplicate dates
holiday_dates = sales[sales["is_holiday"]].drop_duplicates("date")
# Print date col of holiday_dates
print(holiday_dates)

#counting categorical variables
'''
Counting is a great way to get an overview of your data and to spot curiosities that 
you might not notice otherwise. 
In this exercise, you'll count the number of each type of store and the number of each 
department number using the DataFrames you created in the previous exercise:

# Drop duplicate store/type combinations
store_types = sales.drop_duplicates(subset=["store", "type"])

# Drop duplicate store/department combinations
store_depts = sales.drop_duplicates(subset=["store", "department"])
The store_types and store_depts DataFrames you created in the last exercise are available, 
and pandas is imported as pd.
'''
# Count the number of stores of each type
store_counts = store_types["type"].value_counts()
print(store_counts)
# Get the proportion of stores of each type
store_props = store_types["type"].value_counts(normalize=True)
print(store_props)
# Count the number of each department number and sort
dept_counts_sorted = store_depts["department"].value_counts(sort=True)
print(dept_counts_sorted)
# Get the proportion of departments of each number and sort
dept_props_sorted = store_depts["department"].value_counts(sort=True, normalize=True)
print(dept_props_sorted)

#what percent of sales occured at each store type ?
'''
While .groupby() is useful, you can calculate grouped summary statistics without it.
Walmart distinguishes three types of stores: "supercenters," "discount stores," and "neighborhood markets," 
encoded in this dataset as type "A," "B," and "C." In this exercise, you'll calculate 
the total sales made at each store type, without using .groupby(). 
You can then use these numbers to see what proportion of Walmart's total sales were made at each type.
sales is available and pandas is imported as pd.
'''
# Calc total weekly sales
sales_all = sales["weekly_sales"].sum()
# Subset for type A stores, calc total weekly sales
sales_A = sales[sales["type"] == "A"]["weekly_sales"].sum()
# Subset for type B stores, calc total weekly sales
sales_B = sales[sales["type"] == "B"]["weekly_sales"].sum()
# Subset for type C stores, calc total weekly sales
sales_C = sales[sales["type"] == "C"]["weekly_sales"].sum()
# Get proportion for each type
sales_propn_by_type = [sales_A, sales_B, sales_C] / sales_all
print(sales_propn_by_type)


#Calculations with .groupby()
'''
The .groupby() method makes life much easier. 
In this exercise, you'll perform the same calculations as last time, 
except you'll use the .groupby() method. 
You'll also perform calculations on data grouped by two variables to see if sales differ 
by store type depending on if it's a holiday week or not.

sales is available and pandas is loaded as pd.
'''

# Group by type; calc total weekly sales
sales_by_type = sales.groupby("type")["weekly_sales"].sum()
# Get proportion for each type
sales_propn_by_type = sales_by_type / sum(sales_by_type)
print(sales_propn_by_type)

# From previous step
sales_by_type = sales.groupby("type")["weekly_sales"].sum()
# Group by type and is_holiday; calc total weekly sales
sales_by_type_is_holiday = sales.groupby(["type","is_holiday"])["weekly_sales"].sum()
print(sales_by_type_is_holiday)

#Multiple grouped summaries
'''
Earlier in this chapter, 
you saw that the .agg() method is useful to compute multiple statistics on multiple variables. 
It also works with grouped data. NumPy, which is imported as np, 
has many different summary statistics functions, including: np.min, np.max, np.mean, and np.median.
sales is available and pandas is imported as pd.
'''

# Import numpy with the alias np
import numpy as np
# For each store type, aggregate weekly_sales: get min, max, mean, and median
sales_stats = sales.groupby("type")["weekly_sales"].agg([min,max,np.mean,np.median])
# Print sales_stats
print(sales_stats)
# For each store type, aggregate unemployment and fuel_price_usd_per_l: get min, max, mean, and median
unemp_fuel_stats = sales.groupby("type")[["unemployment","fuel_price_usd_per_l"]].agg([min,max,np.mean,np.median])
# Print unemp_fuel_stats
print(unemp_fuel_stats)

