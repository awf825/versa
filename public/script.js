const token = "reinsert ACCESS_TOKEN";

async function fetchBucketJSON() {
	const response =  await fetch("https://storage.googleapis.com/storage/v1/b/versa_audio/o", {
						headers: {
							"Authorization": `Bearer ${token}`,
							//"Cache-Control": "no-transform"
						}
					  });
	const payload = await response.json();
	return payload;
};

fetchBucketJSON().then(bigJoe => {
	console.log(bigJoe);
	//debugger
	const select = document.querySelector('#file-select');
	bigJoe.items.forEach(item => {
		const entry = item.id.split('/')[1];
		var option = document.createElement('option');
		option.value = entry;
		option.textContent = `${entry}`;
		// option.innerText = entry;
		select.appendChild(option);
	});
});
