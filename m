Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FAACD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:44:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8584340280;
	Fri, 19 Jun 2026 10:44:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id A34BA40279
 for <dev@dpdk.org>; Fri, 19 Jun 2026 10:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781858681; x=1813394681;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=a9JzdNzeAyXnoGHGYzQGjFdrhkhh3rRz4VYMgi/uj+k=;
 b=jjE0a+G5uwGScVplmnsWLLCoNh5vhAEDfVD9uObpka+BSAMR5Kgr4oAP
 fqctT+MvNfskc6UgWi0BFv+qf7rHU5s8UVOxpzKcMtPYP0eHfUOoSxLkQ
 +As4El8JYvFLSRwSzyDSShLnesBH1qazKqqLmQOMYwWbjgMPW3f03qnmE
 jQoxxxmBqRxoVQZIw3eAE8az9ZCs81A/4KoV5mRhy3h9qtyvt7WH26Q8y
 RYO7og9d0c2mAiBhu6BqGCJmeep6feLUOPftbhEhGyPwhksQ21yP4kDsQ
 SGXaSboKfZcdnbkZluKa8Ka2Ibg6nm7rcJd8w/LCJvzFxcSw975oo1zkv w==;
X-CSE-ConnectionGUID: 1UvQwP5vTnaPMziXXu14uA==
X-CSE-MsgGUID: WEjrwGwoTVi3JiMcEzaVjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="105504656"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="105504656"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 01:44:40 -0700
X-CSE-ConnectionGUID: FDmep2flQlO5gvZH3RwEDQ==
X-CSE-MsgGUID: y/EN8VDZQhWgvUydDK6zBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="246241885"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 01:44:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 01:44:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 19 Jun 2026 01:44:39 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 01:44:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvU9kpGlaRIDfFZzc1Z1d70WFeuE+2wp/Yb22fTk2DNW4lw14hyzkQoh3zOoYKW5EcOlUXfZoJSvrbgU9sYerhdvu3xExBG3C6tx/wfnDZDw2ARscgxq6KN6iL+nlUOvozrVVdPP+bh1mLlHb2dLoQJtmG9AurQZMW3M/q4iKtB3b4aGWWOC0HXCEo8MwEPmxlx1SXfH//slXVVxx6cqKWG2HoMp9GpYmSd8L2EFhSbRutV8+ClmntRXvEqBhZczPlNAR5+eQi5qUn/hjBVGmUlBqKOyZS5cQbfwDamx4AJK4MwQ8ovPp1QL/Se91TYs5SEl3LNPKdnddnZKSV5Y5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwMwTgDx1HFEvzw2hpbXfRZaHaLBV9eHkbCr8uPKONs=;
 b=uBlIpJH1k6Wr2fr86mw6XOmDLWDCmk8ZvRpJPzj3imCUE4Phl3VOfJleByEsFpga3dej74wDSs5RuTKv5ooFcjVCowbuK1ihbFgqQ6EYvkP1r8+SSr7+1rqduqbgb2O6ipWPc1mOwUjVzQDdp3XeNVo/TN4MXx34ZqcLuNicZzp6Sacf9V43SzQDtJ0vScGenRj/aAMz8W4QuJHtSMCZ+WfU1jKAjAa1HElLASwdUdglLRk9PYR9OjNsiFXMw/OdyCJAjvJqy0mvh+uFo08UeQ7NRH4G44I0gvcBvrOEQhFvBc4pYm8NRii2lCrGu2AOfJ3DhpWBP7uxe+g3kkOAYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 08:44:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 08:44:35 +0000
Date: Fri, 19 Jun 2026 09:44:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 1/1] net/i40e: do not reject RSS types parameter
Message-ID: <ajUBbrHVQ87V0xBt@bricha3-mobl1.ger.corp.intel.com>
References: <7f6f11fb07bc550784335123af6a270cd514f7d7.1781692817.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7f6f11fb07bc550784335123af6a270cd514f7d7.1781692817.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0056.eurprd04.prod.outlook.com
 (2603:10a6:10:234::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV4PR11MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3b740d-aa3f-45d6-69f8-08decddefd65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: ovtc3O6cgTN1nNelBR+oKecI4zvZAtm9K2lTWeQYFE4GvmOrdPy90EuKoVkDMn0RW/F9ncuBKNKFPsBwb/166QVrBNGFMfAPj21mX/35XtIxCPWr4culNBASYu5TgVoc+6BWTZ/ax50r+9UqTNfbzrMWx7RWed55nV5bDWps91yIqWn+NpDNBQqXYO7X9CBo5UgGyp8VS9WWv5p7j6KBApYVTqI3LGYVTR01dOgPGlzyWuxrlluauPSQFxByMNpNWOPZ7qO/QCEi7NQieZXkx6gtZYg4YaYUkMoCNjLO73UMgxLSqtuQ290H+z8q/ZqiEf17i5j3uSwuZoEx23jtMQmOldEZPLItDxpsObZl4iro84CJ/L4F7AStnguhxuK2kPYsmtd3KBXdUGkwfnJpp8hKbYcXB5r+d4lhhOWF3FOyM9t1eh/4L9N5pceN4pV7N9ohX16nXIBIf8QB8NYMM6eD7fIDDmsyoec6LX8y/PfcDs2mt9XhLAWiXG+yaJJ+Bt+1E22C6agADNbSPFj1qsaA0qybso027uQ+8vpi+LbybHqsAn7R8glcOc2TK9U+MAnvt4qCgZDOF9C2r/ZwSKH2mCy57WX19fi6rw/Q9vAehXuKRnMKgnKJ7bXcDqWRFt/2OK74BF4ryJVvRG/wsoZ0GbKGQaTFpbCCet/aMqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7sZ4Tm7vz7YP3w0Ne5ISBfpMgrHJJQj/rEgsQ3E4tVYhUqdik1doF/jrPzWq?=
 =?us-ascii?Q?ZotnnaiYCOTlQeN8e80keP9taHNLLQem8EYcioSfphmQKfzfd87qUe1IduMN?=
 =?us-ascii?Q?EVqpIhT5bk2+rQLPO8Xx6hlhmkKPJi8iou5QYKXypDmJe7CXCrj8W2GhaOw0?=
 =?us-ascii?Q?prqtE3RerJlaHIDLS5ZF1ZamByWKk7erb1IAESy5GElXDQ+kllExK5k4ePYi?=
 =?us-ascii?Q?fwx0PXd9MeqjWfUgtMDUTMM1ryAV/7W3ZkhYSYSAIertnzxjbT93kA3ZwWIP?=
 =?us-ascii?Q?Qsl5gMiTEc3HScWRWH2wz9I2/856MKC3R99idNid1t+MIuO+x8gNxrX+FZ5W?=
 =?us-ascii?Q?VllQg4pxov7a8KBxymBepolX/OcsWKoEhSNh6f2cbccfx2jm7my1lJ/qNsTs?=
 =?us-ascii?Q?6d/n2Xkg57rbTtnj6Lc7RKkxgAnCaAtUq5XR0aSpsGX5Ze6ugAzI8MkuHePF?=
 =?us-ascii?Q?4wze1vn/dDLgGdTVQ4+OPp/pxujN6hSTcst3XPiWuMLtdWYxnj7N367y72V9?=
 =?us-ascii?Q?ONpYaKv8f+03PS5Az4Oh/5LvAhw3zsZZqK++6a+W9SRe6vqcdwtg8F3uck9P?=
 =?us-ascii?Q?qU5yaLoc+BBrk8KzBE4cJqVdxDs1ZheyLY8GmGzmvYujyQnIBCe4TS3SqvaG?=
 =?us-ascii?Q?9LRrjgH7KP4NEUObfOHsuhvHsXmSRpxFnV2gjTaU3VJzbEsxfQmkYBvF6ufb?=
 =?us-ascii?Q?tJnnVEf/6pO4ZGbyJcGzHeadLSeCeeK3Vs8RewWxL5Vd5bq38Zg4yhzuNU5Z?=
 =?us-ascii?Q?FkiwKunl15ca3hA+AIczJ/N+kYrzHgQnpvSeZjA4/DAua+FMb3qrPTAGZWue?=
 =?us-ascii?Q?9spEcfg2eD1QYNmkfBxr3KlqTjCRM/nR5njvQK/+Lw5O1wC546Ygf+QckA4o?=
 =?us-ascii?Q?s3Fb4Xir6Kv7R+wsSYryt2r3s0ZfIKA44MavtPGZ2YYdcuwvtxpBk1yjDQjq?=
 =?us-ascii?Q?RvERrFUCquU6jWn3Q1Z7sUVvRwlFtcPlfDuZeJwloFXrk9AmQVGpPn8MUiuv?=
 =?us-ascii?Q?HO9hx/Tgm8crTAIsONmaFJFg5N2DcOnjMAv/BXxDt13nUMBgm1QfBgMfoBK1?=
 =?us-ascii?Q?Wr3y9fNLoUEpx9RZbb8j8qVR9i+75oIgPKMVNEEEEI+KEBbj81SsOJEsamkt?=
 =?us-ascii?Q?pUBPhZ/VCNvFiqW16Wy3JUWHfmKx8ZEb5d92dxMQKUZ52roaIC2L3CExgVh+?=
 =?us-ascii?Q?CYxS4cIvxjRrYj3ySz9BbVr4hrDsdON2RzgqGFpzcOrbdm0v9nvUs7guDIL8?=
 =?us-ascii?Q?P+6yZHclbxMT25kQ1HM68Nw2bjuLhhIeHTNWkI1MRXlNUzs87yGvh4Dt0gaC?=
 =?us-ascii?Q?p0AUzltqejLLVOittg9fyQ/X1oOyVobm030tvP+vh7z9lH+/gWf+fYRADSZG?=
 =?us-ascii?Q?peaGSr5JQcvslgrtQhoym8HmL2AJIJPyKBuOiz6rjywOzaAke+7rtd4A/Ytz?=
 =?us-ascii?Q?yAhW7PwKbfPDOTMbM61jRrEDb7mZ5D9X+NswunoFgDpcl8II+zWGswd/bMr+?=
 =?us-ascii?Q?SR1Dct9t4H/nM/1rfUe9fjJAajrtK0e27SWKCWmjYqb25MzFGA0k1qoPFl/8?=
 =?us-ascii?Q?i1avoa/ZpSEd/1XU0NzwMwfwvjuqC6gS4DCwHpeJr1uNTuoHo8IJSMYyuooo?=
 =?us-ascii?Q?wBwjU+ZoqKAc5fjpFS9UWpUdbBxPNmxLksZz9+fG93cZkiKXHZSHcArRqVAo?=
 =?us-ascii?Q?etG0wAdE9JtZunNyGgXgNjhtjTJIjZ1vcedCC/v0h/LKm3BL1GNxpZzBC+ov?=
 =?us-ascii?Q?5f8OdOolNn8at0qmRM6gLoQKxuZoHi4=3D?=
X-Exchange-RoutingPolicyChecked: JW/+XltvzYfZxCfww/3amJnSNAIA0qkJRoS0A9K+WYlB4fbNW4qlBgMAzjO2jJvrGa2miTkdhFneMCbTHf98xNM3N1jYr5xT4g2+3KyU1a8JEW+UVGP9MT0aZR7NGrJwnm20IpbQq6tnnOcFk7pdrdbWsk1Wl0hR+1hDhnrZJmPDgl9eZe7ErapsiBFrbf8T1ZyVxy0LvI8qYiJ+PbPEpP8USdnRSxEFkgzF7sCSD/aRpwPcvEK38CtgPxEPg6QX0G93vUr/pV1NzED7U4jRQ/+Q4TVwGGLOUPSkb9JEVmcaxRXuXKhkeAmCKnp8uERwbSOrIPkLG6m1AV8m+QrZxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3b740d-aa3f-45d6-69f8-08decddefd65
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 08:44:35.3905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbcQE966AYlEEIvMLA4Fb3wekuD3vLSuQw5Mi34gawYJ4S7QXViP5CZWdqACNRn9Dhj8/6dfpprTzM2jtFFMpNUHeDOYnW7uAdKB5kPj7wM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9491
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

On Wed, Jun 17, 2026 at 11:40:26AM +0100, Anatoly Burakov wrote:
> After the recent refactor, global RSS configuration started rejecting the
> RSS types parameter because it was not used for anything.
> 
> However, because testpmd will specify RSS types by default if omitted from
> the flow command (i.e. `actions rss queues 0 1 end` vs `actions rss queues
> 0 1 end types end`), RSS action based flows that are created without
> mentioning RSS types will still have RSS types as non-zero, causing flow
> creation failures not directly related to the pattern.
> 
> Fix it by printing a warning but allowing spurious RSS types as opposed to
> rejecting it outright.
> 
> Fixes: 0185303c2e24 ("net/i40e: refactor RSS flow parameter checks")
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce

>  drivers/net/intel/i40e/i40e_hash.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_hash.c b/drivers/net/intel/i40e/i40e_hash.c
> index 8b80d0a91c..5a6543a9ec 100644
> --- a/drivers/net/intel/i40e/i40e_hash.c
> +++ b/drivers/net/intel/i40e/i40e_hash.c
> @@ -1089,12 +1089,18 @@ i40e_hash_validate_rss_common(const struct rte_flow_action_rss *rss_act,
>  				"Symmetric hash function not supported without specific patterns");
>  	}
>  
> -	/* hash types are not supported for global RSS configuration */
> -	if (rss_act->types != 0) {
> -		return rte_flow_error_set(error, EINVAL,
> -				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
> -				"RSS types not supported without a pattern");
> -	}
> +	/*
> +	 * When RSS types is not specified in testpmd, it will set up a default
> +	 * RSS types value for the flow. Even though no hash engine part calling
> +	 * this particular function will use RSS types parameter for anything,
> +	 * we cannot reject having it because it is extra effort for testpmd
> +	 * user to avoid specifying it.
> +	 *
> +	 * So, instead, accept types value even though we are not using it for
> +	 * anything, but produce a warning for the user.
> +	 */
> +	if (rss_act->types != 0)
> +		PMD_DRV_LOG(WARNING, "RSS types specified but will not be used");
>  
>  	/* check RSS key length if it is specified */
>  	if (rss_act->key_len != 0 && rss_act->key_len != I40E_RSS_KEY_LEN) {
> -- 
> 2.47.3
> 
