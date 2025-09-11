Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA18ECAC58E
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 16:22:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8602D402C4;
	Thu, 11 Sep 2025 18:22:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id EDEDF40285
 for <dev@dpdk.org>; Thu, 11 Sep 2025 18:22:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757607723; x=1789143723;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uAEczFkK77GTbShurfJEKIJGc8OAkzBMx9qLlF3Pq4c=;
 b=DEv5PfDo8AR96ug/UgFuU7W/Mee1IXW7k+uwx8DdJvi0g2ta/93ziGMk
 9nWmNHzrGoYxKuI0G2eB7YeqpqMlGKwB3Xuaiq+X50XLrDDfC2nb5NHo3
 dp8V45pAVPpDzvbeXA0GufyebLCKc19tvyfYhNiMn2ltWDRoC6bzTKmuJ
 zLjQbVN3Qv5WufZlhyDNUMgL4oeryE4X1C3CCI27sn1rl5kuGtvwcfRyS
 WudVEYiGRcxC0ucwxIZwTIq2nTwTxPeE/8ytyLcOgENOeXNzIiXIjDMOf
 o/G5Z+czTEHxI/FOggFuEmGk8EI0Lpw0osY0CRicX8k5eQw9EexL8CUSE g==;
X-CSE-ConnectionGUID: lKAiaSzFRTalrsG/GRjACw==
X-CSE-MsgGUID: 6mopPQw8T9KyemzI0639qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="60056094"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="60056094"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 09:22:02 -0700
X-CSE-ConnectionGUID: ewFqhT8vQD+K2ctpUPtCLQ==
X-CSE-MsgGUID: FCxfob3TTxqc1URYCeErJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="173300105"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 09:22:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 09:22:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 09:22:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.61)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 09:22:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWw2c+zFsc7ZdNAf2VPCOHkO0cBTqIJAjmgj429jXKxKo2LNGmNqmOvbtbVzDt/Jj7zxsQo7MTNd/bSOBWM/5Mi8ZmOidxP9U1vbr0QL+b7twyDs9/ByVa4R3lHVherXfccNAPVaHKK1OVLXCM7+aka3AgtFhMEZN7yaTqD/ndMJBS86jtLg71QjRzKAGQuDKkR47iVqifxR1AF8jvizSeAA2hwg14AxZl0WrIaS193WlLSb1kPWxeWkDHw0OSwOSaY73XERXdEbFrAYmrDP5gYrNt14w8TbZTHgvvBeOgH06CVMzTTb1m+nDFW6cRoxJ9zRstLAOPKeW/+M2wjiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYTpGIO4p8d/i9Rasm4NBWLbzjIzc451rVmSYVvQXBE=;
 b=Lr5LkzJ3drc8qKa8whl7ZDPdxs/MycSj+KoV51rgJ42uv/Y26NiX0rWOBlIQ1JWvrTwqglN3UgMUqDmV2Th+H7prZmLpR6uNy7xkCan79L5VutLlFmFx6FMX688bnuSvh/t9XigFd5ALC3ZBm85AJXER/cy8XagFVJq8eVwL/b6SMvUe9pP2GsaTcJw0Hrso/1/8opf+ApYF59WUp88aJ1l4EPqAyc2jD480PL1gNxju5zIzJM8p+glCeZO3N723dboE3m0ShD1f56bnwZXUfMA0Q3qMObuRteoy5WC/ZXujdMQFUptHRYY2NMrGZ6gN3V5h68DpsRhUXz4kNrrXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPFB6E746C59.namprd11.prod.outlook.com (2603:10b6:518:1::d43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:21:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:21:53 +0000
Date: Thu, 11 Sep 2025 17:21:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 2/4] net/idpf: use the common Rx path selection
 infrastructure
Message-ID: <aML3HCcgdJWvrAIM@bricha3-mobl1.ger.corp.intel.com>
References: <20250911143145.3355960-1-ciara.loftus@intel.com>
 <20250911143145.3355960-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250911143145.3355960-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8PR06CA0049.eurprd06.prod.outlook.com
 (2603:10a6:10:120::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPFB6E746C59:EE_
X-MS-Office365-Filtering-Correlation-Id: b84d3d02-6745-4c90-7e30-08ddf14f51b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A/w9VQelICUIyeg2E0i/N9ZsB5V8iwOqHIk7RjF6jlB6jYyTMqnWUa1UuFjH?=
 =?us-ascii?Q?Z9300UWalJ+l8W9pYSgnBmyucV80y5o60rei2zFVXowJBEbTIEPBEcJJ8a/c?=
 =?us-ascii?Q?X8xmPr2d8b4nWpVgjtoyroAfXOJuTXwp0AtD4Q/d2FiOrHkeWoubhX+ypRur?=
 =?us-ascii?Q?KkS2inTeBVr8CSPnO+vAxgWjqqFhjaQm9BK9s+6/ncK1ol0PlhLqz1XcP9yJ?=
 =?us-ascii?Q?iK2KnfPoCx322RpHPzWBstPQJ5ypAhkJGgOCy8FNzKKZMcAl3FsNeoAIFfu4?=
 =?us-ascii?Q?hWd8GDof7LkyjchAlbv/k15988ZcsxGcoZYh6nA+W/lmPRoHP/MmTUyrSxk5?=
 =?us-ascii?Q?s4s3hg4HU3ejuJgo3fK01ifUGXtxeK7yaFkVQJEvFqG2ptvO5x66BabENbWZ?=
 =?us-ascii?Q?3JMBK0edIkpwMjZYHrBUEQ2runBEru5r3mKPembM6XQaDvbTNS26RedZoxOd?=
 =?us-ascii?Q?qFhcaVuEZmRJVK8hZW+NgjZRcjFUe0olfJFyohw0L3Yu9nHuy6iLDUKK08Ju?=
 =?us-ascii?Q?7wMBo1JlXCSu25UL/MQvg3FhM1dCfLF33ZlYWmJvuV0oMXMYAXLYXltS3idN?=
 =?us-ascii?Q?fd7mjoSGzTh43Xa+RihRwIJrKQnvJ3syFkyOAGKN+wpB9iRNzb3xmx2Eiji1?=
 =?us-ascii?Q?HizzY3d0Ge95NOOO9jMROyQmPkE/HZVrzHcSHh/bV2i8yynIrnn7jMEiBeU3?=
 =?us-ascii?Q?thT1DzMC1pk73qj8Ce+bNBXu3dZX8GoV23ukjAbYdGlOJbXVwltkuFC74uEq?=
 =?us-ascii?Q?OhfOKjnU8n2U9JhblBMCGlqJl3P5DgmZ1q+BicbmCmUTmFEFRcFb6AHhLajo?=
 =?us-ascii?Q?H78T6vnP1VAQqtfi0iw15bDZr9JbmqZeTuS7wNbB11EB6ZWQ+yXfm2hSvUMY?=
 =?us-ascii?Q?dwYv8WuZmGfgJFPaHbpBXbx09mxaWKrjjKZ4ad52eNmDchoGh41CH0vSNDYC?=
 =?us-ascii?Q?CjoIm2KhS13uIu3BT6BbC1ACJufWoPOb8ugDMARQCfP/9wb5Ogpk4fQnOU88?=
 =?us-ascii?Q?y3nzpc75HWsgy8j9yG+4FyWSuoslbZEKavZq3B54zFALl+siTswEundTHiBI?=
 =?us-ascii?Q?n/DGTPR2RngRbj+AENAFnwrvzTkuW/olhACSMw0SpPHYrhtA1SZtD4D60GhU?=
 =?us-ascii?Q?TT8k9RMsihbA+Z6XTRFEwxFoPTJynJZSilBS1nQiOqeApBE6Tjf7ythRTish?=
 =?us-ascii?Q?Jhr97qRPveIP+vdQI0U/dq2Wodnuax0PWQ/r31nUh3xoBa0hD9p4rzfw45pn?=
 =?us-ascii?Q?vY7mWmS7nTuLCag9fUZKx46bCli3RAsA+Wu6PGPuOphDZKvbvd7wP/T8elPJ?=
 =?us-ascii?Q?X3UEFuLznUu81RVGwYk3AyIZuhBJCfpDqrcD6aLbTC/6/D1MIlhA0T1+w/Wk?=
 =?us-ascii?Q?HWoz6BI8zPUwmh7LNqDZqf0OS+uR0cH17ceNU6yKCBZRug/IUNpqTneGq4wT?=
 =?us-ascii?Q?lmjiR6wQbds=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IDNcqn9O+VerDUjXibn+u/ub9UiAjlQJghVpMJwlwUSuWwl9OV1WSDc5CNEL?=
 =?us-ascii?Q?eT15lOU0TdqcF6SsBHwf4vc1l+FvtaWbQ/K0ij79i4tYm49i46nDY3jczSCl?=
 =?us-ascii?Q?8+Qh/XVO5biW9cgFW8h2GWgG6chZD/k9UuBIsCAbqdSpZXh45IZYt9tyX1T1?=
 =?us-ascii?Q?raT2sLNIVKHEdkahd3F2sMCBJUuz2BWaRGhIpuVwQjh2fRaC7zt8LnsagWJb?=
 =?us-ascii?Q?KLIK1/QhIYtCoi45fzTeIbvOgHofRRkbwR3tShqEwe+4nWcnI6Eh3mXqWwJU?=
 =?us-ascii?Q?vUhXgAwC34EWVMp7knatrWSLoXD1Yb3GmWXfjPrJHb8MzgPWmPKw3jY7w+bV?=
 =?us-ascii?Q?JHRxOJasuRJj47CONB2xA1VYRNnn6BhAckIj2lTHk8A3gZLM+Ad6sDaiiP2v?=
 =?us-ascii?Q?soQcQp5y+et58UwJEHiNkMdd4skSMAYH7xlEfckVsPla4qAigzD+Ejk1w+4V?=
 =?us-ascii?Q?5dusJWNicVq48pt0Xzqp2hjjQoBpreJUx76pbu0u7rFDzPEKDPxm6zrq6ZlF?=
 =?us-ascii?Q?fPLhQWwXXsErROPRJ3PUJtEgINlRnJWE8fWKLCvlxZ0yENbmgyyGPFei4poO?=
 =?us-ascii?Q?K/aDa4MwKdMHna5HyLjuhGF9vHsKbR1wOi+o5Z3/fWfOo68YvgGN/emFqMl2?=
 =?us-ascii?Q?c+x4Lr0xpGpdKZLYDugWPWC4wKi1R+5CwxmyfOzEpuDcymYVOsDmeKPHu0D0?=
 =?us-ascii?Q?cLXqLNL4kZcZWK0UW/E3yeQDFcK4dhJ6QtA9lo06c/K4o5RkriUfd/rbd2EH?=
 =?us-ascii?Q?O2YxuyDlqrQgGOPAGNoY8VDXyaQP+XregS2DHJ1AWD41gPDW0I8Y+XlX2iPt?=
 =?us-ascii?Q?bJdRuH5a8ludnsPoe/4wcECCie8wuogxpMkX4G15h4kTxbTl5otgxb4nlVYQ?=
 =?us-ascii?Q?A6nwcEFRUnOJ5jmV+AXfR+BNCgP9xvlxBKNdfSbsCAffw7VjfJfmGsSUTK1j?=
 =?us-ascii?Q?we46XNAXGjrC7zpns7BC8bVurMh+/D5W8IoTaJp68k1uEGAwJe3cTONwiGIY?=
 =?us-ascii?Q?5rT2w8KTX4k/9aHmQC1rwRMRb8Ek+P9jLlJ4As0ySdXv8DPVPYx7Y/hx0moe?=
 =?us-ascii?Q?CUGqMdyuBwk3v86RsQXcdWH4FzwaTxbvBal/hjIp/tEFv2/6oQfBSqxhFLcF?=
 =?us-ascii?Q?O5puuS+GYMFqf5IlmfN0aBTb4Fp/JmD8deGHYQFyOJw3AY1W9FPlry+sl0Kc?=
 =?us-ascii?Q?QWDbfhXkVdWI9bH2vm34zpXjc6kdrJCO12HH/Y0O9JdXo/qEqcTltpPam9xJ?=
 =?us-ascii?Q?KBiXgMaxnnSEwTEKdW1UuWznWyCZmfPz2qC0wkEIgZGQha+1ZNYMtXpwOpy7?=
 =?us-ascii?Q?8/PHAhi5EVzCpdQMT4E99Ggwwfi8mOMlxZF8RtJlFwb5fvSkLlHAP8XtgIlg?=
 =?us-ascii?Q?Q0/UaLnsZLE0t1qXX8jOiq+YRCQq40LzMluKU9+XACc6q5FxgCibuDbgE/xG?=
 =?us-ascii?Q?BLvM7f5nhStKs8dxHmq1F2Fdo2sCyMoIhM9arDvk0xVG5EQmEMEkI8Gc8/V9?=
 =?us-ascii?Q?6W9ifOpL4+msAnnPoOk8BesEJ6D5wH10R+XpEXH48gbHU0Lq9FgPped+vXjq?=
 =?us-ascii?Q?d6hZhti5Bj9gte6xHM2KamNcelMJrJmaPNs6AWbDtJ9zG/MdzzmxvEUjgGtH?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b84d3d02-6745-4c90-7e30-08ddf14f51b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:21:53.3904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmI6D0Ib2qP07VYwKbQRSS83092mY8pyRWOtw7dhzMM41lZiOOoVBlcqmD3F6gshsbaiONcVfkzOQ0gSdsr9MYd3ixiGkcUPFLkt6taLEWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFB6E746C59
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

On Thu, Sep 11, 2025 at 02:31:43PM +0000, Ciara Loftus wrote:
> Update the common rx path selection infrastructure to include the
> feature "single queue" which is relevant for the idpf and cpfl drivers.
> Replace the existing complicated logic in the idpf driver with the use
> of the common function.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/common/rx.h               |   5 +
>  drivers/net/intel/idpf/idpf_common_device.h |  12 +++
>  drivers/net/intel/idpf/idpf_common_rxtx.c   |  24 +++++
>  drivers/net/intel/idpf/idpf_common_rxtx.h   |  12 +++
>  drivers/net/intel/idpf/idpf_ethdev.c        |   2 +
>  drivers/net/intel/idpf/idpf_rxtx.c          | 103 ++++++--------------
>  6 files changed, 83 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> index 770284f7ab..741808f573 100644
> --- a/drivers/net/intel/common/rx.h
> +++ b/drivers/net/intel/common/rx.h
> @@ -131,6 +131,7 @@ struct ci_rx_path_features_extra {
>  	bool flex_desc;
>  	bool bulk_alloc;
>  	bool disabled;
> +	bool single_queue;
>  };
>  
>  struct ci_rx_path_features {
> @@ -278,6 +279,10 @@ ci_rx_path_select(struct ci_rx_path_features req_features,
>  		if (path_features->extra.flex_desc != req_features.extra.flex_desc)
>  			continue;
>  
> +		/* If requested, ensure the path supports single queue RX. */
> +		if (path_features->extra.single_queue != req_features.extra.single_queue)
> +			continue;
> +
>  		/* If requested, ensure the path supports scattered RX. */
>  		if (path_features->extra.scattered != req_features.extra.scattered)
>  			continue;
> diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
> index 5f3e4a4fcf..62665ad286 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -44,6 +44,16 @@
>  	(sizeof(struct virtchnl2_ptype) +				\
>  	 (((p)->proto_id_count ? ((p)->proto_id_count - 1) : 0) * sizeof((p)->proto_id[0])))
>  
> +enum idpf_rx_func_type {
> +	IDPF_RX_DEFAULT,
> +	IDPF_RX_SINGLEQ,
> +	IDPF_RX_SINGLEQ_SCATTERED,
> +	IDPF_RX_SINGLEQ_AVX2,
> +	IDPF_RX_AVX512,
> +	IDPF_RX_SINGLQ_AVX512,
> +	IDPF_RX_MAX
> +};
> +
>  struct idpf_adapter {
>  	struct idpf_hw hw;
>  	struct virtchnl2_version_info virtchnl_version;
> @@ -59,6 +69,8 @@ struct idpf_adapter {
>  
>  	/* For timestamp */
>  	uint64_t time_hw;
> +
> +	enum idpf_rx_func_type rx_func_type;
>  };
>  
>  struct idpf_chunks_info {
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index eb25b091d8..97a5ce9b87 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -7,6 +7,8 @@
>  #include <rte_errno.h>
>  
>  #include "idpf_common_rxtx.h"
> +#include "idpf_common_device.h"
> +#include "../common/rx.h"
>  
>  int idpf_timestamp_dynfield_offset = -1;
>  uint64_t idpf_timestamp_dynflag;
> @@ -1622,3 +1624,25 @@ idpf_qc_splitq_rx_vec_setup(struct idpf_rx_queue *rxq)
>  	rxq->bufq2->idpf_ops = &def_rx_ops_vec;
>  	return idpf_rxq_vec_setup_default(rxq->bufq2);
>  }
> +
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_rx_path_infos)
> +const struct ci_rx_path_info idpf_rx_path_infos[] = {
> +	[IDPF_RX_DEFAULT] = {idpf_dp_splitq_recv_pkts, "Scalar Split",
> +		{IDPF_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED}},
> +	[IDPF_RX_SINGLEQ] = {idpf_dp_singleq_recv_pkts, "Scalar Single Queue",
> +		{IDPF_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, {.single_queue = true}}},
> +	[IDPF_RX_SINGLEQ_SCATTERED] = {
> +		idpf_dp_singleq_recv_scatter_pkts, "Scalar Single Queue Scattered",
> +		{IDPF_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED,
> +		{.scattered = true, .single_queue = true}}},
> +#ifdef RTE_ARCH_X86
> +	[IDPF_RX_SINGLEQ_AVX2] = {idpf_dp_singleq_recv_pkts_avx2, "AVX2 Single Queue",
> +		{IDPF_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256, {.single_queue = true}}},
> +#ifdef CC_AVX512_SUPPORT
> +	[IDPF_RX_AVX512] = {idpf_dp_splitq_recv_pkts_avx512, "AVX-512 Split",
> +		{IDPF_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512}},
> +	[IDPF_RX_SINGLQ_AVX512] = {idpf_dp_singleq_recv_pkts_avx512, "AVX-512 Single Queue",
> +		{IDPF_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512, {.single_queue = true}}},
> +#endif /* CC_AVX512_SUPPORT */
> +#endif /* RTE_ARCH_X86 */

A minor point, but I don't particularly like this form of init for the
array. If it was all in table form, with each entry on a single line, then
it would be ok, since we could have neat columns. However, since we are
word-wrapping the lines, I'd tend towards having one element per line and
using named initializers.

