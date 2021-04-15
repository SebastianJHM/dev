import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Triangles {
    static String[] triangleOrNot(int[] a, int[] b, int[] c) {
        String[] Answer = new String[a.length];    
        for (int i=0; i<a.length; i++){
            Answer[i] = "No";
            if((a[i]+b[i]>c[i]) && (a[i]+c[i]>b[i]) && (b[i]+c[i]>a[i])){
                Answer[i] = "Yes";
            }
        }
        return(Answer);
    }
}