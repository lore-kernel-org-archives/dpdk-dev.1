Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53F6C021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 17:12:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D1E040289;
	Mon, 17 Feb 2025 18:12:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 181DB400EF
 for <dev@dpdk.org>; Mon, 17 Feb 2025 18:12:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739812356; x=1771348356;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LLJAQ99ZElgx7UBOmpRkmsEgwEtRaxuxl9o0jRb/+tw=;
 b=JWJ7mU4OQ/DXcNqAsv39ke4F/rPCgqF0kOrAoJ0f5ofJSCHIDuRCnOjR
 lDOXyPuh9GhmXszxrd3AAeoiKWLp4ps0sAJUZ4UPYENaeNDxFWeTENFXN
 vnezah5W2NiL0Ygtu8dAcPCSAVCLURMIUjAS74ZEMAqNsFzvE/kimvJzu
 new+84gyxZ5VwdWkEh1n+R8ZL1Qv32BnJObCmHcyc5hkufzCV86V+KZDq
 0oZcC8Dm3h61kmeiP3h6aFpucnIT/ZL/I6yK1g4NYjzbqmXLw4prYSGN2
 mG2qCaVVSgaHOR3cmPHtTRYOs0IJrjJLmi1aazVRSTD1TpM1xU1FEjKQB w==;
X-CSE-ConnectionGUID: g2UVUZ/BStSVMKQ8nFjbnA==
X-CSE-MsgGUID: wL4pkl/jSf2sBq8rXvMXfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51145724"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; d="scan'208";a="51145724"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 09:12:35 -0800
X-CSE-ConnectionGUID: fAm7D7dsRo2t356zJ/7XRg==
X-CSE-MsgGUID: 2Xjf+w87QEWIhr+awr4yrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; d="scan'208";a="119280311"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 09:12:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 09:12:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 09:12:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 09:12:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcwxnLMZsMpPvyZikkvtZ5aswd0zCCBuWk7O7ihYR8JyQa1waxLBzIHu1aGGPh1Kv0LfS3ICaWOeh19lwC3p1RZpfUlKvbTZ4fBO3OBNbj7zQrIl8c9X2wFSHN2mexuBeDhk3Oec1aogM378S7YgqoEWkFDJpWW0Pvv0WHmcyn0NjDgAN+SuhGlhIqNoycF0mzvMR1+6tIBQo652JmjnmwxrKweFpdi09CjdTCzwM92a8QgSoczGDa8AC/+eHgGoz6aformuz4QKxoeJapSJL8Kq1voa6leV67TNWSw5wYZgavYrckQuh+WclQ5rnkFvjIhEWzwLJTT1KKJ1Ybtruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTBjqDyeOgTeM2wtP3qQK/1RF+TwXqRP3I1ysTqpwvU=;
 b=WNQ/qOJ7YOcaw4mDHzfIAXn9H9StML+GDAZE8SMqdcECgQGfxIKPDGGKxc/QZi02fvO7wjGIzlVctDE1CHTUdI/vLPd+8uBSowwm09sxdYaxbB4hlH+KSfUVR5HOmr/wNTv71sDRsINvCACcHP2vHXQAsfdi4tV0g1IeT0SEGhXJ/lR+Ps9XPIVBKnEJqS15NGkvI0xJ6PvgYrt8ztcd6CIIwmcZ8X5KTT97uEe4LWIXcY2fWj2dBCQtUv8G2xSYpO7LP0OCJ0cHd9Lss2ZCHneNrb/YCJ3V5jlvHzW2/7XvVyd+6/pDYA6kFtE0Wps+OBLwfspRYfO7Ra8uI5UozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5091.namprd11.prod.outlook.com (2603:10b6:303:6c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 17:12:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 17:12:32 +0000
Date: Mon, 17 Feb 2025 17:12:25 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, "Thomas
 Monjalon" <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: Re: [PATCH v2 1/6] ethdev: check that device supports deferred start
Message-ID: <Z7Nt-ZatmKwrSS37@bricha3-mobl1.ger.corp.intel.com>
References: <20241213214929.817688-1-stephen@networkplumber.org>
 <20250214174224.79142-1-stephen@networkplumber.org>
 <20250214174224.79142-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250214174224.79142-2-stephen@networkplumber.org>
X-ClientProxiedBy: DB8P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: dd268338-3328-4c36-d036-08dd4f7643f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ed2KyELcczpJk2pP27fPG2se9RUfrm+6xTat+4V8/vI7BvfidJRBXqGSBGn9?=
 =?us-ascii?Q?JwDFxI3qG2V9DWL/0LD6cQpn0H7OpAibtmmCeCMBxMhXhNKPdTlvd4YS7v32?=
 =?us-ascii?Q?ulVjfizcTjjHVHSV+eSKgMUHMTaU3UW6PHvm3+aWggHONVQFN3lCwh8ZKTtf?=
 =?us-ascii?Q?QBhRmGL6VCh2PRHgrs2gmFF5bhDu1h4lz5xr9NLVVrysY2PSXk4EIB8d2rEV?=
 =?us-ascii?Q?QtcKDqkw7Yp/fPk+uSG4hnKJzvabeEsKkbGvAdREwdm87/o5y22Ef/dRD04P?=
 =?us-ascii?Q?ihbN/uSKbz6wNDzBUmUJVUUnE/sXyYmUCo3qlupw1oXk9uEZsZ/BgVjF3JZf?=
 =?us-ascii?Q?G8/FoQ3fcZgXRA3UHRM7NKo51K1QM4DVSrP0tZtjbFHu0j7eug58Xm4Cl3Og?=
 =?us-ascii?Q?TEyzzIkYO5QebVaWrmEdeyCa1YJp0vf3CIA5c0Pe9yuHHt53R1DqYQ7jd8Iq?=
 =?us-ascii?Q?1pya7uoHb9AW5/NxlRTRR2r7q06xgJSJ/G8uK4ssKOa3Y2tQLdzM5zzKSUBn?=
 =?us-ascii?Q?Kf8pPXIRg0AlEbVuuN8v1Er/UVYqZBLmyYrRpsw4Vtyf7FSVs9zizRgHtue/?=
 =?us-ascii?Q?PZ856iaSxCM5F0Cm5mzMbrq/rK8CYmYfbKgFDJkGSdXsmo/PPizJleVEDha5?=
 =?us-ascii?Q?pWIkM7BCvdpHlK4Zybpf4l8YKCz35NQ4jeFe7658+o8OszeikckUHKtMJ+Rn?=
 =?us-ascii?Q?mQgXr97zLisxj3S+lOUkvyi1lofUxgrIkOUqmEdne5rw/HOq9ziM/L8BbbNa?=
 =?us-ascii?Q?a3Wy6TCoB2ALImDtZQU8ZGKUjskSyi76snFK7Q1y5AKSiYFzz+TZbHPq7Cpa?=
 =?us-ascii?Q?062EaeLtTe19bXENl6BkKi3lEHmh+6GtjCg/HkAhwZ5gpnjw5D9aCTz9FVUK?=
 =?us-ascii?Q?3rYw+EWC8t6Iyp06d5b0nDmZBKE3Y3awnCvam2CiNgcGXl67hC3VEpm58Qcd?=
 =?us-ascii?Q?p1tajjSgQtJU2yuz1tqH99UtgU6zsSi0Y9v8Uk17lNd/2pKBweId7d5foZXX?=
 =?us-ascii?Q?k9maoDY01YrfTXHL98aC0GXFfXL+x5Bb4YTJl7bB5cBudDayTPu34QAIWqV2?=
 =?us-ascii?Q?7GLTCWhQvcNrUnOIbGx6I8QjLfKbA254hiZmzBwyXXR2qcfl+AMmrTCx6VFd?=
 =?us-ascii?Q?o+wGHLGBTYZ1YKFfk5t7T/pkwffH/kSTdZSYrcQ/o439SwIpph4YPRmAaftf?=
 =?us-ascii?Q?rbt+KO09dPNPjfcqA8NpfC1KqPDBc+rY8lV4g+EsHbyp3uddggdHwzQpRIai?=
 =?us-ascii?Q?OgYWzaMMHiuGC95mfTE7kGWZUhwzvD4zZ4Na9UwiJ9fQjF+irqQsLA/0Tebs?=
 =?us-ascii?Q?TZSOKAT+F+hF96qz+nkBde/QEkISmFaethiTrR/0TblbzxyghZHepYtHUlpR?=
 =?us-ascii?Q?mK5zGHU+3GWdvf1kIdfAKwHbmgVb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pJC+Z5susTENDAQNeaoTmMMjNyzOwZK6KUAhvpRmHiz0XuxHBnAksM8M4aBw?=
 =?us-ascii?Q?UNFyt76hRw7Vz/zlDH5wY4r9iCrz74kR8lXFM02Q+jxGPYtsPa8WC6QEm3L4?=
 =?us-ascii?Q?CRfdu8hdsDfl4ABTTrD/DGPfNkMJHWBCt13UeYseO7Kg9ODjThdXyphI2Kzn?=
 =?us-ascii?Q?iXsH0inTtsR1f6DYOONSN+cNicpU3rf7j9uJvdS7cPXFpfRPquRT4BWAzS+D?=
 =?us-ascii?Q?Z8yr4t26MenzVFFkL6hYiaKVlq1obcmngvGFoyBGa3t9S12go8t903ORrJHs?=
 =?us-ascii?Q?8nD5nCbwX5AAKAv0+1hp/OoZSy1yIQz6BLdIoGWwp6ER7T+r/saO6Uz04WNi?=
 =?us-ascii?Q?2lKX0UAS4Za0zDEJ1bjxWhmAQkn2Gk6IB0KHPLMjZDbB82UOzLcXkk3szFIJ?=
 =?us-ascii?Q?+a07U1wlTxx5wHXk0ov5a34f68JSp9im1LpTRtOgnAMHl0u3fwUDhU2vsJPP?=
 =?us-ascii?Q?0pTIgzlbNGA3Qx5B10VslGzgxdnPXnYrw43HMRVgUqK/60EfZHqaCY+H8lhW?=
 =?us-ascii?Q?ZOOCSy8WYmzKX6HeNOdEt1jXCq0x92GBUykQbN5Lb9KZfZTJhi2K6HcU/lOd?=
 =?us-ascii?Q?6+Wb5bhIDOthZVWnrN3oUEt4zZr0BPzHDuM+IDHH8cMQQ60HopFd4wSvN9Fl?=
 =?us-ascii?Q?DnQtRc8FLc3TWVyIJOuWUx5o+ThnGvdKq/TCPVwvt8BrUavuihzHJS3NCyq7?=
 =?us-ascii?Q?aPCTmN14Es4zxkKtE8CcZtkXEjKa5zDc12YbYy7SMsn07kzJDUeiSWQ3ZbPP?=
 =?us-ascii?Q?pBS/Nmhbd3RuJrLpZl8UTiyvNlH8Sz4fhB8/pT9LZVmRtszXBwtDShiX6d5e?=
 =?us-ascii?Q?ParHgqDUfUh2LG6LB23Au0sIF0rUl6Sorbjh2SJkOZnD5oEkZ/sccu8WgAuA?=
 =?us-ascii?Q?WqD/Mf2sPA+vn5neiBWGq1kprTpmfszOCVyNTj1dHt/ncpQFEVXDKw4VIspU?=
 =?us-ascii?Q?R6A3A0b1Oqn9MyKqgrl17dZa7o60UJ7UJbXMkghI62N5jXvAYq2diufNV+zM?=
 =?us-ascii?Q?7NIVDbjyLUu7liZz6jZTccWdwrpqV8V9WuqjDbe6RWWBwr7Slmf/vN9HnqTx?=
 =?us-ascii?Q?Jqzb+eED0zx1ULjRyV1cuxbLSSifLxoFF6IUTP8QfnNRSH3RQebira0KZOba?=
 =?us-ascii?Q?mfcrlmwC1yEx0G52FJ0fz5+NHUSekXluSctRlSZdgYjj2r78BnZVWushC47m?=
 =?us-ascii?Q?gcNBs4J3ht4ZTzfkD9xeX2Xywk92H7+bjNQCjcLhBycbmPFpyQJvhsfG+ti9?=
 =?us-ascii?Q?zVLNZXSTccq14DVOkzV25S5ckENH6djrihobR5qpu67iyZGC1bjZArVWnftI?=
 =?us-ascii?Q?u/6RQQN56Oy4jCLIEV4XPCrc9RatGA+WCqarjLpesqhLrDiZ+WkHXrhcZ7Cv?=
 =?us-ascii?Q?YYv9PQjqHlqMPRwlAst+p9rzrnDxoeJSkO8+QSmzbgOCgjmcBLlNE99qXQJF?=
 =?us-ascii?Q?22ZgWwmgZnu0mMK4UhRKEPaX1NYGdd6IY7F4LPJUk0+so8d/TjhB/3cAlESB?=
 =?us-ascii?Q?Nzs4hYZXO2EJW4RXXVI1oHXY8ibaGDOgBtVjmIUPJanbOuHp3fE0ayDNpgaO?=
 =?us-ascii?Q?KpqAWAuUaa9tGLZ1368MF8PdbB5GSxu4OyIm3o6+KcubeNfkKApedvMtas2x?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd268338-3328-4c36-d036-08dd4f7643f1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 17:12:32.2365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pXCl3npAOa5I9kED1/BfhpQs3NhlwOjZ09hukV1YG+7Bx+ipjOKdJiLUE/3I0E1yHwOqqWkmHT+r1VwBasamve22fWPt0JwWKAOvbRdUYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5091
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

On Fri, Feb 14, 2025 at 09:38:54AM -0800, Stephen Hemminger wrote:
> The check for supporting deferred start should be handled at
> the ethdev level for all devices.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> ---
>  lib/ethdev/rte_ethdev.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index c4079bb924..5493b3b9f8 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -2274,6 +2274,13 @@ rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
>  	if (rx_conf != NULL)
>  		rx_offloads |= rx_conf->offloads;
>  
> +	/* Deferred start requires that device supports queue start */
> +	if (rx_conf && rx_conf->rx_deferred_start && *dev->dev_ops->rx_queue_start == NULL) {

I must admit to being a little confused by the initial "*" at the beginning
of the function pointer check, but Stephen has correctly pointed out that
this style seems to be used everywhere in DPDK. Can someone perhaps just
explain why we check for "*fn_ptr == NULL", rather than just "fn_ptr == NULL".
Testing with code in gdb shows that both work fine, though interestingly
gdb itself gives and error when you interactively request a dereference of
a null fn pointer, i.e. have the extra initial "*".

/Bruce

