Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C41EEE3691
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 14:46:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4644E402DB;
	Thu, 12 Feb 2026 15:46:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4026640268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 15:46:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770907564; x=1802443564;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=w+ME5ZnXNpLl6Awi0mI1CRouDgcuTucj50tOEafVO/o=;
 b=FnsFiTc1v3m0rkVC22FW8r3+ShkIP1k+NXukjIrEVdxeiYAZW4kI7hKD
 EyznKcyVZ9z6U56lKilhGJiJjCwlz6wU6n3pifUdNXFWy0XS/Z6DToRdX
 M/vSuE4Ts9YlRZGla3ercBSNOX7L1Dpe17h238YQoJxzbROWny4dv4viy
 pcJp55m0oUmTzLlyqSNDZL7cnrOAZTrrrITLg81EVGiOhF3/gsFDacGka
 hu8a2DLZliRt+OfUhjzS6xwngHX6YvRgz6WkrQZLdQ1v5rMjnl7smC5vg
 +efSQn8nj3S+paC+hpeqpl0imrtCJIWjPZOtXyUFdDCl1lXGMUAzbCbCx g==;
X-CSE-ConnectionGUID: M6ayW74oTviJsvhDIxQVuw==
X-CSE-MsgGUID: xQLM9gm+Q9OZ6Tah4jUmJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="82806665"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="82806665"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 06:46:03 -0800
X-CSE-ConnectionGUID: 441Gu/39TZKJIxjIewGYXg==
X-CSE-MsgGUID: Hxbnup6yR56i28q++DJWHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="211712173"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 06:46:03 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 06:46:02 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 06:46:02 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 06:46:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+WpAMk5eGaxmAy6I373DJ3ZLlcv3qwzPnrkRx3KkZAe6INM8zrL9IwKIUslALc3bDo5bR+CBLhpj0ZPGdO/VzYOVfE0JFSMner45B+hCao76kE4Efd53BSPJT/jvteJzwBo37wJ+Xj1fpyUCzi0yEkb9GqHrq5IB6v0+FOsyAptMkUKbDBQ5u7FS4TGulVvzhC/I2v8R9RqwpGrbJ6f6FPX1+XJjxYo+OWMjFWAAnd8TVhU/QEm2u4dxaS95JMQ3cfCZbYw/vJuQ+oWuE9kC7aM6/EliwCwUxVDwgbFIPC3BaghRXVlmW5aJW3W2nXGb5C7ZeSpa9o0fnSK250GHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCWlXXvt1wP6D0K3///5ioXqHZuT1E3B9u6joJQs4oA=;
 b=a4a3Qyfzs/lXYw+DXBIj8w4sCzGyzcErrKJWRTR4GOI+iiuzosDY/2H8dr2oJLvmhzcqPSeKQdKPv3wuis17DneWIawjARwZ4ZO9+Ejnq5TXV/kXI0v0M591NuaDdFWYkrHcYx41k29LFNcWZCDL45g8UtVHgMmp9Zc8zHe/42Lch1oX7LyZgAWpInTGndk38qYkTweVEGElXy44PDkyUBI/h+Hoau4laKdI0XAQfJc/qDWxtROR3a8DmzsaQ6YyeXkySTQ9DNXucgOMsf+nBc5Gz2N9AgRJwNRwJYlNK9hOU2BDUZKue/8obKw1RHAjcOiAPJTjhm4lDOBERGJYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7979.namprd11.prod.outlook.com (2603:10b6:806:2f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 14:46:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 14:46:00 +0000
Date: Thu, 12 Feb 2026 14:45:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH v5 00/35] combine multiple Intel scalar Tx paths
Message-ID: <aY3nojowwWvfwUv6@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260211181309.2838042-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU6P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::13) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: ce69ceee-be88-4021-5c17-08de6a456fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ox1afQwXPQ5JZxNDIeCXriss18kk/HgargePOopyuV3jypTVFrQJ0pWu3B51?=
 =?us-ascii?Q?bH4nXDglO/CcLO28o9C88+Ym4ixS0YLjqlcTYZoTdIHMD41shgYtB1AYuAnJ?=
 =?us-ascii?Q?2+RJmkSOLjBjzUbExFHVQliI9FcM7l5n27JO5HUcpDM8l3ICpvz9n9V+dBHA?=
 =?us-ascii?Q?gxO0E1/U5kEDkuOrKIOCdnM3cqg8pcJQWk51J91H9pLoNi8Vm9T6FWPos8cu?=
 =?us-ascii?Q?AFOipkojSCFRXHugT2L87pT+E5i5MfsELYLyYd2zoPxm3a2Or1PF55IMJC6c?=
 =?us-ascii?Q?XqFIHcA7T7ak/863q2PBkYG/kgilEAOdGJFn/mMck3wj8H8NtDFAAVPECjaw?=
 =?us-ascii?Q?WKHU/d5zN8H3xv1lhsTHfpSdUoSuvsodmBS4iYJajbmMBXulRrjhIuguaG9Z?=
 =?us-ascii?Q?PMm/k5A+aiJfPYxsBwgxKoHzCk/Qtsyk9orWDvo+tyDMQ6GoRwyShCiqye1M?=
 =?us-ascii?Q?NYAIuXkkrce9mkI4ZwCpYyLCAIr/q2gtO+K9Y02KOj+GsC8Z+aWM18arGfZA?=
 =?us-ascii?Q?71b9fdPGvMWwjRvGzzNi01caZlKhkRpL4qn3PrraNGTzgxmtvipgtuGyz2ZX?=
 =?us-ascii?Q?WGOn7Q++CeRUNX4d/M1Q5D7NJIjXTPRJ8OSFgNncQsA2+xcp/HeBbiC/LzoD?=
 =?us-ascii?Q?7l+eko2gDeSWRMl1pqYusqPuetDLfwVXOP3DDfYyFeRvs4dmh/5vpQeCrArB?=
 =?us-ascii?Q?iQVUWNb2XcuC3A9PM8hCyF/hZrNK7ZGemPZzZXuM+zakYHR+c7Csxjf6nU3T?=
 =?us-ascii?Q?+DYAhdaEJ5wYMaONM357rzcKPLxHYYHFvJ0yS0RBWGgf+Ie2L7vxtgON2D1o?=
 =?us-ascii?Q?Q/DF0E23KBzAWTQDlZSPlRq0G3id+mB72EsdV7aYgGXgP5HDr3TYHTpIiQsq?=
 =?us-ascii?Q?Z/yCUQongkxf9oYlC9NtSpPlAICy4MzEMTYmLoxtOX9O+Wha2JObbFRmG/vE?=
 =?us-ascii?Q?ssl6RkEwHu/2xWJslhkRjQvKmUaqXollYXEtU4/u9B4kOrTpSyP99XATSfW3?=
 =?us-ascii?Q?/QfmUHjhg9VW6a4YdvTWrTazO2t6La5kvfD8zjqeZprole59J8vwg0qLu8Pn?=
 =?us-ascii?Q?+SKHiEZRGBTd8hZez1qCJmxod1B/CdqBF6Nd4diWsdSlfmuRJOR32FJ1971y?=
 =?us-ascii?Q?T/P6fAIrtF96cLoRy7LOPNjqjWD3RBC47RYXLRLlZluIh0oUcvQhHHDWZ5Mz?=
 =?us-ascii?Q?aJ/Ir2p0bBY3PK76kA8dB/Qyx0dVZkteXlan2SyxzgI5CRZoDmAxRvHnjS6a?=
 =?us-ascii?Q?gtV1p+/GIy/xaGs+KyMd6Cm+C1nQYB46bn+GmLKzhb+zD7/M30Q9pU06Bwjz?=
 =?us-ascii?Q?5GYipArjgVH7beJhfOMDFDV3y7eyZ+BwJ6BigBSJ25fN+j8rjAPY8kCXHQFA?=
 =?us-ascii?Q?aAaJJ+td9Q1IJadqFMZ7cjn+89ONfKwj2JBjlmrk3L82ABDzNOQ6ilndkgsy?=
 =?us-ascii?Q?wO9uMGwRTq+Dlnps4aIHrJaBMheri3c9ABMvAeG/HGwYrPR2okvhY6ZgeNEx?=
 =?us-ascii?Q?JcKLaeIQoz0svEON/8SCNIzfdBXyRSMAzreJ2MexL6Fmr8Ea+UOiTqicwFXG?=
 =?us-ascii?Q?DS+8roBjaPqCJmg4UEU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iSojumM1TI3FcE5YMyOaNVjSuG9KnsccIN0Wb4S0yEMuYeRUblPgHQdQZnzW?=
 =?us-ascii?Q?fiw/Ox3EkQydMA7mhImToy1XF0tm5RwYHxgv05sEOp38S9E9AysSG3Syq0Ek?=
 =?us-ascii?Q?hvxFwCL3iIH18bZAhpIHOaSeqoBCJ5xuEdqCB/kA4WC43YXkGhjxY7nPz5Pf?=
 =?us-ascii?Q?uVIztQOV3GZLqixySkCeMaNZzRVA1EBvmS2Vy7I1xsC6R+AM4rvTT3zDxUVW?=
 =?us-ascii?Q?PmsgVwlEFX1vkzXrSD+d2TJQYS3QNxGWetCLihhGSmfr611VLu5JIqbHiEvB?=
 =?us-ascii?Q?cenu8UWVbw5Dg+ECvkVaR2RaT/VydQhU/yEr2bFU2+g1BPVPSmkTqaZVjE/9?=
 =?us-ascii?Q?Olljer1GVAIw6DBFwFIaPIOLlVmXgrIKZzlgx48GWPb9Xg7zaReGJi+Qrnig?=
 =?us-ascii?Q?iHYXC8G7+sgVFvTUrz3Gm2rse5kvmBZl2Fmd9MukRyVf2H3HCQsv+z6NwQpc?=
 =?us-ascii?Q?p9NpgMf5A5TkKeg3+X8alS4abT99lahQh91DknK0CcvU73OP5uKOMWJBxm6G?=
 =?us-ascii?Q?9dQQk11NfZtfbnUOSGTTNKeLknXnOf0Qys4STdhF7zbVHW2SD7muB+lp7FFH?=
 =?us-ascii?Q?JlTYUIWdyN4/AxYaKRQo/zAORnOpzXFpvEFAVYdJTJIX0EKD9+JAk8VP5ZPP?=
 =?us-ascii?Q?p7C+9ENUXl/SfCPcw+ynqZXAHHPUCMhEXK0vgI7n5tWS46iGLmNjy0I4awGG?=
 =?us-ascii?Q?zb8RyUzzBAyUaa9np9/j/+6RLljHisv+waY0IkXBWvU3mtSXKqlG6++El61g?=
 =?us-ascii?Q?js0jGdARBLuHHuX80WbQcwKtBP168XlYQIwW/A6PISG96NghUPO6+sB1vwaT?=
 =?us-ascii?Q?sT8zBlTbUqC/GfpchMOvNn50oRgZ42/zT/J71B2DWaYDjIgvQYCRzyWdgwKv?=
 =?us-ascii?Q?XaX/iqXpz4R9Y3NzBcVyP5V4/o9RWs2nF0cwj1D3YsPk1ejUoltHNCGOXC6D?=
 =?us-ascii?Q?sn7IwWuLUPuVUbnP4yaZrcvNNMswqkwWMY8QgPDZ4eFrsCtrQFD+Xe3DPsSl?=
 =?us-ascii?Q?/SVC6CLBEz+KN4Ew1olEjoXLIB+90xyjKdk9WCjmrzq7NXQ8gNWAFxX5WkgX?=
 =?us-ascii?Q?y/Q14v158awtsIwT3kBLNjKynBHEm6kslpjPKBmLspHocU7MPQ4tJmACbG1m?=
 =?us-ascii?Q?ViC/MGvLkZALteBv5iEcyksVgyqpLXE5SqiATi+wdWdHz/IRlP7S4u/foqaz?=
 =?us-ascii?Q?Bmr1/6cHF1g66GB4SWOyinZxbbRYWC1JzWhycuU0bAz+Ud31cBOMplxn+FF3?=
 =?us-ascii?Q?12gDWUb6xPNRn9eKjxlA97ZjS/9HYPblPKkNY8nANkM5uNDqQ9WbmPrHH4gg?=
 =?us-ascii?Q?DBaahB4N5luwZDG8wM6ja3Pf0EEf/Q5gWqcwVPCW+53GXl1LGIxCDbfPVlvE?=
 =?us-ascii?Q?yWPRiJfg5UcIZDaiyuZMgOj7h8Q8ye8dIfQcwMDYwZG3ztspcWUWyabyjBNa?=
 =?us-ascii?Q?HJqh+QCP2rJKIXAaPuob/icePw/iN0N+h4Apft9P9rUiGH+lMf/TnoAnh4wV?=
 =?us-ascii?Q?xuLiE85k3mWOFLhDCSFGbwCykrk6C/L5xUsN0hHUek7BFLITSnRpCZa+lDGA?=
 =?us-ascii?Q?P0YG7IGyuNW5K4U46NVwwyiMeDIK5ZT/E08dpTAK5yekgyHyhwREuor0sDYT?=
 =?us-ascii?Q?Ze5LLbsKnl4hOb3J9IRRrnDVEWImUrrXcJYddcR2MqnBVReoG0fn/m7/nsWk?=
 =?us-ascii?Q?AxwNcYUKcIrBYfFlaXSKo+n06EVRUyJwPU689fFJPilElBZbQDgQAvo5/knl?=
 =?us-ascii?Q?J8Vu3BpofsCDf3vxTpCiPFs0rCEIflE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce69ceee-be88-4021-5c17-08de6a456fcc
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 14:46:00.0844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KwhYq2NMwHkUY31IFTsoue8cXVsMB+yeEaeua7OQPskf4f90sVVZChwPzENMUNbqESXjpHDSsh2UKBIPFO59HB77pyBToRQr+e1hH6555Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7979
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

On Wed, Feb 11, 2026 at 06:12:29PM +0000, Bruce Richardson wrote:
> The scalar Tx paths, with support for offloads and multiple mbufs
> per packet, are almost identical across drivers ice, i40e, iavf and
> the single-queue mode of idpf. Therefore, we can do some rework to
> combine these code paths into a single function which is parameterized
> by compile-time constants, allowing code saving to give us a single
> path to optimize and maintain - apart from edge cases like IPSec
> support in iavf.
> 
> The ixgbe driver has a number of similarities too, which we take
> advantage of where we can, but the overall descriptor format is
> sufficiently different that its main scalar code path is kept
> separate.
> 
> Once merged, we can then optimize the drivers a bit to improve
> performance, and also easily extend some drivers to use additional
> paths for better performance, e.g. add the "simple scalar" path
> to IDPF driver for better performance on platforms without AVX.
> 
> V5:
> - more updates following review including:
>   * dropped patch 19 for new EAL macro, and used struct alignment instead
>   * added extra comments for some code, e.g. reason to remove volatile
>   * dropped patch 22 marking a branch as unlikely
>   * split bugfix off patch 24
>   * corrected idpf path selection logic to not assume in-order queue setup
> 
Series applied to dpdk-next-net-intel

Thanks for all the reviews.

/Bruce
