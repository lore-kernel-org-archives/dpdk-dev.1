Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13895CCD185
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 13:28:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B7BF402A0;
	Thu,  9 Oct 2025 15:28:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id D490240267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 15:28:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760016490; x=1791552490;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oWK8JMrszMWKvg9B65bhutPa391qSP2xBafszlRYirI=;
 b=JinFbPktOXI1fCh5pUgFRwm51SmVqET6JQaE+NQaYLEQQjLWUmpFt+n3
 TjDTT4EpPcIJLJMVm+k9znzVPSt0faMQ6puXX4TaPi7+7gshW9Q7CYpTl
 1d6/aRoMp8g3Nf/l/bmU19qdefIZ2NYLvdSMsYoqEa8Z/dSPCVxNKXytz
 jnBoQwFmS1RmQmPxVwg4bCYKk5UZH6c6o9RkOv7qAoRC20uPPQhBE7ESp
 2krrjNk2L2TpxvmGMfvAP/E8M857Cl+LxWU4zSCdk/gh3PGZ4AnuBKisK
 ruAQMSCJ0FhAjw3CS7MCbT1Scz6fHVLBgWNt4CmOKY/vJHGb9y3AF+PZx A==;
X-CSE-ConnectionGUID: GzGklWIITVG29j/3NjBmpA==
X-CSE-MsgGUID: R/k3nelsRnqWvHsWvdLJow==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="73652764"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="73652764"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 06:28:08 -0700
X-CSE-ConnectionGUID: St/PX3XrRBu+4Ri8B+hNFQ==
X-CSE-MsgGUID: Nguc6r+iTuG/lyXjsOsXyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="180529124"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 06:28:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 06:28:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 06:28:07 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 06:28:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmXJyrYP+4wetsu25KlCTdzSHaBq9pOXgH2JDo1KTosjKmlkS0hWQ3oz2/1x24Q0YzK17fTcJL0wjFxjeXCNsaPSiK0JcckwGHagZXfCLgmpp3kWUqipIj/S/ue6gcOyApOlNPcgxi9QhraTo93GAOfgmwV8hRc6Cuf0znLOHKBbtcua5BNS0uGN+bTsWh7Zi4yBDHGbcGZxaphjXODwBvNJ9RvsaxmaGsSe1BqyYINMgUR5FznUT83b2TD79F719x6b64i15wJfG7tAlRBAonyKvrmv5a1QMy31vL1Q6jwCI+t/3J2ruGWX0fOUqCo5chHenmVAxpANW+vPBR7+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEUTFeSFCiPbXiDLyT5CkUG/FLkqhXxaW/HfCrTmbyA=;
 b=VuZjTYWRz3RE9PHn4LeWM/qEhd20TlUcvZdJb8p1qW7TY3x0hQuVNZgJ2mI6eWtcivL2x3PrTtrNa+wxh38H4D0ZB9U6kwi3pLOMIhYXRIRfIz4DmKj9QypN+fMHfChOJ9nWMUMgWvpckN2D8qjWRqjFw+lPKgV4xiCfWqU4+b/uj0UFW/iR6bCczY1iOSLhfNKsWB3B7A5Qe+4P4jBhJCGHWv01jPLR+ZDqKC4TMam3MzpGn5x7H+Gn5WgEPOl7D44xbQTngeKWa6vwghpSxFfMUj2RlGSxKm+1lZJKl/ydfxH0/sJdnFqfrOUMmgNkHXzCQ4rKeOju7VOf+wmp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH2PR11MB8777.namprd11.prod.outlook.com (2603:10b6:610:283::6)
 by LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 13:28:00 +0000
Received: from CH2PR11MB8777.namprd11.prod.outlook.com
 ([fe80::70b0:4dcf:b71:9a25]) by CH2PR11MB8777.namprd11.prod.outlook.com
 ([fe80::70b0:4dcf:b71:9a25%6]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 13:28:00 +0000
From: "Rybalchenko, Kirill" <kirill.rybalchenko@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH] net/ice: fix initialization with 8 ports
Thread-Topic: [PATCH] net/ice: fix initialization with 8 ports
Thread-Index: AQHcMhaqw2o60ntCsk6Q/+VWv+n8DLS53HwQ
Date: Thu, 9 Oct 2025 13:28:00 +0000
Message-ID: <CH2PR11MB8777CB1697FBBCE40BD0538B98EEA@CH2PR11MB8777.namprd11.prod.outlook.com>
References: <20250930142850.1782615-1-bruce.richardson@intel.com>
In-Reply-To: <20250930142850.1782615-1-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR11MB8777:EE_|LV2PR11MB6023:EE_
x-ms-office365-filtering-correlation-id: 73a93193-8a14-4d2d-fe3f-08de0737aab1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?300deZSYN+f8utHryfGZD3LApBSJHOUYHZE71WbKWtNhhmPdbTHSixj8u0hr?=
 =?us-ascii?Q?o1rt9gt/wH6hyJVgPdp9qnZzcvQ5vnuTz3XvSIU8Vu3Lnn/JLpeJqOWRxZH1?=
 =?us-ascii?Q?WdXT+XPf8l0kTwrni+wF5VpZLLuTzQcbNIwHa+anfaOej2yhUTp5Dn83CLm6?=
 =?us-ascii?Q?H+nL+cFFlVOPcovGsgGwDH5AAYd1oRz/BzDXPomha2QoWlZiPYQzwYB7bTBJ?=
 =?us-ascii?Q?Q8ltC6JU/68MrAVCbybjXGvGYl94YpaFnInrd8m4kJPFGsn2N022b+k21rj+?=
 =?us-ascii?Q?9zBkCqTvDKK9Gq4DQygvYn02IlY+JoMai6MOyGG1YGYLNir5+DOJucihYRgk?=
 =?us-ascii?Q?KpSl9SBnwlreR7ve9yEKb/L7xd05XCYTAnVhHm2hCax7pNgnrvREMweOy5Uu?=
 =?us-ascii?Q?o7p9mNfD55DO421rShaDUEXRIUxkrys/vWH8bn1uDuCPLjSIlnjSb18FAjjz?=
 =?us-ascii?Q?qucny62SGHTJ6MafQXn3SKRyfQu5yQYC4AtdZwu9wiZfqVOBhjXOtFw3As9h?=
 =?us-ascii?Q?oHTNp6dSvr9oTlFlmpVRZpHyv4r1cjjdhzyWvYMNpsttqlfONQcP4Hi0VJmP?=
 =?us-ascii?Q?XsQq7BZzs/o8BMWjYIcN2FFDZjXq1Qb6NyjpiXm0+BdutBpsD/SjNHpHSF1w?=
 =?us-ascii?Q?we6qbZRrhHdx8vVOTIxQINd33GS4RNyIIZwD93RhEEi7CKgZcfD3T2hKRNYr?=
 =?us-ascii?Q?UpUM3VL4j8pvvJf/bJsh6W+8qCDX41ufNbdHuVmht6zaQ3lhPFOPXoPnk1rj?=
 =?us-ascii?Q?HXfGe1qeIlNPYOQrq8g2kha07cjkZo+owiXR1jGbF1Du+5ROnFc75QDIjZkG?=
 =?us-ascii?Q?APq35/1EJx2aeIli7x3ya0U3pX4UV0QrogJsZ2sfg/uibeDn6oGb+w82X2gB?=
 =?us-ascii?Q?MMJTGKUNLv38Cho51QdjEW/MmYbQO7GyyDA8Amvl4XTEJcNfrP57qhr/iN8r?=
 =?us-ascii?Q?f2CG5L4SMq4jm11F9+BVgF3EhuDObpH8cNcJxF0ookVNbgIYeerELfKVMItD?=
 =?us-ascii?Q?Gn8bupA6/25GzwiqHP0LhvPIF5a06miTel7WWsksFL8I9Hgy7c/Ai0f9b4kC?=
 =?us-ascii?Q?2Zxr1DS11oDtLLbd1BcZ1NbEf9+wXf8NxBLC/6Lkf/+NlTKPwsbEn3mg5E4G?=
 =?us-ascii?Q?KJqyuhGXYJCJYcF9TatD++tzU2Ux+jn2D63QpNoRmjXB1K/VxFQpCkaTT7mA?=
 =?us-ascii?Q?pRuHXKjmYpJPwyM9h2tcBMesRDfCKhSQa2nWTYxxsGpWTG6YZY0r5E1c+xFY?=
 =?us-ascii?Q?LAWp1BmOmODyCY/x+zNVRv+02Jjqh0UjksD9y40ztEefbBT0Ed7pIRYPfJ/N?=
 =?us-ascii?Q?Zu93JhOe24B1vMTZiOAvVmUdGEbSxmGkSa9TiDzzmo4j/8vbO3+IrbtU6FaH?=
 =?us-ascii?Q?4WWoHvKeDQxuQiw5vMD4ycIBCrZQ3W9bRO2kighvgmkM7rO0jQed/6SRv8uw?=
 =?us-ascii?Q?z7Wdl6JAjDxt1ySQ37L50cYuDWtY2NREgPmHWQROTRR5h3HZdPSLKukxqfYi?=
 =?us-ascii?Q?oimV4jDjiIXLaAef0XF7ifWkTm7SpjOkMGoW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR11MB8777.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aoPrDPOonJmTv8hSwgMk31CVIbpoymKegX5YD1X9irNl738fKIFTYdAzEL//?=
 =?us-ascii?Q?osvojR7v/aJhec4B8GIoQF6blNpvgF2uQrMr6JTcSPIYuaMlzwhGyVLX2gue?=
 =?us-ascii?Q?GT1l+/lSFqTj/G8JdM5zwwWbdHruKAwo+7LEzhCxbFMargwFJgnZ1dOHYPaO?=
 =?us-ascii?Q?79SoB9PYh09xINQpIXksOZY2k/HNBf8o2cEo8Ms7bmfaJsjbNMUr2UbEDjLp?=
 =?us-ascii?Q?0B1PeLcw7JUz6mM7FoPeKQaN+ICV+SGeiQu53oGuyUexr4WHYFfMAQiqpLsr?=
 =?us-ascii?Q?gH9Ka74U0aIGHhs9gp3C98fZLEgoXlm8QedpDJQg/+CulNQu6L78GhnFDJCZ?=
 =?us-ascii?Q?e4+NKPdBtTBHXXpxDjgCRgDqUlnVNoU4bR/fQPFAqtG5BIU0vIJg5M0tGPK4?=
 =?us-ascii?Q?VLNcYvoy4QtWyjtcwFwqwulkeXCJQQrMY8LCTAyaLkYI+jiTmak87LQw0PtW?=
 =?us-ascii?Q?IYclS2LPJ4m65JRSmHk1aMTWdYukQqOqJqNsDmHTxJsEbzhwaG10PqVxC/E7?=
 =?us-ascii?Q?X49wP4ZU2ZiG4x4b+h7sGVBbstkxwRztV1f5XTnMFKDRaQlHXVs7V8pjtPxn?=
 =?us-ascii?Q?ukqAC1lgqiaYW+SG4j+nekCzP5vac4j4ahuoCrBO8AXGh1KmHVIv8X3QV6Vm?=
 =?us-ascii?Q?hoW4ajxC1jTuDHE3KtcY9XIF9NJPz8ocpeGPR+uqeFlVRRk0yF9ajNVmbyx4?=
 =?us-ascii?Q?8NzIC/DdvfaGZ5+vUYUEfccGDzTv4CN/Tysf/o5SxCuqxHxSlSx7lZHKVH+2?=
 =?us-ascii?Q?78nLU++gXry6pqeYsmp6FlqaU/6Uw/YjMKJibaV/lVEVGb8OP3WLURtSZIfZ?=
 =?us-ascii?Q?zi7h0tPfvd/HF9+3wqkzNNPMQfLyZ6iEEb8ztF+Z4m271hvYYONZ6Dmc+gGE?=
 =?us-ascii?Q?8GpQBBYf8J0ZWWkiFz8LRc84SrRkZTtiY1L4YabycszKuGVc2yg6HkWs9B0c?=
 =?us-ascii?Q?gmBUi1bQawUTyfaxYlHO1l8WrhCWXq9O8e3pyCRNb4YX8TJL/raY3QWskWTF?=
 =?us-ascii?Q?lnqNpVEQ1ZKgEVgXHW/2l8EtxqNMgZZFOsAslkQrQJxJiQaEBqI0+4c7Oqoi?=
 =?us-ascii?Q?24vR6DEvEbEpMyREoi+kDqHp4Qkrs8d87kHI+p4hHc2DKf1fIYQUcYtKIpvW?=
 =?us-ascii?Q?YAVdMM9AZ+g3+ivMclXZ31V4LPrWfHcyXrX8vNWSUa08+hlt8CXHnoDwFDad?=
 =?us-ascii?Q?BfqbjHqLpMDnhqE7XfMrBqxR3hZXcO7hAT7Vg+v9wj85zJj2cLdakzjLeAGb?=
 =?us-ascii?Q?wVXvddP76FjglM65mZ0V791yd1bfuai8CaxHD0uoUcpfh4H9o57xVKRxCDMy?=
 =?us-ascii?Q?AGVvMmCsG0ZlHvsY+mHX95lN+Y6TlAv5AuR5tMr50bdSfNIm15mrr4iAb+o5?=
 =?us-ascii?Q?T2ijJnRty0PrNZisSjEcFJitHNI/qdKssUn/2pekgkrI1PAM+33iYQY3Fkg9?=
 =?us-ascii?Q?0rCX4vN0IA3zfcbpwE3dkF9NuQ4WEfL/NP0IwFxoKz0wo8bqnqxRvYhJYeIu?=
 =?us-ascii?Q?Ss+3i/ZNPixzZPqeWlLjiMGwshxGidFdW8hq2jM9CmS1RXtTdMeRY/qCiqyx?=
 =?us-ascii?Q?hqAQ82aEEQbkE1y4CsslXMyT8zJ+fMj+j3WdViygS7Meg91txEnIpOT2solP?=
 =?us-ascii?Q?6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR11MB8777.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a93193-8a14-4d2d-fe3f-08de0737aab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 13:28:00.1328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkFx7h9lsEunpXLub96pQncTFc5V97FuKLem8yfWhtI8iXZ58SwTlJ4Pu4ASMkq/TkLRt4hi4ItllrQ4HALBb+uLit7YAvJMuCzS+JxeG5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
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
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Tuesday 30 September 2025 15:29
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>
> Subject: [PATCH] net/ice: fix initialization with 8 ports
>=20
> When initializing an 8-port device, the ACL configuration
> failed with the adminq returning an ENOMEM status from the
> sixth port onwards. Fix this issue by halving the depth, and
> therefore the space required, when using a device with >4 PFs.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Kirill Rybalchenko <kirill.rybalchenko@intel.com>

>  drivers/net/intel/ice/ice_acl_filter.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/ice/ice_acl_filter.c
> b/drivers/net/intel/ice/ice_acl_filter.c
> index 83cb3e36f9..38e30a4f62 100644
> --- a/drivers/net/intel/ice/ice_acl_filter.c
> +++ b/drivers/net/intel/ice/ice_acl_filter.c
> @@ -114,7 +114,10 @@ ice_acl_setup(struct ice_pf *pf)
>  	else
>  		params.width =3D ICE_AQC_ACL_KEY_WIDTH_BYTES * 3;
>=20
> -	params.depth =3D ICE_AQC_ACL_TCAM_DEPTH;
> +	if (pf_num > 4)
> +		params.depth =3D ICE_AQC_ACL_TCAM_DEPTH / 2;
> +	else
> +		params.depth =3D ICE_AQC_ACL_TCAM_DEPTH;
>  	params.entry_act_pairs =3D 1;
>  	params.concurr =3D false;
>=20
> --
> 2.43.0

