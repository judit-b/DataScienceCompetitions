#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Inspired by https://github.com/mjain72/Hyperparameter-tuning-in-XGBoost-using-genetic-algorithm/blob/master/geneticXGboost.py
"""

from sklearn.metrics import accuracy_score
import numpy as np
import random
import xgboost as xgb
#import matplotlib.pyplot as plt


random.seed(723)
np.random.seed(723)

def initilialize_poplulation(numberOfParents):
    learningRate = np.empty([numberOfParents, 1])
    nEstimators = np.empty([numberOfParents, 1], dtype = np.uint8)
    maxDepth = np.empty([numberOfParents, 1], dtype = np.uint8)
    minChildWeight = np.empty([numberOfParents, 1])
    gammaValue = np.empty([numberOfParents, 1])
    subSample = np.empty([numberOfParents, 1])
    colSampleByTree =  np.empty([numberOfParents, 1])
    scalePosWeight = np.empty([numberOfParents, 1])


    for i in range(numberOfParents):
        print(i)
        learningRate[i] = round(random.uniform(0.01, 1), 2)
        nEstimators[i] = random.randrange(100, 15000, step = 50)
        maxDepth[i] = int(random.randrange(3, 30, step = 1))
        minChildWeight[i] = round(random.uniform(0.01, 10.0), 2)
        gammaValue[i] = round(random.uniform(0.0001, 0.0005), 5)
        subSample[i] = round(random.uniform(0.01, 1.0), 2)
        colSampleByTree[i] = round(random.uniform(0.01, 1.0), 2)
        scalePosWeight[i] = random.randrange(10, 150, step=5)
    
    population = np.concatenate((learningRate, nEstimators, maxDepth, minChildWeight, gammaValue, subSample, \
                                 colSampleByTree, scalePosWeight), axis = 1)
    return population

#create fitness function that will give accuracy_score    

def fitness_score(y_true, y_pred):
    fitness = round((accuracy_score(y_true, y_pred)), 4)
    return fitness

#train the data annd find fitness score
def train_population(population, dMatrixTrain, dMatrixValid, y_valid, dMatrixTest, y_test, gpu):
    fScore = []
    fScore_test = []
    if gpu:
        tm = 'gpu_hist'
    else:
        tm = 'hist'
    for i in range(population.shape[0]):
        param = {'objective'        :'binary:logistic',
                 'learning_rate'    : population[i][0],
                 'n_estimators'     : population[i][1], 
                 'max_depth'        : int(population[i][2]), 
                 'min_child_weight' : population[i][3],
                 'gamma'            : population[i][4], 
                 'subsample'        : population[i][5],
                 'colsample_bytree' : population[i][6],
                 'scale_pos_weight' : population[i][7],
                 'missing'          : np.nan,
                 'random_state'     : 24,
                 'tree_method'      : tm,
                 'n_jobs'           : -1}
        num_round = 100
        xgbT = xgb.train(param, dMatrixTrain, num_round)

        preds_valid = xgbT.predict(dMatrixValid)
        preds_valid = preds_valid>0.5
        fScore.append(fitness_score(y_valid, preds_valid))

        preds_test = xgbT.predict(dMatrixTest)
        preds_test = preds_test>0.5
        fScore_test.append(fitness_score(y_test, preds_test))
    return fScore, fScore_test



#select parents for mating
def new_parents_selection(population, fitness, numParents):
    selectedParents = np.empty((numParents, population.shape[1])) #create an array to store fittest parents
    
    #find the top best performing parents
    for parentId in range(numParents):
        bestFitnessId = np.where(fitness == np.max(fitness))
        bestFitnessId  = bestFitnessId[0][0]
        selectedParents[parentId, :] = population[bestFitnessId, :]
        fitness[bestFitnessId] = -1 #set this value to negative, in case of F1-score, so this parent is not selected again
    return selectedParents
        
'''
Mate these parents to create chilren having parameters from these parents (we are using uniform crossover method)
'''
def crossover_uniform(parents, childrenSize):
    
    crossoverPointIndex = np.arange(0, np.uint8(childrenSize[1]), 1, dtype = np.uint8) #get all the index
    crossoverPointIndex1 = np.random.randint(0, np.uint8(childrenSize[1]), np.uint8(childrenSize[1]/2)) # select half  of the indexes randomly
    crossoverPointIndex2 = np.array(list(set(crossoverPointIndex) - set(crossoverPointIndex1))) #select leftover indexes
    
    children = np.empty(childrenSize)
    
    '''
    Create child by choosing parameters from two paraents selected using new_parent_selection function. The parameter values
    will be picked from the indexes, which were randomly selected above. 
    '''
    for i in range(childrenSize[0]):
        
        #find parent 1 index 
        parent1_index = i%parents.shape[0]
        #find parent 2 index
        parent2_index = (i+1)%parents.shape[0]
        #insert parameters based on random selected indexes in parent 1
        children[i, crossoverPointIndex1] = parents[parent1_index, crossoverPointIndex1]
        #insert parameters based on random selected indexes in parent 1
        children[i, crossoverPointIndex2] = parents[parent2_index, crossoverPointIndex2]
    return children
    
'''
Introduce some mutation in the children. In case of XGboost we will introdcue 
mutation randomly on each parameter one at a time, based on which parameter is 
selected at random. Initially, we will define the maximum/minimum value that is 
allowed for the parameter, to prevent theout the range error during runtime. 
Subsequently, we will generate mutation value and add it to the parameter, and 
return the mutated offspring!!!
'''

def mutation(crossover, numberOfParameters):
    #Define minimum and maximum values allowed for each parameter

    minMaxValue = np.zeros((numberOfParameters, 2))
    
    minMaxValue[0, :] = [0.01, 1.0] #min/max learning rate
    minMaxValue[1, :] = [100, 15000] #min/max n_estimator
    minMaxValue[2, :] = [3, 30] #min/max depth
    minMaxValue[3, :] = [0.01, 10.0] #min/max child_weight
    minMaxValue[4, :] = [0.0001, 0.0005] #min/max gamma
    minMaxValue[5, :] = [0.01, 1.0] #min/max subsample
    minMaxValue[6, :] = [0.01, 1.0] #min/max colsample_bytree
    minMaxValue[7, :] = [10, 150] #min/max scale_pos_weight
 
    # Mutation changes a single gene in each offspring randomly.
    mutationValue = 0
    parameterSelect = np.random.randint(0, 8, 1)
    print(parameterSelect)
    if parameterSelect == 0: #learning_rate
        mutationValue = round(np.random.uniform(-0.5, 0.5), 2)
    if parameterSelect == 1: #n_estimators
        mutationValue = np.random.randint(-200, 200, 1)
    if parameterSelect == 2: #max_depth
        mutationValue = np.random.randint(-5, 5, 1)
    if parameterSelect == 3: #min_child_weight
        mutationValue = round(np.random.uniform(-5, 5), 2)
    if parameterSelect == 4: #gamma
        mutationValue = round(np.random.uniform(-0.0001, 0.0001), 5)
    if parameterSelect == 5: #subsample
        mutationValue = round(np.random.uniform(-0.5, 0.5), 2)
    if parameterSelect == 6: #colsample
        mutationValue = round(np.random.uniform(-0.5, 0.5), 2)
    if parameterSelect == 7: # scale_pos_weight
        mutationValue = round(np.random.uniform(-10, 10), 1)
  
    #indtroduce mutation by changing one parameter, and set to max or min if it goes out of range
    for idx in range(crossover.shape[0]):
        crossover[idx, parameterSelect] = crossover[idx, parameterSelect] + mutationValue
        if(crossover[idx, parameterSelect] > minMaxValue[parameterSelect, 1]):
            crossover[idx, parameterSelect] = minMaxValue[parameterSelect, 1]
        if(crossover[idx, parameterSelect] < minMaxValue[parameterSelect, 0]):
            crossover[idx, parameterSelect] = minMaxValue[parameterSelect, 0]    
    return crossover


'''
This function will allow us to genrate the heatmap for various parameters and 
fitness to visualize  how each parameter and fitness changes with each generation
'''

'''
def plot_parameters(numberOfGenerations, numberOfParents, parameter, parameterName):
    #inspired from https://matplotlib.org/gallery/images_contours_and_fields/image_annotated_heatmap.html
    generationList = ["Gen {}".format(i) for i in range(numberOfGenerations+1)]
    populationList = ["Parent {}".format(i) for i in range(numberOfParents)]
    
    fig, ax = plt.subplots()
    im = ax.imshow(parameter, cmap=plt.get_cmap('YlOrBr'))
    
    # show ticks
    ax.set_xticks(np.arange(len(populationList)))
    ax.set_yticks(np.arange(len(generationList)))
    
    # show labels
    ax.set_xticklabels(populationList)
    ax.set_yticklabels(generationList)
    
    # set ticks at 45 degrees and rotate around anchor
    plt.setp(ax.get_xticklabels(), rotation=45, ha="right",
             rotation_mode="anchor")
    
    
    # insert the value of the parameter in each cell
    for i in range(len(generationList)):
        for j in range(len(populationList)):
            text = ax.text(j, i, parameter[i, j],
                           ha="center", va="center", color="k")
    
    ax.set_title("Change in the value of " + parameterName)
    fig.tight_layout()
    plt.show()
'''