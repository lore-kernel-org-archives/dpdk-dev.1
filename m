Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A101FC624D6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:59:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8706427DF;
	Thu,  3 Sep 2026 15:58:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id E08D54279D;
 Thu,  3 Sep 2026 15:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788443930; x=1819979930;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=w6kZt5jsDSdwoCf5gowwuRkQcnGXHy2/hhBHvJ065Uo=;
 b=S+Umo7CvTRUpD6lHPzylUUuWrJQBJrv+LkQ/HH5Y6NnxqwYltMGATLwC
 Y/X/QFTcJ4N0hNzqItOT5epi+llAFisgVqtSa31RHL2xSYd4nfBQ8nBHv
 RFBnq7/Fm25F42tAbjJ0BKjjqphi/LqcwZrVD3Q4xQm7j1Im5PPgiYSko
 /LVrDSoJSP3mLO9bd1GB4XjY8qyiqAbL+iIeHPOUuWBqwsi8ngsemfUFy
 RKvudN7KaW1Ke5MWb9MAhJDJF0CkAhvMaTK+0zBl5N2y9geb1ZaasSHRP
 0veko9W/gnlOIwL5n5g7er8jPJz2M9GYJxd4V4/31IAnY6Fg1kUz5uBaH Q==;
X-CSE-ConnectionGUID: o+Q+0fp3TXuN8b6ad7Gr8A==
X-CSE-MsgGUID: 8J6B2olvS1aIiD2JjXrDoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88950409"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="88950409"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 06:58:49 -0700
X-CSE-ConnectionGUID: CaePgMCpSdupQCOx1j2eYQ==
X-CSE-MsgGUID: rfn7HEscRAuaaBNTAWoLOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="307945959"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 06:58:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 06:58:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 06:58:48 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.34)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 06:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lW9UBGGTNXFuelTAoNr46vgxPpSHo2xLU4n8i/QGlPJV2OQw4ytNLOoAHM3qPIcNNOIy7hZgwc5rNWwfVD6+xTWyWT8B770jXzc9Ocsc58U90YN1bMSuyEAg5qPW+bivyy9lB95ZZshbui8lap+rjMdfKsmCF20oRcwuaK78zurZqK9F6/E7Ftu1bvbNZmruWeDrVWgsmgRyWZNDbfZPIBGjZMBLdYXNZo1/fotHaUc+vHLhRFhCsCbir7lzwaRNSbMKME5ayaX2SlWMorJkR0jb7FrD2SKo8TL/romldoBzHoVrpeYfu7uUO8UO9sQj0kui1e2jiXd0ywKs0ZVTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Igr8xWlDkY/hG7VqgQAGlc9+FM227xE0aIwlF6gFJxM=;
 b=sms1k+Kir7IS6HEsHUIJ13uVNBwYmYkSNus6r/LdBjT+TD2KXkGnC95JzJmmtbsRmMzptmMoN6D3lV6Nb+k4TLJBjVFaJRxOPZ1VWxMpaVhujWLnuT6k/zaeqCk8/WIdTz7Ot3SrvuvLia/3lNRSZIB+lZzDnefAl42IOqwGcTLh0qzsKDAzjBcSdRDH2QCbfruxtSzTb4Kfa7V5/BRN5Et2eDw09nBRyFmx3rHqS8Mk86gP5mELJZH3eeuaS0usztlQc/6Vv0eMsLP5ykbvppKcwPo2LAKYEYHw4aTEXC41k1X1T9YBKlhrtzRH65ydcd1Ku69XBcewO0uTkorWzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 13:58:44 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:58:44 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, "Wu, 
 Jingjing" <jingjing.wu@intel.com>, "Nicolau, Radu" <radu.nicolau@intel.com>,
 "Doherty, Declan" <declan.doherty@intel.com>, "Sinha, Abhijit"
 <abhijit.sinha@intel.com>
Subject: RE: [PATCH 1/7] net/iavf: disable broken QinQ strip on Rx
Thread-Topic: [PATCH 1/7] net/iavf: disable broken QinQ strip on Rx
Thread-Index: AQHdOTM9+8+6Qr7dr0KGSwa/LXWtkLa85imA
Date: Thu, 3 Sep 2026 13:58:44 +0000
Message-ID: <IA4PR11MB92780A991E3E6B724680D8F28EB62@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260831102621.495759-2-bruce.richardson@intel.com>
In-Reply-To: <20260831102621.495759-2-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DM6PR11MB4531:EE_
x-ms-office365-filtering-correlation-id: ce9dce69-19b8-4405-d539-08df09c377aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: 0BzN79y63/KZO/z66M8VnwV1yAt8WtOWgalhQvIe8LRm2+6NGjAz6Ugv/est/+mE5jsLrukHAlUy9ldE75EuaGLYMvTyhF9UDH1PXv/54/FBEpRLFuqY4hbFAtDwXGukeewDaKeTBgUw3HIsJpB06sd0dkC8qLLTQUXbQnECMDvR4CLVKyHabWr//Az9jG+imb6fcYMWU/PPTwhaKb60kD9dgj5/tb1KgMpGzZUuEYPlMkb0TYD5Jj6baGe2XpWKgpZuvQlnCWvBAy/8GVKCoYLogTZY6+8fdgF7hzaIkyfRonir3laoHsCftUyMb1u8LR8jK6UkyLZfpmxCCwF1FdyTF117f8ovc6nN92k+dGFaYPlzn3qVBPsO6r32BvSMdtvgcyA9nazfvfPOQFH2VcFu3G1raayWtkSBEKhxIrIegw0mmtVECtI5wxWq+F7yrVovjSjCfuyIeYOXDnVMnDys64NGEFk8JgRqvALZi4+Zi9jecYVTnArKwES73wzhKoQ2lYqiwBSBEmACgXnJ5AqU5t2tDAV6fNLejW9KBXlaeTEZjJX0kR+e1TpbvmjQRaPZ1/wcwQxVq0kFLOTy+OqcCeGnPRc+slNxQV7YQPl/uLk5nU6WUXiDlBAZ+HgGgDGidPOhj057XLy7SzjAzAduZrx1PAvcs+uNskaFFcc3+XTGcR2gIglD+jX490U8QvBec5yxJwnRcU0i51qHaVYm6eZ5VL69Ez2KJrLtHsQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BBPqnfxXLKQDXrlvjXk22pYjxFHAZ+Ql5aoZoDojiOCdDH5Md9hV1E1Hks+E?=
 =?us-ascii?Q?gXYWQxfLwEfiipQVfv5lIk6fVz41LaNo5rOjcLNLXGpZ3zU8ZUShn+5aHkiH?=
 =?us-ascii?Q?N8rAR8PnDIfmIhn8eyipkNa6G49jQoLtfE0PVzId1hlZ7MWRHXDtn2eZumkS?=
 =?us-ascii?Q?QXKi/tiPEF0Ii+5J+5BiOMiBsYMBR3kNZuPU0v1wujge0pfzf3kFrcK0f9O2?=
 =?us-ascii?Q?YRr9QMCyjYmXTTGbikxFZ+252+dkNdcOt/ZcnX86653MgheghyHTGlYALOK7?=
 =?us-ascii?Q?XbZxPyrwIF1wayIVghMFVtmXeBiLgNCGESQ4q/Jwa4/zJ1k1R/uWEGqX9VaF?=
 =?us-ascii?Q?4219FozizYma9sWhWDORWyA5zDabP1Vg6hod9JQhZvAzOcbgxIL2EbsWnz8g?=
 =?us-ascii?Q?BflArPxMFQid0Ru0tcN1KYBR3J0adTDTbeE4lu0QfkXoz8SvMx+wZWZvigF3?=
 =?us-ascii?Q?a8Gh1gzYyfWmVK8Ahmr2bv6U+VSZJuq3wllrHl+UASMclNJcOngOM35pvyz8?=
 =?us-ascii?Q?jBRavXPa0YfS/IdV2XMlboGFg+Npg/Cc5PzaqoKFqKCkkY5pOeXJA9/k+tdR?=
 =?us-ascii?Q?woIItTDsxij1nipsd+BPKHBy5NwlZTWf4F7T8ImZdX1IBZwgRFBUiHHmGPt0?=
 =?us-ascii?Q?auPv3lfF9SkZgOsHMzAwpV2pyoQIKZkhjJ+OUWO21TfilXrU5aLIAn5VPqtc?=
 =?us-ascii?Q?5+ZiB9rr6dS1y4Nx6V91Np8mUHT+D89VQejd4ekjM5U8ZINr5wOeBLvEanUs?=
 =?us-ascii?Q?dpggP8VFXkiELgsq9/xNHRAphIICkCYW6QF/DEeryC9sL0y1170SeAdEOfKl?=
 =?us-ascii?Q?vHgda2tyI18P0OUGwhXizCq+Bo8kR/WkLh2NESiCxMUmmqY+V6XbKK/5eR0J?=
 =?us-ascii?Q?8PBXpWhI5MOG9gisFBR57KGDdEi2Ekxf5C+MFRDj5aKC7MUJktvcISkVgS/Z?=
 =?us-ascii?Q?RCqIzxATaxavGWOS5LPiz1Apr27LYMqBlNg6D2tfoKmrh7dw5rsCbf8ekgRz?=
 =?us-ascii?Q?vTyYG34Q13tOSY4k7YDMJKwREV5I28iV2A14257I2ZR/4ptCZ5JVFzG46+Be?=
 =?us-ascii?Q?Rf9hWfOB8wB2+FREAcM6/rOKYNCcAoHo2phMPVE1qVGpVuAss8Ahysg39+40?=
 =?us-ascii?Q?KgbodfVDiAYxCvcjt2S0KCkGo0mjhB+dUCEi7y6RkZuI5Nt1Beh9waznxzj1?=
 =?us-ascii?Q?jXNceiED/rh91jQkwPU/Q5/uzLjVhG01jKEglF/rEv8Lk/KJ9SG8eyBSXZsW?=
 =?us-ascii?Q?2F/tcQ6TCYwqX9bbXKY66h0fX297aEEYxzsthteS1flqpHgc30a5uHnfrhuT?=
 =?us-ascii?Q?vgGHvZQArGnNXDpCAlh/ihsN8iWxYzXf3PBYCqDrpK+L1Lb3dG4xuyQ1mG86?=
 =?us-ascii?Q?GOX2+Y+yKe0rbrhREAnWgZyaAXzc2TX9bjKmWYqLWmAOPYS46emPgTGM7Sqx?=
 =?us-ascii?Q?57HtRjjA2ARIEYB3HC7x53Bq3Ow2u0w5wRtQX+mB5/9Pxeq3D/sZycnixV+9?=
 =?us-ascii?Q?+rGiW5tuEBpT7eYwPI3aOhYGHXsapU73E+JMV6VdazCPa4xseW4NzPU66kj6?=
 =?us-ascii?Q?03NQA+CMzMVBhNJKLjLinIf057DROhrM1EEaMgOkZ517PLWwabiYVD2mKSFt?=
 =?us-ascii?Q?kqf8WuYyw0BzRYEOtwLyhLnL+yOIEjtC0MyD15/qxTxkSM5NkoXL2jkod28D?=
 =?us-ascii?Q?zmMBJeb7IuV1d/h/fpP9DsWuCihwTBxjIWbhyPFMX6ilYWo4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NqSEwLRhMYwWP+DYC3TtYehE6n075mvDi6izduPSUiP/xUYZs+otS76P471+Q6KnVuh04+/IlXJLQenM87SFk6tOg1xB5df4mK+hoQztvYQeCxRS1U3aR6yPACs7SgwM2ItUzGO9OZZekwKHZOu2rYU9S2iPAn6FLc0hBOcTbpdnnATA3Z0bHffAHDKbv5IY+LxqJPznZtifNEfL4Bf3L3Ryhapc5DZ2j5gOQhJYPZiggSnh0X+RgkxJjcaMEfGLLeEgnD90n6Gree8LusmIrlQCe+Wi9nXDL1MWem57hYO3x5BN41DZNWDnKaWqj1KEB39sblu+0tEWLG1v7SqKEw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9dce69-19b8-4405-d539-08df09c377aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 13:58:44.0689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTK+tqqB2qj3N9ju2KRNwGECJKjNALtCEA5bI8qkDmFGvhdrd0yx+cU/Cjy+p9QI6k7CnWviy2VyjlUMfYPR3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531
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

> Subject: [PATCH 1/7] net/iavf: disable broken QinQ strip on Rx
>=20
> When 2 VLANs are stripped from a packet, the iavf driver vector path
> fails to handle them properly as it 'or's the two values together on the
> assumption that only one is valid. Explicitly list the VLAN related
> features supported by the vector path, rather than using the
> "OFFLOAD_VLAN" group, thereby disabling advertising of QinQ stripping so
> that a scalar path is used.
>=20
> Fixes: 1e728b01120c ("net/iavf: rework Tx path")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/iavf/iavf_rxtx.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.h
> b/drivers/net/intel/iavf/iavf_rxtx.h
> index 6f53d5805a..3ff49b94b4 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.h
> +++ b/drivers/net/intel/iavf/iavf_rxtx.h
> @@ -105,7 +105,9 @@
>  		IAVF_RX_VECTOR_OFFLOADS |		\
>  		RTE_ETH_RX_OFFLOAD_CHECKSUM |		\
>  		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |		\
> -		RTE_ETH_RX_OFFLOAD_VLAN |		\
> +		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |		\
> +		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
> +		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |	\
>  		RTE_ETH_RX_OFFLOAD_RSS_HASH)
>  /* vector offload paths that use the flex rx desc */
>  #define IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS (		\
> --
> 2.53.0

