# -*-coding: UTF-8

import sys
sys.path.insert(0, "/Users/gaoyingqiang/Desktop/大学/Master/Guided-Research/nlp-Yingqiang/data_utils")
import json
import codecs
import math
import numpy as np 
import utils
#from data_utils.utils import load_data, load_embedding, binary_mask_generator, binary_mask_generator, mask_generator
import tensorflow as tf 
import os 
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
import matplotlib.pyplot as plt
# this model focus on aspect- based sentiment analysis. For aspect term (i.e. the attributes of entities show up in sentence) sentiment analysis, predict the position and the polarity of aspect term. For aspect category (i.e. the classification of aspect attributes, which may not show up in sentence) sentiment analysis , predict the category and polarity.

# input (feature engineering): GloVe embeddings, universal sentence embeddings, binary mask
# output: position of aspect, polarity of aspect

import json
import codecs
import math
import numpy as np 
import utils
import tensorflow as tf

################################################################################

# initialize model parameter

batch_size = 128
decay = 0.85
max_epoch = 5
max_max_epoch = 10
vocab_size = 5000 # 数据中不同的词的个数，处理数据的时候可以用训练Glove的那个函数数一下
embedding_size = 50
num_sentiment_label = 3 # postive, negative, neutral
fc_hidden_size = 256
lstm_hidden_size = 256 #lstm中前馈网络隐含层节点数,lstm输出为256维，可以自己指定
TRAINING_ITERATIONS = 100
num_lstm_layer = 1 # LSTM cell的纵向堆叠厚度,图上只有一层
max_grad_norm = 5.0 # 最大梯度，超过此值的梯度将被裁剪
LEARNING_RATE = 0.1
WEIGHT_DECAY = 0.0005
negative_weight = 2.0
positive_weight = 1.0
neutral_weight = 3.0
label_dict = {'positive':2, 'neutral':1, 'negative':0}

data_dir = '/home/gaoyingqiang/Desktop/nlp-Yingqiang/nlp-Yingqiang/convert'
embedding_dir = '/home/gaoyingqiang/Desktop/nlp-Yingqiang/nlp-Yingqiang/glove/glove.6B/glove.6B.50d.txt'



################################################################################

# functions for constructing model
# manually set flags here
def set_flag():
    flag_domain = 'Restaurant' # Organic, Restaurant etc. use flag_train_or_test=='test' for Organic dataset since Restaurant test data and organic data has the same format
    flag_train = False
    flag_test = True
    flag_uni_sent_embedding = True
    flag_aspect = 'category'# term or category
    return flag_domain, flag_train, flag_test, flag_uni_sent_embedding, flag_aspect

def fcin_weight_init():
    initial_weight = tf.Variable(tf.truncated_normal([embedding_size, fc_hidden_size], stddev=1.0/math.sqrt(embedding_size)))
    return initial_weight

def fcin_bias_init():
    initial_bias = tf.Variable(tf.zeros(fc_hidden_size))
    return initial_bias

def fcout_weight_init():
    initial_weight = tf.Variable(tf.truncated_normal([lstm_hidden_size, num_sentiment_label], stddev=1.0/math.sqrt(2*lstm_hidden_size)))
    return initial_weight

def fcout_bias_init():
    initial_bias = tf.Variable(tf.zeros(num_sentiment_label))
    return initial_bias

# number of lstm cells == max_sent_len
def bi_lstm():
    # one layer of lstm cells
    lstm_fw_cell = tf.nn.rnn_cell.BasicLSTMCell(lstm_hidden_size, forget_bias=1.0)
    lstm_bw_cell = tf.nn.rnn_cell.BasicLSTMCell(lstm_hidden_size, forget_bias=1.0)
    lstm_fw_multicell = tf.nn.rnn_cell.MultiRNNCell([lstm_fw_cell]*num_lstm_layer)
    lstm_bw_multicell = tf.nn.rnn_cell.MultiRNNCell([lstm_bw_cell]*num_lstm_layer)
    return lstm_fw_multicell, lstm_bw_multicell

def softmax_classifier_init(inputsize, outputsize):
    weights1 = tf.Variable(tf.random_normal([inputsize, 2*inputsize]))
    bias1 = tf.Variable(tf.zeros([2*inputsize])+0.1)
    weights2 = tf.Variable(tf.random_normal([2*inputsize, outputsize]))
    bias2 = tf.Variable(tf.zeros([outputsize])+0.1)

    return weights1, weights2, bias1, bias2

################################################################################

# prepare data and labels
flag_domain, flag_train, flag_test, flag_uni_sent_embedding, flag_aspect = set_flag()

# load word embeddings
word_dict, word_embedding = utils.load_embedding(embedding_dir)

if(flag_domain=='Restaurant'):
    # set path for universal sentence embedding
    universal_dir = '/home/gaoyingqiang/Desktop/nlp-Yingqiang/nlp-Yingqiang/universal_sentence_encoder/SemEval16_Restaurant/'

    # compute max. sentence length
    train_max_sent_len = utils.compute_max_sent_length(data_dir + '/SemEval16_Restaurant_Train.json', flag_train_or_test='train')
    
    # read training data
    train_data_sentence, train_data_target, train_data_category, train_data_polarity  = utils.load_data(data_dir + "/SemEval16_Restaurant_Train.json",flag_train_or_test='train', flag_aspect='train')

    # process training target label, mark the target with 1
    train_target_label = utils.label_generator(train_data_sentence, train_data_target)
    # process training polarity label
    train_polarity_label = utils.polarity_label_generator(train_data_polarity)
    train_category_label,num_category = utils.category_label_generator(train_data_category)

    # compute mask for training data
    train_binary_mask = utils.binary_mask_generator(data_dir + '/SemEval16_Restaurant_Train.json',flag_train_or_test='train')
    train_mask = utils.mask_generator(data_dir,flag_domain='Restaurant',flag_train_or_test='train')

    # compute number of training sample
    num_sample_train = len(train_data_sentence)

    # read test data and process label _, correct_prediction_target, accuracy_polarity,cost_train, polarity_labels
    if(flag_aspect=='term'):
        test_data_sentence, test_data_target, test_data_polarity  = utils.load_data(data_dir + "/SemEval16_Restaurant_Test_term.json", flag_train_or_test='test', flag_aspect='term')
        # compute maximal sentence length
        test_max_sent_len = utils.compute_max_sent_length(data_dir + '/SemEval16_Restaurant_Test_term.json', flag_train_or_test='test')
        # process test target label
        test_target_label = utils.label_generator(test_data_sentence, test_data_target)
        test_polarity_label = utils.polarity_label_generator(test_data_polarity)
        # process mask features
        test_binary_mask = utils.binary_mask_generator(data_dir + '/SemEval16_Restaurant_Test_term.json', flag_train_or_test='test')
        test_mask = utils.mask_generator(data_dir, flag_domain='Restaurant',flag_train_or_test='test')
    if(flag_aspect=='category'):
        test_data_sentence, test_data_category, test_data_polarity = utils.load_data(data_dir + "/SemEval16_Restaurant_Test_category.json",flag_train_or_test='test', flag_aspect='category')
        # compute maximal sentence length
        test_max_sent_len = utils.compute_max_sent_length(data_dir + '/SemEval16_Restaurant_Test_category.json', flag_train_or_test='test')
        # process test category label
        test_category_label, num_category = utils.category_label_generator(test_data_category)
        test_polarity_label = utils.polarity_label_generator(test_data_polarity)
        test_binary_mask = utils.binary_mask_generator(data_dir + '/SemEval16_Restaurant_Test_category.json', flag_train_or_test='test')
        test_mask = utils.mask_generator(data_dir, flag_domain='Restaurant',flag_train_or_test='test')
    
    if(flag_uni_sent_embedding and flag_domain=='Restaurant'):
        # load universal sentence embedding
        if(flag_train):
            uni_dict, uni_embedding = utils.load_embedding(universal_dir+'Train/uni_sent_embedding_compressed.txt')
            uni_embedding = uni_embedding[1:len(uni_embedding)]
        elif(flag_test):
            uni_dict, uni_embedding = utils.load_embedding(universal_dir+'Test/uni_sent_embedding_compressed.txt')
            uni_embedding = uni_embedding[1:len(uni_embedding)]
    
################################################################################

# Modeling
#graph = tf.Graph()

# high version of pylint may report a false positive here
with tf.device('/device:GPU:0'):
    if(flag_domain=='Restaurant'):
        if(flag_train):
            tf_X = tf.placeholder(tf.float32, shape=[None, train_max_sent_len, embedding_size],name='tf_X')
            tf_X_mask = tf.placeholder(tf.float32, shape=[None, train_max_sent_len],name='tf_X_mask')
            tf_X_binary_mask = tf.placeholder(tf.float32, shape=[None, train_max_sent_len],name='tf_X_binary_mask')
            tf_y_polarity = tf.placeholder(tf.int64, shape=[None, 1],name='tf_y_polarity')
            keep_prob = tf.placeholder(tf.float32)
            if(flag_aspect=='term'):
                tf_y_target = tf.placeholder(tf.int64, shape=[None, train_max_sent_len], name='tf_y_target')
            if(flag_aspect=='category'):
                tf_y_category = tf.placeholder(tf.int64, shape=[None, 1],name='tf_y_category')
            if(flag_uni_sent_embedding):
                tf_universal_X = tf.placeholder(tf.float32, shape=[None, train_max_sent_len],name='tf_universal_X')
        if(flag_test):
            tf_X = tf.placeholder(tf.float32, shape=[None, test_max_sent_len, embedding_size],name='tf_X')
            tf_X_mask = tf.placeholder(tf.float32, shape=[None, test_max_sent_len],name='tf_X_mask')
            tf_X_binary_mask = tf.placeholder(tf.float32, shape=[None, test_max_sent_len],name='tf_X_binary_mask')
            tf_y_polarity = tf.placeholder(tf.int64, shape=[None, 1],name='tf_y_polarity')
            keep_prob = tf.placeholder(tf.float32)
            if(flag_aspect=='term'):
                tf_y_target = tf.placeholder(tf.int64, shape=[None, test_max_sent_len],name='tf_y_target')
            if(flag_aspect=='category'):
                tf_y_category = tf.placeholder(tf.int64, shape=[None, 1],name='tf_y_category')
            if(flag_uni_sent_embedding):
                tf_universal_X = tf.placeholder(tf.float32, shape=[None, test_max_sent_len],name='tf_universal_X')
            

    #initialize fc input layer
    fcin_w = fcin_weight_init()
    fcin_b = fcin_bias_init()

    # initialize fc output layer
    fcout_w = fcout_weight_init()
    fcout_b = fcout_bias_init()


    # get labels
    if(flag_aspect=='term'):
        y_target_labels = tf.one_hot(tf_y_target, num_sentiment_label, on_value=1.0, off_value=0.0, axis=-1)
    if(flag_aspect=='category'):
        y_category_labels = tf.one_hot(tf_y_category, num_category, on_value=1.0, off_value=0.0, axis=-1)

    y_polarity_labels = tf.one_hot(tf_y_polarity, num_sentiment_label, on_value=1.0, off_value=0.0,axis=-1)
    
    
    # process input 
    X = tf.transpose(tf_X, [1, 0, 2])
    # reshaping to [batch_size*sentence_length, embedding_size]
    X = tf.reshape(X, [-1, embedding_size])
    X = tf.add(tf.matmul(X, fcin_w), fcin_b)
    X = tf.nn.relu(X)
    # split the data and feed it to the BiLSTM
    if(flag_domain=='Restaurant'):
        if(flag_train):
            X = tf.split(axis=0, num_or_size_splits=train_max_sent_len, value=X)
        if(flag_test):
            X = tf.split(axis=0, num_or_size_splits=test_max_sent_len, value=X)   

    # BiLSTM
    lstm_fw_multicell, lstm_bw_multicell = bi_lstm()
    outputs,_,_ = tf.contrib.rnn.static_bidirectional_rnn(lstm_fw_multicell, lstm_bw_multicell, X, dtype='float32')
    # split the output for fw and bw
    output_fw, output_bw = tf.split(outputs, [lstm_hidden_size, lstm_hidden_size], 2)
    # dim = [61,128,256]
    # add two output and use the final feature for classification
    output_feature = tf.reshape(tf.add(output_fw, output_bw), [-1, lstm_hidden_size])
    
    output_feature = tf.nn.dropout(output_feature, keep_prob)
    output_feature = tf.add(tf.matmul(output_feature, fcout_w), fcout_b)
    # dim = [7808,3]
    
    if(flag_domain=='Restaurant'):
        if(flag_train):
            output_feature = tf.split(axis=0, num_or_size_splits=train_max_sent_len, value=output_feature)
        if(flag_test):
            output_feature = tf.split(axis=0, num_or_size_splits=test_max_sent_len, value=output_feature)

    # change back dimension to [batch_size, n_step, n_input]
    output_feature = tf.stack(output_feature)
    output_feature = tf.transpose(output_feature, [1, 0, 2])
    if(flag_uni_sent_embedding):
        output_feature = tf.add(output_feature, tf.expand_dims(tf_universal_X,2))/2
    # here  output_feature has shape (3,)
    # dim = [128,61,3]
    output_feature = tf.multiply(output_feature, tf.expand_dims(tf_X_binary_mask, 2))
    output_feature_check = output_feature
    if(flag_aspect=='term'):
        # output_feature has shape [?, max_sent_length, 3]
        cross_entropy_target = tf.reduce_mean(tf.multiply(tf.nn.softmax_cross_entropy_with_logits(logits=output_feature, labels=y_target_labels),  tf_X_mask))
        target_prediction = tf.argmax(tf.nn.softmax(output_feature), 2)
        target_correct_prediction = tf.reduce_sum(tf.multiply(tf.cast(tf.equal(target_prediction,   tf_y_target), tf.float32), tf_X_binary_mask))

        TP_t = tf.count_nonzero(target_prediction*tf_y_target)
        TN_t = tf.count_nonzero((target_prediction-1)*(tf_y_target-1))
        FP_t = tf.count_nonzero(target_prediction*(tf_y_target-1))
        FN_t = tf.count_nonzero((target_prediction-1)*tf_y_target)

        target_accuracy = (TP_t+TN_t)/(TP_t+FN_t+TN_t+FP_t)
        target_precision = TP_t/(TP_t+FP_t)
        target_recall = TP_t/(TP_t+FN_t)
        target_f1 = 2*target_precision*target_recall/(target_precision+target_recall)

    
    # category classification
    if(flag_aspect=='category'):
        output_dim = output_feature.get_shape().as_list()[1]
        category_w1, category_w2, category_b1, category_b2 = softmax_classifier_init(output_dim, num_category)
        feature = tf.reduce_mean(output_feature, 2)

        category_hidden_out = tf.nn.relu(tf.matmul(feature, category_w1) + category_b1)
        category_feature = tf.matmul(category_hidden_out, category_w2) + category_b2

        cross_entropy_category = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=category_feature, labels=y_category_labels))
        category_prediction = tf.argmax(tf.nn.softmax(category_feature), 1)
        category_prediction = tf.one_hot(category_prediction, num_category, on_value=1.0, off_value=0.0, axis=-1)
        category_prediction = tf.cast(category_prediction, tf.float32)
        y_category_labels = tf.cast(y_category_labels, tf.float32)
        
        TP_c = tf.count_nonzero(category_prediction*y_category_labels)
        TN_c = tf.count_nonzero((category_prediction - 1)*(y_category_labels - 1))
        FP_c = tf.count_nonzero(category_prediction*(y_category_labels - 1))
        FN_c = tf.count_nonzero((category_prediction - 1)*y_category_labels)
        
        category_accuracy = (TP_c+TN_c)/(TP_c+FN_c+TN_c+FP_c)
        category_precision = TP_c/(TP_c+FP_c)
        category_recall = TP_c/(TP_c+FN_c)
        category_f1 = 2*category_precision*category_recall/(category_precision+category_recall)
        
    
    
    # polarity classification
    output_dim = output_feature.get_shape().as_list()[1]
    polarity_w1, polarity_w2, polarity_b1, polarity_b2 = softmax_classifier_init(output_dim, 3)
    feature = tf.reduce_mean(output_feature, 2)
   
    polarity_hidden_out = tf.nn.relu(tf.matmul(feature, polarity_w1) + polarity_b1)
    polarity_feature = tf.matmul(polarity_hidden_out, polarity_w2) + polarity_b2
    
    cross_entropy_polarity = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=polarity_feature, labels=y_polarity_labels))
    polarity_prediction = tf.argmax(tf.nn.softmax(polarity_feature), 1)
    polarity_prediction = tf.one_hot(polarity_prediction, 3, on_value=1.0, off_value=0.0, axis=-1)
    polarity_prediction = tf.cast(polarity_prediction, tf.float32)
    y_polarity_labels = tf.cast(y_polarity_labels, tf.float32)
    
    TP_p = tf.count_nonzero(polarity_prediction*y_polarity_labels)
    TN_p = tf.count_nonzero((polarity_prediction - 1)*(y_polarity_labels - 1))
    FP_p = tf.count_nonzero(polarity_prediction*(y_polarity_labels - 1))
    FN_p = tf.count_nonzero((polarity_prediction - 1)*y_polarity_labels)

    polarity_accuracy = (TP_p+TN_p)/(TP_p+FN_p+TN_p+FP_p)
    polarity_precision = TP_p/(TP_p+FP_p)
    polarity_recall = TP_p/(TP_p+FN_p)
    polarity_f1 = 2*polarity_precision*polarity_recall/(polarity_precision+polarity_recall)
    

    if(flag_aspect=='term'):
        final_loss = cross_entropy_target + cross_entropy_polarity
    elif(flag_aspect=='category'):
        final_loss = cross_entropy_category + cross_entropy_polarity
        
    global_step = tf.Variable(0, trainable=False)
    learning_rate = tf.train.exponential_decay(LEARNING_RATE, global_step, 1000, 0.65, staircase=True)
    optimizer = tf.train.AdamOptimizer(learning_rate).minimize(final_loss, global_step=global_step)

    saver = tf.train.Saver()
################################################################################

# session run


with tf.Session(config=tf.ConfigProto(allow_soft_placement=True)) as sess:
    init = tf.global_variables_initializer()
    sess.run(init)

    # generate sentence representation
    x_train = utils.sent_represent_generator(train_data_sentence, word_embedding, word_dict)
    x_test = utils.sent_represent_generator(test_data_sentence, word_embedding, word_dict)

    # modify the sentence vectors with fixed length of max_sent_length
    if(flag_domain=='Restaurant'):
        x_train = utils.sent_represent_padding(x_train, max_sent_length=train_max_sent_len, embedding_size=embedding_size)
        x_test = utils.sent_represent_padding(x_test, max_sent_length=test_max_sent_len, embedding_size=embedding_size)
        train_binary_mask = utils.binary_mask_padding(train_binary_mask, train_max_sent_len)
        test_binary_mask = utils.binary_mask_padding(test_binary_mask, test_max_sent_len)
        train_mask = utils.mask_padding(train_mask, train_max_sent_len)
        test_mask = utils.mask_padding(test_mask, test_max_sent_len)
        if(flag_aspect=='term'):
            train_target_label = utils.label_padding(train_target_label, train_max_sent_len)
            test_target_label = utils.label_padding(test_target_label, test_max_sent_len)

    
    if(flag_train):
        loss_list = []
        polarity_accuracy_list = []
        category_accuracy_list = []

        for it in range(TRAINING_ITERATIONS):
            if(it * batch_size % num_sample_train + batch_size < num_sample_train):
                index = it * batch_size % num_sample_train
            else:
                index = num_sample_train - batch_size
            
            if(flag_aspect=='term'):
                _, correct_prediction_target, accuracy_polarity,cost_train, polarity_labels = sess.run([optimizer, target_correct_prediction, polarity_accuracy,final_loss, y_polarity_labels], feed_dict={tf_X: np.asarray(x_train[index:index+batch_size]), tf_X_mask: np.asarray(train_mask[index:index+batch_size]), tf_X_binary_mask: np.asarray(train_binary_mask[index:index+batch_size]), tf_universal_X: np.asarray(uni_embedding[index:index+batch_size]), 
                tf_y_target:np.asarray(train_target_label[index:index+batch_size]),
                tf_y_polarity:np.asarray(train_polarity_label[index:index+batch_size]), 
                keep_prob: 1.0 })
            
            
                print('target accuracy => %.3f, polarity_accuracy => %.3f, cost value => %.5f for step %d, learning_rate => %.5f' % (correct_prediction_target/np.sum(np.asarray(train_binary_mask[index:index+batch_size])), accuracy_polarity ,cost_train, it, learning_rate.eval()))

            if(flag_aspect=='category'):
                _, accuracy_polarity, accuracy_category,cost_train = sess.run([optimizer, category_accuracy , polarity_accuracy,final_loss], feed_dict={tf_X: np.asarray(x_train[index:index+batch_size]), tf_X_mask: np.asarray(train_mask[index:index+batch_size]), tf_X_binary_mask: np.asarray(train_binary_mask[index:index+batch_size]), tf_universal_X: np.asarray(uni_embedding[index:index+batch_size]), tf_y_category:np.asarray(train_category_label[index:index+batch_size]), tf_y_polarity:np.asarray(train_polarity_label[index:index+batch_size]),keep_prob: 1.0 })

                print('category accuracy => %.3f, polarity accuracy => %.3f, cost value => %.5f for step %d, learning rate => %.5f' % (accuracy_category, accuracy_polarity ,cost_train, it, learning_rate.eval()))

                loss_list.append(cost_train)
                polarity_accuracy_list.append(accuracy_polarity)
                category_accuracy_list.append(accuracy_category)
            
        saver.save(sess, '../ckpt/glove50_embedding_15000.ckpt')

        plt.plot(polarity_accuracy_list)
        axes = plt.gca()
        axes.set_ylim([0,1.2])
        plt.title('batch train polarity accuracy')
        plt.ylabel('accuracy')
        plt.xlabel('step')
        plt.savefig('polarity_accuracy.png')
        plt.close()

        plt.plot(category_accuracy_list)
        axes = plt.gca()
        axes.set_ylim([0,1.2])
        plt.title('batch train category accuracy')
        plt.ylabel('accuracy')
        plt.xlabel('step')
        plt.savefig('category_accuracy.png')
        plt.close()

        plt.plot(loss_list)
        axes = plt.gca()
        axes.set_ylim([0,200])
        plt.title('batch train loss')
        plt.ylabel('loss')
        plt.xlabel('step')
        plt.savefig('loss.png')
        plt.close()

    if(flag_test):
        #saver.restore(sess, '../ckpt/multiclass/Multiclass_category+polarity_Restaurant/with_uni_sent_embedding/glove50_embedding_15000.ckpt')
        saver.restore(sess,'../ckpt/glove50_embedding_15000.ckpt')

        if(flag_aspect=='term'):
            correct_prediction_test = sess.run([target_correct_prediction], feed_dict={tf_X: np.asarray(x_test[index:index+batch_size]), tf_X_mask: np.asarray(test_mask[index:index+batch_size]), tf_X_binary_mask: np.asarray(test_binary_mask[index:index+batch_size]), tf_universal_X: np.asarray(uni_embedding[index:index+batch_size]), 
            tf_y_target:np.asarray(test_target_label[index:index+batch_size]),
            tf_y_polarity:np.asarray(test_polarity_label[index:index+batch_size]), 
            keep_prob: 1.0 })

            accuracy_polarity = sess.run([polarity_accuracy], feed_dict={tf_X: np.asarray(x_test[index:index+batch_size]), tf_X_mask: np.asarray(test_mask[index:index+batch_size]), tf_X_binary_mask: np.asarray(test_binary_mask[index:index+batch_size]), tf_universal_X: np.asarray(uni_embedding[index:index+batch_size]), tf_y_category:np.asarray(test_category_label[index:index+batch_size]), tf_y_polarity:np.asarray(test_polarity_label[index:index+batch_size]),keep_prob: 1.0 })

            f1_target = sess.run([target_f1], feed_dict={tf_X: np.asarray(x_test[index:index+batch_size]), tf_X_mask: np.asarray(test_mask[index:index+batch_size]), tf_X_binary_mask: np.asarray(test_binary_mask[index:index+batch_size]), tf_universal_X: np.asarray(uni_embedding[index:index+batch_size]), 
            tf_y_target:np.asarray(test_target_label[index:index+batch_size]),
            tf_y_polarity:np.asarray(test_polarity_label[index:index+batch_size]), 
            keep_prob: 1.0 })

            f1_polarity = sess.run([polarity_f1], feed_dict={tf_X: np.asarray(x_test[index:index+batch_size]), tf_X_mask: np.asarray(test_mask[index:index+batch_size]), tf_X_binary_mask: np.asarray(test_binary_mask[index:index+batch_size]), tf_universal_X: np.asarray(uni_embedding[index:index+batch_size]), 
            tf_y_target:np.asarray(test_target_label[index:index+batch_size]),
            tf_y_polarity:np.asarray(test_polarity_label[index:index+batch_size]), 
            keep_prob: 1.0 })

            print('target accuracy => %.3f' % (correct_prediction_test)/np.sum(test_binary_mask))
            print('polarity accuracy => %.3f' % (accuracy_polarity))
            print('F1 socre for target prediction => %.3f' % (f1_target))
            print('F1 score for polarity prediction => %.3f' % (f1_polarity))

        if(flag_aspect=='category'):
            accuracy_polarity, accuracy_category = sess.run([category_accuracy , polarity_accuracy], feed_dict={tf_X: np.asarray(x_test[index:index+batch_size]), tf_X_mask: np.asarray(test_mask[index:index+batch_size]), tf_X_binary_mask: np.asarray(test_binary_mask[index:index+batch_size]), tf_universal_X: np.asarray(uni_embedding[index:index+batch_size]), tf_y_category:np.asarray(test_category_label[index:index+batch_size]), tf_y_polarity:np.asarray(test_polarity_label[index:index+batch_size]),keep_prob: 1.0 })

            f1_category = sess.run([category_f1], feed_dict={tf_X: np.asarray(x_test[index:index+batch_size]), tf_X_mask: np.asarray(test_mask[index:index+batch_size]), tf_X_binary_mask: np.asarray(test_binary_mask[index:index+batch_size]), tf_universal_X: np.asarray(uni_embedding[index:index+batch_size]), tf_y_category:np.asarray(test_category_label[index:index+batch_size]),tf_y_polarity:np.asarray(test_polarity_label[index:index+batch_size]), 
            keep_prob: 1.0 })

            f1_polarity = sess.run([polarity_f1], feed_dict={tf_X: np.asarray(x_test[index:index+batch_size]), tf_X_mask: np.asarray(test_mask[index:index+batch_size]), tf_X_binary_mask: np.asarray(test_binary_mask[index:index+batch_size]), tf_universal_X: np.asarray(uni_embedding[index:index+batch_size]), tf_y_category:np.asarray(test_category_label[index:index+batch_size]),tf_y_polarity:np.asarray(test_polarity_label[index:index+batch_size]), 
            keep_prob: 1.0 })

            print('category accuracy => %.3f' % (accuracy_category))
            print('polarity accuracy => %.3f' % (accuracy_polarity))
            print('F1 socre for category prediction => %.3f' % (f1_category))
            print('F1 score for polarity prediction => %.3f' % (f1_polarity))






    

    


# functions polarity prediction

# functions category prediction



 
