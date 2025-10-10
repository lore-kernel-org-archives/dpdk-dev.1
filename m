Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6B0CCD185
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 11:22:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB2824027A;
	Fri, 10 Oct 2025 13:22:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 12A134026F
 for <dev@dpdk.org>; Fri, 10 Oct 2025 13:22:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760095373; x=1791631373;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=qZ1HLqc5vHkCjDArlA11pePdj9LBo3Yx1ScyaP7MLSQ=;
 b=lXt1MsrXlKN+boxwopWOuJVZ5DP+2ycvXFpoPqm8RVLgJMjnkFgO1WGA
 E6bbUKtoinKNGyfresaqPq6Pi1SjGe5wk65nFUHTf5Ygavb30RhkTovXS
 n0t69acEzmw9XPQegQcO6w/Auq02zKxZ7J29uhDSnE7Hf1wRnNmgUJrrH
 pghkbYOVweBrbgySXJUaHDxkbPmoVO6AGnXck6gwF07FDRtVYOfw7KHge
 fkLuiXAy1/oCGOAjF29/w/PfUl07+suYyEZuyzd53600iRdEfLvv2iEDz
 Ne1+RrqHN1Dpe3IuJH93vzbFuFVw56RBpy3MCxNN+H06dPCtIJYijzkKU w==;
X-CSE-ConnectionGUID: a6Yt3M3vQ+KMHxkGxbjZCg==
X-CSE-MsgGUID: WqksijfPQUesKFNCQf7kqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="73752028"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; d="scan'208,217";a="73752028"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2025 04:22:51 -0700
X-CSE-ConnectionGUID: w+T154LgT3SRkSjZ98YDig==
X-CSE-MsgGUID: i92KnjB4Q+uLzcwdu1uJKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
 d="scan'208,217";a="180067999"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2025 04:22:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 04:22:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 04:22:50 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 04:22:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqT8B06jQLNrhIHNMcc7na2sEGMlD5o5QyO89oPei6LiT/8s23WWo2grd2Yocz/uSUOltfsZCLtk8VK0b8OdtOLrJjSlJihnq+AXJExLM0anPE2lvuQn9QMwQUejwX2iWdgkAuXTL0AReZHnvN7iWPEJISwk3S9MN687rJWxepeXJkgIZmsfs/LR7Rju/ZrYf8pStg7g0KGxJlWmjk5JCxJOnwlMQWeAhBPxPMTvEZqmOTZxS/qA282UWs68n091es4ORdxJjC4gTNca29/vx2h4/6zGp86b8MCCDs6pouC83n5R7rxQMPRhRlGtKQz2fveriWt2odkDC7V7v7imYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzKGZgQSWSKOhhXHprMmyYvBvDTduuyNyjkSSxbktjk=;
 b=lsHkFRGr1KZUl/jaa5fayjsP9r5fb/fEw6+hOGmNS2xxIbhZsbGbkLETQVLl3U1YZAi332ESjZfTbPSP324mq4pZLXbpxwsIkUpJs2Tb61KJkS6CbXbXRaCRBGn148XKllXHhAC5ApvDZwEeD9duJIsyyX06AY7nCbEgxje/BD4FQTNjWEIMIMi7fDUS6KLEPeC43ZKtw5jO6aS23qsPaKuZyFFNdWqNwP6LBkJ5M68CHYdVr6u2zPf7fuaLuwgG72A+0vLfNYVV0rqTmpTL/9/STcLUjTabEMf4ftRAO9cNLjyGzT/c/osdDG/mJ5iGjQ7LRlh6K4k+Rz5t31IY1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by SN7PR11MB6852.namprd11.prod.outlook.com (2603:10b6:806:2a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:22:47 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%5]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 11:22:47 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "gakhil@marvell.com" <gakhil@marvell.com>, "konstantin.ananyev@huawei.com"
 <konstantin.ananyev@huawei.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: Re: [dpdk-dev v6 1/2] eal: introduce rte_memeq_timingsafe() based on
 FreeBSD API
Thread-Topic: [dpdk-dev v6 1/2] eal: introduce rte_memeq_timingsafe() based on
 FreeBSD API
Thread-Index: AQHcM7HN7sqRuZHtwkeaHWhA4B7+mrSwCTwAgAs/PYQ=
Date: Fri, 10 Oct 2025 11:22:47 +0000
Message-ID: <DS0PR11MB74588649DF0B88EA8475EDF281EFA@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20251001153242.55987-1-kai.ji@intel.com>
 <20251002153229.98158-1-kai.ji@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65493@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65493@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|SN7PR11MB6852:EE_
x-ms-office365-filtering-correlation-id: 0a964c46-cdaa-4288-68bc-08de07ef5716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|42112799006|376014|8096899003|7053199007|13003099007|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sMiBpE1v0xc5/D28p5pO2AKy1T5X9CwEKA5IqIoRmUxfkxtR0xNrYMf+dF?=
 =?iso-8859-1?Q?lTWPvYYya63/vShdzXqiQOrfvt6mOOBG/fulZMcNdb+Eh+AQj5FuLDuUA8?=
 =?iso-8859-1?Q?hECYB+FBDOMaF/UQX+10N0VmE6MPRVKuFcQudxoBwcY35bp6B0OpY2SKSl?=
 =?iso-8859-1?Q?GhbcVHQBHnLgfF7S1VA7WUjJpSyYoFwXJlO8Qp7vJSdlguJdahergY4OSy?=
 =?iso-8859-1?Q?4fzDAL0qPRyP4lPyxADIt2UEx9jA1cHjFPLspUV8aTks1fGL1VD3ttfFby?=
 =?iso-8859-1?Q?56xW/Be0pG7BfXz83DfjK41G4IMUtSWdxAErQK63lKco0y6NtNtOdThM6c?=
 =?iso-8859-1?Q?ESjUMpkWklTVsN7PJxbDgYKth9fv0vCzUnUmV2p3D06gjCWRhm07cpalfR?=
 =?iso-8859-1?Q?XGt5VY455BPt85AscFoCf72BtfXrRdaSl4khv6gtNP7ls+Pdqeh8UCVx3i?=
 =?iso-8859-1?Q?NU7NiZsjz5m9XvNleAVSqp4c75rXIUS+2SHBcIUy7uMUYPUmGcfItniL+T?=
 =?iso-8859-1?Q?Y74Y92eXfbJ19rJB8whaWyvgXs/d9FBQAyO4Aqu4jLEBVrGBL1elMFeCxW?=
 =?iso-8859-1?Q?YbGURrUhYaIcMcLbe2QzEjab+8jI2SVUA2RUm5sIEP4qSI7JkBANCl2LDD?=
 =?iso-8859-1?Q?WVIMX0mfusDQZ8wiYmn2zoePKeGBcjBBt7SHw5prNMBPqq7K9J3K7KFEz6?=
 =?iso-8859-1?Q?WtApHedegcvBMSb5sjy7KEP1/UEmuIexuoO5F3TcLLXy2FF3ornxY0XsW9?=
 =?iso-8859-1?Q?5gVtnPWwCZU2MOQTcBjprCdLHLmcJnRMF8earwFF/la3urwOPZ25SlyoGj?=
 =?iso-8859-1?Q?Q2yxVnJCV5erXK2va2yWejWlPY71dJvTPDiU8AgiAkzi4M8fOSK1mJ0qc/?=
 =?iso-8859-1?Q?P4yKWmlWSLCesQx+KNUBmRrrilBC+mwcf631tR7e8K3q0Nxw9l7V91q5lb?=
 =?iso-8859-1?Q?r72s840Plm/c0NRduNwH4c8UbHAIlTWaVkgmmAP0USUAZAUKVnJgkzCN9v?=
 =?iso-8859-1?Q?fsagDrr6eBTggFKdgeX4dC8pHproYrKQIggNvko+ivs1f45G5QN0Uc852E?=
 =?iso-8859-1?Q?CbaZCRfl9dWdqPkKxB9CPr77YNaEsgm0EL2ESSRM+doAhMhkWtubNNFHky?=
 =?iso-8859-1?Q?DPSXgsIzd39KK8ojeiWiuJIu52zoWKwC/MZufvgo49vKvwADvhMP8NBAMu?=
 =?iso-8859-1?Q?mKcf6T3c3o1tkdPeWKUQXrN8zoZE91iNPKoFgZo0ufDjWv9mCbc5U+fu9z?=
 =?iso-8859-1?Q?LfHYyjykgFYORM8BtAMqdtalO2uCzXnIg7n37/76MKnvGEax0Qiq7jgxX/?=
 =?iso-8859-1?Q?aW+gPKS6l8ik1V2iLqLAFI7F/D29DC5JGOuEhLDesMNEPe+2NPhxKvDy10?=
 =?iso-8859-1?Q?tP/XuoqbtmJy/ROqAvdhpguvpZVfOsE7wem7KNXQiLGZsk+qKPErIsW5XU?=
 =?iso-8859-1?Q?LbVHgC62ntny/OG61rkAxXUN55GLI2vgsPJZOZ2spG6y6L8GumZMY6cLBj?=
 =?iso-8859-1?Q?BgUCo5ISWFR0BGM8BkArhO58w45G/mZtA97ATtG137QA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(42112799006)(376014)(8096899003)(7053199007)(13003099007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9SNoS6UwqcGocUfccPALHza+Py5D8p6Np/N/V/FpagONwkvwSkiTsNNtiM?=
 =?iso-8859-1?Q?QjvOXPRvr6T2Np95AL7xrwWWh3+0Wchc+D8OC3DaEu8zeuGluauN31DWmT?=
 =?iso-8859-1?Q?sRVCwrDHEWn7jbKuqxgyCw6OfhByDoY56SRV0bAfkPXFNtA7mQuTvy+sRM?=
 =?iso-8859-1?Q?y5vYmGAd67qe89DcKNw7LGBjx/E67evuSilKy90BebnXfJNg8jjw+21qdG?=
 =?iso-8859-1?Q?ZgKbiEFlcJkxBB0sb0jmH775BgJ21MiosteFbrXMpMb4wPavSlVOT1IIvS?=
 =?iso-8859-1?Q?XZMTtYi0kABlNOya/qhHuvb4kWyye5ljI2rxELNjPYVjO9FFhXXsKPLxJr?=
 =?iso-8859-1?Q?o7EVygNWrQbn94RqPStnyNXGd4lgVx1posPWoCuSDkfmV6jJr07yIcKOz6?=
 =?iso-8859-1?Q?+QPuktZ+YiMglnzmo4jF5ADF2V32RiCGHOkEw1yCKnx2d0R3KSwgFJf7I3?=
 =?iso-8859-1?Q?3NKLfYWGU535O7EGhLcBdaJjbTdafmX+Z+prHqQqoKjkQb4D9EhTHT4riX?=
 =?iso-8859-1?Q?qlT55SCHkeKHj2A5CrMJ730k89dn1bVeqjJueJIFOs9urCkl0xPA7/MeTs?=
 =?iso-8859-1?Q?3irVvzd/PLI95bdnK8fwB6DdvZ+dOb1Lzcowb6qh9pJqqn/Hf/munXXjDz?=
 =?iso-8859-1?Q?3iB+ytuRL4b7qb10KzGf1cSixBdNdSIJzlT+MG85ThYKpMmBPcdD66ZU5z?=
 =?iso-8859-1?Q?RvkPv2LJWZX+Z/yEF5LZvSCLrMhWT/V2OlD/+ql4VG4hGIO0xFo6zLIUTp?=
 =?iso-8859-1?Q?OxeMAti5YGSQMgZoQzCk1O0TcWaBhVx9HcnPzlAl9fYIwYQvUInx36HkAB?=
 =?iso-8859-1?Q?scbBcNfDxt40hMJIow8D1ReFeUogxSvIu8Zv/wqBwW4FmLDuuz4o3trw5k?=
 =?iso-8859-1?Q?BDxuLZRxruTwUzUH6tfk/hyeNZJpEHOq/HJhsSn6T+7wnYHoms86XceRpu?=
 =?iso-8859-1?Q?iZfq7+VhiYbOx1T4oGdrmOWUAgnDxbJawcJth1Cs22pmlTxr8mgAOigiVA?=
 =?iso-8859-1?Q?qbjEOkTLfkLREezK7n3ZYc6JV1zOaip9mMH7se0U2IQRXrkvrbWkxk7TmQ?=
 =?iso-8859-1?Q?fRJ/aBPTZl6kXEA1wrcMhspdtF3nUiDPJb8ZKaalxvr5/gYRHlnVW5L0qQ?=
 =?iso-8859-1?Q?v2PTLo/TKrfBVRn6CJDUm3oQ/S4rWJd47q+Y0lMM0LOI5eeQrb/hGTwcoL?=
 =?iso-8859-1?Q?1zT5XeA7Ly65pfI7GNR4pKAWJSgpGeRNOuibZhYvpwWQM//yk17UuUoYYK?=
 =?iso-8859-1?Q?eGlk6O8WnlyQhsz3BxtENy2j1IAex0f7dtWOSEReWWOhKjdUCT9nc4Ob7Q?=
 =?iso-8859-1?Q?gpodKvrml0iWYSiSttxO1Oz4846lmo2tN6MzLTeAE5kHEYwpLSM/Eaz+VS?=
 =?iso-8859-1?Q?juHvLQRUy8mI+db4y+qQ9oZG2+qFzCpSLMbiLDFFmVgpGC6tqrr3LZWmQO?=
 =?iso-8859-1?Q?87ruT5B11GLkrZPTUWlWqk2yj47s46NMJw6MI9jZ/t6JNR3VtUTDU/yOgx?=
 =?iso-8859-1?Q?dZpVUHRm4IZRmGT/kVN+xjhTabWQ3lPpCz9gM4prnYtwgK9cM5+SPP9mDK?=
 =?iso-8859-1?Q?wzd2aE7RwnG9Th3XjsVkMa8Wi5GtNfcpIalAAi4/hVvm6rjzQP2Ei4ABxn?=
 =?iso-8859-1?Q?g7I6ey0YLLpa2KRzPxJ2QdD73XUxbp++Pyv6wr62Tji6sOvcSUaiDYhHN0?=
 =?iso-8859-1?Q?h0UrWmamGrB0dMYr3SA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB74588649DF0B88EA8475EDF281EFADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a964c46-cdaa-4288-68bc-08de07ef5716
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 11:22:47.2804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgkLP6M8XMLUFxV7xUx3N7+wsETF61EGMRxbxuCkpqSce9z+pAAaiinHV5+pXf3oR12fTNHS3+t8sqeEHyvVSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6852
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

--_000_DS0PR11MB74588649DF0B88EA8475EDF281EFADS0PR11MB7458namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

What needed to get it merged within RC1 window ?


________________________________
From: Morten Br=F8rup <mb@smartsharesystems.com>
Sent: Friday, October 03, 2025 08:35
To: Ji, Kai <kai.ji@intel.com>; dev@dpdk.org <dev@dpdk.org>
Cc: gakhil@marvell.com <gakhil@marvell.com>; konstantin.ananyev@huawei.com =
<konstantin.ananyev@huawei.com>; Richardson, Bruce <bruce.richardson@intel.=
com>; thomas@monjalon.net <thomas@monjalon.net>; stephen@networkplumber.org=
 <stephen@networkplumber.org>
Subject: RE: [dpdk-dev v6 1/2] eal: introduce rte_memeq_timingsafe() based =
on FreeBSD API

> From: Kai Ji [mailto:kai.ji@intel.com]
> Sent: Thursday, 2 October 2025 17.32
>
> Bugzilla ID: 1773
> https://bugs.dpdk.org/show_bug.cgi?id=3D1773
>
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---
>  lib/eal/include/rte_memory.h | 38 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/lib/eal/include/rte_memory.h
> b/lib/eal/include/rte_memory.h
> index dcc0e69cfe..2d24e091af 100644
> --- a/lib/eal/include/rte_memory.h
> +++ b/lib/eal/include/rte_memory.h
> @@ -746,6 +746,44 @@ __rte_experimental
>  void
>  rte_memzero_explicit(void *dst, size_t sz);
>
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Timing-safe memory equality comparison.
> + *
> + * This function compares two memory regions in constant time, making
> it
> + * resistant to timing side-channel attacks. The execution time
> depends only
> + * on the length parameter, not on the actual data values being
> compared.
> + *
> + * This is particularly important for cryptographic operations where
> timing
> + * differences could leak information about secret keys, passwords, or
> other
> + * sensitive data.
> + *
> + * @param a
> + *   Pointer to the first memory region to compare
> + * @param b
> + *   Pointer to the second memory region to compare
> + * @param n
> + *   Number of bytes to compare
> + * @return
> + *   true if the memory regions are identical, false if they differ
> + */
> +__rte_experimental
> +static inline bool
> +rte_memeq_timingsafe(const void *a, const void *b, size_t n)
> +{
> +     const volatile uint8_t *pa =3D (const volatile uint8_t *)a;
> +     const volatile uint8_t *pb =3D (const volatile uint8_t *)b;
> +     uint8_t result =3D 0;
> +     size_t i;
> +
> +     for (i =3D 0; i < n; i++)
> +             result |=3D pa[i] ^ pb[i];
> +
> +     return result =3D=3D UINT8_C(0);
> +}
> +
>  #ifdef __cplusplus
>  }
>  #endif
> --
> 2.34.1

Reviewed-by: Morten Br=F8rup <mb@smartsharesystems.com>


--_000_DS0PR11MB74588649DF0B88EA8475EDF281EFADS0PR11MB7458namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
What needed to get it merged within RC1 window ?&nbsp;</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Morten Br=F8rup &lt;mb@smartsharesystems.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, October 03, 2025 08:35<br>
<b>To:</b>&nbsp;Ji, Kai &lt;kai.ji@intel.com&gt;; dev@dpdk.org &lt;dev@dpdk=
.org&gt;<br>
<b>Cc:</b>&nbsp;gakhil@marvell.com &lt;gakhil@marvell.com&gt;; konstantin.a=
nanyev@huawei.com &lt;konstantin.ananyev@huawei.com&gt;; Richardson, Bruce =
&lt;bruce.richardson@intel.com&gt;; thomas@monjalon.net &lt;thomas@monjalon=
.net&gt;; stephen@networkplumber.org &lt;stephen@networkplumber.org&gt;<br>
<b>Subject:</b>&nbsp;RE: [dpdk-dev v6 1/2] eal: introduce rte_memeq_timings=
afe() based on FreeBSD API
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">&gt; From: Kai Ji =
[<a class=3D"OWAAutoLink" id=3D"OWAbfe2d5fa-ad9e-6741-9051-c245f7672a14" hr=
ef=3D"mailto:kai.ji@intel.com">mailto:kai.ji@intel.com</a>]<br>
&gt; Sent: Thursday, 2 October 2025 17.32<br>
&gt;<br>
&gt; Bugzilla ID: 1773<br>
&gt; <a data-auth=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWA022adc35=
-d234-0bf2-3791-e24a374476c1" href=3D"https://bugs.dpdk.org/show_bug.cgi?id=
=3D1773">
https://bugs.dpdk.org/show_bug.cgi?id=3D1773</a><br>
&gt;<br>
&gt; Signed-off-by: Kai Ji &lt;kai.ji@intel.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; lib/eal/include/rte_memory.h | 38 ++++++++++++++++++++++++++++++=
++++++<br>
&gt;&nbsp; 1 file changed, 38 insertions(+)<br>
&gt;<br>
&gt; diff --git a/lib/eal/include/rte_memory.h<br>
&gt; b/lib/eal/include/rte_memory.h<br>
&gt; index dcc0e69cfe..2d24e091af 100644<br>
&gt; --- a/lib/eal/include/rte_memory.h<br>
&gt; +++ b/lib/eal/include/rte_memory.h<br>
&gt; @@ -746,6 +746,44 @@ __rte_experimental<br>
&gt;&nbsp; void<br>
&gt;&nbsp; rte_memzero_explicit(void *dst, size_t sz);<br>
&gt;<br>
&gt; +/**<br>
&gt; + * @warning<br>
&gt; + * @b EXPERIMENTAL: this API may change without prior notice.<br>
&gt; + *<br>
&gt; + * Timing-safe memory equality comparison.<br>
&gt; + *<br>
&gt; + * This function compares two memory regions in constant time, making=
<br>
&gt; it<br>
&gt; + * resistant to timing side-channel attacks. The execution time<br>
&gt; depends only<br>
&gt; + * on the length parameter, not on the actual data values being<br>
&gt; compared.<br>
&gt; + *<br>
&gt; + * This is particularly important for cryptographic operations where<=
br>
&gt; timing<br>
&gt; + * differences could leak information about secret keys, passwords, o=
r<br>
&gt; other<br>
&gt; + * sensitive data.<br>
&gt; + *<br>
&gt; + * @param a<br>
&gt; + *&nbsp;&nbsp; Pointer to the first memory region to compare<br>
&gt; + * @param b<br>
&gt; + *&nbsp;&nbsp; Pointer to the second memory region to compare<br>
&gt; + * @param n<br>
&gt; + *&nbsp;&nbsp; Number of bytes to compare<br>
&gt; + * @return<br>
&gt; + *&nbsp;&nbsp; true if the memory regions are identical, false if the=
y differ<br>
&gt; + */<br>
&gt; +__rte_experimental<br>
&gt; +static inline bool<br>
&gt; +rte_memeq_timingsafe(const void *a, const void *b, size_t n)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const volatile uint8_t *pa =3D (const volati=
le uint8_t *)a;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const volatile uint8_t *pb =3D (const volati=
le uint8_t *)b;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint8_t result =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; size_t i;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; n; i++)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; result |=3D pa[i] ^ pb[i];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return result =3D=3D UINT8_C(0);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; #ifdef __cplusplus<br>
&gt;&nbsp; }<br>
&gt;&nbsp; #endif<br>
&gt; --<br>
&gt; 2.34.1<br>
<br>
Reviewed-by: Morten Br=F8rup &lt;mb@smartsharesystems.com&gt;<br>
<br>
</div>
</body>
</html>

--_000_DS0PR11MB74588649DF0B88EA8475EDF281EFADS0PR11MB7458namp_--
