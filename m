Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B151125847
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 15:21:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD9A74060A;
	Wed, 11 Mar 2026 16:21:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id BDAD2402E7;
 Wed, 11 Mar 2026 16:21:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773242510; x=1804778510;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Vf1V7Xyj0cgvxQKouxb9WJtbLW24uU+LUZZ6pZVWSPU=;
 b=PuSM8a86Q+fDAnwq2BU40nTaJHAqOFyH8VqHx8t5Ci6a0mjrF+e4gCAN
 9Yke4G6gGOOO0utZTsTFMGO7jshkjJWBo8WfIBbDH5chP1Litysa4v8sp
 pmLXHu7PFvwm9RF0s2TF2e3FIUAwKwMwTq6fjv24Jvb0HSvgqBrSMMVYx
 6DN53TtwxcaLU+jwGbDIGn+TMgDZRlZaRoQhh/1wrn+thTgmoNbY3/PkR
 3++toBtXH88hVJNmt7yCEDZC2q2uT3oH1I7HgsscHc3XggGcRfkweacbY
 RPa6DhHVAUEeEV+tYEiMxE4zKGpXYy8BeTeiOFu2tE4Z/JIlrk/FfooHc A==;
X-CSE-ConnectionGUID: OqRKDyISS8+xz/VpK77wQQ==
X-CSE-MsgGUID: wBaotoV6Tgezv0HzDIIW9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74191806"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="74191806"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 08:21:47 -0700
X-CSE-ConnectionGUID: pOS1gxWjQBGzHvj4DgYkRg==
X-CSE-MsgGUID: dylH0ofUQiC7sP88cMiqjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="218369300"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 08:21:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 08:21:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 08:21:46 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 08:21:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzbnC93BZdfAvfuwmaaoSjTpCVaIZ41sxSjrzkRpZInSbQNzm6BP1gkKvPE6OMw9iB8L2C19hGsboNbsG4uSebiIG/uBnkhrnUPNqZrBK2SOdOuybnyufQmTT38JWUuSsd3z0g3AUCWAzX2hILl6ncxTwBxYQKDESMGKTB1CJnh7yzGKQtod+tuUprhKf9eoAj8OckXRWBLudkwUKH4JmdvlSAwKVDmKs2hE4UJpisw7mRkBbneQZoRcpfm2q0YJoU5eL3s6Wf8hgkqVLusgw04O4AcKKsrzYhePGC29x3zgfLTX6p6LoCc8rm57WK3OSoFhYarHEJU8FsPss0pFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfcQ9uihquRBGQk4mF7EjnxLmJsCtvaJjtoQxFU2YGY=;
 b=lukD6Z2ajNEgUlQN8WubYOt++qQzUSM4F96hoVkkVPqVr31Z/1MGgy3N3K5DS1rN2Ekb5/FFLb9bVFINUFy2d9h7lZL3LDsy0CsWGM2K1g8Uhj7TsLXeAhWYNNoIKaEKHq/UbGpzNYSXSPtyQB2z2CrfkeyN46P2Lgin2+ht/IJV8bmr7+qLhaX0hvB9hEol4kbs4qAmPYU24EdxZhWwKB+s8s7azuf/kdOz0mWgqybRKjWjxpWccGWxQ8lHaQwVgaG1nH+ofKnt5o/V6aG8OICj33e2+yuqGmV2IdPYGQNF3a9uj1ep3SVcbcPI457RJPbpEOhHE5EiXw5T1O30Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB8032.namprd11.prod.outlook.com (2603:10b6:a03:524::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 15:21:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 15:21:40 +0000
Date: Wed, 11 Mar 2026 15:21:35 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/i40e: validate raw flow items before dereferencing
Message-ID: <abGIf-dWlkxYsrKi@bricha3-mobl1.ger.corp.intel.com>
References: <20260309132802.3094565-1-ciara.loftus@intel.com>
 <20260309152919.3193943-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260309152919.3193943-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DB3PR08CA0036.eurprd08.prod.outlook.com (2603:10a6:8::49)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: 98904fd4-b6bf-453d-dce5-08de7f81e4dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: GdfmgRj2KI0mN62x/FPjwOYIbNy4irpxWYnjHxmBU6A8UCzASLbviPSHegiZNpC2cIhxpX6SvcDf3DqeU6HNduKn8VuocSdDbXQXUTA401LUy0h234tycVDsHT0s3zXXwswxc8WCYnPIbX5yUFjKclBxZHgfReWBGvKZ9j7K6hs0G8ps4wxfjsfpt7AQxuUFhEWTVjseu2V1TjHs25oY76LW00Bbv/yVwzQd7oI0MeAkouiVn9DkLy6c+3+LnkvNvnb0yOQeZiqxTchgs/DySSr3AsQZMnphCtMBFZsodL80+N3QZrpcdum66/juJ48ezT6Ayr2D1+B60eK2HOyeHaqeK0QkgR2O33Iz7sGFwRxS5y1j/uhzdFz3NdLQP7wUZxaU4obsaV0Z2whNuz/xf4eeQx+OiLI5HOLAvstnmuxtvDKZnnDfEFLOzbFUMFVQnpwNkWXEtwR830+vb2PQj0Nqw/Sd13rhsWD1FElLALcGQr5MosHZxAz+JGwa5RzpguTWrS5ttNPxE4N9bPZYNM4JzjeUHtixZfae2gdCeEEHAIffSu4tH/Xz2xnuUJ6314ES2Mi6H4eaYhilc6hrF+c1Fu/Y6xrw43wNXFkX+LsI4Mc2daUpRIvLRSiDhOYXZk8x5a71hHs9OieCRA9WzaDBBsUVZAwSX0fg6zEb/BF/o/d3i5uH1LKb2PS0LflnjKX3Kz5AybAh3g6NqJvgul/ab8zs71ZYogX7IlsrfEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9e5+rKqaNkJRG6b+CJz8bECFTBPYiVTo+9YnnFIgPY35xp94n+8YX8PrUIyD?=
 =?us-ascii?Q?Gatx+P9pIUfPsSXE88L78vSMkID5+y3CyPNrOQdFcpybf84tTmzoad2dQUKb?=
 =?us-ascii?Q?5FSYASzhRwtSbnfUZMFHKFabjgipwt81EQIK7Vzr4AB7wiJ9W8ZZoPbCj+Ek?=
 =?us-ascii?Q?3XBIFpmNIGj02+AJs4zASZmc+iZknjNHVPBegrjcj3SVBrCs0hYX/dBdsl0B?=
 =?us-ascii?Q?OnMOUdDjFAUxggYQ6IAuO63SmC3dn3rYXpg28nKMJ9uj9omksAi4spFxKOw5?=
 =?us-ascii?Q?F2pKaV/xAPoEHjSGcjcdy5RwejfsDGr48LvFvvOP2Ex9aG5eTxjjI8qp7VgR?=
 =?us-ascii?Q?FAJ97QryXJyo7uvHGmnq+nMtilH4ndamfibI8ZvHHLGBqSe9RfloZrp7vo+6?=
 =?us-ascii?Q?NujljhHfGxDehl2tmNINif9D5o6EsUxDIC1SdtDOk4NgX+w6DoSaE7tZTMyk?=
 =?us-ascii?Q?RUx0yaookCzyWYxH+Durbp9fPHLqFbpV0G+td6SpJz+fDofj74Yp8TAdY/QA?=
 =?us-ascii?Q?mFDI3b5vRPcv7nudfXGlr/i3bvZIicUcac4U7xaObed0fTaZV5bjwqc2ZHZn?=
 =?us-ascii?Q?mWRclP8f4CEleCXkDjPyVlfhjla1A/lsAaOpg9Ybkcafu96SuOamKxnzoRo9?=
 =?us-ascii?Q?1MKnTlD/SDnXUSSjwhDIzbap4BCqjjR53u0Uhr4BC/+ftK54293EzuCdQkvv?=
 =?us-ascii?Q?sKdXk3XstOFNMSyo2CDdoY0ogJKF2XQPD76J9VyM/9ri2tlrTYdS0m0r59Iq?=
 =?us-ascii?Q?oZGuGdL+rvpSfDt6YBDdx6EeAEk+9kM8bXKPJSQs168znJHXgC9Z9SLaLJnC?=
 =?us-ascii?Q?azaMBA2czbslRaAAgqAh69Ncn+hp3fyFLpX3YYq8pe6kQ5AlrJUjsx85JG7U?=
 =?us-ascii?Q?xjk16KWNmymYv87sabh9PhFHzloKOKstcoRbeEERvlCLlotDCjKSAuYXia2N?=
 =?us-ascii?Q?n3fxNFyaAqaAIaHFDNUq6lm+rWNFbdIB8hmQLiu66yRQoBspoCxarUDlR1ZG?=
 =?us-ascii?Q?udsDCyPXzpkqIsu7UYBU01yLVDaknjMN6Y3lUAZAmbfZcbqb/kmetG7KJlPN?=
 =?us-ascii?Q?qqI5nkEBGy3yECxhEP460MArrv2z+SPZCCM107YT6x5UWDAyplFuHAMC7DBb?=
 =?us-ascii?Q?qejc9xMa3KHXn2xHqK3J9fXv+KbFz/AUEX5VQVEIHecMY2WFVjSW+MCrLAJM?=
 =?us-ascii?Q?EF23n8aNvbJR1pTDNjNgR6ggdo1Vhm9ibmZ2DOx2HUJxApVyy11X2l582DbY?=
 =?us-ascii?Q?wCO2b+pdWpHWcXVTVh91Sw/tzwpQj4cRqbUVj4DDGZnfvETUSMboVbuSB30C?=
 =?us-ascii?Q?ZnH5lmoar8x+a0s2UIhxLoA5/zGIe7YqTkiaE+smLv4yRawHuP0K7qIJEISi?=
 =?us-ascii?Q?SF08qYU/9+tbmosYi+hYDFmR63iJXrdJ1wD2Vx95uwbtcM59PY2MvDD6qt04?=
 =?us-ascii?Q?6M1XWP4otOeAqM3QmZqz2dinUlV0dvBQj9iB2D4ayGHSiR8tDHmdln6SLMY1?=
 =?us-ascii?Q?UD7Rp4u8xtAKJWZnKLOAM1VFTpirlsctEkm/DmWWJN2q5TMEN4Ym/kRI/G+5?=
 =?us-ascii?Q?XU3LbJqHAU/q61nvMx55Do6TXLb3SqfPCzP/gmHX1QF52LiAjqN1s6mZCHtl?=
 =?us-ascii?Q?ATqUZoZFmJu3cgJooe+8PlqnErfYM+k/h58aELyGXlj34cdx7ths9cXUT/pV?=
 =?us-ascii?Q?SK+skJyfxndrSgnwqNgpSYQnyzgQsxV8XtYsBsMaihr1fHP9jRMS+x+AZaQO?=
 =?us-ascii?Q?hHCyZOw6RjrVCs0pDFSK6BILaj4JFF0=3D?=
X-Exchange-RoutingPolicyChecked: q8X2YyRP2qYxez27erSbdeTdaJVvLr0eAWVBbyvF919eD5gS7hgUPoJxcaabtcqypmlSHiORiUjkT8keuJp0uJ0LiSymQ7OtyCzJaPWEn0mmENlg7KA1+19ZVFmP0Hbwzy8Y6ntBkpABqFCrALEZzKZE/kfbcpaAInzI+046ZFDdncAafzgNJDxYeoIXr5+6UtvPJxZM6d/5kf4BNBsTbLTTSFzRfnNQq9qoK/6Nsk5H5sEmZqoEq8QWn/uAwz6xav42A+mPqQGGDHt0Y+VIQRk6rq5svFArS8gWyB++WUhl45yQkJXYaCOWIlExRcC5TknROxWpZwTLGgWexTmmdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 98904fd4-b6bf-453d-dce5-08de7f81e4dd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:21:40.3563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2yPtQMNVlOOQHUtY0rO4hDgiY935tUhcqTR2mrNZkyNh6KKhtNv9udLRj6gIruQhE0aOfTfpiUzPP4T81RCw69B5wPEWVGIo0sX1vpIdmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8032
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

On Mon, Mar 09, 2026 at 03:29:19PM +0000, Ciara Loftus wrote:
> When a RTE_FLOW_ITEM_TYPE_RAW item is used with a non-zero length,
> the spec and mask pattern pointers are dereferenced unconditionally
> in a loop, causing a segfault if either is NULL. Additionally, no
> check is made that the spec and mask have equal lengths before
> iterating, which could result in out-of-bounds access.
> 
> Add validation before the loop: reject the item if either pattern
> pointer is NULL, or if the spec and mask lengths differ.
> 
> Bugzilla ID: 1155
> Fixes: 6ced3dd72f5f ("net/i40e: support flexible payload parsing for FDIR")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

Missed carrying-forward Anatoly's ack from v1:
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> v2:
> * Add an additional check for spec and mask length mismatch
> ---
>  drivers/net/intel/i40e/i40e_flow.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
> index 2374b9bbca..4624edc758 100644
> --- a/drivers/net/intel/i40e/i40e_flow.c
> +++ b/drivers/net/intel/i40e/i40e_flow.c
> @@ -2350,6 +2350,30 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
>  				return -rte_errno;
>  			}
>  
> +			if (raw_spec->length != 0) {
> +				if (raw_spec->pattern == NULL) {
> +					rte_flow_error_set(error, EINVAL,
> +							   RTE_FLOW_ERROR_TYPE_ITEM,
> +							   item,
> +							   "NULL RAW spec pattern");
> +					return -rte_errno;
> +				}
> +				if (raw_mask->pattern == NULL) {
> +					rte_flow_error_set(error, EINVAL,
> +							   RTE_FLOW_ERROR_TYPE_ITEM,
> +							   item,
> +							   "NULL RAW mask pattern");
> +					return -rte_errno;
> +				}
> +				if (raw_spec->length != raw_mask->length) {
> +					rte_flow_error_set(error, EINVAL,
> +							   RTE_FLOW_ERROR_TYPE_ITEM,
> +							   item,
> +							   "RAW spec and mask length mismatch");
> +					return -rte_errno;
> +				}
> +			}
> +
>  			for (i = 0; i < raw_spec->length; i++) {
>  				j = i + next_dst_off;
>  				if (j >= RTE_ETH_FDIR_MAX_FLEXLEN ||
> -- 
> 2.43.0
> 
