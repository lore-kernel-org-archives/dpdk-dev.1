Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C606FFF885A
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 08:00:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBDFB40431;
	Tue, 28 Apr 2026 10:00:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id CD5B9402A3;
 Tue, 28 Apr 2026 10:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777363231; x=1808899231;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hvteMpTg77sogU6onNLRZys/hojo4Gl5yMbtJpEo9lg=;
 b=gXkUwYTTNpxeTv5CFmvKbtxL7Jn9R1PormrJLnDi9FyZkd14RccEIeQB
 EyvA1x3w2N959CPzyG350cHhMH/PeM/aN64O6QKfaq+IL6tMYB6ZYX4ao
 E69UdlI4wUIex1ubpHopk6Fe1I00a216MJgDQ6aOXWWzuIgL49Q8I9jua
 ihBmjMYdWUrd0AwJs9yiPAlO34edK4nhA9aKMPdcYspFM4oqisG96qPT2
 2IKqapQQyxyOMSGBX3oT/fAUCEtdUH1ZE1MI021c41CZI6Ya03m7tzzyu
 +4oA43uMilqKRDAm+Zt9a4X/0myFFrdbUAYHpEDygffc0+JnCMzDhEM50 g==;
X-CSE-ConnectionGUID: UxMoo2zRSPyIZUVR28fHkg==
X-CSE-MsgGUID: Z2urIPruSKWx+nhOdYlN9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77428247"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="77428247"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 01:00:30 -0700
X-CSE-ConnectionGUID: IwgpJp8VT+mLgrolVK7c/w==
X-CSE-MsgGUID: esS45tSuS2KpA1Giu3m0mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="227367109"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 01:00:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 01:00:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 01:00:29 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 01:00:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCl7c7ftQSAuzqAKk4cK1KvAugUfD/7VCCvplyYq+TKMXEbBnDCwZr/ktRVdGPzIb6nHYgwcNiepArsv+nip9bLB2LMkiUs4d75Ngt1PE+XMGh6jrlhAqHe4wZrnqcch7dFlnfFRgIqwyb1/9S5ToDzCuemBHyb3vnj1nhREyJGq98fEJmOCS0MmAAQwfcnhpEg3s7NIuIUmRVLL7b3/GIlmJ6g34VfDq0LP4p/juC5gfE4W2It5wudhW+PfHdAoh7TpSI34VnR5KsjWBtuNfFg28SPFdREiZxx4VWIGqwvgljlEqJhOBeU0srtTBARDjehVIQYBl7H7UMd4sxfzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoXNRy5BKxUSPm+xVff63yYxHXFS0BWPOHn9WF8sj3M=;
 b=Jqwq9OBhVKukcwibyVjiq/Sux+meKuEwA7qThyZXX+hBKglOQPv3cbVdhQOAWsi313YJdeXUnve0kSahSE1Yd2QRD8AidtYRdY6OhHT4HheReqcQxtMpj7X3Z1Qso2YFESwS4QA8qrplJ1nT38Gnb9J5q2EbAMW4gE2PY5CEer/tsWOxUDCNRGiYcYbQ/fNsK6ZsDdHfACmpL6fEHnMPjqPdDpDZBKHf0KHwxuqjYznBfbjruYfAu5ffsWqNLHLa0U3o3kbrbXFiuXuyRiBK87L40v+uHECz9XpKOdc2LeOg9WQdl9lcVCSHOg2Ux9q618xgSRj24M2B6kGRtj709Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8186.namprd11.prod.outlook.com (2603:10b6:610:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 08:00:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 08:00:20 +0000
Date: Tue, 28 Apr 2026 09:00:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Sunyang Wu
 <sunyang.wu@jaguarmicro.com>, Aman Singh <aman.deep.singh@intel.com>,
 "Olivier Matz" <olivier.matz@6wind.com>
Subject: Re: [PATCH] app/test-pmd: terminate process on second signal
Message-ID: <afBpD-ld62myZsVu@bricha3-mobl1.ger.corp.intel.com>
References: <20260427105741.14348-1-sunyang.wu@jaguarmicro.com>
 <20260427172617.295684-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260427172617.295684-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0323.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 90af1a9d-4758-42c6-33eb-08dea4fc31a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: jAiAONxvpjahfeoc6fNr/PlSEluY+gmZ+AQLZFu+ydn6hUznc7ZvqJis9jwXo4JfZ21LHUGXX/c+rcffMfDil+i69mRY8MRsNCXCbMOZFJiCkIJE7+yjCRKn20aIzNNgZeFJ86ICqzt/Iub4adtYIwbZzmSbOtaUvYVd/tzdAVot2ehsQ3uez3o6Au558Xuw4hs0JpP60wNFLYM6d1HZD0GcEruqpr6gSr3ERTiWMP86y68xEf2kwPwxsKzs/ori+cpZokqS7kvMWld8qth2avNXrzsO1QeNwhFiN7eANFHDGkKJqadKQB8IhauoZh1V93lukBoUr4pD2Iwf+Kcd1GQSpOdDXBrUPJS4o7OItTLiLsRI8QWvtvd3dHGvmtmlfdtHVl0OilIv8TMcm2UWc27VDw1yBAq1CXKD82Vbuf2YPKe3tUWULov+vYg7oY0BtUtFWuRjmbIrexuqUUuKiU2XOQr4EiFFggvNzYIVzQzeKMTfepkDkWAnTUGoUIX8k95v/IA3xWTnEn2ZCA5TSwXum9owGL+Ee7FgNzeltspZGg4HO7VvJdt345gvyRVZ5Qy3lWX1MLp7A3OvmuiBNZ49DWHEQegYc0OLRpK6QV6A3Iyug0J/xjEk2cLoNXd0xFv/uJG8TJ2H3sMknh8eaQ8xkRUhqY5CY34brays6/KHlias6CyMv8DU8VV10JqkF3dLen2B3nw0ha3XXk8+4VXJnBlC1SKwgAywpvCMjDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sGrizQLp+tNaz5YBCCuFX9vilD5Q8xSLPjRFYyfpnkjEzfCF+qfpirjBpupH?=
 =?us-ascii?Q?k0OWY1GJ4mnABpgOJwGkDIAUXdiRSeniycRF6XJJwKQ8C7j1y+SLrb/VUzYc?=
 =?us-ascii?Q?7xDEEYT/P9/Mw/6kn2Tk8HiU01teYVNbvGYluB3ksGacxraaASGEqRfFguLy?=
 =?us-ascii?Q?AoG4CHRoOK1nyu4kjEE37ZaSU41S7WdlYu6xMHeXl3MviXBgOevbIwhBR59K?=
 =?us-ascii?Q?jGg+r7Hp7H2kEZ6kqMz3n+8yD876OspzwDZwb4O4TphdnRVf5HK515Oh5X9n?=
 =?us-ascii?Q?zuY03/UBm6DbS4/FxxFEdn0f1jy/D5PV23izF58kh37F8wKXvEg6K/i4857F?=
 =?us-ascii?Q?Qx305jkvRHLBa3/dt+Omlk62XZ6ZR/90IgMFhm/pW3ixhtG0pYnAYpKPRksl?=
 =?us-ascii?Q?t+ZLiaMQ5Gf8CbUBGIqaMD7mFtRxokYekra+EKbzothx5yCQqM1nO1vQsGOD?=
 =?us-ascii?Q?cIuVklfBkkPDjeUklHXXpuCLJiT54R1CY2VZD3T/IhWULYXMty3Xxjzim7BX?=
 =?us-ascii?Q?BlmHXyPbJ8i5UcykM+3p6RejsAsu0G2A31i9qQ//L/jhV2ppfSwdY6+wg+1s?=
 =?us-ascii?Q?N/pgRxvkLQWmpROgml1PllM+W6Uktnt7b1/Vc5DCFBOYZHnPgKX5D/bddADd?=
 =?us-ascii?Q?wAoPk4+2ifomGxmkt3c3l1Rpe3L05b/k5Z6k0ktMTVnQi35ThdAxHRGAJrJ0?=
 =?us-ascii?Q?rCOTyLa+V2fqwunRdkvUGvCsBq4gDFuCieyKCczMq8hUlsZ+3aMsa3fVvqbM?=
 =?us-ascii?Q?c++rboJtqKKr4BNjU9Qn4vuh1RGZr7ik5h8uiTAymsoJiz5yzwo+2aQTGl01?=
 =?us-ascii?Q?J+wfe6JaoLxxN2kx5f4nafKN00mDb6/X3+e6pB2ISc953uHcoUgjlq+hmaBX?=
 =?us-ascii?Q?+Cf9YdnHgBLquSOKkAeMHw240JQ8x5CGXErhJTe1mOqDxwg+7XsRp32Aj36F?=
 =?us-ascii?Q?madfG8OBtxaNShTC+tUUyNYpx+o1/XU5pgr/UcgickA0WfWUuNzunD6mtHE0?=
 =?us-ascii?Q?uDq4mi+PSyBxbX0hG3Wsv2TtJthHDj4SI+DKxk91SZP8btyVwVpttlsq/NRX?=
 =?us-ascii?Q?yv+7wKzYipLy1t3Ry5jZZ+d0DajdFTP50qCJ67xpG2JZxD+TSDBRaYSI+mdN?=
 =?us-ascii?Q?XXEa84H+5DAKdV3WTQtnly8yEQ+bqR57V5XJJcgqORDM16BYSQIjs6WlNV7l?=
 =?us-ascii?Q?+omwEwmjUDbA9X4sd3g7cggDECZ91TR684mhX1ne+bKlAe8PMEmhcYzEsVWr?=
 =?us-ascii?Q?3FG1a2Kwk3Vc3w/6x9CuyLu5uZdn3OY5dYiUQPkUEMYnN7+N/T+6sv8y+Ham?=
 =?us-ascii?Q?JVnoYUhm8xhdRR5NXfO1zBzDdypazQ567BXR2IkMoU7Mppq8aAwpWuhCPI6M?=
 =?us-ascii?Q?JOS8by8wflOWo8208Ft3uaRgSY25Hli5RGRgok/bX3ymAvGN/Sdv85x2gxDh?=
 =?us-ascii?Q?P431fR5599Njj1qw+jt91DBe8aZ6iQjY0uwjd6NuWQEAj1EEVlXyNBZ5Wi4e?=
 =?us-ascii?Q?flbZ8EkHeeKZH2O3cqOp/kC8izXBHc2VABuFYkCJnq63m5+HtZQB0jWcnmA8?=
 =?us-ascii?Q?4KOVqUEH/xhpmCKsYfMbs3HwvXeh+hZy0485nnM/qGmY0mbIfgIim9kC65xM?=
 =?us-ascii?Q?+/kvBccC6fn+udtMeG6ypigZ9pt3vgg1LKMs1k16yIXTEkV8CHzt0vMUWERQ?=
 =?us-ascii?Q?j/C5SemeFFnDls0yRF/rnKQoE9jIV1lVp0Tq+DJM6E6tFdnfnpkKKAz8tSHm?=
 =?us-ascii?Q?T0AFf5PgCebh+8mXj5GE+8XYbV3icoU=3D?=
X-Exchange-RoutingPolicyChecked: anLwZEG0IzR4E7NSA/KQcooCVZUAKhLQOZR/xeZL5FdfldrrCeMpvo44O3HZUaY+W1f25w82I4ndB6wM2V3VDAppsLAxq+xcRh5G58ElPTtSj6V3gTrMCS20fphKZ4oVzMVnP8Cbq6ptQC6ND1q7LHsezjjhOHWWwJFkcBC9W6CutdCs7gBiGMqv8B2RSpCeybyEHPS7fUauqic4fXF2WA8sgNqPCqcV3jgc83ilHvWGgmwOEVZJQgDUu56nLuPphRh45APtOmRNJ2nFixP6I7qs2U1/cONsQ85eoV3sEjyJplahgbvLbBFM030kqt2LuNRjnQXHgKQpSyyNt8hhng==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90af1a9d-4758-42c6-33eb-08dea4fc31a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:00:20.6869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7SydN2d6rMMDqGB3mOBiZ7EO35pUoKvSmUtYn8YPWt+pw5m7cM9kLVhRELfhjqXUKMkXnEnr1bTsr9WZfAH+S+CKe3yTxTVMnR6/dGmJZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8186
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

On Mon, Apr 27, 2026 at 10:26:17AM -0700, Stephen Hemminger wrote:
> The SIGINT/SIGTERM handler starts a graceful shutdown via
> prompt_exit(), after which prompt() frees the cmdline object with
> cmdline_stdin_exit(). A second signal delivered during or after
> that free re-enters prompt_exit() and dereferences testpmd_cl,
> producing a use-after-free.
> 
> Set SA_RESETHAND so the second signal terminates the process via
> SIG_DFL instead of re-running the shutdown path. On Windows the
> C runtime's signal() already resets the disposition after delivery,
> so behavior is consistent without an #ifdef.
> 
> Fixes: f1d0993e034e ("app/testpmd: fix interactive mode on Windows")
> Cc: stable@dpdk.org
> Reported-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test-pmd/testpmd.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
