Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C8BC0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 11:46:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 149534279D;
	Fri, 31 Jan 2025 12:46:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 25671400D7;
 Fri, 31 Jan 2025 12:46:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738323965; x=1769859965;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5pwI986yDYUV/rmzFFmUW/pAYt8PDCcMrByZM3zn/m0=;
 b=dmTuDtJIJo8J1PiCyPG6C0kyqXAk8l5e0xlEjJYxgwmL9f9lGvO5r40a
 gGmeHBSR3ACQpajcB7ZxgY66d0h+++hvSwPSMO7Wrhw4dHocIrRsRHIqb
 lchS+JOx0/hk4IGz0H6N9tsTDRwDN6ol81Hd51Mc8YoXinwhUG1aJY0Ms
 eDT1QsTj92+SkWDSCqP0sWQVLh78vpEvCKXW1Xky26Vc+taWkPkSwoB95
 Uy88by3iMu1mbJed+Iy0Xh1i3k3gnNHPfLc4P5URhJDsz93fbl78hEYD5
 MtAIs/g2LMMeK1jTZci7P8G2HL8aKxqxeLAdbywt5hOj/R92RQOJShKab A==;
X-CSE-ConnectionGUID: 3svZVSlASQyjRpvkpo0pdQ==
X-CSE-MsgGUID: zdljGTBYR4qzl7cWRhJUpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="38794788"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; d="scan'208";a="38794788"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 03:46:04 -0800
X-CSE-ConnectionGUID: ifdichgiS3OI1Q9Kv/zCGg==
X-CSE-MsgGUID: dnggg1ZVSMmwX25iXUhrOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="110486983"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Jan 2025 03:46:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 31 Jan 2025 03:46:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 31 Jan 2025 03:46:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 31 Jan 2025 03:46:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYppp3RLjkIpWxY2XVGD4ZZ/1myuj+aJQrJBcWzvUUK4nNMM0miz15QnYIASudEev79r8Qx9ORN1w1Q5CEWwvCYd4Bqcx96Z96F3Ns/aw26QJFQ2Ro5ssjnO1fqxBQas7OOLPOMKE6619iuBMcIFrYYGUWT0qUWQ4P4eDX4ZtpMe0CaME4fsXGYutm5eG4dwiovlyhFdP3yr8J2P+vR1WFv562LFgaAXCQOwPcdzgCptJhODqHF2iVrcVRmWGSwjEnNPeBK3ZHU+cwDmMak4pvqlW/n/gUJuwjwLmZdx2Wpw2DZV4jhvgLH3CNTCAFvx6nSBJIHL0HQHxtC8y9oRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+74k3JTiV6ewVy9bPI+hc7cdArcT5pU6RGMRrlpp5c=;
 b=nSXLlsLc7cNBISJD4ZMhBdGTsch7ECi+DTKmea8/k7wbfW4xBK6tr/P5ZdgdEpvfKdVrvQacS0if3GC/03sSIIhZSweWXqsKhvB6PoBi8We70MsscjgXn/sbCt4C3xlE4uBOwNXwjYGXZ/3QiuZlVe7JV6cIeLv56NW4BXVXnIirEXER54skSwXE+xxZnRTKRk2CHoJ5GEZcP/6mDWGTahr0Bh01mKp3XMTHVDUFXT4APwFjVXEpAVE0kEniGH+1kTozwvf2fhqX3/TyuXHKGhVXKudrLriyrzC7JC1DY6k0yQGPf63uEgYD5AIS1oB5PTPPGUZCds8qoWH5Tvyvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SA2PR11MB4876.namprd11.prod.outlook.com (2603:10b6:806:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 11:46:02 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8398.018; Fri, 31 Jan 2025
 11:46:01 +0000
Date: Fri, 31 Jan 2025 11:45:39 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <kai.ji@intel.com>, <anatoly.burakov@intel.com>,
 <qi.z.zhang@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/ice: fix how ice driver handles flows
Message-ID: <Z5y349sJbJpsWkD-@bricha3-mobl1.ger.corp.intel.com>
References: <20250130155011.2658800-1-vladimir.medvedkin@intel.com>
 <20250130161442.2730917-1-vladimir.medvedkin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250130161442.2730917-1-vladimir.medvedkin@intel.com>
X-ClientProxiedBy: DB3PR08CA0027.eurprd08.prod.outlook.com (2603:10a6:8::40)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SA2PR11MB4876:EE_
X-MS-Office365-Filtering-Correlation-Id: d4722e16-f4a7-4412-5738-08dd41ecce2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XU0DYNrbyk9nnsR6bCKbQR7M+F6szp2xZCvMlsRJRFApil4v7xtbQJjh+w5g?=
 =?us-ascii?Q?nqJxW1degTZVVUxxOqXdaPfo+tvPyvF/gCIa/UsRpxigX/YH4HXqfLqKmNsF?=
 =?us-ascii?Q?3q6yeaGKWwMt7W5bQHycko0X38ArxEotl3Oqa1h8eIpT/Jpz9rbr5h+mh69M?=
 =?us-ascii?Q?vDbW00Zmee3FwFVvpIFfA9Y+rZ2gxpC4e45/DERskRCQD/RWc3wsNSdfEW3j?=
 =?us-ascii?Q?BEAeGyZrmjBVyCxsAQcJKap7Mlj7nE4oQTMBruPvWvKRKOm5p0fPSUSDEjbK?=
 =?us-ascii?Q?CLY+Qol635ae/EXv/Q+Islj8SSImCJrT/rXbCYrj1rppFe0rcpSgjv9yoEye?=
 =?us-ascii?Q?D9Vv7GJCSB9ObcX41BNCaGuXL6O8o7L5HbaWkQjGD1YuDnQi1tLK3pp/Xc+I?=
 =?us-ascii?Q?XipxKTiuruIZxnyXo8zYS7b+zwn2iKvrJQgu2jWle3zxQrYs+zS3cLTZaZ4e?=
 =?us-ascii?Q?i+EiAjZz/FuzEYxcgWQBnPi5CGFqWIt0A0TgWEKi6P8JdBTPwSUg8LbA+rRH?=
 =?us-ascii?Q?p2TzcMCTW1g85i4gMAepZfEjoRGd1zbb8Nmdf3ghamcS0Z7FWc26HQ+P0szv?=
 =?us-ascii?Q?rBQ7KuuutnLLvoaOEnzcrF2TMBIMDqZAxGv3iO9bd1EQhdY/w1VNdHAX3QMV?=
 =?us-ascii?Q?WGUOcNevOsPe5qDiQxA4hBeRTtx9FH22rXVau+K6mCF8xQizUKPgF4wEJQem?=
 =?us-ascii?Q?TxwJXW4pNRtAIbFB3GSMuM8Q4WBpVoKxPsDeKqvFTNKIFxIs85jHstzlqewk?=
 =?us-ascii?Q?ZlUlx6d7c/0zC62Ky1f23uK8PjaVGpjw64H1lm2s15eDTuo698GvKEoX02af?=
 =?us-ascii?Q?IgTvz6gAx2+Vqa9pPucqCOiKlpzczlskSl46hkekEUYVBpKpZ625CoH+t0NQ?=
 =?us-ascii?Q?YfBYZvNZmLgL619LWWRjp9BxU8zOWckd1n4UxVQsRn+XONM9YkV45jJ2m+NR?=
 =?us-ascii?Q?ypgyvzccehTYQPAKmKcGXLRQrlTScuaQqcjcoTZJFBMHkk/JjN5sTQ07FK83?=
 =?us-ascii?Q?wQ0LZUYx/9+5Rox0nn+9O7WOqfcGaGipnUN9ze55tUz4VZnuYqqlTH80aWju?=
 =?us-ascii?Q?kXK3aHunKjljjh97WOYHFiAJf8WoBncI1E2+0K1cuxW7UNbfCE4N8V8kkeiB?=
 =?us-ascii?Q?AxS40Tq1pMceM1eXxyhXisZYfzDn56hHBrPrVZvy2UhXEkUnaMyWh8HW/EwX?=
 =?us-ascii?Q?QnAC0kSzzxlT/BinhRdzav/fKXH92XIn2oRy189pAEbdz6lCUx83GZKKgjI5?=
 =?us-ascii?Q?bO/Q4nnFSgt41xTaTCr7XE8gLWZK/ZgNldxBW5dMX91sa09RtfPZ3tPDr45r?=
 =?us-ascii?Q?chgCve//hJwVTKjieqg2f+kAYwoD1mKeT1HBhXIsb3o6fAlP4aWyXSUwxj7l?=
 =?us-ascii?Q?0ZIaw548wPEt5wbFDOt1c7CkEEy5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sKhUQ16+gCxiEQyiowkSmkoiKSf5jY1sVNigUK2i/7Ap0Iu3QvLYV+/Xumu1?=
 =?us-ascii?Q?hUjQdfCMVYJt4Kq/CYg4AF/3hm0TDAHjFfxlI40UDmX0OC2/dAjW+k2hOhvN?=
 =?us-ascii?Q?Y6jNZf74Zo4xLdudddpJwZyjKSJEw6QAy0G/ZdVO4PR6gPGcXc7KfwjjUCr5?=
 =?us-ascii?Q?1VBE1lgO0aPXvVpWAqtILmTTAvbi2DXb9GpogWTBk4djlgFJieGHa8sGnha7?=
 =?us-ascii?Q?t8zNbPZArXudK1YspdT3gdCLiQczDUB3VVwJgiuKPTXRVDGy7cBJRWsZgRXX?=
 =?us-ascii?Q?kVdX92LrsUMIu4iuRQ5uGn9tMY6XPIYM5vdyXPx7VvEuf8X30N2euOvjzAME?=
 =?us-ascii?Q?OzHdwsJTuySlzxTl3vtyvHoW2AjxPoILCKt71KKatrBepZ4tZ1XW6hX100bR?=
 =?us-ascii?Q?d3V2o1Dd1p+NEIYF6xMlZT+OaQ1G+Q9UpENss9nS5Ms6QS8foBKJcDzcNraS?=
 =?us-ascii?Q?UFL2V6BbUZ2IhpdnHbWLxCU0Yhw4g9gaGO30agsdvoK37LRHJxYZ3mgSi/LT?=
 =?us-ascii?Q?BjyucvvVOe1wZn/8M6ClvyFxA0epYt5PcLIJixz7s2SXrKo6ZpFvwqnUTmAC?=
 =?us-ascii?Q?GG2QRGjXa01ChvCBMlRWye2cnqa22SpCjQLUhWsuP/UXfGyjriwHkcZpokdK?=
 =?us-ascii?Q?d9XCNEraYk8PhXUhgSXkh170j7+/BuWj7YJ0BYtCDX3ZaYwnBs+KSGd2xOUu?=
 =?us-ascii?Q?5EuI0XkfMMqNM/P1uZ3k2H9vRzgSwTymI88ccmxTn67WIVT2SpanSbfEPaWr?=
 =?us-ascii?Q?1lhfXLDgB8ADCRXgG6YnP4gB54ZwFjwkrmldH3dbLKL3K0iLNKvNIUsvgN/d?=
 =?us-ascii?Q?4R20S104Lq9k/WYTALQ3qxr8QTnWjPt928KprS3Cm8k0L95r/Ta8PznYREY/?=
 =?us-ascii?Q?3pUCh0dz+isYy9YSb0RDRRdrLaIPkKrNGRpsk/MieXgbmjBOo1shh8rSZRtx?=
 =?us-ascii?Q?fz05w4SgvvHCR/gKa5PbmD9wIPnisqDCa97LjRrFGEgIhgQa33mvWPEQDKxM?=
 =?us-ascii?Q?UgrEi1/rWYUe+HXxNo0sAAy1RET5NbYlsyZyBk2sUCvwsEn91iMlxhCPyQjt?=
 =?us-ascii?Q?dRxwyu/9g7S5QfhuicrMlCz6fZASn3GTu7P4pfzJy42VHboJd5AxU1g3li3d?=
 =?us-ascii?Q?UhbXMJ3O+OM8plzD+7u2uc7+sVfN0l0klMuKaOh+0WH8piGblN2+fy89PYET?=
 =?us-ascii?Q?taArTD+VCKSz4wxh9tJVQBTRG6UDbtMF6M44H9nGMBTRgrEr+8lDNZKAz6bg?=
 =?us-ascii?Q?1s9zOclT9ojXjt0KU9py1GiLZ6OAexKzPNBZFMu5DVGUXvnXZGOKUwqtyNWJ?=
 =?us-ascii?Q?ydqNepSD3TT66u5/APweYMgQidlVnJXRPEK9+fpOjOiD7ZsNvkwKvK7cpDpd?=
 =?us-ascii?Q?Bqb6RZnSgSkM7QqbL/WP+VixKCQfSa0m0WKJgXWe7DfnpcHioyE/pZx4AWim?=
 =?us-ascii?Q?uwqU5uriZtYVxUlBh3SstXbLmvI4N+r7tZSvVq2GX8RnCaESBsimL6KJN0vc?=
 =?us-ascii?Q?3WhTasX7ZthrTif7Y1CQVBXE2QHxpyvTSY2uilXwUmW0aFF5XyVdbCJhnzKB?=
 =?us-ascii?Q?MhdECGMhISfIBA0APoVYwqHZS6hD1aMrPprCh42w4GBblM+lPQzlkT4DhftQ?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4722e16-f4a7-4412-5738-08dd41ecce2d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 11:46:01.7740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMkqmCYCTB673nVLJdmOr3sxvyjAtodMvhtMd9a6SDBXFBxMmenKLSgMVm0sYCsu6CzeP6E+8Smy8xzRXgm3alhmR0rQ9MXa6CfzOPQVTsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4876
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

On Thu, Jan 30, 2025 at 04:14:42PM +0000, Vladimir Medvedkin wrote:
> Currently ICE PMD uses group attribute to select the appropriate HW engine
> to offload the flow. This behavior violates the rte_flow API, existing
> documentation/examples, and reveals hardware specific details.
> 
> This patch eliminates the use of the group attribute and runs each engine
> parser in the order they work in the HW pipeline.
> 
> Fixes: 9c5f0070fa3f ("net/ice: map group to pipeline stage")
> Cc: qi.z.zhang@intel.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel,
Thanks,
/Bruce

PS: for future reference, minor feedback inline below.
> ---
>  drivers/net/intel/ice/ice_generic_flow.c | 30 ++++++++++++++----------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
> index 50d760004f..5c34e0385f 100644
> --- a/drivers/net/intel/ice/ice_generic_flow.c
> +++ b/drivers/net/intel/ice/ice_generic_flow.c
> @@ -20,6 +20,8 @@
>  
>  #define ICE_FLOW_ENGINE_DISABLED(mask, type) ((mask) & BIT(type))
>  
> +#define ICE_FLOW_ENGINE_NB	3
> +
>  static struct ice_engine_list engine_list =
>  		TAILQ_HEAD_INITIALIZER(engine_list);
>  
> @@ -2295,21 +2297,23 @@ ice_flow_process_filter(struct rte_eth_dev *dev,
>  		return 0;
>  	}
>  
> -	parser = get_flow_parser(attr->group);
> -	if (parser == NULL) {
> -		rte_flow_error_set(error, EINVAL,
> -				   RTE_FLOW_ERROR_TYPE_ATTR,
> -				   NULL, "NULL attribute.");
> -		return -rte_errno;
> -	}
> +	for (int i = 0; i < ICE_FLOW_ENGINE_NB; i++) {
> +		parser = get_flow_parser(i);
> +		if (parser == NULL) {
> +			rte_flow_error_set(error, EINVAL,
> +					RTE_FLOW_ERROR_TYPE_ATTR,
> +					NULL, "NULL attribute.");

Since we allow up to 100 chars per line, this can be kept on two lines if
you want.

> +			return -rte_errno;
> +		}
>  
> -	if (ice_parse_engine(ad, flow, parser, attr->priority,
> -			     pattern, actions, error)) {
> -		*engine = parser->engine;
> -		return 0;
> -	} else {
> -		return -rte_errno;
> +		if (ice_parse_engine(ad, flow, parser, attr->priority,
> +				pattern, actions, error)) {

Similarly here, there is no need to wrap this statement - it all fits in
100 chars.

> +			*engine = parser->engine;
> +			return 0;
> +		}
>  	}
> +
> +	return -rte_errno;
>  }
>  
>  static int
> -- 
> 2.43.0
> 
