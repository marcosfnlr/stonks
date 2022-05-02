import yfinance as yf
import json
# import pandas as pd

tickers = ['PETR4.SA', 'PETR3.SA', 'VALE3.SA', 'BBAS3.SA', ]

stocks_df = yf.download(tickers,
                        start='2013-01-01',
                        period='1M',
                        ).swaplevel(axis=1)
# stocks_df.to_csv('data/data.csv')
stocks_df.index = stocks_df.index.strftime('%Y-%m-%d')

output = {}
for t in tickers:
    output[t] = stocks_df[t].to_dict()

with open("data/data.json", "w") as outfile:
    json.dump(output, outfile, indent=2)
