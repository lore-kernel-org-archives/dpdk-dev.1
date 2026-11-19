Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B1606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bcRelsgG;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=HFoOltF9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A7D9402D6;
	Thu, 19 Nov 2026 12:42:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id B15D9400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 12:42:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795088563; x=1826624563;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wHPwN9nlSwTjplNWTcBd+hmlaiJTji1krqGvpUC9mBo=;
 b=bcRelsgGf4+V1QLQGb2PZ6Zg4p5aZUDFnzwPA+BCYZH+n3UeYW+n5DUj
 M1bOMFIqZ5dJnsXeeYvxJXgQ/YGLYdBE4JchJ4jfdXSiYY9/nvJaRHf1V
 ulfk+eiXk9P01Sxem7gPnwCpakX/BfKMKZrTCAoUimJhHouoNoPVMyQhh
 soxnN0XyRbDU+DPfZa01Q0iN+cfhXrNC1rTaV0xPYJ6tnQGBDogkZusqo
 aErKpbgchgrN0tkc3TWVzons6rn4zVyTJxK5d29xdVvwda7SqPEEUc0y2
 fcS1DgFKytXrj/WatsmeU8GaRuJjEPUcKkUifwwwXVmGnYj3MK+RmP57Z A==;
X-CSE-ConnectionGUID: tSCn46wbTySoXQJspcpoOg==
X-CSE-MsgGUID: xingvWW9QW6YmTzhKjB9MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3822244"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3822244"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 03:42:41 -0800
X-CSE-ConnectionGUID: a4O/0odSRGqenMiDBb2STQ==
X-CSE-MsgGUID: DZbBc8e1SY6w7iQmkC7O3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10504715"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 03:42:41 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 03:42:40 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 03:42:40 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 03:42:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhuMSKDyonrCZKBq/fgguw8UsW/MKYrH0qqPRsfyf+wRhPGU4tOK3CxK+jYkwv55UthPMbu5x9i8prTrjGXLcydXEwJaTHGYMH7Y9ON97WiS8kp+iUn0D05Dmf0Mn2B3enu7Flo47QoefmNdAKXexGvjwZkYVOLVlWInu5y0aSJTqdJ7h+BLMEzw07rMhMkIBzvPLnc27Ig3GW6FqAQj27z/tT92HPPO30zylAMYYc/6qLtuQhlrkUll/dsjpPSoJACNf0zx3W1l4b8F9rhUQ8JNAbaj/npeQjdIkZo4yLZAl+D+VAnThfne0XAYvBQBvG9Ng6lXfdE6HgR7bRDgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHPwN9nlSwTjplNWTcBd+hmlaiJTji1krqGvpUC9mBo=;
 b=dTothfksXa4mzooIkadiB4Qm2f1Yz+bHC8MMzbQDaiLbtu9Pq7NS8iGe8QDnpAE+fIsBvt2p8yZnHMLrlDJbTJsK5JcnQoYnIConTEh7sVIprLLTuVcHdca+SkMfQK9DPKLewQSQC3n6eMjzKyuz2oMbY8H/Qs+y1sHyJCtoD58dGtiZv4micjTOl2wQ/cdmmiDz/ho4wlvPAO80lZZIK/ZvqaXJE2ZmOpUzO7/Iec4sBuCClPHxwh2uSKAe/PE5m7fxFyoGBvJeaHPNel07CPyVRxgQ0j95VO9uTsZIcDMIgu2nt4sWOWxkAR7amofUc2qk7aRGEonYE72+Tejsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHPwN9nlSwTjplNWTcBd+hmlaiJTji1krqGvpUC9mBo=;
 b=HFoOltF9UM7RmOcxfk7pAj2fheUtO6Wz/pCm7l4pZAsYuGKFw3EfyxKx7Stal1irVevZlgRey3eCtvJK1ls+L4XACpCp+bIGneHnehSauSdR4rRTEPcj5AWP9uDykTaxkSTPP8vlxBi8adwDChGGyyFhWnZNcw5RuqQADkNgiRM=
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by CY5PR11MB6283.namprd11.prod.outlook.com (2603:10b6:930:21::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 11:42:31 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0615.009; Thu, 19 Nov 2026
 11:42:30 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>, 
 "Penigalapati, Sandeep" <sandeep.penigalapati@intel.com>
Subject: RE: [PATCH] net/ice: disable Rx timestamp offload on vector paths
Thread-Topic: [PATCH] net/ice: disable Rx timestamp offload on vector paths
Thread-Index: AQHdd3cVwhv2YAdpeEWKTj2rckn8W7c1RtUQ
Date: Thu, 19 Nov 2026 11:42:30 +0000
Message-ID: <IA4PR11MB9278D85532ED471D00F094F78E792@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20261118160720.2763248-1-bruce.richardson@intel.com>
In-Reply-To: <20261118160720.2763248-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|CY5PR11MB6283:EE_
x-ms-office365-filtering-correlation-id: 9a215f62-6114-4da4-37ac-08df463231ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261026140227099003|261028144727099003|261102123227099003|22082099003|18002099003;
x-microsoft-antispam-message-info: g5nB6g2Xu0MTL5z5DOwXScSMuyYJj2nJH3gmIaECHCUNMMQtzLPKaexrYCaZtTS66HhRJG56PmbPnFEZOgpuhjgkZKNZp/Kh1OZKXnHt6j2P5pG48uw0Rm1A9ZuzrhjlzJ0o1QDa8gXTrrpQV5uHxvmIDHoJkMjIaTmbdzNy7y+RpPXNZlaTZWOdIwFkQ74sSfKpD35PvtHVPI2W+hOs9onJxc8TDENZ4C4Ygkv0e0wYz/hYjrOXIeRepUeB78JKphs4HHBMFu8kbUR0HAAwTZBnZxeFdaxM60ZdP1PCfjmbgcTFgsQ3tagU16F545CJSdE/LZ9RblXaZ/ygh0O8wKmWNEWGhtFimKSLIeDAgA2Qsb+iAJyCtnBlbsw9duuHPgLmvZ9CSh9lKC6Sc7q+EfMDC9qMOzlrOAQoACC3PXPHP3Kq0ToHi23vI19/SVOYUczz2ytPX/sK8tOQUbZqHMzBGukQYipnYbVjwso9GPULGOgsir6EfDVUJKiGQiEjziikHYOtqEVvSbvZEn2fT/KXbCCfRIjY8K923saWKby2/bFYZwoHaNbd/KArbh7ypAy1+c/fZ4sD3Ao3FXcHewlbtsnyoNGVkklmC+oz9LGMmRRanIyCCLMfjh/P6rZJ0bur7AkZwz3lLZAU/eq75H7tcwI9j5MEYZPgxW3TThEsW3NdKrjugbNCYPFvPEIansXLEYulYWN777tFbR8a8NQ86+5roy4MORM9m389eMQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261026140227099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mDh6oaj/duTTE7OSOsWRllPLJcpNbbiExUTFtcGBBIgEDL9PTizsysMs13Uv?=
 =?us-ascii?Q?gql1xz3vHxw+EiLLAUymmevRki1Sy2cfZzc4UOqGu746XuaqqWv7UFayTBJm?=
 =?us-ascii?Q?YrvXOZY1HrmLUEvbQRyEW/lB/8qBjRpaS2q28DliLCghW6zzMmdKxb41twiL?=
 =?us-ascii?Q?WqooX10BfPEX6hHLqOCUswD4u98TKQb9WJeIJgtFN3oUoeF2vczMIMyHSvI7?=
 =?us-ascii?Q?Ns4JJmOGxGAuH+nIt5IRvNQ/zidNHcCW94PI6rW1sM11ar2EYX1L3ZKicyfw?=
 =?us-ascii?Q?ntVN2VuxnCqGSfYUgVHX1aWiRM0DXNPjuzKJctVSK7ZgUw2i66zCwrp1hT6u?=
 =?us-ascii?Q?VZZnk82MLj69tjdzj5Mga7gTPTd5tv/DSv26eC/OC+SD+PG38Cl0bkReQ229?=
 =?us-ascii?Q?oODRjll4k6dbgafa+IDG4gnicK43bNd1cO+KRNmT5OIfc1t/C3IicghPagoM?=
 =?us-ascii?Q?KT7ZNQVWLfgLpR0x4Do41V2KOEn39tHhBvU/MdCe69ifH555n65fDEyqUc1L?=
 =?us-ascii?Q?aH2E0Bkx5EZpNB8HodhUFDNZxcumgH9nsXCCRl3LnVmvPR2rixUDl1s3cmO5?=
 =?us-ascii?Q?a4drOWWsISvvyp6sznFu3+mF6RRmdL3qlULVTEa0omQ27QP8i4nurJ072+SH?=
 =?us-ascii?Q?h4B68vDaoXmQs64auv+m/yWFtpbwi2Qjafb4AEbTdhEW7a1OCLa2NRIIABR2?=
 =?us-ascii?Q?RMpNT4z4fuq094pfTRRBiGF+PGLJkcdu7lrdNashAPHYdgSJsMvfvpXb37Hy?=
 =?us-ascii?Q?MEK1mOXG9D950NGA/SJvhhsu321Fyumantx/1vhtQup6N25V62Uw5LpHLftx?=
 =?us-ascii?Q?s7KjF2FWE0w13XL6FbImAaRmItWxLXlfviDx3zeAS688VwnehspsQ8tTBVVL?=
 =?us-ascii?Q?BF52s8E5B/tO38hzDjYMLLeOmjyORQBWptntj3guhRHXxcMleT6FIyulnz6u?=
 =?us-ascii?Q?nDvjmK3z/+rHg2qQrUlR4MvFCQwhLcB56sTQUlvhTxXr/70LNuMwueyKlWCa?=
 =?us-ascii?Q?R9ChX/NyDTxJsKtLKLmEPGvQgGTyh8nas5lK902gd++O19s3Zzx4+7BFSix4?=
 =?us-ascii?Q?rQY/5stIIgEU1XTeaV1F3kVGrCKc/KibWhgEHA81QlyAC8BRKJoqZpaTDq62?=
 =?us-ascii?Q?2GejxEjtsIOqEsInnQD+NcLaobFP651fErvCzWUUX+9t+xc1zK/xy26jG96t?=
 =?us-ascii?Q?IF8Lbxk8aVJP05ykdbbBaAJhsYofWN9hIuKAPhdUhFp78C4buObImfBqBENK?=
 =?us-ascii?Q?LSE9ypsfV+X6pOR+3hboEEzIlvFqvNhkTv49Xbi6q/oBFwDiQ1uiC+SDNLZn?=
 =?us-ascii?Q?S4W38aPBlnpEs2QUmou/aOBJhfc3YVI9AJW6WaelxPlNRBCu0S5tCDf2PaVJ?=
 =?us-ascii?Q?nPc1lcJ3H3PIFeMJyg7AXZGxFBMuohwJNGuKEGtWCzyyWqru/7AAZ5kxoBWJ?=
 =?us-ascii?Q?T/nPwbRddA3ZM+SW/HAWQW6f/TnH55MItBVe9b3pwbe9+Gt0lrfrMIG1fDBy?=
 =?us-ascii?Q?fWalNwS5yDlcyu3qrr0bbSbAzC2R0xDkP61xvWtmZJhXhdRorUViI45zptGu?=
 =?us-ascii?Q?V/EoPtL7gOvmGcbwHULDWraYCKD3BXFEYZUdYSVTwVzxHDPWrUGY2HCIdh2F?=
 =?us-ascii?Q?YG1uOo4ADJRy580N9k5jcPcNF5Hvk9W9Kms4FRd6AqaFZN6dX4rkHDTEn/yS?=
 =?us-ascii?Q?FC3dmQRL0mFFFT5++x/dKGM7xxq40X2oxohQO+tWkVmzaHCPwMB8MDg6Qmdq?=
 =?us-ascii?Q?f1V+xjIT1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qDmLSCElpMlfrshxa8hFcnyAP3zEHeHJI0R0C53ow6IchblsNand3olApSEVXua1S84plgDNqWNGTHDKvzVpRmJcwk07UxeCxrf+jp+1R79r7rRAtJnuvKuRWp2DZ+kRfxGlTyflL0hGh93kLtn6mtKxHDI4Wx0gHyJgVRtPYc37MzWMlWNKWhQwVvKVLcNt07zOBdvGc/cXdvsK7ZON/y7oQCjXZMmhHHbKNyTPjEGq7l/Fc4shKu5+3VARdri5iudx/EYqo6AJl7wOKpL1DsU2TBtRGQHV6XAAImb0OVXlJJVJA5plC1p6vZ76ALEuCrEEBUrUSwu7byFql/iHdw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a215f62-6114-4da4-37ac-08df463231ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 11:42:30.5289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bcYPkos9GM/FxTo01R4DPkj12biwMnvJHuFHIoC9/AlBjpdrw9g+AHNfaOqzBAPxCOdmamezo/OJ1NL7TUXRuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6283
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Subject: [PATCH] net/ice: disable Rx timestamp offload on vector paths
>=20
> Enabling IEEE1588 timesync on a running ice port requires the Rx
> timestamp offload to be configured. Previously, having that offload
> always made the driver use the scalar Rx path, which is the only path
> that sets the PTP mbuf flags. Since Rx timestamp support was added to
> the AVX2 and AVX-512 Rx paths, a vector path can now be selected with
> the offload enabled. Timesync then gets enabled after port start, and
> PTP packets are received without the IEEE1588 PTP and timestamp flags
> set.
>=20
> Remove the timestamp offload from the vector Rx path masks so that
> requesting it selects a scalar Rx path again. Flag can be re-added once
> PTP support has also been added in the vector paths.
>=20
> Fixes: 332eb4ec8ff0 ("net/ice: support Rx timestamp offload on vector pat=
h")
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>
