Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EA8C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:52:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25BF14029F;
	Wed, 26 Feb 2025 09:52:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5A3F74027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 09:52:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740559952; x=1772095952;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=467+Zqwi5jaMT/LA6EaYuTNnt3HYNYxdkrtXSkEJ/VY=;
 b=k5ra4YfMK9v0ltq3MYveEQ/jVgfHv1tEhg7Ps70siNHNXCgQN6cup1QE
 W4VABuwJotRjUzEY9yrD5YTYYFLAOgH25qXMAZs4UCmeAIB/oA2+BHTcC
 0W/bf9ouwC4KlzX9wJoOW2Mb6wnbNzioD0rYATHugqpdUCYp63loKvpkZ
 qsxqp2rKRFDaRNIRvtwKtL0Qj4XMuxBFzU6BPIe8NJSkYbGYQmDZIUUuE
 pfUd3cEPb+9D9hXIebz6DtdMufeA+3DQTq35OrpTNsoED90/wTQo75Bkb
 w/JPNhIFjIwuwydQ0ZG6lFbA3TxNLj/3yDfJzlR/TkLo93D1/Sh9odcJj A==;
X-CSE-ConnectionGUID: R6CyNrzZRou6ny+UFVXXOQ==
X-CSE-MsgGUID: HAd1YoXjQHexpkHBlo1eww==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="51605557"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="51605557"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 00:52:30 -0800
X-CSE-ConnectionGUID: OupztgUESE+b9HvqCZVsrA==
X-CSE-MsgGUID: ERcY3YkoQUmiZyoouJOcTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="116428866"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Feb 2025 00:52:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 00:52:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 00:52:29 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 00:52:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyzIOV1osl8eSf8N+ZM9IB8w9s4YsgforNJjP6JFq6yymQdg7Ph/Qz5/OlxT33KbnmQwuO5/eX1MdvqDkETPYS6TIamRvMaoprjJdJXJ7vVajt/7LCJdASZywWsDSfB3f3U2Hyp3g7+NMmmGQYRGOFEmwdvCydey6xXTRrxdbx2KLf9PadM6oy8Lsuy/MTNU8YC5GGuU+qKLp74qrKSDpvqcIHe2gH1jNFl2mXzSWnDTY8k4DWQDhtpqq5D3IzB67NG1yViYahg5xfe7pxrNM4hSOWA40cQzwcy6Ygv5jyKfA95+69I11hhQs7DD48yaEhDY5fKL+zvcddIZnVo/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0xHoE89KRsb9pB05QCW1+v4rUrdTp9Tnk2k7TuMv8k=;
 b=SBHilTB7zWHCFTcXj7WeMtHRaV6Re109i4/DxgMo2Xp1JnFnemSd0P6UPtF4c0iyI50wq1+rS0cQNUfROyvmM07n+vRTCE2pvWdy2txIsFgg/DbM5wHYrJ/nQWpHT/gyl/dz9oxaCOWUZ9PX59fXJpx/m8nemcRLWwnO08efIoe2cicPGtfiHvgLcHh+NZl3a6yVg5L7xvuxjNaLnbs/NMoncukwgjO2SBKjXhBHRshoyH07CtMjkqO7a8T7nz6tUdGR12r5nQBevXrlhBGC2zaeGoythNWHPNQa1EfwtADx/B4E4oni5bKwGClVYcbZEc16yWP7D6GCdogaAT1EaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22)
 by CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 08:52:08 +0000
Received: from DM4PR11MB7757.namprd11.prod.outlook.com
 ([fe80::60c9:10e5:60f0:13a1]) by DM4PR11MB7757.namprd11.prod.outlook.com
 ([fe80::60c9:10e5:60f0:13a1%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 08:52:08 +0000
From: "Xu, Rosen" <rosen.xu@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v2 05/14] net/ipn3ke: remove unnecessary dereference
Thread-Topic: [PATCH v2 05/14] net/ipn3ke: remove unnecessary dereference
Thread-Index: AQHbg0AfHyBs5H6e+EmxX1emDyRhn7NZUOJA
Date: Wed, 26 Feb 2025 08:52:08 +0000
Message-ID: <DM4PR11MB775774AC759BADC816980BDC89C22@DM4PR11MB7757.namprd11.prod.outlook.com>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220023509.630569-1-stephen@networkplumber.org>
 <20250220023509.630569-6-stephen@networkplumber.org>
In-Reply-To: <20250220023509.630569-6-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB7757:EE_|CY8PR11MB6865:EE_
x-ms-office365-filtering-correlation-id: 6195a800-5047-494a-474a-08dd5642d9f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3fjzulz4037Djy3fLUMUVfua5mBu/i7tnJbQyMde2mdyMI2Ja1vi1us5w1e4?=
 =?us-ascii?Q?C+bY5bbAdabLLlpGI6HOz8HHi0a4D8f9gsb9+HMNz6OxxA4L+I2qBrSK9uVb?=
 =?us-ascii?Q?+Z3gKn6mCnaOhyAp4X1R4rzgFO6g3Md7I3U/vPujewji3cIjSFcU8+QbE6NR?=
 =?us-ascii?Q?E6f9Vhwr9Weq2uQ1rlwd2hmBTwcW4kSo4fMcxb34IYt/XCiMJVyb3bwrLGKa?=
 =?us-ascii?Q?ruRcpqo6P/VUzT9zS5tSE1Oa3TFUDmwt+RJja9jDs4IBn/kuHzfoWAbEUGmu?=
 =?us-ascii?Q?ywb0qJeoPQ7dcV6j2yRjLcrxK7tx26JFQ32uij5BEiQnhZyCigyE21odXQ1h?=
 =?us-ascii?Q?myjtisOr4/KG9r28oKSJ0Ad4D4EheUZ0HxTfOnt3IlT8f3lahyyto7jL5QUi?=
 =?us-ascii?Q?Y2SyxZ6YWPq/zDoYP576VTvMozoM3FUPwsTj4HM0oZFgTRkm9kRbXN8VDfis?=
 =?us-ascii?Q?BuAQrMVQYYNCkQ7/1RMtG4fygJPJev0kdUDyIhERCIe76F8tVhmlBpUk5Atd?=
 =?us-ascii?Q?TFd65ooBAm4RNMCe7OihNkxeeJof/gCJK/k1yXnpZw6l1bj1yRWS1pmuWnXu?=
 =?us-ascii?Q?haoh4D7MQlxhKTbSD6rxjOcKYPvvHDjedTjxevIR3bgN10jEOFWRlwdRm8Gx?=
 =?us-ascii?Q?83R0DPfOli+9YiODiF1s778xGxchhQKDXS6Lajw6tC8PZQmnREHymYigfAqW?=
 =?us-ascii?Q?BJPSoFbCtBHhlR3kCfuydjCXHbc845GbsIynNZw1eRPP16vYrEVz8lbeQ773?=
 =?us-ascii?Q?DrsUYf4847iO9xerHf0eop3enOCOhZksgPZEOVQ3567ACqBvMohrqJio+/4M?=
 =?us-ascii?Q?06hOmtiSETdO3VX+yjHb72//NogFt3AjYrXVb+Hz/MMCWcSTEY0q9QJMIah7?=
 =?us-ascii?Q?elymQWsusISY5VqJdyH5A5phvBhUs5qSZ6T6dbjaYpcFx4R45EAX7hNtd13W?=
 =?us-ascii?Q?HGM0YKrFg/pxKaHXA8jNO5PUTRKdjQpUt8VFjqenXNnlwSMHHCVCTKl7Hq+u?=
 =?us-ascii?Q?hKy6Icq7Jy6FqTcz6MqAEF9chgtX+4jdP2uZAkHj5V4Ivk3zcubgyC0gemU0?=
 =?us-ascii?Q?2llaZ/vuI8+W7sgZwmT9eMoFXiWU1uuAMxirhk8s3RX/uszkNuavTPd1EeHY?=
 =?us-ascii?Q?B9UTcWEwlWSAM9B7oG7+6RTlcYn37XPj3Avtr8Fk/aOn7APdgUZrcZI5x6lO?=
 =?us-ascii?Q?/GEHVWzmHUjTpXmbMmObVT91LieStxdDMi+kzi93zs10xvRc4CFL/DBZEIX2?=
 =?us-ascii?Q?+t25ZRM7VNEObfSyHdxq0W1K+BkPjrB1cSfNVL6PXJHLi6LdMy4jxUtfHUqT?=
 =?us-ascii?Q?ucRDsp1eIeps/BkrHP1jKjJ5UoiilkR0y3/1WhW/b5ApPQ7cqPO1QqNgcizk?=
 =?us-ascii?Q?/43fmiUDDiyhh7UtL2hezvP35ntjsy4DJKeMRM1a8iAj8M6IVjKeuxX1RMEg?=
 =?us-ascii?Q?02wuuDdxZrQ8Qo52Yzv/ozenUf78jnRk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB7757.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i0pUhpG9vbAdyi0aC1kaSOPUOfrP8YOOMN+5J6WNxtOBcdrRgfFZeW1UGMsU?=
 =?us-ascii?Q?P9AYm9hmAbWMUGOip2hMHrm0ggZXC1liXXxSUo33Z9wrtXO2ubGKZ2c9gK04?=
 =?us-ascii?Q?SM316ENYSS222xVAjiZcX1a+y1kquFi88BjnAcSbxhB8etUzES9c+F/xuDXI?=
 =?us-ascii?Q?Yqkt0Oz/cB8ZHka+j2/4LYkQ61ARB4PbD1dbPKFs4Snmt78JSv9QqxhZSPk8?=
 =?us-ascii?Q?KjGvrcKBLKHlWSXjiC7ysQzyfPY907dxfYNeGCNf6RwoTLhp2P7GRYl4FdBV?=
 =?us-ascii?Q?7XrBcbi90dK0VRnX//DDXXC/nRC6x+9leVK4zDltSWFDwRM/LnM8EOjD2uqL?=
 =?us-ascii?Q?nHyLb6D6/erz+hYlAo7FtoThE9nA6Ew8AA3GR97+cxeLPQEGvfnUK7W0pYLg?=
 =?us-ascii?Q?L/TKKS6HREZvOrVgpeI2EvIZ/TAgMMEJpjhPcYEUWSDB7FaIYaIwiWZRscPN?=
 =?us-ascii?Q?rMTDarYPWny2pX5MxX5tg1PUJJ8W869tM27tU3eu/Mi9f1emPpHgyvtCZIHs?=
 =?us-ascii?Q?cJscMiNZMEVzrkx+B/u0rAUle98dyUc6lSxCaWREtnMhNQaXZhIN2oZRm1WI?=
 =?us-ascii?Q?mNl+0By7t29sCniaHS41qBIzTUfYD8/U7YTHt030Uw7c+/ifaBAQElN5iwQ2?=
 =?us-ascii?Q?6DudIS+G0/TBtcK3TLA7UGuir6X91PZfVoPO+yFl/HkC2TWaV5f8P2CBWWbe?=
 =?us-ascii?Q?izPKhQi36dEwqwA85A+uA0KvyxzKJPBO5cdaY8btjA9UYA6rlAbnPbGxfkW1?=
 =?us-ascii?Q?RDBI5ylzCQjoblyF1dFHc1YHSzHKM0x4c26OoZM0NXJO4l+wKqw3ZyY/No9f?=
 =?us-ascii?Q?ScNExktQFNQ14K6WeDbhAPFcvc/6747fa9fy6B9H53tBd0Z3YWyjigQTp2YN?=
 =?us-ascii?Q?HtboQfEZCrQK+VQbtgjRPT3RJJ7EGi/vtPdQxTLIL1mHY4qWCs7AbMum72yH?=
 =?us-ascii?Q?heHp/jYLideVhQ9ciOpEWRgNsZjhG3lMN5Zchq8OqHZi5rxP5YYQQVkRHlfD?=
 =?us-ascii?Q?IkuZMmQI2TITYrmjYjhBOa0bCSiMaTwk+5YXPQgBP0mw+SwpKEjjvcmmtMbp?=
 =?us-ascii?Q?LYvFI9iR2Fmb6cwQo6eJmWob11FQ0o3r5nd8zSrseJ+AyBX3FYoNDmkeT6Bv?=
 =?us-ascii?Q?lS0FPAoKSvG3OXKJme+YBA6NeexmrYh5aWFZz0LP26lv1+d/Q1jB4E00ZJOA?=
 =?us-ascii?Q?Bp9AmId9tztQEX0tAxJF6t1IXPcehXbwCa57N4AYNFDQ4tsIpDd8zBafXii/?=
 =?us-ascii?Q?UkiFyZb9kStmMQGFHl/T13sc9JpU39/QRXzzRihd/8tV59E2yJxxHMjw+GTR?=
 =?us-ascii?Q?mwY1djT0/NAzKZbsh39zQVuB9MpvkvALYfd++uDNQ9YZzlA/l7S0feCEa9qB?=
 =?us-ascii?Q?VxgQRc6CbKhFeTCWo5wcKOYnpWx/V/M/QqwmnxFyEtwTFFvDYrVA4LzFqrhm?=
 =?us-ascii?Q?igT0hn5/hpbv8QPoDU+FA8g4P+waNGzWtv2sEAIZHCdhHUsELamvPtpN3nXj?=
 =?us-ascii?Q?cyoCiyQewB2yvO1cK6XajG7vzjst6f2LhlpRvr5eKa1e/YiBQUpFAA+f9SQ3?=
 =?us-ascii?Q?giBtQV+XENaZZfAf+l+R1gOBd5itbDGvMeEoXBEm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB7757.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6195a800-5047-494a-474a-08dd5642d9f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 08:52:08.0643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6a2AgfyCYOTEBIB71rOsy+rK8RaxJKDOTKTWUV3hwX9GLiAJFMMiQLVtg72y5Won/jfwfztgiFUDbdlTikCRvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865
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

Hi,

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, February 20, 2025 10:32 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Xu, Rosen
> <rosen.xu@intel.com>
> Subject: [PATCH v2 05/14] net/ipn3ke: remove unnecessary dereference
>=20
> Since it is a function pointer, the expression *hw->f_mac_read and
> hw->f_mac_read are equivalent in C.
>=20
> Remove excession indentation here.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/intel/ipn3ke/ipn3ke_ethdev.c | 27 +++++-------------------
>  1 file changed, 5 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
> b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
> index baae80d661..c8f06a06cb 100644
> --- a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
> +++ b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
> @@ -229,34 +229,17 @@ ipn3ke_mtu_set(struct ipn3ke_hw *hw, uint32_t
> mac_num,
>  	uint32_t rx;
>  	uint32_t tmp;
>=20
> -	if (!(*hw->f_mac_read) || !(*hw->f_mac_write))
> +	if (!hw->f_mac_read || !hw->f_mac_write)
>  		return;
>=20
> -	(*hw->f_mac_read)(hw,
> -			&tx,
> -			txaddr,
> -			mac_num,
> -			eth_group_sel);
> +	hw->f_mac_read(hw, &tx, txaddr, mac_num, eth_group_sel);
>=20
> -	(*hw->f_mac_read)(hw,
> -			&rx,
> -			rxaddr,
> -			mac_num,
> -			eth_group_sel);
> +	hw->f_mac_read(hw, &rx, rxaddr, mac_num, eth_group_sel);
>=20
>  	tmp =3D ipn3ke_mtu_cal(tx, rx);
>=20
> -	(*hw->f_mac_write)(hw,
> -			tmp,
> -			txaddr,
> -			mac_num,
> -			eth_group_sel);
> -
> -	(*hw->f_mac_write)(hw,
> -			tmp,
> -			rxaddr,
> -			mac_num,
> -			eth_group_sel);
> +	hw->f_mac_write(hw, tmp, txaddr, mac_num, eth_group_sel);
> +	hw->f_mac_write(hw, tmp, rxaddr, mac_num, eth_group_sel);
>  }
>=20
>  static void
> --
> 2.47.2

Reviewed-by: Rosen Xu <rosen.xu@intel.com>
