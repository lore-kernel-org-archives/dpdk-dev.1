Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD645EB4917
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:49:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E92D94027A;
	Thu, 12 Feb 2026 13:49:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3F9F140268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:49:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770900589; x=1802436589;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=T8/cMKn2w4sSrOo2sERvohYVxZfzCmQeF8JSrlegqXQ=;
 b=KG6gJt83Ao+ld39AnlNwyaJvMPOVYcsdJ3u34XL2Frk/lHrQ8h6gZULA
 VpP6LPKo0zauL4uQnL2JxOb05ntYvHP7a3BHN+25KwcuKRBXBlauWdb2T
 V70qCqUnOyvUcUrSObJbNPq2xYYqDm6BLwF04v5hHPu+bE3oyV1l26Lyb
 ocRLzb/RshK4JE3/SGNfNiHSwXgeA2LSMVAI/J2AFfsOumwEtW94mUia7
 ig5+cg8tFbyxok1ufJI9WrK7U4zsTz8eBg5o1ksrB3MTGPZXFt0qWEgFg
 UdHrkwPewGMFMB0j3qpAgz6ABuFWa8Rkjm16y9zxYOBK4IaL0peViD6oh A==;
X-CSE-ConnectionGUID: Is2iNKwEQNC20lPVEvzggw==
X-CSE-MsgGUID: VLqwJfIRQoeb3m6RvqD5TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83438137"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="83438137"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:49:48 -0800
X-CSE-ConnectionGUID: PW16dkXLSNKRNL94CPVCvw==
X-CSE-MsgGUID: 7LK3TBzdRVmu92jbeMaemw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="212100087"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:49:47 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 04:49:47 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 04:49:47 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 04:49:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7Ur05YCT2JLkactoo2rhSbvdbZDRw/tyU1g86e+6j4M46Swj6+lZ3S/VUNGHIOLocZS8uj7froym4TAP8lEVZVJyCWu6FRCcZsUgWm1gLSkxYVxwK7JqSdoIq1xsbSNXKWq6oAaIlo+traMjFJj07SLurzAGG65wsc3HUW8BJeu7EluovfLCLKPcUUC6Hj0JFC92C/73fR6FULCV3Os1It8BuSSmnc5iVvRpGJJtn8lwhE0lq+EG0oNJZlK1p0fw93yQDIUPty1hCX1Gm240zZnvS2KFooUOnTmSnh0QtqmRCxVQENHUeXmo9Vk36kJQljwMsNN2LX9WLSXc4FfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDdgp/4m1YVkSt+fEZhPKpwGNGZlq4VPEJSYG5u/dIY=;
 b=sOOtVO2KuhtFbU5m6hARGK2nvgSu7pewX0p3zDpUj8ydaMua/S1p569GxzrPqvsdBwZwi+5wOonq1S+rCU0ihwJKRBxGgOEzLPqF7rJCc/wVl7DyJh95fZB2ahz223EacUKq4+ffa/zgJL4RiUaOONdnvtSCTj2SMNnZjGGk5lTL2EqBlyLxjxsR8sBnGT/0sRf1yv8J7cc+ueVAt9NPsknfv9KnkldimBbYFEha216zNGwfWxzLZaJfA2+f4nRFo+wWE0vkIOpyU6Anwk4pQM6faI83xLk+SWu1LZPYRTIrAwn0kXaBFjWs7oGCwE0bTDVF1bxFkgDvrMPVsnLBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 12:49:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 12:49:44 +0000
Date: Thu, 12 Feb 2026 12:49:38 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mingjin Ye <mingjinx.ye@intel.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: enable link status polling
Message-ID: <aY3MYsnIFCZwpvwb@bricha3-mobl1.ger.corp.intel.com>
References: <20260212070302.2480480-1-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260212070302.2480480-1-mingjinx.ye@intel.com>
X-ClientProxiedBy: DU2PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:10:232::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 95cd6f38-3269-4192-795c-08de6a353256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9EFV/7jL8QADsvpFCP+Vt3fLPqHbiQTwu8Nu3HbqJpm+X6fOWxIGP8rIA0Os?=
 =?us-ascii?Q?qqUaZVB4Ogv3Q5XtqhCC/xXGzJPrP0dDQBIcIUkr7/Ka9BhD02X/Wp8s6lxd?=
 =?us-ascii?Q?klPNwba09y75EEv/+AM+E7AdTk/aJ+0ML2olxNHJG7+Ql4Gjf94QuMSANkrx?=
 =?us-ascii?Q?b9XnpCIFYLFCEZeuPQ7BzmsSQhFu7TXaBwxVoGmXOUeP0W4SHw6D4l1ctGEs?=
 =?us-ascii?Q?CV26EhMWcCliC0EKH8bzYyOC37X+2b/3/mZH7fwjW7BXK6qJMoyrOiY7Nh9h?=
 =?us-ascii?Q?TzAoWyuihI+ZTZSaL7I/THpkRe9Ar6MWrhCyJC0IyqB5St2/pygkBO/Md5pF?=
 =?us-ascii?Q?3sW9jgRXmZi9CZWBe/skFEq80IqWURm/JyFaw9RoIsTEr3Ku/OGsWiQ9Ju3O?=
 =?us-ascii?Q?qAi0MpD8RXa4IjiernfBoh3H6+be/oqoTtqGzyYNq1fQu1TKT9qBjxqlRYH2?=
 =?us-ascii?Q?hiqHsia5pwvv/viff5KZ3uvDa23N7JXXT9zWYiqGh1ynOdCQIMLDKIf1CvM9?=
 =?us-ascii?Q?DIwI72TVg3DJBG8a9yBfrgtA9F5uBGdPuFqdAa3eDSbZXHk2oTHGPpBCHaNc?=
 =?us-ascii?Q?OtPCjT2hMQFNkx8Y9GBSUFx0sUJ8h4pf7TQGwWyAgZ05OKyS/WOdyo6fDnGl?=
 =?us-ascii?Q?3RdDrEaLBjp6mTlea3iBCgKPn792mFN89KOrxDGW12/4wQrR2Bp4y7JDWLXj?=
 =?us-ascii?Q?f8fWrHJIx3QbMumrg08fnJ2ktbdG0uV+0ja1isSrTe3nUwcYkyZzCTeYhxOj?=
 =?us-ascii?Q?CLtI+5O3HLzFUPqYyxBMOjdP9Nlqe2yPqM0eadIBuqtL7ADgXiw4rTnshcis?=
 =?us-ascii?Q?sVA4s7yNBMtbMgxLIZxjvwEhSCHjALqEnUWX6N9BdmPLIf8B4Mjdq+vGEKen?=
 =?us-ascii?Q?JJ+FZTz4TqYUhrZ0EP+A1OZNAwkH3dG12h/6eX8VzfZz/InrpKo2pfY7YQ3S?=
 =?us-ascii?Q?CTEEgG9FKXyHWvbc5cFdIsdlCzMmpZdy700zadASw/CBlQWN5JC0DiAxIq+M?=
 =?us-ascii?Q?UAqOgr2ZhjqihyWo4zmGph4bH25S7Y7Lu7M2sco2A21Me2YTO+msPsTwP47q?=
 =?us-ascii?Q?N9vOC5cjGzcSUk/pUbrqD5brLR+GAGLQcU38IqtDbhqG8jrttwkJmSF/VPMv?=
 =?us-ascii?Q?BimHI2p7CoQ74EcaML/i8Xg5gpwa7weiUFpIRkVYhHiRF6lqeboiP6ift4D3?=
 =?us-ascii?Q?WOLFvrWMN8KlZUrekZOcZwF4xx73KOQeeLFqeFA7aq1cOWHsY+pgNIeq+G8J?=
 =?us-ascii?Q?reQEt0DQ7wNuQa5A3KI4RU+i6cHzKUXz9qDhtPLNgZ88ChJvQ8azZBJ2y1xn?=
 =?us-ascii?Q?SvBh4aOXPw9IkEBenKEtpjqgIKLJj8iQceDsAiIwySly4k9r8IzwfMo1Y/4L?=
 =?us-ascii?Q?LEvDpczuj/5zf/7lsQyD7z5fv26ba/2GsrZ6fV4WvLouKcWtz/Xp0FeuZqA/?=
 =?us-ascii?Q?UxhsBgGJpWeGdv/+KBfp3rfENOxgrvLsmCQtzEVpusBmt/uqi8snoVmqBa8l?=
 =?us-ascii?Q?+Warm/qLyDYJnjAgnGYxcmHFXXKxK2mtkU5vVJkwtg1SaDhR4qlvjBoe8DfZ?=
 =?us-ascii?Q?KPPnghXji/N05H0R2Tc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cfy5vZiF02fhXPoGtYs/JW3oeDB4+m6nfyfrs7VU8NKeiAuG7yWGI7wjQ+RU?=
 =?us-ascii?Q?30SNmYjpwPyAkzB9hTWxTBBHzsYd1w3BuZSME4X7254GSZxsAG0qn7sOvR6i?=
 =?us-ascii?Q?/Tcx7d+E7Ui6auA1eXzEucWdKQKHDB3R5sZYPLwpI7UqNRs0TF8+bmR8TIwB?=
 =?us-ascii?Q?gucMJjKAua3kPJxQiTQ1IwB8veo98hhdmYtt1uUJ9HS3xjk+PP6A1CtSv8Mb?=
 =?us-ascii?Q?mO+c5+BiRysSqJiElFVOYMl+vBLKixbipM4kA6tVpwIBOfksbzqiOSBm2Dq7?=
 =?us-ascii?Q?x9tpQIiAPp9/Lx/i3Vf+NTHlxxZvxmdAgottpa4tLG61NllNFC1/3AiqafYg?=
 =?us-ascii?Q?c9YflD3HiKGM/L0h7UqtqGwVdiaA0xDM5svGfFfRDiEgf9xSqZQDutMG/N8Y?=
 =?us-ascii?Q?RogaNg/Q/hwocqe/0ACYrZyhXQXNex+90iKcpXhA7staz9PKNKohsHsVEIU3?=
 =?us-ascii?Q?+eove6cANQoBZG9CNKdQ8q843AbCr4lrZitBC4UtugJEmwmTEw715FlVoMEg?=
 =?us-ascii?Q?KfwNH3CCQoNIvlTmiydijfKRRfjZSN8MGJeH0qlBiYOENZNmASaZtKR2oAuY?=
 =?us-ascii?Q?/ENpmX+6G5f5F0u7RgcSSWiXNF5ms2MQOHbFecl2N8p2RrVwNWvKeAQRs6g9?=
 =?us-ascii?Q?ekkPgmd3hyr0c9YrnwOgcdGHw72JaMM1dhIL0P7cSo3Y9bkc5gFZZwuARtTC?=
 =?us-ascii?Q?lq5qQd4pRFB09XpsVK0PdoV0WiyT/3qcfmtaCgmSxJx2Amxbv5CWgBy5s9L8?=
 =?us-ascii?Q?81Oj96iyBKMAkqtVLz6BXCxJepU7E828FGNjxBo2bsrTMlP8+Mg5D/X3PloD?=
 =?us-ascii?Q?yBnETLXLJXKOTxnQAtjowaQXQQfTsyuFFB07fpHzICfievbBM3JGHQtFHdGR?=
 =?us-ascii?Q?jTumiHjuFleNg7CQf38ISu14b4deGpzSLZhjshuEPhveFEPGHk3HwWnqzAV3?=
 =?us-ascii?Q?V11TBKf8z/nYVNS6ebhWSmsiGKqLDcJ7utyPyqQL6Up7SQKXSXyT8zDxe9GE?=
 =?us-ascii?Q?eNcf9hd6tP3cwE0iNkgssK513mM1g4lBW4iZEb21+zx0NYP7yQvriGgxFaGj?=
 =?us-ascii?Q?c0CT7kOoPwb3DtaC+2DWTq662A2eJ2r91Ckp72b/rd0ZxIfn4mR+/ft2UIgb?=
 =?us-ascii?Q?Bk+KP7Fs9rHlgLMFMay8feulImRKWj7XjZha2ydZn6Fy76DWq9ql/v25a14e?=
 =?us-ascii?Q?f8yQp9b80LhZMrgKlq219YhufHtqUWGyCFnDjfMrbUynfT8FXi8xOtmfQEqR?=
 =?us-ascii?Q?3VBhctIW7mZ8JnCOnFyJ82359HVo8khNV6EEPyYatLvIff+aHv1Sp1ecYbE4?=
 =?us-ascii?Q?vf+H2TkMxqUMMh/EFnEebZjz4EpCRE9lqEOd/1uLdZTiicZv3yqxcHCPIN6y?=
 =?us-ascii?Q?K0HO7gV0Bu1ZtCN1R4QCV8cAcLQNPWvbx6Yv0GMGjDUUQul9TLp/KqMVpM4T?=
 =?us-ascii?Q?Jv1hHN5o8dM0Ofyswm6AXOnImnFxUzeKSrb8EULvarV+J2oKiSRmfBAtWm8F?=
 =?us-ascii?Q?Zf8/B1pNI/YdYJgyDYriIDUqjF8M13Qm2tvQ+RM6+9e6tBe68WyIqILQ0sGV?=
 =?us-ascii?Q?WbEuP4bHXrCyBfJYFum5sIKYp9zia8Cqzhup1/bsqlEE8tvmj1xx6gMTR9YJ?=
 =?us-ascii?Q?zHhx84so2cCsI1qfLetFXy3Pqutd/gjqXZLoRmAFnu9St7+/3FoF3ADb1u6j?=
 =?us-ascii?Q?Eemx73PXfDDDCXaq2KL+VAkZi9qEXijVCw0xazeRVswtn65Evfhduo9iPqsL?=
 =?us-ascii?Q?K4r/ln5gtJnVWdVyBBbpiCRRCUCLb/U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cd6f38-3269-4192-795c-08de6a353256
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 12:49:44.6325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a92xMzq/PHaJYVQARC2K3ZqAJBA799Gsa2OaxBpMYzsbRCN3WyfJzpUrAW5BJyZwEbAuhw9dMEPGiouizb87OsdYWsKHYDsgo3sV6qwEdXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6999
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

On Thu, Feb 12, 2026 at 07:03:01AM +0000, Mingjin Ye wrote:
> Add the `link_status_poll_ms` devargs parameter (in milliseconds).
> If greater than zero, ICE PF uses an alarm handler to poll link
> status periodically.
> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>

Hi Mingjin,

thanks for this. See review comments inline. Nothing major, but they do
need to be fixed before this change gets merged.

/Bruce

> ---
>  doc/guides/nics/ice.rst            |  7 +++
>  drivers/net/intel/ice/ice_ethdev.c | 95 ++++++++++++++++++++++++++++--
>  drivers/net/intel/ice/ice_ethdev.h |  1 +
>  3 files changed, 99 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 216c79b6f2..0eded96826 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -382,6 +382,13 @@ Runtime Configuration
>    * ``segment``: Check number of mbuf segments does not exceed HW limits.
>    * ``offload``: Check for use of an unsupported offload flag.
>  
> +- ``Link status poll`` (default ``not enabled``)
> +
> +  Link status polling can be enabled by setting the ``devargs``
> +  parameter ``link_status_poll_ms`` (in milliseconds). If the value is set
> +  to 0 or negative, polling is disabled.
> +  For example ``-a 81:00.0,link_status_poll_ms=50`` or ``-a 81:00.0,link_status_poll_ms=0``.
> +
>  Driver compilation and testing
>  ------------------------------
>  
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index ade13600de..ae891caca5 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -15,6 +15,7 @@
>  
>  #include <rte_tailq.h>
>  #include <rte_os_shim.h>
> +#include <rte_alarm.h>
>  
>  #include "eal_firmware.h"
>  
> @@ -43,6 +44,7 @@
>  #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
>  #define ICE_SOURCE_PRUNE_ARG      "source-prune"
>  #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
> +#define ICE_LINK_STATE_POLL_MS_ARG       "link_status_poll_ms"
>  
>  #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL
>  
> @@ -61,6 +63,7 @@ static const char * const ice_valid_args[] = {
>  	ICE_TM_LEVELS_ARG,
>  	ICE_SOURCE_PRUNE_ARG,
>  	ICE_LINK_STATE_ON_CLOSE,
> +	ICE_LINK_STATE_POLL_MS_ARG,
>  	NULL
>  };
>  
> @@ -1482,6 +1485,38 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
>  	rte_free(event.msg_buf);
>  }
>  #endif
> +static void
> +ice_link_once_update(void *cb_arg)
> +{
> +	int ret;
> +	struct timespec sys_time;
> +	struct rte_eth_dev *dev = cb_arg;
> +
> +	ret = ice_link_update(dev, 0);
> +	if (!ret) {
> +		clock_gettime(CLOCK_REALTIME, &sys_time);
> +		PMD_DRV_LOG(INFO, "Current SYS Time: %.24s %.9ld ns",
> +				ctime(&sys_time.tv_sec), sys_time.tv_nsec);
> +

What is the purpose of this log message? It just reports the time without
giving any extra info. Can we skip it, or else expand it to give meaningful
information, as well as reducing it to DEBUG level?

> +		rte_eth_dev_callback_process
> +			(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
> +	}
> +}
> +
> +static void
> +ice_link_cycle_update(void *cb_arg)
> +{
> +	struct rte_eth_dev *dev = cb_arg;
> +	struct ice_adapter *adapter =
> +		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +
> +	ice_link_once_update(cb_arg);
> +
> +	/* re-alarm link update */
> +	if (rte_eal_alarm_set(adapter->devargs.link_status_poll_ms,
> +				&ice_link_cycle_update, cb_arg))
> +		PMD_DRV_LOG(ERR, "Failed to enable cycle link update");

I'm wondering how best to handle this condition. Logging alone doesn't seem
sufficient.

> +}
>  
>  /**
>   * Interrupt handler triggered by NIC for handling
> @@ -1499,6 +1534,8 @@ static void
>  ice_interrupt_handler(void *param)
>  {
>  	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
> +	struct ice_adapter *adapter =
> +			ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	uint32_t oicr;
>  	uint32_t reg;
> @@ -1533,10 +1570,19 @@ ice_interrupt_handler(void *param)
>  #else
>  	if (oicr & PFINT_OICR_LINK_STAT_CHANGE_M) {
>  		PMD_DRV_LOG(INFO, "OICR: link state change event");
> -		ret = ice_link_update(dev, 0);
> -		if (!ret)
> -			rte_eth_dev_callback_process
> -				(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
> +		if (adapter->devargs.link_status_poll_ms <= 0) {
> +			ret = ice_link_update(dev, 0);
> +			if (!ret)

According to DPDK coding style, this should be "if (ret == 0)". Since the
line is being changed, might as well fix it.

> +				rte_eth_dev_callback_process
> +					(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
> +		} else {
> +			/* With link status polling enabled, "link_status"
> +			 * updates are confined to the alarm thread to
> +			 * avoid race conditions.
> +			 */
> +			if (rte_eal_alarm_set(1, &ice_link_once_update, dev))
> +				PMD_DRV_LOG(ERR, "Failed to enable link update");

If link status polling is being used, then do we need to schedule this?
Certainly if the current status is down, we are probably ok to leave the
link up notification until next scheduled poll so that the link has time to
stabilize.

However, there is another case we might want to look at here. If we
previously had a failure to reschedule the alarm timer i.e. the case above
there rte_eal_alarm_set failed, this would be a good place to rectify that
by trying to reschedule the update. More specifically, rather than assuming
that if link_status_poll_ms > 0 then we are polling, it would be better to
have a flag that is set to indicate that a poll is scheduled. On start,
when the alarm is set, we set the flag to true, but clear it to zero if at
any point the alarm setting fails. We can then do recovery here, AND also
do an explicit link update if no alarm is scheduled.

For example, instead of "if (adapter->devargs.link_status_poll_ms <= 0)",
change our conditions to:

	if (!adapter->lsc_polling) {
		ret = ice_link_update(...);  /* do manual update */
		if (adapter->devargs.link_status_poll_ms > 0) {
			/* we had an alarm set failure, so set new */
			rte_eal_alarm_set(...)
			...
		}
	} else {
		/* we have a scheduled alarm */
		/* do we need to do anything here, 
		 * or explicilty do one delayed update?
		 */
		...
	}

> +		}
>  	}
>  #endif
>  
> @@ -2381,6 +2427,25 @@ ice_parse_mbuf_check(__rte_unused const char *key, const char *value, void *args
>  	return ret;
>  }
>  
> +static int
> +ice_parse_link_status_poll_ms(__rte_unused const char *key,
> +		const char *value, void *args)
> +{
> +	int *num = (int *)args;

nit: no need for cast, void * can be assigned to any other pointer type

> +	int tmp;
> +
> +	if (value == NULL || args == NULL)
> +		return -EINVAL;
> +
> +	tmp = strtoul(value, NULL, 10);
> +	if (errno == EINVAL || errno == ERANGE)
> +		return -1;

For safety, I think you should set errno explicitly == 0 before calling
strtoul.

> +
> +	*num = tmp * 1000;
> +

This is functionally correct in that it converts the ms value to
microseconds for use with the alarm callback. However, for future
developers, this is terrible! The variables used through all have "ms" in
the suffix, which means that you are telling future readers of the code
that you as passing ms values around when in fact you are passing us ones!

Two possible fixes. Either:
1. rename the internal variables to use "_us" rather than "_ms" in the name
2. remove this and do the multiplication when calling alarm_set each time.

I'd tend towards option #2 here, because if we do store a _us value - what
does the function get called - it parses a ms value, but returns a us one?

> +	return 0;
> +}
> +
>  static int ice_parse_devargs(struct rte_eth_dev *dev)
>  {
>  	struct ice_adapter *ad =
> @@ -2469,6 +2534,12 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
>  
>  	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
>  				 &parse_link_state_on_close, &ad->devargs.link_state_on_close);
> +	if (ret)
> +		goto bail;
> +
> +	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_POLL_MS_ARG,
> +				 &ice_parse_link_status_poll_ms,
> +				 &ad->devargs.link_status_poll_ms);
>  
>  bail:
>  	rte_kvargs_free(kvlist);
> @@ -2902,6 +2973,9 @@ ice_dev_stop(struct rte_eth_dev *dev)
>  	if (pf->adapter_stopped)
>  		return 0;
>  
> +	if (ad->devargs.link_status_poll_ms > 0)
> +		rte_eal_alarm_cancel(&ice_link_cycle_update, (void *)dev);
> +
>  	/* stop and clear all Rx queues */
>  	for (i = 0; i < data->nb_rx_queues; i++)
>  		ice_rx_queue_stop(dev, i);
> @@ -4398,6 +4472,8 @@ ice_dev_start(struct rte_eth_dev *dev)
>  	struct rte_eth_dev_data *data = dev->data;
>  	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct rte_pci_device *pci_dev = ICE_DEV_TO_PCI(dev);
> +	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
>  	struct ice_vsi *vsi = pf->main_vsi;
>  	struct ice_adapter *ad =
>  			ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> @@ -4474,8 +4550,19 @@ ice_dev_start(struct rte_eth_dev *dev)
>  
>  	ice_dev_set_link_up(dev);
>  
> +	/* Disable interrupts to avoid race on link status between callback and main thread. */
> +	rte_intr_disable(intr_handle);
>  	/* Call get_link_info aq command to enable/disable LSE */
>  	ice_link_update(dev, 1);
> +	rte_intr_enable(intr_handle);
> +
> +	if (ad->devargs.link_status_poll_ms > 0) {
> +		if (rte_eal_alarm_set(ad->devargs.link_status_poll_ms,
> +					&ice_link_cycle_update, (void *)dev) < 0) {
> +			PMD_DRV_LOG(ERR, "Failed to enable cycle link update");
> +			goto rx_err;
> +		}
> +	}
>  
>  	pf->adapter_stopped = false;
>  
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 9562b2b8f1..781fa3d6ae 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -631,6 +631,7 @@ struct ice_devargs {
>  	char xtr_field_name[RTE_MBUF_DYN_NAMESIZE];
>  	uint64_t mbuf_check;
>  	const char *ddp_filename;
> +	uint32_t link_status_poll_ms;
>  };
>  
>  /**
> -- 
> 2.25.1
> 
