package edu.binghamton.cs571;

import java.util.LinkedHashMap;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.LinkedList;

//TODO: Add comment specifying grammar for a grammar

public class GrammarStats {

  private final Scanner _scanner;
  private Token _lookahead;

 //TODO: add other fields as necessary
//Count of RuleSets, Terminals, Non-Terminals
public static int nRuleSets;
public static int nTerminals;
public static int nNonTerminals;
public MyLinkedList mll;
public MyNTList ntll;
  GrammarStats(String fileName) 
{
_scanner = new Scanner(fileName, PATTERNS_MAP);
    nextToken();

//Function prototype to initialize the Linked List for RuleSets and Tokens
linkinit(_lookahead.lexeme);
ntlinkinit(_lookahead.lexeme);
  }
//Function definition to initialize the linked lists MyLinkedList and MyNTList
public void linkinit(String lex)
	{
	mll=new MyLinkedList(lex);
	}


public void ntlinkinit(String lex)
	{
	ntll=new MyNTList(lex);
	}

  /** Recognize a grammar specification.  Return silently if ok, else
   *  signal an error.
   */
  Stats getStats() {
    Stats stats = null;
    try {
      //TODO: Call top-level parsing function, throw semantic errors,
      //create stats struct if everything ok.


//RuleSet() defines the number of Terminals, Non Terminals, RuleSets
RuleSet();


    }
    catch (GrammarParseException e) {
      System.err.println(e.getMessage());
    }
    return stats;
  }

  //TODO: add parsing functions


//Count of the Grammar Tokens will be calulated in this function.
//The linked list will be created and checked for duplicate rulesets
//Linked list will be created for checking the occurances of non-Terminals in case no rule set is specified for that Non Terminal

public void RuleSet()
{
	//Patterns to match the invalid tokens using regex
	final Pattern p1 = Pattern.compile("[a-z]\\w*");
	final Pattern p2 = Pattern.compile("[A-Z]\\w*");
	final Pattern p3 = Pattern.compile("\\d*");
	final Pattern p4 = Pattern.compile("^[a-zA-Z*$]");
	while(_lookahead.kind != TokenKind.EOF)
		{
		//Pattern Matching for Upper and Lower case strings
		if(p1.matcher(_lookahead.lexeme).find() == true && p2.matcher(_lookahead.lexeme).find() == true)
			{
			System.out.println(_lookahead.coords+" Invalid Grammar representation of token "+"'"+_lookahead.lexeme+"'");
			System.exit(0);
			}
		//Count for number of RuleSets
		if(_lookahead.kind == TokenKind.COLON)
			{
			nRuleSets+=1;
			}
		//Count for number of Terminals
		else if(_lookahead.kind == TokenKind.TERMINAL)
			{
			//condition for checking terminals
	
		        nTerminals+=1;
			}
		//Count for number of Non Terminals
		else if(_lookahead.kind == TokenKind.NON_TERMINAL)
		{
			if(_lookahead.kind != TokenKind.EOF)
				{
				ntll.addNT(_lookahead.lexeme);
				}
	        	nNonTerminals+=1;
		}


	nextToken();

	//Adding the Non terminals to the Linked list using add function
		if(_lookahead.kind == TokenKind.SEMI)
			{
			nextToken();

			if(_lookahead.kind != TokenKind.EOF)
				{
				mll.add(_lookahead.lexeme);	// Function to add
 				mll.check(_lookahead.lexeme);	//Function to check ruleset
			mll.checknonterminal();		//Function to check the nonterminals for valid grammar
				}

			}

		}

		ntll.NTcountcheck();  		//Function to check the rule set for valid grammar rule
mll.print();
ntll.print();
}




  //We extend RuntimeException since Java's checked exceptions are
  //very cumbersome
  private static class GrammarParseException extends RuntimeException {
    GrammarParseException(String message) {
      super(message);
    }
  }
  private void match(TokenKind kind) {
    if (kind != _lookahead.kind) {
      syntaxError();
    }

    if (kind != TokenKind.EOF) {
      nextToken();    
}
  }

  /** Skip to end of current line and then throw exception */
  private void syntaxError() {
    String message = String.format("%s: syntax error at '%s'",
                                   _lookahead.coords, _lookahead.lexeme);
    throw new GrammarParseException(message);
  }

  private static final boolean DO_TOKEN_TRACE = false;

  private void nextToken() {
    _lookahead = _scanner.nextToken();
    if (DO_TOKEN_TRACE) System.err.println("token: " + _lookahead);
  }

  /** token kinds for grammar tokens*/
  private static enum TokenKind {
    EOF,
    COLON,
    PIPE,
    SEMI,
    NON_TERMINAL,
    TERMINAL,
    ERROR,
  }

  /** Simple structure to collect grammar statistics */
  private static class Stats {
    final int nRuleSets;
    final int nNonTerminals;
    final int nTerminals;
    Stats(int nRuleSets, int nNonTerminals, int nTerminals) {
      this.nRuleSets = nRuleSets;
      this.nNonTerminals = nNonTerminals;
      this.nTerminals = nTerminals;
    }
    public String toString() {
      return String.format("%d %d %d", GrammarStats.nRuleSets, GrammarStats.nNonTerminals, GrammarStats.nTerminals);
    }
  }

  /** Map from regex to token-kind */
  private static final LinkedHashMap<String, Enum> PATTERNS_MAP =
    new LinkedHashMap<String, Enum>() {{
      put("", TokenKind.EOF);
      put("\\s+", null);           //ignore whitespace.
      put("\\//.*", null);         //ignore // comments
      put("\\:", TokenKind.COLON);
      put("\\|", TokenKind.PIPE);
      put("\\;", TokenKind.SEMI);
      put("[a-z]\\w*", TokenKind.NON_TERMINAL);
      put("[A-Z]\\w*", TokenKind.TERMINAL);
      put(".", TokenKind.ERROR);  //catch lexical error in parser
    }};


//Class Declaration for Non terminal Linked List
public class MyNTNode
{
	public String strlex;
	public int count;
	public MyNTNode next;

	public MyNTNode(String firsttoken)
		{
		strlex=firsttoken;
		next=null;
		}
}

public class MyNTList
{
	public MyNTNode head;
	public MyNTList(String nttoken)
	{
		head=new MyNTNode(nttoken);
	}

	//Add function for adding Non terminals
	public void addNT(String nextlex)
	{
		MyNTNode temp=head;
		while(temp.next != null)
		{
        		temp=temp.next;
		}
		temp.next=new MyNTNode(nextlex);
	}



	//comparing linked lists to find the non terminals without rule set
	public void NTcount(String nextlex)
	{
		MyNTNode trav=head;
		while(trav!= null)
		{
			if(trav.strlex.equals(nextlex))
			{
				trav.count=trav.count+1;
			}
		trav=trav.next;
		}
	}

	//check for the count of usage of the tokens in the Rule
	public void NTcountcheck()
	{
		MyNTNode trav=head;
		while(trav.next!=null)
		{
			if(trav.count == 0)
			{
				System.out.println("RuleSets not defined for the specified grammar"+trav.strlex+"\t"+trav.count);
				//System.exit(0);
			}
		trav=trav.next;
		}
		useNT();
	}
	//identifying the use of Nt in other sets
	public void useNT()
	{
		MyNTNode trav=head;
		while(trav.next!=null)
		{
			if(trav.count == 1)
			{
				System.out.println("Non Terminal defined but not used in the Right hand side"+trav.strlex+"\t"+trav.count);
				//System.exit(0);
			}
		trav=trav.next;
		}
	}


	//print the list
	public void print()
	{
		MyNTNode tmpNode = head;
		System.out.println("NON TERMINALS");
		while (tmpNode != null)
		{
			System.out.println(tmpNode.strlex);
			tmpNode=tmpNode.next;
		}
	}
}


//Class declaration for Rule Set linked list
	public class MyNode
	{
		public String strlex;
		public MyNode next;
		public int count;
		public MyNode(String firsttoken)
		{
			strlex=firsttoken;
			next=null;

		}
	}
	public class MyLinkedList
	{
	public MyNode head;
	public MyLinkedList(String ftoken)
	{
		head=new MyNode(ftoken);
	}


//Linked list checking for multiple rule set with same name
	public void check(String checklex)
	{
		MyNode trav=head;
		while(trav.next!= null)
		{
			if(trav.strlex.equals(checklex))
			{
        			System.out.println("Multiple rule set defined for the Non-Terminal "+"'"+trav.strlex+"'");
				System.exit(0);

			}
		trav=trav.next;
		}

	}
	//comparing non terminals for identifying the unused grammar
	public void checknonterminal()
	{
		MyNode trav=head;
		while(trav.next!=null)
		{
			ntll.NTcount(trav.strlex);
			trav=trav.next;
		}
	}


//Adding the ruleset to the linked list

	public void add(String nextlex)
	{
		MyNode temp=head;

		while(temp.next != null)
		{
        		temp=temp.next;
		}
		temp.next=new MyNode(nextlex);

	}

	//print the list
	public void print()
	{
		MyNode tmpNode = head;
		while (tmpNode != null)
		{
			System.out.println(tmpNode.strlex);
			tmpNode=tmpNode.next;
		}
	}
}





  private static final String USAGE =
    String.format("usage: java %s GRAMMAR_FILE",
                  GrammarStats.class.getName());

  /** Main program for testing */
  public static void main(String[] args) 
{

    if (args.length != 1) {
      System.err.println(USAGE);
      System.exit(1);
    }

    GrammarStats grammarStats = new GrammarStats(args[0]);
    Stats stats = grammarStats.getStats();

    if (stats != null) {
      System.out.println(stats);
	}


	//Printing the RuleSets , Non-Terminals, Terminals count which has been calulated in RuleSet();
	System.out.println(GrammarStats.nRuleSets+"\t"+ GrammarStats.nNonTerminals+"\t"+ GrammarStats.nTerminals);
  }

}
