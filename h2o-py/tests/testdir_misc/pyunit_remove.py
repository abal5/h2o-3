from h2o.estimators.estimator_base import H2OEstimator
import sys
sys.path.insert(1,"../../")
import h2o
from tests import pyunit_utils
import os


def remove_obj_client():

  training_data = h2o.import_file(pyunit_utils.locate("smalldata/logreg/benign.csv"))
  
  Y = 3
  X = range(3) + range(4,11)
  
  from h2o.estimators.glm import H2OGeneralizedLinearEstimator
  model = H2OGeneralizedLinearEstimator(family="binomial", alpha=0, Lambda=1e-5)
  print model.model_id
  print model
  model.train(x=X,y=Y, training_frame=training_data)
  print model
  h2o.remove(model)
  print model
  
  h2o.remove(training_data)
  print training_data


if __name__ == "__main__":
  pyunit_utils.standalone_test(remove_obj_client)
else:
  remove_obj_client()
