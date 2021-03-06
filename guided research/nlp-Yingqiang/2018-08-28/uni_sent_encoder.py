# -*-coding:UTF-8

import tensorflow as tf
import tensorflow_hub as hub
import utils
import numpy as np
import re


# universal sentence encoder works in CPU environment, not GPU, so make sure to load the sentence embeddings in CPU environment without GPU supports.
def load_uni_sent_encoding(sentences):
    # first loading could take some minutes
    module_url = "https://tfhub.dev/google/universal-sentence-encoder/2"
    # Import the Universal Sentence Encoder's TF Hub module
    embed = hub.Module(module_url)
    print('Loading done.')

    # Reduce logging output.
    tf.logging.set_verbosity(tf.logging.ERROR)
    with tf.Session() as sess:
        sess.run([tf.global_variables_initializer(), tf.tables_initializer()])
        sentence_embeddings = sess.run(embed(sentences))
        print('embedding done')
        with open('uni_sent_embedding_Hahaha.txt','w') as outfile:
            for i, embedding in enumerate(np.array(sentence_embeddings).tolist()):
                temp = str(sentence_embeddings[i]).lstrip('[')
                temp = temp.rstrip(']')
                temp = temp.replace(',', '')
                temp = re.sub(' +', ' ', temp)
                outfile.writelines('sent'+str(i)+' '+temp + '\n')
            print('write file done')
       
    return sentence_embeddings

# this function compress the universal sentence embedding to the wanted dimension with a simple 3 layer forward network
# input size: 512, hidden layer size: 512, hidden layer number:2, output_size: max_sent_length
def universal_fcn(input_data, max_sent_length):
    graph = tf.Graph()
    data = input_data[1:len(input_data)]
    #print(data)
    with graph.as_default(), tf.device('cpu:0'):
        tf_X = tf.placeholder(tf.float32, [None, 512])
        weight1 = tf.Variable(tf.random_normal([512, 512]))
        bias1 = tf.Variable(tf.zeros([1,512])+0.1)
        w1x_plus_b1 = tf.matmul(data, weight1) + bias1
        hidden1_out = w1x_plus_b1
        weight2 = tf.Variable(tf.random_normal([512, max_sent_length]))
        bias2 = tf.Variable(tf.zeros([1,max_sent_length])+0.1)
        w2x_plus_b2 = tf.matmul(hidden1_out, weight2) + bias2
        prediction = w2x_plus_b2
        prediction = tf.nn.l2_normalize(prediction, dim=0)
    
        init = tf.global_variables_initializer()
        #saver = tf.train.Saver()

        with tf.Session() as sess: 
            sess.run(init)
            
            #saver.save(sess, '../ckpt/uni_sent_compress.ckpt')   

            #saver.restore(sess, '../ckpt/uni_sent_compress.ckpt')
            output = sess.run(prediction, feed_dict={tf_X:input_data})
            print(len(output[0]))
            with open('uni_sent_embedding_compressed_This_is_me.txt','w') as outfile:
              for i, embedding in enumerate(np.array(output).tolist()):
                  temp = str(embedding).lstrip('[')
                  temp = temp.rstrip(']')
                  temp = temp.replace(',', '')
                  temp = re.sub(' +', ' ', temp)
                  outfile.writelines('sent'+str(i)+' '+temp + '\n')
            

if __name__ == '__main__':
    
    data_dir = '/Users/gaoyingqiang/Desktop/大学/Master/Guided-Research/nlp-Yingqiang/convert'
    # read training data
    train_data_sentence, _, _,_  = utils.load_untokenized_data(data_dir + "/Organic_Train.json",flag_train_or_test='train')
    print('data OK')

    sent_embedding = load_uni_sent_encoding(train_data_sentence[int(len(train_data_sentence)*0.8):len(train_data_sentence)])
    universal_fcn(sent_embedding, 94)
    
    #universal_fcn(sent_embedding, 74)