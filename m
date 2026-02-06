Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83185EB28FE
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 09:56:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C81A4029A;
	Fri,  6 Feb 2026 10:56:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id B4E2E40293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 10:56:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770371804; x=1801907804;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JiuK9fahQ6VnWPffvcqULwPwzklnYhM26k00/essiFA=;
 b=kEbo3TFv4b9Y0pWUnehvMn+c96aTwLaMr/24HLh1w5aAB011Zh9t9W+s
 2/uk/8mzYzx8OJT4Jowm5O2S6pyH/c3u5gvrZLlMHi8XUwAiXV2O3iEKK
 Y4mjf8kQUhU4zZv4Bhv6MRH7MXj4KkbcnJLGouuBuSwEr/+gMqZNha5CA
 VljGwlhPCpTaPNwP2DZb2TUf5AZC56cS24OyDSbozxfhsDSpMDGcvzx5k
 45AoS9TVuLCdgpDlWS7JYLFMUdaJkwLcLgcuWJA4iQEfuhWjS/eGu/e5f
 yd4+0swbupVVcTATsdV1JqSzS3a4f/F4p5zQ6v6KKBMfz65pRekfnni7S Q==;
X-CSE-ConnectionGUID: M5gJHPADS/eF4/Z0OX0gDw==
X-CSE-MsgGUID: nSHMu2ghTtKBLE2reqCwtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="75196613"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="75196613"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 01:56:42 -0800
X-CSE-ConnectionGUID: eIKBz9zyRVqu0OFtqawT9g==
X-CSE-MsgGUID: 2IB6Iu0gR0iGy5phDWF0bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="210655827"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 01:56:41 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 01:56:40 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 01:56:40 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 01:56:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VO92xpf/oS34mzzbp7RyfDM0yc5zTcj+W6cBKG1c+qbV9NkiEeHf0P4sLMYHgGL4ibR8QaPfsPYsSE1trLZDh2TN9TCMhGW//Q4EigMLKrAolOyytyEYcpK/GA0rZJwKraZGO35WLdlHbX8LOcVMw5+V2cu+06OS30xZZlIahPziUqmAwxxQe0IhL04zm3VNBMXb0ATwwXaIyHrD/rnDN+jcVyosyvRVtK2Ast1K8k1ZJi+9UmCFnMao+a7WC8rVk/MhrUY5EIgQ5gugfj/Wvl3zJtbWC+K9hOI43z+FWQ3g0z4xM01x4xbT5xt2F7ln3eyU8AQ5UgLrVqj0ZvFo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tyP8crBPQsFWZWqoPe/jkvnZD6aDLvul4d/W3onvQE=;
 b=kVFd/rcs+XpGl7g5oQT+aNOH6k+LJW55MMNruqTVyAHteA9l4MnbDTC9Wu3511/8oeAhjIa2rnJT9xnVI7ELyWDV+3hdSyL5C+EAxKmREb4aZCPEJ2000NCB3rXDAEoZ18059ZYZYA1doTpIVeB9nsAXPDg6+Kw4jct06kZXTj78x07k6SB0G3fHmhPSbUwt3MhbtgyMGIJ3dV+QAkoZvZj66qw6NPmsDPaMeRgg1lR2n9ljDEaC0NFwTTojiY7sRBvsFm+mYspU7z0AVERo+w3gjwv2R/yu3eEoESSXCqWXAefC423MpXVXf0vUITEh/jCdZFtMZSKYayL8HLvQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SA2PR11MB5017.namprd11.prod.outlook.com
 (2603:10b6:806:11e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 09:56:39 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 09:56:38 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Shetty, Praveen"
 <praveen.shetty@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Wu, Jingjing" <jingjing.wu@intel.com>
Subject: RE: [PATCH v3 01/36] net/intel: create common Tx descriptor structure
Thread-Topic: [PATCH v3 01/36] net/intel: create common Tx descriptor structure
Thread-Index: AQHckd2RF/L6OWJy2UW9TrI3+8V6SbV1ecew
Date: Fri, 6 Feb 2026 09:56:38 +0000
Message-ID: <DM3PPF7D18F34A1F7A5DB80E146FF2E96598E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-2-bruce.richardson@intel.com>
In-Reply-To: <20260130114207.1126032-2-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SA2PR11MB5017:EE_
x-ms-office365-filtering-correlation-id: a15ab20f-8ff0-46a5-dcce-08de6566058c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?vTNawZfRXLTUSUAcp0jYSFJ+klCibsGMd1hnW8iaNTN07IXpAF/PITpFIzoK?=
 =?us-ascii?Q?dngcppeuVfK04f6NI5XbZFL1Z+4ZGTjzAIuH+lxRw8n2mZgrGCoDud+6YMiN?=
 =?us-ascii?Q?0MNgUimrnfBLeDGTIFLeA6j8NzjnHze6UjMWCtKHyS6MSyyw/XJUVr9bFQVG?=
 =?us-ascii?Q?gG4qTixJYd594y9UDhb5LhtSdfBDt1j2e5s7a+R1OXAGlGeJ5FmO5J/a0I9d?=
 =?us-ascii?Q?A9Akzkb5ecujEFWA5ClyZX6yGZ2lrueAAwWng5qxDYCs/ZgTXrzxxAIc7W6L?=
 =?us-ascii?Q?fpQ3CN19qFA+yehbcNMcZh2hjPBwaX2s5KTHeafj+ho4TbJspeNRcWNZsfZ+?=
 =?us-ascii?Q?1FVf6s+PCiEBwqp0LvI4tPUW7yw25DuvGi71CcXiorcGRnEj8D89arkcQeB5?=
 =?us-ascii?Q?KPav409o4xkp/VgBAfVXrYokdQqumrVuMKORYWpyd85ZeqTMPJzoHmJcGfKZ?=
 =?us-ascii?Q?DKk1pAuXuRnuW9VV3o7K14oEEXfd9neEQPD/gXi7gGDPFxjzfVYXmHkgznNG?=
 =?us-ascii?Q?p94cfr+V+RWH+xRHRlsDMFrqsEXH+kt6Y0R7vSbnolAQnDOFshvXgrOpJ0tr?=
 =?us-ascii?Q?jBekbfQ1HiZhr/wxPkfNmQotCZ+ywRmki1mtysCOlDTSfGNQ7m9zLUt18irC?=
 =?us-ascii?Q?Uv7spFe4L6dnwOpjVEGRXoqNRWhGP0pKSoNUtTfvmAdtklsUukWIoB7GMaA6?=
 =?us-ascii?Q?5MMlgDLWzkwWwYFPPWjA9Hv6oCpj9zfx/5BwN8rCDfH4MopqnRfq+03FQoBk?=
 =?us-ascii?Q?IeID7rSGczzFhNQDXfAQSvhZ4Y72GxNW0NeGThyUiYfiJCVDEMCofTh4UyhY?=
 =?us-ascii?Q?TBc9u3oCKokpeu7cJJscq9FBD0TJeV/kFY1m9JlTkhF5hPbmoZAM2Zeuxk73?=
 =?us-ascii?Q?YA0Aazj/pt8esxE0mmPyzMxVt5yxyNUJzH6kC508YC87ndH0mcdaa3qTfl/z?=
 =?us-ascii?Q?dnkK7zIXKh6WRZ4baS4LCpXSY4SBfjRdDutBDnF8Kp54OURaTvzBeaPgfyWs?=
 =?us-ascii?Q?mhfRZQ0r7G+49Np2pjFz/ubFJOOp7yWCnFZsse0xyOqhhshwdxx7z0fz3nlM?=
 =?us-ascii?Q?yzI8CzSSLH5O8fJftXBjeD8HeYNnZ9qoggpivwoST93geGNppDPkF847yaRX?=
 =?us-ascii?Q?rajCWRqK1j6zPLmSphlJPshBrGzAMnoLMkNjtThf9k4LFKOvQ7zcz/fIvyXC?=
 =?us-ascii?Q?6uLAucGKjl2cM5pImud5rA9cNUcBu+hQdanPyG6To8CN/tJNPrRmVssRTl9Y?=
 =?us-ascii?Q?1R++ZmwH4JH5INeXo8pqeEurRe05QZZjvkwzJUKj10RyKUylRAm5MtGlfrxb?=
 =?us-ascii?Q?+mDhD4e782tmVGC5uGH3vgfWmURXmQJiCIiQLsk+3q/uQ0IkFfv6CCKgCrIF?=
 =?us-ascii?Q?NCbwLktUIQnLAaj+AOi5sa0AYQEBaFNOSRMoE4YBx4HiKWI/vYtiwr4ttm7U?=
 =?us-ascii?Q?mnsbs4PsxHA957b8FfRzkZ+wPY4Oj3RwWfGEbUCLnWZUDD4O1p7gTNdkmmNe?=
 =?us-ascii?Q?qrstbMXcjVq21e0vPrZTSxNdz6DKZmOkbjA1CbyGYU9OWOriVjuUi3X/R5hQ?=
 =?us-ascii?Q?MUp0R7CxYY3u0nm012Iu606Iv9HutaYcH7DoO5Cs67A4I+ejzvBi5O/wOoLw?=
 =?us-ascii?Q?XVfGHqseXxSk/mVeIG4xHJA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fs6bLn0TldzBcnk+2v1r1UsNz05HH5yE9Nd3hHD2yb7o/IyRXiUmNWALclHX?=
 =?us-ascii?Q?Ms1v2gXgUt8xO1NudomgRFy/Lsur+RdCxWd/L1drWHYH5FnUWns0PBADP2YP?=
 =?us-ascii?Q?K3ThNlf8AHAJHo8o5THpPcm8SUf6nofa4kOLF0hU1jxSkl2OsPNy7lASK0mN?=
 =?us-ascii?Q?T9ISiqmZRZ5pwrPbWB6OVHi7mu1nz4d0f1xl2bKd7TB5+faXplXlAKtN0MP7?=
 =?us-ascii?Q?8XI3rlDYBhBM/Cx8pEXoe2xtoozfw0akC0VIiRxKGxs2/Qyni3NaF8dSfdnP?=
 =?us-ascii?Q?a1yLYgCss9cD4UrZIIQ9pFWjwhak3bGVVDz1kjf8l6qsTnuAp7P6wrCuGHPE?=
 =?us-ascii?Q?kEIIPJE9RDg0BuSR602DSlhvTTQl9iFb/d95O2+cw6Djxpl5yWRmmmo/ubWa?=
 =?us-ascii?Q?QXWXj3p0buDW+xN5WgDg0Hyz59H7ko7zKAcEqXWIZOxHZTucjAg0xRKl/afR?=
 =?us-ascii?Q?NOwA7zUOV3F+5j94nad62zF/82Iw6604kVU9LkUfa6Uv3QP5FZggsFGOUcci?=
 =?us-ascii?Q?9B2rRj8PbuT/rbW0n3U7/24gYQ80bEvec/oNIZ1C70IU2vAftUEgynU7SDc5?=
 =?us-ascii?Q?ksLTxPqtltJbZ2RVsyQpgsqWTBgQ4Ynqr5fuJ4qlAp5wPAT9blZEx528QW4D?=
 =?us-ascii?Q?+U7RQAwfCQQOWeQ6pzo/vLEvid++SxUdjEkJgw0ilPJeB2ojw2MqBlnG9oP/?=
 =?us-ascii?Q?3+aYfsRjOXrtIwxbOxCVbafl0b1aY6BibAT0NXNqqtIAGqc3x3ohFMXOj0XM?=
 =?us-ascii?Q?nTt2JAcqFuu9rWRIWgNixFwKaYLQ5dQdydnnOSX4cmyXeX8Y8oNs7WtjVm5T?=
 =?us-ascii?Q?pl8NdVLlpEjk4/CMhCEgg5bULn9pK50o9l8A4+PUQ9Gu0gCjuc9ivhuMHCqC?=
 =?us-ascii?Q?h8X06GEUEe/tt/c5V4NAtRIDEHNA2Am75M/MYtbPLfaXisDh1bK0nH3BxCcC?=
 =?us-ascii?Q?mK4mcQjY/Pmitb7OOVH4FCy8qIX4SRH+co3IDHqjkjpSwsA08JiEpfcNYiem?=
 =?us-ascii?Q?ar6VSrfA00g4YK/iL0R6MDl2bsee8iu3gD8VpKgHK3w9Vbqg4+OWEgDf6Hit?=
 =?us-ascii?Q?0VEr4BPZPWFBnHWZOrKydgrhJpBU0+Kg05C5czpMFmBC/Ybm6bDpHwokDYZZ?=
 =?us-ascii?Q?neKsCLN01L1l5plHs5HRpfeGlkEUWYiHoDpIG1TfpClG7aMXaI9V/fxE4ewO?=
 =?us-ascii?Q?O/4jbwCB2Mh6MEvoap+Q6Zt0sJm2vPXc7GYGCjRb4hQPGs61Yrzx973vgN50?=
 =?us-ascii?Q?lTAZH+i9Uj3Nrzn9dhVhPWEeWEe12um+Dw7qoDOmNVylK8kR9zFcsXCQgLec?=
 =?us-ascii?Q?qdr+U/CiYzp7y2Z8zt1GDm+PpUu4L2mlcLdEsIdB5y+AnZKe32qqISg09m9X?=
 =?us-ascii?Q?lZaelkE66MrkEb2ehuVlU8faHM6aPIOw+OOWyq3qFHJnxOfVYihYb4ZrPFVk?=
 =?us-ascii?Q?5eLDabtsqEUypE4Joc+ZffoG7dhOEWUGI4gBZPQWU87zIGErH9mzHx7ACZJT?=
 =?us-ascii?Q?qYFFqlgOki86PWa+FgjB2/lPQcs33WRa83ogGJFolnMt8VA4p6oSpikfsbGp?=
 =?us-ascii?Q?xgYPLM3AdiDem5bm5SyNh28dQljJyikyk3ufPm97mMpYnCb/WXGF/Dhrzlxq?=
 =?us-ascii?Q?4V6bqco/T4EEpMuCsB2sv+pDJmY9lg1mSo2xXd6X7Sr3Lr/n2Aw6f1K9KKe/?=
 =?us-ascii?Q?dtNuOMfDil0TuRVS6vrjrv16ilyulpk+sMwssDD6LftzGzJFgmE1XLgVAoVz?=
 =?us-ascii?Q?y+yTtUV2JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15ab20f-8ff0-46a5-dcce-08de6566058c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 09:56:38.6807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LhHAZUFEcQkt4Syq1kCH0DVrgJjdnMhuQ3FrTR6obGdsz3FCCRHWzURas+Tq8hTORDpr8i08+1/ho54ezgSUyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5017
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

> Subject: [PATCH v3 01/36] net/intel: create common Tx descriptor structur=
e
>=20
> The Tx descriptors used by the i40e, iavf, ice and idpf drivers are all
> identical 16-byte descriptors, so define a common struct for them. Since
> original struct definitions are in base code, leave them in place, but
> only use the new structs in DPDK code.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/common/tx.h                 | 16 ++++++---
>  drivers/net/intel/cpfl/cpfl_rxtx.c            |  2 +-
>  drivers/net/intel/i40e/i40e_fdir.c            |  4 +--
>  drivers/net/intel/i40e/i40e_rxtx.c            | 26 +++++++-------
>  .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  6 ++--
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  6 ++--
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  6 ++--
>  drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  6 ++--
>  drivers/net/intel/iavf/iavf_rxtx.c            | 16 ++++-----
>  drivers/net/intel/iavf/iavf_rxtx.h            |  2 +-
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  6 ++--
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 12 +++----
>  drivers/net/intel/ice/ice_dcf_ethdev.c        |  2 +-
>  drivers/net/intel/ice/ice_rxtx.c              | 36 +++++++++----------
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  6 ++--
>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  6 ++--
>  drivers/net/intel/idpf/idpf_common_rxtx.c     | 20 +++++------
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |  2 +-
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  8 ++---
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  8 ++---
>  drivers/net/intel/idpf/idpf_rxtx.c            |  2 +-
>  drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  2 +-
>  22 files changed, 104 insertions(+), 96 deletions(-)
>=20
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.=
h
> index e295d83e3a..d7561a2bbb 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -10,6 +10,14 @@
>  #include <rte_ethdev.h>
>  #include <rte_vect.h>
>=20
> +/*
> + * Structure of a 16-byte Tx descriptor common across i40e, ice, iavf an=
d idpf
> drivers
> + */
> +struct ci_tx_desc {
> +	uint64_t buffer_addr; /* Address of descriptor's data buf */
> +	uint64_t cmd_type_offset_bsz;
> +};
> +
>  /* forward declaration of the common intel (ci) queue structure */
>  struct ci_tx_queue;
>=20
> @@ -33,10 +41,10 @@ typedef void (*ice_tx_release_mbufs_t)(struct
> ci_tx_queue *txq);
>=20
>  struct ci_tx_queue {
>  	union { /* TX ring virtual address */
> -		volatile struct i40e_tx_desc *i40e_tx_ring;
> -		volatile struct iavf_tx_desc *iavf_tx_ring;
> -		volatile struct ice_tx_desc *ice_tx_ring;
> -		volatile struct idpf_base_tx_desc *idpf_tx_ring;
> +		volatile struct ci_tx_desc *i40e_tx_ring;
> +		volatile struct ci_tx_desc *iavf_tx_ring;
> +		volatile struct ci_tx_desc *ice_tx_ring;
> +		volatile struct ci_tx_desc *idpf_tx_ring;
>  		volatile union ixgbe_adv_tx_desc *ixgbe_tx_ring;
>  	};
>  	volatile uint8_t *qtx_tail;               /* register address of tail *=
/
> diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c
> b/drivers/net/intel/cpfl/cpfl_rxtx.c
> index d0438b5da0..78bc3e9b49 100644
> --- a/drivers/net/intel/cpfl/cpfl_rxtx.c
> +++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
> @@ -131,7 +131,7 @@ cpfl_dma_zone_reserve(struct rte_eth_dev *dev,
> uint16_t queue_idx,
>  			ring_size =3D RTE_ALIGN(len * sizeof(struct
> idpf_flex_tx_sched_desc),
>  					      CPFL_DMA_MEM_ALIGN);
>  		else
> -			ring_size =3D RTE_ALIGN(len * sizeof(struct
> idpf_base_tx_desc),
> +			ring_size =3D RTE_ALIGN(len * sizeof(struct ci_tx_desc),
>  					      CPFL_DMA_MEM_ALIGN);
>  		memcpy(ring_name, "cpfl Tx ring", sizeof("cpfl Tx ring"));
>  		break;
> diff --git a/drivers/net/intel/i40e/i40e_fdir.c
> b/drivers/net/intel/i40e/i40e_fdir.c
> index 55d18c5d4a..605df73c9e 100644
> --- a/drivers/net/intel/i40e/i40e_fdir.c
> +++ b/drivers/net/intel/i40e/i40e_fdir.c
> @@ -1377,7 +1377,7 @@ i40e_find_available_buffer(struct rte_eth_dev
> *dev)
>  	 */
>  	if (fdir_info->txq_available_buf_count <=3D 0) {
>  		uint16_t tmp_tail;
> -		volatile struct i40e_tx_desc *tmp_txdp;
> +		volatile struct ci_tx_desc *tmp_txdp;
>=20
>  		tmp_tail =3D txq->tx_tail;
>  		tmp_txdp =3D &txq->i40e_tx_ring[tmp_tail + 1];
> @@ -1628,7 +1628,7 @@ i40e_flow_fdir_filter_programming(struct i40e_pf
> *pf,
>  	struct ci_tx_queue *txq =3D pf->fdir.txq;
>  	struct ci_rx_queue *rxq =3D pf->fdir.rxq;
>  	const struct i40e_fdir_action *fdir_action =3D &filter->action;
> -	volatile struct i40e_tx_desc *txdp;
> +	volatile struct ci_tx_desc *txdp;
>  	volatile struct i40e_filter_program_desc *fdirdp;
>  	uint32_t td_cmd;
>  	uint16_t vsi_id;
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> b/drivers/net/intel/i40e/i40e_rxtx.c
> index 1c3586778c..92d49ccb79 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -388,7 +388,7 @@ static inline int
>  i40e_xmit_cleanup(struct ci_tx_queue *txq)
>  {
>  	struct ci_tx_entry *sw_ring =3D txq->sw_ring;
> -	volatile struct i40e_tx_desc *txd =3D txq->i40e_tx_ring;
> +	volatile struct ci_tx_desc *txd =3D txq->i40e_tx_ring;
>  	uint16_t last_desc_cleaned =3D txq->last_desc_cleaned;
>  	uint16_t nb_tx_desc =3D txq->nb_tx_desc;
>  	uint16_t desc_to_clean_to;
> @@ -1092,8 +1092,8 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  	struct ci_tx_queue *txq;
>  	struct ci_tx_entry *sw_ring;
>  	struct ci_tx_entry *txe, *txn;
> -	volatile struct i40e_tx_desc *txd;
> -	volatile struct i40e_tx_desc *txr;
> +	volatile struct ci_tx_desc *txd;
> +	volatile struct ci_tx_desc *txr;
>  	struct rte_mbuf *tx_pkt;
>  	struct rte_mbuf *m_seg;
>  	uint32_t cd_tunneling_params;
> @@ -1398,7 +1398,7 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
>=20
>  /* Populate 4 descriptors with data from 4 mbufs */
>  static inline void
> -tx4(volatile struct i40e_tx_desc *txdp, struct rte_mbuf **pkts)
> +tx4(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
>  {
>  	uint64_t dma_addr;
>  	uint32_t i;
> @@ -1414,7 +1414,7 @@ tx4(volatile struct i40e_tx_desc *txdp, struct
> rte_mbuf **pkts)
>=20
>  /* Populate 1 descriptor with data from 1 mbuf */
>  static inline void
> -tx1(volatile struct i40e_tx_desc *txdp, struct rte_mbuf **pkts)
> +tx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
>  {
>  	uint64_t dma_addr;
>=20
> @@ -1431,7 +1431,7 @@ i40e_tx_fill_hw_ring(struct ci_tx_queue *txq,
>  		     struct rte_mbuf **pkts,
>  		     uint16_t nb_pkts)
>  {
> -	volatile struct i40e_tx_desc *txdp =3D &txq->i40e_tx_ring[txq->tx_tail]=
;
> +	volatile struct ci_tx_desc *txdp =3D &txq->i40e_tx_ring[txq->tx_tail];
>  	struct ci_tx_entry *txep =3D &txq->sw_ring[txq->tx_tail];
>  	const int N_PER_LOOP =3D 4;
>  	const int N_PER_LOOP_MASK =3D N_PER_LOOP - 1;
> @@ -1459,7 +1459,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
>  	     struct rte_mbuf **tx_pkts,
>  	     uint16_t nb_pkts)
>  {
> -	volatile struct i40e_tx_desc *txr =3D txq->i40e_tx_ring;
> +	volatile struct ci_tx_desc *txr =3D txq->i40e_tx_ring;
>  	uint16_t n =3D 0;
>=20
>  	/**
> @@ -2616,7 +2616,7 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev
> *dev,
>  	}
>=20
>  	/* Allocate TX hardware ring descriptors. */
> -	ring_size =3D sizeof(struct i40e_tx_desc) * I40E_MAX_RING_DESC;
> +	ring_size =3D sizeof(struct ci_tx_desc) * I40E_MAX_RING_DESC;
>  	ring_size =3D RTE_ALIGN(ring_size, I40E_DMA_MEM_ALIGN);
>  	tz =3D rte_eth_dma_zone_reserve(dev, "i40e_tx_ring", queue_idx,
>  			      ring_size, I40E_RING_BASE_ALIGN, socket_id);
> @@ -2640,7 +2640,7 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev
> *dev,
>  	txq->tx_deferred_start =3D tx_conf->tx_deferred_start;
>=20
>  	txq->tx_ring_dma =3D tz->iova;
> -	txq->i40e_tx_ring =3D (struct i40e_tx_desc *)tz->addr;
> +	txq->i40e_tx_ring =3D (struct ci_tx_desc *)tz->addr;
>=20
>  	/* Allocate software ring */
>  	txq->sw_ring =3D
> @@ -2913,13 +2913,13 @@ i40e_reset_tx_queue(struct ci_tx_queue *txq)
>  	}
>=20
>  	txe =3D txq->sw_ring;
> -	size =3D sizeof(struct i40e_tx_desc) * txq->nb_tx_desc;
> +	size =3D sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
>  	for (i =3D 0; i < size; i++)
>  		((volatile char *)txq->i40e_tx_ring)[i] =3D 0;
>=20
>  	prev =3D (uint16_t)(txq->nb_tx_desc - 1);
>  	for (i =3D 0; i < txq->nb_tx_desc; i++) {
> -		volatile struct i40e_tx_desc *txd =3D &txq->i40e_tx_ring[i];
> +		volatile struct ci_tx_desc *txd =3D &txq->i40e_tx_ring[i];
>=20
>  		txd->cmd_type_offset_bsz =3D
>=20
> 	rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE);
> @@ -3221,7 +3221,7 @@ i40e_fdir_setup_tx_resources(struct i40e_pf *pf)
>  	}
>=20
>  	/* Allocate TX hardware ring descriptors. */
> -	ring_size =3D sizeof(struct i40e_tx_desc) * I40E_FDIR_NUM_TX_DESC;
> +	ring_size =3D sizeof(struct ci_tx_desc) * I40E_FDIR_NUM_TX_DESC;
>  	ring_size =3D RTE_ALIGN(ring_size, I40E_DMA_MEM_ALIGN);
>=20
>  	tz =3D rte_eth_dma_zone_reserve(dev, "fdir_tx_ring",
> @@ -3240,7 +3240,7 @@ i40e_fdir_setup_tx_resources(struct i40e_pf *pf)
>  	txq->i40e_vsi =3D pf->fdir.fdir_vsi;
>=20
>  	txq->tx_ring_dma =3D tz->iova;
> -	txq->i40e_tx_ring =3D (struct i40e_tx_desc *)tz->addr;
> +	txq->i40e_tx_ring =3D (struct ci_tx_desc *)tz->addr;
>=20
>  	/*
>  	 * don't need to allocate software ring and reset for the fdir
> diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
> b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
> index bbb6d907cf..ef5b252898 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
> @@ -446,7 +446,7 @@ i40e_recv_scattered_pkts_vec(void *rx_queue, struct
> rte_mbuf **rx_pkts,
>  }
>=20
>  static inline void
> -vtx1(volatile struct i40e_tx_desc *txdp,
> +vtx1(volatile struct ci_tx_desc *txdp,
>  	struct rte_mbuf *pkt, uint64_t flags)
>  {
>  	uint64_t high_qw =3D (I40E_TX_DESC_DTYPE_DATA |
> @@ -459,7 +459,7 @@ vtx1(volatile struct i40e_tx_desc *txdp,
>  }
>=20
>  static inline void
> -vtx(volatile struct i40e_tx_desc *txdp,
> +vtx(volatile struct ci_tx_desc *txdp,
>  	struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
>  {
>  	int i;
> @@ -473,7 +473,7 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct
> rte_mbuf **tx_pkts,
>  			  uint16_t nb_pkts)
>  {
>  	struct ci_tx_queue *txq =3D (struct ci_tx_queue *)tx_queue;
> -	volatile struct i40e_tx_desc *txdp;
> +	volatile struct ci_tx_desc *txdp;
>  	struct ci_tx_entry_vec *txep;
>  	uint16_t n, nb_commit, tx_id;
>  	uint64_t flags =3D I40E_TD_CMD;
> diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
> b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
> index 4e398b3140..137c1f9765 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
> @@ -681,7 +681,7 @@ i40e_recv_scattered_pkts_vec_avx2(void *rx_queue,
> struct rte_mbuf **rx_pkts,
>=20
>=20
>  static inline void
> -vtx1(volatile struct i40e_tx_desc *txdp,
> +vtx1(volatile struct ci_tx_desc *txdp,
>  		struct rte_mbuf *pkt, uint64_t flags)
>  {
>  	uint64_t high_qw =3D (I40E_TX_DESC_DTYPE_DATA |
> @@ -694,7 +694,7 @@ vtx1(volatile struct i40e_tx_desc *txdp,
>  }
>=20
>  static inline void
> -vtx(volatile struct i40e_tx_desc *txdp,
> +vtx(volatile struct ci_tx_desc *txdp,
>  		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
>  {
>  	const uint64_t hi_qw_tmpl =3D (I40E_TX_DESC_DTYPE_DATA |
> @@ -739,7 +739,7 @@ i40e_xmit_fixed_burst_vec_avx2(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  			  uint16_t nb_pkts)
>  {
>  	struct ci_tx_queue *txq =3D (struct ci_tx_queue *)tx_queue;
> -	volatile struct i40e_tx_desc *txdp;
> +	volatile struct ci_tx_desc *txdp;
>  	struct ci_tx_entry_vec *txep;
>  	uint16_t n, nb_commit, tx_id;
>  	uint64_t flags =3D I40E_TD_CMD;
> diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
> b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
> index 571987d27a..6971488750 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
> @@ -750,7 +750,7 @@ i40e_recv_scattered_pkts_vec_avx512(void
> *rx_queue,
>  }
>=20
>  static inline void
> -vtx1(volatile struct i40e_tx_desc *txdp, struct rte_mbuf *pkt, uint64_t =
flags)
> +vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt, uint64_t fl=
ags)
>  {
>  	uint64_t high_qw =3D (I40E_TX_DESC_DTYPE_DATA |
>  		((uint64_t)flags  << I40E_TXD_QW1_CMD_SHIFT) |
> @@ -762,7 +762,7 @@ vtx1(volatile struct i40e_tx_desc *txdp, struct
> rte_mbuf *pkt, uint64_t flags)
>  }
>=20
>  static inline void
> -vtx(volatile struct i40e_tx_desc *txdp,
> +vtx(volatile struct ci_tx_desc *txdp,
>  	struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
>  {
>  	const uint64_t hi_qw_tmpl =3D (I40E_TX_DESC_DTYPE_DATA |
> @@ -807,7 +807,7 @@ i40e_xmit_fixed_burst_vec_avx512(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  				 uint16_t nb_pkts)
>  {
>  	struct ci_tx_queue *txq =3D (struct ci_tx_queue *)tx_queue;
> -	volatile struct i40e_tx_desc *txdp;
> +	volatile struct ci_tx_desc *txdp;
>  	struct ci_tx_entry_vec *txep;
>  	uint16_t n, nb_commit, tx_id;
>  	uint64_t flags =3D I40E_TD_CMD;
> diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
> b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
> index b5be0c1b59..6404b70c56 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
> @@ -597,7 +597,7 @@ i40e_recv_scattered_pkts_vec(void *rx_queue, struct
> rte_mbuf **rx_pkts,
>  }
>=20
>  static inline void
> -vtx1(volatile struct i40e_tx_desc *txdp,
> +vtx1(volatile struct ci_tx_desc *txdp,
>  		struct rte_mbuf *pkt, uint64_t flags)
>  {
>  	uint64_t high_qw =3D (I40E_TX_DESC_DTYPE_DATA |
> @@ -609,7 +609,7 @@ vtx1(volatile struct i40e_tx_desc *txdp,
>  }
>=20
>  static inline void
> -vtx(volatile struct i40e_tx_desc *txdp, struct rte_mbuf **pkt,
> +vtx(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkt,
>  		uint16_t nb_pkts,  uint64_t flags)
>  {
>  	int i;
> @@ -623,7 +623,7 @@ i40e_xmit_fixed_burst_vec(void *__rte_restrict
> tx_queue,
>  	struct rte_mbuf **__rte_restrict tx_pkts, uint16_t nb_pkts)
>  {
>  	struct ci_tx_queue *txq =3D (struct ci_tx_queue *)tx_queue;
> -	volatile struct i40e_tx_desc *txdp;
> +	volatile struct ci_tx_desc *txdp;
>  	struct ci_tx_entry_vec *txep;
>  	uint16_t n, nb_commit, tx_id;
>  	uint64_t flags =3D I40E_TD_CMD;
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> b/drivers/net/intel/iavf/iavf_rxtx.c
> index 4b763627bc..e4421a9932 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -267,7 +267,7 @@ reset_tx_queue(struct ci_tx_queue *txq)
>  	}
>=20
>  	txe =3D txq->sw_ring;
> -	size =3D sizeof(struct iavf_tx_desc) * txq->nb_tx_desc;
> +	size =3D sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
>  	for (i =3D 0; i < size; i++)
>  		((volatile char *)txq->iavf_tx_ring)[i] =3D 0;
>=20
> @@ -827,7 +827,7 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
>  	}
>=20
>  	/* Allocate TX hardware ring descriptors. */
> -	ring_size =3D sizeof(struct iavf_tx_desc) * IAVF_MAX_RING_DESC;
> +	ring_size =3D sizeof(struct ci_tx_desc) * IAVF_MAX_RING_DESC;
>  	ring_size =3D RTE_ALIGN(ring_size, IAVF_DMA_MEM_ALIGN);
>  	mz =3D rte_eth_dma_zone_reserve(dev, "iavf_tx_ring", queue_idx,
>  				      ring_size, IAVF_RING_BASE_ALIGN,
> @@ -839,7 +839,7 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
>  		return -ENOMEM;
>  	}
>  	txq->tx_ring_dma =3D mz->iova;
> -	txq->iavf_tx_ring =3D (struct iavf_tx_desc *)mz->addr;
> +	txq->iavf_tx_ring =3D (struct ci_tx_desc *)mz->addr;
>=20
>  	txq->mz =3D mz;
>  	reset_tx_queue(txq);
> @@ -2333,7 +2333,7 @@ iavf_xmit_cleanup(struct ci_tx_queue *txq)
>  	uint16_t desc_to_clean_to;
>  	uint16_t nb_tx_to_clean;
>=20
> -	volatile struct iavf_tx_desc *txd =3D txq->iavf_tx_ring;
> +	volatile struct ci_tx_desc *txd =3D txq->iavf_tx_ring;
>=20
>  	desc_to_clean_to =3D (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
>  	if (desc_to_clean_to >=3D nb_tx_desc)
> @@ -2723,7 +2723,7 @@ iavf_calc_pkt_desc(struct rte_mbuf *tx_pkt)
>  }
>=20
>  static inline void
> -iavf_fill_data_desc(volatile struct iavf_tx_desc *desc,
> +iavf_fill_data_desc(volatile struct ci_tx_desc *desc,
>  	uint64_t desc_template,	uint16_t buffsz,
>  	uint64_t buffer_addr)
>  {
> @@ -2756,7 +2756,7 @@ uint16_t
>  iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pk=
ts)
>  {
>  	struct ci_tx_queue *txq =3D tx_queue;
> -	volatile struct iavf_tx_desc *txr =3D txq->iavf_tx_ring;
> +	volatile struct ci_tx_desc *txr =3D txq->iavf_tx_ring;
>  	struct ci_tx_entry *txe_ring =3D txq->sw_ring;
>  	struct ci_tx_entry *txe, *txn;
>  	struct rte_mbuf *mb, *mb_seg;
> @@ -2774,7 +2774,7 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  	txe =3D &txe_ring[desc_idx];
>=20
>  	for (idx =3D 0; idx < nb_pkts; idx++) {
> -		volatile struct iavf_tx_desc *ddesc;
> +		volatile struct ci_tx_desc *ddesc;
>  		struct iavf_ipsec_crypto_pkt_metadata *ipsec_md;
>=20
>  		uint16_t nb_desc_ctx, nb_desc_ipsec;
> @@ -2895,7 +2895,7 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  		mb_seg =3D mb;
>=20
>  		do {
> -			ddesc =3D (volatile struct iavf_tx_desc *)
> +			ddesc =3D (volatile struct ci_tx_desc *)
>  					&txr[desc_idx];
>=20
>  			txn =3D &txe_ring[txe->next_id];
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.h
> b/drivers/net/intel/iavf/iavf_rxtx.h
> index e1f78dcde0..dd6d884fc1 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.h
> +++ b/drivers/net/intel/iavf/iavf_rxtx.h
> @@ -678,7 +678,7 @@ void iavf_dump_tx_descriptor(const struct
> ci_tx_queue *txq,
>  			    const volatile void *desc, uint16_t tx_id)
>  {
>  	const char *name;
> -	const volatile struct iavf_tx_desc *tx_desc =3D desc;
> +	const volatile struct ci_tx_desc *tx_desc =3D desc;
>  	enum iavf_tx_desc_dtype_value type;
>=20
>=20
> diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
> b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
> index e29958e0bc..5b62d51cf7 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
> @@ -1630,7 +1630,7 @@
> iavf_recv_scattered_pkts_vec_avx2_flex_rxd_offload(void *rx_queue,
>=20
>=20
>  static __rte_always_inline void
> -iavf_vtx1(volatile struct iavf_tx_desc *txdp,
> +iavf_vtx1(volatile struct ci_tx_desc *txdp,
>  	  struct rte_mbuf *pkt, uint64_t flags, bool offload, uint8_t vlan_flag=
)
>  {
>  	uint64_t high_qw =3D
> @@ -1646,7 +1646,7 @@ iavf_vtx1(volatile struct iavf_tx_desc *txdp,
>  }
>=20
>  static __rte_always_inline void
> -iavf_vtx(volatile struct iavf_tx_desc *txdp,
> +iavf_vtx(volatile struct ci_tx_desc *txdp,
>  	 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags, bool
> offload, uint8_t vlan_flag)
>  {
>  	const uint64_t hi_qw_tmpl =3D (IAVF_TX_DESC_DTYPE_DATA |
> @@ -1713,7 +1713,7 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  			       uint16_t nb_pkts, bool offload)
>  {
>  	struct ci_tx_queue *txq =3D (struct ci_tx_queue *)tx_queue;
> -	volatile struct iavf_tx_desc *txdp;
> +	volatile struct ci_tx_desc *txdp;
>  	struct ci_tx_entry_vec *txep;
>  	uint16_t n, nb_commit, tx_id;
>  	/* bit2 is reserved and must be set to 1 according to Spec */
> diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> index 7c0907b7cf..d79d96c7b7 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> @@ -1840,7 +1840,7 @@ tx_backlog_entry_avx512(struct ci_tx_entry_vec
> *txep,
>  }
>=20
>  static __rte_always_inline void
> -iavf_vtx1(volatile struct iavf_tx_desc *txdp,
> +iavf_vtx1(volatile struct ci_tx_desc *txdp,
>  	  struct rte_mbuf *pkt, uint64_t flags,
>  	  bool offload, uint8_t vlan_flag)
>  {
> @@ -1859,7 +1859,7 @@ iavf_vtx1(volatile struct iavf_tx_desc *txdp,
>  #define IAVF_TX_LEN_MASK 0xAA
>  #define IAVF_TX_OFF_MASK 0x55
>  static __rte_always_inline void
> -iavf_vtx(volatile struct iavf_tx_desc *txdp,
> +iavf_vtx(volatile struct ci_tx_desc *txdp,
>  		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
>  		bool offload, uint8_t vlan_flag)
>  {
> @@ -2068,7 +2068,7 @@ iavf_fill_ctx_desc_tunnelling_field(volatile uint64=
_t
> *qw0,
>  }
>=20
>  static __rte_always_inline void
> -ctx_vtx1(volatile struct iavf_tx_desc *txdp, struct rte_mbuf *pkt,
> +ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
>  		uint64_t flags, bool offload, uint8_t vlan_flag)
>  {
>  	uint64_t high_ctx_qw =3D IAVF_TX_DESC_DTYPE_CONTEXT;
> @@ -2106,7 +2106,7 @@ ctx_vtx1(volatile struct iavf_tx_desc *txdp, struct
> rte_mbuf *pkt,
>  }
>=20
>  static __rte_always_inline void
> -ctx_vtx(volatile struct iavf_tx_desc *txdp,
> +ctx_vtx(volatile struct ci_tx_desc *txdp,
>  		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
>  		bool offload, uint8_t vlan_flag)
>  {
> @@ -2203,7 +2203,7 @@ iavf_xmit_fixed_burst_vec_avx512(void
> *tx_queue, struct rte_mbuf **tx_pkts,
>  				 uint16_t nb_pkts, bool offload)
>  {
>  	struct ci_tx_queue *txq =3D (struct ci_tx_queue *)tx_queue;
> -	volatile struct iavf_tx_desc *txdp;
> +	volatile struct ci_tx_desc *txdp;
>  	struct ci_tx_entry_vec *txep;
>  	uint16_t n, nb_commit, tx_id;
>  	/* bit2 is reserved and must be set to 1 according to Spec */
> @@ -2271,7 +2271,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void
> *tx_queue, struct rte_mbuf **tx_pkts,
>  				 uint16_t nb_pkts, bool offload)
>  {
>  	struct ci_tx_queue *txq =3D (struct ci_tx_queue *)tx_queue;
> -	volatile struct iavf_tx_desc *txdp;
> +	volatile struct ci_tx_desc *txdp;
>  	struct ci_tx_entry_vec *txep;
>  	uint16_t n, nb_commit, nb_mbuf, tx_id;
>  	/* bit2 is reserved and must be set to 1 according to Spec */
> diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c
> b/drivers/net/intel/ice/ice_dcf_ethdev.c
> index 81da5a4656..ab1d499cef 100644
> --- a/drivers/net/intel/ice/ice_dcf_ethdev.c
> +++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
> @@ -399,7 +399,7 @@ reset_tx_queue(struct ci_tx_queue *txq)
>  	}
>=20
>  	txe =3D txq->sw_ring;
> -	size =3D sizeof(struct ice_tx_desc) * txq->nb_tx_desc;
> +	size =3D sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
>  	for (i =3D 0; i < size; i++)
>  		((volatile char *)txq->ice_tx_ring)[i] =3D 0;
>=20
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice=
_rxtx.c
> index f3bc79423d..74b80e7df3 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -1115,13 +1115,13 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
>  	}
>=20
>  	txe =3D txq->sw_ring;
> -	size =3D sizeof(struct ice_tx_desc) * txq->nb_tx_desc;
> +	size =3D sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
>  	for (i =3D 0; i < size; i++)
>  		((volatile char *)txq->ice_tx_ring)[i] =3D 0;
>=20
>  	prev =3D (uint16_t)(txq->nb_tx_desc - 1);
>  	for (i =3D 0; i < txq->nb_tx_desc; i++) {
> -		volatile struct ice_tx_desc *txd =3D &txq->ice_tx_ring[i];
> +		volatile struct ci_tx_desc *txd =3D &txq->ice_tx_ring[i];
>=20
>  		txd->cmd_type_offset_bsz =3D
>  			rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE);
> @@ -1623,7 +1623,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  	}
>=20
>  	/* Allocate TX hardware ring descriptors. */
> -	ring_size =3D sizeof(struct ice_tx_desc) *
> ICE_MAX_NUM_DESC_BY_MAC(hw);
> +	ring_size =3D sizeof(struct ci_tx_desc) *
> ICE_MAX_NUM_DESC_BY_MAC(hw);
>  	ring_size =3D RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
>  	tz =3D rte_eth_dma_zone_reserve(dev, "ice_tx_ring", queue_idx,
>  				      ring_size, ICE_RING_BASE_ALIGN,
> @@ -2619,7 +2619,7 @@ ice_fdir_setup_tx_resources(struct ice_pf *pf)
>  	}
>=20
>  	/* Allocate TX hardware ring descriptors. */
> -	ring_size =3D sizeof(struct ice_tx_desc) * ICE_FDIR_NUM_TX_DESC;
> +	ring_size =3D sizeof(struct ci_tx_desc) * ICE_FDIR_NUM_TX_DESC;
>  	ring_size =3D RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
>=20
>  	tz =3D rte_eth_dma_zone_reserve(dev, "fdir_tx_ring",
> @@ -2638,7 +2638,7 @@ ice_fdir_setup_tx_resources(struct ice_pf *pf)
>  	txq->ice_vsi =3D pf->fdir.fdir_vsi;
>=20
>  	txq->tx_ring_dma =3D tz->iova;
> -	txq->ice_tx_ring =3D (struct ice_tx_desc *)tz->addr;
> +	txq->ice_tx_ring =3D (struct ci_tx_desc *)tz->addr;
>  	/*
>  	 * don't need to allocate software ring and reset for the fdir
>  	 * program queue just set the queue has been configured.
> @@ -3027,7 +3027,7 @@ static inline int
>  ice_xmit_cleanup(struct ci_tx_queue *txq)
>  {
>  	struct ci_tx_entry *sw_ring =3D txq->sw_ring;
> -	volatile struct ice_tx_desc *txd =3D txq->ice_tx_ring;
> +	volatile struct ci_tx_desc *txd =3D txq->ice_tx_ring;
>  	uint16_t last_desc_cleaned =3D txq->last_desc_cleaned;
>  	uint16_t nb_tx_desc =3D txq->nb_tx_desc;
>  	uint16_t desc_to_clean_to;
> @@ -3148,8 +3148,8 @@ uint16_t
>  ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkt=
s)
>  {
>  	struct ci_tx_queue *txq;
> -	volatile struct ice_tx_desc *ice_tx_ring;
> -	volatile struct ice_tx_desc *txd;
> +	volatile struct ci_tx_desc *ice_tx_ring;
> +	volatile struct ci_tx_desc *txd;
>  	struct ci_tx_entry *sw_ring;
>  	struct ci_tx_entry *txe, *txn;
>  	struct rte_mbuf *tx_pkt;
> @@ -3312,7 +3312,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>=20
>  			while ((ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
> RTE_MBUF_F_TX_UDP_SEG)) &&
>  				unlikely(slen > ICE_MAX_DATA_PER_TXD)) {
> -				txd->buf_addr =3D
> rte_cpu_to_le_64(buf_dma_addr);
> +				txd->buffer_addr =3D
> rte_cpu_to_le_64(buf_dma_addr);
>  				txd->cmd_type_offset_bsz =3D
>  				rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DATA
> |
>  				((uint64_t)td_cmd << ICE_TXD_QW1_CMD_S)
> |
> @@ -3331,7 +3331,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  				txn =3D &sw_ring[txe->next_id];
>  			}
>=20
> -			txd->buf_addr =3D rte_cpu_to_le_64(buf_dma_addr);
> +			txd->buffer_addr =3D rte_cpu_to_le_64(buf_dma_addr);
>  			txd->cmd_type_offset_bsz =3D
>  				rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DATA
> |
>  				((uint64_t)td_cmd << ICE_TXD_QW1_CMD_S)
> |
> @@ -3563,14 +3563,14 @@ ice_tx_done_cleanup(void *txq, uint32_t
> free_cnt)
>=20
>  /* Populate 4 descriptors with data from 4 mbufs */
>  static inline void
> -tx4(volatile struct ice_tx_desc *txdp, struct rte_mbuf **pkts)
> +tx4(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
>  {
>  	uint64_t dma_addr;
>  	uint32_t i;
>=20
>  	for (i =3D 0; i < 4; i++, txdp++, pkts++) {
>  		dma_addr =3D rte_mbuf_data_iova(*pkts);
> -		txdp->buf_addr =3D rte_cpu_to_le_64(dma_addr);
> +		txdp->buffer_addr =3D rte_cpu_to_le_64(dma_addr);
>  		txdp->cmd_type_offset_bsz =3D
>  			ice_build_ctob((uint32_t)ICE_TD_CMD, 0,
>  				       (*pkts)->data_len, 0);
> @@ -3579,12 +3579,12 @@ tx4(volatile struct ice_tx_desc *txdp, struct
> rte_mbuf **pkts)
>=20
>  /* Populate 1 descriptor with data from 1 mbuf */
>  static inline void
> -tx1(volatile struct ice_tx_desc *txdp, struct rte_mbuf **pkts)
> +tx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts)
>  {
>  	uint64_t dma_addr;
>=20
>  	dma_addr =3D rte_mbuf_data_iova(*pkts);
> -	txdp->buf_addr =3D rte_cpu_to_le_64(dma_addr);
> +	txdp->buffer_addr =3D rte_cpu_to_le_64(dma_addr);
>  	txdp->cmd_type_offset_bsz =3D
>  		ice_build_ctob((uint32_t)ICE_TD_CMD, 0,
>  			       (*pkts)->data_len, 0);
> @@ -3594,7 +3594,7 @@ static inline void
>  ice_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
>  		    uint16_t nb_pkts)
>  {
> -	volatile struct ice_tx_desc *txdp =3D &txq->ice_tx_ring[txq->tx_tail];
> +	volatile struct ci_tx_desc *txdp =3D &txq->ice_tx_ring[txq->tx_tail];
>  	struct ci_tx_entry *txep =3D &txq->sw_ring[txq->tx_tail];
>  	const int N_PER_LOOP =3D 4;
>  	const int N_PER_LOOP_MASK =3D N_PER_LOOP - 1;
> @@ -3627,7 +3627,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
>  	     struct rte_mbuf **tx_pkts,
>  	     uint16_t nb_pkts)
>  {
> -	volatile struct ice_tx_desc *txr =3D txq->ice_tx_ring;
> +	volatile struct ci_tx_desc *txr =3D txq->ice_tx_ring;
>  	uint16_t n =3D 0;
>=20
>  	/**
> @@ -4882,7 +4882,7 @@ ice_fdir_programming(struct ice_pf *pf, struct
> ice_fltr_desc *fdir_desc)
>  	struct ci_tx_queue *txq =3D pf->fdir.txq;
>  	struct ci_rx_queue *rxq =3D pf->fdir.rxq;
>  	volatile struct ice_fltr_desc *fdirdp;
> -	volatile struct ice_tx_desc *txdp;
> +	volatile struct ci_tx_desc *txdp;
>  	uint32_t td_cmd;
>  	uint16_t i;
>=20
> @@ -4892,7 +4892,7 @@ ice_fdir_programming(struct ice_pf *pf, struct
> ice_fltr_desc *fdir_desc)
>  	fdirdp->dtype_cmd_vsi_fdid =3D fdir_desc->dtype_cmd_vsi_fdid;
>=20
>  	txdp =3D &txq->ice_tx_ring[txq->tx_tail + 1];
> -	txdp->buf_addr =3D rte_cpu_to_le_64(pf->fdir.dma_addr);
> +	txdp->buffer_addr =3D rte_cpu_to_le_64(pf->fdir.dma_addr);
>  	td_cmd =3D ICE_TX_DESC_CMD_EOP |
>  		ICE_TX_DESC_CMD_RS  |
>  		ICE_TX_DESC_CMD_DUMMY;
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> index 0ba1d557ca..bef7bb00ba 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> @@ -774,7 +774,7 @@ ice_recv_scattered_pkts_vec_avx2_offload(void
> *rx_queue,
>  }
>=20
>  static __rte_always_inline void
> -ice_vtx1(volatile struct ice_tx_desc *txdp,
> +ice_vtx1(volatile struct ci_tx_desc *txdp,
>  	 struct rte_mbuf *pkt, uint64_t flags, bool offload)
>  {
>  	uint64_t high_qw =3D
> @@ -789,7 +789,7 @@ ice_vtx1(volatile struct ice_tx_desc *txdp,
>  }
>=20
>  static __rte_always_inline void
> -ice_vtx(volatile struct ice_tx_desc *txdp,
> +ice_vtx(volatile struct ci_tx_desc *txdp,
>  	struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags, bool offload)
>  {
>  	const uint64_t hi_qw_tmpl =3D (ICE_TX_DESC_DTYPE_DATA |
> @@ -852,7 +852,7 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  			      uint16_t nb_pkts, bool offload)
>  {
>  	struct ci_tx_queue *txq =3D (struct ci_tx_queue *)tx_queue;
> -	volatile struct ice_tx_desc *txdp;
> +	volatile struct ci_tx_desc *txdp;
>  	struct ci_tx_entry_vec *txep;
>  	uint16_t n, nb_commit, tx_id;
>  	uint64_t flags =3D ICE_TD_CMD;
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> index 7c6fe82072..1f6bf5fc8e 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> @@ -847,7 +847,7 @@ ice_recv_scattered_pkts_vec_avx512_offload(void
> *rx_queue,
>  }
>=20
>  static __rte_always_inline void
> -ice_vtx1(volatile struct ice_tx_desc *txdp,
> +ice_vtx1(volatile struct ci_tx_desc *txdp,
>  	 struct rte_mbuf *pkt, uint64_t flags, bool do_offload)
>  {
>  	uint64_t high_qw =3D
> @@ -863,7 +863,7 @@ ice_vtx1(volatile struct ice_tx_desc *txdp,
>  }
>=20
>  static __rte_always_inline void
> -ice_vtx(volatile struct ice_tx_desc *txdp, struct rte_mbuf **pkt,
> +ice_vtx(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkt,
>  	uint16_t nb_pkts,  uint64_t flags, bool do_offload)
>  {
>  	const uint64_t hi_qw_tmpl =3D (ICE_TX_DESC_DTYPE_DATA |
> @@ -916,7 +916,7 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  				uint16_t nb_pkts, bool do_offload)
>  {
>  	struct ci_tx_queue *txq =3D (struct ci_tx_queue *)tx_queue;
> -	volatile struct ice_tx_desc *txdp;
> +	volatile struct ci_tx_desc *txdp;
>  	struct ci_tx_entry_vec *txep;
>  	uint16_t n, nb_commit, tx_id;
>  	uint64_t flags =3D ICE_TD_CMD;
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c
> b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index 797ee515dd..be3c1ef216 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -264,13 +264,13 @@ idpf_qc_single_tx_queue_reset(struct ci_tx_queue
> *txq)
>  	}
>=20
>  	txe =3D txq->sw_ring;
> -	size =3D sizeof(struct idpf_base_tx_desc) * txq->nb_tx_desc;
> +	size =3D sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
>  	for (i =3D 0; i < size; i++)
>  		((volatile char *)txq->idpf_tx_ring)[i] =3D 0;
>=20
>  	prev =3D (uint16_t)(txq->nb_tx_desc - 1);
>  	for (i =3D 0; i < txq->nb_tx_desc; i++) {
> -		txq->idpf_tx_ring[i].qw1 =3D
> +		txq->idpf_tx_ring[i].cmd_type_offset_bsz =3D
>=20
> 	rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
>  		txe[i].mbuf =3D  NULL;
>  		txe[i].last_id =3D i;
> @@ -1335,14 +1335,14 @@ idpf_xmit_cleanup(struct ci_tx_queue *txq)
>  	uint16_t desc_to_clean_to;
>  	uint16_t nb_tx_to_clean;
>=20
> -	volatile struct idpf_base_tx_desc *txd =3D txq->idpf_tx_ring;
> +	volatile struct ci_tx_desc *txd =3D txq->idpf_tx_ring;
>=20
>  	desc_to_clean_to =3D (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
>  	if (desc_to_clean_to >=3D nb_tx_desc)
>  		desc_to_clean_to =3D (uint16_t)(desc_to_clean_to -
> nb_tx_desc);
>=20
>  	desc_to_clean_to =3D sw_ring[desc_to_clean_to].last_id;
> -	if ((txd[desc_to_clean_to].qw1 &
> +	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
>  	     rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) !=3D
>  	    rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE)) {
>  		TX_LOG(DEBUG, "TX descriptor %4u is not done "
> @@ -1358,7 +1358,7 @@ idpf_xmit_cleanup(struct ci_tx_queue *txq)
>  		nb_tx_to_clean =3D (uint16_t)(desc_to_clean_to -
>  					    last_desc_cleaned);
>=20
> -	txd[desc_to_clean_to].qw1 =3D 0;
> +	txd[desc_to_clean_to].cmd_type_offset_bsz =3D 0;
>=20
>  	txq->last_desc_cleaned =3D desc_to_clean_to;
>  	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
> @@ -1372,8 +1372,8 @@ uint16_t
>  idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>  			  uint16_t nb_pkts)
>  {
> -	volatile struct idpf_base_tx_desc *txd;
> -	volatile struct idpf_base_tx_desc *txr;
> +	volatile struct ci_tx_desc *txd;
> +	volatile struct ci_tx_desc *txr;
>  	union idpf_tx_offload tx_offload =3D {0};
>  	struct ci_tx_entry *txe, *txn;
>  	struct ci_tx_entry *sw_ring;
> @@ -1491,8 +1491,8 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct
> rte_mbuf **tx_pkts,
>  			/* Setup TX Descriptor */
>  			slen =3D m_seg->data_len;
>  			buf_dma_addr =3D rte_mbuf_data_iova(m_seg);
> -			txd->buf_addr =3D rte_cpu_to_le_64(buf_dma_addr);
> -			txd->qw1 =3D
> rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DATA |
> +			txd->buffer_addr =3D rte_cpu_to_le_64(buf_dma_addr);
> +			txd->cmd_type_offset_bsz =3D
> rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DATA |
>  				((uint64_t)td_cmd  <<
> IDPF_TXD_QW1_CMD_S) |
>  				((uint64_t)td_offset <<
> IDPF_TXD_QW1_OFFSET_S) |
>  				((uint64_t)slen <<
> IDPF_TXD_QW1_TX_BUF_SZ_S));
> @@ -1519,7 +1519,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct
> rte_mbuf **tx_pkts,
>  			txq->nb_tx_used =3D 0;
>  		}
>=20
> -		txd->qw1 |=3D rte_cpu_to_le_16(td_cmd <<
> IDPF_TXD_QW1_CMD_S);
> +		txd->cmd_type_offset_bsz |=3D rte_cpu_to_le_16(td_cmd <<
> IDPF_TXD_QW1_CMD_S);
>  	}
>=20
>  end_of_tx:
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h
> b/drivers/net/intel/idpf/idpf_common_rxtx.h
> index 7c6ff5d047..2f2fa153b2 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.h
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
> @@ -182,7 +182,7 @@ union idpf_tx_offload {
>  };
>=20
>  union idpf_tx_desc {
> -	struct idpf_base_tx_desc *tx_ring;
> +	struct ci_tx_desc *tx_ring;
>  	struct idpf_flex_tx_sched_desc *desc_ring;
>  	struct idpf_splitq_tx_compl_desc *compl_ring;
>  };
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index 21c8f79254..5f5d538dcb 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -483,7 +483,7 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue,
> struct rte_mbuf **rx_pkts, uint16
>  }
>=20
>  static inline void
> -idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
> +idpf_singleq_vtx1(volatile struct ci_tx_desc *txdp,
>  		  struct rte_mbuf *pkt, uint64_t flags)
>  {
>  	uint64_t high_qw =3D
> @@ -497,7 +497,7 @@ idpf_singleq_vtx1(volatile struct idpf_base_tx_desc
> *txdp,
>  }
>=20
>  static inline void
> -idpf_singleq_vtx(volatile struct idpf_base_tx_desc *txdp,
> +idpf_singleq_vtx(volatile struct ci_tx_desc *txdp,
>  		 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
>  {
>  	const uint64_t hi_qw_tmpl =3D (IDPF_TX_DESC_DTYPE_DATA |
> @@ -556,7 +556,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void
> *tx_queue, struct rte_mbuf **tx_pkts
>  				       uint16_t nb_pkts)
>  {
>  	struct ci_tx_queue *txq =3D (struct ci_tx_queue *)tx_queue;
> -	volatile struct idpf_base_tx_desc *txdp;
> +	volatile struct ci_tx_desc *txdp;
>  	struct ci_tx_entry_vec *txep;
>  	uint16_t n, nb_commit, tx_id;
>  	uint64_t flags =3D IDPF_TX_DESC_CMD_EOP;
> @@ -604,7 +604,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void
> *tx_queue, struct rte_mbuf **tx_pkts
>=20
>  	tx_id =3D (uint16_t)(tx_id + nb_commit);
>  	if (tx_id > txq->tx_next_rs) {
> -		txq->idpf_tx_ring[txq->tx_next_rs].qw1 |=3D
> +		txq->idpf_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
>=20
> 	rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
>  					 IDPF_TXD_QW1_CMD_S);
>  		txq->tx_next_rs =3D
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> index bc2cadd738..c1ec3d1222 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> @@ -1000,7 +1000,7 @@ idpf_dp_splitq_recv_pkts_avx512(void *rx_queue,
> struct rte_mbuf **rx_pkts,
>  }
>=20
>  static __rte_always_inline void
> -idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
> +idpf_singleq_vtx1(volatile struct ci_tx_desc *txdp,
>  	  struct rte_mbuf *pkt, uint64_t flags)
>  {
>  	uint64_t high_qw =3D
> @@ -1016,7 +1016,7 @@ idpf_singleq_vtx1(volatile struct idpf_base_tx_desc
> *txdp,
>  #define IDPF_TX_LEN_MASK 0xAA
>  #define IDPF_TX_OFF_MASK 0x55
>  static __rte_always_inline void
> -idpf_singleq_vtx(volatile struct idpf_base_tx_desc *txdp,
> +idpf_singleq_vtx(volatile struct ci_tx_desc *txdp,
>  	 struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
>  {
>  	const uint64_t hi_qw_tmpl =3D (IDPF_TX_DESC_DTYPE_DATA  |
> @@ -1072,7 +1072,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void
> *tx_queue, struct rte_mbuf **tx_pk
>  					 uint16_t nb_pkts)
>  {
>  	struct ci_tx_queue *txq =3D tx_queue;
> -	volatile struct idpf_base_tx_desc *txdp;
> +	volatile struct ci_tx_desc *txdp;
>  	struct ci_tx_entry_vec *txep;
>  	uint16_t n, nb_commit, tx_id;
>  	uint64_t flags =3D IDPF_TX_DESC_CMD_EOP;
> @@ -1123,7 +1123,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void
> *tx_queue, struct rte_mbuf **tx_pk
>=20
>  	tx_id =3D (uint16_t)(tx_id + nb_commit);
>  	if (tx_id > txq->tx_next_rs) {
> -		txq->idpf_tx_ring[txq->tx_next_rs].qw1 |=3D
> +		txq->idpf_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
>=20
> 	rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
>  					 IDPF_TXD_QW1_CMD_S);
>  		txq->tx_next_rs =3D
> diff --git a/drivers/net/intel/idpf/idpf_rxtx.c
> b/drivers/net/intel/idpf/idpf_rxtx.c
> index cee454244f..8aa44585fe 100644
> --- a/drivers/net/intel/idpf/idpf_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_rxtx.c
> @@ -72,7 +72,7 @@ idpf_dma_zone_reserve(struct rte_eth_dev *dev,
> uint16_t queue_idx,
>  			ring_size =3D RTE_ALIGN(len * sizeof(struct
> idpf_flex_tx_sched_desc),
>  					      IDPF_DMA_MEM_ALIGN);
>  		else
> -			ring_size =3D RTE_ALIGN(len * sizeof(struct
> idpf_base_tx_desc),
> +			ring_size =3D RTE_ALIGN(len * sizeof(struct ci_tx_desc),
>  					      IDPF_DMA_MEM_ALIGN);
>  		rte_memcpy(ring_name, "idpf Tx ring", sizeof("idpf Tx ring"));
>  		break;
> diff --git a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
> b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
> index 425f0792a1..4702061484 100644
> --- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
> +++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
> @@ -31,7 +31,7 @@ idpf_tx_desc_done(struct ci_tx_queue *txq, uint16_t
> idx)
>  	if (txq->complq !=3D NULL)
>  		return 1;
>=20
> -	return (txq->idpf_tx_ring[idx].qw1 &
> +	return (txq->idpf_tx_ring[idx].cmd_type_offset_bsz &
>  			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) =3D=3D
>=20
> 	rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
>  }
> --
> 2.51.0

