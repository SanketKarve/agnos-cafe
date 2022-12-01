import axios from "axios";

const instance = axios.create({
	baseURL: `${process.env.NEXT_PUBLIC_BASE_URL}/api/v1`,
	timeout: 1000,
	headers: {
		"Access-Control-Allow-Origin": "*",
		"Content-Type": "application/json",
	},
});

export const createCustomer = (data) => {
	return instance.post("/customers", data);
};

export const getProducts = () => {
	return instance.get("/products");
};

export const createOrder = (data) => {
	return instance.post("/orders", data);
};

export const getOrder = (id) => {
	return instance.get(`/orders/${id}`);
};

export const createPayment = (data) => {
	return instance.post(`/payments`, data);
};
