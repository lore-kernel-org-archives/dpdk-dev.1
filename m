Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5995C88E4C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:51:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3BC340269;
	Fri, 11 Sep 2026 11:51:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by mails.dpdk.org (Postfix) with ESMTP id 5AB8240264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:51:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789120301; x=1820656301;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8myv1gjotWriX3Fy0rrWm5rLrC4a4y7J460WtqTlD+g=;
 b=LXQ3CuD0SlEvqNF4ayfJekIfhwSCZQ7cvEC70E86fFQA7aF63yVb7qSV
 1TaexuVqobiH7hiVcDNOWHDm8Ce31+iNvKpB20XuiAhNxmHwdbzXiXR1k
 Mdy7I0Z8o7tQ7V2EjgWVxc4qY70mINA8gM4I+rlZt1WcOPKGZWVeBLZpS
 WkpCLTwtw/m5ZqaicZ4ZcDlQaypgk2dewP/6PUjxhpvOILBdsihXf5wSH
 F/fDXnQ89lOJGyau+NhsUeu4HY+etS5nrJSVklSzgaaOJVv+kcku9rv+n
 j6o9geH/Nef0HPUwJaqT0MoC+oCEL8KlVymlZ9+d9g+oQaC27Ab3M4TfB Q==;
X-CSE-ConnectionGUID: 61uepDqdRUWM7GGh9+AucQ==
X-CSE-MsgGUID: YTnrh31PSxy9L/U0GrvVwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89844"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89844"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:51:40 -0700
X-CSE-ConnectionGUID: QDL5Tgh8SqmayyyWDthg5w==
X-CSE-MsgGUID: B6f637ntQoiGg0Xnocb/xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="170624"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:51:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:51:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 02:51:40 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:51:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxe4+yA6SsBwlkutVQOHpXJlHipJliwCL2YMMoi8ouX4Tiey7qXFZo/ij/XkkUPwHOAxVClqlf/NPlA+47I1xxW4TLCah1UucxkR+8YZ8bIh5XLzedZvO7+vLG/vE/gnAKzTkxRKB6WDT4DWnl0GL08m/z5jI33vA6R+U0BbX72ylYc8rvlF2Nkc5ggro8OD+ysr00MqAk482UQ4pYrRmDxXzLpZsjnKgaIlNgYT8BPqte4qH/eE/ybL0jXPCF1mHPoJMWKsFqlyz++7dt7HNyuNcO21Oth1TQU2GJUP0ub9oy8/J91O6tO96OisBVJWWelczp3vesXGo9aWxQKh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak3BhjiFxV3WzQnarwgsivodbEN5tsbhgrNGmW2dRTo=;
 b=HDYSnNr3KnmkvRphJ+6oU/ktP7C2UVQYbMQsvuD70B1Zhpu9IX3hsfmU0deS3gBSgPwR3wekJzdUclilu1/uXdSVEfKjyqUv0/3oDiEHw75xnRNCFbYhG7YU9km9ufUBuf+Vj76x/U/6jSpD1nEuGWM1chpNS00QE3lFzUFFTfgYgtUP3Je819md5AaNu4AkdssjlHZtb/9h5VifJB8tO/CtZx6YfHd3tLEXqbxL5qLtw/loupNDK5+3V5xbWQ373UrUIxN4oeA2EyUfY095bT8ZEZjj2PVyYFmigqQ5VKtlN16gXqbadnyOh7YnMgu5LUb0WNkJlm9mSFd5kpfSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV2PR11MB261624.namprd11.prod.outlook.com (2603:10b6:408:413::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:51:37 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 09:51:37 +0000
Date: Fri, 11 Sep 2026 10:51:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Yipeng Wang <yipeng1.wang@intel.com>
Subject: Re: [PATCH v2 65/68] efd: replace use of rte_memcpy
Message-ID: <aqPPJemyLyXk4rvO@bricha3-mobl1.ger.corp.intel.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-66-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-66-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0347.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::20) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV2PR11MB261624:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f0878c-6c5a-46f4-ddca-08df0fea459a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iu3bVWWGY5AnYLABdP8Sh34VerLJIH1Z/ySzpXoARVCEW7H/zg7HPB6bQwlJi1kxJ5pjzlLfR/ypgzHdLu4TUEQYX+k6PmAq29fzZK7QF3RrfedH2js8pjIkX2yEFczHporiXtuY2TBZrJBA9EHevXRdBm6tdMiwbL1esr1NADrgEG6L+nV8XxwvdM5DpxUs35qLc1m4iUTK3LRMVMvDuJHthTZlWQT9boV8i/446EzVz2f8cwyx3IUQYmKI0GUDmWrn25FcsdLbUtvmX923eJpqE9YtzrpBrgZ3nYMm835xH5YRFJ8y8BNCdHA02qU3E3tGZcvmiTWpnxIySjCjYrvhOeZCWWmmvazmmIImvWNWykGux3BWubeGx5XmRik+g/K7Rc76eBmEK9x2CoBccM56LaBXcYc4YOYEamgXCuSqbYyEuk2ECWsyXluX8dMV8kNzLdZViu3cAle4IgHVJBZ9pGSgTK6v6w7jJO1DdGYmuqrmXTH3JLuSFwlYn/G8z6cKv6bn1N3yT+cghjdHkCDUQNTxcFwWMBFrYbg7OarE3Cf7NSelJkxd0d+gCcnZmtbyR479EcsYdwDblYeN7vcFTSMq8sQG+yDNm3evEXBXPFnD+Ai6nai6vjvGvJXkaVh3sBmumZxWSimZ7dl/5dyBcNgincpzxaNco8NCsXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mR/0aZH7gWOHqHOoP53LrxWZabp2bfY2REPRos7ruPtSAL7yI/ubyTpu5000?=
 =?us-ascii?Q?wJ1Sh/sbCgJA8MtlkHl/JgglFx6Lr5J7bmJGrMCjzcrDs7GOPexQvldISdam?=
 =?us-ascii?Q?Esc0R/0FhM/vR98a9bm5cidGBRStAHFR4tnWyT5jnOc/8PZZSBWUMVKIwqzX?=
 =?us-ascii?Q?wKqQP7CVzcac9+HGcZQFzZe33+wLkC8k1FwqzFXjyu13XpFH6HXXsN2cePmT?=
 =?us-ascii?Q?dSNr82Lr0oXJHE/vT3WZrJUwtMypNN/sk8D1sakHKXTfpTzXq0l+l3bMeMCD?=
 =?us-ascii?Q?UFpcE7Lsa26glupD/gdKj/jbOQkgyF71nOLPgAYA79qEZORCn6QgKtDVB8G4?=
 =?us-ascii?Q?n9godkt95FiaIFIoAHv0OisU1v0X2Dn/drECjcayQKJw0TVHYF+DaaILBRWS?=
 =?us-ascii?Q?Gt2Gp3b2VzEj8asxXBH+jBHOIGbJDtG4KvzCHkzBJ6xDgpQzmjExnaA7q7nE?=
 =?us-ascii?Q?rEeN6/zwHEQhMk9jrJmFQ8BWgRPxLQomawnaScUf9MXSIcbDSelXZ8iVHii2?=
 =?us-ascii?Q?z4a+7s709Et7sduoj/SNsIFByqCFCWhG0jfJZ3KdNKD0HR1e6B7eKQy9+c+9?=
 =?us-ascii?Q?9fuPhWjwK+YSDkX6xMOoVLAu+/MFYJ7t6BRgRa4Y7ppewdVLg21OKV6OfqOg?=
 =?us-ascii?Q?ysci0OnUq1X2HWop08DOwmafdHuztv2SzMvFhzR0v2/9wDDAxq9Q/MnPM0ae?=
 =?us-ascii?Q?h6F31ApYgYdfG/uaKKVorTH/pGI/O70HmGWTllMRlvWC199iNey5nFESyOVO?=
 =?us-ascii?Q?wSXq20MjtHW0KdKzhxszJFtKgqIvgdU/PO4ix4oWBQM+bPbymRfKMSi3PRY9?=
 =?us-ascii?Q?lYxnPvcFiQVfpGuiy7Sn0WfP/v9hRQp5oEW419AYiOBfV79r0qTrjTN0A3mR?=
 =?us-ascii?Q?/iBcADHfE8Yix+0oZoOywb0N64f4X6xzJBs6TUJoL5OIsboMVW0MYIUq2cBJ?=
 =?us-ascii?Q?7YVLDEZDDuUwrJWQc81f/CZdb6BiEYb4g+V6OXeg4YlMm2p+3lgJx/ba0j+z?=
 =?us-ascii?Q?lbijAZrYhX5+i1+MNZIrj83m9ETT9EvxgNZONXugMiees8KOifCLLzXiq4cO?=
 =?us-ascii?Q?Y1Ijs5pTDa9CESIHNCEbUunrQBUUPfbpqn1m9pmQ2jaVzBZ6UJxwVGBU1AAf?=
 =?us-ascii?Q?1XkG7mUhUvGgPsvOxg1HsNHWwAsKliklFUxbmVU9XcANG1MdWvHVT9L0sW10?=
 =?us-ascii?Q?f47rDbiZteaVwhYxKchlDUqPN881rVqFWomJZ8ZgB/MYxQ+PNEvQTQ0qQlYZ?=
 =?us-ascii?Q?P5FIdip0vjBSGfrhenTf0g7qkCX3yvXS8TmMLpqgBK4yliMfw/OulaH5nFWZ?=
 =?us-ascii?Q?kBezAwmgNp5/gR/tihKPthSfH+6q0zbM9mwmbshyNRWygseOrr39ql4iU4J2?=
 =?us-ascii?Q?Tq57ppgM0eZIZVc/2ndNdK/ZSqEo8gK5XpOsL27KEWPhHNUbNifggo2NRTxu?=
 =?us-ascii?Q?4JQPJfNYoCX/uSqD8g/O3NikPxEuXVcHTAtqPXi2IiyVDXb5rxtEpE0gsbPh?=
 =?us-ascii?Q?v7rs7DBg2db69fS4wl4lCMrVnYJq3kqwaUiDmZMwRQiP+NAIaGhiPHGxskl2?=
 =?us-ascii?Q?9RptvwNfCU9YiVrqd5PGianiLt6FtBZD0bLlJiOXnqatWwEb7jq4vtwkCB+Q?=
 =?us-ascii?Q?ZOPTzo8S79jRMndp1DOtWMBLlX4H5Yu8qJ6co1sguiKTQtX8aTgHHbSg1ZW9?=
 =?us-ascii?Q?D1E8F+ECp67Kl+df0Wlqm+FTS+iWtaEanYLf69XHdHbdmvY/hoqKpWyKXG1P?=
 =?us-ascii?Q?tZF84WMP4JYtLF9KL3xGw07wDP+USV8=3D?=
X-Exchange-RoutingPolicyChecked: LxgU/lknfCIous6qd2LXkDkiTPuPsRZq8nvmTYhSQ9uyp7k/6EWaeZljXMkCTbTWpJWXWQm75qdSWK0kFOwatn17nAnKDszNA0jJFdnmV8/IWiT3utGgrbOnEdGgknQNiGxY80PtluxPGOjDYeawKRWbtY6RPo8LimLCEoLLWlasS04bVxZ0wAMwObWwuy91rXafgja2oyswnX+qctxuZ+aQ4zz0WyHH9QveDNJG3obKDzDWT1iZT71urFeFl1Yy5IhOjG9ZBTyPEqKmTLdLYgnubL0CvkSM/XOQAe6IIqvupX9/wzlr89iaI8N4q2gQuOPZw3zkw1MatK5HeyEnTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f0878c-6c5a-46f4-ddca-08df0fea459a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:51:37.6273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6VAGeAvsqLB6zWDxV/sd0w6cxzdy4jKccizMDcoq4GJ2q2m6gOQRYQfz/i2iRP4+gEB4FLai2EVwX4vweRZCFst4Im3JPvCuu79xJPQCk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB261624
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

On Fri, Aug 21, 2026 at 12:25:00PM -0700, Stephen Hemminger wrote:
> Copying small key with rte_memcpy is better done with memcpy
> which enables more analysis checks.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/efd/rte_efd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
