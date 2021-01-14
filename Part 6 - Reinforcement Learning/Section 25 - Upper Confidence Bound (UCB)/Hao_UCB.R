# UCB

# Importing the DataSet
dataset = read.csv("Ads_CTR_Optimisation.csv")

# Appling UCB

N = 10000
d = 10
numbers_of_selections = integer(d)
sums_of_selections = integer(d)
ads_selected = integer(0)
total_reward = 0

for (Round in 1:N) {
  max_UCB = 0
  best_ad = 0
  for (ad in 1:d) {
    if (numbers_of_selections[ad] > 0){
      average_reward = sums_of_selections[ad] / numbers_of_selections[ad]
      delta_ad = sqrt(3/2 * log(Round) / numbers_of_selections[ad])
      upper_bound = average_reward + delta_ad
    }
    else{
      upper_bound = 1e400
    }
    if (upper_bound > max_UCB){
      max_UCB = upper_bound
      best_ad = ad
    }
  }
  ads_selected = append(ads_selected, best_ad)
  numbers_of_selections[best_ad] = numbers_of_selections[best_ad] + 1
  reward = dataset[Round,best_ad]
  sums_of_selections[best_ad] = sums_of_selections[best_ad] + reward
  total_reward = total_reward + reward
}

# Visualising the results
hist(ads_selected,
     col = 'blue',
     main = 'Histogram of ads selections',
     xlab = 'Ads',
     ylab = 'Number of times each ad was selected')

