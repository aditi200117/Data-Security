package com.apps.algo;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.security.SecureRandom;
import java.security.Security;
import java.security.spec.KeySpec;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;
import org.bouncycastle.jce.provider.BouncyCastleProvider;

public class CustomAESFileAlgorithm 
{      
    public static void EncryptFile(String inFilePath, String encFilePath, String encSalt, String encIv, String password)
    {
        FileInputStream inFile = null;
        FileOutputStream outFile = null;
        FileOutputStream saltOutFile = null;
        FileOutputStream ivOutFile = null;
        byte[] salt = null;
        int blocksize = 16;
        
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
            //salt = new byte[8];
            salt = new byte[blocksize]; //Change of Salt Key Size
            SecureRandom secureRandom = new SecureRandom();
            secureRandom.nextBytes(salt);
            
            saltOutFile = new FileOutputStream(encSalt);
            saltOutFile.write(salt);
            saltOutFile.close();

            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
            KeySpec keySpec = new PBEKeySpec(password.toCharArray(), salt, 65536, 256);
            SecretKey secretKey = factory.generateSecret(keySpec);
            SecretKey secret = new SecretKeySpec(secretKey.getEncoded(), "AES");

            //Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");       
            
            Cipher cipher = Cipher.getInstance("AES/CTR/NoPadding", new BouncyCastleProvider()); //Cipher mode can be changed (Counter Mode)
            
            //cipher.init(Cipher.ENCRYPT_MODE, secret);
                  
            //System.out.println("Encrypt Cipher Length: " + cipher.getBlockSize()); //length = 16
             
            //AlgorithmParameters params = cipher.getParameters();
            
            // iv adds randomness to the text and just makes the mechanism more
            // secure
            // used while initializing the cipher
            // file to store the iv
            ivOutFile = new FileOutputStream(encIv);
            
            //byte[] iv = params.getParameterSpec(IvParameterSpec.class).getIV();
                         
            byte[] iv = new byte[blocksize]; //Change of IV Key Size
              
            blocksize = blocksize + 16;
                    
            IvParameterSpec ivParameterSpec = new IvParameterSpec(iv); //Procedure Change in generation of iv key
           
            cipher.init(Cipher.ENCRYPT_MODE, secret, ivParameterSpec);
            
            System.out.println("Encrypt Block Size: " + blocksize); //Block size can be changed
                        
            ivOutFile.write(iv);
            ivOutFile.close();
           
            //file encryption
            byte[] input = new byte[1024];
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
        int blocksize = 16;
        
        try
        {
            // reading the salt
            // user should have secure mechanism to transfer the
            // salt, iv and password to the recipient
            saltFis = new FileInputStream(encSalt);
            //salt = new byte[8];
            salt = new byte[blocksize]; //Change of Salt Key Size
            saltFis.read(salt);
            saltFis.close();

            // reading the iv
            ivFis = new FileInputStream(encIv);
            //iv = new byte[8];
            iv = new byte[blocksize]; //Change of IV Key Size
            blocksize = blocksize + 16;
            ivFis.read(iv);
            ivFis.close();

            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
            KeySpec keySpec = new PBEKeySpec(password.toCharArray(), salt, 65536, 256);
            SecretKey tmp = factory.generateSecret(keySpec);
            SecretKey secret = new SecretKeySpec(tmp.getEncoded(), "AES");

            // file decryption
            //Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            //cipher.init(Cipher.DECRYPT_MODE, secret, new IvParameterSpec(iv));
            
            Cipher cipher = Cipher.getInstance("AES/CTR/NoPadding", new BouncyCastleProvider()); //Cipher mode can be changed (Counter Mode)
            
            System.out.println("Decrypt Block Size: " + blocksize); //Block size can be changed
             
            IvParameterSpec ivParameterSpec = new IvParameterSpec(iv); //Procedure Change in generation of iv key
             
            cipher.init(Cipher.DECRYPT_MODE, secret, ivParameterSpec);
            
            FileInputStream fis = new FileInputStream(decFilePath);
            FileOutputStream fos = new FileOutputStream(outfilePath);
            
            byte[] in = new byte[1024];
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
    
    public static void main(String args[])
    {
        try
        {
            Security.addProvider(new BouncyCastleProvider());
            
            String saveFile = "E:/images/1.txt";
            String secretKey = "1234";
            String outputFile = "E:/images/2.txt";
            
             CustomAESFileAlgorithm.EncryptFile(saveFile, saveFile.substring(0, saveFile.indexOf(".")) + ".des",
                    saveFile.substring(0, saveFile.indexOf(".")) + "_iv.enc", 
                    saveFile.substring(0, saveFile.indexOf(".")) + "_salt.enc", secretKey);
             
              CustomAESFileAlgorithm.DecryptFile(outputFile, saveFile.substring(0, saveFile.indexOf(".")) + ".des",
                    saveFile.substring(0, saveFile.indexOf(".")) + "_iv.enc", 
                    saveFile.substring(0, saveFile.indexOf(".")) + "_salt.enc",
                    secretKey);
        }
        catch(Exception e)            
        {
            e.printStackTrace();
        }
    }
}