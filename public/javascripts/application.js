// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function switch_values(code){
	var site_values = sites[code];
	var htm = "";
	jQuery("#search_site").html('');
	
	for(var i=0; i < site_values.length; i++){
		htm += "<option value='" ;
		htm += site_values[i][1] + "'>"; 
		htm += site_values[i][0]; 
		htm += "</option>";
	}
	
	jQuery("#search_site").html(htm);
}

function setCategories(){
	var values = "";
	
	jQuery(".category_box:checked").each(function(){
		values += jQuery(this).val() + ",";
	});
	
	values = values.slice(0, values.length-1);
	
	jQuery("#category").val(values);
}

function showLoader(){
  jQuery("#search_loader").show();
	jQuery("#search_button").hide();
}

function hideLoader(){
  jQuery("#search_loader").hide();
	jQuery("#search_button").show();
}

jQuery(document).ready(function(){
	
	jQuery("#coda-slider-1").codaSlider({
		dynamicArrows: false,
		dynamicTabs: false
	});
	jQuery("#search_category").val("main");
	jQuery("#search_site").val("google");
	jQuery("#search_query").val("Search for...");
	
	jQuery("#search_category").change(function(){
		//switch_values(jQuery(this).val());
	});
	
	jQuery("#search_query").bind('click',function(){
		var txt = jQuery("#search_query");
		
		if(txt.val() == "Search for..."){
			txt.val('');
			txt.attr("style", "color: black;")
		}
	});

	jQuery("#search_query").bind('blur',function(){
		var txt = jQuery("#search_query");
		
		if(txt.val() == ""){
			txt.val('Search for...');
			txt.attr("style", "color: #D3D3D3;");
		}
	});
	
	jQuery("#check_all_option").click(function(){
		jQuery(".category_box").attr("checked",true);
		setCategories();
	});	
	
	jQuery("#clear_all_option").click(function(){
		var txt = jQuery("#search_query");
		jQuery(".category_box").attr("checked",false);
		jQuery("#category").val('');
    txt.val('Search for...');
    txt.attr("style", "color: #D3D3D3;");
	});
	
	jQuery(".categ_name").click(function(){
		var cbox = jQuery(this).siblings("input");
		if(cbox.attr("checked")){
			cbox.attr("checked", false);
		}
		else{
			cbox.attr("checked", true);
		}
		setCategories();
	});
	
	jQuery(".category_box").attr("checked", false);
	
	jQuery(".category_box").change(function(){
		setCategories();

	});
});