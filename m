Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED06F8A142
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 08:13:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36452402A3;
	Thu, 16 Apr 2026 10:13:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id D303F40144;
 Thu, 16 Apr 2026 10:13:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776327227; x=1807863227;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=36/Z+Oa4ccUrY4w3jTTWvXknmpWMEqm3zYGP0icPf3Y=;
 b=Wr/4cglCSUyYeK1Y0WuJw/vxC1yvUyXkbTA6UWvA0curJ9l3fTwL7uIM
 7W4JwRmetGXCl5Bz/EwFuZ+1B+NGPtk0U86oEFw0l13I0bkCB9ptBE4P3
 Mj8VV3k4SEoCfBUWAvi3VSIYPFLW622FU/lmijtXY915yUuko94MPUKd/
 jVxcPnycoMT6pILKEyPy4fFqSyh3Nzbw9XAsDTkz9+5qcDBBlkXo/Wq/i
 Ngdyuny3Ix8w3p7iCHyGwgXDTrGTou0+UBo+yZdKI95a0XPUnYA7cmeeh
 ulG6xJ5JKYmE1GOg9cGIJ8wYnDw+gMlpSzpSU6nznE4Ux5I8Fy2HJ0FgC g==;
X-CSE-ConnectionGUID: KrEAbpg9TXuG4cBa5jGfyQ==
X-CSE-MsgGUID: 6DYyjGRgQhOyHa+3SfusFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="79903995"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="79903995"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 01:13:45 -0700
X-CSE-ConnectionGUID: m6X67RQFSBet/cOBTvOBkQ==
X-CSE-MsgGUID: FoPdV+rjTSmX61X5ljAOEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="230914148"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 01:13:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 01:13:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 01:13:43 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.35)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 01:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdGCwx16Twfej9jtdDfXXfqW6EchkWCZbIlAkxP9U8R1DotdmPQO5YzlEcNHz90NO14OCdNnVBjLtJSyG7ZuPCLEnfYE8i9mr/uiKv7NQ6ztfvxET5DET7x8Rbi9xzxjwpIValDL3hMw4/iQcVzT46gqJdWyWX/tf5zaMNPeGXn+TGYO01YBC8/wyq7Mf2JtvVzPGtfas3nNG5Ub9XyvhbQfCz3Gc3l4KCvenJ1SisM8f76zVgl0w7X8rNFWsigMuXq1Nnsti1dxZk4v4z29Z32qmXm2BoUnPSxgHOv4QxLSJ7GXtvto/wgdCvv4vKADpYdeHvxvIjoC29YYVn3GzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcnznKAmC1adgBj6zbN0pQRToasg9oNvOG2SBh2aMXs=;
 b=SJ4n0nkSZOvOBEgqZiSPuEwhRHKpJ4Vpqn3oH314jH9No5oYKrr0IeMciUO9T9KLn09EtWgctHwzK3lTwR7o1NYfjol6HJlRDdvBYShBKC5UKKasrdCj5l+9h2dX1oWcql4WMSzeB7iHXxni6uq9GJEW57ApdEGyPRmWn5seATCM+60ePc/eEX/p+v1AJxFlN/uMrT7mgCLtelE+0uwHE6JYu+2hV/1rKAY6c15YwNfdDqltuCf+HvGlVN4knpVvNt4luSnLipMOMsa5yFRYR7xA2WIOcIE/IbJdeWup07tYTzh3WlR9bsSq5t9UvXKD3D1MyvVoZ5eZskkqlC9RHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by DM6PR11MB4641.namprd11.prod.outlook.com
 (2603:10b6:5:2a9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 08:13:35 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::6d5e:e9cc:2957:6451]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::6d5e:e9cc:2957:6451%7]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 08:13:35 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
Subject: RE: [PATCH] net/i40e: reduce debug messages
Thread-Topic: [PATCH] net/i40e: reduce debug messages
Thread-Index: AQHcy887RJl2xVQDB0q1C3hA15BCoLXhWcBg
Date: Thu, 16 Apr 2026 08:13:35 +0000
Message-ID: <DM3PPF7D18F34A1AA387BF494651F0DA4918E232@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20260414052603.201114-1-stephen@networkplumber.org>
In-Reply-To: <20260414052603.201114-1-stephen@networkplumber.org>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|DM6PR11MB4641:EE_
x-ms-office365-filtering-correlation-id: 17599c6c-57fc-4860-b125-08de9b900e6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 93li5TNaCAOk0QPNs/aLM01HzMPsKb7MZ8yR8faf7LMP36v84LbEIolR0dr35AhhIoAWB8DUvDj2+KIJ10VjNHJ1KkZjr0jkkR5H2wBf6+E+UHpZx7dzDoAxBXMPAMyaALHz5h7oJKkGwZ1fuXqm4hmeX5usnArAVwfeU6PfpXnQOaMM4UfM4Dtzx8YaG/Qp8KkNfaFYagPBUhQMNuJqByFv98yyCwnpZdbI0awPP/KqP7cVrMBswYcyNRHzyUwbhE2mefxNsldnzZsV0Fzsmj4ldTuQxpe96KIzFMw7rvAEd8voX94ieKLE4OcXUgmixi929aMaVOjIkFY+50hOjxncAnvK7tp2zOzOtqTYDzxgK1ibtXO+WQNJGl0ngU0H2Sw6yvXcK3sb6TAzbM0ikBr1cEcPrQPMhTC9vXyTSJJ2CusTLMg5UCq0Y0tV7q89tmPl/1o05xTeFadueK00wYtjeJ92xu4irNqM+1li4lnHPGbv1TKjgR7w0hmdcqwd+MUEEan7dwqgCAwXuIbn82tlJ04dh7zcqXdu2fGSWtacMckzRm5W/B5vS5lD4kVU5ETR1/IDFwuwWm+14+BnvI8lpmyQEq7UNvDINSvO/Ll3YWDSM3hBTPObJb7CPO1k25KetKmzaoN2+3/Xmbm7RCS3DOIHAdhsPznuZ6FD3tXgxrMVXCFt3T6wS3im+H9Yma6PjBTj+xjPWJJzL1yg6CAVeiXqHI1nsfvYIeasGjfWNpPgzuuph+5joS5rTvG4yZwbhGiAawmUp/COgcre8YUTwvoHwetQ67664OMFcHU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zdze0xai2Z7IPT0Z4qtADooU4IFOEfC0x2ST9WcwHtABb4F5ghj064Pgs8QX?=
 =?us-ascii?Q?7FqyG2qEBVLqfCDG3u5pnDq1fN/KIRtgVQhLKfQHwp7s4M5Tffweq9bdUMOw?=
 =?us-ascii?Q?hsk2odq/oidr5yo6MOzH9vdz42B5zeIi0xUmQji/MOW+IePDxO4kf2QrTSm2?=
 =?us-ascii?Q?XMK5wT9uhSLsWuVyvl8BhkTZrREirwIS1zlxAP+l7FqWt6cAYphtfmsdutcw?=
 =?us-ascii?Q?/dq5g4sGN6Qqt8hE491Zsi2+CCZK7bElyDT9WC1i/nmlmSFid21Z0AEWNUry?=
 =?us-ascii?Q?hu8lFe+cJ6AfY1FyXwo1QiVu7PRD7qYw5zAIBzQZKGUy0Vfy+KN/hWgWikSO?=
 =?us-ascii?Q?vYt8p7xruZ3dIhxWpa40Sghd2141U3oroibdfcONEZOsRzUI/bMwVmRonm6R?=
 =?us-ascii?Q?EyWX3RjP96ZbUx/eQ7QAM5xDHqSFLjhfG9fhRxxQY8aVwENs8RoHWxU4vBja?=
 =?us-ascii?Q?QgmG2sH7CXsDWja1C1lbDqbOhygdvuEnIBKdmtahqgTMacE6YXp6zWVCG+nq?=
 =?us-ascii?Q?aDljriolwdEyhm2EQmH2EmUiidUiE8pqxg7QUWnuER2oO0nMW5dTqWw2cCn5?=
 =?us-ascii?Q?VnGkkE4OZDMn+ml2cJpLx7QmvvUg7PSysEIZ5xS380YPcFpX/EJSIsc2SLHP?=
 =?us-ascii?Q?B9WrXl16hX+PcX2KKj0kCkFRPltyAsDSXuh8MpmD+jVAKwQdrQwTInXMt9pk?=
 =?us-ascii?Q?J8ZHiIYmG+5AVB4M4gvxQVqObredGe7S5CSGqYJI7Rl3fdH4xbjWZQhWpgW5?=
 =?us-ascii?Q?1mpAKMo+tWXnxZCGH175ZTQxi9YE5LD1UVqMinlZAXdnxpJMe/ET5koFHchF?=
 =?us-ascii?Q?0t8WqAvR8AxEnQqww08IngjEsqsEUxJu5Hl/Ieh04cPd9AI87FcrR60zHlgv?=
 =?us-ascii?Q?rokTY37h3Tf6otoAocU1B0pAgrAVU6266Plzp/9X/xlwQQ5rqE9i0a+X/czO?=
 =?us-ascii?Q?/634Mhj3yofO/yksovlwqOJlnUeOOjhZyPPAbeh+jV0EmJK0wfyykpil142x?=
 =?us-ascii?Q?uab3I/dpBTUTBqtgJRI+9ZMdK9p+zHP9aURZCsM1iE/5JnzU6vsTCTQmj3sJ?=
 =?us-ascii?Q?zOS7TCMYWq/90/lgRRsV4mra+9ktjaWWGHYVbJfOLu2MbKZbCCC9cSMQ6A/4?=
 =?us-ascii?Q?kT7kHo/HsA3YinhEsq0nc5kjvBm2WBUBUqPc80mDpLzy4uhX8mmRKQU4AP8z?=
 =?us-ascii?Q?Ay7NKVOEK3RWacBuaBQ1BuOCrHOrxcSsDCDONSBcqNVLkU9MiyS0p1XkiX6Q?=
 =?us-ascii?Q?0wevfmDXKfaobEwI2S33DTO7NcnTeXePNfp07ccE8JBlT3LHy8HBUTPxpe7x?=
 =?us-ascii?Q?QhkGAcfavqzF9IVYJkeVkjGhftrkqpVa2dfo/G5iBibOlpYQVt2s5nw01orv?=
 =?us-ascii?Q?X3W/7VmRQbk+VwcHV3Z+FtY6sNOso5bN4XWQBX3Ewi6Nd4/qjDYOUOmOpvvz?=
 =?us-ascii?Q?SWq4ciDVlfTUobBZSeeewBu85NFcCOd5SK/cvdYTW0Fi1MSrS1IAbYCYwnWg?=
 =?us-ascii?Q?3Xw1E1/7N2TY5vfIHn9CdaL4uZHAUlByyEu5gntnjdOZdOBQp0FQ/PA1yAKG?=
 =?us-ascii?Q?qqDf6i1tFxYrsGd6S9+Iu4EOvMKK3ohxW6HP0ethbds5D228vjZhwk30obCw?=
 =?us-ascii?Q?t/QCWXm8/uY+AVsBjn8OBFePYr88M3M4ZbAlDo2jxIpPnDA6vzokUOWN6v29?=
 =?us-ascii?Q?jDB3INO3HEiPa12S9U3B83pBQm+JDBE5SooYOfRikWsOhN2svxFHE5AEGL01?=
 =?us-ascii?Q?kB0NZQUKNQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WpiKsh0eiohk8BvbFL3VbCBtcthHxx0XLZqTOf15jKwY6/MYEu57mrQ5A4eb26zS1hIT2jPh418z74sWPPC3k/IJdthWTZP399OmAQH0+2Hj/cIeAl0s2Ficm3PrY7G3MfxWRjjbq2rhfRdpmbymOhEEZsXO1i3sM2cNDNMPJnzGnTrNBPYonY6Kg8BxBG84Wi6EMGz8yMzwXK6CCRnD3l9a7iiyHUNMCunLYkUTRR3Mig9ogtS1D/x9C0XOBTdW0kQvA9HYldjxvZ8DkH5TFR/4ydoUY/h+JgLl7HvNS/5ls+a10uIfNPumhAsXNu5vbSeb4qFhiIg78R+KAtHWgg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17599c6c-57fc-4860-b125-08de9b900e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 08:13:35.2813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sy79+7o+uyN3A8gP20ypLpB4P0+ae+c/HWgrrMwMAeo9TJ6PZhrmSFrfui/K75bg1HD0sILKiMfUo4eEW20xGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4641
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

> Subject: [PATCH] net/i40e: reduce debug messages
>=20
> The driver logs normal things like choice of AVX at NOTICE level.
> This shows up as unnecessary noise to regular users.
>=20
> Bugzilla ID: 1936
> Fixes: 3f24891594c1 ("net/i40e: use common Rx path selection
> infrastructure")
> Fixes: 8d57c1788806 ("net/i40e: use common Tx path selection
> infrastructure")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/i40e/i40e_rxtx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> b/drivers/net/intel/i40e/i40e_rxtx.c
> index c5ac75e0f0..d00548ac89 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -3042,7 +3042,7 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
>=20
>  out:
>  	dev->rx_pkt_burst =3D i40e_rx_path_infos[ad->rx_func_type].pkt_burst;
> -	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
> +	PMD_DRV_LOG(DEBUG, "Using %s (port %d).",
>  			i40e_rx_path_infos[ad->rx_func_type].info, dev-
> >data->port_id);
>  }
>=20
> @@ -3124,7 +3124,7 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
>  					 i40e_tx_path_infos[ad-
> >tx_func_type].pkt_burst;
>  	dev->tx_pkt_prepare =3D i40e_tx_path_infos[ad-
> >tx_func_type].pkt_prep;
>=20
> -	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
> +	PMD_DRV_LOG(DEBUG, "Using %s (port %d).",
>  		i40e_tx_path_infos[ad->tx_func_type].info, dev->data-
> >port_id);
>=20
>  	if (ad->tx_func_type =3D=3D I40E_TX_SCALAR_SIMPLE ||
> --
> 2.53.0

