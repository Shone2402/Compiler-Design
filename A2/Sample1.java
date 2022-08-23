class Sample1{
    public static void main(String[] a){
        System.out.println(new A().add3(1,new B().add2(1,2),3));
    }
}

class X
{
  protected int one()
  {
   return 0;
  }
}

class Y extends X
{
  protected int two()
  {
   return 1;
  }
}

class Z extends Y
{
  public int three()
  {
    Z a;
    int x;
    int y;
    int k;
    x=a.one();
    y=a.two();
    k=x+y;
    return k;
  }

}



class A
{
  public int add3(int x,int y,int z)
  {
    int c;
    c=x+y;
    c=c+z;
    return c;
  }

}

class B
{
  public int add2(int w,int z)
  {
    int c;
    int[] num1;
    int[] num2;
    boolean useless;
    A tp;
    
    int len;
    tp=new A();
    useless=true;
    num1 = new int[5];
    num2 = new int[5];
    num2[0]=1;
    num1[0]=2;
    num1[num2[0]]=num1[0];
    len=num1.length;
    if(useless)
     {System.out.println(num2[0]);}
    else
     num2[0]=num1[2];
    c=w+z;
    return c;
    
    
  }

}


