package com.apps.algo;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.security.AlgorithmParameters;
import java.security.SecureRandom;
import java.security.spec.KeySpec;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

public class AESFileAlgorithm 
{
    public static void EncryptFile(String inFilePath, String encFilePath, String encSalt, String encIv, String password)
    {
        FileInputStream inFile = null;
        FileOutputStream outFile = null;
        FileOutputStream saltOutFile = null;
        FileOutputStream ivOutFile = null;
        byte[] salt = null;
        
        try
        {
            // file to be encrypted
            inFile = new FileInputStream(inFilePath);
            
            // encrypted file
            outFile = new FileOutputStream(encFilePath);
            
            // password, iv and salt should be transferred to the other end
            // in a secure manner

            // salt is used for encoding
            // writing it to a file
            // salt should be transferred to the recipient securely
            // for decryption
            salt = new byte[8];
            SecureRandom secureRandom = new SecureRandom();
            secureRandom.nextBytes(salt);
            
            saltOutFile = new FileOutputStream(encSalt);
            saltOutFile.write(salt);
            saltOutFile.close();

            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
            KeySpec keySpec = new PBEKeySpec(password.toCharArray(), salt, 65536, 256);
            SecretKey secretKey = factory.generateSecret(keySpec);
            SecretKey secret = new SecretKeySpec(secretKey.getEncoded(), "AES");

            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, secret);
            AlgorithmParameters params = cipher.getParameters();
            
            // iv adds randomness to the text and just makes the mechanism more
            // secure
            // used while initializing the cipher
            // file to store the iv
            ivOutFile = new FileOutputStream(encIv);
            byte[] iv = params.getParameterSpec(IvParameterSpec.class).getIV();
            ivOutFile.write(iv);
            ivOutFile.close();

            //file encryption
            byte[] input = new byte[64];
            int bytesRead;

            while ((bytesRead = inFile.read(input)) != -1) 
            {
                byte[] output = cipher.update(input, 0, bytesRead);
                
                if (output != null) 
                {
                    outFile.write(output);
                }
            }

            byte[] output = cipher.doFinal();
            
            if (output != null) 
            {
                outFile.write(output);
            }

            inFile.close();
            outFile.flush();
            outFile.close();

            System.out.println("File Encrypted.");        
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    
    public static void DecryptFile(String outfilePath, String decFilePath, String encSalt, String encIv, String password)
    {
        FileInputStream saltFis = null;
        FileInputStream ivFis = null;
        byte[] salt = null;
        byte[] iv = null;
        
        try
        {
            // reading the salt
            // user should have secure mechanism to transfer the
            // salt, iv and password to the recipient
            saltFis = new FileInputStream(encSalt);
            salt = new byte[8];
            saltFis.read(salt);
            saltFis.close();

            // reading the iv
            ivFis = new FileInputStream(encIv);
            iv = new byte[16];
            ivFis.read(iv);
            ivFis.close();

            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
            KeySpec keySpec = new PBEKeySpec(password.toCharArray(), salt, 65536, 256);
            SecretKey tmp = factory.generateSecret(keySpec);
            SecretKey secret = new SecretKeySpec(tmp.getEncoded(), "AES");

            // file decryption
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, secret, new IvParameterSpec(iv));
            FileInputStream fis = new FileInputStream(decFilePath);
            FileOutputStream fos = new FileOutputStream(outfilePath);
            byte[] in = new byte[64];
            int read;

            while ((read = fis.read(in)) != -1) 
            {
                byte[] output = cipher.update(in, 0, read);

                if (output != null) 
                {
                    fos.write(output);
                }
            }

            byte[] output = cipher.doFinal();

            if (output != null) 
            {
                fos.write(output);
            }

            fis.close();
            fos.flush();
            fos.close();

            System.out.println("File Decrypted.");
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
}