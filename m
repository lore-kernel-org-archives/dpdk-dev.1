Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFEFC79FB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 17:47:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FC534026F;
	Mon,  5 Jan 2026 18:47:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 261D740267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 18:47:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767635260; x=1799171260;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ZyyLKFi/JP3pQw7UmscvKgfe9GT6cPwm+NADUeCfFP0=;
 b=dCE39oP3P2IvMeASnk3q7B8ktdxU0QGRNV/H/eLnp5nrTQIkQvZYZkOz
 tzQPqX1iYf2SpVzE8Q6XQUKvfp6Pfzg1jzsge6RReW837UsX82dvntB+y
 OTrNNeLFdpNxgpVBuTkp0yG7EpjAkzP9kGlJmUggyCkDeN6V9MTWED/XX
 CIuRkjEDednFGCU2LHP//1sEHB7sCoEGPG+7CBmuwdnNdb+lrn69Y0Ge6
 d2L8x3wyavMtErQPhZK/URn/LsIkHumapWo6EedhurNDjmCZHBvVI4XzR
 HBNZeE6iSvJNVLv/EF/umDG1QE9NXIP1YYfhSVmpD+ORyK34IAhtO9YoI w==;
X-CSE-ConnectionGUID: ro6l9zp7TnKN31rs+Xf0sg==
X-CSE-MsgGUID: Lct0t2TGSY+pcg4i0HJ/jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="71581849"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="71581849"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 09:47:39 -0800
X-CSE-ConnectionGUID: RFhNUDfhRCGwzFNTsn9ydA==
X-CSE-MsgGUID: h6eLzXNdRwKBnKXWgUy4/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="203413914"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 09:47:39 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 09:47:38 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 09:47:38 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 09:47:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNxZvGkyLzMwKTpx8ytcHPiWrKEqDBcSE0nQwlFZF2IXopR+2s0C+5+nGsUUDIYdQLDTl3NQ1IpxAZM64onkjAfykoykPft+brNp8X6RSbG0DE/aQD3uD4wj88NMtsIZVrFvOiUOg35QhJUVHCvEqIdKb1vYYGWP/g+TYbqQ8B4Dzdh3W9grkLsWS9ohozmmEfsJibCwgBDNQe1BFL6bQAOogKB5fdzA77Pe/mNJvAOOplf91EnK9YcQSmkoZh53gd9oY5JbHfzBFTCGOmr1bmQn9U9eL0I2FYE0Frn6h/xFLhDPjL8GLFJ0oeKWC1l4rc1YXUkoxN2WPKZoXMgVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29/9xqQkYL19vVI1k0oNLNeiqXAqIUPEDdeZgua3bo0=;
 b=BvHGSJ5876VWtqoGCg3NU7QaaqB/TbCpfYMQItJOiD2WysPzZtNeaHsWRUX73sSriZbqG+ftM2nNtrLqJbsZD3lLAp003kDnhoV3BGLbjywQUSFBPjJreGNI2I/TSRWmXG43sflANkmx04BEHSm5wKwrFLe18jAfSRxZWU/LA0nXRmzdFjZTuYkAdDCqP7g/rL3FeeyTnY3Z6AB5704EzV4M8S/kR+Asdo5wBjUTn8tFTvhk9CqMUR6x+yOKUAYuNoTaFnAWzKXRntshbkkCrw3sQAqDo5021XI3TB7mi7mau8Ko6a5vqeqVM7xBnCpwP4DcSbAmzXAuvvX66SHbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB8807.namprd11.prod.outlook.com (2603:10b6:8:255::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 17:47:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 17:47:36 +0000
Date: Mon, 5 Jan 2026 17:47:31 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Praveen Shetty <praveen.shetty@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, <dev@dpdk.org>
Subject: Re: [PATCH] net/intel: cache mbuf fast release mempool
Message-ID: <aVv5M8mXjOOIMdKU@bricha3-mobl1.ger.corp.intel.com>
References: <20251212111136.103137-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251212111136.103137-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DUZPR01CA0349.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd45a6d-bfcd-427b-54ea-08de4c8282fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?wg14K38KV+2rvJ3E/P62Cdrwgi1h7JfJH7GQp1z0SoBTil8PY96YnqhySG?=
 =?iso-8859-1?Q?hT+nTFOJRvHR563kGXQtPiDGNH4bayZ25egLJC0T7QdJx7Vm9kmhbI6NHF?=
 =?iso-8859-1?Q?s/3ZX/sN9At5f5CZ/DoD6onNFFWos7FPy5IEX6li4gICaa2TRkNwvhTmz5?=
 =?iso-8859-1?Q?xuz4GjfExeEf76omfKJWX5KpxnBb9O30NbSjJCp8lcc5KML6BAOuhbp5FJ?=
 =?iso-8859-1?Q?BSDpmDah/Og0EErMYOlArY6j3d827c+FPvPpHyLy6YW85Z39zzdVPZe7ox?=
 =?iso-8859-1?Q?GGM1ym3adDBIBiJOATR5MfCepQF/uGe2Dg8PO4H5njIqXyxpMcFG+Wssor?=
 =?iso-8859-1?Q?Kmwm/wjNrSBnuBqpwUCW7D4/eOjSoDh4zrnzwJ9NdunuD6rYfU65Xh9Z8J?=
 =?iso-8859-1?Q?Ir+hCN4W4bATdLyv4UK0PX0JY983K4/xqbBh117pOyv0s7YCLT8Q6NRE2o?=
 =?iso-8859-1?Q?1pzZ+VrPLXDzNGzOqVKb4MEzqHtgx25eJ+UBG1R3EEZnR8RWAZSUp63qZ1?=
 =?iso-8859-1?Q?7punpr9U1ePkTBzjRZ/6Iasf4sQdxvYJ9hltHGREbCATeqcbz2zznfijeG?=
 =?iso-8859-1?Q?NJcuk5U9CtQdzKwI/rapkIeboEkng6BeGmrnMu02JQPef7yjxJeImheJ1f?=
 =?iso-8859-1?Q?CGtOa15W8+v1xOfhqMpcisErqsYOlVc9Y30OZfnoxzClEjxJ5POFLOx1uK?=
 =?iso-8859-1?Q?12y/KWB911rT5UmunwgVq/IaauR9+SBab5TDYvrEjGrjhPc3RNnuz1reZf?=
 =?iso-8859-1?Q?lImZ7c9ajfajsmR3+7f0hGDjtbuH7c6YnhneGl83Tax7H8ouFWFcmkJBRo?=
 =?iso-8859-1?Q?nzE6YU0uOstTT+MebOJtUkbaRMU0/U3hEZnKpWSNeUpQ7adIuekhzGLbHJ?=
 =?iso-8859-1?Q?JZTKRzb98bD5HNvNxgTTC1Z+tJTNxKISTIaeVnnR/fTsFRJbXsm3XPZGjG?=
 =?iso-8859-1?Q?8rZIZK3RubxsDS6ANPykwXaw+XD4TMqq30hu+jeDCO0y+GIMha21llkV1P?=
 =?iso-8859-1?Q?zGqFzGHT16YD3p6kuZgBV7S35jBjZcvdJQ2Ur6sb8jdIj0cMirvc3Q+275?=
 =?iso-8859-1?Q?npo/kqgM/JALkhBqlt94HNFn/nRKVSWESrwj73qiurQH7b8jGQR69Iq4HF?=
 =?iso-8859-1?Q?V2zXm3reYrJRFtLezaNj8oGgcAg4NqkxnFchDWYIvIjKDRy1kSXiq6czqT?=
 =?iso-8859-1?Q?e6Z2wR4cmLrfVxi2QIj49KhABylVeu5KZA5TYaMO3SWwf0hR69Sx3cRd18?=
 =?iso-8859-1?Q?GUvwMVvByogiF+N+3yR/IrbzBNpRWjx6jWYcLCpkUpENZKr9VWsBr5UvPb?=
 =?iso-8859-1?Q?9LcYzvKViO2utbxZwZCsLqekf3JJJJbWxdjut4Cx84WYzoqPrSlf0wBjdX?=
 =?iso-8859-1?Q?V83AlqccXcWbe+vYfzENFF1esVWe1RkKFPaFOQa2Yp5w3zxqYbcRCfbcWI?=
 =?iso-8859-1?Q?fDF9MJONzmyv6Cch7SnCw7TSTj7K9ZRuotgZz8Fs5rDmlhXlvW9mdnsmqj?=
 =?iso-8859-1?Q?zmo3ocaxZCzWx8HD+7xXbh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QFVmoVaFSsIrCESMHKZpQQOyul9t2ya47nQLpyw0cdopNVf6XWAgWMb6/J?=
 =?iso-8859-1?Q?Ir+J2Y3HSA52kOMw4oEqi47l/DsWmvmGEHfzaIEtBtqlh3VoLpq9hanESF?=
 =?iso-8859-1?Q?51qj7NWfL0OZX6z0USs73sUkdKI6uAlHSCj/OTuKGoDSAPMYXyy+ai6GN1?=
 =?iso-8859-1?Q?qopt2/BG4CjqcuZBuanvYl+3yy1h6fSza/2sbpQNybyEfwe3GAxH8e/bNV?=
 =?iso-8859-1?Q?WeiQCb/8iv40XIUIIaHPbz73/1wNX1WlKgBlSjLJBS9FSUABrkBxokczUd?=
 =?iso-8859-1?Q?v8f1NeJKbIaRg7qdiYbJw1xuL7XnMUZALxnubf6M9rzxWELQVQpOeoTlEx?=
 =?iso-8859-1?Q?MAj7Bfv0hP9MWz2iRVRX59dVmBTalTO+33UMs05S8GmJUU2yMJvWDofVkK?=
 =?iso-8859-1?Q?m+3GlkxX9lMvAqxXzeSPVyDPm0xFuBd7m2ODUC+aX/o5/98ixj32oHBqRn?=
 =?iso-8859-1?Q?WNVwMSbHaVmfniAPdBbFa+uUOJM5dshZUiQijXgueQWU6s/L4KnLZJv67O?=
 =?iso-8859-1?Q?z5+rSM3f/2AQ08aJC5mCOS7byUv7Zy3cfWRPV0CvGzUgIDiif849z9Vui8?=
 =?iso-8859-1?Q?zjzFIH2vGdDAupwDMRcFezE4SArDm5aR5oH5nHEk29r2J0F5XdVchso1Z+?=
 =?iso-8859-1?Q?CMMzUuPthxfMAI49i4TV6+8/32ifbZVK5foaR75PsRrotT0CRC0oJE4+Tm?=
 =?iso-8859-1?Q?7NET30xpm6cQZmjh7++IjiUBQEn/5RoefEerDw8j8gSt6FMpP6sbQr/AJ8?=
 =?iso-8859-1?Q?XLTNXvyOp5WNTwnC1fzeB9POrQicjLzW9LRFbrLb+9+uiNdKnCcQK4yvs5?=
 =?iso-8859-1?Q?zoRSZmiwxG1ncbQRbVJrHsnIW/PDQ6E2NzixtXAV4SsERQu2W4hXNFehAH?=
 =?iso-8859-1?Q?YaC2wrCd4kyyAe0tEHVlFi7o4cljxnmiEvgX26r/vYaYGV37kvbwaXcfNP?=
 =?iso-8859-1?Q?uZH8oI9yX/D1VsN9I0wtkx1+8IUlCIwMrJ6MzUhIRj8k8zcySBHfvFdEgG?=
 =?iso-8859-1?Q?vKophPQhmHiUueD3eewoGtNd9MRb4q89Hj2FWIpKnI9F8d6NwOzX16DKyM?=
 =?iso-8859-1?Q?Ry1ZsGxgXg0fbn+DK+qNKXRcSizEaC24P2s0iS1bAl8XuL40/Sx9SZynpD?=
 =?iso-8859-1?Q?rw5RHKvBVzWf6O4qZHbQas6GDVXU9nXdaIHijNglc0TA1OQV86mhN3VDwA?=
 =?iso-8859-1?Q?g7dLfq7fEPZupyAYVO6+RlhKbQhXFCdpuMuVgYFqp6ioiUBXGV94a2/tFl?=
 =?iso-8859-1?Q?O5lj7aRK/FRY70gL8NZFqjw1uBtA8/6iGnRJbSyUhWDNs7u5FEYjy9JgKc?=
 =?iso-8859-1?Q?kVllHFzU3BuBJw0EOQfTR/l9vNXQc/lpG2kjmddO3EkAgAT2f57bBOOrP+?=
 =?iso-8859-1?Q?C6+tuYSLNvLbIOxaMJEPZhCYRbxbVBqO4XSYvoDhmm9RbEnZ45Mv5unQXA?=
 =?iso-8859-1?Q?P7q6SJlzDPkAoZmPdR2R66Z5rfUBfcwIY87JYfgYSghDfQmPyGuwM3iBpN?=
 =?iso-8859-1?Q?9MmamvSu4DFUjgFbEHhBr4NAGQ3yBNXr/SbTUCk3Sj0XgSGbOKhOPEZwOm?=
 =?iso-8859-1?Q?6GNzPHMitBmxZRbvCD5g1s7RGsD7+km2Ag5QGpCl7dP47ehQTCr1PHQ1dA?=
 =?iso-8859-1?Q?wOKP5pwswLEbCfztihk2bjA11c3BfvWW69m72Dx1PiUy1/HeoNglhhf1/0?=
 =?iso-8859-1?Q?8qjhnfYjqKtl8xXhIm48rWu4Bp0don+SvUjgtMSKu6cAxsbHBt6JaizqnY?=
 =?iso-8859-1?Q?xptKPd/5PV2eHRb093Ypmmxt5Q9XbWz7CYQg+JgR8cGRJ+QAtGxM35uYjv?=
 =?iso-8859-1?Q?uWKBflSLQXhem6l/CU+a69raRwNuA9g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd45a6d-bfcd-427b-54ea-08de4c8282fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 17:47:36.2865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWLmAWxvHXPVjuhhXZzxYtsduUdumWnNOWPqUKONllTCeWTK+ioKRF2LQXipw7Vz0SM7l4kGTUHqH48MtXV2KdZNgLb59n/oBz01ilFP2Tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8807
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

On Fri, Dec 12, 2025 at 11:11:36AM +0000, Morten Brørup wrote:
> When fast release of mbufs is enabled, the mempool to free the mbufs to
> was determined by looking at the pool pointer of the first mbuf in the
> burst being freed, potentially costing a cache miss.
> 
> This patch adds a mbuf fast release mempool pointer to the common transmit
> queue structure, so reading the mbufs during fast release is avoided.
> The pointer in located a cache line already being accessed,
> and is only set once, when the first mbuf ever is released.
> 
> The fast release mempool pointer also indicates if fast release is
> enabled, so this pointer is checked instead of the
> RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE flag in the offloads field in the
> transmit queue structure.
> 
> The same optimizations were applied to mbuf recycle.
> 
> For the ice driver, prefetcing the mbufs when fast release of mbufs is
> enabled became superflouous, and has been moved into the branch for normal
> mbuf release.
> 
> For the i40e driver, prefetcing the mbufs when fast release of mbufs is
> enabled was already superflouous, and has been moved into the branch for
> normal mbuf release.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  drivers/net/intel/common/recycle_mbufs.h | 10 +++++---
>  drivers/net/intel/common/tx.h            | 14 +++++++++--
>  drivers/net/intel/cpfl/cpfl_rxtx.c       |  2 ++
>  drivers/net/intel/i40e/i40e_rxtx.c       | 31 +++++++++++++++---------
>  drivers/net/intel/iavf/iavf_rxtx.c       |  2 ++
>  drivers/net/intel/ice/ice_rxtx.c         | 15 +++++++++---
>  drivers/net/intel/idpf/idpf_rxtx.c       |  2 ++
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c     |  2 ++
>  8 files changed, 57 insertions(+), 21 deletions(-)
> 

This change seems reasonable to me. Ran a quick test with 2 x 100G ports
and saw no degradation in performance, and it seems to improve performance
by maybe 1-2%, in that quick test.

Therefore:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> diff --git a/drivers/net/intel/common/recycle_mbufs.h b/drivers/net/intel/common/recycle_mbufs.h
> index fbe09eb5d0..564c8320d1 100644
> --- a/drivers/net/intel/common/recycle_mbufs.h
> +++ b/drivers/net/intel/common/recycle_mbufs.h
> @@ -129,10 +129,14 @@ ci_tx_recycle_mbufs(struct ci_tx_queue *txq, ci_desc_done_fn desc_done,
>  	rxep += refill_head;
>  
>  	/* is fast-free enabled in offloads? */
> -	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
> +	struct rte_mempool *fast_free_mp =
> +			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
> +			txq->fast_free_mp :
> +			(txq->fast_free_mp = txep[0].mbuf->pool);
> +
> +	if (fast_free_mp != NULL) {
>  		/* Avoid txq containing buffers from unexpected mempool. */
> -		if (unlikely(recycle_rxq_info->mp
> -					!= txep[0].mbuf->pool))
> +		if (unlikely(recycle_rxq_info->mp != fast_free_mp))
>  			return 0;
>  
>  		/* Directly put mbufs from Tx to Rx. */
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index 5af64a4cfe..44b6ab76e2 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -61,6 +61,11 @@ struct ci_tx_queue {
>  	uint16_t reg_idx;
>  	uint16_t tx_next_dd;
>  	uint16_t tx_next_rs;
> +	/* Mempool pointer for fast release of mbufs.
> +	 * NULL if disabled, UINTPTR_MAX if enabled and not yet known.
> +	 * Set at first use (if enabled and not yet known).
> +	 */
> +	struct rte_mempool *fast_free_mp;
>  	uint64_t offloads;
>  	uint64_t mbuf_errors;
>  	rte_iova_t tx_ring_dma;        /* TX ring DMA address */
> @@ -154,8 +159,13 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq, ci_desc_done_fn desc_done, bool ctx
>  	struct ci_tx_entry_vec *txep = txq->sw_ring_vec;
>  	txep += (txq->tx_next_dd >> ctx_descs) - (n - 1);
>  
> -	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE && (n & 31) == 0) {
> -		struct rte_mempool *mp = txep[0].mbuf->pool;
> +	/* is fast-free enabled? */
> +	struct rte_mempool *mp =
> +			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
> +			txq->fast_free_mp :
> +			(txq->fast_free_mp = txep[0].mbuf->pool);
> +
> +	if (mp != NULL && (n & 31) == 0) {
>  		void **cache_objs;
>  		struct rte_mempool_cache *cache = rte_mempool_default_cache(mp, rte_lcore_id());
>  
> diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
> index 453ec975d5..8fe6354325 100644
> --- a/drivers/net/intel/cpfl/cpfl_rxtx.c
> +++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
> @@ -565,6 +565,8 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>  	txq->tx_free_thresh = tx_free_thresh;
>  	txq->queue_id = vport->chunks_info.tx_start_qid + queue_idx;
>  	txq->port_id = dev->data->port_id;
> +	txq->fast_free_mp = offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
> +			(void *)UINTPTR_MAX : NULL;
>  	txq->offloads = cpfl_tx_offload_convert(offloads);
>  	txq->tx_deferred_start = tx_conf->tx_deferred_start;
>  
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
> index 255414dd03..5a73e5d1b3 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -1337,8 +1337,8 @@ static __rte_always_inline int
>  i40e_tx_free_bufs(struct ci_tx_queue *txq)
>  {
>  	struct ci_tx_entry *txep;
> -	uint16_t tx_rs_thresh = txq->tx_rs_thresh;
> -	uint16_t i = 0, j = 0;
> +	const uint16_t tx_rs_thresh = txq->tx_rs_thresh;
> +	uint16_t i, j;
>  	struct rte_mbuf *free[I40E_TX_MAX_FREE_BUF_SZ];
>  	const uint16_t k = RTE_ALIGN_FLOOR(tx_rs_thresh, I40E_TX_MAX_FREE_BUF_SZ);
>  	const uint16_t m = tx_rs_thresh % I40E_TX_MAX_FREE_BUF_SZ;
> @@ -1350,17 +1350,19 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
>  
>  	txep = &txq->sw_ring[txq->tx_next_dd - (tx_rs_thresh - 1)];
>  
> -	for (i = 0; i < tx_rs_thresh; i++)
> -		rte_prefetch0((txep + i)->mbuf);
> +	struct rte_mempool *fast_free_mp =
> +			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
> +			txq->fast_free_mp :
> +			(txq->fast_free_mp = txep[0].mbuf->pool);
>  
> -	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
> +	if (fast_free_mp != NULL) {
>  		if (k) {
>  			for (j = 0; j != k; j += I40E_TX_MAX_FREE_BUF_SZ) {
>  				for (i = 0; i < I40E_TX_MAX_FREE_BUF_SZ; ++i, ++txep) {
>  					free[i] = txep->mbuf;
>  					txep->mbuf = NULL;
>  				}
> -				rte_mbuf_raw_free_bulk(free[0]->pool, free,
> +				rte_mbuf_raw_free_bulk(fast_free_mp, free,
>  						I40E_TX_MAX_FREE_BUF_SZ);
>  			}
>  		}
> @@ -1370,21 +1372,24 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
>  				free[i] = txep->mbuf;
>  				txep->mbuf = NULL;
>  			}
> -			rte_mbuf_raw_free_bulk(free[0]->pool, free, m);
> +			rte_mbuf_raw_free_bulk(fast_free_mp, free, m);
>  		}
>  	} else {
> -		for (i = 0; i < txq->tx_rs_thresh; ++i, ++txep) {
> +		for (i = 0; i < tx_rs_thresh; i++)
> +			rte_prefetch0((txep + i)->mbuf);
> +
> +		for (i = 0; i < tx_rs_thresh; ++i, ++txep) {
>  			rte_pktmbuf_free_seg(txep->mbuf);
>  			txep->mbuf = NULL;
>  		}
>  	}
>  
> -	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
> -	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
> +	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + tx_rs_thresh);
> +	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + tx_rs_thresh);
>  	if (txq->tx_next_dd >= txq->nb_tx_desc)
> -		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
> +		txq->tx_next_dd = (uint16_t)(tx_rs_thresh - 1);
>  
> -	return txq->tx_rs_thresh;
> +	return tx_rs_thresh;
>  }
>  
>  /* Populate 4 descriptors with data from 4 mbufs */
> @@ -2550,6 +2555,8 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
>  	txq->queue_id = queue_idx;
>  	txq->reg_idx = reg_idx;
>  	txq->port_id = dev->data->port_id;
> +	txq->fast_free_mp = offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
> +			(void *)UINTPTR_MAX : NULL;
>  	txq->offloads = offloads;
>  	txq->i40e_vsi = vsi;
>  	txq->tx_deferred_start = tx_conf->tx_deferred_start;
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> index d8662fd815..18ec1d5d78 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -820,6 +820,8 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
>  	txq->tx_free_thresh = tx_free_thresh;
>  	txq->queue_id = queue_idx;
>  	txq->port_id = dev->data->port_id;
> +	txq->fast_free_mp = offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
> +			(void *)UINTPTR_MAX : NULL;
>  	txq->offloads = offloads;
>  	txq->tx_deferred_start = tx_conf->tx_deferred_start;
>  	txq->iavf_vsi = vsi;
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index 74db0fbec9..e4b4aa2806 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -1628,6 +1628,8 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  
>  	txq->reg_idx = vsi->base_queue + queue_idx;
>  	txq->port_id = dev->data->port_id;
> +	txq->fast_free_mp = offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
> +			(void *)UINTPTR_MAX : NULL;
>  	txq->offloads = offloads;
>  	txq->ice_vsi = vsi;
>  	txq->tx_deferred_start = tx_conf->tx_deferred_start;
> @@ -3409,15 +3411,20 @@ ice_tx_free_bufs(struct ci_tx_queue *txq)
>  
>  	txep = &txq->sw_ring[txq->tx_next_dd - (txq->tx_rs_thresh - 1)];
>  
> -	for (i = 0; i < txq->tx_rs_thresh; i++)
> -		rte_prefetch0((txep + i)->mbuf);
> +	struct rte_mempool *fast_free_mp =
> +			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
> +			txq->fast_free_mp :
> +			(txq->fast_free_mp = txep[0].mbuf->pool);
>  
> -	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
> +	if (fast_free_mp != NULL) {
>  		for (i = 0; i < txq->tx_rs_thresh; ++i, ++txep) {
> -			rte_mempool_put(txep->mbuf->pool, txep->mbuf);
> +			rte_mempool_put(fast_free_mp, txep->mbuf);
>  			txep->mbuf = NULL;
>  		}
>  	} else {
> +		for (i = 0; i < txq->tx_rs_thresh; i++)
> +			rte_prefetch0((txep + i)->mbuf);
> +
>  		for (i = 0; i < txq->tx_rs_thresh; ++i, ++txep) {
>  			rte_pktmbuf_free_seg(txep->mbuf);
>  			txep->mbuf = NULL;
> diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
> index 4796d8b862..b838d7650a 100644
> --- a/drivers/net/intel/idpf/idpf_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_rxtx.c
> @@ -440,6 +440,8 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>  	txq->tx_free_thresh = tx_free_thresh;
>  	txq->queue_id = vport->chunks_info.tx_start_qid + queue_idx;
>  	txq->port_id = dev->data->port_id;
> +	txq->fast_free_mp = offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
> +			(void *)UINTPTR_MAX : NULL;
>  	txq->offloads = idpf_tx_offload_convert(offloads);
>  	txq->tx_deferred_start = tx_conf->tx_deferred_start;
>  
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> index a7583c178a..824e328230 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> @@ -2878,6 +2878,8 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
>  	txq->reg_idx = (uint16_t)((RTE_ETH_DEV_SRIOV(dev).active == 0) ?
>  		queue_idx : RTE_ETH_DEV_SRIOV(dev).def_pool_q_idx + queue_idx);
>  	txq->port_id = dev->data->port_id;
> +	txq->fast_free_mp = offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
> +			(void *)UINTPTR_MAX : NULL;
>  	txq->offloads = offloads;
>  	txq->ops = &def_txq_ops;
>  	txq->tx_deferred_start = tx_conf->tx_deferred_start;
> -- 
> 2.43.0
> 
