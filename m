Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ADAEE208F
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 11:25:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C7234029A;
	Fri,  6 Feb 2026 12:25:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id DC8F140293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 12:25:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770377145; x=1801913145;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/4vQTOjFGzy9eITrzMIAMeZHRNB88Pgj6yxiG0Os02s=;
 b=UtjhBAUvDoYsRbLJJCbE1mwSh0HiUCqQZ0N2Q4CkePZIMoWYxH6Dqxjn
 YJQxxkLRCF7wFJ6Wr2ir2uqjlDziGtWIeSONn4Mp+unEavB1poJjkQBlS
 X9EchK5fMqVnNIAITJX6Z0RetzSAezAET5A1AFxujAbwzDE1+l3Xo0/LL
 nc4LNt2mQ2mAUwLN4YgqZ3eqju8cn4m8mSGgen5/1aO3a+C/MsGDEWOzj
 E2qRlQ4sQUkNF4F7fDdSpqvBFHH64RA/Rpy2hyGRt0WD2qi2aEndrsK17
 rsPnu/ApPtXgh5ycOkG0R5rgiXOZ6nuTI6YHoNXp99TI5gMQ+KZc7LEaM w==;
X-CSE-ConnectionGUID: Haasz4MeTXuq16EyXvKxMw==
X-CSE-MsgGUID: vow73OjtQ9CUCBTcwZaPxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71762060"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="71762060"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 03:25:44 -0800
X-CSE-ConnectionGUID: fdP0YUkiS926KrLqcKujZw==
X-CSE-MsgGUID: b6lXdD8HSauS0kW3kTwIaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="215017266"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 03:25:44 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 03:25:43 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 03:25:43 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 03:25:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRDbTQxS9wyZAomI9iF0LwFKgheGfhp0xx1S+mowMX40lwnbg0oaTj/7xyMO0elCWBJZYzBvHnhoRqn1ZOQr/YyhNEFf5GoE74FT8dYtS3D6J4jX4SqPP0JwdkBVlT3bJgS6nUvGrKpLda3Zkp267NFcj4/ibBvxcZAN+qI469tEwj/vwSGosQWFfe9cpaRYFx35KgMPR0aTaErPHkUw8i91E+norgM08E5SrL9oKt5B49jB4wSelpv5Qe2vqdFT0OFl7jcej757YPx6bFomkPoQEYY2GgSjpUCUFDqYIZF2+FdDib6/7+z8MfRQp7EQCZY6LNqp2IofrzDP4oFzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yIG7k5j3ITHMljc4apjTwvkWxPN+lrSo7tA2opTW20=;
 b=xZd2Mf6QEnDv5fuZM7PshFIndJZ5zOYl8wsn5mWukyS2mGbDsmGfcF2udTIx8m11Twx1JbgFssQ8UwvUOqkbneZxzMCkbYlNL2ErIsYMpZ3d1RqdJibIo0EpZ0GOJ1csD3WpjNiUJp6h5FWBFMf6EKpy5xPsNqNFuPT+U+ryzY2RHgifj472yjQ5DnX3d4M1rElcCY4hOIZjYMesBhSVczafcGzTafXZZTR4Cc1N1afZ68JDUIs5UCfQSj3oOjLL7/VbHZzWw8WQD9pLPl2RSQyA/6tePEQsBhR97lzNaVTRn8XCddTPPbEYpwbgJ4ZV3S99MOmXTCpsfoOgKQ+e0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by MN2PR11MB4725.namprd11.prod.outlook.com
 (2603:10b6:208:263::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 11:25:36 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 11:25:36 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Wu, Jingjing" <jingjing.wu@intel.com>, "Shetty, 
 Praveen" <praveen.shetty@intel.com>
Subject: RE: [PATCH v3 10/36] net/intel: consolidate checksum mask definition
Thread-Topic: [PATCH v3 10/36] net/intel: consolidate checksum mask definition
Thread-Index: AQHckd265G0WFjVjE02oFekdCY7HhbV1jjRw
Date: Fri, 6 Feb 2026 11:25:36 +0000
Message-ID: <DM3PPF7D18F34A12FEC34AE8A326C0E0F928E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-11-bruce.richardson@intel.com>
In-Reply-To: <20260130114207.1126032-11-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|MN2PR11MB4725:EE_
x-ms-office365-filtering-correlation-id: c4e1e082-dbb9-437f-0d79-08de65727309
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?KMhGMU36bMFd9JK6lpWxIF5qlORiyPiofBACrkZChCFgJxZmPp4AbdHjJ7u7?=
 =?us-ascii?Q?VNsBPxMPA/ZA5b1PykNcRF4SiQ8As9q7tA0CMw8feEIadxp0F9pTmir8rFX/?=
 =?us-ascii?Q?kfsdq2mKR9AQ3qAMipHkqdUyG3hYZs2vdlMbJX2bnWljz1sTaGbFW20+HORv?=
 =?us-ascii?Q?HDdiWQwz+HnAAfGvzMq0lUAeEaly53jlUgFdZkrt+MAWPuZ88xQ8/btdtC/g?=
 =?us-ascii?Q?CH8K2AI0SKY8nQTrpRFIA3yNLfGBU2VuZPDMNXIA6FfL/SJQKqG5VQH1UKAI?=
 =?us-ascii?Q?Mky2XrjzgRJLby5+rh5Zc4k60FzLy0DXxfvMRVIva6auxjS1GHu0mlE2JiNN?=
 =?us-ascii?Q?LtbwDD9Io/7wakVnTxnq4AGgg1LAPakymNn1R4rQ5wkvzVsRfg6hqcgqOtnJ?=
 =?us-ascii?Q?d+KdSyG7XvSQUTVZKHQzpwvEa2qbZ4F2bAVMTpNn+JQd0F/OlhG466GvcgWs?=
 =?us-ascii?Q?3NepRUtIIsRiC1uaM8dm0cTPZ4WL/FgZOnlDfn1sryaVy/Pzf4zIt3cKYigK?=
 =?us-ascii?Q?1o65vVcTE7miHfi3y415Lf0IIY87DjgX6ZV51RddpZ2jAIxQwP2KYAit2GIf?=
 =?us-ascii?Q?H1/gFKAEh8zojldAdeNRmsW0fM++VzGsk0iUji+j6AhVjue7HryIPZx+Q384?=
 =?us-ascii?Q?rMugDACPO33qX2z8lIQrlnUNYapQ2OEtydz29LKzjxDIxt6lC25SFVZoEvj9?=
 =?us-ascii?Q?cyoHH+fUMT7ev9vBqZmtESVonyyg7kv1EfP02tfYK6h7WcNSvoJApY7gnIf+?=
 =?us-ascii?Q?h4P36rzq9nshvAusifJy8kKZu3IRTOWL5q2MVE0DCytEZZbINGt06xpmn9lE?=
 =?us-ascii?Q?SDq+8+hNtSFzcvRlxHnAO/2IorQuasxK/3mdJj1HlZjTnnIOQ+iQEkO1pXjw?=
 =?us-ascii?Q?0hzpxV/Zxd5CuocKO80p3qH4hNOPR1RcwUGlF14d65d0PwkOd573gbHL4JUU?=
 =?us-ascii?Q?n+8qL16NiFY6ckRfS+tEooGZoopjdJFORnr8RNiEnrMnQlRxcgJ31MXdR5fv?=
 =?us-ascii?Q?ee4Lc/+6Cm1u/qFAsT9TWD0XClH3JO2XkLCCNjITkmN8f3A2BUGZSgWa+f6l?=
 =?us-ascii?Q?NzuJlOHmsW8U18F/ZuNyWaorF9+5ZrJjW12PHyspnjSL29Ni25xa8UG3F9UR?=
 =?us-ascii?Q?BR770fV/Ci2xpdkfnxNoIecJqPa2zEVzErBDM0RySIi01S+UcduZ8G4IK7U9?=
 =?us-ascii?Q?+BhNFh9ohgh5Rr6gkNMck4tekAQuaHpN8s5F1h9Kd825Xk38JWsmta4+itDT?=
 =?us-ascii?Q?zu0bjzbUGmstW9qhz2MDuH4ubFYyH39zzROmM8eFFGyeRJxEF2dUWMpWg9nP?=
 =?us-ascii?Q?r4YK1D+JWn7AG8aMY14hJos4pkWxOetfwBd6rGKF7BsTqwd/PWjUPJTCYuvh?=
 =?us-ascii?Q?IHZHX9LUY97y69eWE15tlCPLPORhWsYR4kymWRuiKU+zV54WFcD3K5IMJVrn?=
 =?us-ascii?Q?VkbFWpPXzVk+V9v6IK8NE1o5OZ5FgmxqJkDS6/iDmi4AbzLPd/td/uGJyo+j?=
 =?us-ascii?Q?GPj+V3MTCZrdXSfG4f2TB8kdGKUXpE7YTtW1dRQPNUYOUg3ZDzRTfnB0ILdZ?=
 =?us-ascii?Q?7Vqz+S/amnTGTChOEKa6WC/gE6YV7MLlWrIXOR1Gr/4Lu1Mc45r2iAa1d6OI?=
 =?us-ascii?Q?Ern83VLSyx05iDbnyP45R/E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BFV0ktQOy1QZMK5Cfz4pSJb1h1i2bDZ8j+GgA78mkXNGElVU+kkwpaSz/q/h?=
 =?us-ascii?Q?bzWSz7wUOVydvji8Zyg0nGieAc2EMqBZ78Zf9++HSEzZQEBmZsg7rOfnKqse?=
 =?us-ascii?Q?I/EmoxVTRXCkTcXoDHDsjriMAEHqASjMLaS3hwegNJYhbulS9loYp3DXBHxY?=
 =?us-ascii?Q?iKca3fHn5oD5CJ4VJac3qot9MH+zvwiB4RNa5FA7HBQlIa0tbaTrCCXsvGQ2?=
 =?us-ascii?Q?GksJhDhevjDlZuyJMJNjB3P2qH155p30bBQ1np/fQE2n1Bkx506w9WuP6Vk8?=
 =?us-ascii?Q?VVqnbUvag0SyeNwrCQGEFZMpXW6Wrz0IB8r88EO841Nk1r+qsLz2Uq1HooMV?=
 =?us-ascii?Q?uVuvu6hHER5n4TxGIzvrwJkGctAOWZyobTn12WLAkn+1p2t5uXQGNNe5JB8a?=
 =?us-ascii?Q?w241zwnCwmNXEeU9yrFZ7PYTOnP8tKJfmxrPya3qj+nOhM3hfMkgmT8zpm5t?=
 =?us-ascii?Q?3JN/VAcYBvUdHQNEeg+KRVnns0kFE3iV63o/C/JS5OOptUzz8uEpKnsxFFJM?=
 =?us-ascii?Q?Wu/4H+YuaAro0MFbNsN6DTHhzQ/xS3W0TKLVmZLQHGXnILMQSrY/RtfK6Tkc?=
 =?us-ascii?Q?diRuNdwX89eBhB8UEFxEaKdxBIOgIweBo6U0p+hySo8jvcX03TmVpmBx4oko?=
 =?us-ascii?Q?pEn6qxXorN6pfPwqNHfqzPOiMFOeNgyyQ5XJXCSSQpVEgwI49DygyicfUxyD?=
 =?us-ascii?Q?5NEz20+Y+ejKtv5MAmla/t/gMxOrQGdIAjqfAt+gZDpDywoigQD4e2kU3bvk?=
 =?us-ascii?Q?twhfRZEPqplPrH/O1Y5EJdkfmojZbQ1VRp3n2o+hdXrDXrFQmvHVfAb49z0X?=
 =?us-ascii?Q?3p6YYXPtNW68LLzT9kZv7yzXC3DVkRzAxm12TJobnwQErd2BRXs9mubNXHCK?=
 =?us-ascii?Q?LCKPARJdmVzDwXU3OVi25W/qVYjtv0+zzAo6QmKMrmgfoJc9xa2Wr2I7Rf8C?=
 =?us-ascii?Q?sjmc/OI/D8U51r5XFDWvbP6RUXxFAmIY/YiQorGun50YlFHOGxjLPinhiQPk?=
 =?us-ascii?Q?XGdmZTVmh8NM+GlC9k6vE6tdG+vVXSRvmsynDENdMiEL7bpojHRa/gJTkUCN?=
 =?us-ascii?Q?WFNWTSloZzq4WqK2p6B6Vu0XKrs79vhkv60LJfpfOv9xATKxhzOeNoAalUIm?=
 =?us-ascii?Q?lpSMZ8mGetvyD7P8A4qifRQS5iywK4TzBknGgWFYdpILIg4P5DaL+sckB6Fu?=
 =?us-ascii?Q?/68fIuSyx6Pt4TGqdhJSJXD+56SQFNZSr1DO7vXh1aLYHaMMOOdkOB7ngKt7?=
 =?us-ascii?Q?7U/Jj8hDhrRVKcFYl4LN8XKivwvDyjqs7uNCkVJzwhFMOoFUKRRh4P9rBYLW?=
 =?us-ascii?Q?YszzRWq4TOL5syvD8NArO2UO7yn1krbGVuaxOYE6/2YNfsuewvr3Hh2o0CQ6?=
 =?us-ascii?Q?Ko+qV7JQT1ySInLDnJg8Z6ZiMhNPHB9Jq1a5XlRNK6YFixq4r+FPejypUMIz?=
 =?us-ascii?Q?nrV6sxuzyxP6O1Kn+ClODMjtKA4LN9vEHrCJMMXukiiYnIuDxItaLdRzql1p?=
 =?us-ascii?Q?8y1/F7qPmPjcgJVW3C9iwphmznd55e3HDPy76HLcQ2mQfJqT867DRhgDtbOI?=
 =?us-ascii?Q?VvnIsmKhuBEZsTnwCq1o/8zff3lPEl/F+VISN/BsDdUo2TQYmN5KW4tgrgR3?=
 =?us-ascii?Q?r9+jLfjNTRk+LusLTY+Ni4UOOjJWM+6872hq4oeZiITPki6YqI3tKMdfDxsA?=
 =?us-ascii?Q?ZEIClpwxkF0T3LGjFeXzh5A0xk23Iw9a2LCFR0d20waxAhuov1CmtlYpea64?=
 =?us-ascii?Q?7zOxrnYsYQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e1e082-dbb9-437f-0d79-08de65727309
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 11:25:36.3364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BK/kv891YsYC7ysEqVBGkQuxUSB05fGEtRJakn3u6rp3bpwbUojkLCiO/AbfcZlN+9+1HqpebUsw/KMci92xpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4725
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

> Subject: [PATCH v3 10/36] net/intel: consolidate checksum mask definition
>=20
> Create a common definition for checksum masks across iavf, idpf, i40e
> and ice drivers.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/common/tx.h             | 8 ++++++++
>  drivers/net/intel/i40e/i40e_rxtx.c        | 7 +------
>  drivers/net/intel/iavf/iavf_rxtx.c        | 2 +-
>  drivers/net/intel/iavf/iavf_rxtx.h        | 8 --------
>  drivers/net/intel/ice/ice_rxtx.c          | 8 +-------
>  drivers/net/intel/idpf/idpf_common_rxtx.c | 4 ++--
>  drivers/net/intel/idpf/idpf_common_rxtx.h | 7 +------
>  7 files changed, 14 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.=
h
> index 01e42303b4..928fad1df5 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -53,6 +53,14 @@
>  /* Common maximum data per TX descriptor */
>  #define CI_MAX_DATA_PER_TXD     (CI_TXD_QW1_TX_BUF_SZ_M >>
> CI_TXD_QW1_TX_BUF_SZ_S)
>=20
> +/* Checksum offload mask to identify packets requesting offload */
> +#define CI_TX_CKSUM_OFFLOAD_MASK (RTE_MBUF_F_TX_IP_CKSUM |
> 		 \
> +				   RTE_MBUF_F_TX_L4_MASK |		 \
> +				   RTE_MBUF_F_TX_TCP_SEG |		 \
> +				   RTE_MBUF_F_TX_UDP_SEG |		 \
> +				   RTE_MBUF_F_TX_OUTER_IP_CKSUM |
> 	 \
> +				   RTE_MBUF_F_TX_OUTER_UDP_CKSUM)
> +
>  /**


<snip>

> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h
> b/drivers/net/intel/idpf/idpf_common_rxtx.h
> index b88a87402d..fe7094d434 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.h
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
> @@ -39,13 +39,8 @@
>  #define IDPF_RLAN_CTX_DBUF_S	7
>  #define IDPF_RX_MAX_DATA_BUF_SIZE	(16 * 1024 - 128)
>=20
> -#define IDPF_TX_CKSUM_OFFLOAD_MASK (		\
> -		RTE_MBUF_F_TX_IP_CKSUM |	\
> -		RTE_MBUF_F_TX_L4_MASK |		\
> -		RTE_MBUF_F_TX_TCP_SEG)
> -
>  #define IDPF_TX_OFFLOAD_MASK (			\
> -		IDPF_TX_CKSUM_OFFLOAD_MASK |	\
> +		CI_TX_CKSUM_OFFLOAD_MASK |	\

With this change should the features in idpf.ini be updated to include
Inner L3/L4 checksum?
And IDPF_TX_SCALAR_OFFLOADS update to include
RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM
RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM

>  		RTE_MBUF_F_TX_IPV4 |		\
>  		RTE_MBUF_F_TX_IPV6)
>=20
> --
> 2.51.0

