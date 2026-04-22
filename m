Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ADBF9B607
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 10:18:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94FB34042C;
	Wed, 22 Apr 2026 12:18:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id E75BD402E0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 12:18:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776853107; x=1808389107;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cv3Pm10R8s/NMOXJpw0jfHOYRDFjC+dA5z3lqy12L6A=;
 b=cC43K3CC1CIny7dDTx8vU/SkZPr0CoS7/Z3Ay5S5+RDi1Qs+738J95VL
 jZg2kazWRpQ3a3rHzgl2ll7JRvdu2ah1Es8EZStkVs1Mcy6HGAy2AOgKV
 Vpg1SGlNDW3g1DzPQgqm8UUqMm2fsf4sLTj/CRO277Ekn8NwPLU2TRyk+
 K/wPVXB8HSfU3DkdpuW4X1cWzwop7e/w9jAQBE+gYxOTNU0aVJgUgYtVf
 NSTThUoLfNL0nOZaiusvykZCo7yExY1pMJT37oNbM12tY50mGXBRWnn3y
 /mI5oipp06tWbCBlJdhA3zpCAs5tHjbIvjkhIK4RZ6se4yHC+zlcUBZmk w==;
X-CSE-ConnectionGUID: 8GCIXUdeSMOfjYCeKGaGng==
X-CSE-MsgGUID: uRx1CleGTbeVWHghylh66Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="100455900"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="100455900"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 03:18:26 -0700
X-CSE-ConnectionGUID: ynXBeIhbQjmt9wsAAWvQug==
X-CSE-MsgGUID: kqeoE6tSQ3SnkQff0Cia4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="227736076"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 03:18:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 03:18:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 03:18:25 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 03:18:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uqo4tqxfGLUpYw7aN2BbMLKEVUULu6hxf7/j7HhH7GvRMRTSdE3vLrZ787K8BImroNTsqayE9TzdSMB0RRUtNTCT7RXQ1Jwi+7CGB/NUJWPqZK8wndLuH8RnJDjwt5NTBcybAESjSJG4DYyafhA1myP4DBfSAZ4LDScgZf0IjElTvuO9GWrt/jakqhJa58rdssTa9nmgLelxUjxPVGWxU60ovthCVBdUPgAmZNk2sU9fx/+/jojsCRrJOOG/2h7QsPmn7hVec58CzWEeh5QVViOEgkcg4/rH/0iCCyNd3QCDjlWA9aloEVRLSo5c9fOpajVVpExO7EyrwTiiJ0pxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3TIvaKUjyfCv+CZwIcsGgkPNcyOhAVTiPiwB2bRtH8=;
 b=GPVPpPOTKm7V7SjlnXLVv4FWLTLdDD3gjKWNo8tWA0RJNtcsRLJR/pQoTGVx0OhYUH3AWwzH80u5/8BvFaakEIoD07cMYGmKxkcETka11tsaIsZ6EirK8LlhaNnHIfBEAWIV+5baoIPqqM4GS3wLDF82kFufELJeOIxbtu481wte6N6J0aEoZERYvRsPJJZyLBrzeOFhNSVKvl4cW0gi1BHDc8gAssKXZCWd78XHtFmj3lwdwvrap1tskhFbp88IsWzSJrgTrYVG/LWHq+xO1YgaZBGvNFQl63zt1v3g7s+I1WTufk4GSoL/nfBaLuS/cIfFh11GunovTrsuLt4hlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by IA0PR11MB7861.namprd11.prod.outlook.com
 (2603:10b6:208:3de::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Wed, 22 Apr
 2026 10:18:09 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::d99e:14f5:fdbb:f2d]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::d99e:14f5:fdbb:f2d%6]) with mapi id 15.20.9846.012; Wed, 22 Apr 2026
 10:18:09 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH] test/event_eth_rx_intr_adapter: support NICs with fewer
 int vectors
Thread-Topic: [PATCH] test/event_eth_rx_intr_adapter: support NICs with fewer
 int vectors
Thread-Index: AQHcvSOd5emcF9GK7ku3VitGxaIBB7XrCCkA
Date: Wed, 22 Apr 2026 10:18:09 +0000
Message-ID: <DM3PPF7D18F34A115BCA37E02527DC8C08B8E2D2@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20260326132142.565979-2-bruce.richardson@intel.com>
In-Reply-To: <20260326132142.565979-2-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|IA0PR11MB7861:EE_
x-ms-office365-filtering-correlation-id: 339256e2-cd78-44e4-da6d-08dea05873dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: fXdw5FvmBl67QiRkZKs+bOxwKThZCWWm56LmLM2nXjklOiH/LPd3sFlrkXbiD2ZcipZnGnvHigdzEzH2bMyhXyxIiD9D9WVZzsqmRGCMLu6rhO8TcAq3ubcknID7Y2hwgiWDAEL1Gz4plOH8nu6DeGQV2UB4Gccy9qC9wpz5MaOr/qj31x0BspdiNJj1fAVYongQ48g0gc5ZKfG2m7hvb4wXJXiG7w1y1lyiz8wwAypw8Uo7PPbwgehMs55z1gnE4sgIUrhdRDA7nnnihOAeaZNgq5KGlpbagGMNifJGPR3B2Q71DaF+hJFDB43RI1kfL/Qwl5Ao4g7RR6Cjo2m/Ik4nBT4AHHJd8iHqqx30jBrwqP2atfq4pYmTgl0b5wtNwzxymT9mKbvHm3YzrJWxzG33UX/hzRLQILcAkd08Wvr7vAITtvVMcozWO6P67rkXyFUpbbL0DfH3TIzt8JEykTdmdZA7bnqPSclnjOFxSQyeGnbhBN3VgBtfx/DuGRfcYFJ7xX3G6cT2LdaCxDvgz2y8kuEvIzGzVUl39SSVHWXUz6i8B29fxwf2ZDdavrp17seEEzR3dNSp7VuO1hVbkHmRcCFPxRWNV0oyy88y0eIyu0n08RlJMsR269G6LDklHEbcEobCr+CDCL411lnDLWNBMuJWTYFka+LNwPqFfDaOXgDZtj0ZVBj+hy4e7iTC5UDF6OrGXxMO5zsOHdXXzVbvFUqdY69ypXxD1Nm8BGx/BnvVF30ePFNANa2VVA8s10qWXej6rrdg1QrPSTDnJyGI0rHYXW6g5Nyk06sJEsU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(38070700021)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RNK8Ulnovqe3k5PqcjU25QQbaauwsdzu+GPUkAx12ZpTA1EZaZbGwVK1WUdh?=
 =?us-ascii?Q?kZ1kE3Xp45qjBuoMd0F2eVFcfv+LjZRheDfLA0UjBWU4ucBbtjlTE0QtDXc8?=
 =?us-ascii?Q?YtoVmfvFskmpEM1Kker/Ajd6lwqaOxQwUSjKtpV3OdO1FbT8weLasgBlMzqL?=
 =?us-ascii?Q?Z7RZKTLkKZlEi4I6vf++yp0mydmxz8NFPZV2RBDfkf/rF1ML5E56GH8YDU4R?=
 =?us-ascii?Q?Vh7z0lXZK9MIn4FeChpFBWAZE0KFjKg3HMHajOu7g3MbBP+/Tm48uPskqfYR?=
 =?us-ascii?Q?nE3/MkwWGgLqvLNfK/XqeUMR5jwnH0E5HP03nkC2JjOAyGb9IHCA241/yuFL?=
 =?us-ascii?Q?0hKIsIolbXyYwQpvOpWD6AT9LCKqQvCuZzk0kZKJDScT88+t1b4KS+Fyqdpg?=
 =?us-ascii?Q?DMIsvfc9rjfbqwrYMj0jZqe5FuiVj+8AfzeJKu+GI++EFH+QBVJQ6HLGt/WV?=
 =?us-ascii?Q?Y/pAEqbnQefjvN7/nbx3xirbiAWq/7D2HQ6IwFqLO0goWZRWtrvJ/Sm0xgE5?=
 =?us-ascii?Q?eN6NypRoTOpi4XdqM31iztpD4LLHKiAp7ivrROe/s/kv8cqScSibvinJq4q4?=
 =?us-ascii?Q?5CJMc4Nw6xVaqB9B/CPe+Js6Pt7sdCe/X/Fue6P5EbO8GB3zzkbJ/U3mOyL0?=
 =?us-ascii?Q?FSlIIHJ0s7wK43GptNl8HVyuqs5AJ//txFgSrsd1cSoHKsfPV3P8vvrJVFxD?=
 =?us-ascii?Q?6ZStNxE9ITQZ3mBlcSBxHnjNKFL+m6dZ44m7nY4et0oniGe20L5l2AdcQvAw?=
 =?us-ascii?Q?x+whrphe9I5garTITPbyTI+6A92B4xf8KDfjoL25zczX7nQc4UbsP752H0th?=
 =?us-ascii?Q?nIuLE5y7URRX6DboXtB4bGtxGT0Sj+5m+avinxo+2K3KfrpcRgM8M/gm+2VS?=
 =?us-ascii?Q?TCiIcPy7LQPDoO/G3AUapoJ3QZVfBX6/Iuf7jDVXlVfGooZJPykJpZrW4v+M?=
 =?us-ascii?Q?gc7EVd4pu/TCCPZR7K5oKQUPLUt/CNNuxWcTFIPuBugD/C0KgrtQnP3iWmBB?=
 =?us-ascii?Q?M6bD5UDd4dgQuN7S1d9aBoRrYuGpYsh2FFypDAZcc0hiRCvNr1+SXqR5cg0Z?=
 =?us-ascii?Q?3YsLLveWY8FlhrI6MuykqsxrDAM2uPrdq5LX6bQ3OLuZEoCMNYj/Nx7jj6yH?=
 =?us-ascii?Q?kR05R71pZw3SX9sVNSv9KgTgPbZjMumhDndizGV0UBYOuE3O1npsNvm8ASEe?=
 =?us-ascii?Q?POWerczoidgQN+GryDknkaQt5P1rQYVF5SGoNCHI6GJwRqoAv0z3vO24MHY6?=
 =?us-ascii?Q?v4twlCCELbmCZJXlmzg+WsNDAJOB8CvCdKbjZeMGMQCOLu+AeWWWiIkwVLxF?=
 =?us-ascii?Q?86QQgAHO1SEjKed7JH2Hid0+FBwKbTkgGBoi8/iorARUsAAXD5y+VGOyM52X?=
 =?us-ascii?Q?YF/iXcsXcPl435dk9wi4T0ty7lzlynr8VoS47iZcJrOm9gP5VTMiQmyzc+nS?=
 =?us-ascii?Q?r/8DnNrIziA51LstcqwN8onpBM3w7ucYQDMbaaYiBka3mvcltGQ2BwP/WSaA?=
 =?us-ascii?Q?DPsoAgk3ZpBYL6kd32UmuP7s/OWOc0lLyvkD/ZkEEL1mou6IV5j6z0w/ctHA?=
 =?us-ascii?Q?PkdIeOE8sjBzrRGzc/C56NFjYj1APBRdxuzyMiH6uZn1IwqHpGVY1QlWtkUg?=
 =?us-ascii?Q?o/W4kWuRz4TT7k3I/DQZOJLDLrLdt5cSa6FiXQaRureWK81UeJQSvHvZb7IO?=
 =?us-ascii?Q?XYAe7+j5JwKmG2dyDFKUwicVTIzNTIrilk/ItwtNcnASWV2TPZZdvxkxiZLl?=
 =?us-ascii?Q?KtIWtgTFGw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: snQrWVbhHUM9UQ3Iy//sX2mR3VzwfnHo7Zk+wluPhGmkmnju/hG0q2SNICfNUcAMIN9fWOr3V1ceNnvAsfs7hAcmXv1zADWN7Xia8+iTqCRtA18mohJKZvWhTX2LvjKFZVSeTvU/qEhQPKvesGYvP+RgRG06KwTvpqMBFE5nwvbZmBqruG2cW/8T1/Tx/eQkeYqOP7ZHFcePg2ffV81o0BoThGO8zcIQrxdPkLC8YkQxoApRFhcBiVezIw85j/2VmwY3Ba2izooIGQjdeSSeKa8UcXxI5RpfiHFIk/SsH67A9JhpbheKfxb6WumBTH3CzXjXyw+9NLTKOvbiRuNJqw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339256e2-cd78-44e4-da6d-08dea05873dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 10:18:09.4446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dvv1iLSDPln+5btYm9FoCtX8eobNu7R+6/aVBNBN8340i7POt4PVSPA/peiPRFXUC0QHlttkyJpjhzpSTGHRKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7861
X-OriginatorOrg: intel.com
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

> Subject: [PATCH] test/event_eth_rx_intr_adapter: support NICs with fewer =
int
> vectors
>=20
> Some NICs may not be able to support interrupts on all queues that are
> advertised, which will cause the test to fail if the queues supporting
> interrupts are fewer than 64. We can work around this by retrying the
> NIC configuration multiple times with fewer queues in case of failure.
> This allows the test to pass with NICs using ixgbe driver, for example.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

LGTM.
Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  app/test/test_event_eth_rx_adapter.c | 52 +++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 20 deletions(-)
>=20
> diff --git a/app/test/test_event_eth_rx_adapter.c
> b/app/test/test_event_eth_rx_adapter.c
> index ae428b3333..7b38935bec 100644
> --- a/app/test/test_event_eth_rx_adapter.c
> +++ b/app/test/test_event_eth_rx_adapter.c
> @@ -60,6 +60,7 @@ port_init_common(uint16_t port, const struct
> rte_eth_conf *port_conf,
>  {
>  	const uint16_t rx_ring_size =3D 512, tx_ring_size =3D 512;
>  	int retval;
> +	bool started =3D false;
>  	uint16_t q;
>  	struct rte_eth_dev_info dev_info;
>=20
> @@ -76,32 +77,43 @@ port_init_common(uint16_t port, const struct
> rte_eth_conf *port_conf,
>  					MAX_NUM_RX_QUEUE);
>  	default_params.tx_rings =3D 1;
>=20
> -	/* Configure the Ethernet device. */
> -	retval =3D rte_eth_dev_configure(port, default_params.rx_rings,
> +	while (!started) {
> +		/* Configure the Ethernet device. */
> +		retval =3D rte_eth_dev_configure(port, default_params.rx_rings,
>  				default_params.tx_rings, port_conf);
> -	if (retval !=3D 0)
> -		return retval;
> -
> -	for (q =3D 0; q < default_params.rx_rings; q++) {
> -		retval =3D rte_eth_rx_queue_setup(port, q, rx_ring_size,
> -				rte_eth_dev_socket_id(port), NULL, mp);
> -		if (retval < 0)
> +		if (retval !=3D 0)
>  			return retval;
> -	}
>=20
> -	/* Allocate and set up 1 TX queue per Ethernet port. */
> -	for (q =3D 0; q < default_params.tx_rings; q++) {
> -		retval =3D rte_eth_tx_queue_setup(port, q, tx_ring_size,
> -				rte_eth_dev_socket_id(port), NULL);
> -		if (retval < 0)
> +		for (q =3D 0; q < default_params.rx_rings; q++) {
> +			retval =3D rte_eth_rx_queue_setup(port, q, rx_ring_size,
> +					rte_eth_dev_socket_id(port), NULL,
> mp);
> +			if (retval < 0)
> +				return retval;
> +		}
> +
> +		/* Allocate and set up 1 TX queue per Ethernet port. */
> +		for (q =3D 0; q < default_params.tx_rings; q++) {
> +			retval =3D rte_eth_tx_queue_setup(port, q, tx_ring_size,
> +					rte_eth_dev_socket_id(port), NULL);
> +			if (retval < 0)
> +				return retval;
> +		}
> +
> +		/* Start the Ethernet port. */
> +		retval =3D rte_eth_dev_start(port);
> +		if (retval < 0) {
> +			/* Some NICs may not support interrupts on all
> reported queues.
> +			 * Therefore try to reconfigure and start with fewer
> queues
> +			 */
> +			if (default_params.rx_rings > 2) {
> +				default_params.rx_rings /=3D 2;
> +				continue;
> +			}
>  			return retval;
> +		}
> +		started =3D true;
>  	}
>=20
> -	/* Start the Ethernet port. */
> -	retval =3D rte_eth_dev_start(port);
> -	if (retval < 0)
> -		return retval;
> -
>  	/* Display the port MAC address. */
>  	struct rte_ether_addr addr;
>  	retval =3D rte_eth_macaddr_get(port, &addr);
> --
> 2.51.0

