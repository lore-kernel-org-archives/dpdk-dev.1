Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D775CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Sep 2025 09:04:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CAAE40655;
	Sun, 28 Sep 2025 11:04:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 905C9402EA;
 Sun, 28 Sep 2025 11:04:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759050259; x=1790586259;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xdVXQb5jI2OmTTpOCXM3Q1oItd7wmNzpFDVj9B62nfY=;
 b=C9rxbh5HV15dGDUk+WoZ9LCXgluNq4tp7to5pN23KPd0SPoy4ceRLyEO
 Dz5IFc5HFyubyf/qKwLmo3TeUYwHuEeU7bn/XiY4Unit/ovRai+zCrI13
 juK3Q0qxcQWcac+z9FXNGmYJ8G/VfEUVCpsli5BNKJ8UMr4tR0T0XDJJ3
 vrEQfLWXcCjWPXesehilasKsTiN/i0ZFAsMemTmaP/xVd+uYFb8UbpJvc
 Nb+7DDGQVla96RFJKAR7flZarm1PrOUK4KR+f23y6nsYdQiXqt56EK21h
 MtSpf8LBrkFYifQHKm8xCNg3BYsrSwkloXF1kvULZ3w6Cc5NucHs/Ttn0 w==;
X-CSE-ConnectionGUID: TMopzh3/SH6AfTVsyHxuVQ==
X-CSE-MsgGUID: H08SLyDiTq+F0kh2qmS3KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="72755632"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="72755632"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 02:04:17 -0700
X-CSE-ConnectionGUID: aYsdj6/zQ0qtilhk3ocLUw==
X-CSE-MsgGUID: MOHy9OVETkGZHv8H+3WcZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="183151644"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 02:04:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 02:04:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 28 Sep 2025 02:04:16 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 02:04:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKwBSVb7di8Q5U9A38fk2MWwRGMaLbnpfn/YZSosZn7mEXWAdyyUfQdT5HnXCMCb+jT7XHYf1JjVIKWzn4Eaxhd2XYuNt3miEhluJvQAjqlwJhj+pBlQEhJQeNulhYRYiKFEleYIPusZIZhVFojStZEAUFRK2atiDJ5FQad3VLm8ZN5GV0l+0slLl1QrKIL6v6Ryl4yNlCxR7SSy0FhjwCdDP7EAbZZ1pRvEfcyxA5jqS/IZkPZIfTLxqqsMF9sW+b2aDyckviXX+pRTfnbMMIwvI+7EyNBuiJN99eNn/ptmJISO5OCaVprHsKxNBuEfn9APJD1ln8xb7+PxHqfFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdVXQb5jI2OmTTpOCXM3Q1oItd7wmNzpFDVj9B62nfY=;
 b=nnJOf4mbvl48a4sUHTD+E2a94faU+E4snuu2HsDAmqjJTq6lJU+nyJ211DjtsuAYFTR2+/61hz6lluSnzXxALMKQL868ws+nUFvotdUgAXVq5cPL2haAbtTgdntqRDxzRntXOaVw9PlhapXxTE25Q5zNhWzttxpkWelBcdbXiY804e0MVlGXp9PTzfTPviPe8Bra+8KNwYltenrCrFtwdUUE6EWCzHJsjsZ4bCE5d5jhW7eTCHGW0noVvR04PLbPdAMJTYnpN7LvwdUu0lBYnQvhFeZ1+y5pweJpNLSAOpiKopv3cUuCP2wk233+ROtbTnZMdW9/CAyka0wn5IEwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF653E4B531.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::74) by PH7PR11MB6008.namprd11.prod.outlook.com
 (2603:10b6:510:1d0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 09:04:10 +0000
Received: from DS4PPF653E4B531.namprd11.prod.outlook.com
 ([fe80::f2bd:46a6:b761:8e10]) by DS4PPF653E4B531.namprd11.prod.outlook.com
 ([fe80::f2bd:46a6:b761:8e10%7]) with mapi id 15.20.9115.020; Sun, 28 Sep 2025
 09:04:10 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: "Zeng, ZhichaoX" <zhichaox.zeng@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "Zeng, ZhichaoX"
 <zhichaox.zeng@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Ferruh Yigit <ferruh.yigit@amd.com>, "Shahaf
 Shuler" <shahafs@nvidia.com>
Subject: RE: [PATCH] examples/ip_reassembly: remove conflicting Tx offload
Thread-Topic: [PATCH] examples/ip_reassembly: remove conflicting Tx offload
Thread-Index: AQHcKTH5sW4+x+kH7kaa8mdSQb4XvrSoWt7Q
Date: Sun, 28 Sep 2025 09:04:10 +0000
Message-ID: <DS4PPF653E4B5319321D7269925038504289F18A@DS4PPF653E4B531.namprd11.prod.outlook.com>
References: <20250919071213.818567-1-zhichaox.zeng@intel.com>
In-Reply-To: <20250919071213.818567-1-zhichaox.zeng@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF653E4B531:EE_|PH7PR11MB6008:EE_
x-ms-office365-filtering-correlation-id: eeede68b-570b-4c37-c0d6-08ddfe6dfcee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?93GUwBi/ObtYwt7izNgncGR7kdBHW6koEE8NmnUG+OLOL3SLKyGaaaFUWG4+?=
 =?us-ascii?Q?REljg4ArIyqrbxVlktDk3qDUBkPkQWiYLKfhL+8QN5XOCnJMNVG1XZhOOF5d?=
 =?us-ascii?Q?lWthok/BLqOfVGhuQ8ZLTmEcHPgTzg7k1+t0RSTzhgwtA8VgFKEEsBkDh8oY?=
 =?us-ascii?Q?C6FYP6/QA5MGatfe/SA1Q2sbv0FVVF9HNLAxlBjmZuDTAeu6A+dBhwYDEfe5?=
 =?us-ascii?Q?kMR/+YWB2/ZJK5aYojrh9pKBNcLigatTNkWNgTt7OacXENaYGcMpz+lQoCuf?=
 =?us-ascii?Q?9VbPjTyzWm8V63iB3eDFWg8i8+KdT1V1MPou202gsCmq2ygy8NJD4WKpXn9q?=
 =?us-ascii?Q?Juj4SI/GYMQ2SP1/GrP9R3waEcoZ1sLG4hrtYX+7kbCb5PZEuf1KDXKvsZzr?=
 =?us-ascii?Q?2TZU0ZaKML7Ja0JY/Kb3MXufwCCXCHJkVcTMcWd9JUOJXg+AORtCFRUKAkHh?=
 =?us-ascii?Q?SUYH8HMZpUI5SNmkL5sMFWySlDSHoAzg0tCwbPyqQaAUv3J/bYJmJsxs94/d?=
 =?us-ascii?Q?YQIcenGVTFfhwTkeVfYJhW4p34Yg3BpBorhOMmW6MgXX0c6WwGugwaRULEWn?=
 =?us-ascii?Q?9VdV/jbXpiqGQGutwfu+Dn9HVyhqXXwduWyU55BL+7hs8wfrDSCWq/mYichB?=
 =?us-ascii?Q?4SrUWAhsSDsXyJQyJqAnpAAEDS632HuEl7Jlc4Difzda9enQzKZAAnMVYrqu?=
 =?us-ascii?Q?0O7mKbON3kg2PW5qlcsGk3tWYt17zxNd9QzcxOKSU+RJOI8CBjaQO0MYmuSN?=
 =?us-ascii?Q?xilDYXJIWjBcR6UnE7WJJIPRHuRVyrG+tttEuRZAkO/qO12t/hcPhkFSruKo?=
 =?us-ascii?Q?0RUBT85iyoh/phhdSTxuwikcFb4TipF4hyt08l7kj2+HZZX91LmsKSiPsC0N?=
 =?us-ascii?Q?urO+vRwNXpFoZ6hj4dPJPuY1zGIT/oCPZB6wtbKbSBiVjYNP01EfJ9AZ1vNJ?=
 =?us-ascii?Q?H6zqJSzKB9AZuU9v8ye4IIM2KyBSDErpFGh6l49jcKRWJV2c3SXd2efw9dfz?=
 =?us-ascii?Q?K4KM1YmHHWguFvbMLP93D+95lFXR6UxXBRa/77uxcTkOlJNfOiiqLGgknXGA?=
 =?us-ascii?Q?33Is8SJP1P9aJACb2r0JP3aa727FhO2NfUED4EmJSzmysuDIx5FYKggz9F+7?=
 =?us-ascii?Q?HMESQdLFmO6ZEHZPPFy4G0GoUOmWuxtKWHvqmInvj+EbNNK32uLbsStYligF?=
 =?us-ascii?Q?50RvV54ESYnNTIOaOBlb6D6MV46ZDtIUX9Mf/wZbzyMVz4BDW6jf4tsO35+k?=
 =?us-ascii?Q?ueTw/5yjrXq3pWoaCXExJvnYoIUKVP8li+j4q4VfFSU2ILzQ8rnmKqnSTyQH?=
 =?us-ascii?Q?Xl2S2OcYCqxOg+RHbqfhPSYPBum43Ry9biboUF+ivsRuUYbY89NhgymKcm5b?=
 =?us-ascii?Q?f2IHL9pxh0ZCZUZpRkOVEUUDO7Pha2zXgIV6ezZciFCRPGUdUjwMSXvyfATU?=
 =?us-ascii?Q?PI7sefIMGt5h/WACUXhHRimBR3xZMZH39FFPlIQ7Uh4u9z+KNkGvuPsQSM2P?=
 =?us-ascii?Q?DVDhW12TUHmlgyNc9c0w1O/cP7IiP+2MYxfv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF653E4B531.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Ch/g6txg2AISdAd6hc10Wc6zAQ8igzNoJ3LnXOtiX1b7TLko3ofo1LhcB/7?=
 =?us-ascii?Q?plYExJr5YNpO+63HBJeDug6uYWP2q3IMNlfN7JLzAVBi17GRuyqmcuLxCnKQ?=
 =?us-ascii?Q?QbZx+C1tXey7PduVamqZQ1bbsIst6pNasBsc+d7en9GXhL82Ud1vRDPqm+98?=
 =?us-ascii?Q?+YZM6HLZ88kbf27dtPsO6jqfoiDxp0WphCqT+SnWh6ypMj3KDFEvDgup8FhU?=
 =?us-ascii?Q?K5FY2MR08HOn9u4JWK7Pr2aLqx8haE9OdMkHWhKf4TxUSozhFB1fEdrqOMdo?=
 =?us-ascii?Q?TwGRoxZRxTbH76rLP1U4zWP+xCeW/3X+rvgJzliKXzVsesFryhPHd4F+KghS?=
 =?us-ascii?Q?sH2zj+EFtb+Yf77AYa18L1Bc1JkBaTZ39CZkr4QWG3Jbi831iyw+2OyQELvw?=
 =?us-ascii?Q?hAX+PFkGUPutNa3Mzt0YNkfoqcsyo/6EKiYAUabtICyVYi/zXxAq5Mu8dm8q?=
 =?us-ascii?Q?pVY8Uv+2YxHYFUX49SDN/u0lKo2j3WaBgySbxjET1PtJWWe8XDYzWFIzPPAf?=
 =?us-ascii?Q?sNjpU3fy+0sq5Bi/wOEuCWMwZK6nTzC8YuEaVfL3DunYo2BU/ujEmUom6J+0?=
 =?us-ascii?Q?37ztdcUcejL/RCLgsiNdkbhUs26EvqnoGh7nsqNhhgCIYZN+wBO63794ZUJG?=
 =?us-ascii?Q?EcKysR54TcqWGZHvbbzmc+8v/epzruq+67h2PMNoyWwimPkynKG3ZpXPCtrJ?=
 =?us-ascii?Q?12Fsbzs63sgrTkI7m+YnTqGdrJ3wY5TAuFvoTgn+0gXKie3JAWWIYP7PGlvU?=
 =?us-ascii?Q?csbPF/ldjeyIt/vt7P3AvvW2N0yvVedoZ3uVT9XoJtR4tidWb2l4fy2+cPKS?=
 =?us-ascii?Q?hhADrwANuV1+6Wd62VaZD1ZLWb9WrCN71sS8PyXTHGfn95qoZ70XiQvGyia7?=
 =?us-ascii?Q?iwCOPEZEeyqerHH7uQZQNS9jXG+S15k5h69HOb088W3T2kmiQ0opBb4trbPl?=
 =?us-ascii?Q?Az7QwlN4Spy2SBLyVEtrdjcx5F4FrZRIjsskW54Tzl07twiWMjfBcjhEd/51?=
 =?us-ascii?Q?VjBD44ci6F3bENCXNLooWVVh8v7KEMQOIEII4OimhtdeusppBfDdJoAZJ0Xa?=
 =?us-ascii?Q?JDQVEbGVThPXubjlbGp49bcf10B5XpBTxORs98hdmsZcQQkpn6lI357Fjae6?=
 =?us-ascii?Q?QyfsthJ6y3mqhRZP3uQ3MqGwzMiakTeoHvJEbSqNdtSXw58m0a7cR0JUfPdG?=
 =?us-ascii?Q?S/AcC3d5xE6mSZQxMCJ81zSt5d2mNB08CV+7+3jmuF+qMpKBQRIeX99NuPKA?=
 =?us-ascii?Q?8k8vFkDE53sWydz0EWFneEyn97PCjTeM1hAUql8y+2msccz07HUXnTinfMJu?=
 =?us-ascii?Q?drFXtSuo2lzsdBSaT3PH3FVOty6QgKszXXGy7DWPMuZlhjgJkdo5hAnvJKtt?=
 =?us-ascii?Q?WopbdL06tqLBzt62QRM17cVFytkX83MfCc6htZ2d1uZI5D5FDJJefvsP5kYG?=
 =?us-ascii?Q?Aec+ZHzaGveHiqsr4K4wFVFLnq2pDbVvBlPJTILyj+ERVksgS0jk0K7klfYr?=
 =?us-ascii?Q?UGGtKJspwTRzQ7uekD9lWOeGUcYjl3Rh+53WNIKutRqfoYcCp89TQLvpkTcm?=
 =?us-ascii?Q?LbnkTvA3TO8EFngriuiZ5dK+GTWJSW1vksSdQisI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF653E4B531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeede68b-570b-4c37-c0d6-08ddfe6dfcee
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2025 09:04:10.4708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VR6EKhreI4mLcAq6AIbXj9imqFXn1UWNrlEuBiH54NntZBKV/4/n8Mn6icRWBd0vQqFFTWT9RC24KGmmYV9HRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6008
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
> From: Zhichao Zeng <zhichaox.zeng@intel.com>
> Sent: Friday, September 19, 2025 3:12 PM
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Zeng, ZhichaoX <zhichaox.zeng@intel.com>; Konstantin
> Ananyev <konstantin.ananyev@huawei.com>; Ferruh Yigit
> <ferruh.yigit@amd.com>; Shahaf Shuler <shahafs@nvidia.com>
> Subject: [PATCH] examples/ip_reassembly: remove conflicting Tx offload
>=20
> IP packet reassembly requires the MULTI_SEGS offload to be enabled in ord=
er
> to handle fragmented packets across multiple memory segments. However,
> the MBUF_FAST_FREE offload conflicts with MULTI_SEGS and cannot be
> enabled simultaneously.
>=20
> Remove the MBUF_FAST_FREE offload to avoid conflicts with MULTI_SEGS.
>=20
> Fixes: 9df56e69ee3f ("examples/ip_reassembly: convert to new ethdev
> offloads API")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Zhichao Zeng <zhichaox.zeng@intel.com>
> ---
Tested-by: Xu, HailinX <hailinx.xu@intel.com>
