BASE_DIR=$(shell pwd)
SRC_DIR=$(BASE_DIR)/src
BUILD_DIR=$(BASE_DIR)/target
STAGING_DIRECTORY_STAMP=$(BUILD_DIR)/staging-directory-stamp
STAGING_DIRECTORY=$(BUILD_DIR)/staging
STAGING_WHEELHOUSE=$(BUILD_DIR)/staging-wheelhouse
STAGING_WHEELHOUSE_STAMP=$(BUILD_DIR)/staging-wheelhouse-stamp
CACHE_WHEELHOUSE=$(BUILD_DIR)/cache-wheelhouse
CACHE_WHEELHOUSE_STAMP=$(BUILD_DIR)/cache-wheelhouse-stamp
OUTPUT_FILE_NAME=herokuCloudwatchSync.zip
OUTPUT_ZIP=$(BUILD_DIR)/$(OUTPUT_FILE_NAME)

-include .env

$(OUTPUT_ZIP): $(STAGING_DIRECTORY_STAMP)
	#rm -f $(OUTPUT_ZIP)
	cd $(STAGING_DIRECTORY) && zip -q -X -9 -r ../$(OUTPUT_FILE_NAME) *

clean:
	rm -f $(STAGING_DIRECTORY_STAMP)
	rm -f $(STAGING_WHEELHOUSE_STAMP)
	rm -f $(CACHE_WHEELHOUSE_STAMP)
	rm -rf $(STAGING_DIRECTORY)
	rm -f $(OUTPUT_ZIP)
	rm -f $(BUILD_DIR)/heroku_sync_to_cloudwatch.py

$(CACHE_WHEELHOUSE_STAMP): $(SRC_DIR)/requirements.txt
	cd $(SRC_DIR); pip3 wheel -q -r requirements.txt . --wheel-dir=$(CACHE_WHEELHOUSE)
	touch $@

$(STAGING_WHEELHOUSE_STAMP): $(CACHE_WHEELHOUSE_STAMP)
	rm -rf $(STAGING_WHEELHOUSE)
	cd $(SRC_DIR); pip3 wheel -q -r requirements.txt --wheel-dir=$(STAGING_WHEELHOUSE) --find-links=$(CACHE_WHEELHOUSE)
	touch $@


$(STAGING_DIRECTORY_STAMP): $(SRC_DIR)/heroku_sync_to_cloudwatch.py $(STAGING_WHEELHOUSE_STAMP)
	rm -rf $(STAGING_DIRECTORY)
	mkdir $(STAGING_DIRECTORY)
	cp $(SRC_DIR)/heroku_sync_to_cloudwatch.py $(STAGING_DIRECTORY)
	unzip -q "$(STAGING_WHEELHOUSE)/*.whl" -d $(STAGING_DIRECTORY)
	touch $@

deploy: $(OUTPUT_ZIP)
	aws s3 cp $(OUTPUT_ZIP) s3://$(S3_BUCKET_NAME)
	aws lambda update-function-code --s3-bucket=$(S3_BUCKET_NAME) --s3-key=$(OUTPUT_FILE_NAME) --function-name=$(AWS_CREATED_LAMBDA_NAME)

all: $(OUTPUT_ZIP)
#	.PHONY: all clean
