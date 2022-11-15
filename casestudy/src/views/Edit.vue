<script>
import axios from "axios";
import { RouterLink } from "vue-router";

import Btn from "../components/Btn.vue";

export default {
  components: { Btn },
  props: ["url"],
  data() {
    return {
      order: {},
      btnLoading: false,
	  message: ""
    };
  },
  methods: {
    // Fetch Orders
    getOrder() {
      axios
        .get(`${this.url}/api/orders/${this.$route.params.id}`)
        .then((res) => (this.order = res.data))
        .catch((err) => console.log(err));
    },
    // Simulate Dispatch
    onEdit() {
      // Show loader
      this.btnLoading = true;

      axios
        .put(`${this.url}/api/orders/${this.$route.params.id}`, {quantity: this.order.quantity})
        .then((res) => {
          // Remove loader
          this.btnLoading = false;
		  this.message = res.data.message
          this.getOrders();
        })
        .catch((err) => (this.btnLoading = false));
    },
  },
  mounted() {
    this.getOrder();
  },
};
</script>

<template>
  <div>
    <center>
      <p class="bg-success">{{ message }}</p>
      <h1>Edit Order {{ $route.params.id }}</h1>
      <br />
    </center>

    <form action="">
      <label for="">Quantity</label>
      <br />
      <br />

      <input type="number"
             name="quantity"
             class="form-control rounded-0"
             v-model="order.quantity">
      <br />

      <center>
        <Btn btnClass="btn btn-md btn-primary rounded-0"
             btnText="Edit"
			 :btnLoading="btnLoading"
             @click.prevent="onEdit" />
      </center>
    </form>
    <br />

    <center>
      <RouterLink to="/warehouse"
                  class="btn btn-lg btn-primary rounded-0">
        Go to Orders
      </RouterLink>
    </center>
  </div>
</template>
