package com.apps.algo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.security.Key;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class BlowfishFileAlgorithm 
{
    private static final String ALGORITHM = "Blowfish";

    public static void encrypt(String inputFile, String outputFile, String publicKey) throws Exception 
    {
        doCrypto(Cipher.ENCRYPT_MODE, new File(inputFile), new File(outputFile), publicKey);
        
        System.out.println("File encrypted successfully!");
    }

    public static void decrypt(String inputFile, String outputFile, String publicKey) throws Exception 
    {
        doCrypto(Cipher.DECRYPT_MODE, new File(inputFile), new File(outputFile), publicKey);
        
        System.out.println("File decrypted successfully!");
    }

    private static void doCrypto(int cipherMode, File inputFile, File outputFile, String publicKey) throws Exception 
    {
        Key secretKey = new SecretKeySpec(publicKey.getBytes(), ALGORITHM);
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(cipherMode, secretKey);

        FileInputStream inputStream = new FileInputStream(inputFile);
        byte[] inputBytes = new byte[(int) inputFile.length()];
        inputStream.read(inputBytes);

        byte[] outputBytes = cipher.doFinal(inputBytes);

        FileOutputStream outputStream = new FileOutputStream(outputFile);
        outputStream.write(outputBytes);

        inputStream.close();
        outputStream.close();
    }
}