Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAFCCEFCE1
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 17:40:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6F13402F1;
	Tue,  6 Jan 2026 18:40:47 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 3BAE0402DC
 for <dev@dpdk.org>; Tue,  6 Jan 2026 18:40:45 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlz3G1Rh1zJ46fZ;
 Wed,  7 Jan 2026 01:40:42 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 2095D40565;
 Wed,  7 Jan 2026 01:40:44 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 Jan 2026 18:40:43 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 6 Jan 2026 18:40:43 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v2 1/2] test: add a test for null PMD
Thread-Topic: [PATCH v2 1/2] test: add a test for null PMD
Thread-Index: AQHcfyxS/q65vRQ8j0u/gXKwX3Dx8bVFYaog
Date: Tue, 6 Jan 2026 17:40:43 +0000
Message-ID: <0e08cb939d1147c694b46c55c9668db2@huawei.com>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260106164815.158430-1-stephen@networkplumber.org>
 <20260106164815.158430-2-stephen@networkplumber.org>
In-Reply-To: <20260106164815.158430-2-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

> +/* Create random valid ethernet packets */
> +static int
> +test_mbuf_setup_burst(struct rte_mbuf **bufs, unsigned int burst_size)
> +{
> +	unsigned int i;
> +
> +	if (rte_pktmbuf_alloc_bulk(mp, bufs, burst_size) !=3D 0)
> +		return -1;
> +
> +	for (i =3D 0; i < burst_size; i++) {
> +		struct rte_mbuf *m =3D bufs[i];
> +		uint16_t len;
> +
> +		/* Choose random length between ether min and available space */
> +		len =3D rte_rand_max(rte_pktmbuf_tailroom(m) - RTE_ETHER_MIN_LEN)

Nit: could technically use rte_pktmbuf_tailroom(m) - RTE_ETHER_MIN_LEN + 1.

> +			+ RTE_ETHER_MIN_LEN;
> +		m->data_len =3D len;
> +		m->buf_len =3D len;

Not sure why we are changing buf_len here.

> +	}
> +	return 0;
> +}

Would still be cool to verify non-standard data_off.

// snip

> +/*
> + * Test: MAC address operations
> + */
> +static int
> +test_null_mac_addr(void)
> +{
> +	struct rte_ether_addr mac_addr;
> +	struct rte_ether_addr new_mac =3D {
> +		.addr_bytes =3D {0x00, 0x11, 0x22, 0x33, 0x44, 0x55}
> +	};
> +	int ret;
> +
> +	/* Get current MAC address */
> +	ret =3D rte_eth_macaddr_get(port_id, &mac_addr);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to get MAC address");
> +
> +	/* Set new MAC address */
> +	ret =3D rte_eth_dev_default_mac_addr_set(port_id, &new_mac);
> +	TEST_ASSERT(ret =3D=3D 0, "Failed to set MAC address");
> +

Still not checking that it actually does something.

> +	return TEST_SUCCESS;
> +}

I still wish the test was more behavior- and less implementation-based.
It almost feels like it works around existing bugs in the module now.
However I agree that no tests whatsoever is probably worse, therefore

Acked-by: Marat Khalili <marat.khalili@huawei.com>
