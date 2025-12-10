Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2F4D3B9BE
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 17:12:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06200406FF;
	Wed, 10 Dec 2025 18:12:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 101444028F;
 Wed, 10 Dec 2025 18:12:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765386760; x=1796922760;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VARHvk8G3l3xoCThQNuIMIuvCwrEVL1aOFLIWnEJ6uU=;
 b=VwupYCqZ6gUwzoeKsH3OhyVIJRFhfI4SjLmUDQfyZajIvyeB1PatHDvc
 xBiiXRmokyesDO6+dTSSnPU1LKqq4kIYJzqkKHdb8UeGP6jUuH+UOQful
 SYJl9QgKXoTralD+zyAZCaMzmr4d6mcAstG2ZF6lgtwb6gnW7GQPgkgK1
 hbfCqF/fdxRllokz+Quz7S1NJUrAx7aFiwvqtk040zsHvtLwPrl9851FH
 d7sIeIU2RMppkRi7esVRl/oQ6wwO7pPAS2QSiZ38OOtOQs3Z0zOrCRuh/
 bdNbROMIYnqZAANrfRA49VgY8lGgBL/RV0X/YhZfeQGw5/zgBYeDk+KLQ g==;
X-CSE-ConnectionGUID: ftjSbLb5QCGw9aIGwI+IHg==
X-CSE-MsgGUID: 4Fl6XEmcQY2BJYX2dzSBIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="84968020"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="84968020"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 09:12:39 -0800
X-CSE-ConnectionGUID: 1b6GgJEjQbS6QnDrnzLGfA==
X-CSE-MsgGUID: drKX2ioDQG2UFRNfQ6YF6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="195642790"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 09:12:38 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 09:12:38 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 09:12:38 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 09:12:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLJShNoNDl+e8b+WldX6LecdQ2EckNObp280KBeRrRPvkE/3iMk1GtsCKTFa2oe0Sw7vVruB34K/eAkmmrFadFpjCogSnmCzZuqB+Bum7WF4e0PYFn2mP61WFnk/otGaDGYtCaIzecgCoIiKuEyLPfa9zhCbgwiVysjIUU6aCOf2aSBPt6+DfXzGI74pY5rRReHf7A7LIfG44NGVhBwDHrrVK8eQeX+p+KTw3gcJVBp1rFAlPHJAeYiV4zvEzO2D2pT4o5X2pgQj9YV0lDGZx1tlQQVOLsV4p4kJ9poO7Jyg4d2gygg7RkQowRR1g5couRa2Uw/QCYXv8OGSkhTn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iITW8nXwChz8WwjTLy9zBImd97ckFCsmVMnojDsYpWI=;
 b=ab8MYuPU843vmD//hKj2kV91HjW77/hMJESyQ3HgwW5QBW/b/5WRYBOR/0syYvyNK3SRtUVPu3lX9KSadfHs4yF0mmrJFmamkR8Jpw8BMaDigtTvFsmq2f40r5B3fT/bMu3XlctMCDp1vpXp+L36z/h+vMHpaPkUqPC1ZvpbBVlLbmCDQRHJi3++qPyemv1AbVyboQr2QlkZNxNnONQ3wjSr448GRJsvfNR7E1w7X1qQuDDb1i5KlZfaMR6rFpWW9mxn/EFlsmTkT26i5jnQdagS/pZeNgV49qSNcSDLNJ+FCsp/MjL5crfQA/eRph36D0B8XmJluUYtEx6TLcbx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8184.namprd11.prod.outlook.com (2603:10b6:8:160::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 17:12:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 17:12:35 +0000
Date: Wed, 10 Dec 2025 17:12:30 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
CC: David Zage <david.zage@intel.com>, Soumyadeep Hore
 <soumyadeep.hore@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 1/1] net/e1000: use device timestamp for igc
 read_clock() operation
Message-ID: <aTmp_sa2vA_2N3bN@bricha3-mobl1.ger.corp.intel.com>
References: <20251108080613.123969-1-yoong.siang.song@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251108080613.123969-1-yoong.siang.song@intel.com>
X-ClientProxiedBy: DUZPR01CA0303.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0122d0-e47f-4365-4440-08de380f5038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QZiCj6CFwQasZASy6O2j9cGn3joUeYif3iR/4ljLbuS7dbSQOvIseCBVKEjy?=
 =?us-ascii?Q?I1OfWjieTln6Du70KQXhwdfRqR/O43/8dpxaT6ofgDsH5OZbFn7S1VKfd5o7?=
 =?us-ascii?Q?p+78svyuIF9wxgeO6IulxRVvE6VZ6pv08TMqPk5ecxr6WKvKGM7r99oyQbTX?=
 =?us-ascii?Q?JrF7PG8DJXv4wCSX3Wfa0UWivuR2rO4eDVNiy3nbyt3xaB6dg9GzWpCDgUGL?=
 =?us-ascii?Q?SjoNMx6rygboF+7Zx+KImHCUei8Sku2bAI7ksV8isrm2EPes7O5GFxIQ7B7s?=
 =?us-ascii?Q?VzkfSDiQWCjq6MQ4D3z8CKedGCQ7pnntkdn9/xkjrRl9HHI0NtNaMIgw8NS8?=
 =?us-ascii?Q?7YxxQreozYPVxJUZckTWXcPqNR4ALSMay4h6deueJqYpvzAljVyooV2iOAHe?=
 =?us-ascii?Q?isOlrQi3IW8+7gR6+FTPxr1iQsJJldKp4v2DFEKxOUlmMlSZhOqnkozYQVLG?=
 =?us-ascii?Q?ej6MF/PZptoSWlZzyVrJ+fMRN33I+r03XO4jHSCGWmy/+N6XIrPh0QNUVIvI?=
 =?us-ascii?Q?x3VB5UaKY8Mt+aijPNKx7qZei2mOpayd6hDn3j4HYly75gbG1wHBbKSHXhEt?=
 =?us-ascii?Q?dDWL+RuTgfqT+5jE6Xw3HrXx7Ddgldn8wFNTvthMnQ+bIiJs6U/gxzmo5pns?=
 =?us-ascii?Q?prCgBYC3OTdT6rFd47rfeGKnlrpbn4xGN1uWDpbQeiBa2x8He2ptndaSLO9T?=
 =?us-ascii?Q?NuQ7gimAQcrRk04tVkdJMIM6gAI9p735Zts48JL0G1W+j/kINFMuY94NaWSr?=
 =?us-ascii?Q?5iM9ipMtnABHNX9v3wNvVmzrn7U/3NZtC46LK1I1yHFgVMymO/CT/QWKg2ct?=
 =?us-ascii?Q?caUt28MlhOO7v3wUnOD5ArylaHDkdrHNfvGEYtgpkBIw21MFmqyvNHVsy4Rm?=
 =?us-ascii?Q?fiZlPpjy/z4Qkg2Cww7aZRMzmwPo6f70lTXO2g/jtKalk83Jy9mkEXOYJtLN?=
 =?us-ascii?Q?U6pQO1U5cb0Diq7VSdl6FdLDYe21pMdT7jNlBvnYxpslFBhzkxC/ZlYyHBIG?=
 =?us-ascii?Q?Eaj0CWXCW+PjetpLxKEQBGKiEkRguXvp1QqHrx2vkhkDwn8kXMtN7UbLHc5l?=
 =?us-ascii?Q?1I04HvG6MBvAkRk01kON1xCbVWCclqNlRvqhPSe8CBCwRQaq9BFPlbVn0hWP?=
 =?us-ascii?Q?Iz01dwLXb97+cJUbzfIiwC0OBR6x0+r/BBSwfFq05PZGQ7OgxgrfTChiVLFT?=
 =?us-ascii?Q?GUEN9dCrGGrgvmAkVQbsQwM/H9ajGIc7wNauxiGknLNBbH1hzg0kGyyOkxMc?=
 =?us-ascii?Q?2k3zD4EM5t6y/gTM4HWN6nJAJd2q33pHcYJCRQxByMfl8fdo1OkD8MHTck6h?=
 =?us-ascii?Q?JbRHqRIkL3k6otQPl0l7lx7dRg91ZVbnHEe+eJA5Zl/xTlj6Tb+qFkLhnEFN?=
 =?us-ascii?Q?s/a28IY/32bR/xFxFz+Dm6emBEfBlSoWVxOWMFGvsPRXkxb1lhzR2WoxKkFB?=
 =?us-ascii?Q?4S7ukILkW/4h0wkc+BN9/lcAACU17ScmhW4YkUwHYUgGCCzagknjCA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/lRAtf63wGhTZa1X9W5t1HFf5XQ0kehDwElRIQ8O1E13bAl21QlftjyCg9lz?=
 =?us-ascii?Q?vnPKQoRcTCyQRAxq+xOyz9qilMaBEEYuaHJ32edaMzFSD9NIetTn+Z8XqL2N?=
 =?us-ascii?Q?3XN1PD6ds4VPRuIYRhNJOVTGqIrqL2xVKhK9x8Bm/ZlSsTuAjTMFcza7NLXS?=
 =?us-ascii?Q?cq8FAne6kOvOcH/tXCA/wrgs1idBPEHCfQSuZV7KDLbHUiX2WSU/EJeYwOo3?=
 =?us-ascii?Q?ditg5A5KjbsI1w/a6uxurLSer3m8r2u5OpWSGqBN0Zhq+/6oOpv2lewInM3/?=
 =?us-ascii?Q?VAZpnyXjtyUnRP9j+g9lhTGFYiKpMG2tZ5shc7UOLZqPGACJHNEI3anF1ib+?=
 =?us-ascii?Q?K0ldZTj0hggL6BtAnPNVGGmeHDI+g41b7QXv0dI7n0K7k3sVrKW63x0U4VeI?=
 =?us-ascii?Q?HjTQnHh7FKeMlaVuIEmxUXhPIuKIpDbdxVsbMb/jJvwzHSSmNNy2QcDI7xUl?=
 =?us-ascii?Q?NbuA4aYl0JyNNQcubcxcwa04GwQLTZYJUMkJouQAWaqjIFKO1ZqTSbZyVOGE?=
 =?us-ascii?Q?owpjuPFeDnNo32T/OdRKq0Jbldlxb7wAxBM9/EZvSBslhj/8PzM60RcwE6hT?=
 =?us-ascii?Q?ECyIgF9lUU7Kc2aBKFdvvkI9K7A5BFcm+hnZhzACdmGeZJd8ogWY8xcvDk1/?=
 =?us-ascii?Q?hlDp1pULxQSCdLrWRLEtELeKsisRRuVltSWrI24r3CWCTQyex37NvZmP7HMd?=
 =?us-ascii?Q?wfBxhufaJ4YsvVlqg9ePFZuDV43Sko3d1yI33eU9yG3UsdPSisujvDbsauje?=
 =?us-ascii?Q?jfzMLhB9pcU1iClaBzEqmdAiRKfXgSkrdjPsrFwM2bsjbOxYiqPtKYdqc9HL?=
 =?us-ascii?Q?cqk6gbFMQWfMTw9MWA/aNvA0+sXffQWkgzpOxDToMRoBTzyelGyyS/apa/VP?=
 =?us-ascii?Q?X8WNCIwkgJDh10FyybGuZfv4jb+nICszWch9aWLHkjsGFzdCApg4VN+P4Jar?=
 =?us-ascii?Q?EahVmhryOJcmYpA5qziVi7mPY3NULcRWpf4ZztqedXKPjKEaKN0OfB78+Qpm?=
 =?us-ascii?Q?/eSLFuj04c8OdQC6SsUvJ7qjVOW5j1kYbiOUAj6Vau7sP6wKjbLlR4MsDl5u?=
 =?us-ascii?Q?6dsyiIHVJpbWckhar98SGz0lk9A3fMYEEPw9HJtbWkDq9smWqnP4QPrJCYZ9?=
 =?us-ascii?Q?3Rqcun8ao28sdukhrjyf6t6DBTlOWgOvPJ0J1ClgVx5xx6cEvKhHtO89gQ0H?=
 =?us-ascii?Q?Vt8MiOt3fEfFOVc0ub0x/FW4wv3svb2W5uP0H95sIPvKfOXFQzSMW9LO1/hc?=
 =?us-ascii?Q?7Xk0gAeSYwvSawbKj+vSglRgyhXqLq/tnDYPJ9emlyATpnXYhjcKxwQ1WDCX?=
 =?us-ascii?Q?GcTRiNEID7e9+1X3nBbNKvWSGAFSc5ujJvtOVRu4kZ9SqB54yjpx1xr2EyBU?=
 =?us-ascii?Q?JP0U+gP2WJj6PnenD0Yehrm+BOZPpcJO68G6XpzcLWRbnn3NSDzbYxGx1RJg?=
 =?us-ascii?Q?7HCrEW8mSqSSdaekE6kZmlt+A9oUGu/0QkNZG/iTsGC36Sh7AZuWHSKl2fCE?=
 =?us-ascii?Q?7Y76lIiX1hmweTXQYKzNvByzF/jm/jWRT7oFYIIq3rIEVrJFlaXTWk6m9zb6?=
 =?us-ascii?Q?msQ6c5jPIeaMw01g3FXMrGinPbvAFvcasIDKxYhxIl0ZC/IfCBtLE0h94wRu?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0122d0-e47f-4365-4440-08de380f5038
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 17:12:35.7347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sC1hz9yuJxjxrskDPTeeigvr7FXFw8xAImZgCOE63aMxOuS0eZ11xcb/GelNLSTiNHeToGTe4CJ72t087lv77rQWsTfs22qZo6ad7Ovegtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8184
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

On Sat, Nov 08, 2025 at 04:06:13PM +0800, Song Yoong Siang wrote:
> Change eth_igc_read_clock() to read from hardware timestamp registers
> (E1000_SYSTIML/E1000_SYSTIMH) instead of using system clock_gettime().
> 
> This ensures that the clock reading is consistent with the hardware's
> internal time base used for Qbv cycle and launch time scheduling,
> providing better accuracy for Time-Sensitive Networking applications.
> 
> Fixes: 9630f7c71ecd ("net/igc: enable launch time offloading")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Zage <david.zage@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
> v1: https://patches.dpdk.org/project/dpdk/patch/20251107031507.3890366-1-yoong.siang.song@intel.com/
> 
> changelog:
> v1 -> v2
> - reuse the existing eth_igc_timesync_read_time() (Soumyadeep).
> ---
>  drivers/net/intel/e1000/igc_ethdev.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
> index b9c91d2446..d4edc82668 100644
> --- a/drivers/net/intel/e1000/igc_ethdev.c
> +++ b/drivers/net/intel/e1000/igc_ethdev.c
> @@ -2813,6 +2813,12 @@ eth_igc_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts)
>  {
>  	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
>  
> +	/*
> +	 * Reading the SYSTIML register latches the upper 32 bits to the SYSTIMH
> +	 * shadow register for coherent access. As long as we read SYSTIML first
> +	 * followed by SYSTIMH, we avoid race conditions where the time rolls
> +	 * over between the two register reads.
> +	 */

Not sure this is true. If the nsec value == 999,999,999 on read, then the
rollover occurs, the resulting timestamp will be almost 1 second out,
right?

Instead, you should probably do one of:
* read nsec, then sec, then nsec again and verify that nsec2 > nsec1
* read sec, nsec, then sec, and verify that sec2 == sec1

in both casees retrying the reads if the condition fails.

>  	ts->tv_nsec = E1000_READ_REG(hw, E1000_SYSTIML);
>  	ts->tv_sec = E1000_READ_REG(hw, E1000_SYSTIMH);
>  
> @@ -2972,10 +2978,10 @@ eth_igc_timesync_disable(struct rte_eth_dev *dev)
>  static int
>  eth_igc_read_clock(__rte_unused struct rte_eth_dev *dev, uint64_t *clock)
>  {
> -	struct timespec system_time;
> +	struct timespec ts;
>  
> -	clock_gettime(CLOCK_REALTIME, &system_time);
> -	*clock = system_time.tv_sec * NSEC_PER_SEC + system_time.tv_nsec;
> +	eth_igc_timesync_read_time(dev, &ts);
> +	*clock = rte_timespec_to_ns(&ts);
>  
>  	return 0;
>  }
> -- 
> 2.48.1
> 
