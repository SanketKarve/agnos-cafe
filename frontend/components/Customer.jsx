import React, { useState } from "react";
import { Paper, Button, Grid, TextField, Typography, Box } from "@mui/material";
import { useRouter } from "next/router";

import { createCustomer } from "../apis";
import { storeUser } from "../utils/storage";

const styles = {
	background: {
		height: "100%",
	},
	coffeeImg: {
		width: "100%",
		height: "auto",
		maxHight: "400px",
		maxWidth: "400px",
		float: "right",
	},
	welcomeText: {
		textAlign: "center",
	},
	agnosCafeText: {
		fontWeight: 700,
		textAlign: "center",
	},
	form: {
		margin: "10%",
		marginTop: "15%",
	},
	textField: {
		marginBottom: "10px",
	},
	button: {
		backgroundImage:
			"linear-gradient(to right, #DD5E89 0%, #F7BB97 51%, #DD5E89 100%)",
		fontWeight: 700,
	},
};

const Customer = () => {
	const router = useRouter();
	const [name, setName] = useState("");
	const [phoneNumber, setPhoneNumber] = useState("");

	const handleFormSubmit = async (e) => {
		try {
			e.preventDefault();
			if (name.length > 0 && phoneNumber.length > 0) {
				const customer = await createCustomer({
					name,
					phone_number: phoneNumber,
				});
				if (customer.status === 200) {
					storeUser(customer.data);
					router.push("/products");
				}
			}
		} catch (error) {
			console.log(error);
		}
	};

	return (
		<Paper sx={styles.background}>
			<Grid container spacing={2}>
				<Grid item xs={12} md={6}>
					<Box sx={{ display: { xs: "block", md: "none" } }}>
						<Typography sx={styles.welcomeText} variant="h5" gutterBottom>
							Welcome to
						</Typography>
						<Typography sx={styles.agnosCafeText} variant="h3" gutterBottom>
							AGNOS CAFE
						</Typography>
					</Box>
					<form style={styles.form} onSubmit={handleFormSubmit}>
						<TextField
							sx={styles.textField}
							variant="standard"
							fullWidth
							label="Name"
							name="name"
							required
							value={name}
							onChange={(e) => setName(e.target.value)}
						/>
						<TextField
							sx={styles.textField}
							variant="standard"
							fullWidth
							label="Phone Number"
							name="phoneNumber"
							required
							value={phoneNumber}
							onChange={(e) => setPhoneNumber(e.target.value)}
						/>
						<Button
							sx={styles.button}
							variant="contained"
							fullWidth
							type="submit"
						>
							Submit
						</Button>
					</form>
				</Grid>
				<Grid item xs={12} md={6}>
					<Box sx={{ display: { xs: "none", md: "block" } }}>
						<Typography sx={styles.welcomeText} variant="h5" gutterBottom>
							Welcome to
						</Typography>
						<Typography sx={styles.agnosCafeText} variant="h3" gutterBottom>
							AGNOS CAFE
						</Typography>
						<img src="/assets/coffee.png" style={styles.coffeeImg} />
					</Box>
				</Grid>
			</Grid>
		</Paper>
	);
};
export default Customer;
