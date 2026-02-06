Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D96EEE2085
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 10:54:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 122104029A;
	Fri,  6 Feb 2026 11:54:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id DA5E840293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 11:54:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770375289; x=1801911289;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=M24yHG6ILZ3UId/xdj8L15LuOTTQnfsj+6T+YgjxJyk=;
 b=WMhQoCLKSMFIiXfbiVQ8VraPUUfi2kLqCZRegR6lDMnA/F+ZgitRE+ej
 DtML2hW7NZAyO4qNYJ4YYSjG6uEXuJ07hwDZW6sJfTKzTX+Y/PMZt/KvR
 uRE8iOB98M9HEhfFNhu4koeZP4HCaPvsnEpiH+XTJDlAb1d8fDNgwf8ot
 SEDQYYCnLyatHVlV8yZxHUmRokPIXswO3q5TOHN6SmjFd/XAQPrl8Eozr
 2iC9IfbvCHqaaNAA6OYQbNcuw0AtVzlIhEhu6ueIQmHGOV2ctAvuUSmtW
 4cFIQF4yWxaewqIZ6vlegXiphqxL7faH4LAUO4axvCy7fXKqoog8ta9rD w==;
X-CSE-ConnectionGUID: /jEvAwZXSPWXfruPkmZZHw==
X-CSE-MsgGUID: +Eqz2J4LSa6VNYuyPqnQHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71481018"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="71481018"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 02:54:48 -0800
X-CSE-ConnectionGUID: cOzy5PxsT2C64eFmHS12Uw==
X-CSE-MsgGUID: cojqqTwYQZSTEAYoyWWehw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="209932627"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 02:54:48 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 02:54:47 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 02:54:47 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 02:54:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGIwSMyrd8b/UM1aeYAy3TioWTx0Bbse+1z5vUHE23svcWFjn0wMJonp+3MKPFMJkeP/AnQX47QqLuY/7jwUG6HHQLGFTSlv+z7JzD3H2o17cB1LRNU2pJW25M0OYIemsGPgbdNh8r8sytdPHVQGKvFxXPdxzfVKLOYkeqyrD7CjSxF0aSIpRz0TqHN+vO0XDJYHLdBGwdsYrwJxJH/mlyhREWlsOVAzmKdG9/b/qnDn/vhmY47mvSexJlzToOTLf3mPXkhUWYCQfGdQVKyKBLcmdt1I30i5AZ8pRc59BYiDwG1gYTsAB1Dj9OptoXj8gJzmu2xurdW9z22tjiM5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppAdNGqIfq5Dp7FMopmIaWHudmkZk6jYGYBn+1rcvJQ=;
 b=KX/ezNhGo0PDApOD2OFRfIsC+kmEpGON5OLdeLUET0j6NSRih8iKTDASqwAZfE1COenmP/sAnpxzC2fCWVlytY5H/U5cg+j07nOK+bX8td6W1CBjXjCUMdm+WdHJ2il87QyOEjFGhpwK9b2nSBVKYmwXb3YkrfZKTgphWcPqcqnS6gEn9lhqZqgbSRvRk4nivCPMixkPWu0w/1Ph4T1BW64Z0DboVVrGFIVZ8qXlA0Zvn5BGX5kTCg0LXE7sBHsEAEnVsdCl4GaGGUeytadx6lLJCAuMNLJkgOxt4aPGRfiGiqapXZxvRUrNuyrhTSehIT+EFatjL4T08aF+WaeNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by DS0PR11MB7481.namprd11.prod.outlook.com
 (2603:10b6:8:14b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 10:54:40 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 10:54:40 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH v3 08/36] net/i40e: refactor context descriptor handling
Thread-Topic: [PATCH v3 08/36] net/i40e: refactor context descriptor handling
Thread-Index: AQHckd2wwt6e+T7Ti0uB2HllTqzd5rV1iSqg
Date: Fri, 6 Feb 2026 10:54:40 +0000
Message-ID: <DM3PPF7D18F34A13B8EB4542E64F6A380178E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-9-bruce.richardson@intel.com>
In-Reply-To: <20260130114207.1126032-9-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|DS0PR11MB7481:EE_
x-ms-office365-filtering-correlation-id: 965d1151-76c0-4158-f693-08de656e209d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?ykxDNZ0b5zSFi/JfeqpxPD/6WaerrCtkZQhEQob/2HD5J3rZS2uVbqjtKYSS?=
 =?us-ascii?Q?misnoWptPN7dkukSzbCj+Jh/FBtQzE2NKIgZD8GQVQfCpB6BZMa7yGLbJfQq?=
 =?us-ascii?Q?rpB3mTOpbsjKQLzrBV4sgKIlFDLh2Wh6GN0GV54nON32oryuAhlDF1ZIjaJv?=
 =?us-ascii?Q?6RoWDHGr/2FP+Q7iskFAyfLgDopsK0tvcqTzsoZUB0UfLh3199HooAlsHrWj?=
 =?us-ascii?Q?BRE9rOJ4MeL277UIhWJukjB9RMccgdFbzNZsr4OIEI7Z8O0Z+01UHLRtjc34?=
 =?us-ascii?Q?iXyGR4zfXgmW2DCB3oMbkbx5dN/uYd9sPKx0MGc8f9FFDvqV4GM0qo9fymEG?=
 =?us-ascii?Q?Uif8YAOiII0m1zsGWJ8GFK5B6HxNiRT6pTBwmtP90BQM7jFHcDrkHISP2JK2?=
 =?us-ascii?Q?uFgnxylXb1NQcPJn4Y9c2D+qg1WhT7jssvR17MS4dP1+PqLIQZ6MUHGGwZAO?=
 =?us-ascii?Q?e6F0WvCw0/xXcfv9Q7mtOmJw3fAdDqLwAyh46rnV6TicCznVtjLAI6xb+2tQ?=
 =?us-ascii?Q?MXaCpKzImOyzfLKvzba9lZulVdMNFvJs5FsOoZjWBBbPlMVL6dqT+wrJmcuD?=
 =?us-ascii?Q?m9X+7tIwSSv+1+i4lZeE2y95Uy9IsGoZ6wyZR6a5EaaGdY7yh5KeuCmoVUb6?=
 =?us-ascii?Q?EOdzCgZ0wyvM4QpIuBBwd9EPvG1c3/m7kw0zbNDmDZ1Gunk9NdM5ERRX0+iS?=
 =?us-ascii?Q?fAW1v++tOARc+4j3b5uR8PUmJM5qEjGPbHVjjol/FITO12T1LMVLYyLtM4ty?=
 =?us-ascii?Q?4bzlmDZ+EgzZJHf/jYlyv8TE5AelhHvbrjZFSdaBtudvDkUOv7rN9o+hJOTC?=
 =?us-ascii?Q?Bz5tgsQTl9SH10HFgnxdWv4xylvXYLlF0cljxM+/aXlk/uWsk9vQRk7QAy8A?=
 =?us-ascii?Q?hoWKRoSKI8V+GU9Pw7ZYwSiEklne3uLOWbCVswBZmMTK+OgoTblXOf3TOITi?=
 =?us-ascii?Q?TjXcfbcIdsmc17VXqY3PFaR9eDa0zUkhKRS8LoxTJg8LbQ83RKH+I4Bstlms?=
 =?us-ascii?Q?zLgs9z4WKfY0xZK/lfSsG0McPpGPmWEl/DyOWLdQjad9Inbj5nReXFjxKlO1?=
 =?us-ascii?Q?+/imSKyVM3kQjyCL3OFQMFCsnJImO2yt+mPmE2OqDY5Fcw8F/+4017rk7XNT?=
 =?us-ascii?Q?Ay/n+NmQAKjTf28f96UoJ3v4Y+01z6OmVMeLH5A6YQRNp1gwAaM252IcEopA?=
 =?us-ascii?Q?1lW+2aEnZY2gYsxrQeGivFozJfAORJlXdb3yaq2Hvtb0yzXxoiRHF41biJhg?=
 =?us-ascii?Q?i8cFyisq3nlTAQtpM6nUqJ5BML884T8q2Q6nJalgVqmkheblSVUvNZwUktoO?=
 =?us-ascii?Q?Y4nlr7lEudaOx7YJ8OfTznOhIHt/9jroW1MQDgWI9WA/YFsTIGJJGQuRcZ3B?=
 =?us-ascii?Q?P4EJPlDYAIXVyWegmyUm5G/ubkn21rehs9CT1cGqcBQy0vMyIqopnaISxV3m?=
 =?us-ascii?Q?WxGfsvr27wKjVEo6wbKYdTRjtvW5UChO7CJZWD3noWE1jZOfX1YXDvSTNM95?=
 =?us-ascii?Q?slCEi1fVG9XxaI9K7zrRTXtCqNXaO5xn9bGi9avd2XDoJ32HxHUOCNAhvXTy?=
 =?us-ascii?Q?F44FG0vVGfN/m6mcptj2b05SaZAADn3sX5sL3bNqFGh2bMsLVgphZZRPbpfp?=
 =?us-ascii?Q?BByN99nuMhaIqOHM/4C4WDQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a/7HrgF3sFqqn7uLBBI7VRgijipv51dhy2jTiTIgS0KyiUpYzNc9f60jge7V?=
 =?us-ascii?Q?PuYWCne0GsYhnC7rIgD60iHH23HFpDtjpU3pLHHxb2UFDda+vStFGjqVibw5?=
 =?us-ascii?Q?rg+BWrD0zBqeosophebq2tR+5NZaKnUf//w0f51w8A/OyRzwprZ+yT1+XUqu?=
 =?us-ascii?Q?KeBRksxEiQw+fFKomWRpc1crCJhKN7vHNJBcaXq2OfsoGU1+TgVo8WQAFLXP?=
 =?us-ascii?Q?QMSzHHCT7vorthftNJ2BnY/Jg0HQ1ylW6XsuH3/Gi81M3CiLEugM6S3RPMVE?=
 =?us-ascii?Q?Z2Bkw3eRXOfzwXPhchgVcy4Z8/USkpAoKAv+OMACuh20ZTTlI53mdsupnfD2?=
 =?us-ascii?Q?miRU+ingN0JJuf6VCvaDikSXaphJRyqphzILAskjq2L2zYQQfEffk69zW7gg?=
 =?us-ascii?Q?yUtK1/bqlHIC71ZqazZzRpbu6/iYmmUcDvE444k70qnOLG9V4OnNJBk1q7Ur?=
 =?us-ascii?Q?8XTk6d/Jk1RmPP4IHl0zHRAXZN12F46Ae+OtiGUapT6j99l51e6g3HMnBptz?=
 =?us-ascii?Q?Ki4JQWEj3uvfmPA2Jxfu0K6/BtJZCXrGBTKQ7BJZjfxWqzhT0x3y5d1EjyI2?=
 =?us-ascii?Q?UdXn6pFkqW9r0JuT74PXTksfVa47MeHz+epBmXld5O0AFLCHBuNCmwQBUEau?=
 =?us-ascii?Q?rwbqkebrJ/0H85+Ledxf7HqeSmUqhwaOGRdG8OQNiz6iDAi1wHKVnXMRKjiW?=
 =?us-ascii?Q?6m5Xv08nNdYcTC3bNqwcJHo1nNzsT0Gp+aapHy/PI1Fqbd22DFomR08sQWS4?=
 =?us-ascii?Q?ngOxu0sayUb54a876iC+KRyH5tQx63smDzZDElwHO/rhUwI/dK/4iqrRCgMV?=
 =?us-ascii?Q?dn+cJw9IEdhsmdorFwpGFRK0uRqYQxE0ZWlp0DPC6vgR4pfmhEHbIEgW7trt?=
 =?us-ascii?Q?eRFL+N4GQsIeBtJkPIyCOejH9ZH5+cB27yqi/8OOkDNCSwUNnaBbdySorWa6?=
 =?us-ascii?Q?X3EXGjfrfwVtrwQjZe2ueEvf+hC3GyY4f5brlMiOg4gLrINFZ0duoTWJ0l1L?=
 =?us-ascii?Q?eLTQrVXEZct+LAukdvD1vmYRs7GTTxNQhkVNZptKsqmyTSHPV7w51toqHBGn?=
 =?us-ascii?Q?fxdFgZx0RwWWs2yhpF09qZ9DegkFo4ZRF3aqqVDO3qbmh1iF4MWBSiANxRhV?=
 =?us-ascii?Q?jmSzxFDmnFWTa1OMa5QyxoLIiaUB3Imz9FLYBmEPDTspB0WRGhgTXYadvpUj?=
 =?us-ascii?Q?E2Nsf09cUonfzmIhPgM3xw0atXu+SxUxc51Oo2fNYe6Q+MOTCfvauMB8cL3j?=
 =?us-ascii?Q?EdN2OiLjmk4TcrJW9RSKweHNaVaiUqQ2AYzfLS/hx1n5mXG3k1PQnASFIpK6?=
 =?us-ascii?Q?mpIHi4AkYa2CTm9OGe33puBqENt/QSChXfznv2LdKS4Ob0PKAbrq87ZAgSJJ?=
 =?us-ascii?Q?lJDMcrOS2Cun61kKtLBj1D9xPeHdIwO7Q36dsbo1IJU2WBRLwGMbvdTShrDq?=
 =?us-ascii?Q?4zOmVI+jBbS48vFS7edZ09o5PPS+BxNctIQx9XUy8KDYPPkJSgOXosf5ELUR?=
 =?us-ascii?Q?JcCcsogQIqzDiNtp61WnYmVGyFhj5qJ1CQUy2Vdv3JMt8cIMMDITgIdLRuMX?=
 =?us-ascii?Q?6uYV9cGACDIgewPMVa8+tAU7CIO794omK/I4bWdKgOw5SF6ZxAHh2aZIrvGB?=
 =?us-ascii?Q?xkpnVBZwOi+oEMM0Jzw0taKHuhz2m259a1dOGS4HmDqXqy5iCQU3JXlRJnhO?=
 =?us-ascii?Q?jaQ1YipgcZeRfpu0T4zkkJM7vDM6LY1Rpr1pwsQVcN4V/wK6mgaOhE2UZPA1?=
 =?us-ascii?Q?2jPYlt0UGg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965d1151-76c0-4158-f693-08de656e209d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 10:54:40.0833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N++vNmwDFWcKQdZMSXMW/Ks6Tfm5zraW8yvB6XzWf69logdeHCyyIZGkS+iai7Odz0U/1FhMBYXPZbd/o8NHqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7481
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

> Subject: [PATCH v3 08/36] net/i40e: refactor context descriptor handling
>=20
> move all context descriptor handling to a single function, as with the

Nit: capitalise

> ice driver, and use the same function signature as that driver.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_rxtx.c | 123 +++++++++++++++--------------
>  1 file changed, 63 insertions(+), 60 deletions(-)
>=20
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> b/drivers/net/intel/i40e/i40e_rxtx.c
> index b75306931a..183b70c63f 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -321,11 +321,6 @@ i40e_txd_enable_checksum(uint64_t ol_flags,
>  			uint32_t *td_offset,
>  			union ci_tx_offload tx_offload)
>  {
> -	/* Set MACLEN */
> -	if (!(ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK))
> -		*td_offset |=3D (tx_offload.l2_len >> 1)
> -			<< CI_TX_DESC_LEN_MACLEN_S;
> -
>  	/* Enable L3 checksum offloads */
>  	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
>  		*td_cmd |=3D CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
> @@ -1004,7 +999,7 @@ i40e_calc_context_desc(uint64_t flags)
>=20
>  /* set i40e TSO context descriptor */
>  static inline uint64_t
> -i40e_set_tso_ctx(struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
> +i40e_set_tso_ctx(uint64_t ol_flags, const struct rte_mbuf *mbuf, union
> ci_tx_offload tx_offload)
>  {
>  	uint64_t ctx_desc =3D 0;
>  	uint32_t cd_cmd, hdr_len, cd_tso_len;
> @@ -1015,7 +1010,7 @@ i40e_set_tso_ctx(struct rte_mbuf *mbuf, union
> ci_tx_offload tx_offload)
>  	}
>=20
>  	hdr_len =3D tx_offload.l2_len + tx_offload.l3_len + tx_offload.l4_len;
> -	hdr_len +=3D (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) ?
> +	hdr_len +=3D (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) ?
>  		   tx_offload.outer_l2_len + tx_offload.outer_l3_len : 0;
>=20
>  	cd_cmd =3D I40E_TX_CTX_DESC_TSO;
> @@ -1029,6 +1024,52 @@ i40e_set_tso_ctx(struct rte_mbuf *mbuf, union
> ci_tx_offload tx_offload)
>  	return ctx_desc;
>  }
>=20
> +/* compute a context descriptor if one is necessary based on the ol_flag=
s
> + *
> + * Returns 0 if no descriptor is necessary.
> + * Returns 1 if one is necessary and the contents of the descriptor are
> returned
> + *   in the values pointed to by qw0 and qw1. td_offset may also be modi=
fied.

Same comment as previous patch re td_offset comment

> + */
> +static __rte_always_inline uint16_t
> +get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
> +		 const union ci_tx_offload *tx_offload,
> +		 const struct ci_tx_queue *txq __rte_unused,
> +		 uint64_t *qw0, uint64_t *qw1)
> +{
> +	uint16_t cd_l2tag2 =3D 0;
> +	uint64_t cd_type_cmd_tso_mss =3D I40E_TX_DESC_DTYPE_CONTEXT;

CI_TX_DESC_DTYPE_CTX could now be used

> +	uint32_t cd_tunneling_params =3D 0;
> +


