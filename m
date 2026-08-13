Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBC9C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 14:30:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 708B5402AC;
	Thu, 13 Aug 2026 16:30:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 369B240298
 for <dev@dpdk.org>; Thu, 13 Aug 2026 16:30:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786631415; x=1818167415;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kAtGBCeqbzGC3OJXxkYgks0Fhwm5mr3PYVaJbPQTtrA=;
 b=JqQat5jIHSDt/aixC1DhuUa2QDpcr1JWP1LzGLJW2sMvzpswbNCEnV4c
 coydtybmu0W0+T98ehnNF1xjHCTZ7pR9aEE1xF/w2PPPGP16BWKceAWpN
 6vMI3CSJeuI54oMKXvlPy95DSShUwkfwrZRcH8yj5xHgTxv9o9ROGEVOX
 SuPWyPbwhRbpQdhkLBmptUp+I0Z9x4is6gly3WxEdgAvM+BmUgSeNgptv
 h+e3nVEL/znhufpUNrwhPV9Qa+lI5aGks+0JvEev9osw2sFyWtkeLjPSW
 4qcNrWbGlLan4Md37v/CZ1KoNEx3imFF+DLoSRp50vQD0AMghKubQ/w8V A==;
X-CSE-ConnectionGUID: YwDL97VaSQO5/sXSlN+PXw==
X-CSE-MsgGUID: R6FLKjb2QpqLu0ud9VBSow==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87087688"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87087688"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 07:30:10 -0700
X-CSE-ConnectionGUID: F8Fa9wu9TEeNpcIE3MG0ng==
X-CSE-MsgGUID: WeVd+R7fSKSdkn/xo6xf8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="302211167"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 07:30:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 07:30:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 07:30:05 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 07:30:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ec4N7fdyCcpkGNq9kmkE/OCmdS/AQ4J9PFwJxKrN5t1JGw23L0/ejYrX/4NsCgX1g2pyidT5MX4/GvJFrr8JzVMgSx+QnW+yUwTkfWUyiXpAyGRhhzL27V0mLzixbsgtcm71/VhcU1u+kmoz38V5eFudSP6Hwqc4ksaeQAJgOz9lWP8/qKmjgYXBrX8DMJmHIiDvkc9NzwvSRFauEZug8zcZhSdkZjQHhK9HD4E0+V4mMNMinsIL4ThFPpPbTsLc7orD/QPTOucajAQbhkseBVV4GI6C4Fpfnq61TYD8G5rmjC4bGo+KMdVY+aG1DAL0P8fko3inla0sUx8tNLqpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WQpwk1AolCXilNBVQMMetW9hxtzGkprFlSkQJF+oho=;
 b=EuYcceBqZamlreVVWEp9bMy4gbCOSixndgsqytsqLVRZBTZkcv5CEtb6v2FPn6IdL61SjmcONT5oEqNh0cmVnL8jzy9dAGvvZSQ/atj2oHopeAgMuaJEnFa/D1xnulEnlCYVNapPJqvXbuVe7KEjkLiEGfcUdG3y9ahQAAlAnaEklLGkmL9B37bULHl+jdMICsYvxsgqz0uoFaVDkGJu+XNdj28iu+eU/rneq+0x9UKfsJ9+AAHCrvqI1XTG3aOKz/XGiSYkeWBNjaeLJC9Qn5rdRMytqW7le05NoyA3CZt54wvD20bp43ZB+ycG+LG8egzWTnWb2YLPnoXmNXD7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH8PR11MB6903.namprd11.prod.outlook.com (2603:10b6:510:228::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 14:30:02 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 14:30:01 +0000
Date: Thu, 13 Aug 2026 15:29:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH 2/2] net/ixgbe: replace memcpy with structure assignment
Message-ID: <an3U5FqHhtct6F-K@bricha3-mobl1.ger.corp.intel.com>
References: <20260728143800.148509-1-stephen@networkplumber.org>
 <20260728143800.148509-2-stephen@networkplumber.org>
 <an2xbeQC3Plf_uMm@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <an2xbeQC3Plf_uMm@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0249.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::14) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH8PR11MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c12da6d-e74e-4867-04bf-08def9475c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: C615WkQvdUwnn9nn6lKdA0R9HeLLmC+IKfU9ukTYjAHxkB7jAnrMYrrdNWLqBNjsXzpX0oWQ62z3Nsxjt5GlcvfakWFbLyHJ7v1tjgQ2uQpYIeDmFv49HIj6/dcWITgFut3qkvYMwRwK59HKZLGFtep0f7VchzBvIQYNeLv4dEsQEfncjNI2Se4eka7qHhTl/VcFgAff+0TmX/0cVEZiSDuvrUVi5XsI3WKoIL7duawAP9W1hhR2W/vGQaqxfKDE/cisnRxhn03Iqdq8F1WsEB6+kUmROx+zPeR+01lwdtJ8tc6DkbMnP7oWF+WBUo32VQeBv8jFVRJaFtSv6xaAHcnvdwT3LfAZkAnRQ9nazq5GdbEcll6eHFpPE8dU/sDeYv4caSRt3SM2yJTC+yHyXvlkOaafsUMSusz2oF7gpXZUbVnN1hlGiYB5eScQvMn5myTPIOZie711Xa2AMHoNvaXO9RSL4NYigoGDP3DarPQZKkxY0gNOQyGvVCo9jrXjm1nwYHufOS0WDyYo25W/nvXwqPV026xuhFnkT11YTmx0U6cti7/mZu956Kuwe/onLfc8BGu2uebtVgIK0adHXGrodJZM/w7laNGaaMTb99w/OZBtk1oE8iSLucd+aoQ8CQH1frZjTsjNg12hmzb9ABiS/Inhygf3aX7S/Gp2Gdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qvQhGo+AgLtvm9YMUQo4op+KOw5E6N8HDSwnoRpj/oAUA1mFjV53Iw2wqYpH?=
 =?us-ascii?Q?qUaQb78K2i1eg1aXv25KyX2k71a2AgzlxDqEmZu8U91nXOldH+2CIV6lGnda?=
 =?us-ascii?Q?ZNzYlc0Mlc2PR75p13oZTt8Lb9EjUo5jKrNRYAtcf1Ck3veNvTATl9heBxYg?=
 =?us-ascii?Q?iGPDbuezyxSv6IpSsoNfwXk6BKNghIg8t01fvqrNRd+FQYGbBK43b6qprJjc?=
 =?us-ascii?Q?4PcYtgwuv174W3WqXmpEWmuWjXTwAcBPgZ3n2+LdZ2uO9ld3aznZzCRmOv2x?=
 =?us-ascii?Q?ZzbEYeaG4/HTuCMwO3OrREeNAw4C0iM7+HJQSCoBwFSTF7HVwNZwUQB3lnrP?=
 =?us-ascii?Q?36ADzUcVOycd3TrygrQCybLtT9ZHwL8XiI9TJcOBN9ZhQMVW1zuEb6uhmo3g?=
 =?us-ascii?Q?ohEsylCJe3hWrzoPRFrf79ZIJrFNfEmUK0GwMi4GHrc4coYc/SV2tBwbtt+r?=
 =?us-ascii?Q?xk9CNZVZom3OGnR0IE+WU/+hfOGS04+Bc11Znpt0IllXxHJ0DsnKzIGyMRdI?=
 =?us-ascii?Q?79e0iilUhk8G+n+8Vlg4pza9V9p5tY00KVy+z9Lf5sJNtsc5SVW8El2w8NUg?=
 =?us-ascii?Q?ydqaVJu+SU7/aEe6YRc7KUpRZ5HYj7vAygdXJcOrZk0KMqO6CUG+EO389eo8?=
 =?us-ascii?Q?yvitx7teW55zqU1upjZOqBPVDGgm9r9XVdKIXOrZ4cgpNIVF/gx0a8pXKrjo?=
 =?us-ascii?Q?MiU1ChZfXBECGWmQ7BTNB2XR8ljY1mI6HuEwjnd40bbmvtM7GhSPaKOmn6HJ?=
 =?us-ascii?Q?QfkW9ikJvVRJCU2wDLbYgeA6c1i/P2+sNaJ3Ffe+yHYtC9kEKR77RCrjYj0P?=
 =?us-ascii?Q?21wqsGBBAC+kJN3pUWQLSlRjRax+2rgMybGB3dFs8OnUW9UGTld2+z0OubK2?=
 =?us-ascii?Q?XqpyBdtmc6D5t20C22umirha+zYwQHZiZ+P1o5IUrGw51cAtiEs94pjukN9e?=
 =?us-ascii?Q?rtjnC3NJLA7dHDVBYgIUsTq/8ZFY3uywiygxYfPBxe8mU8wSdZLbBkOFTf6w?=
 =?us-ascii?Q?86trIMP3Ht1OfRZKtOgvLKzl+JFwOGt9xOLO/GcDxzhQFZT3eSJX9UiyTsAx?=
 =?us-ascii?Q?JWcnYwRcOfqylOa0noyig1qaHuQYua5h7cR3n49EvIhvaDkH0mMF8/SQaWAw?=
 =?us-ascii?Q?bDj9/tA/eGI3udRwIztcuTNKNPih5++sIABnt16F4AoMBta5s/rhfU3obF6f?=
 =?us-ascii?Q?OPW/qoiTNb+zJJ/Eg2ntlEP9VZJ5PuvfNseMrwzCBDx+ZQK9eIK0Q+pjE4cd?=
 =?us-ascii?Q?LDn44z9P8ikNLC5nRe9zkASVFIXN9Q6cIT+Mtpf/jtc3PbTqJx1dgyo8QOFn?=
 =?us-ascii?Q?6Jit0aILOmWQFBU2ItejC5F3tufoU4Fy/XHJXFAuXaltvqrdjBn6mSVtdm1Y?=
 =?us-ascii?Q?F5a7+L0vRYNhAhOUEaB/EQ0GAHv3iaqAWCXb2jE4wk9zwWjrkagGcq/DepPt?=
 =?us-ascii?Q?IhcTOk87X7eu1IMYiw77M1+5IqlY9tnDW92HI66WkbNmJyJeGlgXsvme+mB6?=
 =?us-ascii?Q?b99MzH259eg1vBfXdgFOGbKSeozwHxu47yaCaQrFa0KIoz2t7CvUG/QQWasW?=
 =?us-ascii?Q?yfYgKib69JTlirvbOcRBMLyRunxsRNmxd75sfNVNtoMhj80of96D19b7Y/5Y?=
 =?us-ascii?Q?1zU6yY22dgLvbU2kjfgUaYYq41ZjBK4ksYDbmN9kHYXVDL8oMtWeWZgift/l?=
 =?us-ascii?Q?1QgsRpckSm5qqpsV1MxgutZEL3DJWk+n+8LVwO5J9uO2UNMjPYhrSvooenzL?=
 =?us-ascii?Q?q1NlFRXrXlV/87ie7H62w094YAuhUxk=3D?=
X-Exchange-RoutingPolicyChecked: qKBePOsLshnIa3JjUVKO/fw3wBzdn+c9DrKE8GKmyi+P2pGN8vZBOKy1avTISfwvVNQPVOOtbo/VSnoXawBa8NpNw0c1N3n3V0+B3ocW0p2s9OSPvUtJ8gP3k1rpIeUXf373H+sf7ItfhlOxUv3IJ/GafTZ+c6LOzxJGq/U7aghgTCQcEBiiZPdCSAKY7Sz64Y7jg4fm+rOnz/AElBszW3MLKBtzqABqqiIHs9jHZktVRqSA91GSQax+cAPEw7kgl2b04cGf8XePWOz7aRQfUr0iis0pB9zx7pCkNdGXbU4qTdavR3efXVT18SWFEoWpC61w/j5oR0nnn7NacTQ++A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c12da6d-e74e-4867-04bf-08def9475c24
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 14:30:01.8659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwtmKmn2pjHLbYMq1UcZdpKbzTiLsBU99Vkst2R0ItM4XLDeJBJyHJSAdX2R/85ehI3NVXqPDG+8cpSq0QL4prRTR4D0dKpxNOfBRGiv1kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6903
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

On Thu, Aug 13, 2026 at 12:58:37PM +0100, Bruce Richardson wrote:
> On Tue, Jul 28, 2026 at 07:38:00AM -0700, Stephen Hemminger wrote:
> > Where possible use structure assignment instead of memcpy
> > to preserve type checking. Found by cocci/struct-assign.cocci.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  drivers/net/intel/ixgbe/ixgbe_flow.c | 39 +++++++---------------------
> >  1 file changed, 10 insertions(+), 29 deletions(-)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied (this patch only) to next-net-intel.

Thanks,
/Bruce
