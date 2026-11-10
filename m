Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A6606A333
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MCT8OHfk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AF5240E31;
	Tue, 10 Nov 2026 19:51:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 2990A4026C;
 Tue, 10 Nov 2026 19:51:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794336681; x=1825872681;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0Pm9htzTkDHV5hmTougQ1FUZU3hHMLV3y+Q1JOZMuB4=;
 b=MCT8OHfkg6EOjbVacMFj6otKiqxz/oMhVYXKX9o1tiKuPwBrcSB4TfSa
 ImUp3l1X7e+7pJLuoVxqHyEWvv1c7WfJMfgGdublH3uWZRPw7fIx+zOQ7
 ogGmxHt/duVTi5DOtssgu0OqwVJiCL5bautPh9gI4AKXDLDyTwXzw4nHq
 SNeO0qmYFuUYygCxyxnA641n+8qKVDe8G2b3AOId2jiongwBYDCB5g3y6
 EHKNys3p2g5SDMTukwSRAdzkulSF9uE/3jRSAmfK6Nh8BA+Q1m2zvYu5m
 bynjCgKIljL/zg8x7hCfav0vlqQyEivXHPi0pv66+M7G1IuoX6KATmgIr w==;
X-CSE-ConnectionGUID: EwAqROR8S3SKfK90FqmEiQ==
X-CSE-MsgGUID: 9FYini6bRpisyI4PHMB06A==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2996241"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2996241"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 10:51:19 -0800
X-CSE-ConnectionGUID: AzL2bOCvR7e8D6NayAtM/w==
X-CSE-MsgGUID: 6whzLoYhRUSut6GNsMA56g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8364346"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 10:51:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 10:51:15 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 10:51:15 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 10:51:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jx6enQuiiOjeZLPIp19j33rvMkpl/J/XXI8a9uGQ7747DtwZpuBERPpwZr8PZ0YUnt+gDUoGjwMf2qtAsHaEJvwDN7UecSm03TD5sSmzAxHzDHPKAzITVuHYvWnoi2N0M9OjQrhrK2XC2ccCpRfolMoJxoHfTvxQprCvV3Y+sWJ6YcuWXXimVt2Acyp2X4tUWJSDRdZj8m8ADUigB7cfJv79oC1KjP+NNJ+JNELq5OCjgUUXgoCwIQ0d/Zwf7y3e6wXZ6ND/9x1g1HVGUYjTM2EQJk6pK9HOiYlkMWK8ER0iqgnF/LEfTnIWjd7ynBwK1P4gmq5dlNgLsGR+BFKE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgnUmU6INlO7BvXTgdakkMrGXwLX4eyigVOluLbA140=;
 b=b5Vsi3iyibwANeNYpTuznJGnG0d0DrV1cb17EBskQr0d/UssBy/h3+6Snftw0SuqHpT0enxQOxYI8ieQ91MhakP+8dgTjAXDJOHbdzLw69+AOTV/FmAwOBe/DheCCPkNSltnxBiFkafehL1HurjruqVY1JHeg+3nky3HA03JzgojOALH+cMVWkGTUncY5wKpTYD0LvtpxtS0lnKtJoddIYUJAERTEPCOMdPPTROmBBnPmpdDE3b+xn+gmfWxMHKkltLxsfRUasmF813bGjL5OYEoyuamKbosVCe6+wzCK5sqHNu3YIJLF9JqrpZBppoCbfX0baRleYdVPl8WlSqLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 18:51:07 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 18:51:06 +0000
Date: Tue, 10 Nov 2026 18:51:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Mattias =?iso-8859-1?Q?R=F6nnblom?=
 <mattias.ronnblom@ericsson.com>
Subject: Re: [PATCH 02/18] random: always use getentropy
Message-ID: <avNnlLwnCJWHN-aJ@bricha3-mobl1.ger.corp.intel.com>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
 <20260915192207.3926217-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260915192207.3926217-3-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::9) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA0PR11MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc07f64-13b5-45d3-315b-08df3f5b93e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261009223027099003|10067099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mGCBfwEblI4ZoOEQcTMjNLgjPNrFqDG+Qs89MOU0f5KXi8zPVVJAfgtuZ9xEY7pNt6qSH0yEOQVgZ1QhCMd/ojkp9Jp1f86vaLKVb236TwW2/EfFDESIWkFQIuarhxDoF4ZdsaEt4nlxHAdrX2tjn6VQOq1Me5OCG7oum3FCJMtk11CEi0+aOpsETdtYnL3apXQTyO+vHcp/UyOCsgp8QvOFrmfPKmiyG2NHkl5cne3arsnbn7KJVujTjn4txADrpbTV799o1oyFj7fpxZ+5/XG5dPfLsWQKIKxrtJaXQkcRYeW/4vwUtWf2cA8aFiyI29b/zm7U1BOsMrdfqf/wIVpSVYg+LirL8PuqcTIgos7x/WVVkA4gbdBbnguH5J9nR7ds+iln0t0Iep/9vC7v4+lIuoOorXoHvkg/IwTXyUiZfQZVb6rMKsCUJcqPA5e4bXu9drQt1bMeKDz05l6vv9LHcJNtyJXtEqw0tJt4gysG6gyrRHSGo+esoGCPMTG/Jtqsl0ffd8Npxvnm4zXbVXBpGNCRC1G2PuNpHV3UMzh2i4oNabwX9XaOhfZ89ulvOeCIXj95Uiegw7Qiydf4R27HQWawErnw2ZbkR8Fn+ynxfMZbJ6TbVSxOHzDqv/HHCOtBpCOwS/kA7JDyauWXjpOiKhz6jFwsiAL1mQcBRrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261009223027099003)(10067099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?67xAVk6ch1zhAgcDVKX/nNRA0NWzPKvC1MHRtMRgLrCkjE9ppDxnLpSxvuwR?=
 =?us-ascii?Q?kPyGzIZXP1giQysdRAgIdU3grLxFuc8EslYqBNcxbKMeSWjprI4/RURFzYxG?=
 =?us-ascii?Q?4JXLTE2CcMKGdj6MzbxVxvcZUVxpeYkGcBRnGmkzYW2XdB8CFaJlct60Otk5?=
 =?us-ascii?Q?lgUyquq/FZof4oNrDzcBnflwhyuYEq3bKBDxAFWnnAiEJaIy9ZEuTlXIXew8?=
 =?us-ascii?Q?tdyXY6ykHr5QOlVSmY+peuo/VPCSwtLlYG7JWY1312o9vHX/Df/v8eNkehe9?=
 =?us-ascii?Q?FWyx98bkX0v5fXZ63raXjeQ/RuCIYfFSwOxpjlPMi1L3m8BnHRR2UocVACfs?=
 =?us-ascii?Q?3wxFNJXeNWcXln+FGpv3WGqDKeD3TTgEcWKcufc9SY04BLJKq4fO3Obj/IE8?=
 =?us-ascii?Q?WJyfkKY8Nf1Quol6ZkpRXyIYfm5jHVB9GWe5eBN0OREhyAFTPcN1zPAlv5WR?=
 =?us-ascii?Q?DTn+1UgsyWXGJb7apGqD2S3sLHdr0U8TEE+52J1dV3M/9jIB16A6Q5N2gB1P?=
 =?us-ascii?Q?Ndfx7YF5KgNJGeyEOl/BlWE4IuIYKXyqP0X1K+zQM62cuPXAGIadfhrqGBm+?=
 =?us-ascii?Q?8pY/J8lSB95ls1qnzDbNubVcvhPJbH7hk9sva2/DPKfrlwnYXwYlTZwkX0f7?=
 =?us-ascii?Q?fWsLKS8UHBmtNRFhFHsrYV+orgZyK+mfvF7M9hF+x5gYgl1q4SAI4vn9CGlt?=
 =?us-ascii?Q?EnAzXfbJh1Vf8afxyggNx9eB0u0FqQHCmnlHGPdLdUeTVvHKw+o3DzKvAtXy?=
 =?us-ascii?Q?M4gLrFn/hCXBlMlu138ex2dKx7aMcUb8U6HQL6QTyzovMSkp0sGo7zc+UjhK?=
 =?us-ascii?Q?+7zR/9zVHGNYqGiK1SvPlmGyRUX6M12CSRWneKIDDoK63X/2thVDEcDybpeX?=
 =?us-ascii?Q?SxiWqRlfV+8EfLeAnp56KByBvcqCoDwAILats6v4iANkePGEdKEeL7k2Zfmb?=
 =?us-ascii?Q?lbBnI6yhN+8SMhx23G1wIFIG/YCoIBaS7uOeWqv0+J+ug8wIEU9zQsn5ncOQ?=
 =?us-ascii?Q?IIjtVopNFuS9gb2vB0iWNPzhM6/M2QZvLD7Y1yh2LNJHcI8K2lnsjyNC38o8?=
 =?us-ascii?Q?cba+XFj4HQb7XdlTA3PAlEx7DOKNaJqblcayERoxXgmrn3pEPS2hDNBPkS92?=
 =?us-ascii?Q?O6YYa/lYXBusCu157W7k9TGELMEVTCn0NCvw9BXQYzcZkC+/uba48eE4Kzqu?=
 =?us-ascii?Q?BBsc43MUVKV0seVIPgzz2bCs8/DY8oTqVjpzuiultZoJ1JNlt+zb8hnfCTrL?=
 =?us-ascii?Q?AIMYUkth0483BQJIGEpUNymytJRJCJMgtm/7Xq33AJGeIujN00qjjA+QM+q4?=
 =?us-ascii?Q?fSIhNuLnBylpiIBforsk5HmiG909pl9+YxJtuakCzpTB7RKNumqxiFbFbFxo?=
 =?us-ascii?Q?CIN+CAKmJN1O47PpxQho6K/zXxaUyEoQbDlpabf3i9h475IPUxt9vCxroBDV?=
 =?us-ascii?Q?jXnkyKaLd3dua8XFpM5gWb1EFhXWlrQoV+hFzV1GQUWWoBG35pesd7YgELVS?=
 =?us-ascii?Q?j+I6apB28MhnN37la/xBjaxH895uvJTrfqMmZmHrrP3YPn65bnYdvY0Cn8lr?=
 =?us-ascii?Q?a9Fi1SapS8HuWgouB2+VBbPrbz/dMqdfUWLZIsnOoiyrdv9Xxn6y40TGrftS?=
 =?us-ascii?Q?9GZ//rrQFzf+krYLtALN/u6Q+VODXV6V50RR04/kt2XEnKoby7ZfIMv6NVvQ?=
 =?us-ascii?Q?DyKZ7inn4QLDa1XjRX+8BhdTMU2cidqp/aGNYpqtAJGYv+bKZnRUwlxFxV42?=
 =?us-ascii?Q?utr+sBsFYOLuDZC8dyZamw03OfAqoT4=3D?=
X-Exchange-RoutingPolicyChecked: sHLTti/lRGu5h2svYrqLqxXXL6+cN5z/U+xisECAtL0Gh0Wu87hT5nOviisu7ajUIerJZ3K2BPH1QDgiITHUL69YXI2vZkrmzOgQkmTQCQxRn8HBh+12s5alCXBxbRsxBXEjDZGD1aQIZnYg1Ro7SwAPTQGfnN+whC8j5UwYqfyDBjHpxGsLIMPzhOTj0QBGnd6GN8IcQmnLVVf4lkNcZaIuH7J15tRmK5wE1xbV+2ZuZNzPLa3W3uI99bnoA76IRDy42ll0jEPz8bH9r2Kj3QfMV8Om1CKQKk+4P3jNSqtb5xm4pKobJu3uTrw8TZGqiNQ1REsHRlapdiI6zZpwxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc07f64-13b5-45d3-315b-08df3f5b93e6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:51:06.8551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOaCu4jrVTkVEm2bVVn8u3Rwe2TjkdIdnN20mRlhYOG/7rJcIuhcrZ052p2pA/q+Y+drwzGRjQHe7EhQ76ZzkkS3KTh34D2QIBt8Hes4vYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7378
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 15, 2026 at 12:21:00PM -0700, Stephen Hemminger wrote:
> The cc.has_function() check compiled its test program under strict
> -std=c11, where glibc hides the getentropy() declaration behind
> _DEFAULT_SOURCE. The probe therefore always failed on Linux and
> RTE_LIBEAL_USE_GETENTROPY was never defined, silently falling back
> to RDSEED or TSC for the initial PRNG seed.
> 
> Now that a getentropy() wrapper exists for Windows it can always be
> enabled. Removing the conditional means any future regression is a
> link error rather than a silent downgrade of seed quality.
> 
> Falling back to the TSC now logs at ERR level, including the errno
> from getentropy() so that a blocked syscall can be told apart from
> other failures. A TSC derived seed only varies by process start time,
> which a co-resident attacker can bound.
> 
> This requires glibc >= 2.25, which all supported distributions meet.
> 
> A backport needs the preceding patch which adds the Windows
> getentropy() shim, otherwise the Windows build breaks.
> 
> Bugzilla ID: 2035
> Fixes: faf8fd252785 ("eal: improve entropy for initial PRNG seed")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/rel_notes/release_26_11.rst | 4 ++++
>  lib/eal/common/rte_random.c            | 6 ++++--
>  lib/eal/include/rte_random.h           | 7 ++++---
>  lib/eal/meson.build                    | 3 ---
>  4 files changed, 12 insertions(+), 8 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

