export const storeUser = (data) => {
	localStorage.setItem("User", JSON.stringify(data));
};

export const getUser = () => {
	const user = localStorage.getItem("User");
	if (user === null) {
		return null;
	} else {
		return JSON.parse(user);
	}
};
