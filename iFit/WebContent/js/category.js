function categoryItemHandler(e,category){
	console.log(category);	
	//이곳에서 productList를 호출하기 전에 ajax 통신으로 json형식의 dataType을 받아와 동적으로  product_list를 만들고 페이지 변경.
	$.mobile.changePage("#productList");
}


