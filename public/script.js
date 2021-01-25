const token = "ya29.c.Kp0B7wc-lzlpUGMmvh4Vs-GM6SKwQ3pAbDu0ayxBrg_1CYdLPvfm3vmLuTRA_sPzLOEkV1CfWLBjJ2sBpP_9o5eAoFuCS7C2mOzpp9f6VaK9OHG_XLKtf1WKURjbCOVhR_tzzvEepVBGFV-OgGkidvmuKr60QviZ64g4tgG8o1tskq81SgSYwwJ8p7a87XLgXHTsIWQ3Reuj7hkLwT39SA";

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
	const select = document.querySelector('#file-select');
	bigJoe.items.forEach(item => {
		const entry = item.id.split('/')[1];
		var option = document.createElement('option');
		option.value = entry;
		option.textContent = `${entry}`;
		select.appendChild(option);
	});
});
