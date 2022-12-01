import React, { useState, useEffect } from "react";
import Paper from "@mui/material/Paper";
import CardActions from "@mui/material/CardActions";
import CardContent from "@mui/material/CardContent";
import Chip from "@mui/material/Chip";
import Typography from "@mui/material/Typography";
import PaidOutlinedIcon from "@mui/icons-material/PaidOutlined";
import Button from "@mui/material/Button";
import ButtonGroup from "@mui/material/ButtonGroup";
import Card from "@mui/material/Card";
import { useRouter } from "next/router";

import { getProducts, createOrder } from "../apis/index";
import { getUser } from "../utils/storage";

const styles = {
	background: {
		height: "80vh",
		width: "100%",
		overflowY: "scroll",
		background: "transparent",
	},
	button: {
		width: "100%",
		marginTop: 3,
		color: "#FFFFFF",
		backgroundImage: "linear-gradient(to right, #DD5E89 0%, #DD5E89 100%)",
		fontWeight: 700,
	},
	card: {
		marginBottom: "5px",
	},
	priceTag: {
		float: "right",
	},
};

const Products = () => {
	const router = useRouter();
	const [products, setProducts] = useState([]);
	const [purchases, setPurchases] = useState([]);

	const getProductsList = async () => {
		try {
			const productData = await getProducts();
			if (productData.status === 200) {
				setProducts(productData.data);
			}
		} catch (error) {
			console.log(error);
		}
	};

	useEffect(() => {
		getProductsList();
		return () => {
			setProducts([]);
		};
	}, []);

	const purchasesCount = (productId) => {
		if (purchases.length) {
			let purchase = purchases.filter((item) => item.id === productId);
			return purchase.length;
		} else {
			return 0;
		}
	};

	const addItem = (product) => {
		if (purchases.length) {
			setPurchases([...purchases, product]);
		} else {
			setPurchases([product]);
		}
	};
	const removeItem = (product) => {
		if (purchases.length) {
			const removeByAttr = (arr, attr, value) => {
				let i = arr.length;
				while (i--) {
					if (
						arr[i] &&
						arr[i].hasOwnProperty(attr) &&
						arguments.length > 2 &&
						arr[i][attr] === value
					) {
						arr.splice(i, 1);
						return arr;
					}
				}
				return arr;
			};
			const filterPurchases = removeByAttr(purchases, "id", product.id);
			setPurchases([...filterPurchases]);
		}
	};

	const orderNow = async () => {
		try {
			const customer = getUser();
			let order = {
				customer_id: customer.id,
				products: [],
			};
			console.log(JSON.stringify(purchases));
			let purchasesCount = {};
			purchases.map((item) => {
				if (purchasesCount.hasOwnProperty(item.id)) {
					purchasesCount[item.id] += 1;
				} else {
					purchasesCount[item.id] = 1;
				}
			});

			order.products = Object.entries(purchasesCount).map(([k, v]) => ({
				id: k,
				quantity: v,
			}));
			console.log(order);
			const orderRes = await createOrder(order);
			console.log(orderRes);
			if (orderRes.status === 200) {
				router.push(`/orders/${orderRes.data.id}`);
			} else {
				alert(order?.error?.message || "Something went wrong!!");
			}
		} catch (error) {
			console.log(error);
		}
	};

	return (
		<>
			<Paper sx={styles.background}>
				{products.map((product) => (
					<Card key={product.id} sx={styles.card}>
						<CardContent>
							<Typography gutterBottom variant="h5" component="div">
								{product.title}
								<Chip
									sx={styles.priceTag}
									label={product.price}
									color="info"
									size="small"
									icon={<PaidOutlinedIcon />}
								/>
							</Typography>
							<Typography variant="body2" color="text.secondary">
								{product.description}
							</Typography>
						</CardContent>
						<CardActions>
							<ButtonGroup
								size="small"
								variant="contained"
								aria-label="outlined primary button group"
							>
								<Button onClick={() => removeItem(product)}>-</Button>
								<Button disabled>{purchasesCount(product.id)}</Button>
								<Button onClick={() => addItem(product)}>+</Button>
							</ButtonGroup>
						</CardActions>
					</Card>
				))}
			</Paper>
			<Button
				disabled={purchases.length === 0 || false}
				sx={styles.button}
				onClick={orderNow}
			>
				Order Now
			</Button>
		</>
	);
};

export default Products;
