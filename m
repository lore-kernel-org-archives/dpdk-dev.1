Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4E3C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 13:05:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E5E0410F2;
	Fri,  7 Feb 2025 14:05:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id D7BF940E45
 for <dev@dpdk.org>; Fri,  7 Feb 2025 14:05:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738933509; x=1770469509;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Nbtyg0CNRL+b02qpd9m7AEKOSxqid3CSyoii4+pTYFk=;
 b=kCZr0gh34sYw+6oOjhtQYGXPH6KPjTgyCYlPUGvU04dt19lQpQ2PKwZU
 SIKFmjRQIKZfkjrEfaCc3OxJCGfTTtj5lfwaJSYVS69R86R0AoiBPZr0C
 z8cM4Ftwbm9xEuT47E3cKkaMgUHLQp+4jnnYu+OVHozta2t8HhebAUVE2
 QbFi8udkjs8xPjK51nvqIIeXiU+3E3J0FQ+6zPObwg09gP7JjEsGPcODm
 MKtjpPeaZsaUG+9+pur3mueSx8pI/4PjI0JOcE/fp+2ohvIXtKVIJh7xX
 0Lw3VBvPi2uTeD6xHrWECSIWXuNonHtbGMtAbJ/ozR+rGZ++lfKZyt2FH g==;
X-CSE-ConnectionGUID: U1scmbiuR4uWMaDWTX4OSA==
X-CSE-MsgGUID: w0u2PmOkTACDEEzoTPWPjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="49814717"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="49814717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 05:05:07 -0800
X-CSE-ConnectionGUID: m2hQvbagTfyZdV1tCGn40w==
X-CSE-MsgGUID: 1t64oCppQNabmIRr+mjqig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="116462466"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 05:05:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 05:05:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 05:05:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 05:05:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWzYuSOso1AU1ESG/qYSJUaLMo+38mkvwAc2bsvYSxf2xKKa44JhzCyO4QD6SXMp7HhCjHbPcTLAaF2mvrwyDH+U68eMYBUUo8Bqc06EsmDECRAhAqqqKiGHP0hPLVxYaPeybus6Rx5fQ+Bxm98BELMxfLS2zCkYbPbfW30l8AEONsWRV8CSc+SFxyutxCU7ghzgUqSUhlY5BoXAuMllscZRakL02yG2Cv/2KPKeMvSlzQyNbG2lj+KUiQf1UxAcIRq5Du76dc2+ZEQ6C2dqFkWLrE7WFWCNFk0xtqIhnwIef+RukEmsqtnc96y6KQyNGforVQS2gaB0jdXjod5s0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAHWIR+hQ4FlTrpc82OjmijhJl66LpalN6x9h/w/GYY=;
 b=FkaXzkC0sQyfo+ko4mHDbKib01tqc5RjOTZ24eG27OWedQGbvxsEF1x+Tv8NQ2Ba8PKJsFzmSuyMfCFqotn0gD52Ya/ZmORm5J2zIs5+O6saw0DRVpjlRF/a16fJ7ENNrybfn1CAbZu0q2orUW0qsFGcC38wuNFMeZTTk3HEvi9VAWjn9VlpPso4kFuDeBTiAtcrvfSr7tGY55reLM6NpUk4NpUn/TYpqvUXYlVHw0NCjY62t/QjFzCfo6xcqU0iIBXMbjEq7hMDSpNCaYkl34DZV349nccwB6VYZL6P0pUexVdBfvoTmkB37DEv186b6C6pU4+YV90Dp1/SiCuY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DS0PR11MB7412.namprd11.prod.outlook.com (2603:10b6:8:152::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 13:04:57 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 13:04:56 +0000
Date: Fri, 7 Feb 2025 13:04:52 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 07/36] net/e1000: add support for more I219 devices
Message-ID: <Z6YE9HWGelGN4ygU@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
 <aa0df2ccd3864c368e93367b1c38b5bc98b53bcf.1738932115.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aa0df2ccd3864c368e93367b1c38b5bc98b53bcf.1738932115.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8PR06CA0062.eurprd06.prod.outlook.com
 (2603:10a6:10:120::36) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DS0PR11MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d62aa36-a1a4-4ff2-0d28-08dd47780527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hM+Pg7rSohPlImHf9ILqYoqISJV1jehOwt0LYgntmyfSm49kRLlPptxBmtqN?=
 =?us-ascii?Q?R9U7WHcHDbU+wCkIWWldGXkbNH+rD/8BJe13WjBVFHbyvZfEHbwz5C11Jl0+?=
 =?us-ascii?Q?mTKTxlN9kW9yVlGkzft4cwjL894z4M1g+i/UJF+PzAMDCMLc3jllhO38BQ2h?=
 =?us-ascii?Q?rnha9DZXeT/c1XJpWpMjUzylWr1peehL9svNIXdCeLiVCXJDwbtWOJhu0Uyk?=
 =?us-ascii?Q?1mJ3+SA53BcHNVxh04CcwFoCONtB7UJ3JMeNJVZWGn18BHUxaCqSvMA68IPI?=
 =?us-ascii?Q?iEY9EFePRcQ+8dxVT+7Bax2nGKYa4TYZjNLzjLvJhHzFntKGVhl80R71CDop?=
 =?us-ascii?Q?EgUoc+rGTRKgvvPydlAoIw1Y+fAcoGpxBpERpc2Xa+i7MgfSgBnL5oLJayXd?=
 =?us-ascii?Q?VJjrlfvEe4EEJwtrbcjxX1Dn0KXc6OCgk97E4xKCvy0GqiTaE4rZ9ewQzNOc?=
 =?us-ascii?Q?X4VBLGJgrgicVom5AFd75psv7hfSgSfhkwcdEAgmcBDCb+OWuEtqHgihSOOy?=
 =?us-ascii?Q?sSnfqx8I0bR212SRAIrcP/XILfXJGtnO1teI1grspmg/SEHVmepDZNpzrqa8?=
 =?us-ascii?Q?A+zMhUyMutyjAnWQeRRsOnQhcyUb0qVkC8stxE+7W2KpxPCEIvCFu/s6RdcO?=
 =?us-ascii?Q?uP0DtsO2b7YcBLMIHqQrEL8OmbclfCEBupZwWkGh1/xP/d+f3BmeWJyFPucK?=
 =?us-ascii?Q?MwvR4W9Skm/P429Y24+qcxTVNbczkUMa8KOAgaYCdrzkUfQGhbfvopSj3RvH?=
 =?us-ascii?Q?QEEwAbKLA1WFUjvUTG6vJb2SmZylEo5FG4CVUql27hmX7cpgXnVNruO5Afhw?=
 =?us-ascii?Q?2A/iVm+YMvFooqiOEa5wZud+ODV6TKO0XT5uor18Ijym+bZvsdCvKdAcJsWx?=
 =?us-ascii?Q?UqoExnnfMzu0qGfefQUA964Gf1twdSJI40/R9BVzUkmMTqAB7K1PozcN4ooE?=
 =?us-ascii?Q?dYEkCQDkU6kkrRRZ4qIJf0i2wlbLEAnAxVPdVthmtf6bvEA1Li/sQ0XILrmV?=
 =?us-ascii?Q?itXYXYzz9353jhbPW5okR7WW3LqIr52iZwEzVHB8InFzElWjUJvwX2ikqhVN?=
 =?us-ascii?Q?Dv6pQyfKr7zZ/ejmSv7dz1x7d7zzWW1o6MgZdjsMIp5MC++z2jkkndZBcQHJ?=
 =?us-ascii?Q?dfbudECVXAXjh8k671+MmBioTuSI8KTAO4JAe3yaw8M2ad7gjRGTT1TqptMv?=
 =?us-ascii?Q?JwsfG+qwXjZkiKS+Tk6NgBY7v0XrH/RE46NFcbbror6ugjCJ6YulHZy5P0fS?=
 =?us-ascii?Q?/EL48b7keWVmG4hLds0b+QtqT0CE+A0rxR00e4t+eZBU5nx92o/EA1qoChbV?=
 =?us-ascii?Q?lSEYa7Bkb+xQgQUrDcyKj3gv7s/9u/nI00jQD75EwEh5Lx0ugZ+PSgWwBX2s?=
 =?us-ascii?Q?tZhyHOxENp/MW0Q7+2EayVq+bY5w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xiD2xh8RWZ1LuQU6tLT0yQWKaYK3Bs5cHZOg7MuKyo1pABBF5KO/iXWEgGON?=
 =?us-ascii?Q?DWeve08LZ+senFMlOYA2S59M2vsRAx3DlVYwCNmEItrFrKNt3b7khlg8ePXl?=
 =?us-ascii?Q?2W5MBDUwAy0x4iJOCm0Dtb3fn8e1AP/3UYiGVG78phVPF3vaOAECqDLhZCWu?=
 =?us-ascii?Q?aSPDdJV5jaN7KkrIAL+XWulJyQ47dTASTV9Ox1czAFwrsXPOzxMRtBM6ei+7?=
 =?us-ascii?Q?qI3C9uHXkEmyH0Dpxycvt5bnzjh8yke3CbmUCHsyujFYVOuBey4E+04Ov3Af?=
 =?us-ascii?Q?zDurYvITWUqzISsS6DQYON16YHE5cry6zLE1mTtE9lezUbltGyjHdPZ54I41?=
 =?us-ascii?Q?IVzkgx8M6tjttszvxLEmcCj4BB4Elv4jSMB+v+aO+N6+TYPBP/dIOrYK+Z4J?=
 =?us-ascii?Q?6Q5yrFmvnCLddsSO4+ty4CsFqNtCV/ZJ2wKZSZVrovcYqENlbkfiCP+WUMaG?=
 =?us-ascii?Q?98s4XUBqbk4qFDTVs54vVIlDdSw35q83WqtnJ5hx4ENv8Dgrv0Sw3wzMqb+Y?=
 =?us-ascii?Q?NdajDrxb38bHtDHqr2jd01Cg6LrjLS0ECdcOqSx1zzaNFb6OTvcfRX6Ohu27?=
 =?us-ascii?Q?QKObmrsyFoN1wu7RYrMyMrrfcS9vBQkSCXnpukvG8rAwZJzO6WE76IBGaJk+?=
 =?us-ascii?Q?rKxxbYEUJ0IcqxDHUJwFyXsEgDL6ujqlzJB5SGBICfJyLYAbmOSNJ05uBS3S?=
 =?us-ascii?Q?1CR/s+H3Pzd6RoEVy89dOf+zOphmoc70Ev7teTIvAbyEP0dyoQ+UzMhYotQC?=
 =?us-ascii?Q?ooiIKjCaNbWsuN44CuOCRri1eYvRyOUU6TruXKI+GWrM3tOw4rlmgbBh4jB7?=
 =?us-ascii?Q?8Digqdo6k+jT8nsUEJl8AVK85Y1ke1hlMZWDqVOO+jg3QoglaPzAYk9bLXfQ?=
 =?us-ascii?Q?GVhaCopbYGrUu3753Nx+08+qb/E4QT+2ji4lBqm1s924X/qzIRuK6PqgTLUQ?=
 =?us-ascii?Q?X3Fp0RhCCq9pfEWkv2wq3yA/8BVy09pIzSB8glzpSanF4hn5KP4KwZOx9Msg?=
 =?us-ascii?Q?nEMlrHVleqT8ZI98WTdgmXqCg7TVlY5Go720KkrYoO1ZYFO2Q7Ip5ysmyhoU?=
 =?us-ascii?Q?ufbrqBLSgvoWIlFUlovz5Hs3r6NZICoN1ygIyHldwe39CxD+Hr/9CpHWgrhi?=
 =?us-ascii?Q?gw+pRVl6mxpuFbT9ks1W3YoG6zavevKfdwWYGKQZoRgR25Dv12L6DlIGqCrD?=
 =?us-ascii?Q?urWWflPfgPgW/DSx/YDodVJlgwY0K/1TiTlHCocbff9bYMehfkiut224LPlo?=
 =?us-ascii?Q?fx2ufp+bGKs86lAB8WQL/VkvfmRPLyus6YDqP9IaGbTZ+UGpqD98ivaLPQSO?=
 =?us-ascii?Q?uFelhaEJ1rMASzlsuxNakfpk+MVqbQlV5B7eM4schA7+Z88BI7a/WezitNMl?=
 =?us-ascii?Q?MpN6BrbN8Sd4Rex3bsGJ5JPT110xCRyALddTPJkw5mgqzsl/5wlbap4YPRdO?=
 =?us-ascii?Q?TPbXFybx+TMgaIko8LxXifpHpnz9NDfby2PE5CTJygQsxAgWkt02CKH/soDk?=
 =?us-ascii?Q?yzKBywNTe0Iq4vqRrmMx4yz0rN1EvrnPw2N7BM9uK3FLRL0QKSlkaFVgTf0q?=
 =?us-ascii?Q?dF9QbTxHN4xir+vVOaKH1eqm+/4T3owkoCGva3QVBzdyxluvZqZfhhraTkdv?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d62aa36-a1a4-4ff2-0d28-08dd47780527
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:04:56.6219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nulYZG6DhSFgAXJysQc3xMWwNLjFWVSYPffMZmG7z2F2q6Vyn0odE4UXBp2vYP6sfvajPy8/yK/EL3O+K3tZgJu3TZYfeGhByjEboPDsHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7412
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

On Fri, Feb 07, 2025 at 12:44:59PM +0000, Anatoly Burakov wrote:
> From: Vitaly Lifshits <vitaly.lifshits@intel.com>
> 
> Add support for new hardware ID's from the I219 series.
> 
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Should i219 be added to the base code README as a supported device family?
If so, I can just add on apply, if no other issues with this set.

/Bruce

>  drivers/net/intel/e1000/base/e1000_api.c     | 32 +++++++++++++++++
>  drivers/net/intel/e1000/base/e1000_hw.h      | 36 +++++++++++++++++---
>  drivers/net/intel/e1000/base/e1000_ich8lan.c | 21 ++++++++++++
>  drivers/net/intel/e1000/em_ethdev.c          | 28 ++++++++++++++-
>  4 files changed, 112 insertions(+), 5 deletions(-)
> 
