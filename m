Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB88FCD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 09:24:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8220402B2;
	Wed,  6 May 2026 11:24:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 95F2640285
 for <dev@dpdk.org>; Wed,  6 May 2026 11:24:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778059457; x=1809595457;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bg9CacZQdCfxLxEfOqWvE2f5B7lIROmYEocCQDV9JCo=;
 b=b4DHLSb3XeUAwpsTVAfFrg7V24QPV9vtN0z5USwAfepdJjGZJFiBcBvc
 4gNg1wY0PpMTSmiiO4L8/2v6HmyE/XfWF02DOHumwZe2bo4ipnVVk6Wf4
 Ea48G6UnBfRy7RswTXiCnWNHOxSXy2EJVsqa0lrm5zbvZU2TwwvhukrDi
 mXIajynj0yXpX2eFFrlZAlYLFLui7Fnr/zQnMlwHHqN7QSbJrCaPR9DFu
 spMFg3UZNqF4QrX/tSG3w2ATvGrkmK7Iq0GFtGN2QhSKYtKPvvSnnjKGA
 16pTibgvVbnCVfMyNzCA5B97JEzuRPnAnX4m0GmFRj6tb3l9O7w0OmGQL w==;
X-CSE-ConnectionGUID: vs4RjZ4xQf2y5ks+0Perzg==
X-CSE-MsgGUID: A3GPeCaoQSOAE8T0INfmdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78873513"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="78873513"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 02:24:16 -0700
X-CSE-ConnectionGUID: kFetCqViRke9x1XACw0w9w==
X-CSE-MsgGUID: 9unGODrHQr690K7YsFAGmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="236189330"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 02:24:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 02:24:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 02:24:15 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.26) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 02:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOeLnsS0MFpUe2zPfyzs5lpDMQUBwFDbGcJ/JcuKisrEjadRg84GKrptzETdrJNGbz2+9QM1t/J1ek2NlFCKoQ5McTpx/2vVkavfuAD/w2+ivjBzRfEq5LYezuX0TyeRLgljJtaTQ3HA7/f+UTw/+UoXTeayxJz5u0ok1NxzBoNxMVK9wYHJyOEBuydu+BD4+pJ13ibiSrVwOLJ0IxS9OmO0q0trCd2/H2lxg+jPCpKmDRi5t3Tl+GcglV8TcUHTDuvcF3HLV2qs7MW7DogQEe1GoRDMSRXFRPeTYis6bM8RYMrIomf49xCA0oFiPhimpD7Se0G8WwsiokuaBV4/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNFd9Q2UWZDSPZV53BlAeO7py/tdCG8lKRPY44/6HwI=;
 b=Vg7j+0g677FzLPoX2Xh/4twAK1XGjzaT+wxV5H8X303TN/pA6DsEJ8FIB5NeKqvx2TycFEcDI1BJ1A1QwOJtwP0sVakxxAWv5njrcS+D9RsvbiqTMgMc0BtYkVbOmd4laJMCrpmxRajigJx9OF1kl7S7fgJ/40qQNFXvqH1mJcM9ov3CqpbkfNP1HXKnWkBIpBHFtvu9C8PE6UqxxzqhcDIWprD0QlG/lLW81y+O7ZcdoK5M672/uN/S9QAEY4H8Cn3dNQoM5kS1MKiwcfQ21lW3j1zfPQzoPlLQGr9ZG49gZraQ9fQZdTgr1eNved/AVsohf8dJbF1Y0qzxg8AcaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8533.namprd11.prod.outlook.com (2603:10b6:408:1e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 09:24:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 09:24:07 +0000
Date: Wed, 6 May 2026 10:24:02 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v1 08/15] net/ixgbe: do not use flow list to count flows
Message-ID: <afsIsmhvkxJj5reu@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1777547413.git.anatoly.burakov@intel.com>
 <57737980689706695c04d3fd0492b2403633eb52.1777547413.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <57737980689706695c04d3fd0492b2403633eb52.1777547413.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0226.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e28091f-9a14-4bca-9ba3-08deab513906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: oN6g1rstjAx2tY0pzguvcKuXMBKlkbeYK/4Pz6D63RrqD+8UJr8W3NlnRqQWoPzUgQO7W22LBwtM/vvztgFxbY4YbLCxK/Zw8w5AVN4V+003vhZe9pLjZIObi/5HL/cBJ6Ctq8OgCjtJavkzyXvUuGiJItM/C1ObS5Ni8Dn9+AlxPTZ76QWtw+/wThIgmjMV0oEwEJ1FCXuJKElfeR6Axl85W0jmH7tnCrmbe1U2O9TucEZjtF/ftaDV499jCA/a1juWi4Yi083C8cjaqAM33iHN4Tty+bCa+JAaODMVG4mSTRqh5nv68MOvg8LO0D51MddTWXSJes2nMOObwMdsQIbBFtQFErsLoPEfskRbPV6709gFXfHM8fFhNStGcimYmmFYXD6eg6D1nOb+RFT0Sf2QjCMuqJqjEQNSyflACjeH1xM0XXTpf1pgD7Jn/NYNYH1JaoYGFvxcPUhOCNyz4uyBZPQXr1jOtLYON+2+ssDSLDFMgmv5/pQ9WELdtgLuFDjmVLQ5Ti6BFoUbYX9rl/Q8o4E3/fGRQv2J40om258runTZ69SQ0GFNCL7BRpxfyzNYdQ5t/UuN5vZA9eCgcTJJLoNfWzlzwsYBm+DlMncgPAmvqt7ksV/ck/QrZ6TJSyI5eUdN0XbWkwa2ZJqzZUA/jto61sShuXyYwj5C9soNATJor5bvPQOVLm2CzTor
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S3RwwevufdaGLY+foxkJRgY23s9bLjuQo7qMMB9PSUoj9Eb3GkklqCiYHBV2?=
 =?us-ascii?Q?WEH59vQ2NP1Y+SU+nl11CFRLUOwJybVGxBlC35ppfvsKebfCU9I+IwLxhz4W?=
 =?us-ascii?Q?PRExSfsHSqNZ2EbuAuauLfhGbQsl1D+FrixvR+68WhZRHt+SI1VSK+Lb7zi3?=
 =?us-ascii?Q?/ejFV6peC1a6PYc1zonFzKWeWIPwTsNx58O3uYxisgWf2qSTH/Q4Neu0anBH?=
 =?us-ascii?Q?xBV0bLkAXrjo4yV075fc/ILA7pcpOleegEGxvUIx37A4saBJGTMUIMKk0U5o?=
 =?us-ascii?Q?wm03v4/3Gg6y/Gsodjq0uYIRfPaqqpZobYqFRn9AnBwtkOdvsgdVEg+ZmDCB?=
 =?us-ascii?Q?V/0DDhTvqehAHOa7Z0G8twt5p0HcUReUK/FKKRa1UC347xNKD+lXSXBdAEfz?=
 =?us-ascii?Q?wroq3rIeoYrV9oRDfpUPjdKk8/9bJ0c18nLPGH/kGT1NlRPwwucoW2cWBnJP?=
 =?us-ascii?Q?XLZsfo64t9DdDVlOxS/sjP8mqIiFi522DVDE9Xt96LCO5sxjKvBPo2avj9i/?=
 =?us-ascii?Q?eJxXQgd2PDH1xZ5TRFRm8K0O2cax4dMyyvmFyAg2Qodb/iOxgcOUL7ZwtaQP?=
 =?us-ascii?Q?iEnrg2zD0y2r0bHlBgrvOwqiXxyZ+mU2tpp0ySa0ARHEZjo7Ey2tSEvIMcT6?=
 =?us-ascii?Q?XOzfxFE+Uww79xMsDR/KJGs+SOHiGFg0HqFN6UbkfcG5vFbHREL+qbibQNf4?=
 =?us-ascii?Q?7NQvqoWh92jwclr4z0cIn1piFUTIsay2+CDMvcma3sAzuHzR98My4GicIiyx?=
 =?us-ascii?Q?BiHGqxyql7CXbp1QYv2HsYNdjsz2SX2m8dWPuc2syCx0oALE1d+N/Y+sisGh?=
 =?us-ascii?Q?TuI26/lE4trLbLKYn7Rw+dewKyK0nzHKn0jkei6OdoqG344cRzI27hK514n/?=
 =?us-ascii?Q?iSf6yXNplU+sipDLMxbXnrbfp/KPTzz+cu+Db0bFxhjaq1wCyNITI2yEnXoX?=
 =?us-ascii?Q?ZjGOhJmYzDn4AIkBPfXxekBQBvqC19gVWh8/YDdBiBchFxX9qbgodHRmoRJj?=
 =?us-ascii?Q?lpCCHRDL4l4FfcKZwH6evezlPLxXI1vZQMQE1Iq7Uce9bmayf3Y9GQvuTF2C?=
 =?us-ascii?Q?34I7ZuQSuHlrGo00GqrCfxaNlHwqFWJDkZBR9ZH3miadqT1tOyyk+B0d0AXP?=
 =?us-ascii?Q?Zz/wRY2kThcfN25oRabhHzAmIXbxcqcmPKsfkM6znb5vymq3itlkU/R76DL+?=
 =?us-ascii?Q?DrYkL16w64C+XLhpDVf0Mo7TvKgDMAcRGTzU1vumHS+Qw7/JVF3JaC5WjlA+?=
 =?us-ascii?Q?F6Opo6ynZUm6LiLMiVgBiioGw5MnTRKTkjo6v0pOk77bOVCYJf2Rv251q55r?=
 =?us-ascii?Q?Qr2ln7rfTuWXjkBG1P6e2IjdxIWNr1vTrOoMf31Py9YDPWT0HnPb3V5j174u?=
 =?us-ascii?Q?5Ue+YStv9mlyMEJAhpRHP5UaWghXf6DDl60Vs04Go/IwVPDJz5bidaq0V1n/?=
 =?us-ascii?Q?ENZe00uzoxf/22/hyxjlVGefs+uNIRuBWMAWq+in87RmjcaF66IFV9oTr+rk?=
 =?us-ascii?Q?L1zw7MREQudt7WpqbTVjhOjB2GrptfVL2GfNKlB3z2QT9MjKyozqzZE8VV+W?=
 =?us-ascii?Q?qmr5oUxjDuFt8M0LO+xP6H168/LruHAed21ni+tKaILbLBPjjFdNA348rsHX?=
 =?us-ascii?Q?f91QCrtouU29Dh81BRDQIfkQOPjnImHIA36akMFJIbfrBGpA6LOwHMDVz5P+?=
 =?us-ascii?Q?gXmZRsx8vf5sl0OXbWKUbq/bfCpoyM36eJCSk4ELLIV5eSlccLutAhGvSbPG?=
 =?us-ascii?Q?EpJTseTYudYeXVG/6QshHADCVAxfFUk=3D?=
X-Exchange-RoutingPolicyChecked: CiauD84rp+vK4dVisgVHMUOFjMqQQ8qFKBJoBD7dOSLLmisPMU3AJst6CPss4acYkp/NXHa1XUCwSsA1jHcbSu+DZNryq6qy413DU5HOJiq+7WA4Ga1yg8fYS+G5VqC72tcKYFQAa57JcPlhFwF5n+xXRx+yomJ5Yeu8PmWWZ8m/X2j/8WMDOvKYYqoFad21wNOkImmWNMlcUNTosO6/kWU3wx4z6O5uIZypUedUjF83LAryh4C6IeZHnId72cwt4czPp33tXmS4mJ3oH9bQR5fB4cycRYjgSoD8U7gbx+b5JcYWnsNxxa2GrnXF3+jwbxdIAtg+9uPWP4w0pz1VjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e28091f-9a14-4bca-9ba3-08deab513906
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 09:24:07.2912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHye005k8hzDGkCxELVaZUoVQiVHFVY4W7ukhAE9ryuWI7BeyCeUbYur1sphwi+udq6pPGoDry7xUDB6tjlgIlcnHf+3+HLSvcf/tBt/fPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8533
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

On Thu, Apr 30, 2026 at 12:14:37PM +0100, Anatoly Burakov wrote:
> Currently, FDIR code will use emptiness of its flow list as an indicator
> that there are no flows (and that we can install a mask). That usage is the
> only thing preventing us from getting rid of the FDIR flow list
> altogether, so introduce a new mechanism for flow count tracking.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 1 +
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h | 1 +
>  drivers/net/intel/ixgbe/ixgbe_fdir.c   | 8 +++++---
>  drivers/net/intel/ixgbe/ixgbe_flow.c   | 3 ++-
>  4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index 1c4a2e1177..ee1b499b49 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -1465,6 +1465,7 @@ static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
>  		rte_hash_free(fdir_info->hash_handle);
>  		return -ENOMEM;
>  	}
> +	fdir_info->n_flows = 0;
>  	fdir_info->mask_added = FALSE;
>  
>  	return 0;
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> index 2fb6d55387..6147cd6bdf 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> @@ -199,6 +199,7 @@ struct ixgbe_hw_fdir_info {
>  	struct ixgbe_fdir_filter **hash_map;
>  	struct rte_hash *hash_handle; /* cuckoo hash handler */
>  	bool mask_added; /* If already got mask from consistent filter */
> +	uint32_t    n_flows;
>  };
>  
Minor nit, for future reference: best to put this before the mask_added
field, so that we have the fields sorted for size and avoid gaps.
However, this struct already has gaps, and is not perf sensitive, so not a
big deal here. If you don't mind me doing so, I can reorder the new field
on apply.

/Bruce
