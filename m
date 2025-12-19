Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A630ED711CC
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 01:06:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 785FC4026A;
	Fri, 19 Dec 2025 02:06:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 361D740150
 for <dev@dpdk.org>; Fri, 19 Dec 2025 02:06:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766106380; x=1797642380;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZFIznWrASgKWTQqnehMwwDcRWSD1siYePf48E+H27QU=;
 b=fD6sg0UVrNMnLw+XhfWWKz7ocYANc0z4Brq1BCLj+GxONEoPFFEkt8uk
 X5urWq7vO0xzthTtUbCbt7oWBqx0o4Rvxk+Yiak35OaRBC9Yi5Q+LKymb
 GnChElcXBuz59OMFyWYFf6ITlILbM1UARMb7TLUY3RS93JAr0zJecQItA
 cl4kP4XI1UveBMvVQWjBkeRh5IQjnulqenVa/KUg3fHtgOZuECUgfUYk7
 rp9AbsBt3sahCMpgpemZWnWXK5QKq/1YwSxRz7ab/m7KI+oVxdVJiT3Yd
 na2YIvayOeYXlZCWVlt1Lh0oEkVIKWa+GBkJIC6+XxCNsS7qcZAyuZM+B Q==;
X-CSE-ConnectionGUID: tNGXgMDyQUiWKZ5/6raQpg==
X-CSE-MsgGUID: LIDGtME1Rk6WdRXhhpciXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="67069046"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; d="scan'208";a="67069046"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2025 17:06:18 -0800
X-CSE-ConnectionGUID: QK5gCHgSQFOAW93hH+gCrw==
X-CSE-MsgGUID: IkxrovxSSiaoSKjGZHthmA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2025 17:06:17 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 17:06:17 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 18 Dec 2025 17:06:17 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 17:06:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKhszXBZzCH1FT6su9TTPs16nbEE9vEO4YnlbP4rJGHqZo5z9JGXiIV0XOJ7uw9Igqm+FvxO4DVCDFX/TLbKrAOtZWrBzartcKPZaQ7LVfU3Y9DebuepNu6LaAlezKuxFdzASWl52QmcVoW2Nmmy75k5/9gBMTPAwaV7VwtNT1HKATNe865YqH4VqrFI4W5ifRAiUv93mbjFN71SbHnE/YKcJ7F8m7el/XxYbdjh3CAuRN3bx0DX5EtBJihUkGKfg/N2UmfXueqNJclkg9rXUwWrE+HwA0VPPo0lb7u+Z6ZRyPxwjDzukbs0P/JxGS2OyJL4ZBF7y38Qx0IwIFKc9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFIznWrASgKWTQqnehMwwDcRWSD1siYePf48E+H27QU=;
 b=zCKkO6EvbnP4k85G+z6wUSfeXFz02P5RrYjStzDrb+UgLs8IPxlFMB0tJa4debVGfEEvXy00w6RDPZfayuyWD7c1cnx8k/gFx2jiwWAtiHk8/v0zkoCBzGfj57Cw/w7GEhZhCXrkY1FquRG2o/FtIGHsmJGm6BX9PXxzb+0GgTjyUVsv6Q0lZ8PUrL5IFDdLKHo4sfVVVKu8ntREpHC2Py57kz1ojkJzclXXvc7QfE0lxjxsFBEZu8Tx8VQULvlsCyPQKoM4EP0ieN3jkBeBdajH94S0LuR08lJXsZ+4Jwz+d0VVUG7C4MHVzHbJso4YEIbcWihnyyfWky0OKQBs+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by DM4PR11MB6552.namprd11.prod.outlook.com (2603:10b6:8:8f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.8; Fri, 19 Dec 2025 01:06:14 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9%4]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 01:06:14 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>
Subject: RE: [PATCH] [v4] net/ice: add MAC anti-spoof option
Thread-Topic: [PATCH] [v4] net/ice: add MAC anti-spoof option
Thread-Index: AQHccIOrUUzVBbdhGk6Pm55tiB+QQQ==
Date: Fri, 19 Dec 2025 01:06:14 +0000
Message-ID: <CY5PR11MB6116032AFE3D2226EC9A7FD0E4A9A@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20251217201143.155053-1-anurag.mandal@intel.com>
 <6943d80b.050a0220.a065.15daSMTPIN_ADDED_MISSING@mx.google.com>
In-Reply-To: <6943d80b.050a0220.a065.15daSMTPIN_ADDED_MISSING@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|DM4PR11MB6552:EE_
x-ms-office365-filtering-correlation-id: 633d44a2-b268-4124-f514-08de3e9ace7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?4M8E/dbq+DtFxuXMNwWotdcDE2nEuJDaCUtrVAiUvVQIwHhbEuD+KHDKcZd+?=
 =?us-ascii?Q?rOZnMovjtNL2dsmNbObwfzmVRqKxj1Y79x1rCVQJFdgi9+xwNohXruYmkoJn?=
 =?us-ascii?Q?7SHh0SHv41qSi74lkRA4IpuFu2DiP95dNls/NIXEEMrHDTlGxkkWo2MTH93W?=
 =?us-ascii?Q?drW9qtIc3OywQCVyQnBwE7MzDCKIBn63dnT+g+5oobei46xh7bUacorREGZE?=
 =?us-ascii?Q?DoRCsc33C/RGHoEwXqeOA6CuCpwimWcEmplatsqiHbt+Z8wOcrAdFbrjIj6g?=
 =?us-ascii?Q?e45+1S+00e0Y955h9BpPrbGjRljHyaM8SvPUJDeCys1JyZZfqntGFJTmIJDl?=
 =?us-ascii?Q?OGlAU2sgREjY7Wst6B2CMPHLI6R7P96OQOb5dhOISzyIT/VIQ7/uXoMvu3vq?=
 =?us-ascii?Q?71G0pfS7wSbam+sG/qgleva3Er8240K9o66Qctf1HP9BmZOfbhexfFtRQ/Gi?=
 =?us-ascii?Q?B6OcsjiBgkvaxbuGClyVnZW+RsrFLenF/PgUgk5+PsGQ2XBQQU5hy39p9+qo?=
 =?us-ascii?Q?eru3dVxjqx3LRjMgFIHboaHRbAopKYeS/nYb9lW8we+kguoK0VmmsfDk6BGf?=
 =?us-ascii?Q?4TJkXDvAaIbKBe2whYpVA+RQo3H8jO/piE8A1cZMT/l6HJbdYw5hsXO9q/KD?=
 =?us-ascii?Q?EVBLh5VeJDKupUR4jzAQUElSTNdeJMnJSwLUCmjLNU4xz+qLCRfuJHZAEeWQ?=
 =?us-ascii?Q?genhGLQEsqovw7So8cRq82DEzGFQ+VycoyUIrC9SBJT+z/SZOytUD78IK9BJ?=
 =?us-ascii?Q?V0VH0jnjx7hDps/s6Ttcu776D1jvvGT70Ehww+bcfa/s08Y2i+MQS953Bsds?=
 =?us-ascii?Q?GYeJA2RJYhaVnQxpqGm+O9YGWVDbhVTmcGItjLzmERHa8gHmeEpkik4QWL6+?=
 =?us-ascii?Q?9AvVETru09Q8i8JFHuMIQT7DKxq+ocDuLE4uQtCWLwGdDauSH17WIi2BN7Yq?=
 =?us-ascii?Q?chU/zPKMoJtMXSMNOcpgIqA8WWxteVjpUKSKtAyUjLbAcTNqarE2kPc/NhHz?=
 =?us-ascii?Q?seD5vYT23ccpRdmea62GXcJeqMVED7x9PdXeK5giafr3t5bY2CPWT1aLw6Y+?=
 =?us-ascii?Q?2w00kjs3Fm+eyhS2aRhlXVGz4xJc1qsCAW8ToHU73gWBK8R/dlK7qbSdhkGC?=
 =?us-ascii?Q?Kzfv/icHfa8GnEB3QgQO6rfvwDug/tPWmTZ8F4860N7ubawneP+231M8tKEw?=
 =?us-ascii?Q?tcAxL/EtMG734CUKut16FS0Zco+fHiFoayCNPs1Rp/BJ8ZraIoAVmmY7T/O0?=
 =?us-ascii?Q?tHDtbMmUhKYVM7WggVFZvv8PC3jDB8VX5zvDzw28BQf87YtgwHbNArTX6b70?=
 =?us-ascii?Q?Hs5AMhSDOog88qx/VxNSr2qr9MTJv/JDVRVwh4DxusFCOcW9iGuGXZknRH80?=
 =?us-ascii?Q?avJkdYzdniImrwBhGbbPEA1LRQhGNq/gubtD6nCZp4s6p1T/Sep/K7JNP7Bs?=
 =?us-ascii?Q?xJv1Ta0fp1fFAOzk6C1v0bXKk0OUmp+ms4HG4DnPQefahqQg8ZypgWf4E+0j?=
 =?us-ascii?Q?VIJlVo87GnpC6zgXj2lboAjO4vbiitndkSuF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8UfbtVi0feq4e5JkVpPFUGAgZNyRBSZeUeNK15YQf065Y9l6T2sdQwYX2Epm?=
 =?us-ascii?Q?IVBoRidQN6gJF4OA2MmXfQdCrmK+ZAH3mXZt6iTKTc9PyAH+mlZBydYGYRa4?=
 =?us-ascii?Q?LSOeC5SRS5cdkGCHgGEEhedJGRw5tCPe3BDwrzCohntzE1mEdGoh84R3g6I7?=
 =?us-ascii?Q?/SZ897kuju9eLmDf7pyp5wUA3qSXXCRaZ2ws5Fw2jkm9aD3ftF7UWQThj3Vo?=
 =?us-ascii?Q?1ah1HMQf65ydiV+5QfTuwsczCZai4yVGDmx6G0yXN1qOZyyoqcoL7Iv154Oi?=
 =?us-ascii?Q?Jjv9PQHOBZmIR0QvZPnG6r7tzkbLNEallWSRPpFiUsBefHj/hIH6UgsYphTn?=
 =?us-ascii?Q?hl7m1msKaOA/X86VIqDy+0OhB3NAz8GOB21nCLOEUg90mD47JCrHZaGPJRK5?=
 =?us-ascii?Q?jxTCpPwPy1VVtTYzeJbR7CzNPO0tVccUr5b1fqmJA/pWH5cVMHbciwUZkZrW?=
 =?us-ascii?Q?1Dd7i/l94ysimkDR+l8Cq+mwzJetaDOTygN0i9cZO9XLNl5TzbxoDRV0DP7k?=
 =?us-ascii?Q?tU/V7yM0QjU16Cp9IfqGIw/aYx6dPxFqyeMgR89nVI7XUAhXV+vGiLNayMJS?=
 =?us-ascii?Q?8Gu0QxfZwP8V4ZDKQycX9kHc4R7pxS9gTENdh0zJtZnCyizCUpUOovrfbs09?=
 =?us-ascii?Q?6ptXUDpdxQQhoHUy9SL4ZNp/+Wf0OdjfMq7nGTMvZJnJW0Md6LV5/ej8eM//?=
 =?us-ascii?Q?FE9kAOOOeFxny2i02JjE3RY6voizuweYHiFSLyl6SrcHhRZlAm5Pypkzo+mA?=
 =?us-ascii?Q?QzHchZauxQNJDtxqR7CinEszwbhUcoXrPk7WdIJplZDbP4aKnC84R53xXJog?=
 =?us-ascii?Q?wchKRgqPNk4Er5eDQg7+mqsv55zVFIE+fNzBv3OTUZf07JlwJGkFoZ7NaDx/?=
 =?us-ascii?Q?2islkVEtH1ll9QYQw+kLwIXWcwrrQWzk5f2ae6hTUAfoIDJJdMNGwOjmuF0+?=
 =?us-ascii?Q?nAm0xxK1S3Hp9vQkUnvnEh8IUAJmRcBdRcIG4AGGD4cX4GdmzzmTu1Kz5s9V?=
 =?us-ascii?Q?C5qBf0BR6/IUZNxh0NbvCJZfCQQjOlsjTygV89pLpkEmAP/mhRCdbNHXLE15?=
 =?us-ascii?Q?jYFVNYZ0izkDl6NmOYEOJsUataEYFZbgAVbrTYBkOTsBzRGA663+I176nCcf?=
 =?us-ascii?Q?qEdmsc2K97LPZ8Vf7jPmZRy1174hKRepdNgSYw8QhgZowNv7ycE7QboZAC8z?=
 =?us-ascii?Q?n700Wd0ftlFEGK6onNhojICZqv+lGXnz8QI6Ez7JfpDugrkdp7AKLU5Bb6kv?=
 =?us-ascii?Q?sLHKS5eQuDfUGUZ9xFAk3iCBKumlJHQylqARlDAXBz35xu746KMRWVMB9OJz?=
 =?us-ascii?Q?qHwvMP/fSc1Yn/FRT/jst2E1Fj37bTsRE88P6ZjellYfOtyLom6+9d2Lg1t7?=
 =?us-ascii?Q?iqvP08sDT7+zAaKRVXntafTOQUkeffY6AbymvWeXd4pEB0aBN+swNjUqIZ1o?=
 =?us-ascii?Q?YwmKjZvy/Xo96HZFP2g7YfXMQbDZ822Of0Li88Y4miPnaqFLgpL2O009s+U4?=
 =?us-ascii?Q?SB1l5ex+ie/X2dqa5RWcBtn3Lroi0NX8jDK91wNIJZ4jFdZORnYi8APXMVob?=
 =?us-ascii?Q?//yQG9mAHpZyeQ+FsRN5ESzRFHVTJRKUOo5Q00tJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633d44a2-b268-4124-f514-08de3e9ace7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 01:06:14.2813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UswJNOKNtLYRAVqBXBgF+bfPVTAXIy0vI8ecfRcsbWhN6YqW/293IKQO5Gq06IEml2qwwfJPhe5wzRFoukWFfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6552
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

Recheck-request: iol-intel-Performance



