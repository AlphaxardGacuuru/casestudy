<script>
import axios from "axios";
import { RouterLink } from "vue-router";

import Btn from "../components/Btn.vue";

export default {
  components: { Btn },
  props: ["url"],
  data() {
    return {
      products: [],
      btnLoading: false,
      message: "",
    };
  },
  methods: {
    getProducts() {
      axios
        .get(`${this.url}/api/products`)
        .then((res) => (this.products = res.data))
        .catch((err) => console.log(err));
    },
    // Simulate sale
    sell(id) {
      // Show loader
      this.btnLoading = id;

      axios
        .put(`${this.url}/api/products/${id}`)
        .then((res) => {
          this.btnLoading = false;
          this.message = res.data.message;
          this.getProducts();
        })
        .catch((err) => {
          this.btnLoading = false;
        });
    },
  },
  mounted() {
    this.getProducts();
  },
};
</script>

<template>
  <div>
    <center>
      <p class="bg-success">{{ message }}</p>
      <h1>Products</h1>
      <br />
    </center>

    <table class="table table-dark table-responsive">
      <thead>
        <tr>
          <th>Product Name</th>
          <th>Outstanding Inventory</th>
          <th>Fulfilled Orders</th>
          <th>Order Number</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(product, key) in products"
            :key="key">
          <td>{{ product.name }}</td>
          <td>{{ product.inventory }}</td>
          <td>{{ product.reorder }}</td>
          <td v-if="product.order_number">{{ product.order_number }}</td>
          <td v-else>N/A</td>
          <td>
            <Btn v-if="product.inventory > 0"
                 btnText="Sell"
                 :btnLoading="btnLoading == product.id"
                 @click="sell(product.id)" />
          </td>
        </tr>
      </tbody>
    </table>

    <center>
      <RouterLink to="/orders"
                  class="btn btn-lg btn-primary rounded-0">
        Go to My Orders
      </RouterLink>
    </center>
  </div>
</template>
