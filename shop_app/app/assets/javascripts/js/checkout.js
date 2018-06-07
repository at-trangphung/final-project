function load_steps_checkout(id_tab) {
  for (let i = 1; i <= 5; i++){
    var div_show  = document.getElementById("step-"+i);
    var btn_show  = document.getElementById("btn-step-"+i);
    var order_show  = document.getElementById("order-step-"+i);
    if (i === id_tab) {
    	order_show.classList.add("active");
      div_show.style.display = "block";
      btn_show.style.display = "block";
    } else {
    	order_show.classList.remove("active");
      div_show.style.display = "none";
      btn_show.style.display = "none";
    }
  }
}
