CXXFLAGS=-I./inc -I/opt/opencv/include -O3 -g -fPIC -pthread -fmessage-length=0 -std=c++14
LDFLAGS=-L/opt/opencv/lib -Wl,-rpath,/opt/opencv/lib -lopencv_core -lopencv_highgui -lopencv_imgcodecs -lopencv_imgproc -lopencv_video -lopencv_videoio -lopencv_objdetect -lopencv_ml -lX11 -lpng -ljpeg -ldl -lrt -lpthread
OBJS_BASE= \
./src/Allocator.o \
./src/blob.o \
./src/BlobExtraction.o \
./src/BlobResult.o \
./src/Camera.o \
./src/CmdLine.o \
./src/CmdOption.o \
./src/cross_bilateral_filter.o \
./src/DiskXFile.o \
./src/FileList.o \
./src/FileListCmdOption.o \
./src/general.o \
./src/IntegralImage.o \
./src/LocalBinaryPattern.o \
./src/MultiLayerBGS.o \
./src/Object.o \
./src/Random.o \
./src/string_utils.o \
./src/XFile.o
OBJS_EXT= \
./src/BoostClassifierCovariance.o \
./src/BuildFeatureImages.o \
./src/CovarianceMatrix.o \
./src/ImageBoostingNegExamples.o \
./src/ImageDetection.o \
./src/IntegralRegionCov.o \
./src/MergingDetection.o \
./src/NegExamplesGenerator.o \
./src/sym_eig234.o \
./src/TestWindows.o \
./src/WeakClassifier.o \
./src/WeakClassifierCovariance.o

TARGET1=background_sub_train
TARGET2=background_sub_infer
TARGET3=background_sub_human_detect

$(TARGET1): $(OBJS_BASE) ./src/bgsub_train.o
	$(CXX) $(OBJS_BASE) ./src/bgsub_train.o $(LDFLAGS) -o $(TARGET1)
	
$(TARGET2): $(OBJS_BASE) ./src/bgsub_infer.o
	$(CXX) $(OBJS_BASE) ./src/bgsub_infer.o $(LDFLAGS) -o $(TARGET2)	
	
$(TARGET3): $(OBJS_BASE) $(OBJS_EXT) ./src/human_detect.o
	$(CXX) $(OBJS_BASE) $(OBJS_EXT) ./src/human_detect.o $(LDFLAGS) -o $(TARGET3)

all: $(TARGET1) $(TARGET2) $(TARGET3)

clean:
	rm -f $(OBJS_BASE) $(OBJS_EXT) ./src/bgsub_train.o ./src/bgsub_infer.o ./src/human_detect.o $(TARGET1) $(TARGET2) $(TARGET3)
