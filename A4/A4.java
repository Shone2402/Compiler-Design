import syntaxtree.*;
import visitor.*;

public class A4 {
   public static void main(String [] args) {
      try {
         Node root = new microIRParser(System.in).Goal();
         GJDepthFirst1 b = new GJDepthFirst1();
         root.accept(b,null);
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 


