package visitor;
import syntaxtree.*;
import java.util.*;

/**
 * Provides default methods which visit each node in the tree in depth-first
 * order.  Your visitors may extend this class.
 */
public class GJDepthFirst2 implements GJVisitor<String,String> {
   String expr = "";
   int a = 0;
   String result="";
   int b=0;
   String arg1="";
   int c=0;
   String arg2="";
   String store = "";
  
   public String endprint()
   {
      String ans="";
       ans += "\n\n.text \n.globl _halloc \n_halloc: \n";
      ans +="\tli $v0, 9 \n\tsyscall \n\tjr $ra\n";

      ans +="\n\n.text \n.globl _error \n_error: \n";
      ans +="\tli $v0, 4 \n\tsyscall \n\tli $v0, 10\n\tsyscall \n";
     
      ans +="\n\n.text \n.globl _print  \n_print:  \n";
      ans +="\tli $v0, 1 \n\tsyscall \n\tla $a0, newline \n\tli $v0, 4 \n\tsyscall \n\tjr $ra\n";
      
      ans += "\n\n.text \n.globl _exitret \n_exitret: \n";
      ans +="\tli $v0, 10 \n\tsyscall \n\t.data\n";

      ans += "\n\n.data \n.align 0 \nnewline: .asciiz \"\\n\" \n\n\n.data \n.align 0 \nstr_er: .asciiz \"ERROR: abnormal termination\\n\"\n";
      return ans;
   }
   
   public String find(String expr)
   {
       if(expr == "Reg")
    		  return "move ";
    	  else if(expr == "Label")
    		  return "la ";
    	  else
    		  return "li " ;

   }
   
   public String operate(String s)
   {
         if(s=="LE")
         return "sle";
        if(s=="PLUS")
         return "add";
        if(s=="NE")
         return "sne";
        if(s=="MINUS")
         return "sub";
        if(s=="TIMES")
         return "mul";
        if(s=="DIV")
         return "div";


        return "";
   }
   
   //
   // Auto class visitors--probably don't need to be overridden.
   //
   public String visit(NodeList n, String argu) {
      String ans="";
      int _count=0;
      for ( Enumeration<Node> e = n.elements(); e.hasMoreElements(); ) {
         ans += e.nextElement().accept(this, argu);
         _count++;
      }
      return ans;
   }

   public String visit(NodeListOptional n, String argu) {
      if ( n.present() ) {
         String ans="";
         int _count=0;
         for ( Enumeration<Node> e = n.elements(); e.hasMoreElements(); ) {
            ans += e.nextElement().accept(this, argu);
            _count++;
         }
         return ans;
      }
      else
         return "";
   }

   public String visit(NodeOptional n, String argu) {
      if ( n.present() )
         return n.node.accept(this, argu)+":";
      else
         return "";
   }

   public String visit(NodeSequence n, String argu) {
      String ans="";
      int _count=0;
      for ( Enumeration<Node> e = n.elements(); e.hasMoreElements(); ) {
    	 ans += e.nextElement().accept(this, argu);
         _count++;
      }
      return ans;
   }

   public String visit(NodeToken n, String argu) { return n.tokenImage; }

   //
   // User-generated visitor methods below
   //

     /**
    * f0 -> "MAIN"
    * f1 -> "["
    * f2 -> IntegerLiteral()
    * f3 -> "]"
    * f4 -> "["
    * f5 -> IntegerLiteral()
    * f6 -> "]"
    * f7 -> "["
    * f8 -> IntegerLiteral()
    * f9 -> "]"
    * f10 -> StmtList()
    * f11 -> "END"
    * f12 -> ( SpillInfo() )?
    * f13 -> ( Procedure() )*
    * f14 -> <EOF>
    */
   public String visit(Goal n, String argu) {
	   String ans=".text\n";
      ans +=".globl main\n";
      ans += "main:\n";
      ans += "\tmove $fp, $sp\n";
      ans += "\tsw $ra, -4($sp)\n";
     
     
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      a = Integer.parseInt(n.f2.accept(this, argu));
	   if(a<4) a = 4;
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
      b = Integer.parseInt(n.f5.accept(this, argu));
      n.f6.accept(this, argu);
      n.f7.accept(this, argu);
      c = Integer.parseInt(n.f8.accept(this, argu));
      String fin=Integer.toString(4*(b-a+4 + c+1));
	  
     ans += "\tsubu $sp, $sp, " + fin + "\n";
        n.f9.accept(this, argu);   
     ans += n.f10.accept(this, argu);
       n.f10.accept(this, argu);
      n.f11.accept(this, argu);
      ans += "\taddu $sp, $sp, " + fin+ "\n";
      ans += "\tlw $ra, -4($sp)\n";
      ans += "\tjal _exitret\n";
	    n.f12.accept(this, argu);
      
      
      ans += n.f13.accept(this, argu);      
      n.f14.accept(this, argu);
      String last=endprint();
      ans +=last;
      return ans;
   }

   /**
    * f0 -> ( ( Label() )? Stmt() )*
    */
   public String visit(StmtList n, String argu) {
	   String ans=n.f0.accept(this, argu);
      return ans;
   }

   /**
    * f0 -> Label()
    * f1 -> "["
    * f2 -> IntegerLiteral()
    * f3 -> "]"
    * f4 -> "["
    * f5 -> IntegerLiteral()
    * f6 -> "]"
    * f7 -> "["
    * f8 -> IntegerLiteral()
    * f9 -> "]"
    * f10 -> StmtList()
    * f11 -> "END"
    * f12 -> ( SpillInfo() )?
    */
   public String visit(Procedure n, String argu) {
	  String s = n.f0.accept(this, argu);
     String ans="\n\n.text\n";
      ans +=".globl " + s + "\n";
      ans += s + ":\n";
      ans += "\tsw $fp, -8($sp)\n";
      ans += "\tmove $fp, $sp\n";
      ans += "\tsw $ra, -4($sp)\n";
     
      n.f1.accept(this, argu);
	  a = Integer.parseInt(n.f2.accept(this, argu));
	  if(a < 4)	a = 4;
      n.f3.accept(this, argu);
      n.f4.accept(this, argu);
     b=0;
     b = Integer.parseInt(n.f5.accept(this, argu));
     c=0;
      n.f6.accept(this, argu);
      n.f7.accept(this, argu);
     c = Integer.parseInt(n.f8.accept(this, argu));
       String fin=Integer.toString(4*(b-a+4 + c+1));
	  
      ans += "\tsubu $sp, $sp, " + fin+ "\n";
       n.f9.accept(this, argu);
      ans += n.f10.accept(this, argu);
      n.f11.accept(this, argu);
      n.f12.accept(this, argu);
      ans += "\taddu $sp, $sp, " + fin + "\n";
      ans += "\tlw $ra, -4($sp)\n";
      ans += "\tlw $fp, -8($sp)\n";
      ans += "\tjr $ra\n";
    
      return ans;
   }

   /**
    * f0 -> NoOpStmt()
    *       | ErrorStmt()
    *       | CJumpStmt()
    *       | JumpStmt()
    *       | HStoreStmt()
    *       | HLoadStmt()
    *       | MoveStmt()
    *       | PrintStmt()
    *       | ALoadStmt()
    *       | AStoreStmt()
    *       | PassArgStmt()
    *       | CallStmt()
    */
   public String visit(Stmt n, String argu) {
	  String ans="";
     ans+="\t" + n.f0.accept(this, argu);
     return ans;
   }

   /**
    * f0 -> "NOOP"
    */
   public String visit(NoOpStmt n, String argu) {
      String ans="";
      ans+="nop\n";
      n.f0.accept(this, argu);
      return ans;
   }

   /**
    * f0 -> "ERROR"
    */
   public String visit(ErrorStmt n, String argu) {
      String ans="";
      ans+="b str_er\n";
      n.f0.accept(this, argu);
      return ans;
   }

   /**
    * f0 -> "CJUMP"
    * f1 -> Reg()
    * f2 -> Label()
    */
   public String visit(CJumpStmt n, String argu) {
      n.f0.accept(this, argu);
      String ans="beqz " + n.f1.accept(this, argu) + ", " + n.f2.accept(this, argu);
      
      return ans + "\n";
   }

   /**
    * f0 -> "JUMP"
    * f1 -> Label()
    */
   public String visit(JumpStmt n, String argu) {
      n.f0.accept(this, argu);
      String ans="b " ;
      ans+= n.f1.accept(this, argu) + "\n";

      return ans;
   }

   /**
    * f0 -> "HSTORE"
    * f1 -> Reg()
    * f2 -> IntegerLiteral()
    * f3 -> Reg()
    */
   public String visit(HStoreStmt n, String argu) {
      n.f0.accept(this, argu);
      String ans="sw ";
      ans += n.f3.accept(this, argu) + ", " ;
      ans += n.f2.accept(this, argu) + "(" ;
      ans += n.f1.accept(this, argu) + ")\n";
      return ans;
   }

   /**
    * f0 -> "HLOAD"
    * f1 -> Reg()
    * f2 -> Reg()
    * f3 -> IntegerLiteral()
    */
   public String visit(HLoadStmt n, String argu) {
      n.f0.accept(this, argu);
      String ans="lw ";
      ans += n.f1.accept(this, argu) + ", ";
      ans += n.f3.accept(this, argu) + "(" ;
      ans += n.f2.accept(this, argu) + ")\n";
      return ans;
   }

   /**
    * f0 -> "MOVE"
    * f1 -> Reg()
    * f2 -> Exp()
    */
   public String visit(MoveStmt n, String argu) {
      String ans="";
      n.f0.accept(this, argu);
      String s = n.f2.accept(this, argu);
      if(n.f2.f0.choice instanceof BinOp){
    	  ans = result + " ";
        ans += n.f1.accept(this, argu) + ", ";
        ans += arg1 + ", " + arg2 + "\n"; 
      }
      else if(n.f2.f0.choice instanceof HAllocate){
    	  ans = store;
        store="";
    	  ans += "\tmove " ;
         ans+= n.f1.accept(this, argu) + ", ";
         ans += s + "\n";
      }
      else{
        String temp= n.f1.accept(this, argu) + ", ";
        temp += s + "\n";
        String ret=find(expr);
    	  ans=ret+temp;
      }
      return ans;
   }

   /**
    * f0 -> "PRINT"
    * f1 -> SimpleExp()
    */
   public String visit(PrintStmt n, String argu) {
      n.f0.accept(this, argu);
      String ans= "move $a0, ";
      ans +=n.f1.accept(this, argu) + "\n";
      ans += "\tjal _print\n";
      return ans;
   }

   /**
    * f0 -> "ALOAD"
    * f1 -> Reg()
    * f2 -> SpilledArg()
    */
   public String visit(ALoadStmt n, String argu) {
      n.f0.accept(this, argu);
      String ans="lw ";
      ans +=n.f1.accept(this, argu) + ", ";
      int index = Integer.parseInt(n.f2.accept(this, argu));
      if(index < a-4)
    	  ans += Integer.toString(index*4) + "($fp)";
      else
    	  ans += Integer.toString((index-a+4)*-4 + -12) + "($fp)";
      return ans + "\n";
   }

   /**
    * f0 -> "ASTORE"
    * f1 -> SpilledArg()
    * f2 -> Reg()
    */
   public String visit(AStoreStmt n, String argu) {
      n.f0.accept(this, argu);
      String ans="sw ";
      ans +=  n.f2.accept(this, argu) + ", ";
      int index = Integer.parseInt(n.f1.accept(this, argu));
      if(index < a-4)
    	  ans += Integer.toString(index*4) + "($fp)";
      else
    	  ans += Integer.toString((index-a+4)*-4 + -12) + "($fp)";
      return ans + "\n";
   }

   /**
    * f0 -> "PASSARG"
    * f1 -> IntegerLiteral()
    * f2 -> Reg()
    */
   public String visit(PassArgStmt n, String argu) {
      n.f0.accept(this, argu);
      String ans="sw "; 
      ans+= n.f2.accept(this, argu) + ", ";
      n.f0.accept(this, argu);
      int index =  (Integer.parseInt(n.f1.accept(this, argu)) - 1)*4;
      ans += index + "($sp)\n";
      return ans;
   }

   /**
    * f0 -> "CALL"
    * f1 -> SimpleExp()
    */
   public String visit(CallStmt n, String argu) {
      n.f0.accept(this, argu);
      String ans="";
      if(expr == "Reg")
    	  ans = "jalr ";
      else
        ans ="jal ";
      String s = n.f1.accept(this, argu);
      ans += s + "\n";
    
      return ans;
   }

   /**
    * f0 -> HAllocate()
    *       | BinOp()
    *       | SimpleExp()
    */
   public String visit(Exp n, String argu) {
	   String ans= n.f0.accept(this, argu);
      return ans;
   }

   /**
    * f0 -> "HALLOCATE"
    * f1 -> SimpleExp()
    */
   public String visit(HAllocate n, String argu) {
       n.f0.accept(this, argu);
      String s = n.f1.accept(this, argu);
      if(expr == "IntegerLiteral"){
    	 store+="\tli $a0, " + s+"\n";
      }
      if(expr == "Reg"){
    	  store+="\tmove $a0, " + s+"\n";   
      }
      store+="\tjal _halloc\n";
      return "$v0 ";
   }

   /**
    * f0 -> Operator()
    * f1 -> Reg()
    * f2 -> SimpleExp()
    */
   public String visit(BinOp n, String argu) {
      result  = n.f0.accept(this, argu);
      arg1 	  = n.f1.accept(this, argu);
      arg2	  = n.f2.accept(this, argu);
      return "";
   }

   /**
    * f0 -> "LE"
    *       | "PLUS"
    *       | "NE"
    *       | "MINUS"
    *       | "TIMES"
    *       | "DIV"
  
    */
   public String visit(Operator n, String argu) {
      n.f0.accept(this, argu);
      
        String s=((NodeToken)n.f0.choice).tokenImage;
        String ans=operate(s);
        return ans;
    	  
     
   }

   /**
    * f0 -> "SPILLEDARG"
    * f1 -> IntegerLiteral()
    */
   public String visit(SpilledArg n, String argu) {
      n.f0.accept(this, argu);
      String ans= n.f1.accept(this, argu);
      return ans;
   }

   /**
    * f0 -> Reg()
    *       | IntegerLiteral()
    *       | Label()
    */
   public String visit(SimpleExp n, String argu) {
	   n.f0.accept(this, argu);
      if(n.f0.choice instanceof Reg)		
      			expr = "Reg";
	   else if(n.f0.choice instanceof IntegerLiteral)	
               expr = "IntegerLiteral";
	   else		
       			expr = "Label";
		   
	   return n.f0.accept(this, argu);
   }

   /**
    * f0 -> "a0"
    *       | "a1"
    *       | "a2"
    *       | "a3"
    *       | "t0"
    *       | "t1"
    *       | "t2"
    *       | "t3"
    *       | "t4"
    *       | "t5"
    *       | "t6"
    *       | "t7"
    *       | "s0"
    *       | "s1"
    *       | "s2"
    *       | "s3"
    *       | "s4"
    *       | "s5"
    *       | "s6"
    *       | "s7"
    *       | "t8"
    *       | "t9"
    *       | "v0"
    *       | "v1"
    */
   public String visit(Reg n, String argu) {
      n.f0.accept(this, argu);
      String ans="$" + ((NodeToken)n.f0.choice).tokenImage;
      return ans;
   }

   /**
    * f0 -> <INTEGER_LITERAL>
    */
   public String visit(IntegerLiteral n, String argu) {
      String ans=n.f0.accept(this, argu);
      return ans;
   }

   /**
    * f0 -> <IDENTIFIER>
    */
   public String visit(Label n, String argu) {
	   String ans=n.f0.accept(this, argu);
      return ans;
   }

  /**
    * f0 -> "//"
    * f1 -> SpillStatus()
    */
    public String visit(SpillInfo n, String argu) {
      String ans=null;
      n.f0.accept(this, argu);
      n.f1.accept(this, argu);
      return "";
   }

    /**
    * f0 -> <SPILLED>
    *       | <NOTSPILLED>
    */
   public String visit(SpillStatus n, String argu) {
      n.f0.accept(this, argu);
      return "";
   }

}
