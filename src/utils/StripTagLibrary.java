package utils;



public class StripTagLibrary {
	
	public static String escapeMarkup(final String s, final boolean escapeSpaces,
		    final boolean convertToHtmlUnicodeEscapes)
		{
		    if (s == null)
		    {
		        return null;
		    }
		    else
		    {
		        int len = s.length();
		        final StringBuffer buffer = new StringBuffer((int)(len * 1.1));

		        for (int i = 0; i < len; i++)
		        {
		            final char c = s.charAt(i);

		            switch (c)
		            {
		                case '\t' :
		                    if (escapeSpaces)
		                    {
		                        // Assumption is four space tabs (sorry, but that's
		                        // just how it is!)
		                        buffer.append("&nbsp;&nbsp;&nbsp;&nbsp;");
		                    }
		                    else
		                    {
		                        buffer.append(c);
		                    }
		                    break;

		                case ' ' :
		                    if (escapeSpaces)
		                    {
		                        buffer.append("&nbsp;");
		                    }
		                    else
		                    {
		                        buffer.append(c);
		                    }
		                    break;

		                case '<' :
		                    buffer.append("&lt;");
		                    break;

		                case '>' :
		                    buffer.append("&gt;");
		                    break;

		                case '&' :
                            if(s.charAt(i+1)==' ') {
		                    buffer.append("&amp;");
                            }
		                    break;

		                case '"' :
		                    buffer.append("&quot;");
		                    break;

		                case '\'' :
		                    buffer.append("&#039;");
		                    break;
		              
		                
		                case '?' :
		                    buffer.append("&#63;");
		                    break;
		                default :

		                    if (convertToHtmlUnicodeEscapes)
		                    {
		                        int ci = 0xffff & c;
		                        if (ci < 160)
		                        {
		                            // nothing special only 7 Bit
		                            buffer.append(c);
		                        }
		                        else
		                        {
		                            // Not 7 Bit use the unicode system
		                            buffer.append("&#");
		                            buffer.append(new Integer(ci).toString());
		                            buffer.append(';');
		                        }
		                    }
		                    else
		                    {
		                        buffer.append(c);
		                    }

		                    break;
		            }
		        }

		        return buffer.toString();
		    }
		}
	}
