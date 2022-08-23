import syntaxtree.*;
import visitor.*;

public class A2{
   public static void main(String [] args) {
      try {
         Node root = new MiniJavaParser(System.in).Goal();
        //root.accept(new GJDepthFirst(),null);
        GJDepthFirst g=new GJDepthFirst();
        root.accept(g,null);
        //g.printdump();
        root.accept(g,null);
         System.out.println("Program type checked successfully");
          // Your assignment part is invoked here.
      }

      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
}
