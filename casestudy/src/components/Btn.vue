<script>
export default {
  name: "Button",
  props: {
    btnText: {
      type: String,
      default: "button",
    },
    btnClass: {
      type: String,
      default: "btn btn-sm btn-primary rounded-0",
    },
    btnLoading: {
      type: Boolean,
      default: false,
    },
  },
};
</script>

<template>
  <button :class="btnClass">
    {{ btnText }}
    <div v-if="btnLoading"
         class='spinner-border ms-2 my-auto'
         style='
		 border-top-width: 2px; 
		 border-bottom-width: 2px; 
		 border-left-width: 2px; 
		 width: 15px; height: 15px; 
		 color: inherit;
		 '>
    </div>
  </button>
</template>