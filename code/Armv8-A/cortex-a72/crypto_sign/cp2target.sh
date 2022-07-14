#!bin/sh


TARGET_PATH=$1

cp -rL dilithium2/aarch64 $TARGET_PATH/crypto_sign/dilithium2/
cp -rL dilithium3/aarch64 $TARGET_PATH/crypto_sign/dilithium3/
cp -rL dilithium5/aarch64 $TARGET_PATH/crypto_sign/dilithium5/

