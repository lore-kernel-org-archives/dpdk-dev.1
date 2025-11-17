Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F470CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 06:46:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73FF041109;
	Mon, 17 Nov 2025 07:46:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id F0A39402A1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 07:46:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763362016; x=1794898016;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AmPHOG7bkHwZSyu5r6gqzLjD7gc4KYqxofv+dbHTbSE=;
 b=kTU0FfDR2jDBbufI5xNphbJMdtlaMZEM25sLdd4JWodg7ucXddnnEF3x
 K/1rIYwuqltdYRVrUsb2KantD7JMJ8iwzGRdsRUrwhABKUs/ktcFMjBNg
 2sUxfxmB1H91+QmFJlCkbAg8Uf3KpwON4pCKgf/RcR3b5FC901uY4aOPu
 pq7ms60iZ+3XOLMTFXCGVZ/HmqJnujlhEtdtEDCMDzjE1LFttqIliRNS7
 onF3YCSSwkXq6/M93z2h5sYUJG/GL9IT8l9uzMnCHdOwv2XiRBFX26K+8
 EgyzvsUYDTyjI3U+IdBmARK3zDeWQJNOIKeG+Rs3pS9oYFyCbIGXUFXWY A==;
X-CSE-ConnectionGUID: GhvM+xqvQW28dZ/RQq5tdw==
X-CSE-MsgGUID: pLlG3qcqTz6U3XN1YBKdtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="65449792"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="65449792"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2025 22:46:55 -0800
X-CSE-ConnectionGUID: MJNz+lOSQACmNULpeMszuA==
X-CSE-MsgGUID: c1Ka6YmaTue7Ktq0GdaQ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="194475033"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2025 22:46:55 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 22:46:54 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 16 Nov 2025 22:46:54 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 22:46:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyRGUSNFAzVuykx0iWJRmt94EvGF8SFhPt3dH7O9p1Qffjfg1rj9xfD2SFA0U5sKainuuODxWaiK5Fov6uoX+o/muUwmSP2qMPdF3edzbB47YEv9xIgp9U/Fmb8wnoJJU2HX+FBQwkUBkHej/8+z61K4r7dMUoGJV02Tg8gN4mrGgToT0dYEJKvhl1MG6J4UrwRsPWpyMAlloT1AUqwpq++fxaE2UNYFdLzOcwwatx9LOuYMDkA5fngpssU+ch5lhvuRL+I808uquF7ey1V8NSPiGSuJ5Dhn9Js/Kna59YNcWYTUWURtGxFUkeVZn3SO6hnHPYboc5bMm98fGsm9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wveMhJdjMxR1+jjddHKv0kuiYyXGnkSYk0gHAf421CY=;
 b=WRxZIBOcTglIZsGtYEv+2OeNM34wvOLF/Sgd3/yCQI30uptzCF6RZf+K6eykq2JlhFFDXIG8odYRgBvLBAZkqvM4zUXXa9kJXrJ0lOVJW967BWY5LUZBVSbycnPmjEu7gIIFUNCg4yLTiEoxfCMUOF2EfoukBoeyQuAxr+D4L2HpkM5/1XCauEpgnth9rpoXTOuHJsMtrm+xXZ0zJ2Zwkf1j8TyslfJRAnyIi0Ch4rkP4ZRyEYlH1iaymO40O1kIjX9ZulF/Zp9H9cg0NYYtpgLFTaOT6UTlfZQ2wjLEBGba9dp8HcjNheZi1O1+UfdLHFRYahyVsmJWh6U30oaqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f15) by BL4PR11MB8797.namprd11.prod.outlook.com
 (2603:10b6:208:5a7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 06:46:44 +0000
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::576b:ce1f:299d:677d]) by DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::576b:ce1f:299d:677d%4]) with mapi id 15.20.9320.019; Mon, 17 Nov 2025
 06:46:44 +0000
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Loftus, Ciara" <ciara.loftus@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] net/idpf: fix missing offload from conversion function
Thread-Topic: [PATCH] net/idpf: fix missing offload from conversion function
Thread-Index: AQHcVKzmZ6bOSJynHEm7jfEzIfrJprT2cbjA
Date: Mon, 17 Nov 2025 06:46:44 +0000
Message-ID: <DM3PPF291EF9BF16AE2EB6DB4623D607D049DC9A@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
References: <20251113145021.3793930-1-ciara.loftus@intel.com>
In-Reply-To: <20251113145021.3793930-1-ciara.loftus@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF291EF9BF1:EE_|BL4PR11MB8797:EE_
x-ms-office365-filtering-correlation-id: 60384d78-c734-44e6-87ed-08de25a51275
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?05qV7jQOjTiYWOl8rn1LVlKOGrSUlo+E/Q3xohAslUY0gkjxKfClsuJnyHjx?=
 =?us-ascii?Q?gRsmf57i+2nLbj5mk7wGQhlsEN3EsHx9eKAiAL4Ol4C29mfzVzAXAh7UK2XN?=
 =?us-ascii?Q?L8irrwAjZ/u/yhpPMHxWbz2z6KBbH3QccsWZBuiGZN/nAzuPxQneYDVdfC3S?=
 =?us-ascii?Q?Yn5m0hgAEQE+Do4R1dt00aCKrRGjFf1lFeJ/GSsajm5wpL9ZDNmlyC5CL78I?=
 =?us-ascii?Q?8YB0ZXHCoIcWaXrqE/dvDeLEmv2peVVwRoiYpEkgE4tPFVpUFEAzxL4JcIyO?=
 =?us-ascii?Q?4W3hDtjMW9aM+IHM+RgX5LURwPeOcDAN5mBMhGFe71tRJC1WVN773H9hgpVa?=
 =?us-ascii?Q?BDU5XP+aHzIQD+NKDLA0k722ufLvRjhukkYA2oCFkh51m71bSOEJKHwYBlEE?=
 =?us-ascii?Q?uBYe9qp5AJz/D0q+OetjBVxOe8+z8GFuKNaDggC28XKzmliEaWnBIZvHrivG?=
 =?us-ascii?Q?X2aFXNIyl52BBB9jep30y8RXDiuBEraZfs6HY6EBFKhEWbf7qeXtKFoZrpuw?=
 =?us-ascii?Q?Cp37W0D1gLXfOhuJ41f/wjmPqroJtmj/uxFbYbw+hGHpgaOIN0yVO8gaogzT?=
 =?us-ascii?Q?XK+K+Um/kfKHYnl2BcnwhLFa81nKLqRX51oNQieyYYrCFTx5AYPgJn5bex2y?=
 =?us-ascii?Q?4utxLiW2JimhAOzCcnp1tewspCE9b9v4zWtukoFfjmJatmvly2hIdaiQWCE5?=
 =?us-ascii?Q?LfQDqjaK+8MPxDnPT8xAUCekZDJzWTmTD95f6qZB1lNKBa59Xu/3srZtEQAp?=
 =?us-ascii?Q?0c0X3EaehZjmhT25sITqMoK3weBSDQg9JlkMkZgm443e+iqsDLsf33OSR/EK?=
 =?us-ascii?Q?3l9YUczEQ67i/wFagIgooS2baujqQ04evwvARHII9ANoRcR/TVos9IH3Ntvn?=
 =?us-ascii?Q?rcosZC4M43QPQdWY3Ing+S0dZYNd5CeuA6jgeO6XF+WhLvgCz1L+2sV+6cOc?=
 =?us-ascii?Q?KmT6WPXIojBdeRuJr8GHjoy0vWdDx/sHuq3abAnCdzzZVhvMLhq9Z+2Inv9t?=
 =?us-ascii?Q?pLv1D9ExCzITJFT/bAQhe2tUOcFBVrMbn8hnH029Vp6+6uvnpKKRL5kqdtnE?=
 =?us-ascii?Q?IKNojKUjkI/E0X4bB4qee1eP7/www1MXn/K7e7rG1kw8wXNg+OH8ho2OPNzc?=
 =?us-ascii?Q?KBnVdbnuKX1Z0HpcOR/5dT2iI2NJvll7FmKhRi0vqnMW2Fwon98f9o3zdt35?=
 =?us-ascii?Q?C4j5KlVBlsBLZ5I23zHhKry+1dmXn8ZXGKFQyQXeyDkGaDVjTlVdlNlCuccK?=
 =?us-ascii?Q?iXE00BWu3iBVJdLRgzs/ZBq2JnpoGVfXXTs5vvjnOm7cC2AwtuoRz7HO7rYS?=
 =?us-ascii?Q?PGdiqaIrOmkBVo+PdJo5iuFWXQS/zM5IfjImtaOZceUac2YsxsNRUKrttlAq?=
 =?us-ascii?Q?KWCU/aY8gYi/Lvd+qNQ3j7LNBoaFyNB0bZeck+ymPP9oeDAGNZDnqboGno8q?=
 =?us-ascii?Q?Qj5gW3NF9sfeCONdkEVqICYv8AFBb6flJOB9szZYn6KGAwtVBS3sFVAo08pd?=
 =?us-ascii?Q?OZlOMHGdEs3GhxY8aiyKsgH2sZgVUTaq5cT4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF291EF9BF1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1+RTo1gmgj6B0wINVAh8sFjm/Uf071ZyCZuxe7slQFbbkgpYT6taxJJztz+P?=
 =?us-ascii?Q?HtpYrcVTAzuoEu3QzGOXbTEy9aL7u/5jtgiFjw04kxnxwajthQFhS+w+nEzA?=
 =?us-ascii?Q?FDuzQXEhfeumafMK49CRYE2cQeDzxjAi5hQVl+GTWzg+Mz0Of6yO9bg8sbLH?=
 =?us-ascii?Q?JS/GqQ96Z6lpgBTU/9cpST8743U+P15ZF8IJ15/sdWuP5QFMeyTSRPp2/dhE?=
 =?us-ascii?Q?EQHJNgLcZTDAoeZXG3qPON1cTrTlhc5RL7ZnZ7EWiYqcZfyquo4xXk75jmoR?=
 =?us-ascii?Q?68nTS6XkZyikmECgZ13f61DGL4njVI/zWvZMXxAsmxn3CbyXbp9jlaYEwmjT?=
 =?us-ascii?Q?VAZyLz9DRXa71o3c0YRa4EEReFRZbOA6na6+Ss53Im9gb1Sa9ZUbVezt7sDF?=
 =?us-ascii?Q?KlLt074Xwr3zxAwm0FBNevSFp6KxtKMgs6UJBsemINTuQj1OC8RFK0+8mCHm?=
 =?us-ascii?Q?zegDgnAE0gjrqTUhTxatHP86xP0/BUTsF5HQzU4Mb29xN1F6JQeyPKhUCBvq?=
 =?us-ascii?Q?XPbQYIabkHkI/94pkYFwqxf1xwgZNNzbVEWSufkxvo2elkGAUtt9Uw/uDk6z?=
 =?us-ascii?Q?jFg7c+087WR/rcKbm9710g7mkot2A+FpGD5rQjoIuFJOyoUjjC+/JXeMFwCj?=
 =?us-ascii?Q?3tqRz7jvw5CN5jJF4h88bvDWZmfp5BWO7wQXKdlbWyw3WJOSWjePG4eaYFpr?=
 =?us-ascii?Q?yQP2IAnqyORCYSMYYLzB7dUU3XVqdjuqtvyhqjyno0q+rsnTq8xG41OAsm9L?=
 =?us-ascii?Q?zEbcWI7phP6K+Jd3LLhi49aOo0e0ao72Yk/pJMBkrW7PIfa6JN+pP5FdKJUU?=
 =?us-ascii?Q?VVy0VvjR03Xvq3I4/Aglw6QyS1cmdSJgjFpbUOIswoBZn/fY4iZ1vIsKrTOQ?=
 =?us-ascii?Q?lhnba0ImWIaSxWSUt/pPaL9l4TA3qJwRqzVr4qaL3C6E9aJGcozTqqtY1rXn?=
 =?us-ascii?Q?pj3CXF3fq39L+pKvRQH1cvcsICDnVgfEaMx8bs6x9GJM3DP0Hu18Vovglfcf?=
 =?us-ascii?Q?bPpi7pJbXs2LW16lTSh1Icky/mXTd+PIOAVP1Vz2r2/UL9youeYv3BbGCXI5?=
 =?us-ascii?Q?yV7g51lWWRwEmPL64Uig1AEW+SKbvrBtLx8zkwLKF8ss45fx1bNQuIAbNqu0?=
 =?us-ascii?Q?GIWxtvmw8UyH8NjpOZ+p4ihC4QOwWs6Kkao13tvUteNovtaqG42VVefKsndN?=
 =?us-ascii?Q?WJXlutJJBnTFx7TNhThbhLHlcYFX2GPUDD2T2O1WZqleI79TKZ1JQtpqZqKR?=
 =?us-ascii?Q?S066MFnEz4Kw19kmaqlXs3F4M5UO6Kr05KiwMnBerLGwwAdAyrVB3uxIQxph?=
 =?us-ascii?Q?l3QacYWFeuJiaEUEG/Q7PklC+0esiT1Jpb3ZCivOuLRuOdjcALsHsAhWlUU0?=
 =?us-ascii?Q?yuLWzuvRp1Xgmpg2Cp7sTWub3nsmjm5IZg0XhDjyCOVBo3WzzUJA9YLP9Ugi?=
 =?us-ascii?Q?bTFJkwaotj++2f19LqR+o4YlH73RwJ4jI+g1eI7DcTszoXBhCexRgmrKFAmV?=
 =?us-ascii?Q?pM+pDjD8fqTnsixxUMTKm2iJG9DkIDJcCstfmJW9FQjj5g7MwB4CZuhtzWk1?=
 =?us-ascii?Q?4eyARq/Sofgd7RLA0oIp/cxaDQZxFgodE6nYvVBo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF291EF9BF1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60384d78-c734-44e6-87ed-08de25a51275
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 06:46:44.2648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6a/GIQqRqxswULYh+1ha1IyU/CEZeuR/JRojfR5NFcuNHshgHsMJ9wullny5jRAMwytquKJ1ejZpGvbnSlPvXpUvdfXDsMEg0OdBiYZtM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8797
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

The TCP_TSO tx offload was missing from the conversion function. This was e=
ffectively taking the request for that offload out of consideration when se=
lecting the tx function. As a result a vector path which does not support T=
SO could be chosen when that offload was requested, when instead the scalar=
 path should be chosen which does support that offload. Fix this by adding =
the TSO offload to the conversion function.

Fixes: c008a5e740bd ("common/idpf: add queue setup/release")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/idpf/idpf_rxtx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/id=
pf_rxtx.c
index 1c725065df..4796d8b862 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -42,6 +42,8 @@ idpf_tx_offload_convert(uint64_t offload)
 		ol |=3D IDPF_TX_OFFLOAD_TCP_CKSUM;
 	if ((offload & RTE_ETH_TX_OFFLOAD_SCTP_CKSUM) !=3D 0)
 		ol |=3D IDPF_TX_OFFLOAD_SCTP_CKSUM;
+	if ((offload & RTE_ETH_TX_OFFLOAD_TCP_TSO) !=3D 0)
+		ol |=3D IDPF_TX_OFFLOAD_TCP_TSO;
 	if ((offload & RTE_ETH_TX_OFFLOAD_MULTI_SEGS) !=3D 0)
 		ol |=3D IDPF_TX_OFFLOAD_MULTI_SEGS;
 	if ((offload & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) !=3D 0)
--

Looks good to me,
Acked-by: Praveen Shetty <praveen.shetty@intel.com>

2.34.1

