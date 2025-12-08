Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E39BD3B7DD
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 08:59:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CF8140280;
	Mon,  8 Dec 2025 09:59:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 15DEB4003C
 for <dev@dpdk.org>; Mon,  8 Dec 2025 09:59:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765184351; x=1796720351;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=78tsjTWC0jYcIFdtHxNBe78I7sc0IAYdWVcE3cocPIY=;
 b=N9AKuMd3UezRdqXlVDecZmWPy5k9S9NLWKOP6OztGnq7SISQvOPXihL2
 aXbv+5sxLpvASwglfrWqBndzGPVqCE3V1o0EVYqsy+B3PkMfrx9O/nRcr
 4sd8XoxxviRR+tI/4IbnGR8qLLQ4wqYq7Tx7CbP8zeHq+gFJrMiC+RNtg
 mnzuPysInS1RntqdT1E3DmCLHFV97Zx3peYfdimbn0UHKc4lXL3/x2WJt
 lnFaD6m0KIKJ5CA2vveEXKruiIJu578ANWJuzGj543gb2jXK8H59lXN1e
 jk9DRtewren7Jd9mOnV+ikCvYoMs1b6gooHU9oTrFlvqZfvVIZu3h32yH Q==;
X-CSE-ConnectionGUID: 5K3/WXgXTDOUECy1ZvVIyw==
X-CSE-MsgGUID: xIr1ddZgQ+SzKF6KxpY3iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67158256"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="67158256"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 00:59:06 -0800
X-CSE-ConnectionGUID: k3InOZT+SZCvfJQw/lSLFA==
X-CSE-MsgGUID: K9pcwpO+Sn6WqMpEnOnxfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="200062078"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 00:59:07 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 00:59:05 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 8 Dec 2025 00:59:05 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.67)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 00:59:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8nk/RZgN1hpaui7Nambrg+1AlJNMsiL9sgDQcsmUOA3/kYTd8XVIuBVcrD9mSfyu9A47774qDnA9lm0nw1PxvGGt98SzWTcZ8rtN91yPuwUDkwmuSk4/JwAPpotMjGTcnSV+SqjArlIUMMIhqU0W+rPXqTsnFAe+sYI8p0OWAufOYIyqPydbF4hoQPqaiKcwrkOE04BP01tOsrbCaxjChDzphZTj+BDhsOY5j5vRPpI50z86nzQjRWpiznQV4oZn/gVcTpLc/1kIxQvoTBRUNJqMMHMXbb5EG4FblnvVclHmGf8f7wxPQVoxOqBEriozNieJexlxhIuclU4xjSNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+hjVDxG8qrKa7ZeiQyzBVD217DaJPKlW7hxfb6BbJk=;
 b=JK+OC6WQvYtdhjP5QxhI+4lZHjQkCGbaJaZscU//DWEoDkHIRxAhcm2I8NrIdb/a/EnSwshO4razuKf+/MxE9mVCQWALkIJEyJVSRVHfjrMzg0fgsZ2cgWjjBIR1pQWVD7qHtzZuVYhNchPDOrZ7gnGp/2w1Tj7rJsdmFesaK9XPdbrNSBvT57DHHgbjM4Y3kUiKrDg9qDm9SV7GlEDvIW/Dhmg0Q5nYTDVkXy/8UIoUy9hcRU1NcnWDphw1i0R66YiKgptm0L994ZQinanJXIp8UsMe6wnnryYxdn8tZJEQik2VAC71j4Hs2Fkr9GJ/d52BBeUSSyk6YGSNvcxOIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7847.namprd11.prod.outlook.com (2603:10b6:930:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 08:58:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 08:58:59 +0000
Date: Mon, 8 Dec 2025 08:58:53 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 12/16] eal: check tailq length
Message-ID: <aTaTTdBJX9DknImZ@bricha3-mobl1.ger.corp.intel.com>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
 <20251205201537.251131-13-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251205201537.251131-13-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0004.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3e2a81-c6be-4563-9b4f-08de36380660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eQ+OLwUenH6vQ3o0crJNgPFHhhMJ3B1ZBWhu4O/ZLcxVAi2myHb3EtFZ1alX?=
 =?us-ascii?Q?01EGpVTSCvmphg0vIusfvvB1UhuBV7tAkY37mPlCZE7eKD0a83pGwqnPf9bj?=
 =?us-ascii?Q?/X151gc++ieT9JpJKeNMP8WK0GocHlTO2w5PGNGIPi3nCoYZCZcFgfrle6Vx?=
 =?us-ascii?Q?PtKf9/ScBlF96y82E8d11Hn7WyeOtRgjK4pSAHktMOjlGK0mFp+uLzcXDh50?=
 =?us-ascii?Q?28lSo9rQseNCphpmrLpm3fWns15bEppQQyOKvFT0JfdboGT4z55DSocX6dY5?=
 =?us-ascii?Q?NuxJ3Y5gSP6Ezr82KEorbFKgLiqBFELwKtmPIKZMuIQYX2Q+TI+4GjFyxj7Q?=
 =?us-ascii?Q?4t4YcBq+mHKck9LaHKkIqhtMHssy2buGfm8v81KpUDvVDhbSYthI5EHqrGN0?=
 =?us-ascii?Q?WYMn4lFgSyFLZrtDx5xuVKSQXTomN7akCYxF/aDc9sFZsTi4duZ8jMKW/q81?=
 =?us-ascii?Q?tiFb3pxABwsvRQKyeSYR+G9u5CYfUUs2ADX++VcWVZ8NlZfD9xd1VrD2EskK?=
 =?us-ascii?Q?cWSfcDcBUSwWhiDFa40KsjKgdnZzt/KIzKW+lb48939pfYGhvk1vgn4G5nw7?=
 =?us-ascii?Q?WTCLIGCh0CuV/FvpqLBTDMGaxZxz24nnPJFe6BuU3ZGCgpbdbDRn3uRrHGQ1?=
 =?us-ascii?Q?td3Q83dbR8qG99wR3l3JRbADpfV4ADxWq5C26/jNjJQ2sVFWl6HKMonraO8T?=
 =?us-ascii?Q?63Yk4LO5kUywLGkCV5hjGI/LUduWosn53we/UVxg6nCJqsu1XN5zr/zWf4I8?=
 =?us-ascii?Q?TNdL6Fub+JxNG7XXfeuO0krqQdWkWyHUuskfm7vW6Kxnbp33pUZN7hL04i8L?=
 =?us-ascii?Q?9ZJ3aAkfC/zqEOsjkt7M0dtKiPRPedDYMPWTBHbtHzzOAh9ZUuIPtLR5La+B?=
 =?us-ascii?Q?Knc3sCxTnTJzFBBhWHsJI43wJ7Dpk40FCWwQbdwdBXrAjx7aJG/7k2tjfnwA?=
 =?us-ascii?Q?70WFScDWcrqZvfnjM5aA7XjVR/xSt49QxVjWIwpOHUNZEjFP4U2gLDa9yhSy?=
 =?us-ascii?Q?7RIrlGeULIxH5pqR/g+QjwekmWdAz8x+xHWmK2kghvCdO7qTo1q8JB6rkvMr?=
 =?us-ascii?Q?U+TPUuWik7ZCQDHeix27oY8VJbTFWCAvxsee9AbGu4Ug2x/z0vLcEE/UhuhI?=
 =?us-ascii?Q?xPpuNKOKym7e9eptgkOCOjmWtlp10KiiUL+J+s+j6tLOugjEqNZBrl2Qkb8z?=
 =?us-ascii?Q?PbSgvjiVTzbIO5lSDwnhX1GGAeVqau7e10AHBPAcpPZXqoMWAlGKDMYy5whm?=
 =?us-ascii?Q?AqBKjlWgH8MI2wNg8wMn+/tIROm2s2sYt0NiX95QihY0kO5uBooprJa56P8g?=
 =?us-ascii?Q?5TSnsUGpU4vQG1Ydvi/Bs/PFue509c4w1DzuLRye31eTzShEqByC+aHOfNDW?=
 =?us-ascii?Q?J0359clVBZ6L+lqF9l70lztNZG/uvMexTDWrFSshBqndxscgqg4vPTQzKLsC?=
 =?us-ascii?Q?Kjq1I1h+M+lgd8yIRV/nFYhhkFYgN3uP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?65tnnShKgRW+RrSTQRAhzXDv7FcJIQFkCnyPuFFiNyJ91sIOQMgTK0TQo+Ti?=
 =?us-ascii?Q?fc6unvteQduZUdluHf0G06n4Or7Qeqrm/WhDH3WxFYQqgmEpjStArbj1iMva?=
 =?us-ascii?Q?hOD6ukovGhngEe0pivOULnbrT+jl6hbzCj+vn8YMuU5vCvC9wXE8JLLVUGT4?=
 =?us-ascii?Q?TgWcQvxSTYePb9/x8bBYh9GHRmkJUa+KBxC/1DsWC0fcYp4DMISVsm4gCseo?=
 =?us-ascii?Q?aKoFLAYtXaXskDGb+4APPP5zMO+HHKcbovOhjs3cOQlDkF2NXwEFJNiFlmLa?=
 =?us-ascii?Q?fg1sIIYVwQ5BPaJZpnkfEcxBN52WUdF5L2eJ41Z7FVpxghJqPrEJhOztDcRQ?=
 =?us-ascii?Q?e+M1qSFOtyTNKhx7Mw1pi9Q6anCn4P5LPSvDPF7fRylT/mRD3BnmzRf5/x+Z?=
 =?us-ascii?Q?J2ZmgzeHY5vwbndn47HP57omvgO0OvcVT7Gkj6MrsPcEFo5byouy1tjvfVH9?=
 =?us-ascii?Q?x39BoA9N0C4ysTEq6mtmpLXVlhmz9deJ+6tzskFYt5UWDwEGi/4Ui2HmSVMS?=
 =?us-ascii?Q?pd2aCBOHD58MmRzQa3lUO2VaBZLwyhAsW5kqKe7DTpCvIhMQctbTAcRUNb/z?=
 =?us-ascii?Q?/xE51k3y+Jc5ibxkdSS9ZDabWM87yj7au+6VeqV01ZtXfWgibBvc2LiUYdPT?=
 =?us-ascii?Q?qn0Od1yAqeKqwEhMivpYNSkJUoiMkNMC5fqJuqs2QmFBwQL9xeSvkpBh9lAB?=
 =?us-ascii?Q?/oKGg4KBAH8OiufseuoQYr9l7FKPLJR3zY1pA+Okly28zeLlHSUW11IZfKJ9?=
 =?us-ascii?Q?8FjHQZW+nwO4A7SA8bAFkjz8EwaREDr2OCQPksg6DFrOg5RkS2m38GBxN5NP?=
 =?us-ascii?Q?oh5Jj1L+emMNYs3evlkn0c3TxaeCgWGLTAX+QgXceAsamYuTFz7TTYbqqDoR?=
 =?us-ascii?Q?uFbLJ02O2ckUkWp1xDyrxlL8UpdaaLXmDbuJTkZr27Gkx++gdvSAWlknJKUw?=
 =?us-ascii?Q?U6JL3sxSw0R1sPjZ6u9S5rr2mRHGaPSOaB+Hnqa9c6iRMF9kCWQqnzjxyTjJ?=
 =?us-ascii?Q?cZp4Cbm14Ne2nHU2UI8UC2DVVH0EK4M0XjpkwR33Gx5VtKxKRDKC5M+hcKpr?=
 =?us-ascii?Q?pZPuL47CnA0I59Pdyp/JhWfRysupyjJiCEhzBEHLVVCRkjdYZh2PW9ex+B6F?=
 =?us-ascii?Q?HPTU4+fdyNQCiP9LtMzV3yg/bnUBxwBtrZnAkrGEbxfGQWp9L2IHLs5C6lTG?=
 =?us-ascii?Q?6jKOtBqRr9Es8SljEmiRg3jh3+FV0PmwakSRJNo6SagyQArOPpAZM4guD5hQ?=
 =?us-ascii?Q?rgZnuLX8urizYvK8s/HS3SbpBi8kqkrPWTIyRSlbwDG4SQFCAyhiGaDZ398t?=
 =?us-ascii?Q?aQxV/9ycIMxPH49FB04LS9COHXDomcYbCnEiNkEbqUHSMWn6IGsTeTEJFvd/?=
 =?us-ascii?Q?kQXvHzfvQNgrR/ogqBFfvrBsq5vvGUFLWafFZXK4tcBAB4+RMbUcDWhvIlfk?=
 =?us-ascii?Q?3u2t6fHv04fz2OvpEZPj7aiqgha4olplnTjrLyQQL2eJqlzJ/6LAO8sbxGzP?=
 =?us-ascii?Q?I25+FVHGbRrisd7/xagKw7EU4horRGwasKgpt0AhW3CznWfu65WwrePioTR9?=
 =?us-ascii?Q?TT6RoYY7pMxX3xo9dB68vi8TCswsMnIK+HvLbY8Ixolk4sI5eRzGHNlnFnxm?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3e2a81-c6be-4563-9b4f-08de36380660
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 08:58:58.7270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FAxqyWAXejUki+2vLg01SxW3fdd31ymPOvK47JNGZVx9htYi+/Jk95ImTvKBACb9ncAD75SztJ8pDnO3S/JfbdiJ3DvAnxhG/gqS1krUM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7847
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

On Fri, Dec 05, 2025 at 12:11:41PM -0800, Stephen Hemminger wrote:
> The tailq name should not be allowed to exceed limits.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/eal/common/eal_common_tailqs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
