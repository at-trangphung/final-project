function load_steps_checkout(id_tab) {
  for (let i = 1; i <= 5; i++){
    var div_show  = document.getElementById('step-'+i);
    var order_show  = document.getElementById('order-step-'+i);
    if (i === id_tab) {
    	order_show.classList.add('active');
      div_show.style.display = 'block';
      if (id_tab === 2) {
        var checkbox = document.getElementById('checkbox-form');
        for (let i = 1; i <= 7; i++) {
          var object_address  = document.getElementById('object_address_'+i);
          var object_billing  = document.getElementById('object_billing_'+i);
          if (checkbox.checked == true) {
            object_billing.value = object_address.value;
          }
        }
      }
      if (id_tab === 3) {
        delivery_time();
      }
    } else {
    	order_show.classList.remove('active');
      div_show.style.display = 'none';
    }
  }
}

function load_option_payment(id_tab) {
  for (let i = 1; i <= 3; i++){
    var option_show  = document.getElementById('payment-option-'+i);
    if (i === id_tab) {
      option_show.style.display = 'block';
    } else {
      option_show.style.display = 'none';
    }
  }
}

function delivery_time() {
  var delivery_time = document.getElementById('later');
  var minutes_show = document.getElementById('id-minutes');
  var hours_show = document.getElementById('id-hours');
  if (delivery_time.selected == true) {
    minutes_show.style.display = 'block';
    hours_show.style.display = 'block';
      } else {
    minutes_show.style.display = 'none';
    hours_show.style.display = 'none';
  }
}

function cb_payment() {
  var btn_payment = document.getElementById('btn_payment');
  var cb_payment = document.getElementById('cb_payment');

  if (cb_payment.checked === true) {
    btn_payment.disabled = false;
  } else {
    btn_payment.disabled = true;
  }

}

function terms_conditions() {
  window.open("http://localhost:3000/terms_conditions");
}
