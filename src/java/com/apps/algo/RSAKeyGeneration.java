package com.apps.algo;

import com.apps.constants.Constants;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.PrivateKey;
import java.security.PublicKey;

public class RSAKeyGeneration {

    private KeyPairGenerator keyGen;
    private KeyPair pair;
    private PrivateKey privateKey;
    private PublicKey publicKey;

    public RSAKeyGeneration(int keylength) throws NoSuchAlgorithmException, NoSuchProviderException {
        this.keyGen = KeyPairGenerator.getInstance("RSA");
        this.keyGen.initialize(keylength);
    }

    public void createKeys() {
        this.pair = this.keyGen.generateKeyPair();
        this.privateKey = pair.getPrivate();
        this.publicKey = pair.getPublic();
    }
    public PrivateKey getPrivateKey() {
        return this.privateKey;
    }
    public PublicKey getPublicKey() {
        return this.publicKey;
    }
    public void writeToFile(String path, byte[] key) throws IOException {
        FileOutputStream fos = null;
        File f = null;

        try {
            f = new File(path);
            f.getParentFile().mkdirs();

            fos = new FileOutputStream(f);
            fos.write(key);
            fos.flush();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (fos != null) {
                fos.close();
                fos = null;
            }
        }
    }
    public static void main(String[] args) {
        RSAKeyGeneration gk;

        try {
            gk = new RSAKeyGeneration(1024);
            gk.createKeys();
            gk.writeToFile(Constants.BASE_PATH + "publicKey", gk.getPublicKey().getEncoded());
            gk.writeToFile(Constants.BASE_PATH + "privateKey", gk.getPrivateKey().getEncoded());
        } catch (NoSuchAlgorithmException e) {
            System.err.println(e.getMessage());
        } catch (NoSuchProviderException e) {
            System.err.println(e.getMessage());
        } catch (IOException e) {
            System.err.println(e.getMessage());
        }
    }
}
