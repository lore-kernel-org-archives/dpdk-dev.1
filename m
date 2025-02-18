Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FF4C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 10:48:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D2B9402A0;
	Tue, 18 Feb 2025 11:48:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id DC8B84025F
 for <dev@dpdk.org>; Tue, 18 Feb 2025 11:48:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739875699; x=1771411699;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aKDppXa2xkgqwgkndItcOahYTGmZOvY6sAkM/P3V3+0=;
 b=VU1YSr4cl7Ep7lITE4CEmFl/RifUtklq3h+DrJlXMM0Dhx7QHJhEDsm2
 eP0uNOX9wEnIu2zw4rjM0Nbme3PC2dANa3RXGf1ZXXHz86w+Mf2L+pRs1
 vjR2riiT0rYNCzA1quAO9DB2uD58TD/V9hPkAjockn75DyxuMq7Q3cq4B
 gJonTB0LjMxwW+l4OYieoeWLnWeUrI32+Vt1TajtTVn0sKJANCnxhbyQW
 81lqTCQeZHnn19yC0hYDKaoAZE2LVl7YnN4czV77xIXBfAsowS7sMXPCe
 pDR408hx5mbiye0/SgBUeHXoccb3/GsHqxqeu2glH/dUrEDaA38ps26Ko A==;
X-CSE-ConnectionGUID: tEh1pqTFSTKIn9bCh6Eh8A==
X-CSE-MsgGUID: WLbt4k8kSpGpYaO5iYZ8FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="58102362"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="58102362"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 02:48:17 -0800
X-CSE-ConnectionGUID: Perpi8vRSFmdDHuPhGI+Tg==
X-CSE-MsgGUID: HAQrLKmQQ02UITsePKcPRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="114099095"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 02:48:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 02:48:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 02:48:17 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 02:48:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZINcaxL+dFGI7v6P2+/E0tDnS49+K6rn3idK0L8G3SRr3C4BI++lw9htdZiUVz+1T8HOKgYYI0BkIg8gDAomKN4WR7f8pK2qBZAS43ASn7yENsvwdk3Wnra21QWkyjHo/WbPI7e+qvx35he5PulhkDs2WAm22Vel9iY4MYGdqxxyRyFhjQaIxy8bmqPjvWtZy+MFU+th0ku3DQl7+IeTtUa9cvhs+kvwJtZTZg71/0sFe3yHKGpmrXoHTS8f1mXp8hJsprjTCJ7Zx58V17DApB1gYjkAozEhiyRXc2nUbJ7b+XQcFWpA6QEPbgm033jnU30gTDSp0SfegVO0judUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAt3v7glQb4lw+anOjjFtQfTWBblGcPTUwBbfgY9fps=;
 b=EAuUchynO/Dd3z9WxyryvUwMj1DAGiqQn7cqwyt/4Ucn+Zh6V+MxbEhdxNZV3jCg/nW3BXsfa+8ego7Eya1agpWKFReAgb3Nci2vVtk/Ar/OUkIYmJUKcA8zDRjDGC4anQOXcKlZMu6/TrbfXjIPZWjyR3m5Bp44BipHWRcdMBC2FhshM5i99d7X9fTKh6ORExfFY1CBeFK/jO77/fZHyS5Nhd6qLAv3vEgo9Xb/KYv/kvJVFcrmla3nfiVeRt+/cbvYvWb4RaMHOCtbpXGHVL/2IranMEdU+SyipSVz4UZ56MopxbypdBAE9Jht070F7q3R+gi4Aa5rPa964LSa0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5587.namprd11.prod.outlook.com (2603:10b6:303:139::13)
 by SN7PR11MB7639.namprd11.prod.outlook.com (2603:10b6:806:32a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Tue, 18 Feb
 2025 10:48:14 +0000
Received: from CO6PR11MB5587.namprd11.prod.outlook.com
 ([fe80::5204:ecdf:ea31:48db]) by CO6PR11MB5587.namprd11.prod.outlook.com
 ([fe80::5204:ecdf:ea31:48db%5]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 10:48:14 +0000
From: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
To: "Dooley, Brian" <brian.dooley@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "gakhil@marvell.com" <gakhil@marvell.com>, 
 "Ji, Kai" <kai.ji@intel.com>
Subject: RE: [PATCH v3 1/2] crypto/ipsec_mb: add SM4 GCM support
Thread-Topic: [PATCH v3 1/2] crypto/ipsec_mb: add SM4 GCM support
Thread-Index: AQHbZd4RMwRj2qT310uCUz9V11f7ebNNGOWg
Date: Tue, 18 Feb 2025 10:48:14 +0000
Message-ID: <CO6PR11MB5587187C907F0E63A9BE306B84FA2@CO6PR11MB5587.namprd11.prod.outlook.com>
References: <20241213125850.2714328-1-brian.dooley@intel.com>
 <20250113171022.1649181-1-brian.dooley@intel.com>
In-Reply-To: <20250113171022.1649181-1-brian.dooley@intel.com>
Accept-Language: en-US, en-IE, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5587:EE_|SN7PR11MB7639:EE_
x-ms-office365-filtering-correlation-id: b3070a2f-a917-4f33-b2fc-08dd5009bf1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?unydiKB0/9FGk86iYl8sAhRQzktqaUOvrRASchKuEvMIdrkA55bB8fXu1ZlN?=
 =?us-ascii?Q?DXRFBWnsRlLRYtsSEol86JQusGflROXD1VY+b3YrkPZy9PrVRr8tu26AsgVN?=
 =?us-ascii?Q?7ga8zc0YcKNUmA13KLi045Q0MTIaZiZzPPsH9eAMyhz8jB0R+Yb6+z/wjsHa?=
 =?us-ascii?Q?zpOrO+ybiBXQD3J9I0w5Fg/AK7j6fw5rJ1oF0QQL6t84CePSfrJ3bj57qlqN?=
 =?us-ascii?Q?us4C1d+g+LLeNzEbq9I5kk/MBwP3QOet7XAl682kQMVNLZc6VMNzUxp+/3/K?=
 =?us-ascii?Q?w7z3ZCs/Wn9drOOshKvcX3BsMcddahLatdcaaXcwfGJ8vTpuyJjatd80aH/b?=
 =?us-ascii?Q?MmG9KhfYjMD9clA8vIiiHJdguHpV/6d9Jeq3cnMWM+4Sv9eqWOP/voMB2Y33?=
 =?us-ascii?Q?99NaAMSKPUFfF0ICjEJQAoi+SKXgAwt2LAXHlHVJkIk3eWrgd3jCaupIf/Lz?=
 =?us-ascii?Q?JeYuW8yz5edTTr27dHqN9EuMPj4ZG3eP/myHoSztSUe9Iv8gfsSjiIyek5Xb?=
 =?us-ascii?Q?ruGmMr1gDJYY3U6M1eKqJCSN9xT5tybwwoOSf/yGoZKt1Y8exgtlRwNLgXTo?=
 =?us-ascii?Q?ElBx/IAVEBk4o+eiDEyjBFukrL+DpRPgGjWsk3G39IroZtLVn50lLsotjGAq?=
 =?us-ascii?Q?zASXLPxneR0B+gUuTwmES8Ysb6hI4LhFSShVNvfLOUEjmJbUy+OgSCnH4/Y4?=
 =?us-ascii?Q?0gXhFyuW6FE//G/eWqFzfqoDe63hUbYGBtS9tmsCTgUl9EKmihpJGntM5YM3?=
 =?us-ascii?Q?rvHoZtOG2pDcHgfbxfiSarpm0nSYzeaevOXsutkRgGH6dXWvvK9qA/WLVjyF?=
 =?us-ascii?Q?XBXBvZtDyr7AyM9KYddrwdnUsRqGt02ZECKdPNbauB8+erV2gB0lBj28jan5?=
 =?us-ascii?Q?EwtmlsKHU3ljIMkX5d02bgI5GqRcALTic71aO8W0nReH1H06DZgLvaFnuzLi?=
 =?us-ascii?Q?HPFa+2sYx3g/Y1kOD15FK5QJdM8tBLbKxl9wBYkhWUVZkOSSz4CVl1M18HXB?=
 =?us-ascii?Q?mIF4BNvcPpjgpG/4gGaoHiZMnjo9Hb9uJcu4OGik0yAVECJIjNs2yhQRz82W?=
 =?us-ascii?Q?cRt0T2PMOvkhuzU2fUFH8RtlM927PFFKNlS23aFBBoJhzEWxXuOZf9Rj5kJ4?=
 =?us-ascii?Q?QVaY8zPcnsL39Qp3J2qp19mpEbFRnDtf0AUy3cjq9gS42urWs4X0lwIVuA/l?=
 =?us-ascii?Q?tNW5TFLxdP0hq7kuZzKQpPueeiVR15nMmR4dTL3OtIHs11dL4myxrQQ0lAOO?=
 =?us-ascii?Q?8WjuuWlusIK8XaIy9T55iYGF+mpNYkyAt45Kh8Xe+wnBCffGW6t1RgdEnRMH?=
 =?us-ascii?Q?vTtdeJDuLpfoxa0GJOXGC9fqU29+1EB3wjUunUa5jmGrB4RsW/8J8CB+LmSx?=
 =?us-ascii?Q?jHWQS4vVLmgm1BQ8HTC9d8lmyT1YB4NaXk+/aRC92pL3esWCDHiZocgsfFf3?=
 =?us-ascii?Q?AAKc+YMCoWYEDZd/0FWMCnhva8tGXS0Q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR11MB5587.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PwV0icNVcbHBCl9bpE9RuIsORsOjDy8DDUWtkzqBCl6V9TGzrBwu04tDhZAQ?=
 =?us-ascii?Q?1dolYxQ6lKxNdmpmK6WIj97F5LzhZcNH4s8teSOD3CCO/mF6jCu2fqhvBBuv?=
 =?us-ascii?Q?vHpJNsFGLqzcQAZhdObIqQ1xTRmhGcMfmvzBvsrUkPMdC0SUQIcmD7NR+y6I?=
 =?us-ascii?Q?JlA8plTpKQg5YO2ad2lsrpfqEznk/aOmdTRYWh1LpEOP1kU5zVEPEsgjYnyI?=
 =?us-ascii?Q?j8yLkQ3xaqZ1vVX6lmJSL9jtyI9YKwHY9fQFJh8lN9ZnNMKarPcC5Pi/FCuR?=
 =?us-ascii?Q?kJHb4x1+T7VI3GeSUzpmVIVXDx/XmipAsvzDsPF1h07qcBrq6GNIz4if7f/k?=
 =?us-ascii?Q?nL1FmlS5kSCo3U8dbv8S7XpBE4PAf9fH559xh/K+P3ASaEeKq8aBnXhQry9d?=
 =?us-ascii?Q?U7rWe53+BmnzkfMuwD6E0FMiMaYvsnN+70apZc6TQIGunlzh/9KiR2DgmgWg?=
 =?us-ascii?Q?Nj7P91p+C4k6DI2io68eNK8nUHkfjJH2kUZQL56YSvCWt/8DO25ez0nvUtuf?=
 =?us-ascii?Q?sX+Ejk8qO+TZo4PhsuKaPa5RuVGfZ6DBWQg5KOW6gkVuVC8bEnpxpUsRNPVJ?=
 =?us-ascii?Q?DqvpiPhe2kEwLCWbDANNeIVvyRGqBLKT52/ivoJsDkeVUfQL6Pp+C6zjb25R?=
 =?us-ascii?Q?GBabL+ebJ9GUwIFX/ieMJ1eb9a2N8QWPQIJsfkPqI77qm+r9bGf49m1tKuGg?=
 =?us-ascii?Q?X2dDunmVPGGVduqEk772osAXBiSqkjU03PDKSh6wmWyJttpbbxSfIwpDu1jp?=
 =?us-ascii?Q?m25JndeeL1bNg297N0hOdTnkqF6HYDsDHrBBS0lFwGNDWkeW2mN9HIbuUJyu?=
 =?us-ascii?Q?QlcmaCZqefsjwrx47z1EFJj1OqJDIvOsWlK0pZjPX14BZeiOv5RfmrFEfK38?=
 =?us-ascii?Q?1jFF1kLGnaaSFWFspH62Nn5hJio/tjFHbv76FcnUlyiaagJ7cbcXvconD7IQ?=
 =?us-ascii?Q?z6hVAMHskuozOE5KeJVrcW1kqsaa8Klg0sylZ6rPbS6e3MMQrJNv1vhP42Y5?=
 =?us-ascii?Q?ATn7P+8LC6rU3Owrr67Ruxq8CIdpBHsZZ0gBP+mv+BkbV1VfwGVfDGBJU4PC?=
 =?us-ascii?Q?PgWliqHNzDYE+ZFPkVJBvnde1HmwrFTIwdBlI9rFSMqIwLRSl4REP0E48Zjw?=
 =?us-ascii?Q?RTCmDXGwo1zvUO8WGByfOpI/0md0kiEhtpsxi8HnjCwJDia+gakwenxb8dlC?=
 =?us-ascii?Q?QIIl3+60gH47S8HyMWlT3iVANHeeCLCVXZHQf3gE09le6ZkaWebo7bodXww5?=
 =?us-ascii?Q?VJR8Vw8+I1tGWwQThmmNRzU9rVCdLxL7zOTIhDxagjtLSj/dgBWZ7cYNQ3ij?=
 =?us-ascii?Q?etBPRElAcm2Jl0coeYxmmBWv0D3J5H7mJppOixbwPmCugzWPDMrqOUYzehHj?=
 =?us-ascii?Q?5VAMzsjGYiBUDtGiY3Kym3kFxc0IB7FA63BKgSVwLr8uue+xiBoTDeoVLjmL?=
 =?us-ascii?Q?r2saRNtwIVqLXDAWb2wY0Xr4Q9IWX44pN3aeMzmI/aGlKF4uYAPqXkjOvyMP?=
 =?us-ascii?Q?e+JZjw977A16sTP+1DlSwylRWj6wJkEJcgFNBo1p+ljcb7asF8xycrr8KEGi?=
 =?us-ascii?Q?HHC1CTsQ0oFC7pSDtCjjKh9krDXn7w4AwIh9rgEHXtWm1Y0yc/57E9Hl6Hn0?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3070a2f-a917-4f33-b2fc-08dd5009bf1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 10:48:14.7366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xv9mNebN+Y/sxkXTfiEW360KgK6dKBELyQdSl1Rhs+o9XvrO95uM3u9/iJm+b5KCsIyj7AoAFQGcLHNGRM114a0defydvpJaEymnE9lUfzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7639
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

Hi Brian,

> -----Original Message-----
> From: Dooley, Brian <brian.dooley@intel.com>
> Sent: Monday, January 13, 2025 6:10 PM
> Cc: dev@dpdk.org; gakhil@marvell.com; Ji, Kai <kai.ji@intel.com>; De Lara
> Guarch, Pablo <pablo.de.lara.guarch@intel.com>; Dooley, Brian
> <brian.dooley@intel.com>
> Subject: [PATCH v3 1/2] crypto/ipsec_mb: add SM4 GCM support
>=20
> This patch introduces SM4 GCM algorithm support to the AESNI_MB PMD.
> SM4 GCM is available in the v2.0 release of Intel IPsec MB.
>=20
> Signed-off-by: Brian Dooley <brian.dooley@intel.com>
> ---

A couple of comments below.

Thanks,
Pablo

...

> --- a/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
> +++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h
> @@ -826,6 +826,36 @@ static const struct rte_cryptodev_capabilities
> aesni_mb_capabilities[] =3D {
>  			}, }
>  		}, }
>  	},
> +	{	/* SM4 GCM */
> +		.op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
> +		{.sym =3D {
> +			.xform_type =3D RTE_CRYPTO_SYM_XFORM_AEAD,
> +			{.aead =3D {
> +				.algo =3D RTE_CRYPTO_AEAD_SM4_GCM,
> +				.block_size =3D 16,
> +				.key_size =3D {
> +					.min =3D 16,
> +					.max =3D 16,
> +					.increment =3D 0,
> +				},
> +				.digest_size =3D {
> +					.min =3D 16,
> +					.max =3D 16,
> +					.increment =3D 0,

Digest size can be 1 to 16 bytes.

> +				},
> +				.aad_size =3D {
> +					.min =3D 0,
> +					.max =3D 65535,
> +					.increment =3D 1,
> +				},
> +				.iv_size =3D {
> +					.min =3D 12,
> +					.max =3D 12,
> +					.increment =3D 0,
> +				}
> +			}, }
> +		}, }
> +	},
>  #endif
>  	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
>  };
> diff --git a/lib/cryptodev/rte_crypto_sym.h b/lib/cryptodev/rte_crypto_sy=
m.h
> index 505356ff44..b47e52f63b 100644
> --- a/lib/cryptodev/rte_crypto_sym.h
> +++ b/lib/cryptodev/rte_crypto_sym.h
> @@ -482,8 +482,10 @@ enum rte_crypto_aead_algorithm {
>  	/**< AES algorithm in CCM mode. */
>  	RTE_CRYPTO_AEAD_AES_GCM,
>  	/**< AES algorithm in GCM mode. */
> -	RTE_CRYPTO_AEAD_CHACHA20_POLY1305
> +	RTE_CRYPTO_AEAD_CHACHA20_POLY1305,
>  	/**< Chacha20 cipher with poly1305 authenticator */
> +	RTE_CRYPTO_AEAD_SM4_GCM
> +	/**< SM4 cipher with GCM mode */

To keep consistency, "in GCM mode".

>  };

