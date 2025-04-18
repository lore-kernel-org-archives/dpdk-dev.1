Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9363BC369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 10:42:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B385402E2;
	Fri, 18 Apr 2025 12:42:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id F0A0F400D6
 for <dev@dpdk.org>; Fri, 18 Apr 2025 12:42:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744972966; x=1776508966;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TnYn+MIMXtaEeoxB2iYOQQXvHH4GAzPtUR4eMz4Zw08=;
 b=lmYqfz9BSFOUM2FMo/XZuk/gyBvk7kxqj46CfxdLYs+pVW2phcnXxYQC
 aASlwUHzASKG+9cYxaCBcFPMmd/7t5If28rdOdSEOAWXxOJvrljHzAEOT
 BlzZzhu4e4IfFV0zLNupWxedVApMUpWC75HcamAjvVqNPEPzUVSgw173L
 Frjoq/0dLn4u039vwjw2EfB8T6f7uUkqdVznnxrkG3EQMnJdExathYa3V
 Jm8bqaZc6+8faA+7dIqCDxdbaVDZnjT0W6PeOHd3SMlrGretzSQW4NBNc
 59vaMWtLYVdpYKw+cmXPFR2y25VeGwBcMxhdriI3XZxxPRHA+sRNwZA2w w==;
X-CSE-ConnectionGUID: gXM+LSmyTzuwRkb+qzAMYg==
X-CSE-MsgGUID: 5bnOyxPTTSWbqiusheKHMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="64004106"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; d="scan'208";a="64004106"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2025 03:42:44 -0700
X-CSE-ConnectionGUID: lok79PsZQVKjiBOSeGAnTA==
X-CSE-MsgGUID: JcvCqQY4SPmyJIRuXbCeIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; d="scan'208";a="135937833"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2025 03:42:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 03:42:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 18 Apr 2025 03:42:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 18 Apr 2025 03:42:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPS+b9dmzmffhBb5LMpMWXMGmtMaF3LC/F3UtRrbmAkKcFYFtd5xmAD7BQ9n6R5sdGDDwuS49pMQ64Alto3Q+8My3m4zoUFBgGPqV9joJrnvvtZW9woGe4h/S7CGyTIj5ADCiOLnxupeOGVo5cdOwjBkNfmNtvNAYpSqaRQymA3gc1iyHRvsEfMVUINP1CdK0L+sOsx+sBxkEFObpstsGfmpmkN5g65eJcdDUGxxS02rE6VU85dXWOOiFTYSsiU7FnvhTwgqxIQkyUmmTM6XR/nak/OYDxQYPmziKjdfbn5l367cg4um6ArIscLntnpzS1Pp71OeixaljF6Wa1PPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnYn+MIMXtaEeoxB2iYOQQXvHH4GAzPtUR4eMz4Zw08=;
 b=JVLiwJ/ndmRpaG+G0/qCL7dnMgel7r0/CC3c1YCn07YnnrjdOEDX6y1/yQqDRQ0lr7FawVh4+38W7IhggHygmomH62bi6Rd8el/CTqJRQCQMv5ZlKtz+boArPuXV/p1SIhmnKYgcM36UWpz8ygaSOyXZ/459NdZgNaR+xOqbqkrh1s1NfqeYb+Rt8bI9cPGCY2HII9aUZ1YzzSFeKJQQVIeSE8YeoykB/Ijolh62oB8j4k5DJcsh0VVmKsNvRVY4WEE/YKju1rEDxd5D63mfmhlHfKV2G8asQGRoO9In6ZyhNRQ0w69Z9fQQGPQFXZuQeKqgQKdjXRSH0N5LP4J7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20)
 by SA3PR11MB7414.namprd11.prod.outlook.com (2603:10b6:806:31c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.30; Fri, 18 Apr
 2025 10:42:22 +0000
Received: from MW4PR11MB5912.namprd11.prod.outlook.com
 ([fe80::7a4b:e159:c4b0:7c21]) by MW4PR11MB5912.namprd11.prod.outlook.com
 ([fe80::7a4b:e159:c4b0:7c21%3]) with mapi id 15.20.8632.025; Fri, 18 Apr 2025
 10:42:22 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: "Wang, YuanX" <yuanx.wang@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Wang, YuanX" <yuanx.wang@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/ixgbe: fix port mask default value in flow director
Thread-Topic: [PATCH] net/ixgbe: fix port mask default value in flow director
Thread-Index: AQHbsDXhd2G4QrGZ8Ua72KPlQdf1t7OpPDRQ
Date: Fri, 18 Apr 2025 10:42:22 +0000
Message-ID: <MW4PR11MB5912DA7DB0D41DEA230127559FBF2@MW4PR11MB5912.namprd11.prod.outlook.com>
References: <20250418074309.705337-1-yuanx.wang@intel.com>
In-Reply-To: <20250418074309.705337-1-yuanx.wang@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5912:EE_|SA3PR11MB7414:EE_
x-ms-office365-filtering-correlation-id: f6c6138f-8e41-48d4-6355-08dd7e65b371
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ZK386B42Uxy+SUaBXwCWKmsokbGazVyhBCxdYeoIzsj4kaPau6aZpYfjJBfV?=
 =?us-ascii?Q?a5BY27eeXz2KxA/Ux11zNvecwzQmtRu82BCMlCWWpQ4zTdvOWrH3WwAfczUa?=
 =?us-ascii?Q?wKX1mY1Aec/3MzkQNj0OFDw4KvHbBDfjIeld1bGRL/feIcXM82sPa/AKM3Qs?=
 =?us-ascii?Q?QzzqxNqlraXF+ZOb8IvK7cYBBvzWV3Hfnmyf7PXXExEmsODjwa2NWYzRyKqe?=
 =?us-ascii?Q?UHPX12lGbvQEGGnXkkhJZUP+cywO+EBBSIG56INl2UjALXXaedFOv0IdNY7N?=
 =?us-ascii?Q?yu3VeF+4JhKAfxBrfsbNLY9S7Vc4SGddkZ92gQK/G2WcpykkQ6bo5g5PbeoP?=
 =?us-ascii?Q?6l1IWi/0jpzUhDCXDoBxwlkqCP9qmTAKB+SNwaer5X0hhUeIfI3Pa6M82NSx?=
 =?us-ascii?Q?/4rsv3tjj9+PDxppwE0wAPw/kjRDy8KHyv2k/njoJooLP9X5qn7E2g27ItYW?=
 =?us-ascii?Q?SD1YVJU+I+GJT1JYLucXPjNru/4WFxR0usiYN9Ot0Qc1CTLcRIevLnA4sgcB?=
 =?us-ascii?Q?gUAzbovkvZ325054//H63cGiAUdFbeYVN4mKeQm+Rw7LRfGqxMPFKXr61D8L?=
 =?us-ascii?Q?fsnbLQLn1gwiFA1/nViCLodxKmU+VigMgZPqrfGGwKqMR9QsQRf5d6so253e?=
 =?us-ascii?Q?AJul+vdVcwO8iAORtnLvNw9I/O+lIYY2tLRVh0p/T033hFa0jRu7vZJP8Qf3?=
 =?us-ascii?Q?6K6JZzMcGfEfAUbl87+oBitSFuX0pIBpYr0md0XSQSWnS7bFu+YB7lWG70vN?=
 =?us-ascii?Q?DIPID7nnQhOmcKRYpQnqO/wcMna9FSSy0XMIzF9KQEjHR0/cElLzVQK8HBWD?=
 =?us-ascii?Q?EVvVYJzwO6P5gYzNVj5vvYBZAl29XHWEQx9ell8w7RO2b6f6uafoGbkvujEl?=
 =?us-ascii?Q?1bOLbibmsPiL7RdTDuSR9IJE98pTZ52Ztz6AJoroWynwv/mcRzbyVCiLO68a?=
 =?us-ascii?Q?GLg1hsG8hx5wTOS/lgJzeyPWuNvqFC1N3A7ZeSDvE/Hj5352nBBkmBYHkez8?=
 =?us-ascii?Q?d44VG0466OVWvOHeNCGJbqvGt2/Xx7nZIbbR9UxWoCOAGhHeCpHpzSBoO1SP?=
 =?us-ascii?Q?kl6m+CytHjry+BxCJkYv/D6R4bIF36aLLD+Ghn7Y84FXSauq+1wyo/htTylQ?=
 =?us-ascii?Q?G7xcP38F9w+GHlEuElJUP9JlLUvYbJqZXjxMmpqOpdomBEuGrypjxDLJvNha?=
 =?us-ascii?Q?1Y3HGGGZItABjodQQsCd6sjlZhkBXw5Z1lRqrvHLBQDN5KodJXpPQH9GNVVr?=
 =?us-ascii?Q?aIp/PdMhCbtB7rUjUuWe+YF4JMbka/yrb6UD8fsRsRmZttcbsuRfhwgBMObE?=
 =?us-ascii?Q?xXzJUHv9NGvHlVphF4jD0OH7re/piHglQ2O2spcYD3GCxj30SxrrxSqoFwHU?=
 =?us-ascii?Q?xGfV9QpMuuEkg6u05Rg1GU4eDG64IMqDm/iXQriJ1Wb88s0e4yVC2k5kRY4w?=
 =?us-ascii?Q?wh9keVletOnS1C5jNmGNvluqYajLZu4CdH8RlDyIAvA7UvowG0EpWxeQwwkr?=
 =?us-ascii?Q?/6ebXcB/RjA8RcE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5912.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2RFgNK0tfMONElKgefGE8Kg1gDJZwd7YTagN0bOM18rzAWDrjln9bSfBHd8e?=
 =?us-ascii?Q?/SE5soz58TB5oo1Umaa79hSsusdaNEIM46TvqESv4OQ31PkApZWoLRE8yQNw?=
 =?us-ascii?Q?gOhjICOi6+KUkHnJSv8UqbpuUNdJk3w8hnVViWsB2N1MCm5IEXtj2RqhpDLK?=
 =?us-ascii?Q?Qvz3axi1r33oTOnEu2k7GpfMwFA4DwMZ3juFWEOcrjOuxE/b05oVQSczZKcR?=
 =?us-ascii?Q?K0eNGS6iiCcZIWL4FYao8ezpEMx0eqraNt1JEe0EMFYWvZY9sLkL/iAo/cRh?=
 =?us-ascii?Q?zUezyz4kghBNCjkFzl0pViXk/ANh6tBxvxuJZJdPD3o6Mdq9ic9Z8WHUrVfI?=
 =?us-ascii?Q?NsLxJmdWUwyUIm5hf0JywYYpvfZ9M4+0rSNX3YHo5MbW9HuvzGpH6af8JY6c?=
 =?us-ascii?Q?5ml8Dm703uT+oTR0OW5tpiAqLpalI11wYtIrKC7EpVDQ7CGf44maIcpOF3ct?=
 =?us-ascii?Q?B+qAgOdiWBhPMCMpHv9r3VfJbYvEqq9F7S5W96b2D8tt38auWU4ryc1/srmM?=
 =?us-ascii?Q?I9FFwiS3gN4xVluxH/z6dLYoUG/rPG/sQyJy9p9uwR+HW3C5YSH5TIikG+T3?=
 =?us-ascii?Q?GgIfQvGKo3968oGZ7TnvnGXwONJGUpJd+7Ww/uKJ5R4cEam0BDaPA2Q4MGV1?=
 =?us-ascii?Q?MArZshhiqLh6m/UegOzU1uxgTEhFP0mdLx0DZnGO7xse5aCZgY6ZlRh9LTET?=
 =?us-ascii?Q?McoxusVvwh3NSlmthdWVAILcWHy0AptmWkiuxYFwhaAXNFEvP1rr08hNRbDR?=
 =?us-ascii?Q?VpXlyAawFzv4Mule2oTIp2pRghWy8YqnM/uO9eBj85OE1TkynfcuI6zZRfMW?=
 =?us-ascii?Q?mgFchkDJRoT7PFPDQZv3otQcUV5bKRKhd9WU9sagyR4sU1WACWterMzGt9XG?=
 =?us-ascii?Q?ss2+xu8s3+Y3YHDKhQ3vIueOuSMpl1tsw0DZPSoGPdACDgicz66WaxhMZlK7?=
 =?us-ascii?Q?h8XkJ+nLMDXdYMiyYsStti7H1CJRUs5p8VTzdAbuVvN6xEotMCBlH1qNzryA?=
 =?us-ascii?Q?QM5xJuQ69iNAXnSN+EMyKdrH0c8b3K7x+RvDZZOFHpcJZWWn3zwzAVbVgba9?=
 =?us-ascii?Q?41UVGx6Xxwn3yCVSy1OU0nmiWJkzZ+PjwuHFaoUFvUxz0f/+Ek7AQCSmmXUp?=
 =?us-ascii?Q?e3CsqPqRQsnXx1587pS4q/N0PGfs4j2+p9YRyGVjTnDrbg7yhx44l1VxHHgt?=
 =?us-ascii?Q?8hlAbiY6K/oYhMaqSCt9DvydqYszDFKUK0C9hK5DC+hv39kYapD6oSacYNbH?=
 =?us-ascii?Q?8QFJuctm7rwcRuduuOYjOXfGzihbm267WM6i3813LiMMFLbYWdcIlJj3Lp5z?=
 =?us-ascii?Q?TQK2ei6l6SiCx0j+siBW6omv8a7+fQB29HS3BA0gk55qBywBfr9BoTy2I5CG?=
 =?us-ascii?Q?74CdkpxrEA/tflDIEYXSPsM19i9/UezsWbjUsgYxGLfBPHlI3Uaw4rlBOWSC?=
 =?us-ascii?Q?r3cTWSKRWthePD9dESINrshM7ibdj/uy5dlfFKws60pElsQt/hYhgnrMGbWY?=
 =?us-ascii?Q?AWew2dSlzbVu+yckg7uRIKThABIzpErnHtcpl+EjcGZ+j1XL/6RNDIGOCARU?=
 =?us-ascii?Q?mSdkvCD2CiWQHlB+nVt/rT4kOEphgq5V1d5TDeKz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5912.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c6138f-8e41-48d4-6355-08dd7e65b371
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 10:42:22.3210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vP+ZlIyamm4W104ZHZEedqR2RWmznN3T1r76deW/iTZe9eabSAll3VjG9G/OECGsPHaX6OxUqtT61d5CI92XaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7414
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

> -----Original Message-----
> From: Yuan Wang <yuanx.wang@intel.com>
> Sent: Friday, April 18, 2025 3:43 PM
> To: Burakov, Anatoly <anatoly.burakov@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; dev@dpdk.org
> Cc: Wang, YuanX <yuanx.wang@intel.com>; stable@dpdk.org
> Subject: [PATCH] net/ixgbe: fix port mask default value in flow director
>=20
> The fdir filter should mask L4 protocol in order to process raw IP packet=
s.
> However, the initial value of port mask is 0xFF and the filter will not p=
rocess
> raw IP packets if the flow rule does not change it.
>=20
> Fixed by setting the default value to 0.
>=20
> Fixes: 444505f933f1 (net/ixgbe: fix IPv6 mask in flow director)
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Yuan Wang <yuanx.wang@intel.com>
> ---
Tested-by: Xu, HailinX <hailinx.xu@intel.com>
