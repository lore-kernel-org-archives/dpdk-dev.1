Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35480606A327
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PkwHVrwE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73B9A40264;
	Mon,  2 Nov 2026 11:31:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTPS id 15C6D4003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 11:31:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793615470; x=1825151470;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mOd+922jVJBTtxOHY4qGWf/tiI9hIGLFovZCKFO2Bgs=;
 b=PkwHVrwEW0nxFL5dwwgVtcFsMi7wQXUvCwi4hXDUsZm2PPavj7i9Zr0w
 1I2KR3pgn0JTNVQHc7NmzYpKWvhM8eeFF08ZChylUELzXc6rTsobZvv36
 HqIs55l6v/J6KW7/5HlIezMOha8EzvPNFR+hck45x26sJG9wHF2xMiwsc
 ZEbfrqzOE2SZHRRYkGq3nAAC13gcj/IRAyuN/56r4NdzS3VZeOO1pA91K
 lASbxFMo9DCEP/BC+HnyQVf41Saxtum5Uo6vNgV62kcayvjWWNWtypiUG
 9+FcAHze7jtbrqNTJZZiSdtlhBieli4dmOpNaFZnV4vX3YoH6qmSZgm+V g==;
X-CSE-ConnectionGUID: z06bnHGGSCOVBtefoBTgcg==
X-CSE-MsgGUID: WgORfVfbS82HTH/pIuIryg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2303534"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2303534"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:31:07 -0800
X-CSE-ConnectionGUID: 9XRLDrMPTXGGooYZ1b5TWA==
X-CSE-MsgGUID: 2g8RqkmMR1aP7v5fMI+Z6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="5940887"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 02:31:06 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:31:06 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:31:06 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:31:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLGGyWTNEKk2TXjmuMA03WIEgD6Ut81n8JXx6dArlIQV9ZrTmN8dODlWWQDsRukWNj12IgYw+66kL+q4oCXbpQWN371Ou45hkonBvzU4HpY/hsYjwcIwJpH5F4jdBordt9oxo2bRtzhsG8pabuiYSIRSJvYuXj9cU+AONH9375VAuzgrb6n9JaiYf5whbwxQrIwWEJhIxDHdd711MflhvBNSkA1f0so3rTdPCyRK9LDOA5uLPD58eNZcKYe7CYpRliepfHSR2yIBwbmcNlXMzTECIlXOHPpKvqrFwZel58jbcGUGY8KJUGkNeZTBy7hcewunnUWEbLNc+QYxnEXUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5rkNBMvTi/NseBbJq8MCcohNPI87sbd1jcQr/VFYqA=;
 b=PuZ9fbm0V4mKIEbwsBkO+ql9821rZy2mjVQegE5X8Fo5xNMbSnveEiCJCzJ9mSeogSHKM6M+hasjd2cIPTTZqnHvB9hLhHSQ8SYCbummBqrSRIdBk5XBN9albm1lCqwb57OYkr5WOUx9D4yiP4tlEbLEUeGZUqU0CsGR0PZlcd36d9KKErw7Q+dRNQ/mXmWjvM3rX9GZIM/VJraGwwzJ1mDqLzrxqtBO5IKTe9JMSWZVy1TqTnYKtSR+1j93Qg7iCjdNfbmQQ6cTMAu6B9kwpPxw50cqjeWRnbYUglUH8mOfVcefFFw0URMy6UoTmtbhIKV2u3S8fsbqyrqaWYZQhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from AT6PR11MB044526.namprd11.prod.outlook.com
 (2603:10b6:170:110::22) by SA3PR11MB169024.namprd11.prod.outlook.com
 (2603:10b6:806:588::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:30:58 +0000
Received: from AT6PR11MB044526.namprd11.prod.outlook.com
 ([fe80::4301:f255:af66:888c]) by AT6PR11MB044526.namprd11.prod.outlook.com
 ([fe80::4301:f255:af66:888c%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:30:57 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Mandal, Anurag" <anurag.mandal@intel.com>
Subject: RE: [PATCH v2] net/i40e: add IEEE1588 handling to AVX vector paths
Thread-Topic: [PATCH v2] net/i40e: add IEEE1588 handling to AVX vector paths
Thread-Index: AQHdX+IL9UN+0eo84E+7qtLDxzx4y7capuwQ
Date: Mon, 2 Nov 2026 10:30:57 +0000
Message-ID: <AT6PR11MB044526DAECD0D816DEC484220AE46A2@AT6PR11MB044526.namprd11.prod.outlook.com>
References: <20261009053449.843546-1-anurag.mandal@intel.com>
 <20261019155300.755825-2-bruce.richardson@intel.com>
In-Reply-To: <20261019155300.755825-2-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AT6PR11MB044526:EE_|SA3PR11MB169024:EE_
x-ms-office365-filtering-correlation-id: 11dea27c-e032-4bd6-285a-08df38cc61c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261009223027099003|38070700021|261026140227099003|261026121527099003|261028144727099003|11063799006|4143699003|10067099003|56012099006|22082099003|6133799003|18002099003;
x-microsoft-antispam-message-info: BZyxT2lx4eC1FJyhDGtvGUcoFu+pJ/96g/oyNA3MCfmlOU/UpwImJC9Wlgwhhpwxl6QtWsIH4Mv/FPQVORmuzwpOkllYZDfj/UxCVfXzMLQ4cnpBCk3gMiy0zBD5x/DBihcF17ts5lkJr6LYsrOlqHS2l7SKCJ87RZDZ4LvlbJ4jtL3Zz7SySJSmBcR9x3a3pN7iYghgJJDf+2KDwLMpQ6HBJs5KtiQS96wy/abb8Dw1iINtGJQcBstONSIL99yhFiD2SpfJk7AptyM2sqDcmYFzDtgo2V3lfJJvydUmj6hc+6YKIvm8+WZWzsA92o1cC3mPo5F6g6uPajsdOKM6XOxQa8WVyZIFxHxsMkgw9L9Yg5nSn03DgUX+nKFI5BzySpaTf0X5YEgo/Os2Qmu3h7bbXSTBKs09OYaxoLUKC5W3Pu4Z6Q4FP5wEP5Kve+GdarbbHL5LjFJaC68oiEUpL6bgQ+tXjjHJqJ3J6+l015s5YEzFiMTqpQLgK2s11Tw068ZqC5lRfjMHzZhRVpXGDIGnxwEVBGGJNZeOLFui+ZBIqu7ZDz3kSn70DfIaQrj63gp6tGICoPkGR/9iwyr8hhGb454viyChFxVvHifdCaUjG0saoiq0Ixmln0QQpMbDmbmvn1VYaaA746VOqvHKdnOoqRJ1KIaJ1TPnZcl37iDf6zHtqMrhStlc3NJbAaDijJB+xk/ZbCMe67ULKgszJNs6YHIFOUbeIaYp+6olDBM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AT6PR11MB044526.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261009223027099003)(38070700021)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wiqQkoWPllUERkmp0dCKLEfcXDywvkx6Yk1yzYJAzbfOyQnJ5705hyt9sOTV?=
 =?us-ascii?Q?uM59/qrtywurCk/m2T5wY351D7Mh3cLMJp61fbUyL6Vn6WE6LKk4qct7hPPa?=
 =?us-ascii?Q?ASaD2+sjlSCfGKvJ1eEL6Lox2eO+7+hHecVLKR7+E2+faXj3pM49UYmLsozs?=
 =?us-ascii?Q?pGtT5fHhqOQjQbuEvWLbeNYz3o8c4xaL2VkzzGvOiDTb6TvQnZVH7F9VRvqC?=
 =?us-ascii?Q?S+/gzq/9Fk1rNnk4OoIruigKEuwRjyw799zv5ROM6L8AD7LE/mU4y4yPYrxu?=
 =?us-ascii?Q?Wv5RM8jOI7XUnyKJWAD1K+bOHQUtgIE75wFqoqR3RreCt9wa2JRnYiIJba4n?=
 =?us-ascii?Q?8NfsBharx3dUI1cD7R11xe8gbMd/iu3a9Kjp/PEbcPxXLgBenvEVP8rgqIU8?=
 =?us-ascii?Q?ASuM4pV0Q46AOrm1bkABuptMqNVux6TqI1o4QMWbbadHYgio4Ux5yqhmS/2w?=
 =?us-ascii?Q?CUj4XCDOnSsLwCkMmcOIFJhn4GyfP2pcs+nWVaPI7PO1sLS6kdYCraOCpA99?=
 =?us-ascii?Q?mM4BFpgo9JhE0VafFSQhEmQ4Ym/4a/EoVMs6PP+Ua+MU2VZBhGj6bTTqP663?=
 =?us-ascii?Q?nO9AEqHp3QA3jt7C7L2V0KWU/IGJ9wghFWN8W8Ld/lSMiJ8NWovAX1pGW2sI?=
 =?us-ascii?Q?z1y6XqS73DCfcmUIqBcrR51i5skTKPnbQl9blyT+zFpEW7WG6l6XkkpwpnXE?=
 =?us-ascii?Q?+x+xKqqccFl4TZNqnrr9ZHgMB98oDFb7kGklk8/b86LMQ2QEtGt2LzC8nSPb?=
 =?us-ascii?Q?vCqRppkyc3M/tR49hDqlFkk8AVJyFvLxlXLPEhChoCAteC8S7s0sS4xtWcsB?=
 =?us-ascii?Q?uDfR2GZdBEoze3XsDqbWjpqdYlpdeJAPOsj1pjIyzPaGPY/873czz5UQhq+S?=
 =?us-ascii?Q?bjZfODCdSyk4sRa4TJtyxXlBvWlEldifdwp101z8Szj1EEENAEj0MjFcxwTv?=
 =?us-ascii?Q?Rl4tz72WnbXdRprQTesqlR+uAaues6lFTB/H7dBPFG9XeZpRhN/DspagBmub?=
 =?us-ascii?Q?6DeLJFXKYOvSeeo4n4RVTW9pr2djTsclNqaRrphXioQkoUL4Paf5Q5uotxbv?=
 =?us-ascii?Q?SUUnqG6qhpDs3Zhd+Ixn1kQ7AXqkgGWR5lIRGIDQzHkBbGt4nNsalxVz/8+Q?=
 =?us-ascii?Q?Hl3Okbeq6DOpgHmcNHPIzzx5bTYsuGjtSm02DiQymqWsOBZ3BeZiCmpOnRiY?=
 =?us-ascii?Q?JhIxAxb9HXm+LYoXQ+336qcUUQMu7UsjosQ0jxQezJBkWtTkPqausTjkflAQ?=
 =?us-ascii?Q?nPPVJyu7h1+g3J4aWxIt+Pq/eXnVsgPnGIyNw0giVt0TyhVZUFlT4ZhNmgq1?=
 =?us-ascii?Q?eY+OsuzIhKARsnCQ87fTh5irW8vP/HzVMz1K2X1dz8UjG2NPMa+mdJ1P4qiH?=
 =?us-ascii?Q?Yrl8sXZq3Pn43w6W0GE/Ji+oTvTetqzIAbHOfGFnqk2hljgdXo8km69IuW9C?=
 =?us-ascii?Q?IjPKwPWZxVcFj7+QOn24SW2hxyi45NiczeYOu9oSWW3q0fFJflh89kYrjN77?=
 =?us-ascii?Q?TpJree8ceVCbyRgVynsqocWmiUUwVOprnIh0MULN88Le/khstn0UPoW2EIrn?=
 =?us-ascii?Q?e5pycrh2F7LOQvYQJCLuqbkt00Mq/Tgl0QwX4bcy1hMaoPAYNfRavos6yFdo?=
 =?us-ascii?Q?v+j7Uzi0AEQQepFcY4XZ6EQ6+yuymchws/3Rv/U0LW/ILcKnPPKHatsZj5qU?=
 =?us-ascii?Q?SOZzx0LkHY6y/XOtxzdC9hrJuC+eQC13y0gUp1YeuLDKf5r1q5Y2lFYJ6STr?=
 =?us-ascii?Q?23odWFnSuQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ywx/aYqmcm2CX56dpKJeDhGzOQiiogC1OVmT0sjaAcA5fMtpp8C8jLJhbq74VMSD3h3QR0IYw0BYy9+SAqjyoVec6kLs2VBmftOpU84MwdTMOV1xx/1pmDuYDRmeCJwhaE9eWTgydvkqCin4IUz2rt2OMs/F7iX3bvMLJwyCb/y63KJTqSn0CZ2NaVuUZVYp8U7hYO4ckx30atysUgzg66c8ADNxAKy3H4StPm7DIYunyakIhHoUxxwGwJ8Koc8kLrytrv78DRNE/jraNQUQVzuXI4D+8mFzXMsnra+xD8ZF+8/dKNAGvWr8qdCzgrCa1UD1FHvzmOy0WxFivY1urg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AT6PR11MB044526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dea27c-e032-4bd6-285a-08df38cc61c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 10:30:57.3819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZViIaKSNAfy6hxKCtyThepuy4Stker13Ym1r9lqvpMXomWqtpO9KFE9zeCYTq5WZaCpnhkcepmRclTFHAF0dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB169024
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: 19 October 2026 21:23
> To: Mandal, Anurag <anurag.mandal@intel.com>
> Cc: dev@dpdk.org; Richardson, Bruce <bruce.richardson@intel.com>
> Subject: [PATCH v2] net/i40e: add IEEE1588 handling to AVX vector paths
>=20
> The IEEE1588 timesync support was only supported on the scalar RX paths,
> but is, in a number of ways, quite similar to how FDIR support works: we =
read
> and process values from the various per-packet flags and then do a single
> store to the mbuf. Add support for IEEE1588 to the AVX2 and
> AVX-512 vector functions inline in the main descriptor processing loop, a=
s
> well as the appropriate one-line fix for the case of scattered packets.
>=20
> Suggested-by: Anurag Mandal <anurag.mandal@intel.com>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Tested-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/common/rx.h                 |  3 +
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   | 59 ++++++++++++++++++
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c | 61 +++++++++++++++++++
> drivers/net/intel/i40e/i40e_rxtx_vec_common.h | 12 ++--
>  4 files changed, 131 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.=
h
> index e0bf520ebd..8f4454d477 100644
> --- a/drivers/net/intel/common/rx.h
> +++ b/drivers/net/intel/common/rx.h
> @@ -167,6 +167,9 @@ ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs,
> uint16_t nb_bufs, uint8_t *s
>  				start->hash =3D end->hash;
>  				start->vlan_tci =3D end->vlan_tci;
>  				start->ol_flags =3D end->ol_flags;
> +#ifdef RTE_LIBRTE_IEEE1588
> +				start->timesync =3D end->timesync;
> +#endif
>  				/* we need to strip crc for the whole packet */
>  				start->pkt_len -=3D crc_len;
>  				if (end->data_len > crc_len) {
> diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
> b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
> index dd06e258ad..652a915db2 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
> @@ -494,6 +494,65 @@ _recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq,
> struct rte_mbuf **rx_pkts,
>=20
>  		} /* if() on FDIR enabled */
>=20
> +#ifdef RTE_LIBRTE_IEEE1588
> +		/* The TSYNVALID and TSYNINDX bits are already present in
> +		 * status0_7, so the PTP timestamp flags can be built with
> +		 * no extra descriptor reads, the same way the RSS/FDIR flags
> +		 * are above. Only the 2-bit timestamp register index has to
> +		 * land in a specific mbuf field, so it still needs a
> +		 * per-packet store, done the same way as the FDIR ID above.
> +		 */
> +		const __m256i tsyn_valid_mask =3D _mm256_set1_epi32(
> +				1 <<
> I40E_RXD_QW1_STATUS_TSYNVALID_SHIFT);
> +		const __m256i tsyn_valid =3D _mm256_cmpeq_epi32(
> +				_mm256_and_si256(status0_7,
> tsyn_valid_mask),
> +				tsyn_valid_mask);
> +		const __m256i tmst_flags =3D _mm256_and_si256(tsyn_valid,
> +
> 	_mm256_set1_epi32(RTE_MBUF_F_RX_IEEE1588_TMST));
> +		mbuf_flags =3D _mm256_or_si256(mbuf_flags, tmst_flags);
> +
> +		/* zero the index unless TSYNVALID is set, to match the
> +		 * scalar driver, which only ever assigns tsyn & 0x03
> +		 */
> +		const __m256i tsyn_indx =3D _mm256_and_si256(tsyn_valid,
> +
> 	_mm256_srli_epi32(_mm256_and_si256(status0_7,
> +					_mm256_set1_epi32(0x3 <<
> I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT)),
> +
> 	I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT));
> +
> +		/* status0_7 packet order is (hi->lo): [1, 3, 5, 7, 0, 2, 4, 6] */
> +		rx_pkts[i + 1]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 7);
> +		rx_pkts[i + 3]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 6);
> +		rx_pkts[i + 5]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 5);
> +		rx_pkts[i + 7]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 4);
> +		rx_pkts[i + 0]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 3);
> +		rx_pkts[i + 2]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 2);
> +		rx_pkts[i + 4]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 1);
> +		rx_pkts[i + 6]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 0);
> +
> +		/* the PTP flag only depends on packet_type, which was
> already
> +		 * looked up above for each packet, so again no extra reads
> +		 * are needed to build it
> +		 */
> +		const __m256i ptp_flags =3D _mm256_set_epi32(
> +			(ptype_tbl[ptype1] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
> +			(ptype_tbl[ptype3] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
> +			(ptype_tbl[ptype5] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
> +			(ptype_tbl[ptype7] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
> +			(ptype_tbl[ptype0] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
> +			(ptype_tbl[ptype2] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
> +			(ptype_tbl[ptype4] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
> +			(ptype_tbl[ptype6] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0);
> +		mbuf_flags =3D _mm256_or_si256(mbuf_flags, ptp_flags);
> #endif /*
> +RTE_LIBRTE_IEEE1588 */
> +
>  		/*
>  		 * At this point, we have the 8 sets of flags in the low 16-bits
>  		 * of each 32-bit value in vlan0.
> diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
> b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
> index ea2e6dc024..f96e965914 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
> @@ -543,6 +543,67 @@ _recv_raw_pkts_vec_avx512(struct ci_rx_queue
> *rxq, struct rte_mbuf **rx_pkts,
>=20
>  		} /* if() on FDIR enabled */
>=20
> +#ifdef RTE_LIBRTE_IEEE1588
> +		/* The TSYNVALID and TSYNINDX bits are already present in
> +		 * status0_7, so the PTP timestamp flags can be built with
> +		 * no extra descriptor reads, the same way the RSS/FDIR flags
> +		 * are above. Only the 2-bit timestamp register index has to
> +		 * land in a specific mbuf field, so it still needs a
> +		 * per-packet store, done the same way as the FDIR ID above.
> +		 */
> +		const __m256i tsyn_valid_mask =3D _mm256_set1_epi32(
> +				1 <<
> I40E_RXD_QW1_STATUS_TSYNVALID_SHIFT);
> +		const __m256i tsyn_valid =3D _mm256_cmpeq_epi32(
> +				_mm256_and_si256(status0_7,
> tsyn_valid_mask),
> +				tsyn_valid_mask);
> +		const __m256i tmst_flags =3D _mm256_and_si256(tsyn_valid,
> +
> 	_mm256_set1_epi32(RTE_MBUF_F_RX_IEEE1588_TMST));
> +
> +		mbuf_flags =3D _mm256_or_si256(mbuf_flags, tmst_flags);
> +
> +		/* zero the index unless TSYNVALID is set, to match the
> +		 * scalar driver, which only ever assigns tsyn & 0x03
> +		 */
> +		const __m256i tsyn_indx =3D _mm256_and_si256(tsyn_valid,
> +
> 	_mm256_srli_epi32(_mm256_and_si256(status0_7,
> +					_mm256_set1_epi32(0x3 <<
> I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT)),
> +
> 	I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT));
> +
Hi Bruce,

I have tested it. It works fine for me.=20
Only small concern:
On 64-bit, cache line 0 ends exactly at pool (offset 56-63), and timesync s=
its at offset 90.

The non-scattered vector Rx path never writes past offset 63. Its per-packe=
t writes are the 32-byte rearm_data store covering offsets 16-47, and the F=
DIR ID store at hash.fdir.hi, offsets 48-51 - which is itself done as a sep=
arate scalar store precisely because it falls outside the 32-byte vector st=
ore.
Both are in line 0. The path does not even prefetch line 1 in the common ca=
se: rte_mbuf_prefetch_part2() is called only under if (split_packet), becau=
se scattered Rx is the one path that has to write next.

So as written, the patch brings the second cache line of all eight mbufs in=
to the write path on every loop iteration, for every packet, to carry a reg=
ister index that is meaningful on a tiny fraction of frames.=20
The scalar path does not do this - i40e_get_iee15888_flags() writes mb->tim=
esync only inside if (tsyn & 0x04).
The scalar path writes it only when TSYNVALID is set.

I would suggest to add the following which keeps the vector extraction and =
matches scalar behaviour:
if (!_mm256_testz_si256(tsyn_valid, tsyn_valid)) {
	rx_pkts[i + 1]->timesync =3D _mm256_extract_epi32(tsyn_indx,
              ..................
}

Thanks & Regards,
Anurag M

> +		/* status0_7 packet order is (hi->lo): [1, 3, 5, 7, 0, 2, 4, 6] */
> +		rx_pkts[i + 1]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 7);
> +		rx_pkts[i + 3]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 6);
> +		rx_pkts[i + 5]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 5);
> +		rx_pkts[i + 7]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 4);
> +		rx_pkts[i + 0]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 3);
> +		rx_pkts[i + 2]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 2);
> +		rx_pkts[i + 4]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 1);
> +		rx_pkts[i + 6]->timesync =3D _mm256_extract_epi32(tsyn_indx,
> 0);
> +
> +		/* the PTP flag only depends on packet_type, which was
> already
> +		 * looked up above for each packet, so again no extra reads
> +		 * are needed to build it
> +		 */
> +		const __m256i ptp_flags =3D _mm256_set_epi32(
> +			(ptype_tbl[ptype1] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
> +			(ptype_tbl[ptype3] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
> +			(ptype_tbl[ptype5] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
> +			(ptype_tbl[ptype7] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
> +			(ptype_tbl[ptype0] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
> +			(ptype_tbl[ptype2] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
> +			(ptype_tbl[ptype4] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0,
> +			(ptype_tbl[ptype6] & RTE_PTYPE_L2_MASK) =3D=3D
> RTE_PTYPE_L2_ETHER_TIMESYNC ?
> +				RTE_MBUF_F_RX_IEEE1588_PTP : 0);
> +
> +		mbuf_flags =3D _mm256_or_si256(mbuf_flags, ptp_flags);
> #endif /*
> +RTE_LIBRTE_IEEE1588 */
> +
>  		/* At this point, we have the 8 sets of flags in the low 16-bits
>  		 * of each 32-bit value in vlan0.
>  		 * We want to extract these, and merge them with the mbuf
> init data diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
> b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
> index 292a39501e..521e206438 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
> +++ b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
> @@ -53,7 +53,14 @@ _i40e_rx_queue_release_mbufs_vec(struct
> ci_rx_queue *rxq)  static inline int
> i40e_rx_vec_dev_conf_condition_check_default(struct rte_eth_dev *dev)  { =
-
> #ifndef RTE_LIBRTE_IEEE1588
> +#if defined(RTE_LIBRTE_IEEE1588) && !defined(RTE_ARCH_X86)
> +	/* Only the AVX2/AVX512 Rx paths propagate the IEEE1588 PTP flags
> and
> +	 * the hardware timestamp register index, so other architectures
> +	 * still have to fall back to the scalar Rx path.
> +	 */
> +	RTE_SET_USED(dev);
> +	return -1;
> +#else
>  	/**
>  	 * Vector mode is allowed only when number of Rx queue
>  	 * descriptor is power of 2.
> @@ -67,9 +74,6 @@ i40e_rx_vec_dev_conf_condition_check_default(struct
> rte_eth_dev *dev)
>  	}
>=20
>  	return 0;
> -#else
> -	RTE_SET_USED(dev);
> -	return -1;
>  #endif
>  }
>=20
> --
> 2.53.0

