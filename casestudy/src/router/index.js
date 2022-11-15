import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes: [
		{
			path: '/',
			name: 'home',
			component: Home
		},
		{
			path: '/orders',
			name: 'orders',
			// route level code-splitting
			// this generates a separate chunk (About.[hash].js) for this route
			// which is lazy-loaded when the route is visited.
			component: () => import('../views/Orders.vue')
		},
		{
			path: '/edit/:id',
			name: 'edit',
			component: () => import('../views/Edit.vue')
		},
		{
			path: '/warehouse',
			name: 'warehouse',
			component: () => import('../views/Warehouse.vue')
		},
	]
})

export default router
