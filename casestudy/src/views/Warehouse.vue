<script>
import axios from "axios";
import { RouterLink } from "vue-router";

import Btn from "../components/Btn.vue";

export default {
  components: { Btn },
  props: ["url"],
  data() {
    return {
      orders: [],
      dispatchBtnLoading: false,
	  message: ""
    };
  },
  methods: {
    // Fetch Orders
    getOrders() {
      axios
        .get(`${this.url}/api/orders`)
        .then((res) => (this.orders = res.data))
        .catch((err) => console.log(err));
    },
    // Simulate Dispatch
    onDispatch(id) {
      // Show loader
      this.dispatchBtnLoading = id;

      axios
        .put(`${this.url}/api/orders/${id}`)
        .then((res) => {
          // Remove loader
          this.dispatchBtnLoading = false;
		  this.message = res.data.message
          this.getOrders();
        })
        .catch((err) => (this.dispatchBtnLoading = false));
    },
  },
  computed: {
	unfulfilledOrders() {
		return this.orders.filter((order) => !order.fulfilled)
	}
  },
  mounted() {
    this.getOrders();
  },
};
</script>

<template>
  <div>
    <center>
      <p class="bg-success">{{ message }}</p>
      <h1>Orders</h1>
      <br />
    </center>

    <table class="table table-dark table-responsive">
      <thead>
        <tr>
          <th>Order ID</th>
          <th>Product ID</th>
          <th>Quantity</th>
          <th>Status</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(order, key) in unfulfilledOrders"
            :key="key">
          <td>{{ order.id }}</td>
          <td>{{ order.product_id }}</td>
          <td>{{ order.quantity }}</td>
          <td>{{ order.fulfilled }}</td>
          <td>
            <!-- Dispatch Button -->
            <Btn btnText="Dispatch"
                 :btnLoading="dispatchBtnLoading == order.id"
                 @click="onDispatch(order.id)" />
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
