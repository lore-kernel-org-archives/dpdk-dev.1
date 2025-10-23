Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3390CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 16:14:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3448B40151;
	Thu, 23 Oct 2025 18:14:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6533540144;
 Thu, 23 Oct 2025 18:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761236044; x=1792772044;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RlG8fbrMp3ABKseNPZ5WSZ0KcNmY7FQGB8jg8aq/d1Q=;
 b=bGCDz4UHtcl1BVcXYtTv/Fz0nYFZ5hvsis5hvpdkVJkLfxz+WxK63fog
 hWZg2EnjvUUgkG+OjGFCGf/+DNriA/w2iWV4ViSRykjGjg6XID8DNtqr9
 9Y+u9g5WeHvJvpK7VRT329Hx69Jm9zUxt8rQgagFR0hXqrxuovpUf3UNP
 rHef0p709gUQGRKz8ONqHAXVI1SY1dZUoWn1B/sr/RA/3lIkgC9z7//4r
 c1g1oJohQsLmpoMZDudQtaD/nl1Bd9f/36XYOu2l5yHzJZlHKwB8Jpvbx
 KFw8gh1iJsmA8DxwNPFpSF5SSWcZO20qcNyqI9CyUcDBz+5jSZvUDmhpf w==;
X-CSE-ConnectionGUID: 7HbFqVm3SfKJQ4u1xjz+mw==
X-CSE-MsgGUID: eBGBCTp+REyoyBDyi3LOXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63304255"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; d="scan'208";a="63304255"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 09:14:02 -0700
X-CSE-ConnectionGUID: zZWj40bIQqSbfQV2A2YcKw==
X-CSE-MsgGUID: ILIMy9mvR0CNoAFfRcrgSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; d="scan'208";a="183803374"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 09:14:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 09:14:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 09:14:02 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 09:14:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLKaFLm1XxLdyHMZKXBmMh/vRjrEKurXlxpWYxY4tedMu8tDvvwcvD4383jNt4cGZ+CQm1AFuxn6//UXWy8mAeAV8kIvDECFHB4VYtoGKBzVdiW8Z7aDg3/6AU/OX77Cb2h33LBHFzcsXw+64jYKyku8LP8k52O7werapEjAgfJpNx5Csi9tfhImcaOTt4SxOpSeWFnFiqngp2kHxsdg5+hqKoWOnBVSve+jY0pMekCnZ9zvUcOOKntkvcSD8Hov2yze+ZdEAzOG6IoHeN9BJkzYNtLf4jie3ZAu348qIJs+d+u2PIHkad7bJHKFNfPUC/eh5WGRPlCWNbLZM//jww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMkqk2qKqRo1gEqm6HFnM225bGR3ZOjaOtjJOUgsRnQ=;
 b=fD3A+XQJf709WYzuRHWKx3ykrwcqg5+kGt9n0LVbHDNHRelrfeZf0r6lp/qKQCHmJcVyRtQuFlfi3Lxz2ZEidL2aOIp/VCZp2NfpWP3wQxROvyACTgUZLtBFbdQYcVfDSXvahZRodtPQaYgNMCrsUeMOOAgaMS9ahZEeF+fqRehQMPeWIZyH0zT9U3TCazj8Rim61O0Kx0SLwmgnjisz+85nEf9ncseXX+V8E/KJSh9zE5rTMfTrWNMs9EIij7jkMWEN4ZEU5wU6wNxESsY/4mHkZqRulAu1gZtpP8woCBGFGnc9ksrkQnA1UHTwtSDMuAL5mIr1PrhIXT9KPl0Ozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8671.namprd11.prod.outlook.com (2603:10b6:0:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:13:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 16:13:58 +0000
Date: Thu, 23 Oct 2025 17:13:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v4 1/8] dumpcap: handle primary process exit
Message-ID: <aPpUQb-HquTd4IBx@bricha3-mobl1.ger.corp.intel.com>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251023154748.38535-1-stephen@networkplumber.org>
 <20251023154748.38535-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251023154748.38535-2-stephen@networkplumber.org>
X-ClientProxiedBy: DUZP191CA0054.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8671:EE_
X-MS-Office365-Filtering-Correlation-Id: 1990f791-af6e-4570-7c58-08de124f2bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nSYq1HDgDpsyBP0DvWkz+fE39fmlk8qsjenjAtMyIX8rosNc0S5dCObRp7JK?=
 =?us-ascii?Q?XN+NvnImLrX0KiwZEHjxknzWtssqK7mIqFAJO5zpNI0Dnq4FHhazokenznU0?=
 =?us-ascii?Q?YLfqYN/aSQW8/pkobHj26BpzRyDn9DDpAY5hubLOJgEXU+hu0FmkfFiAQNs8?=
 =?us-ascii?Q?hM//uOGnYRFjrab59+u5PLQ4aZSzGOhSzlfL1pZ69kcv1LKVTLcWN03VhOQB?=
 =?us-ascii?Q?pYl/mfh8LL+0anA9BsmIMORSbrQf1YuFujO9rCtIJRZ61pHd5U2bIQO+30cA?=
 =?us-ascii?Q?Nn7vhrCAGdK5l9Z6lRcq/Oko8ARVnCW+rB6jAvXRHx4HyzP/wH6QL1M3afD2?=
 =?us-ascii?Q?HjqZDUxIGeBZcOy72ZYIwH/kuaiwUek9qgejuYlGdkfFnn/0Ixf5g0xruZWs?=
 =?us-ascii?Q?Kmu3S9r5fBcgDQzFcgTqiKLr3Ix9jlKVL6M6jp4LAEPOoM5Qssm2L3q89sRr?=
 =?us-ascii?Q?5+Mb/WCUVjPXA6fHz7xP8qGd8civqhwvuj0Ujpg/UJut2VfkaFpbY8NeyH8B?=
 =?us-ascii?Q?IKYmHls7x5/wlH7zp7P7+sZLsKYHXfLAtT3+9hD7nlPgQIjOxQ8RIYPx/C2e?=
 =?us-ascii?Q?P6vp9LUsrshdBBenD7YahkCrWAEheosoKGIICNGXYWs8nDQ49+acBa3qfWoL?=
 =?us-ascii?Q?tTNqw2IxiiZQNxcWIKPPWolnDxdbo9DxHHkkKII5MSZ/dj6vuTnDbdHZgkwO?=
 =?us-ascii?Q?9kTnEs9DC+gH1oXj5fYPPjP1IVc93o1vBpurseU4kTaL9igNe82EYuIoJwS7?=
 =?us-ascii?Q?974IAGsD5S6fFmxlMjz7ROSWswJuuVVnLAlVqrobgV6rbM0OEL4zAsvE6qip?=
 =?us-ascii?Q?tqwrJA0pTRpT6q//8XJgkUxbetR3WtwjenDjuYx4RCgpOCPyNjTAAKqiNiNE?=
 =?us-ascii?Q?1mUCQjO9aZ4eXxL7PgfY3d1wmwV541M4XOK5KHMLvdRssMF5k6Sw+b4MIA/Z?=
 =?us-ascii?Q?JlYM0FXlfx1BPX8aDEDodZoByKRptVuubbTNVRc41isumX4oC67lHz85TAoy?=
 =?us-ascii?Q?flLj5W6wQoVApg6+KmB32JrwwFn4xOK0tV+PlR+gayOs+31FFgPOzmBHfY/y?=
 =?us-ascii?Q?T8Se0ahJml1RBJsUAJWK5BEa2zIFOJxh8zkXiqb6/TPDeYS8yddzZa2GNnFs?=
 =?us-ascii?Q?I7aoLEyjfbdhTDmfwm5QwBOAs5Srn7twLo4D87xBBv5XItONtK+lRJcSb1dB?=
 =?us-ascii?Q?XWsVYj6F2PsxJsAP2ZcMl0QLzBfXwxbhUBUO2ryhOClg+sOgkgS9Q54gmfI+?=
 =?us-ascii?Q?xatO+Rwv9UseWDxkqvkT6gRPNNlVzJSJ8gl/F6Y46raHEqvkKgxuS/spKdPj?=
 =?us-ascii?Q?6uM+e3RZZlr+QXth1xv7vLU46G/WBfuDeZLsR0fFfGGOveYDLFVPdes/FqIf?=
 =?us-ascii?Q?8sTXfPAw5YVm93BeBr92Za+nku+LoMPp0dYv07Mhr0ehFLA1sRAY8r02fn91?=
 =?us-ascii?Q?Ac1+019MwmDz+K4/nOFOZmHaAVeaMI7L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VmS20DA5OhF4aOlBEfUJIlHCiBpwlcGoFLFFleuwws57Gv5zvVZ6QTbjU8Be?=
 =?us-ascii?Q?iAIivbHHT5wiMQbNm5ooREyLTzOgyWAztoEHBKAoSSmp7O7Y5D+a63/WZ0GK?=
 =?us-ascii?Q?o9bCaiPg4i1sLyB9E7eph08wxHjAx8h4yxQqzyuI1oqgwWdqXtRjxLeFkTaK?=
 =?us-ascii?Q?RMl9YZeFbOrq1IBFFDG3raqVjQ599s0kS68wqBWEO9BiIkp2wwAlTcLYXA3r?=
 =?us-ascii?Q?WkvL36BNKTHMoxc9kUYdgq/wSnDp9PeLzupND489Sv2WHocUUdYFFZ3jW3JX?=
 =?us-ascii?Q?UpTGz+un4ThBzHdFWrm5to/NnYvDGdWHp6jJ9XjxcFM7Kwcm7qyYPkDxVy2L?=
 =?us-ascii?Q?A0RJppuWQC1srhNIzy3DR9jMdqnAw9yAAj2QSRwHiPl1god9qMdG954aAK8K?=
 =?us-ascii?Q?nH+KFlZ3OVmSmYuAjTVAe9wgiezo4yTLd/vQsoFCUKyqLezNgxUHrFBgI5is?=
 =?us-ascii?Q?WyPg/1WwW5vJzSb0qBwFm17IUuy51Ze2VQniZEiGYaBHG8c3wPYIBcDXCCvy?=
 =?us-ascii?Q?reZMsvnYibohcW3uR+wXN8T4aTLhXi0DTqBoXiPtL+XZm3yIN+3CauRvdP+v?=
 =?us-ascii?Q?UmLN5j2JdODAw4exd4A2ENxsT3g/DD54B4mvRQAQtwmJsLIpts4o9CAHwBl9?=
 =?us-ascii?Q?0ww/0hmfWv11k+0sAKbrNy6mfmAA7Z40WFqoyxQPiYzzutUUzmy5HGbzSjBv?=
 =?us-ascii?Q?3y1FvK36oEaszpyERgw4AhtDUO+7/ulIQtULcyXe+3WFC2tOsmeHBd7ZgoLT?=
 =?us-ascii?Q?bKsQ3IR0GOqdWSq2n3gUAbVNnXObGFb+vB8io11r2SE4IbF/8MI043vAytcw?=
 =?us-ascii?Q?/d7+pEviL6C5QkM/spjANhRx8/9heCTzhEe+3zOxVBZm5+KJ1A4bko4cGPV1?=
 =?us-ascii?Q?YBVoM7QpVU3I7hYS19iEuud/6/QNZHFTwBcpBdsGsVITj+9GlmpjLpIw30ad?=
 =?us-ascii?Q?uerkPODSxQzmN6+075Apn1rmY6pacXINo17ABozETfPhgH4ApCpKVTi8iTc7?=
 =?us-ascii?Q?eZaLe9lS4IGG7y1EEDa7avgDw8JEj4xgMn2XWbcdQOHGRBKvSbmcotpXFuT0?=
 =?us-ascii?Q?YLq0hYPfgylcSCPGIBSLeD2oMU/NcVJ2kFh5zi19paTaflaLaIARGStHLWrl?=
 =?us-ascii?Q?i6+cTFvzPJipD4YfIkttPXTX7x9MkBaoBBkKOavhtgG+Ge1NPXAsNivjZkRF?=
 =?us-ascii?Q?ybELPqa0YLxce5p1+i9ethxVyTHKJqh5lWtSXa7iFZ5KvUP9lI4vajMW1iD4?=
 =?us-ascii?Q?CSxGMmc+NFIlgyMOpzgVFUjwI7KhB+cCZp2Z+biYtm9lqjT4k+UIIbyZE62K?=
 =?us-ascii?Q?+wD9PLui6zDwqw4mFUPFGsJAX0DNKrKnRO/MUXNdYfOBmVh4zVspIJDQ5nh4?=
 =?us-ascii?Q?heWjEKCCFEGCdTiMT7gPCyiUasPsc+mGT9k3nTD7AgFu0CCmz6l7pbsOeeNh?=
 =?us-ascii?Q?aY0w5UH0yUJys7NEjbSkL+p/hEtVdDyjtgxlp6LYz8ghQY3nogMyd1oNs+9y?=
 =?us-ascii?Q?K8YPxSMoq32rs+fTIwNYdAWN2GA8D3DL+aZbvN1+8x4NNR529FckIgofxkxy?=
 =?us-ascii?Q?TNxQGbX+bbPBWc0s8aREg887jHwo0LjM8epJU++CsU7uScBnbW1QEADAZcl3?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1990f791-af6e-4570-7c58-08de124f2bf6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:13:58.3743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubNzPMkmrtW3kIX9hMTq0MDFBJXL/naqwKpFJKlk06cWR5xnEsuZVwjkBRR8K+MORvpOfIbxgGFdvNpFtKEfRmSRRmsiOG7OCWhshk3U6f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8671
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

On Thu, Oct 23, 2025 at 08:46:22AM -0700, Stephen Hemminger wrote:
> If primary process exits, then it is not possible (or needed)
> to cleanup resources. Instead just exit after closing the
> capture file.
> 
> Bugzilla ID: 1760
> Fixes: cbb44143be74 ("app/dumpcap: add new packet capture application")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Makes sense.
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  app/dumpcap/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
> index e5ba36350b..3621c0ebe3 100644
> --- a/app/dumpcap/main.c
> +++ b/app/dumpcap/main.c
> @@ -1059,6 +1059,10 @@ int main(int argc, char **argv)
>  	else
>  		pcap_dump_close(out.dumper);
>  
> +	/* If primary has exited, do not try and communicate with it */
> +	if (!rte_eal_primary_proc_alive(NULL))
> +		return 0;
> +
>  	cleanup_pdump_resources();
>  
>  	rte_ring_free(r);
> -- 
> 2.51.0
> 
