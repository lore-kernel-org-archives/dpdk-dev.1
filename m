Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D02C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 09:46:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F77640B97;
	Thu, 15 May 2025 11:46:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id ABE06402C2
 for <dev@dpdk.org>; Thu, 15 May 2025 11:46:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747302367; x=1778838367;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zLy0VQdVifMNVmw5CACgDs8uxCp76YG9jOzXI9efP9M=;
 b=QGDpvgOCAl3ZFsGhhCtd9TPzn3wAzpHIXRJYDbNdknAXDRJTH1pMXpl1
 07FUtU0bf3y3imDJBkgcH3R57anWTQlqt2pNYltFkoDz+qpuTCar77Kv7
 C6BSLJBa8OlNQuCclQIBacTD3blidZein9fPQqy1gWH/5zjqxjB+z0yfB
 vfl8HaBoMnxnuYzBhMUdW+umS0YzMV2LO0OZE2ILlJ/42IvvUe8UqV/fH
 OCkfC1nWiuyHbCtRYHazQ9V0oegi4kB1sBoXmw6QwSKm2WXFWO7jv8AN2
 n3fdgNIX34cUZ/Oa4f6sGGMMHp6TAUDaWEYHvs72u3ZLVz0O7j6BBShx4 Q==;
X-CSE-ConnectionGUID: X7n0bdpjTd+9a1DqjE0fHQ==
X-CSE-MsgGUID: 5AR+DhkiRy2I2zlNNEDYSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="53040638"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="53040638"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 02:46:05 -0700
X-CSE-ConnectionGUID: /fppmsYoSKqFWx0U2k2B5Q==
X-CSE-MsgGUID: PCcTK9CzR5atqQaQCyZo8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="138369271"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 02:46:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 02:46:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 02:46:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 02:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDYddp8l7QVbOZRU0bAU5827uj5gNJFmpVBL0ry2qdcnr373dwthCeQJlQHDckQKhaY+Ywcp9PP3EsSdeZ/QmxGwNmaVTjZ+57221ttmVy5DFTbZlWy4I+nSIbUqUb5yulP9urZ6cAKKuI2X2iXTqvcYafgplXjgzH5Pw5+tobdO+BgaxaP4qCEUtzew/FVZO2H2UxGzcmbbemXeCUgEyZCkGYpubaw5B0eGt34gyJaLb5hGStmDVAtUnbSX9z84V8wYILi9trwTP5ZY+QJP8DI5MsoSNmhG1q/q2PT859v4Bc5HWFq/eSIK9mm4W1+B8r+XkbYcmlbXBJuLnqtZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FWQz7SodYSqTM/DDJAGwI2I15htAaITDxkejiATlA4=;
 b=gZoIopdCEo+jhOVYwuUT+vj686ODS6OhOdqXGi+xuqciiLIFUz+MOJjambmAmp3aqyeKhGcQ9wg5LXXa6MS0idTby8ii7HG/V2JNaukP4phXEj0T0mDJnd1zeHwUGBzxrK1W8NcaHGK1BlTq9TGaick5cis3vEghxC6/CBGgbx7eqhAnWyUccTLt4HNCLzHiHdtiU3y2UzAfJUhNkyW8PaFE5yh9UD8ZAeQOQPV5J9xl2Pwj71d/2pIq52/jBNm4V1H+VGUXE6CUrUQCEctf8S/5sGO7b8DUKes5+6uO2eF6lhbo6obhQEKXfepGH8KlFkgG6qrnPiFz1DaJmqS9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 09:46:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 09:46:02 +0000
Date: Thu, 15 May 2025 10:45:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dhanya Pillai <dhanya.r.pillai@intel.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH] net/ice: fix flow creation failure
Message-ID: <aCW31QjixY20ns-_@bricha3-mobl1.ger.corp.intel.com>
References: <20250514181530.5385-1-dhanya.r.pillai@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514181530.5385-1-dhanya.r.pillai@intel.com>
X-ClientProxiedBy: DU2P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 6181cc20-62aa-48d2-d3f9-08dd93954dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n4dftFHYrBni2+WyoxIP2JSZ1cqylBnB47WPVitdIEkKN8Z7H5gOTTqpv0H9?=
 =?us-ascii?Q?r+7644bee5wcNosXhm0BkMW7E4FyzA2pklOM6NEto5r8j3j8NUHByohI/U+B?=
 =?us-ascii?Q?W9HGfp+WPy15E3igzS3YOHKK1XPPZHrhOthtmN390XriiJOsa+aTYBf/fSpR?=
 =?us-ascii?Q?8OP6/I3K6HGzWVGWuI5GhpFqlbKcSA8oSGl8nLmbvEuT0GX8YzVtzH2m8s39?=
 =?us-ascii?Q?qHjJoTQVHcNJbDu69iw2gvt8xu5K3ifrMOFjGrxi81VLpfYWYM9lTvYQz3/N?=
 =?us-ascii?Q?uYIcfj/Zwqldhz8CcbtrrNxwFVPB5Tu1BO1Fo5qaiU8kBJSrM75gmwRM+XIn?=
 =?us-ascii?Q?KkxFoXAV2YlLn5eqnwZYXs5xWm5Xai1DKp2ilzKnHRPleKd+R5/cjX6EkFMh?=
 =?us-ascii?Q?dXzD8vvkEVidqt9dJP+0bBbnIHEG+zZ4HcgCSzzQbgZ7lsrqiFKbUDqiqNiS?=
 =?us-ascii?Q?DwAQ7vhwM9UodN4SNSdYpF31N1aom1InGjEAWyzfcDdqjuRjRUUBRV3G3fk+?=
 =?us-ascii?Q?9eNrMyEmw+RSqmFjRm8+3IgSgDBS0iNRi7J1OHEN4jdy0kJrWDmm4isfqJMq?=
 =?us-ascii?Q?QUfWBtWyE3ZyKNKLTCF3sO2vWDQgq8jd1lSFAuXKZlx5eUFM6EEcEZaQ4aPB?=
 =?us-ascii?Q?ThgpclWl321Ky43zYKfl3oDCBfQs9zpPkq7CSNRfc0Mlv0pFfXzT4aiFvwix?=
 =?us-ascii?Q?hQl19Ag45eS2G+6MeeEssf1GP4GBcgAOw11R5glbH962+1FFymbGLLhUycId?=
 =?us-ascii?Q?HP759sLyPnNAAfjCql05UrPgq2al21HMyGV3Z59dqcOboGTL50TYYiVLqJaw?=
 =?us-ascii?Q?m8tZMWqGT0/SmhLwl3cmLnbvrEW0NYbvtn793RfASGTF864JKFuIkXCloWwV?=
 =?us-ascii?Q?D5VGC6PDrVVn0279SG94TNqZfpPmucp3zMzoTRPJjX5kYNVGbru2xKdNB/4U?=
 =?us-ascii?Q?vsHvvVJvg5UXL4PRumaOMlH9GGk2D236Vlv4jSk+SC6v4FXsLOkMr/svnGlE?=
 =?us-ascii?Q?nhA/MSDkcuzDxc2NZr8jZHI8ARDOPOyrGaMmlEoqlvyw8yvwy7KH82s0qIsm?=
 =?us-ascii?Q?TQO0pxU1zH7Wo6LXwy9jXqoEiO/2g28XS+dJHim0I3eR8jpfafWvCNxTXlzk?=
 =?us-ascii?Q?xmsfku7X0CGyQ4O5RkbgfG/5fXalIBUv6fWaqcI2ZzjSQu7/0cOp6xbPTuoI?=
 =?us-ascii?Q?p1ijyEOF53zGTH7C3qqPRNMWQuJUWd+5n0m90XuuzvhrOqwwgb0nChBPxv02?=
 =?us-ascii?Q?6u5kDB9HqSKk0Bzrk4bdxnNFvvf3P3lFUH8uliEWBMS0IyZo4XjGFoLFt6mR?=
 =?us-ascii?Q?asaUPaXmtfYwoc1gQ4RZck3+STFwMLV9Doa3UR5i3oVy4AvVVoXWcVNCJBQq?=
 =?us-ascii?Q?l9ZyXAjpd6ezY4CPPRbqx10mg02EpRR2oRerv0pEGVeW9yLDSqptgHjLRFLj?=
 =?us-ascii?Q?cuEdoxEjGyU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u55UwoZE0LXFldqsNfcNxIYj+VGNrA1fLh4yt9HRsF7J2xM+VxDMk/yYHzPq?=
 =?us-ascii?Q?bh8Y/Jo6xnkM7pXn/a0cBIOBYR/igSPKwy6Us3cXys3YgQDsYc3jkL9oknJQ?=
 =?us-ascii?Q?zyUHRw/XFvN7lgrqwbMwo3b/xGMtTCq7M/vtRZnWVmJJchhWaD7F9mtjhHIg?=
 =?us-ascii?Q?jYA57ZnUay3H+qMniJVj+biSWUoajUfagq5aesqEMGD/u4EaaPQmHfrAEcFf?=
 =?us-ascii?Q?EZWd+dc/wg05wR8cwhxoZT5v+VxvCIjWKalV9Jqg7TLSgCxUZdt46cukLGqc?=
 =?us-ascii?Q?2LoRon7QMo9gIEd99dDnmqpeBgIucv/H8l/IFUWwcUdS8U/ER4LFX4L5E2AX?=
 =?us-ascii?Q?hYEcD3IqQb78DvqrRSgp4Rdg+mWFY9uoYFQb30q3HIiU0/amvlDW4wvRdc/x?=
 =?us-ascii?Q?iknl5BfC/ap1UgF6N1luTtgm50igztOZActhZkGZ56DY8kONCDYfV+jFlrO1?=
 =?us-ascii?Q?HSX2wfOiGNlurOXW5BX861xTA1jqXEO/LhFyOcvlNGb6iKg3P8PHnGYrBGiu?=
 =?us-ascii?Q?yqwPZEOxeq2aYL5EmdlCx3J761CnMj7o2Hpxa7ViJbilM1kRm1kLtkoPNR9A?=
 =?us-ascii?Q?Ls8GD9Qmx/QtnSnTznTR+4Hvm4MKhADxCozFOEEoISAun30heD8HO4dhsMe/?=
 =?us-ascii?Q?Ywi0ENGkwiQvjiIELAQ6QbSmOM6prczucenpaHQXVhHxHDLe6dsw9tJVY5W1?=
 =?us-ascii?Q?vYGnmDMfTTshd/1JQHCaOUtjVuFB4Oj2uiM41B/jv6C/IMdaFYnkGBNLZIiS?=
 =?us-ascii?Q?bRNkpRXTSr7O0Qjo13v/h+r56rKadzjCHHS0mE6UogOBaCGCalTIyfOdXeOw?=
 =?us-ascii?Q?11Qpn8u4aknebmAfswYd/t+s5HXcvb5fiEqM6LjfvJLgsvkkS/mEvMog8cxW?=
 =?us-ascii?Q?s5kt8IyrCIvCiga2mDU5iQ71+WzmZ77zL5H4uAvhpPlBhXo0NCGzQCJM4aBU?=
 =?us-ascii?Q?scTj4NBDIZcZ1Rrxp/DAvW+rGpSa9RgO9jeWBJK4E6v+U2TGcDd+r74bs8sm?=
 =?us-ascii?Q?mkv2MpsJSH4svITgYybYpkmJ0EkAHNkGwz1PFXsNvbowpWv35lp3y8sG632i?=
 =?us-ascii?Q?espAHr+GZBkf3rK2catPkaTX/YoRnyU1/JVPK76QzAGMvwzQTzffvly5ryfG?=
 =?us-ascii?Q?ZPYZ5IWtUXJVzCxWMcA4l1gAJt4B1WAC2OXfAU0FYRBaCrOWDp7Hi86eKRI1?=
 =?us-ascii?Q?MUVaSKa9qKwvChFbjyPrTTOg40cfJ4ZBZt2m/QOIVgM3w3nkgHIJEsB3h34U?=
 =?us-ascii?Q?yt6IRtUAg7H2qpJ7xJ5NpbR9SUkYt+P611+3Pxyr6dZYeoK3nqAlZW8JYpBu?=
 =?us-ascii?Q?j0d+cZsw+PVLmUkRJAWCaktkUnjKmHugXDjAdIQVC7FNvZw5WAMU3j+uYKNp?=
 =?us-ascii?Q?DnjR3pU+/eRWgO4ALM+3ve8g6PFfNFUCocSKqUuN/gra68RUkuadqveB1kZ4?=
 =?us-ascii?Q?B0VDGRcOP/v11QYAEcQJohRD3W6jV4KZYsNa+ww+i0z3+/nhpDffRKaEGlYL?=
 =?us-ascii?Q?g2pTrfrdHF4auUDz+0dorUCEefooDrVVvFesMfQXzwSsJyhX+5auqegD2n8f?=
 =?us-ascii?Q?nGFwbggy0Qaw1/tLVKA3Eobs29r1LzZmRf+/DovIfR9WAgodgG8D/MA5R3ol?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6181cc20-62aa-48d2-d3f9-08dd93954dec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 09:46:02.4284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flB3MCgWRB+zZFbUUoV4JtuLzICRlGfLlyRlDV7mx2WeCqweVEDG28NI+kQmZDTHWC1XP0G1FkM7Y0xNYDvIJ7GypHbrblli98IfSjSUeo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
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

On Wed, May 14, 2025 at 06:15:26PM +0000, Dhanya Pillai wrote:
> In non-pipeline mode, priority is ignored, a flow rule can be created
> as a flow director rule or a switch rule depends on its pattern/action.
> Hence removing the priority field check from ice_fdir_parse which is
> causing valid flow creation to return failure.
> 
> Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
> ---
>  drivers/net/intel/ice/ice_fdir_filter.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
> index 2ff0090aca..d71d14b013 100644
> --- a/drivers/net/intel/ice/ice_fdir_filter.c
> +++ b/drivers/net/intel/ice/ice_fdir_filter.c
> @@ -2456,13 +2456,12 @@ ice_fdir_parse(struct ice_adapter *ad,
>  	uint64_t input_set;
>  	bool raw = false;
>  	int ret;
> +	(void)priority;
>  

Rather than casting to void, you can use the RTE_SET_USED macro (which is
just an alias for casting to void) to achieve the same thing with better
readability as to the reason for the cast.

Perhaps an even better solution, though, is to just put "__rte_unused" on
the definition of the "priority" parameter, as:
 "uint32_t priority __rte_unused,"

/Bruce
