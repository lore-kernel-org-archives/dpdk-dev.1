Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0441C5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 13:01:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D74D402AC;
	Thu, 13 Aug 2026 15:01:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9AFFC40298
 for <dev@dpdk.org>; Thu, 13 Aug 2026 15:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786626077; x=1818162077;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/CjopaHGWFk+txi/p1MVH0exAYISH1EN3Ij6xjCF1zg=;
 b=hoPEKVXg6nThKufyKRTlzJYkZY6gDGluNFTNYeTaixxBocNJFAYNOCxD
 XJ7Px7TdPcjXuYrwMXaygvdqSJFzsq+HaS/zBkQo4UReANhniEqLTHJZS
 mz1ikHg6XUMWLbFMUcFn2OcXF/M62RVRuiH8lx6mOgGZekGxPWBMFJHCv
 8BtWLSR4a7CVRDI5OI0pExfQuraB0WDNmx4tVr0Vi2mTPE+qpfpQmo7BN
 4xKXsr5FAlvKKvaXGtu4xoU9kyuASpWbOPj6zs4tXxx7JMrf46XGzA936
 wGjyS5pK3A3OapMPsqpCdKAAThTB6IWci6VSVltO7Y9YF92COarfhA5RC Q==;
X-CSE-ConnectionGUID: rvAoy3A4TCeaWdIN0+LHBg==
X-CSE-MsgGUID: 3F0GCUr5T3GZ4X7OB8iPJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="104582038"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="104582038"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:01:16 -0700
X-CSE-ConnectionGUID: A8KWr88zTkqfkqmZScbE4w==
X-CSE-MsgGUID: FfisH2N6QbS7OJHlaKEGkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="265914878"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:01:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:01:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 06:01:15 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.35)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:01:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBamKDtztLwL6Dw5cpGDSc4CPotMqUoVJgPceYaPcQZdFwS0iBxEQ6lHO6MlouJhfilKKe8I0gC44XxzyoY9PaS0kMS4j8YO8DZDuFxIrebfMrF/uhm6UL/4duwiW4HlrBptMS/MV+nWGh0bgpzU7yTN6Vln4wU+upxocv6wUGlhlt40EFHUjRKrShm7h4XA00rLfWPXsLCQngmz4WC/IDJSoCqjbrQezzpu/NMUhlwCPaWpDvGZjfxkQLVS2LE+wAijPwqc16P9/gkMuwULpGSEI1PUgsIpHI3AP0bc9BJMyrG8VM5B4ROxXsZ8GMCfymmjDfdUHwsjwmWR0QVnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCeQvzbPouXx5zM6Al0aDzfAKdo7AFvZ8zQE3IYrxv8=;
 b=GF2HkK63rhb/PDsnRHQLu2qhgkwcRrNNUmR3yqrPKryb8uZBDv6/XciDcvrWKvto3iszV6E3NWMDTJ9qRUdXwhDkuDsgx0zh6WDDwfWyDuEqOCAPGONH+yaIsq3zwE9DmCaSdiwmdzDzLKBpQDjGNGtB0VAtcWM8w6gc7as07DJTtw+UjsSmm0YuhsEpXz4J/3X9ZZafXzFpgiVRMjuYybRFPKvyIPVeUNA0xlW1jktSSBGL1IJXf5il8ADVkHt7JPve3KlwaaiAbyKyWsHHMIWAzZIIXmz6j0r6n6TktZj1QgAHw4dEKWg9e6fiChOWmsCf0ZkdO2k56kgFKvgcpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DS0PR11MB8739.namprd11.prod.outlook.com (2603:10b6:8:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 13:01:10 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0270.016; Thu, 13 Aug 2026
 13:01:09 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v2 1/7] net/iavf: discard empty AdminQ descriptors on reset
Thread-Topic: [PATCH v2 1/7] net/iavf: discard empty AdminQ descriptors on
 reset
Thread-Index: AQHdKxEMHP97B/UxT0Sz5shjVyeoYbab8Kjg
Date: Thu, 13 Aug 2026 13:01:09 +0000
Message-ID: <IA4PR11MB9278A072F7B28EC3C97437048EDB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <cover.1786617159.git.anurag.mandal@intel.com>
 <1758e9329549e06f64942ebd102aee9e23c6f4a3.1786617159.git.anurag.mandal@intel.com>
In-Reply-To: <1758e9329549e06f64942ebd102aee9e23c6f4a3.1786617159.git.anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DS0PR11MB8739:EE_
x-ms-office365-filtering-correlation-id: f876a426-8a86-456c-57d2-08def93af218
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|11063799006|56012099006|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: YHrZyU/GClhVhZuoQux78mj3FbT0lAxs0cctfRKz03VVZYlNmV5AL4T4jX+94SaGm0FPTh/08znmsmcy4yFuaOzHlQdzmEIWL8s2tMr8F+c7/h8u0LMk1nI1xp9Gw3hD8A2yJmiwuv8lLoTZtf4C5MnWGwrVIcbhXZMna50aGAP1owt1L4HSaddlvIGHr4m+YwCT9hmw+BBJCGuPNzW6xjF1UeNy0E5+8Ykj9UGt3B+0hx8przYsSIiAYCPbZm0X/4cMD1/thcYqazLvIRW9OKn8+bVkbVSZwY1+dmtD1Av63IAwIm469LX1r92f1kAVdIPSG0f2WOAoDyqJevgmyJv6jFzDSlTHLl+HFhjHFEKrCG+ALvV34EJgaJs1AsYy3UpPjOuiIH4tBgCr0GPy0wpXGUxRtSal+nmvWFrDP+qjgYvi7VCoTWpcsT+lr86mKaSeGpFEPtip3pHVpXv0OPWaOBXPVEo5XAW1o8rV+YNj3uIY3cnIWyWPFJT4parXwkIcyUGnYwS3wmVMaDUn0Uy1mjzThuS4Tbwk4O2lkCJkTNIADLuWqmFS2xm3+lJy+RtK4PUIu8Tcl5C2Z+27q194XptQwijQ6uQzy5e/hhriJAx69gO6SAMPzY1+UH6Uhui1/2xC7T/srsjQAghCwG3MJFvs4dOMAWnraqJyj+vHcJqvvu80duBtQNZgyMCP7615YNU0om77jGO5T0s/kw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BobXweNAtP/6zCVHvREQyXm+mLhtVrRxow209V1bOy/7QRZ9N0zzj+HTFIiw?=
 =?us-ascii?Q?LUn6/q0WU73MCLy4EN7wAcJ1NiyVTywWg3fNAGZfPZnzpEyEzTPc7qVsuBOe?=
 =?us-ascii?Q?G8Co/cPr2T1PxsvhlmmXEm8Cig0t436cSaVHAS9NlaWFEbCtp35hhvjdFKLV?=
 =?us-ascii?Q?CUvuD2xafbuHgPWuRQqmlAKEZLbIZ2/Lilv7euwWt+GESh20cvFielBS+ezg?=
 =?us-ascii?Q?OnzQlGbmCg3O05glKlnTEd26NZISOH3b7+tsOmbUTECOpO7kfmpiEUxwIjDM?=
 =?us-ascii?Q?629gaf2VHG9uImXszfQTAo9O0Z12p2EFjyjKpYOXQ8js4Y3MW+BBgEDGmJj9?=
 =?us-ascii?Q?Dc+/qfVnWUhvO2MAFCKzEVlB/B0h5GKwLkk+HKzZGiDrnJLZ0LaGeFpZ/rY5?=
 =?us-ascii?Q?PobRaGYylJYETMErZk5QdAmuPFo5o7kuqAVFcXlkfPV/hwlB/32Nw2UjgZ+T?=
 =?us-ascii?Q?eQqDGN/gns//eSHPSQ6mUQR0RYlrh8Toc3SPd5X/xlp2rk5YzrX0evd4wGCD?=
 =?us-ascii?Q?chrDXVkLUuV/eKOx/Ow3707pjnvkpGem7t39AVDdEX/Ntb4VSV/b7D8bkUyk?=
 =?us-ascii?Q?1OwokeuwBK7J57+/KZNgBb/NYb1MW1+ah8HZgxqOZMKglaWkpZpjYTl+LRUV?=
 =?us-ascii?Q?4mBBcqtq1q46nTX+Zh8+2RXwBFdaBzgfN56bPkrKrTY325X8bWa/Yl3u1RzY?=
 =?us-ascii?Q?7kUpsxHYECWmSIX99HjG+dqDEsN8l1Z2jk5x+GjShnbiVqXwU9CPDUeToMlZ?=
 =?us-ascii?Q?6NU0sX7roVyt13LlKWOtCapezulzeRotXgOdODZqPsamS4UQ5G2ZXBMvc6AK?=
 =?us-ascii?Q?Milvz8rSvIzSEHMzUOOce4pXt6h3kz76Dg+59jXRO4BZCl19JR0bA+zRKCOA?=
 =?us-ascii?Q?FEKt/oFxNVzH/v7Ru6G6XoAprU/kMzsIUlkgS/WD2pLuPdJLILTc2r1Owfry?=
 =?us-ascii?Q?zHkPobzTLP1CDw2qOTncTiruzrdxafMxUEhy0oFI4wqqA3/Ol246yPjgU6y1?=
 =?us-ascii?Q?x/vOLC18tld+BGvX9lS9DCEwJUhR4MDwM6MpVuVLnItKmmhmYqLQJD9VyVCX?=
 =?us-ascii?Q?GKKodnlJaELIkJq6dmE504mQREjpapvtku9UpGSxA7VE4ro3MUCafRztfzOk?=
 =?us-ascii?Q?3voQgVM9Zc1CstvEER8ap3CFkgGLo0wq2g68J62qubw3byW+cBp5sizR7gqn?=
 =?us-ascii?Q?d6hK79KoSYH5cGSWNm2jgH8HRJjo1NUqGXBbCsz14r646H0eo1tUth60un8R?=
 =?us-ascii?Q?LiI047lZkDMqfuryGWeHLQLs3vUZ7rZK37fRvANd7hDC+i/VNvNeOfpWGmlO?=
 =?us-ascii?Q?LIlTehqotv/1udSWkWU7U1o6N7feA31w4IyrGcRu2neYhsB8Ybc4OMmWL37d?=
 =?us-ascii?Q?2XzNMiK0T4H4fTL67HHdxYya7wQKSUMTAIkSjbcYaD05bE8me2kgyTOLOIfQ?=
 =?us-ascii?Q?LQZVJZ2cQGNdT6CeKU7ZR/9MyHtDRFrDJ5/rhYt+30xv+NhZ5TLlGw0ICh4u?=
 =?us-ascii?Q?6Y3nDjOas0a6ah3t4NylsFY9M3giSM5tRDt/Z++Qn8rc15Zb9pPirZmMhyUQ?=
 =?us-ascii?Q?UBL9xbEuwC0DLcIumFXoI1hsnqR3SbhP+8YxG7TIkXiBylQ1Oj+gpwGyQqq6?=
 =?us-ascii?Q?l8txMfKZsZDf+XYQd1qZB87bvGHlIrAnLzMfD3yb8UnZYhO/y8rDlHLgT9qy?=
 =?us-ascii?Q?OWYzUBbIZjDarMIfNhbY3SbR2mrw134AOdo3pXEGJAbTiJNGMg7+Aa9hfpxK?=
 =?us-ascii?Q?rj+0YzkUuA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EfBH2mUvl1Tm1Y6Gxfgh7BAaM8/VBcj7dG3wmcLdByO2pZZUP7QoJKPMgZzZpetO4zcHkwIE9Ymd+XSBQVWdXwVvk7HJNNjycEWUix/WK6Mro/1Emo/lgs4JYR4I8XmOkGVGfBTp8LbGNcY5zievYsrl1ZVTA9LGibelhntHKRHf39+ZupBuQH0ONrCdGxXpl4AhufNZUywBPJhveVSxjASTe42nWwHQ01mEQocKm65RcDIhuhV8UKiZ4FvCWB4jhlTyBFZgxYL+BN3HvXNlQtADqseocmzcvjmH8lSCtbxQ/4/nZSY/YCwF5Y2jfcnDJZI817favHT7yjLGFYWTNg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f876a426-8a86-456c-57d2-08def93af218
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 13:01:09.8047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqF+ahmop49Oz7k8+bu2+JkW+tT1g44k8fhI6mt19+SLCBa4frL9SV9FczGIlaHRqsOAyv4zYPkFDrSBeAGJeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8739
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

> Subject: [PATCH v2 1/7] net/iavf: discard empty AdminQ descriptors on res=
et
>=20
> During PF-initiated resets iavf_clean_arq_element() has been observed
> to return success with a fully zeroed descriptor (opcode 0).
> These fell through to the default arm of the dispatch switch and
> produced a "Request 0 is not supported yet" log flood in the field.
>=20
> Skip descriptors with opcode 0 so they are silently discarded and do not
> flood log.
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index f346837bf1..23e4107743 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -614,6 +614,11 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
>  			break;
>  		}
>  		aq_opc =3D rte_le_to_cpu_16(info.desc.opcode);
> +
> +		/* opcode 0 means the descriptor is empty/zeroed, skip it */
> +		if (aq_opc =3D=3D 0)
> +			continue;
> +
>  		/* For the message sent from pf to vf, opcode is stored in
>  		 * cookie_high of struct iavf_aq_desc, while return error code
>  		 * are stored in cookie_low, Which is done by PF driver.
> --
> 2.34.1

