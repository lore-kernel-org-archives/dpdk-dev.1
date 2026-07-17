Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810A4C44516
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:40:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBB8C40E0B;
	Fri, 17 Jul 2026 11:40:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id EA62640270
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:40:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784281209; x=1815817209;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zhPnNmTwL6d+uTFg7cNAFvZiCPT3jjHkNMktSI6+Uz0=;
 b=ZW5pwULu4w9PU7NvDQEDbeXliAiGBAp/bX4uK9T7jHaxhT7OQINHibIP
 dfvz/legdVrWeWAys96SwC19Pj3mUiTJghY4umdEOEkAIyN7c9lTVWQys
 4U8X0JebAL1+v+j2dnkiqETAuz3RHeQRgCnutp+rvwzjOEaMj+DVFP4R1
 EekN+YMbM6s5hxlfo4KjjE/uDqkzynGQdQUdMqJek5Phsc09uYNyGd0xZ
 EW30GL2IMsQNxj+hrSKo852bww08NAgt14OLt8krXwdQJumcyZ47CyzKZ
 DplUE2vXIBW9FkGrGFXBtlGnHI80eWEDwwPFHCLyKKgqXJP0/XIosAQMY g==;
X-CSE-ConnectionGUID: Z3aWD10xTqCIqs7znKRXLQ==
X-CSE-MsgGUID: xOETuW3ET+WVtN/S4r8+Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84728284"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="84728284"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:39:49 -0700
X-CSE-ConnectionGUID: IwYHtZIeQkS/TcZwjlFoBA==
X-CSE-MsgGUID: 17UvD++xT5CjSmQc0OiwKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="253325361"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:39:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 02:39:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 02:39:48 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 02:39:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s60MS2QqawxEVMN1tNKT6jKFeTUFCbZf9RvTaqifNW45p559lQ4w3Dy2R/AQWWmQi5mcSKSzmQtNptMWdd1A3crxUaC28fDE4PapMNNIuyquEwdE5Jwg918UzUTcznxrB6neJ0czL8OQyMuXQM6DWXPEod/HJoCXbET4ZKDYOjqvWh0oOXHU8+ptU9Ab7QI9PZqnbMHsxl44KeePIQtKRm7EMgxgnlH03PEO4wYgHqzXZy94xU9JG/8/UGNqKRGzlwjzTHGEJpThbZM33WXFGXC3diNDv9d4mHtKNSWwJNh+U92Nhd1RVJ6TCAkTuItKIb81C3Ov6L7I5Hv+lEBkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+Gst44ioIXNQsM+mY31snN9Cz1/GH81RNpaOWJCluA=;
 b=bBRdxW+dQd+x9VPinL9765B6LwMwIEaL3xwCtIh1sH6y++uBbmPsrmtJ58dbl++oLPmk3r+CK6ZWkBOACXMjOG6KRWqiYl/Mi8zvjU737ApILTxkKho3Hvk5Vo/vsXUr3vGPqbhigHrLJYMedmFdp3GOEWxTQ8RF8i7/BNCYYYu4fZL/j/tubc7taLTDqwScAzZTGkzMttyqIytXjxC3eyjhAnSQytM3vMTrhp9fBzSiMvoWL198iFU9bMM/8VnRgv0KHEyk3F7K6ba9BOx+1BUWUdxP0rpdVzAwqFZ1ZAwTGBXj1xuFY+v76Ki8FR8W3x77RUQwyxDK2k/pi2aomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CO1PR11MB5025.namprd11.prod.outlook.com (2603:10b6:303:9e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:39:46 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 09:39:46 +0000
Date: Fri, 17 Jul 2026 10:39:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 04/10] test: uninline helper for forking
Message-ID: <aln4XS_06ozs_pZ0@bricha3-mobl1.ger.corp.intel.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260717093006.229370-5-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717093006.229370-5-david.marchand@redhat.com>
X-ClientProxiedBy: DU6P191CA0072.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::25) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CO1PR11MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: 930e7a62-55da-44cb-c4f9-08dee3e75680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sV1vjt1Cu3YR+4a/756LPdfJIVnZ7++8BLf8/quN90eaE+ps2rz5uAl+EOOjgDkW5lcz1U3EnMt9DWMYQMCpWsFPZa/qD0e/1d4jLUBD3qKXoNnMIbfkPwRHb7Te2C6rA+DUDppCun5uOgMbik3wp8iUU/hBtzeOv6FgPjkbklHcO0OKqGY6appHipRCgOv9nkfWY8B0xrOQl1SF40RdWsqZtxYgvNmXfrQ60zepOz034jHe0ajwxK+upsvm+TyUgvG1S2//+FJ2GbqDUo51z54TB78Y1tHkm747BO247xx2/V/VVD5ktuFLMOf6EEXNIa7DfniV17TamCZwPf3f97f9FAKNa5DTHCriNYLZhA86Desb2ATdUNizeGBnSNUUicAb4RL25MPsTDbKLsIkLDqPQleppDIo2E5LMOl6tHClmviORgzfo6r4/b74Tn+MEJY3tPBXwS8BopEk+YkSqgVusP4CJX1n1Ri2S1JQ3w892rjqKqLsLgQr1oarUjPqtzJ7yao+wTA0hh8CACsvf3OET1aUDlKojEbc97X6fVUU8cd8NzmnHDyZarQWXkyIhZIlErqmzjfjGtVb1jOU4krucTIXQlE3v+f6HlL1g6OExZHLU44irWW28aI14flPwasWl8d6RxGc0EsEqlXl4MOLng6S6RABqEXZnYjJmxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+VQqc7XBw8+j0I2Bq538P3CggBE4DPdBoFSh9+Xk8Tm43HE+O0rRGREJw3PV?=
 =?us-ascii?Q?dyNR0H8xgE+EU1aAQdTnIEBnePoHC+pPA53Wyf4NuRrLaldqCFCi6In6bzXa?=
 =?us-ascii?Q?Hh6YaurVKAv1H6k6M6gX0/OB2zhRjIwFkUVg2cEhRUA8yWcZLdXo+9Nb9HY8?=
 =?us-ascii?Q?WsD874D5dJp047CCQTzNMr3hU7b3ExI8sD9xRMt+2sqMIMRTfiDpFuScXdC5?=
 =?us-ascii?Q?45UpX4EexoC1rEvtLxLbYczVLG/8vBj13g4KTq5H2jE2dGaavfc+Ne1YVeAp?=
 =?us-ascii?Q?p/f+Dx0vXNc44lY6v21G/z1YWkSiy80hL4lBbeKaQgdSELUfm+gsmhrPacFh?=
 =?us-ascii?Q?4zmcbEgQedrzi0qSyPITDJ/wfjBg3Vc0F2lpiBGy/Nw3OaWuA6JI2EdJkH5F?=
 =?us-ascii?Q?7uA9ca5jvc5pNMIUfelnLbZMHDBUD7FJARGBiqCr+L8MwJBLYDh+58wBuB5n?=
 =?us-ascii?Q?PTaJCzAYXX7md+Wvg0RuvCdZyOEaAWgckW9iRWrbc4/7Di/+QUOTypHBma5h?=
 =?us-ascii?Q?PKuMRjHKKs4qwCNJn9bGRVN9Op/9K3fIcfUlZo5BE4976X1KtUrZXkXs76hh?=
 =?us-ascii?Q?OqGTyxUd864Xj5kNcD5cfaQKLcLV4oXV8JRlZly8tp1VAtmE7Obp9aBhIWjj?=
 =?us-ascii?Q?wLsmZvQ8mhY6ILOqqc3J6gtgWGYlLFJkIP0DO0h/s88aXS7qna0VBznBHKu3?=
 =?us-ascii?Q?oDoL+ntFrVcjJOtUgJ+tNwbobrpwCn0Xkh0dmh+ztQxeBr/72zhKuXcxmKSB?=
 =?us-ascii?Q?PLu+kg117T0B7xFYcrB9BIneHYQejw+GNKbXj+0WIZhs5FTBcXVdoz7el3QS?=
 =?us-ascii?Q?jCrzzfXTrPFZJAOBatqB9CIa/9/VOFPCGpemsKucMsmDR6uSF8GG5GvUTRuU?=
 =?us-ascii?Q?VdDMLZuVKcnWWSCHENny8d/HuVNEk8GLhuttQw5fR29f3E0JFmd/chJmtNCc?=
 =?us-ascii?Q?HOjYbvpe9eBWOKhfn9JHIvXJQiiBhAYiB9fZIT0lJqNIPGWWMzX+CcyaVXWj?=
 =?us-ascii?Q?5gT/T618XEaAMyT7q8jPwxzddaYvS803FOazO67mAujM/Gfs8JdbVoL1e1pq?=
 =?us-ascii?Q?THvNklpyaGtCIdMdAlHtj+UHcXJWNFI4aqdr8sSLlCyUaR2Tnw8j8W1WW1Ue?=
 =?us-ascii?Q?Lc6vlAobq+5KeIWccSi4TVqd1R84T7KZPqYlmchqcDBIzb6OPkNXJZoduHw1?=
 =?us-ascii?Q?PBGUICUNdzGm+XLICzi/tDL3HTYiOJ3+Q6Ob8ut4sBgOXrEbIN1rPOAp9U9T?=
 =?us-ascii?Q?Sll4n2EBP67rouH1ahSPtqS+B2j74bhsKG4nZRzyYPI5LBVhVTQJG5MkD+Hm?=
 =?us-ascii?Q?bIbhRHllL1EMQtOPeCkb2k9z4yCe1Qubto4CO+c4g0TVQ/aau9XdPUkABuD8?=
 =?us-ascii?Q?jkvBTd44akI93sHuy8cFPB9eePTi6CciPXoDryUdSQKS73UK29PsRzTirzK3?=
 =?us-ascii?Q?rBfytByJq+Fjwi5pkY8bWIZNnQs8BdYnYRgfaZ78vE+bhYPFKQYWCzIJ5vTm?=
 =?us-ascii?Q?KXKMf8/AxdNBm2fNoHO7Fj3U+xjpxYPuKC8txZJKZMiBkIFL1+I6jKdCA7cf?=
 =?us-ascii?Q?d+2P7tKs+IH5oyiKAUXf1IadmBzjHke/FbdgcIxs5Z3uFbryxD7LDgjp5nP9?=
 =?us-ascii?Q?6wLjxTAM/PecUkNZfKIdjGGAaUVx88RbV5tFrGetSkJGHopUWbre/Tb9AJ3c?=
 =?us-ascii?Q?qBuO+rDrCHWA8H2enIfsqGYaTPjh9tCY1UXT3g+fdqUhha1C9hNX+wwW9lWJ?=
 =?us-ascii?Q?PsWsd82ECbXZu/OUqqnx2GbvuOE+5rw=3D?=
X-Exchange-RoutingPolicyChecked: g3Fg8Uqw6LJ+8HlUJkhaacT25O8rnsRsxKb8aB7WcgMrG2fJjlJ5IyQ+Luf48+/AfxQmuz5/B3Li2aumMim/whPPxzLzEEvi3BNRylbQ0mYbBu7e3inG+Gz83ny71/BZ/c3cJwKVMDlsQvHLZbk9Q5JXObR0O2Yi+5LgJpGYMZWWMMvPoYW/mSX1S+VP49+K6+EtkH8L/TAZvKgd94j4YR9MxWTvG+HV4dnXgXkwdbY1FFBzydIt/0slKPr8W8eR7oa1EH8aQXpJMe5gYmTXD0Y3BS4E6j9iyZxX0Jnjk3d7N13GIAsF7x0GXRp1yvyatQco5HOpEUZ3Gydafvf5IA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 930e7a62-55da-44cb-c4f9-08dee3e75680
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:39:46.2164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9RyRJjxDCGQUkr2umKG5evT63FLXB/rTxW1lW2YF3hIeOyV/ju0ZdHqcQ42RXrks4eB6KySiAdf9n6fW5TiXGSfTPEeXsd5u3YDCSzzzek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5025
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

On Fri, Jul 17, 2026 at 11:29:59AM +0200, David Marchand wrote:
> There is no reason to keep those helpers inlined.
> 
> Besides, this code relies on internal API.
> So any consumer of process.h requires internal API.
> 
> Move this code in process.c.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
