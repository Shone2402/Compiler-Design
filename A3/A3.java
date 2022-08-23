import syntaxtree.*;
import visitor.*;

public class A3 {
   public static void main(String [] args) {
      try {
         Node root = new MiniJavaParser(System.in).Goal();
         // Get classes class_tables         
         
         GJDepthFirst2 c=new GJDepthFirst2();
         root.accept(c,null);
       
         GJDepthFirst3 cd = new GJDepthFirst3();
         cd.class_tables = c.class_tables;
         root.accept(cd,null);
        
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 
