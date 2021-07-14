package com.univhash.controller;

import java.util.*;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.*;

@Controller
class UnivHash{

	static int m; //Number of buckets
    static int n; //Number of input integers
    static List<Integer> prime_list = new ArrayList<Integer>();
    static List<List<Integer>> hash_table = new ArrayList<List<Integer>>();
    static List<String> reconstruct = new ArrayList<String>();
    static Random rand = new Random();
    
	static void initHashTable() {
		for(int i=0;i<m;i++) {
			List<Integer> list_item = new ArrayList<Integer>();
			hash_table.add(list_item);
		}
	}
	
    static void calcPrimes(){
    	prime_list = new ArrayList<Integer>();
	    for (int i = m;i<2*m;i++) {
            boolean isPrimeNumber = true;
            for (int j = 2;j<i;j++) {
                if (i % j == 0) {
                    isPrimeNumber = false;
                    break; // exit the inner for loop
                }
            }
            if (isPrimeNumber) {
                prime_list.add(i);
            }
        }
	}
	
	static void computeHash(int x){
	    //Select a prime number p between m,2m;
	    int r = rand.nextInt(prime_list.size());
	    int p = prime_list.get(r);
	    
	    //Select a,b between 1,p;
	    int a = rand.nextInt(p)+1;
	    int b = rand.nextInt(p)+1;
	    
	    //hashValue(x) = (( a*x + b )%p)%m
	    int hashValue = (a*x + b)%p%m;
	    
	    String str = x+","+hashValue+","+a+","+b+","+p+","+m;
	    reconstruct.add(str);
	    
	    List<Integer> hash_list = hash_table.get(hashValue);
	    hash_list.add(x);
	    hash_table.set(hashValue, hash_list);
	    
//	    System.out.println("Input number: "+x+" Bucket number: "+hashValue);
	}
	
	@RequestMapping(value = "/univHash", method=RequestMethod.POST)
	public  @ResponseBody String univHash(@RequestParam("bucket") String bucket, @RequestParam("input") String input){
		hash_table = new ArrayList<List<Integer>>();
		reconstruct = new ArrayList<String>();
		m = Integer.parseInt(bucket);
		String inputs[] = input.split(",");
		n = inputs.length;
		System.out.println(n);
		int input_numbers[] = new int[n];
		for(int i = 0; i<n;i++){
		    input_numbers[i] = Integer.parseInt(inputs[i]);
		}		
		calcPrimes();
		initHashTable();		
		for(int i = 0; i<n;i++){
		    computeHash(input_numbers[i]);
		}		
		System.out.println(hash_table);		
		return hash_table.toString();
    }	
	

	public static void main(String args[]){

	}
}