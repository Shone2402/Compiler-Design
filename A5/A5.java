import syntaxtree.*;
import visitor.*;

public class A5 {
   public static void main(String [] args) {
      try {
         Node root = new MiniRAParser(System.in).Goal();
         GJDepthFirst2 g = new GJDepthFirst2();
         System.out.println(root.accept(g,null));
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
}
