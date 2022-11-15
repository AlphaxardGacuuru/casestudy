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
      message: "",
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
    // Delete Order
    onDelete(id) {
      axios
        .delete(`${this.url}/api/orders/${id}`)
        .then((res) => (this.message = res.data.message));
    },
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
      <h1>My Orders</h1>
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
        <tr v-for="(order, key) in orders"
            :key="key">
          <td>{{ order.id }}</td>
          <td>{{ order.product_id }}</td>
          <td>{{ order.quantity }}</td>
          <td v-if="order.fulfilled"
              class="text-success">Processed</td>
          <td v-else
              class="text-danger">Pending</td>
          <td>
            <!-- Edit Button -->
            <RouterLink v-if="!order.fulfilled"
                        :to="`/edit/${order.id}`"
                        class="btn btn-sm btn-warning rounded-0 ms-2">
              Edit
            </RouterLink>

            <!-- Delete Button -->
            <Btn v-if="!order.fulfilled"
                 btnClass="btn btn-sm btn-danger rounded-0 ms-2"
                 btnText="Delete"
                 :btnLoading="deleteBtnLoading == order.id"
                 @click="() => {
					orders.splice(key, 1)
				 	onDelete(order.id)
				 }" />
          </td>
        </tr>
      </tbody>
    </table>

    <center>
      <RouterLink to="/"
                  class="btn btn-lg btn-primary rounded-0">
        Go to Store
      </RouterLink>
    </center>
  </div>
</template>
