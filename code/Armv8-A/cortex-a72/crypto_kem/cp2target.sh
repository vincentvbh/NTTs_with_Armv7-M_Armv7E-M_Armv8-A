#!bin/sh

TARGET_PATH=$1


cp -rL kyber512/aarch64 $TARGET_PATH/crypto_kem/kyber512/
cp -rL kyber768/aarch64 $TARGET_PATH/crypto_kem/kyber768/
cp -rL kyber1024/aarch64 $TARGET_PATH/crypto_kem/kyber1024/


cp -rL lightsaber/aarch64 $TARGET_PATH/crypto_kem/lightsaber/
cp -rL saber/aarch64 $TARGET_PATH/crypto_kem/saber/
cp -rL firesaber/aarch64 $TARGET_PATH/crypto_kem/firesaber/

