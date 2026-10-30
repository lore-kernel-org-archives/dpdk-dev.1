Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C6606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OuV/LhDQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AD6140288;
	Fri, 30 Oct 2026 17:50:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTPS id 1689640285
 for <dev@dpdk.org>; Fri, 30 Oct 2026 17:50:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793379009; x=1824915009;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=w1zutLzVMr9Q/L4yAzC4ZGqSt5PXJRtTvWIj+IfeSp4=;
 b=OuV/LhDQLUrMDtRV2k5L1HLye6HVZCbqqkuvmyvOBGMoWPFlWzc/iouX
 XqjzVBNCb0tJU5RFvGDhz1yZg/lPvdxDejSrA14K7juonwjB2iu2PA5zX
 cIgYVQahYgHE4hrb8f7mWROv1cQl9U9TRzD/un449m/YL6ciEM8cbAKiH
 KY5O3JOsF2S15XecCRxUl3PHC8aOgabzERzjqxAUQBVoyKj0FFdp+SiTK
 8tJAePA4JTjrqBP0ymZux7fU1zCS5ocHhM0jbZ90rtbGWeo2rXtGfWXqz
 PrdreFgqsRRiTaxsOEf1i7Lb3wZWcuZmJ++uswORDn+vL32E2t4/YBuic Q==;
X-CSE-ConnectionGUID: /IPbh/6nRTGEqqo1Ywe0Uw==
X-CSE-MsgGUID: LNENCNYMRR+oPhh494NOcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2150821"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2150821"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 09:49:45 -0700
X-CSE-ConnectionGUID: ZvAahkDXTxKJgNJjvh4+pw==
X-CSE-MsgGUID: Ln/Dah+xQm290g26ZEOC6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7323502"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 09:49:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 09:49:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 09:49:44 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 09:49:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+5Mkhpdy07kAbBd7Vq0aqIKR8wlbSSBGE/Qbuh2D1JseniQyAsPbqDlbIViwHj6sP5ciUsaYTP7HN5USHrSNo5WhjAO1+b6ZS5kjF2mJu+gXuBorTtiKlU+47eoTo57C/ADah4M47f7b7Nvas1XiTreRaZ2/L5SjFJogodj62iF+kgZYovUf+4x3uRwSAmCmPRDG0ZdZ2ELtOob4sAtlEiVkJjjRWGEwAy+x+i9RadGQxTUkz9qFyCsOsNNCl3+v0nzgSnK7uhmkOzYtMleSfP1HSbNRFsV+OpR2Tqj7bHWYkljhsoLS1Z/v6F+Vj3sQjO7rdNebLLPzVTnva0z7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOwxGr9XhAIrYOkKDTtPpZhsJfzfLo6kqhQhnDkGmY8=;
 b=JTDA1xDITWXRCA5Az/3ShSzyAx4gh7AxcFZ16yJpIjrqLfjFR0WtmNylVKBTviH48lskj8RxegrTeZnmzpAX3ZCnxHjDB878NyE6NVaWhzuXG0cxD0LMla+eJA8g9aOVpta8HOBAKJqIYYBbYaynHeEnWMjuIpvTEdRk4XuZIgkRt6YOigfCSD+t4rs+37sjfdVK1GXvLLkxz709SSYh1U8fBNX+yoQGmGz5J03HDxwDYr5rdaXI6MNc/wGnVq2z2+KrnvcdQ7ZUn9VrIFv+VVl2zP595ZgMaiJWJD7xhWeXm6eehTWYxVfGmdEdvp1EpcxtIb8QRx1GFemWZ1g0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA3PR11MB715720.namprd11.prod.outlook.com (2603:10b6:208:714::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 16:49:42 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Fri, 30 Oct 2026
 16:49:42 +0000
Date: Fri, 30 Oct 2026 16:49:37 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 1/9] net/i40e: skip FDIR flow engine when FDIR is
 unavailable
Message-ID: <auTKoYngTHype9Fq@bricha3-mobl1.ger.corp.intel.com>
References: <5e64cc416c8ab3b038eee6bb55836e0b8ed507ab.1793353214.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5e64cc416c8ab3b038eee6bb55836e0b8ed507ab.1793353214.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU6P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::21) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA3PR11MB715720:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3bed2f-7b5e-49fb-8282-08df36a5cb6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: vqn98+hFivLkm+wAwqbvRhQrOLHM2Iv3OcaD9lxCtfNa7NOcm+7vHuw29hTHWTkYmFS6HRJagmqWMElTgTge8BiCCzfAkUYPeo8ySaARrkfmCuYoBeLBG2r4GbY9buJap3SbT39B4yjp4E+U9OMK6rsq10Ua5B/sTQ5qTCjwpuxt2BTVPbksZhMGU/wyOzi4DUQgABT2RzhiX28ubxAUEJNeXO0LSwBpWlVknRQKqOLYcCnMGLbSLJ21ZjswbwGB9zTL5rzWAHS4Hkugu5U+j1+t3zbMgePEbpG8dLLsPSR2dk2jumXIQOCjtVYfjhSmZ2/dxrLVrPmJD8yj75BODsVvHRVCx8F6lZ4YgbI/Mn4Ou8PmcgMkD/a2BQZM/IcAbm6qZ7WSOgVu4ZSoYcMAfaxTmEpxdltKwEOsoBymjgicpBUYX0/utQJx57cPXUNXh8LCHYzYt0/Mcia2+VukwL1q+1r4s+wvgnL1KqqHI7QqtoIaaKhGYySfg27vDnBjoDym5m5fzOqDDnDCCIZ2eZP1pMMDZfonC4fUrhqpBjZB2SqPbpvgKTCOEz5EFlK1f3LEQyr1RCExSlnU2R9brU6BuSbV1WJimm7rJanFAeMNJ+4G+RvVclHXn6VrXVHC7KSN8M+qUVPA8amj5/iMT+OBikI0G3TRa69JZUes1Do=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xSVHzwXolo/SwH+WjVoUYzx/W3CC4mrtUDEgW7dOgqiZac7pAgqFLglRb9lI?=
 =?us-ascii?Q?fZ6L/n/Jx/lXm0DC7D5slQyUqjLfEB/1ThMqPtYSD3v6kntxiTQFKC8dObkc?=
 =?us-ascii?Q?bWGJUVha+tGZ7GGcFNCFLSgadQz9woc/1ZNrmnj4fbFTKd1LSMXzap9kjPfY?=
 =?us-ascii?Q?ozY2rRbX7g2P2uP0r1sebmr0pZJj5WjEDCexvkt1rR9QpdTuHCbo7U8VPS93?=
 =?us-ascii?Q?gFRd9FTTEFlzcS9YHh/HcYFPBoMoI4z5c7qKPITwKnwF+o9EZxetsj8rVime?=
 =?us-ascii?Q?gAGnZvfMeid0UC6AYQ3GFe87eEY+EeEzVHx7Lo5+hhTOSQXssPzJfZmGHw2r?=
 =?us-ascii?Q?2tQmemMowPEycvch9sTjc4k4QrOVJ723H6F81JJTS1OsiQvI1ZnU1ye6PWN4?=
 =?us-ascii?Q?oVMuGo6aV62i+rl3uhVEOT5RWLxQ6jRdEC8D0d+LLG/fToCGvZWpj/je/ov/?=
 =?us-ascii?Q?i/voaAVW732OTh9WtfgJQlIyB7DGqou6YjrgBwR7jEivEkLTJ9klM9Q7YsHJ?=
 =?us-ascii?Q?QRWePHEa/lBt0zGFy7wE8bYZiGxllbQNa57YaTHh5DwTwyGpassV/iu5aic+?=
 =?us-ascii?Q?Dpxv2frag5oVbyd5en4hFmkksII2Er9TKB5wkTmd3PSS3ROk4M9Td0Lho8RF?=
 =?us-ascii?Q?pYcZVXcBfy25o45+H+xYmf62cOaj/x0SnT2vyXCMhH3/+YQv4p1uHXZPEX7r?=
 =?us-ascii?Q?JTa8b8J9SPXJHsnfHPHA3mvbR9yg/lpRO4btvkPpsXhKToKKn+PeYS24Gutg?=
 =?us-ascii?Q?tXpG5nsdZ+b8JtV4NVWsRE1+dxvKWoCeP4122iKS4Xq1FcRxA40PWL9O2qqk?=
 =?us-ascii?Q?iudPImvRvsSEf8eig3WtYgr2WH30fTxSimoYDfltxW4RYLJv20GfAwMjoCyA?=
 =?us-ascii?Q?cikLt9vUdsXcccLzkGDqypogADj9JA9AS2JckNfjQzsaRv6BsmO/RLfIyGWu?=
 =?us-ascii?Q?czxSdex6xuGF8ftSWIEd/OrpNyT6gRLFg+fwGPXMUHDVhuZO0ot/R30L+Pfl?=
 =?us-ascii?Q?t1E/EREgoHyvBv29c9A6rZmGndsn+VyqrLUBEkafch/XtJIOCSvdOIRz240k?=
 =?us-ascii?Q?mjJthRPdofXtHrFAeIMTWMFL4+WrkT3XW01I48T92LvUjzKXkw0e5aKY5rHX?=
 =?us-ascii?Q?nTCCiVgiSqLka089mjukhS9O4nDAaqmLM8DqVIxHF6BXqV8y0NyK/vgnDTJ3?=
 =?us-ascii?Q?xDOcZ6oo64AapOJcV4es/uM2hpDhP1dFRR6P/XCnbIkimcA/pqqatPpaWpZz?=
 =?us-ascii?Q?7jJk6WPMLJLAVYYGccnGnLHWW+MJ5Do1lc9Gl1IPwup2SOwquRqtV0q+GuW4?=
 =?us-ascii?Q?QUx21OiWmrvQgDCaTtS4CoN9c66kBug/G2i2jAtsNH3W2hebgxEy/aoePJH7?=
 =?us-ascii?Q?C62BDCrJDOmpsCkIsFRuPZipFu6Bsg5zld6rFP7D+j7HhNVLyvf82CB8s/Ph?=
 =?us-ascii?Q?KjfybYueVuzlun294PFiehS6/lgl+RJqFUnJXb5Zi0nj9qiNuzVVaOv52eQl?=
 =?us-ascii?Q?tqqnpEyhIl3poRHHkwY/OOCm9VuWdpeJu6I40CkXLUceoPWD8G1EkRjLg8OP?=
 =?us-ascii?Q?FAZXSt6pw2zbB4F8nbEy7hnax3gXybWS+2AVbfCAqyFjm2nIAUkTwhvdUO4L?=
 =?us-ascii?Q?lRl4GHzCAl8K37eDS89UaGUStb3v/EYDnFJzpvoNRsUD7Fs9d3dYDgwPNsX/?=
 =?us-ascii?Q?GbE2Th8O8AjtxuZTMySrsG6O3PG1YTFYW9Xjvkt6MUOqKLkBPXllg7DOk/4z?=
 =?us-ascii?Q?WIAtNjYJVBxC868tqz/fd+Deyy+/QTc=3D?=
X-Exchange-RoutingPolicyChecked: p19uQZ+Rbe8mNGQxZzcx4M5VC0P0nY9K5822I+fy6onhkKEWf4Yh4RHO2co7Fh3BG/6o9vmGgcusA4gKYvzcWnKLRFX2XXPDsURxk7E+6hJ0vPh7hsZg4FjCPc99iveWyZstVTY5O8vNmqlyiTPEFq1DNVGJAObAqABVOm0vRanEJu/jgGqFMalrWM/xxKgxRhIp+mPxQk+jd8DW0WYAb+jEKdgKpoNKJ7V/Gq8nLX5RecSBux+p2jvQ6QbHPd7Zp0RdSBTtuo6rM8Bt4qmcQF64InP2q6n59kd0dLrRKzyrA1SrOv/+PaPJwLhzwbBOWoqiKqvxp6T45bJEg3r5qA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3bed2f-7b5e-49fb-8282-08df36a5cb6b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 16:49:42.2776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PnFFpsGw0JduuBQmrDxvrNMbrQlI8p9zKgfPONnMNocNZm94J3BN28eAIJu4v/II/qRL+YZDWT/zuyJ9AFTCVrVubwhI4Eucch/7FaXkrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB715720
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

On Fri, Oct 30, 2026 at 09:40:14AM +0000, Anatoly Burakov wrote:
> The FDIR flow engine was initialized even when flow director was not
> usable. With no FDIR filter space, engine init failed and logged an
> error. When FDIR was disabled because its queue could not be allocated,
> the engine was initialized and FDIR flows only failed at install.
> 

This commit log is not entirely clear, for example, when you talk about cases
where the engine init already fails - given that you are adding code to
make the engine init fail.

> Return -ENOTSUP in both cases so that the engine is skipped.

You actually refer to 3 cases, I think: fdir not usable, no filter space,
and no queue allocation. From the patch, I don't see the third case being
relevant, so maybe drop the mention of it?

> 
> Fixes: 05432a6e4676 ("net/i40e: reimplement FDIR parser")
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_flow_fdir.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Code change looks reasonable, though, so with commit log cleanup:

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> diff --git a/drivers/net/intel/i40e/i40e_flow_fdir.c b/drivers/net/intel/i40e/i40e_flow_fdir.c
> index 55997295edb..197b93f3746 100644
> --- a/drivers/net/intel/i40e/i40e_flow_fdir.c
> +++ b/drivers/net/intel/i40e/i40e_flow_fdir.c
> @@ -2010,6 +2010,9 @@ i40e_fdir_flow_engine_init(const struct ci_flow_engine *engine,
>  	uint32_t i;
>  	int ret;
>  
> +	if ((pf->flags & I40E_FLAG_FDIR) == 0 || fdir_info->fdir_space_size == 0)
> +		return -ENOTSUP;
> +
>  	snprintf(fdir_hash_name, sizeof(fdir_hash_name), "fdir_%s", dev_data->name);
>  
>  	struct rte_hash_parameters fdir_hash_params = {
> -- 
> 2.52.0
> 
