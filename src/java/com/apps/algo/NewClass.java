/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apps.algo;

import com.apps.constants.Constants;
import java.io.File;
import java.security.PrivateKey;
import java.security.PublicKey;

/**
 *
 * @author home
 */
public class NewClass 
{    
    public void display() throws Exception 
    {
        RSAFileAlgorithm ac = new RSAFileAlgorithm();
        PrivateKey privateKey = ac.getPrivate(Constants.BASE_PATH + "privateKey");
        PublicKey publicKey = ac.getPublic(Constants.BASE_PATH + "publicKey");

        String msg = "Cryptography is fun!";
        String encrypted_msg = ac.encryptText(msg, privateKey);
        String decrypted_msg = ac.decryptText(encrypted_msg, publicKey);
        System.out.println("Original Message: " + msg + "\nEncrypted Message: " + encrypted_msg + "\nDecrypted Message: " + decrypted_msg);

        if(new File(Constants.BASE_PATH + "text.txt").exists())
        {
            ac.encryptFile(ac.getFileInBytes(new File(Constants.BASE_PATH + "text.txt")), new File(Constants.BASE_PATH + "5d9115d27ab28098fff9943f2206Mail_encrypted.txt"), privateKey);
            ac.decryptFile(ac.getFileInBytes(new File(Constants.BASE_PATH + "5d9115d27ab28098fff9943f2206Mail_encrypted.txt")), new File(Constants.BASE_PATH + "5d9115d27ab28098fff9943f2206Mail_decrypted.txt"), publicKey);
        }
        else
        {
            System.out.println("Create a file text.txt under folder KeyPair");
        }
    }
    
    public static void main(String[] args) throws Exception 
    {
        NewClass objNewClass = new NewClass();
        objNewClass.display();
    }
}
