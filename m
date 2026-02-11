Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CEDEDF04F
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 07:33:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13812402C0;
	Thu, 12 Feb 2026 08:33:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id CBA5B402AB
 for <dev@dpdk.org>; Wed, 11 Feb 2026 22:57:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770847035; x=1802383035;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=GtynUWV++Qz6Yp9ahKhgsROhA7BQ1H5Sq8GBPsjKxGI=;
 b=mVk9MaHNVcYsSlsmXB4dCVXUYqXCD/RYRoV4yV9A/aQ0SBynH9WX4pvD
 f2SUr4hAVG6tRy1DYcsxQ7PRSsGEOawH7tvp7onUT1c6k9Zi0Fs9SHLUI
 h+ozpP55J0DVbJ1PcTab7DRd84utsUkAfKkpV8zG/1AZgx6lCeeTvjMzw
 7yLJcFjedgKcGJNfloVpPN0XWyGKT3TKCV/eBRIfGHymG1dK5VXNRoxKs
 20WmvdCniRJeoBoZ93bOMwFToRgj6uD4Z7Dk6kGdxlxp51dUb98ALYvZg
 93dybjLCmgHd0ue8Gwc+20DLCWNHBapBNArFEoD9YyTifCd1g2CN1H1VM g==;
X-CSE-ConnectionGUID: ATJAXVkDQkCsRo2wiJ/JGw==
X-CSE-MsgGUID: D6f6ho2qTsi4NXQv31AXcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="89592765"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="89592765"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 13:57:14 -0800
X-CSE-ConnectionGUID: b2QJm5vTTiuSi/uXSngJzA==
X-CSE-MsgGUID: 6FK0cRKIQ6KVLq0b5+3kTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="217341409"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 13:57:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 13:57:13 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 13:57:13 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 13:57:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgENEcH+QHhh10NFHAS3tuUaRI9Pskm+iJe5lDJIiAQ4FP7djlkuRUtk7xBbiifO6t/J0N58VuXrRdHVydLBlMK8LIDHM8jij9OJaZrho+h+7sbSQAh+wYocB7YPLpNp8n3PyRslvqOruoTDjpHLHCzu7TfCBimH5cqKHo96yHu23sniKJkkLeAI4uNSboZV8/Sf5+UNhnN6Xz1sknVv93hn/fHdzQhKcLGwO4xoQzJ4QUFh7n3IKow5NVkUao4y6UTxy2TricTHZBPPF0U0T1vMDlyhX+3PXLi7CiPA5mV+oNwmlpfJbXppiHBVWmHOQWawadyxTYQa3NJNd23LEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTcqc8cp0s/VjSu4ocV2WuhJhd4Tu65DIb7bDxaHp9Q=;
 b=HY5RrOiR5ltfonb8Xi98HKOMNPy129vAMiqhOWaZXZAhz1mIazGZ9y57fvd9cmse8N5qibTv+Hc3bCH4KA3cPLftM4j5Q59AcMPKf5R2+jE/p4aWo+n2Tk1HwWeZd6RSrvOJwp0Cyu3QPt0S5NG8dfNh+G/xO4l16ZzEUN4qU9xrb+I4jFVqfs1z/WgaDpsrBQ8bg1lZE4zl1Zc9xBrr9WPcmvplB+wZE+0Im4XCC3wZzRDuoKbsuGO5uhsyqpSHhFMEUE3F22Ll1+Cc8VWvts0HRQgkq8DqzmEa59suW1JEeuzT9WkhspnKIp6YYHIv6IPPvTpkoHFTR99aeTI1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by LV2PR11MB9538.namprd11.prod.outlook.com (2603:10b6:408:378::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 21:57:11 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4d6a:a025:2e8b:b240]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::4d6a:a025:2e8b:b240%4]) with mapi id 15.20.9587.013; Wed, 11 Feb 2026
 21:57:11 +0000
From: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>,
 "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, Carolyn Wyborny
 <carolyn.wyborny@intel.com>
Subject: RE: [PATCH v4 1/9] net/ixgbe: add missing E610 MAC type checks
Thread-Topic: [PATCH v4 1/9] net/ixgbe: add missing E610 MAC type checks
Thread-Index: AQHcm11EWVyachL4tUWIhx+iC9OZZ7V+C2nA
Date: Wed, 11 Feb 2026 21:57:11 +0000
Message-ID: <PH7PR11MB59832F159ACA2F0153CE63E1F363A@PH7PR11MB5983.namprd11.prod.outlook.com>
References: <cover.1770817694.git.anatoly.burakov@intel.com>
 <cover.1770817694.git.anatoly.burakov@intel.com>
 <00e9b9a24f3984857d568aad04335a01e6834850.1770817694.git.anatoly.burakov@intel.com>
In-Reply-To: <00e9b9a24f3984857d568aad04335a01e6834850.1770817694.git.anatoly.burakov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|LV2PR11MB9538:EE_
x-ms-office365-filtering-correlation-id: 52bce9d4-7b62-464f-bd7f-08de69b8823c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zIln8lFfvmjsA5zofnp/klWBP+gs85WtGwu1lDRgYGjaU4EgytYDJ4+4C+C6?=
 =?us-ascii?Q?2sSmDHovv0aVIX0MIW8XyWfizkfNky1Pnh4Z5TM7ok1umlVTFvb35etu/Z6y?=
 =?us-ascii?Q?+kjH62nutIQEqT9VfRog48pinzaitFEF+vkrRqcu9s7WLsjM48bw2YoAJmUy?=
 =?us-ascii?Q?+3+Fvo7SMReZCfbIxaQ8m/57+UQ0lMNeEzo9h91NbcL8vI0I4qZA6Q66a8Q/?=
 =?us-ascii?Q?slZHE4jzaSqmvWX7sOE+GmIGMWFqqDHj8tqWc6WSiGQXap2ugMmB8ySh1PiM?=
 =?us-ascii?Q?cSTHsRVg/pCK0vHAjnnolJXz7YUm2qRH2NZULTqSLeozOi9eNDFp9cKkv7xC?=
 =?us-ascii?Q?3tzMBW1opeUiM3gLrJh29pIOvTnaKwTIwYDC3icv/qUgQdYx9nyhaIjwK+XY?=
 =?us-ascii?Q?RhF5O+xcf4p6Ovlh+5y7HQpGI6qD+Db6GbbQzmipgRieJ17goOD+Lfahcz6j?=
 =?us-ascii?Q?tXPGVoa9UUHRWtmLFb//S1m/Oe/nd+skDcUeEFiK3ggAKHdcRrJHmnCXmR3I?=
 =?us-ascii?Q?xETBkIm4nZvTLAZQEno52VSc+3PEHoZJPk6JcblqmfkWc6rgiYt5UZKxLm8O?=
 =?us-ascii?Q?IIGxQa3za88FupaW0VfBLTZBSe6YkOFTSZI8T5R1/P/OJdbEI2WfezWo/Y/U?=
 =?us-ascii?Q?vkm7TtZMftcchl9o4xQOwdltUTyPlZF1ALT2MLrDhorITZv2cUf/QK98EF30?=
 =?us-ascii?Q?8wohRCJCr0aHTjMTTyz6BRmNir9sGweo7ggTErORYW8XCXPNrsHYVmIqPx9s?=
 =?us-ascii?Q?bwLD6j0FEuBpgjhsNgZCzlBBZR4JMqrD64m0xX6i0xy2j+MDX68JCtx9kpXl?=
 =?us-ascii?Q?lqNSoK1PLWA33bCwAZKrnIKMBbUlI5ddacEs2jFT4ybxpGptlpZrhUD0ZjPM?=
 =?us-ascii?Q?X0PidjIfKenzypEMqF2eOk6U3WyuczuCjhOL2vjFfjlmAQsvw3J5nXXurUEx?=
 =?us-ascii?Q?DUYU2NryL/HpGF5jXynrwv9sE6zi7ksbghnx+c/b4OuhZVHTvpWrotld+0xJ?=
 =?us-ascii?Q?Bq9A70CfyQAe9+QHn+o95D6fTJVdz+AAn4KVxcq8UHw4HNbG77NL8TSFrN4/?=
 =?us-ascii?Q?V5I+1LZwJhOmD3W4/qD4smsaAqdrKASbFt0YMlm11BmT7anyKaWvoSLWyK73?=
 =?us-ascii?Q?dsND53qW3mQnNKzGujDvPhRipgZpQFP6wCyqRrR0tronz2Prs2+hSs6r/ViC?=
 =?us-ascii?Q?hLI3gYHlNXwRtUCN+diMvecWyWK5LY/NCQ7TZpqc/m4pV/HhpRYTrseKrGE4?=
 =?us-ascii?Q?iQ1/dTSum4GlGJDl5gsaN/fQqVO60NUqSIGGl5bZ3ozccaK+epFvqNjoS2hi?=
 =?us-ascii?Q?K2DsNqwuS4KoRZ004DCYKDt8kvRSq/fNYZ4YkU10i2Qi1B0Fin3cHTlYOeID?=
 =?us-ascii?Q?nxGGx9Vw3B5ICORqQ9/GGZGoMcZPUTa3MB8nnghjjyyeSggUb08yXFnXONDC?=
 =?us-ascii?Q?194tY2F7UE4iQ5O3vBQBghRzAlbK952PasBPvgPa4jmqZN3Iocx82LYO/rIG?=
 =?us-ascii?Q?7CP5vXftN+lJsgVshzmLr7uhOQ+PS5WBQ7Ac42W8ACOONSDTtE7FIybk7UIM?=
 =?us-ascii?Q?ZRegoKcbK/anlnm48tlTjGrOvlLRh8RWQT9hxX76ZPwpLjBy3fGr+o97MEis?=
 =?us-ascii?Q?Mch8VHb+EAK73UGyRXgWrDg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5983.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?arTr5VigxgWorDsao/Q1IdXIHW5o+TIDWVHcN1Z9eYAnyCF0JNPE23OozDBZ?=
 =?us-ascii?Q?LeyRqpo2lXOrfXL2g1hp8s1oN9YknLtJcerAOnmHhk7bg3XoCV6Ct6iycEsG?=
 =?us-ascii?Q?yaTPJChv6g5MQc0g6HjeOKCFik+Fo1FGH3NtgoXpm2dmlcFltoDXESqM5lqG?=
 =?us-ascii?Q?1lO/KoaLCys3Ck84kFRhlag+Uv8J3gzNldYeqo/jRNzxaNjvUZWt/574Fme8?=
 =?us-ascii?Q?60g2KyJFuYbE1HzAPU1m60yfoD8hEqxSD4fGR5VvOseqebcdhueOxIHG3UKq?=
 =?us-ascii?Q?Lv6Jm5rjUoU7/TMiO004ZjEWt4HiHziV1ZNUuYgdO8C6c+/R4tkwIOduHGGN?=
 =?us-ascii?Q?Zc0d9zTsLJYbox6Lo3ksM/2dLkquHi9lWSUWaJs+yxvxsIAVBnhlLSMtZZjg?=
 =?us-ascii?Q?xE2u87xMT0oADcuYrU32Sd46bbRuw2QlcdAnJ8NdK9hCqR+F+eAeZ4vFXa12?=
 =?us-ascii?Q?tu0fxNDtTYxkxPuT+v2HUrkZMruXv3Iv1d4Dr012dVo7MbC9x7FLepxCnMPF?=
 =?us-ascii?Q?hnJeTghD9GsEOmGs5Lxn+Pfd0UmyYIksEvFAqLOilp8Ff8MAv6nYqqoebMWP?=
 =?us-ascii?Q?asx73m1eT/yM5WE1TS8QL57WOaTrWTRk6OvGJGpTHujIgLMVswhiPx6XfDJ8?=
 =?us-ascii?Q?m1DYpTo8eeP+DdsGCp7w0QoWnpDkzEbq2N+4kQEhhOY/96j5lvJysNTmgefB?=
 =?us-ascii?Q?YjBy40LA+DwAA+C5ez1LuKuaGNM3fCMKF8TKZwQcqJeo9kbpIqGqgsS3ighT?=
 =?us-ascii?Q?/1mQKHMOQKXy5QtkBdn7Cs29HlwNQsNplH/ZKdWTYShZ+Cak03Deg+ofa3lb?=
 =?us-ascii?Q?PgkDBXTO2wddKiwgF8/BfpBmORlR4alzimXKjfVjTbjhyzFaD9VPePwPE2mV?=
 =?us-ascii?Q?yIiNyFpIuNuJlW6szOBrURh8FxC2asCNAgcCgIQ6m20I3F+qmQExeZvbsEXv?=
 =?us-ascii?Q?AJCwXq6JxWpQnrCPOly0MCOi+b1WgopbzLQhCEolKV9fp3wmXvIvFn/l7XgD?=
 =?us-ascii?Q?vhZKUmnFJJRGFupvNen+R3qbAJNYRXY8ffC9FCwyPXu+ORvsLAsGNKb0Hwag?=
 =?us-ascii?Q?JXKMHQO7L1+4yaI66D5z9X53Chje2lNtZUJ7UXwEE/7lEtyNeaDtu3k/8KlC?=
 =?us-ascii?Q?MIoIAs1Wig++XxglNV+e22ZswIxff6JBM8xqGeSGE8UScbXO7KTGlg3uUuFJ?=
 =?us-ascii?Q?RupFiAsORG9FpS0VmmFVr0ksxYZNMO/I3N7VglgDNzpWIlu4xKNI3VdcPPnv?=
 =?us-ascii?Q?cCYisYGT5TluCwMYpMEKXNosiAGWbWcZaypUbGysLI6Y47DH3dDOs+dMvVW2?=
 =?us-ascii?Q?JkhJhehEUIsp50kn2gxcAeiIi/0+AJZd5R8juXapIJZb6cQBj5cThGlvHYcS?=
 =?us-ascii?Q?6TAKCCXvwmYNV+hEb7M23QCBDRPKldbM/mGr0Xulg70H6PqXPrMLwIiS43Po?=
 =?us-ascii?Q?RxxedmhU4axwo9c9w+GteLo+NMwc7dhjJsJcgw84wAYOgtC4roE7KIwRfxEi?=
 =?us-ascii?Q?BLL1nh9JfEVQaj3euX2Pd38krAkOaI6vKNy3Ra8i97pGUmdTAJbTBYkv4k1c?=
 =?us-ascii?Q?P4/0YAAgZgiao28KaQKbxonHQvOWYLdEdg5zT5q4V+izOg+7YY7A+1zl3jMG?=
 =?us-ascii?Q?SRzXfCF5tcxJxKfZXhAyJCwGBTnw2fV7xnF2n4mus3FPjZb5EbPMdyOummy6?=
 =?us-ascii?Q?+5FaPycQGy9CRHzTL6o9AuGc5D8u4uvUWSBvIQvAqh7QGaiBITod5qIGhO69?=
 =?us-ascii?Q?ycWqXpoONQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bce9d4-7b62-464f-bd7f-08de69b8823c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 21:57:11.2380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SK9n0rOVYMSWbRVwFr29KDYTcQRsOqp4T3rtok8+SRBT6BBzoYGdvCO+YwgYfQBXMEFRnpF10aEF0YtWLk8Wa96PKEqa93OiV/UjunME3tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB9538
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Thu, 12 Feb 2026 08:33:00 +0100
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

>-----Original Message-----
>From: Burakov, Anatoly <anatoly.burakov@intel.com>=20
>Sent: Wednesday, February 11, 2026 2:49 PM
>To: dev@dpdk.org; Medvedkin, Vladimir <vladimir.medvedkin@intel.com>; Kwap=
ulinski, Piotr <piotr.kwapulinski@intel.com>; Jagielski, Jedrzej <jedrzej.j=
agielski@intel.com>; Carolyn Wyborny <carolyn.wyborny@intel.com>
>Subject: [PATCH v4 1/9] net/ixgbe: add missing E610 MAC type checks
>
>A few E610 MAC type checks were missing (verified using E610 datasheet).
>
>Fixes: 316637762a5f ("net/ixgbe/base: enable E610 device")
>Cc: stable@dpdk.org
>
>Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>---
> drivers/net/intel/ixgbe/ixgbe_bypass_api.h |  8 +-----
> drivers/net/intel/ixgbe/ixgbe_ethdev.c     | 29 ++++++++++++++--------
> drivers/net/intel/ixgbe/ixgbe_fdir.c       |  8 +++---
> drivers/net/intel/ixgbe/ixgbe_flow.c       |  3 ++-
> drivers/net/intel/ixgbe/ixgbe_pf.c         |  5 ++--
> drivers/net/intel/ixgbe/ixgbe_rxtx.c       | 14 +++++++----
> 6 files changed, 39 insertions(+), 28 deletions(-)
>
>diff --git a/drivers/net/intel/ixgbe/ixgbe_bypass_api.h b/drivers/net/inte=
l/ixgbe/ixgbe_bypass_api.h
>index 6ef965dbb6..eb73bc8b17 100644
>--- a/drivers/net/intel/ixgbe/ixgbe_bypass_api.h
>+++ b/drivers/net/intel/ixgbe/ixgbe_bypass_api.h
>@@ -40,16 +40,10 @@ static s32 ixgbe_bypass_rw_generic(struct ixgbe_hw *hw=
, u32 cmd, u32 *status)
> 		dir_sdo =3D IXGBE_ESDP_SDP6_DIR;
> 		break;
> 	case ixgbe_mac_X540:
>-		sck =3D IXGBE_ESDP_SDP2;
>-		sdi =3D IXGBE_ESDP_SDP0;
>-		sdo =3D IXGBE_ESDP_SDP1;
>-		dir_sck =3D IXGBE_ESDP_SDP2_DIR;
>-		dir_sdi =3D IXGBE_ESDP_SDP0_DIR;
>-		dir_sdo =3D IXGBE_ESDP_SDP1_DIR;
>-		break;
> 	case ixgbe_mac_X550:
> 	case ixgbe_mac_X550EM_x:
> 	case ixgbe_mac_X550EM_a:
>+	case ixgbe_mac_E610:
> 		sck =3D IXGBE_ESDP_SDP2;
> 		sdi =3D IXGBE_ESDP_SDP0;
> 		sdo =3D IXGBE_ESDP_SDP1;
>diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ix=
gbe/ixgbe_ethdev.c
>index 89a799762f..11500a923c 100644
>--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
>+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
>@@ -911,7 +911,8 @@ ixgbe_dev_queue_stats_mapping_set(struct rte_eth_dev *=
eth_dev,
> 		(hw->mac.type !=3D ixgbe_mac_X540) &&
> 		(hw->mac.type !=3D ixgbe_mac_X550) &&
> 		(hw->mac.type !=3D ixgbe_mac_X550EM_x) &&
>-		(hw->mac.type !=3D ixgbe_mac_X550EM_a))
>+		(hw->mac.type !=3D ixgbe_mac_X550EM_a) &&
>+		(hw->mac.type !=3D ixgbe_mac_E610))
> 		return -ENOSYS;
>=20
> 	PMD_INIT_LOG(DEBUG, "Setting port %d, %s queue_id %d to stat index %d", =
@@ -2134,10 +2135,11 @@ ixgbe_vlan_hw_extend_enable(struct rte_eth_dev *dev=
)
> 	ctrl |=3D IXGBE_EXTENDED_VLAN;
> 	IXGBE_WRITE_REG(hw, IXGBE_CTRL_EXT, ctrl);
>=20
>-	/* Clear pooling mode of PFVTCTL. It's required by X550. */
>+	/* Clear pooling mode of PFVTCTL. It's required by X550 and E610. */
> 	if (hw->mac.type =3D=3D ixgbe_mac_X550 ||
> 	    hw->mac.type =3D=3D ixgbe_mac_X550EM_x ||
>-	    hw->mac.type =3D=3D ixgbe_mac_X550EM_a) {
>+	    hw->mac.type =3D=3D ixgbe_mac_X550EM_a ||
>+	    hw->mac.type =3D=3D ixgbe_mac_E610) {
> 		ctrl =3D IXGBE_READ_REG(hw, IXGBE_VT_CTL);
> 		ctrl &=3D ~IXGBE_VT_CTL_POOLING_MODE_MASK;
> 		IXGBE_WRITE_REG(hw, IXGBE_VT_CTL, ctrl); @@ -2830,6 +2832,7 @@ ixgbe_de=
v_start(struct rte_eth_dev *dev)
> 		case ixgbe_mac_X550:
> 		case ixgbe_mac_X550EM_x:
> 		case ixgbe_mac_X550EM_a:
>+		case ixgbe_mac_E610:
> 			speed =3D IXGBE_LINK_SPEED_X550_AUTONEG;
> 			break;
> 		default:
>@@ -4046,10 +4049,11 @@ ixgbe_dev_info_get(struct rte_eth_dev *dev, struct=
 rte_eth_dev_info *dev_info)
> 	if (hw->mac.type =3D=3D ixgbe_mac_X540 ||
> 	    hw->mac.type =3D=3D ixgbe_mac_X540_vf ||
> 	    hw->mac.type =3D=3D ixgbe_mac_X550 ||
>-	    hw->mac.type =3D=3D ixgbe_mac_X550_vf) {
>+	    hw->mac.type =3D=3D ixgbe_mac_X550_vf ||
>+	    hw->mac.type =3D=3D ixgbe_mac_E610) {
> 		dev_info->speed_capa |=3D RTE_ETH_LINK_SPEED_100M;
> 	}
>-	if (hw->mac.type =3D=3D ixgbe_mac_X550) {
>+	if (hw->mac.type =3D=3D ixgbe_mac_X550 || hw->mac.type =3D=3D ixgbe_mac_=
E610)=20
>+{
> 		dev_info->speed_capa |=3D RTE_ETH_LINK_SPEED_2_5G;
> 		dev_info->speed_capa |=3D RTE_ETH_LINK_SPEED_5G;
> 	}
>@@ -7665,7 +7669,8 @@ ixgbe_update_e_tag_eth_type(struct ixgbe_hw *hw,
>=20
> 	if (hw->mac.type !=3D ixgbe_mac_X550 &&
> 	    hw->mac.type !=3D ixgbe_mac_X550EM_x &&
>-	    hw->mac.type !=3D ixgbe_mac_X550EM_a) {
>+	    hw->mac.type !=3D ixgbe_mac_X550EM_a &&
>+	    hw->mac.type !=3D ixgbe_mac_E610) {
> 		return -ENOTSUP;
> 	}
>=20
>@@ -7686,7 +7691,8 @@ ixgbe_e_tag_enable(struct ixgbe_hw *hw)
>=20
> 	if (hw->mac.type !=3D ixgbe_mac_X550 &&
> 	    hw->mac.type !=3D ixgbe_mac_X550EM_x &&
>-	    hw->mac.type !=3D ixgbe_mac_X550EM_a) {
>+	    hw->mac.type !=3D ixgbe_mac_X550EM_a &&
>+	    hw->mac.type !=3D ixgbe_mac_E610) {
> 		return -ENOTSUP;
> 	}
>=20
>@@ -7709,7 +7715,8 @@ ixgbe_e_tag_filter_del(struct rte_eth_dev *dev,
>=20
> 	if (hw->mac.type !=3D ixgbe_mac_X550 &&
> 	    hw->mac.type !=3D ixgbe_mac_X550EM_x &&
>-	    hw->mac.type !=3D ixgbe_mac_X550EM_a) {
>+	    hw->mac.type !=3D ixgbe_mac_X550EM_a &&
>+	    hw->mac.type !=3D ixgbe_mac_E610) {
> 		return -ENOTSUP;
> 	}
>=20
>@@ -7745,7 +7752,8 @@ ixgbe_e_tag_filter_add(struct rte_eth_dev *dev,
>=20
> 	if (hw->mac.type !=3D ixgbe_mac_X550 &&
> 	    hw->mac.type !=3D ixgbe_mac_X550EM_x &&
>-	    hw->mac.type !=3D ixgbe_mac_X550EM_a) {
>+	    hw->mac.type !=3D ixgbe_mac_X550EM_a &&
>+	    hw->mac.type !=3D ixgbe_mac_E610) {
> 		return -ENOTSUP;
> 	}
>=20
>@@ -7932,7 +7940,8 @@ ixgbe_e_tag_forwarding_en_dis(struct rte_eth_dev *de=
v, bool en)
>=20
> 	if (hw->mac.type !=3D ixgbe_mac_X550 &&
> 	    hw->mac.type !=3D ixgbe_mac_X550EM_x &&
>-	    hw->mac.type !=3D ixgbe_mac_X550EM_a) {
>+	    hw->mac.type !=3D ixgbe_mac_X550EM_a &&
>+	    hw->mac.type !=3D ixgbe_mac_E610) {
> 		return -ENOTSUP;
> 	}
>=20
>diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgb=
e/ixgbe_fdir.c
>index 97ef185583..0bdfbd411a 100644
>--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
>+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
>@@ -650,10 +650,11 @@ ixgbe_fdir_configure(struct rte_eth_dev *dev)
> 		hw->mac.type !=3D ixgbe_mac_E610)
> 		return -ENOSYS;
>=20
>-	/* x550 supports mac-vlan and tunnel mode but other NICs not */
>+	/* x550 and E610 supports mac-vlan and tunnel mode but other NICs not=20
>+*/
> 	if (hw->mac.type !=3D ixgbe_mac_X550 &&
> 	    hw->mac.type !=3D ixgbe_mac_X550EM_x &&
> 	    hw->mac.type !=3D ixgbe_mac_X550EM_a &&
>+	    hw->mac.type !=3D ixgbe_mac_E610 &&
> 	    mode !=3D RTE_FDIR_MODE_SIGNATURE &&
> 	    mode !=3D RTE_FDIR_MODE_PERFECT)
> 		return -ENOSYS;
>@@ -1130,7 +1131,7 @@ ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
> 		return -ENOTSUP;
>=20
> 	/*
>-	 * Sanity check for x550.
>+	 * Sanity check for x550 and E610.
> 	 * When adding a new filter with flow type set to IPv4,
> 	 * the flow director mask should be configed before,
> 	 * and the L4 protocol and ports are masked.
>@@ -1138,7 +1139,8 @@ ixgbe_fdir_filter_program(struct rte_eth_dev *dev,
> 	if ((!del) &&
> 	    (hw->mac.type =3D=3D ixgbe_mac_X550 ||
> 	     hw->mac.type =3D=3D ixgbe_mac_X550EM_x ||
>-	     hw->mac.type =3D=3D ixgbe_mac_X550EM_a) &&
>+	     hw->mac.type =3D=3D ixgbe_mac_X550EM_a ||
>+	     hw->mac.type =3D=3D ixgbe_mac_E610) &&
> 	    (rule->ixgbe_fdir.formatted.flow_type =3D=3D
> 	     IXGBE_ATR_FLOW_TYPE_IPV4 ||
> 	     rule->ixgbe_fdir.formatted.flow_type =3D=3D diff --git a/drivers/ne=
t/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
>index 3b68d820ca..27d2ba1132 100644
>--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
>+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
>@@ -1361,7 +1361,8 @@ ixgbe_parse_l2_tn_filter(struct rte_eth_dev *dev,
>=20
> 	if (hw->mac.type !=3D ixgbe_mac_X550 &&
> 		hw->mac.type !=3D ixgbe_mac_X550EM_x &&
>-		hw->mac.type !=3D ixgbe_mac_X550EM_a) {
>+		hw->mac.type !=3D ixgbe_mac_X550EM_a &&
>+		hw->mac.type !=3D ixgbe_mac_E610) {
> 		memset(l2_tn_filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
> 		rte_flow_error_set(error, EINVAL,
> 			RTE_FLOW_ERROR_TYPE_ITEM,
>diff --git a/drivers/net/intel/ixgbe/ixgbe_pf.c b/drivers/net/intel/ixgbe/=
ixgbe_pf.c
>index e967fe5e48..d9a775f99a 100644
>--- a/drivers/net/intel/ixgbe/ixgbe_pf.c
>+++ b/drivers/net/intel/ixgbe/ixgbe_pf.c
>@@ -558,11 +558,12 @@ ixgbe_set_vf_lpe(struct rte_eth_dev *dev, uint32_t v=
f, uint32_t *msgbuf)
> 	uint32_t max_frs;
> 	uint32_t hlreg0;
>=20
>-	/* X540 and X550 support jumbo frames in IOV mode */
>+	/* X540, X550, and E610 support jumbo frames in IOV mode */
> 	if (hw->mac.type !=3D ixgbe_mac_X540 &&
> 		hw->mac.type !=3D ixgbe_mac_X550 &&
> 		hw->mac.type !=3D ixgbe_mac_X550EM_x &&
>-		hw->mac.type !=3D ixgbe_mac_X550EM_a) {
>+		hw->mac.type !=3D ixgbe_mac_X550EM_a &&
>+		hw->mac.type !=3D ixgbe_mac_E610) {
> 		struct ixgbe_vf_info *vfinfo =3D
> 			*IXGBE_DEV_PRIVATE_TO_P_VFDATA(dev->data->dev_private);
>=20
>diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgb=
e/ixgbe_rxtx.c
>index 0af04c9b0d..2857c19355 100644
>--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
>+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
>@@ -2707,7 +2707,8 @@ ixgbe_get_tx_port_offloads(struct rte_eth_dev *dev)
>=20
> 	if (hw->mac.type =3D=3D ixgbe_mac_X550 ||
> 	    hw->mac.type =3D=3D ixgbe_mac_X550EM_x ||
>-	    hw->mac.type =3D=3D ixgbe_mac_X550EM_a)
>+	    hw->mac.type =3D=3D ixgbe_mac_X550EM_a ||
>+	    hw->mac.type =3D=3D ixgbe_mac_E610)
> 		tx_offload_capa |=3D RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM;
>=20
> #ifdef RTE_LIB_SECURITY
>@@ -3166,7 +3167,8 @@ ixgbe_get_rx_port_offloads(struct rte_eth_dev *dev)
>=20
> 	if (hw->mac.type =3D=3D ixgbe_mac_X550 ||
> 	    hw->mac.type =3D=3D ixgbe_mac_X550EM_x ||
>-	    hw->mac.type =3D=3D ixgbe_mac_X550EM_a)
>+	    hw->mac.type =3D=3D ixgbe_mac_X550EM_a ||
>+	    hw->mac.type =3D=3D ixgbe_mac_E610)
> 		offloads |=3D RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM;
>=20
> #ifdef RTE_LIB_SECURITY
>@@ -3246,7 +3248,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
>=20
> 	/*
> 	 * The packet type in RX descriptor is different for different NICs.
>-	 * Some bits are used for x550 but reserved for other NICS.
>+	 * Some bits are used for x550 and E610 but reserved for other NICS.
> 	 * So set different masks for different NICs.
> 	 */
> 	if (hw->mac.type =3D=3D ixgbe_mac_X550 ||
>@@ -3254,7 +3256,8 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
> 	    hw->mac.type =3D=3D ixgbe_mac_X550EM_a ||
> 	    hw->mac.type =3D=3D ixgbe_mac_X550_vf ||
> 	    hw->mac.type =3D=3D ixgbe_mac_X550EM_x_vf ||
>-	    hw->mac.type =3D=3D ixgbe_mac_X550EM_a_vf)
>+	    hw->mac.type =3D=3D ixgbe_mac_X550EM_a_vf ||
>+	    hw->mac.type =3D=3D ixgbe_mac_E610)
> 		rxq->pkt_type_mask =3D IXGBE_PACKET_TYPE_MASK_X550;
> 	else
> 		rxq->pkt_type_mask =3D IXGBE_PACKET_TYPE_MASK_82599; @@ -3506,7 +3509,8=
 @@ ixgbe_dev_clear_queues(struct rte_eth_dev *dev)
> 		if (hw->mac.type =3D=3D ixgbe_mac_X540 ||
> 		     hw->mac.type =3D=3D ixgbe_mac_X550 ||
> 		     hw->mac.type =3D=3D ixgbe_mac_X550EM_x ||
>-		     hw->mac.type =3D=3D ixgbe_mac_X550EM_a)
>+		     hw->mac.type =3D=3D ixgbe_mac_X550EM_a ||
>+		     hw->mac.type =3D=3D ixgbe_mac_E610)
> 			ixgbe_setup_loopback_link_x540_x550(hw, false);
> 	}
> }

Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
