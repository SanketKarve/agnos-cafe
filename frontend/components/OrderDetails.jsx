import React, { useState, useEffect } from "react";
import { useRouter } from "next/router";
import Paper from "@mui/material/Paper";
import Typography from "@mui/material/Typography";
import Table from "@mui/material/Table";
import TableBody from "@mui/material/TableBody";
import TableCell from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TableHead from "@mui/material/TableHead";
import TableRow from "@mui/material/TableRow";
import { Button } from "@mui/material";

import { getOrder, createPayment } from "../apis/index";

const styles = {
	paper: {
		textAlign: "center",
		paddingTop: 5,
		paddingBottom: 5,
	},
	button: {
		width: "100%",
		marginTop: 3,
		color: "#FFFFFF",
		backgroundImage: "linear-gradient(to right, #DD5E89 0%, #DD5E89 100%)",
		fontWeight: 700,
	},
};

const paymentStatusList = {
	PENDING: "pending",
	SUCCESS: "success",
};

const OrderDetails = () => {
	const router = useRouter();
	const [order, setOrder] = useState(null);
	const [paymentStatus, setPaymentStatus] = useState(paymentStatusList.PENDING);
	const [transactionId, setTransactionId] = useState(null);

	const getOrderDetails = async (id) => {
		const orderRes = await getOrder(id);
		if (orderRes.status === 200) {
			setOrder(orderRes.data);
		}
		try {
		} catch (error) {}
	};

	useEffect(() => {
		if (router?.query?.id) {
			getOrderDetails(router.query.id);
		}

		return () => {
			setOrder(null);
		};
	}, [router.query]);

	if (!order) {
		return null;
	}

	const handlePayment = async () => {
		try {
			console.log("Make payment");
			const paymentRes = await createPayment({ order_id: order.id });
			if (paymentRes.status === 200) {
				setPaymentStatus(paymentStatusList.SUCCESS);
				setTransactionId(paymentRes.data.transaction_id);
			} else {
				alert(paymentRes.error.message || "Something went wrong");
			}
		} catch (error) {
			console.log(error);
		}
	};

	if (paymentStatus === paymentStatusList.SUCCESS) {
		return (
			<>
				<Paper sx={styles.paper}>
					<Typography variant="h3">Thank you for ordering with us!!</Typography>
					<Typography variant="h5">
						Your payment transaction id : <b>{transactionId}</b>
					</Typography>
					<Typography variant="h5">
						Your order will shortly be prepared
					</Typography>
				</Paper>
				<Button sx={styles.button} onClick={() => router.push("/products")}>
					Order Again
				</Button>
			</>
		);
	}

	return (
		<>
			<Paper sx={styles.paper}>
				<Typography>Order Details</Typography>

				<TableContainer component={Paper}>
					<Table sx={{ minWidth: 700 }} aria-label="spanning table">
						<TableHead>
							<TableRow>
								<TableCell align="center" colSpan={3}>
									Details
								</TableCell>
								<TableCell align="right">Price</TableCell>
							</TableRow>
							<TableRow>
								<TableCell>Desc</TableCell>
								<TableCell align="right">Qty.</TableCell>
								<TableCell align="right">Price</TableCell>
								<TableCell align="right">Sum</TableCell>
							</TableRow>
						</TableHead>
						<TableBody>
							{order.purchases.map((purchase) => (
								<TableRow key={purchase.id}>
									<TableCell>{purchase.product.title}</TableCell>
									<TableCell align="right">{purchase.quantity}</TableCell>
									<TableCell align="right">{purchase.product.price}</TableCell>
									<TableCell align="right">
										{purchase.quantity * purchase.product.price}
									</TableCell>
								</TableRow>
							))}
							<TableRow>
								<TableCell rowSpan={3} />
								<TableCell colSpan={2}>Subtotal</TableCell>
								<TableCell align="right">{order.total_price}</TableCell>
							</TableRow>
							<TableRow>
								<TableCell>Tax</TableCell>
								<TableCell></TableCell>
								<TableCell align="right">{order.tax_price}</TableCell>
							</TableRow>
							<TableRow>
								<TableCell colSpan={2}>Total</TableCell>
								<TableCell align="right">{order.net_price}</TableCell>
							</TableRow>
						</TableBody>
					</Table>
				</TableContainer>
			</Paper>
			<Button sx={styles.button} onClick={handlePayment}>
				Make Payment
			</Button>
		</>
	);
};

export default OrderDetails;
