Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC614E81A49
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:06:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED64C40296;
	Mon, 16 Feb 2026 18:06:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 8495140289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:06:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771261603; x=1802797603;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ka8AAwaOW3QWkMYGcwr+Vr1/vxJ+VIvhzfng7yGbNLU=;
 b=JHhedAp6ejqzO47ZeGmCCw+XDD/x9q3TpYS3E+g+uIrA+i4VYHoutrpe
 wd/vP1XFqR0Y37FCxLE6pm6btxPjruTfftlR3IGEee6EbK/5YaIQBCclI
 NpiR5DfHyolQICeqvDBrJ0wJ+Ug8hpw4j8ukylApAxA0r1lw6gHXlcys2
 +Ef+WW0MlxWAkNr0rLW21s9mW6oSY7p//xSMDmAqJD1+e125y2BTqPOwc
 kRvWkDArY0wy8wPysGb6fCoBKxpOwxiQEozScsvjmS1R8j1dBfCi4nozI
 t3FTRXX/qeMqCcW0lEJfUmDaFbgFS5toHBKxq19gKQqV93xDr4x9W08HL w==;
X-CSE-ConnectionGUID: H8O/gLspSb2H7TiL6nLQRA==
X-CSE-MsgGUID: 7Q7D0Rw2RdqHJfEmSTDtQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="97802432"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="97802432"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:06:42 -0800
X-CSE-ConnectionGUID: KnA3i4uJRBuWinUNx841BQ==
X-CSE-MsgGUID: dp5FmCfkTrSdwL6jlmv+MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="212757028"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:06:43 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:06:43 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:06:43 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.64) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:06:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3opYieNAnKGhCunASBwJJJwb8za1jguLZGGbZPhR/gxVxZdinzrNe601U6UUUp1UlAMtDD7jhC8ScxUGB4fN86S/3z4U4uYQEmc+MJgEl8aIPKp0B6ELKvWWzTSKTFtZHKp//APOTtaiviHnAMg6WknOCtkldcjWnQlBVKJOGaLExBlv0CzhYhbjdLaI9+vaqRZHE63+d9xSRdBa/R7FTwIfH17lg8fRV9l+1bD1rM8+s2Xde9z3Iyg4+SQlNMcud9cquHW0n6inngYNxLrdfKuqedISQinVNFjDHx9/lQrO7jm4J4BdRrjEDcFj7UPygpcdnEFgro9tEbUM/phKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7vE9aVpwkxhdmRpfhyhE7/LHwXqag4nhDByqWOOBTU=;
 b=rGCXU/nZJjOet8pSskEPSU2zX5x/hmBcGw5A23GV9aPLOTauwLwwppuxVItmK3uzfbfXfcxURiAKGNpNBVGQKD7FAc6I4HxN6vB7If0sqxhvxnG8RtQEpXMdj/x9xAjZUe/3uI0d89kMk3xutIhmHUw6YDXppG6lxL5zMRNJ8mv/bvDaQNYBtttoFPUL28Ni5PfK72/4jZ0mTBIDwjZRTmLPQ33grm2vl3OexWJz5qADf05QHUK5uK4zrb5329+0niQu8hxp8XsHi7rkcnGavhKvxf0DCM3Y7GFr4AYSViVvuQ9TvD1CxFirBsBcNyIRpMwJYhJcfObKlb5/xtbmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7611.namprd11.prod.outlook.com (2603:10b6:806:304::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:06:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:06:40 +0000
Date: Mon, 16 Feb 2026 17:06:35 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 10/27] net/i40e: avoid rte malloc in RSS RETA operations
Message-ID: <aZNOm5EGcN7uSeVt@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
 <18276a5e4876d084096cccf6f40ef9af87fedacf.1770817884.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <18276a5e4876d084096cccf6f40ef9af87fedacf.1770817884.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0292.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bad543d-0baf-4cfd-3404-08de6d7dc07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LWMQkyXwYrQbbWKPGl952n035FZ04BHIl7hOvXB9UwoI/1UoVn2hcBgjy3n0?=
 =?us-ascii?Q?IUjIn03QsiwwlSlIrPCGQjOt1+9+zotsHPtQutkySXs6ouUUsJieShczfDMa?=
 =?us-ascii?Q?lt4da2h/DEG0rkQb/IdwxsvaWpUkjMgWuCK3z+ALSb3Mctjx43N4NI0X9e7U?=
 =?us-ascii?Q?izM45prPzrVtR1DEkTOCrAPDgdQFB9iIQRmDV2nApmphCTzK7HFaycgJfiz9?=
 =?us-ascii?Q?PZJyE3w6P2Ti8XGsytD0lo81fPrlPHZ04Qlwk8Z29GwcC/gWLmwNRTUA3mJm?=
 =?us-ascii?Q?oY4nBoM3hPMbUMbGEy3V2G6ajCB3uQO258a2DMj9S0aoM4Fgbsg4KfM8UJH1?=
 =?us-ascii?Q?CCYVj5ZzI+vmyCY4SSEonw2lkraUK9naDyihn3mYIdg5mTZEpicCn6fDNJDC?=
 =?us-ascii?Q?8yjMXoPwrcNcjLd8FCBrWRuXhP3Z84tYwKIn2KQnl3IuFKaLkC1o0F8M5r6l?=
 =?us-ascii?Q?ikkB8hPH7Y0SAHG2cp13CJ6TbHPCUn0WjmRdRLvCvvC05Rk8muRxPbO6l1Dg?=
 =?us-ascii?Q?N55sBiXZbGmkezhAS+fn3xZfXbjbLkIzcZDoTXtL/QVSxaXqiLIaaTMk4uhO?=
 =?us-ascii?Q?FHbHHtx2Jqlkj5osJMfaMqoJVomGqggEzkFSApIVIfcpUCmI7ZtMJCoL2dLO?=
 =?us-ascii?Q?6fZU9PcKgp2HXUfSQ+BHVpXst/+gpp81m4FF+ETy15sNIdrDBoA/yNzPsMXR?=
 =?us-ascii?Q?0z0qrEH7CMLxwqO4Dj7zwWhFg8+Gf9JmRRxBh3vTYsfvdbuO3hKCIx1yUOxD?=
 =?us-ascii?Q?CeGut+BzhHyEj9b0WNdxlEDNT8O9kJZRBAXzbp4qNqICst992CDYVVS9hu2O?=
 =?us-ascii?Q?UsH6Q+F3K3G/vL0fVPL+fNdiLNKWrDUH510QDLmHf6xBAy1Fyf/K/tLuJzLG?=
 =?us-ascii?Q?KO9zrBA9M/FP3nJ11JB8B0+kxyJzviAl4eTaoDpooxu5jYjC1LET2z8tpdsd?=
 =?us-ascii?Q?mTPNP09VCvxUTel0GBaK7u9jDi2QyOa9GxhLSNZJuQAn6Lx/sQQYZISE8FRl?=
 =?us-ascii?Q?LcAgmfAIEIV6rGwg3NFr32nCOzIZqxjp5Hp7CO5eZ6XX60wx43euQUhcCHgn?=
 =?us-ascii?Q?dhmW8HP/MapB7DcvnIKfaCh01XfpPLwuidNXpcDXkllUPnb5hAWEuAUwXHPy?=
 =?us-ascii?Q?GInmc7jd/SOeHtPPPfFJFFmfouqhDB7te7pY2zchJnAapMdAjGQRYgktaVYr?=
 =?us-ascii?Q?k2xjG81yR0psQnHt629qMRX8ujHy9VDM/rSd4LBlsyUBq5yo4VcUyEMGTIFV?=
 =?us-ascii?Q?wMxPxj3FRZ4OthHUxyemXFaY9hoWy3rWB3StO4Es8+CkLgZqVesFSeS3Mqf2?=
 =?us-ascii?Q?6DNrLSNCr1CERo4E+M5B/u18UL7scdsKuvZfa5XWvN//4+dUvBXayzKrp/3R?=
 =?us-ascii?Q?y6pyURB39fRSW6QPjpo130aDW+UlG+GJmImuuavW49FBWJQNZZUJuKRqiodn?=
 =?us-ascii?Q?ImW6cNxI69ZE+0iSGL4BDc8PBBzy6swNcq0hGVmTD0jTUOHxIB/SaLUZqjFp?=
 =?us-ascii?Q?1z8KL84B5yGXsPTMAg+W8KinBL4VWvz5CDC7GtLt4mV/JHTYVeVdYbaIalg8?=
 =?us-ascii?Q?PEiMD/iu0IXn8tfqpdw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hjtW8Z5mBvjlBDVWL5U8etoq4qYeb6PWx4dBbCtvQJxYYqpdO534/ialgZSZ?=
 =?us-ascii?Q?9J5GE+DI912UQ5y23oUQSNOZ6BeIFJ5rUJex1yH2AapmxR4CFA+pLSne/K83?=
 =?us-ascii?Q?Im3j56nS3l7XG/OAXyI2txHiFaWDgBeHDo8iENwn288/hwzEcMeG2/I9JEPt?=
 =?us-ascii?Q?9l7Td6KsSLB+xgrGq8OcPuJOCXKUiJRLWVBA23D4k5nCewOHiqCMAIS5FmOE?=
 =?us-ascii?Q?AvDc1elULfswrQ37YRsxBK/+7XCR77C+4wT/KPA/waL9fLvCGS6/TSvVONeM?=
 =?us-ascii?Q?jL6RBjc/cMjRrQLMXBktuzVs9OmLT2dC81r3V/Xce/WlckbH5h0wK66ZYv7o?=
 =?us-ascii?Q?NkmUIHwj3bLqqDOV/QEqCkq+kFpdjkhq+DbHkATm1Rv3iwqZqhb4DlOJlF5Y?=
 =?us-ascii?Q?Xk4yNN7mopLJ2WGovdFXOONMiPi7EQLmHGNFwwqswYG+a3L8h2BKgSto5lzI?=
 =?us-ascii?Q?KeckMRyQ3R+KXe/ARUT4p4n4R4W9MmpYFA8LRN121gNwQggBT/Q3MT+EirFf?=
 =?us-ascii?Q?oViETEB/LjY2uIoW/AZfgRg9+V1QHQLh6ZMys08vEpBOYztFkk0r6tcYmjyF?=
 =?us-ascii?Q?mEYyP+kqQ2UC/LfsBQpP/TNS1eaoZ6Gv5iftqmDEaczlRI9bVbj2eSJhlxKd?=
 =?us-ascii?Q?L15u/YOEUAqJW+UUvW+p1PdCgln98goXYQL2lwjTPm32eS4bpxODHh5XPdiR?=
 =?us-ascii?Q?xtAI9Lv5tYvZNwgmtJ8JKUNcuQz7yqkNFWXoQvRUzoF+LLJ7aX3zrT+3zD6D?=
 =?us-ascii?Q?kqr6WGh5BHFOOVj0L8SlYr3Hr5b2MPfbYxx+jT1o26J2Hu3GUgKb5pSLuv8S?=
 =?us-ascii?Q?PMV/+Bive9rKxI1ygP5p6L2myEt0AycO4Z5LErJzK4yNJqKU8Sfqr5gvU2xa?=
 =?us-ascii?Q?2cTlafbG5O77EVoHmUzGh6xUmliSPRRo/hyHj1oC1f/3JFfBeZnv3MAEJt7q?=
 =?us-ascii?Q?efbKALaSfCHh4uDMUk16qjGk+K6FQ1h68nzwELVvLChL/11Ayu6kznZm4MVO?=
 =?us-ascii?Q?PxFFmHLG86L5sFdLhLRmzy5TtW2Bh8djqBk2XjXPPZ6x3xaT4U1MQfDP6kSm?=
 =?us-ascii?Q?RzOHNUP/yRCs6ILg4bgaT8JzcSh2yTioC+J34AGFDcGQzva8r6SgOxqdQ1u6?=
 =?us-ascii?Q?2gFpYfRhfZLUDfMoFNv82oQYE9HjMBEYzttr56XhVcTRgc9P1tr63Z6O9rwX?=
 =?us-ascii?Q?wRYg6bW16d4Q1q+9xAjBeKSrod+KaqEveiFn1qvU7tfRMp/5cyO+e3/bDg4f?=
 =?us-ascii?Q?eAcn8sPN48+BpsBIdfT77Y0yjYby67AXKrAmiMcBmC8z11ovvxQ7Bslcyvql?=
 =?us-ascii?Q?qOM690uWsbwslSg9ILCts+fGwutsxEgKj5AU5bYI3laFLaLdq1T6ljjJymVw?=
 =?us-ascii?Q?0N6nHrvNtMnyXEli7ewqjrZeouHwjIpe3wCpQ/T7AP8E9MwGnEai3YurnwiU?=
 =?us-ascii?Q?yPxj6FARK5RKWcsT6MbOq/Da+2RUMJyfBdyJvCyPWk/UwHKYZEZISyhmSwY4?=
 =?us-ascii?Q?AU4C9lJPY4ztfZn8N9/hXkZmD/cksfAsR1oTfPTO5xCEFURGj8KhBIs4OQGC?=
 =?us-ascii?Q?D+isVM9wbQ7o9UvEtmiyM186loSuJ5EvmoGGN5ISqDAuzsfwpfyQcLBlNwYl?=
 =?us-ascii?Q?NzQYRkQP+srfbIS031TMp75UbvJ2d/xq/QyohpC+kbNhStmE30RacSgkQg6o?=
 =?us-ascii?Q?aEVXIheexxYpdAt/GYvkokS/YpO0UY5pOiulZhliNiaCbe33kuEPHmkw/IFO?=
 =?us-ascii?Q?jR3QlyVKiKbT56ckPo3dx4AMIulCpWc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bad543d-0baf-4cfd-3404-08de6d7dc07b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:06:40.3546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOumuUghAv1GyLLP36Cgr1BEbtRSYtNE+UfD55e8U4dXCk/Lq6fo/NBBGEsc1tzJ8m47MouLKEbfRZxJha22CNx1oCJGp46wK5kor+JC9hU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7611
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

On Wed, Feb 11, 2026 at 01:52:52PM +0000, Anatoly Burakov wrote:
> Currently, when updating or querying RSS redirection table (RETA), we
> are using rte_zmalloc followed by an immediate rte_free. This is not
> needed as this memory is not being stored anywhere, so replace it with
> regular malloc/free.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_ethdev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> index 06430e6319..654b0e5d16 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -4630,7 +4630,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
>  		return -EINVAL;
>  	}
>  
> -	lut = rte_zmalloc("i40e_rss_lut", reta_size, 0);
> +	lut = calloc(1, reta_size);
>  	if (!lut) {
>  		PMD_DRV_LOG(ERR, "No memory can be allocated");
>  		return -ENOMEM;
> @@ -4649,7 +4649,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
>  	pf->adapter->rss_reta_updated = 1;
>  
>  out:
> -	rte_free(lut);
> +	free(lut);
>  
>  	return ret;
>  }

For i40e do we not have a reasonable max reta size that we could use for a
local array variable, save allocating and freeing entirely?

> @@ -4673,7 +4673,7 @@ i40e_dev_rss_reta_query(struct rte_eth_dev *dev,
>  		return -EINVAL;
>  	}
>  
> -	lut = rte_zmalloc("i40e_rss_lut", reta_size, 0);
> +	lut = calloc(1, reta_size);
>  	if (!lut) {
>  		PMD_DRV_LOG(ERR, "No memory can be allocated");
>  		return -ENOMEM;
> @@ -4690,7 +4690,7 @@ i40e_dev_rss_reta_query(struct rte_eth_dev *dev,
>  	}
>  
>  out:
> -	rte_free(lut);
> +	free(lut);
>  
>  	return ret;
>  }
> -- 
> 2.47.3
> 
