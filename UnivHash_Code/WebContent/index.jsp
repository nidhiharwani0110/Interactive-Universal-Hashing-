<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
div {
  word-wrap: break-word;
}

table, th, td {
    border:1px solid black;
    border-style: thin;
    border-collapse: collapse;
}

.content {
    margin: auto;
    background: white;
    padding: 10px;
}

.buttoncontent {
    margin: auto;
    background: white;
    padding: 10px;
}
#submitUnivHash{
	background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
}
</style>
<script>	

$(document).ready(function(){
	$("#submitUnivHash").click(function() {		
		$("#input_string").text($("#input").val());
		$.ajax({
			  method: "POST",
			  url: "univHash.html",
			  data: { bucket:$("#bucket").val(), input: $("#input").val()}
			})
			  .done(function( json ) { 
				var bucket_arr = json.split("],");
				var r = /\d+/g;
				var table_body = '<table border = \"1\">';	
				for (var i=0;i<$("#bucket").val(); i++)
					{
					table_body += "<th> Bucket "+(i+1)+" </th>";
					}
			    table_body+='<tr>';
			        for(var j=0;j<bucket_arr.length;j++){
			        			if(bucket_arr[j].match(r) != null)
			        				{
				 				var buckets = (bucket_arr[j].match(r));
				 				table_body +="<td id=\'"+j+"\'>"
				 				for(var i=0; i < buckets.length;i++)
				 					{
			                			table_body += "<label>"+buckets[i]+"</label><br />";
				 					}		
			        				
			                table_body +='</td>';
			        				}
			        			else
			        				{
			        				table_body += "<td>Empty</td>";
			        				}
			            }
			            table_body+='</tr>';
		            table_body+='</table>';
		           $('#tableDiv').html(table_body);     
			  });
		}); 
	
    });


function myFunction() {
	var rand_input = "";
	for(var i=0;i<100;i++)
		{
		rand_input = rand_input + ","+Math.round(Math.random() * 20) ;
		}
	rand_input = rand_input.substring(1, rand_input.length);
	$("#input").val(rand_input);
}

</script>
</head>
<body class="content">
<h1>Universal Hashing Algorithm</h1>
<font size="5"><p>In&nbsp;mathematics&nbsp;and&nbsp;computing,&nbsp;<strong>universal hashing</strong>&nbsp;(in a&nbsp;randomized algorithm&nbsp;or data structure) refers to selecting a&nbsp;hash function&nbsp;at random from a family of hash functions with a certain mathematical property (see definition below). This guarantees a low number of collisions in&nbsp;expectation, even if the data is chosen by an adversary. Many universal families are known (for hashing integers, vectors, strings), and their evaluation is often very efficient. Universal hashing has numerous uses in computer science, for example in implementations of&nbsp;hash tables,&nbsp;randomized algorithms, and&nbsp;cryptography.<br><br>Working of Universal Hashing Algorithm:<br>1. Let <strong>m</strong> be the number of buckets in the hash table.<br>2. Generate a random prime number <strong>p</strong> between <strong>m</strong> and <strong>2m.</strong><br>3. Generate two random numbers <strong>a</strong> and <strong>b</strong> between <strong>1</strong> and <strong>p.</strong><br>4. Generate a hash function <strong>((( a*x + b) % p ) % m)</strong> where <strong>x</strong> is the input integer.<br></p></font>
<input type = "text" id = "bucket" placeholder="Number of buckets" />
<input type = "text" id = "input" placeholder="Input integers" />
<button onclick="myFunction()">Generate random input</button>
<div>
<label id="input_string"></label>
</div>
<p></p>
<div class="buttoncontent">
<input type = "submit" value= "Get Universal Hash" id="submitUnivHash" /> 
</div>
<p></p>
<p></p>
<div id="tableDiv"></div>
</body>
</html>