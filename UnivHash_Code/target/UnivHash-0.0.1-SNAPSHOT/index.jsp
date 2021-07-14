<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
table, th, td {
    border:1px solid black;
    border-style: thin;
    border-collapse: collapse;
}

.content {
    max-width: 500px;
    margin: auto;
    background: white;
    padding: 10px;
}

.buttoncontent {
    max-width: 300px;
    max-height: 250px;
    margin: auto;
    background: white;
    padding: 10px;
}
</style>
<script>	

$(document).ready(function(){
	$("#submitUnivHash").click(function() {
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
    
</script>
</head>
<body class="content">
<input type = "text" id = "bucket" placeholder="bucket" />
<input type = "text" id = "input" placeholder="input" />
<p></p>
<div class="buttoncontent">
<input type = "submit" value= "Get Universal Hash" id="submitUnivHash" /> 
</div>
<p></p>
<p></p>
<div id="tableDiv"></div>
</body>
</html>
