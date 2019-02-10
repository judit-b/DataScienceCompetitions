#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Inspired by https://github.com/mjain72/Hyperparameter-tuning-in-XGBoost-using-genetic-algorithm/blob/master/xgboost_genetic.py
"""

'''
We will use genetic algorithum to optimize hyperparameters for XGboost. 
'''

DATA_DIRECTORY = '/data/test_data/'
DATA_FILENAME = DATA_DIRECTORY + 'full_df_for_xgboost_190206.p'  
VALID_SIZE = 0.15
TEST_SIZE = 0.15
USE_GPU = True        # set to False to use cpu

# Importing the libraries
import numpy as np
import pandas as pd
import geneticXGBoost #genetic algorithum module
import xgboost as xgb
import pickle
import time

start = time.time()

np.random.seed(723)
'''
The dataset should be customized.
'''

# Importing the dataset
data = pickle.load(open(DATA_FILENAME, 'rb'))  # pandas dataframe
df = data.iloc[:, 2:]
X = df.drop(['target'], axis = 1)
y = df.target.copy()

# Splitting the dataset into the training set, validation set and test set
from sklearn.model_selection import train_test_split
X_train, X_validtest, y_train, y_validtest = train_test_split(X, y, test_size = VALID_SIZE + TEST_SIZE, random_state = 1, \
                                                          stratify = X[['feature_1', 'feature_2', 'feature_3', 'is_outlier']])
X_valid, X_localtest, y_valid, y_localtest = train_test_split(X_validtest, y_validtest, 
                                                              test_size = (TEST_SIZE / (VALID_SIZE + TEST_SIZE)), \
                                                              random_state = 1, \
                                                              stratify = X_validtest[['feature_1', 'feature_2', 'feature_3', \
                                                              'is_outlier']])

y_train_label = X_train.is_outlier.copy()
X_train.drop('is_outlier', axis = 1, inplace = True)
y_valid_label = X_valid.is_outlier.copy()
X_valid.drop('is_outlier', axis = 1, inplace = True)
y_localtest_label = X_localtest.is_outlier.copy()
X_localtest.drop('is_outlier', axis = 1, inplace = True)

# Feature Scaling
#from sklearn.preprocessing import StandardScaler
#sc = StandardScaler()
#X_train = sc.fit_transform(X_train)
#X_valid = sc.transform(X_valid)
#X_localtest = sc.transform(X_localtest)
train_nanmean = np.nanmean(X_train, axis=0)
train_nanstd = np.nanstd(X_train, axis=0) + 1e-10
X_train = (X_train - train_nanmean) / train_nanstd
X_valid = (X_valid - train_nanmean) / train_nanstd
X_localtest = (X_localtest - train_nanmean) / train_nanstd

#XGboost Classifier

#model xgboost
#use xgboost API now
xgDMatrix = xgb.DMatrix(X_train, y_train_label) #create Dmatrix
xgbDMatrixValid = xgb.DMatrix(X_valid, y_valid_label)
xgbDMatrixTest = xgb.DMatrix(X_localtest, y_localtest_label)


'''
Let's find optimized parameters using genetic algorithms
'''

numberOfParents = 64 #number of parents to start
numberOfParentsMating = 32 #number of parents that will mate
numberOfParameters = 8 #number of parameters that will be optimized
numberOfGenerations = 32 #number of genration that will be created

#define the population size

populationSize = (numberOfParents, numberOfParameters)

#initialize the population with randomly generated parameters
population = geneticXGBoost.initilialize_poplulation(numberOfParents)

#define an array to store the fitness  hitory
fitnessHistory = np.empty([numberOfGenerations+1, numberOfParents])

#define an array to store the value of each parameter for each parent and generation
populationHistory = np.empty([(numberOfGenerations+1)*numberOfParents, numberOfParameters])

#insert the value of initial parameters to history
populationHistory[0:numberOfParents, :] = population

for generation in range(numberOfGenerations):
    print("This is number %s generation" % (generation))
    
    #train the dataset and obtain fitness
    fitnessValue, _ = geneticXGBoost.train_population(population=population, dMatrixTrain=xgDMatrix, \
                                                      dMatrixValid=xgbDMatrixValid, y_valid=y_valid_label, \
                                                      dMatrixTest=xgbDMatrixTest, y_test=y_localtest_label, \
                                                      gpu=USE_GPU)
    fitnessHistory[generation, :] = fitnessValue
    
    #best score in the current iteration
    print('Best score in this iteration = {}'.format(np.max(fitnessHistory[generation, :])))

    #survival of the fittest - take the top parents, based on the fitness value and number of parents needed to be selected
    parents = geneticXGBoost.new_parents_selection(population=population, fitness=fitnessValue, \
                                                   numParents=numberOfParentsMating)
    
    #mate these parents to create children having parameters from these parents (we are using uniform crossover)
    children = geneticXGBoost.crossover_uniform(parents=parents, \
                                                childrenSize=(populationSize[0] - parents.shape[0], numberOfParameters))
    
    #add mutation to create genetic diversity
    children_mutated = geneticXGBoost.mutation(children, numberOfParameters)
    
    '''
    We will create new population, which will contain parents that where selected previously based on the
    fitness score and rest of them  will be children
    '''
    population[0:parents.shape[0], :] = parents #fittest parents
    population[parents.shape[0]:, :] = children_mutated #children
    
    populationHistory[(generation+1)*numberOfParents : \
                      (generation+1)*numberOfParents+ numberOfParents , :] = population #srore parent information
    

#Best solution from the final iteration

fitness, fitness_test = geneticXGBoost.train_population(population=population, dMatrixTrain=xgDMatrix, \
                                                        dMatrixValid=xgbDMatrixValid, y_valid=y_valid_label, \
                                                        dMatrixTest=xgbDMatrixTest, y_test=y_localtest_label, \
                                                        gpu=USE_GPU)

fitnessHistory[generation+1, :] = fitness

#index of the best solution
bestFitnessIndex = np.where(fitness == np.max(fitness))[0][0]

#Best fitness
print("Best validation fitness is =", fitness[bestFitnessIndex])
print("Test fitness of algorithm with best validation fitness =", fitness_test[bestFitnessIndex])

#Best parameters
print("Best parameters are:")
print('learning_rate', population[bestFitnessIndex][0])
print('n_estimators', population[bestFitnessIndex][1])
print('max_depth', int(population[bestFitnessIndex][2])) 
print('min_child_weight', population[bestFitnessIndex][3])
print('gamma', population[bestFitnessIndex][4])
print('subsample', population[bestFitnessIndex][5])
print('colsample_bytree', population[bestFitnessIndex][6])
print('scale_pos_weight', population[bestFitnessIndex][7])


#visualize the change in fitness of the various generations and parents

'''
geneticXGBoost.plot_parameters(numberOfGenerations, numberOfParents, fitnessHistory, "fitness (accuracy-score)")
'''
#Look at individual parameters change with generation
#Create array for each parameter history (Genration x Parents)

learnigRateHistory = populationHistory[:, 0].reshape([numberOfGenerations+1, numberOfParents])
nEstimatorHistory = populationHistory[:, 1].reshape([numberOfGenerations+1, numberOfParents])
maxdepthHistory = populationHistory[:, 2].reshape([numberOfGenerations+1, numberOfParents])
minChildWeightHistory = populationHistory[:, 3].reshape([numberOfGenerations+1, numberOfParents])
gammaHistory = populationHistory[:, 4].reshape([numberOfGenerations+1, numberOfParents])
subsampleHistory = populationHistory[:, 5].reshape([numberOfGenerations+1, numberOfParents])
colsampleByTreeHistory = populationHistory[:, 6].reshape([numberOfGenerations+1, numberOfParents])
scalePosWeightHistory = populationHistory[:, 7].reshape([numberOfGenerations+1, numberOfParents])

#generate heatmap for each parameter
'''
geneticXGBoost.plot_parameters(numberOfGenerations, numberOfParents, learnigRateHistory, "learning rate")
geneticXGBoost.plot_parameters(numberOfGenerations, numberOfParents, nEstimatorHistory, "n_estimator")
geneticXGBoost.plot_parameters(numberOfGenerations, numberOfParents, maxdepthHistory, "maximum depth")
geneticXGBoost.plot_parameters(numberOfGenerations, numberOfParents, minChildWeightHistory, "minimum child weight")
geneticXGBoost.plot_parameters(numberOfGenerations, numberOfParents, gammaHistory, "gamma")
geneticXGBoost.plot_parameters(numberOfGenerations, numberOfParents, subsampleHistory, "subsample")
geneticXGBoost.plot_parameters(numberOfGenerations, numberOfParents, colsampleByTreeHistory, "col sample by history")
geneticXGBoost.plot_parameters(numberOfGenerations, numberOfParents, scalePosWeight, "scale_pos_weight")
'''

pickle.dump((fitnessHistory, populationHistory, fitness_test[bestFitnessIndex], population[bestFitnessIndex]), \
            open(DATA_DIRECTORY + 'xgboost_output_190206.p', 'wb'))

end = time.time()
print('Elapsed time: %.3fs' % (end-start))  

'''
Output with GPU:
Best validation fitness is = 0.9892
Test fitness of algorithm with best validation fitness = 0.989
Best parameters are:
learning_rate 0.14
n_estimators 100.0
max_depth 26
min_child_weight 0.01
gamma 0.00037999999999999997
subsample 0.87
colsample_bytree 0.15
scale_pos_weight 16.0
Elapsed time: 117238.816s
'''