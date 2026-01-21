Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482E7C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 16:11:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39F3E42D7F;
	Wed, 21 Jan 2026 17:11:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id F05FC40261;
 Wed, 21 Jan 2026 17:11:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769011913; x=1800547913;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JI6TM9wfVYKqwjKnYcG4O8NOGX7pSq4JVOWEJcHME/M=;
 b=hHkqZwfC4Pv/V4rq6Cv3xHNEX3HrUa91fsQHX2p4ZFLsGL9hbotZxa8n
 zJ8aKbXNvqcC/w1P0Bpkjjw01/ZQdMTTF5up7ypdlbhgl/01hFokL9wBX
 /IURN+mbzxsK9jzdmajJJGDCbMDZooZsGzYgb8N1zoZh4MrTPg5HiipV3
 aXbSnXz/Z7wXTJCcyd664YGWCoLL4jpCsffKy72qiVajJJQDLE34YFuMR
 mLdWRf1wfcRseuiX7TIQ9i6nwREIKWcErQyVuHW6Jm1vt3duPNnbq3OFB
 8PB1qlWoL2r27J4DCofjqzepdFy069PvzMTNPmVdYVU1uXq3QPw7vaCfd g==;
X-CSE-ConnectionGUID: odp7L/TvRiatM7wihb6fKQ==
X-CSE-MsgGUID: s85iJkQUSwqZkADTp9Rqvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="87654332"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="87654332"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 08:11:52 -0800
X-CSE-ConnectionGUID: bPLrswUOQQGfelYvwuQPhw==
X-CSE-MsgGUID: bpcQYYboQJm5RybNDPZ4uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="206911548"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 08:11:51 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:11:51 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 08:11:51 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:11:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcjNSqYlCFEa9J8A7wCFLKd0yxV6LDSlkw7SMj1JEdoJ3hi06yvk4tyG3OXdXSuKc4DzZg/NVMPOc8awEv1XSlV/t2pj5hJzf6ni8fn6G4XzAx9tFOX1wMfuHA8fMVXqnbO/h2pSIQcQKWG+3DWZQwTo7MxhtlePDx6vI9Bk2crjxvInPJdHYZ9lQFGyEGX015UKXjWoem/dGYODWMV/j6ZruCpOtEwvUnojqSGK5GtJrgKM2s75OH2T1J6rMR/mlth+FI/uY/P4K/yhHkQTBCk/gND4obtyxQSkDWD93zvHzlkB6yTZkZZ+KVAnL+9GFrwRGy4CyqgayXMGkbEDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcunqRHSnd3F/EAp4KCncFxY1Q7I5Rk2+V1q7B1wiDA=;
 b=Em+xIXYzw7hr4+i+EQMezmbSFdFHUPWXrIIRld6xjhPMRXoIpqbnt6fidpbBgHaAeDBcl2udTMJyVtO97s0HDSdTHoWi+yK82/to6e9Cv0EDUfm40BP+CXHJID4XToTkHMtgsPQt+xnHrIdV+0APZbypFxh3NMv22KfacreGoKTUBIcQKqQj1WS0dL9cwkv6ofTv3t15/8WtaP/pCJ69wBkuT61ntUTBanVUkblG24nitZ41aP1tDfYkD28ujYgSnKrayecaJYefuhhyelKWtfqgtlRZGuo9v+O7UxXUsMCmqy7KFA3kRgvhhyNzbbmYNCXtNKKrPqgsWNaXvYy5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7876.namprd11.prod.outlook.com (2603:10b6:930:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:11:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 16:11:47 +0000
Date: Wed, 21 Jan 2026 16:11:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 2/6] test: fix timeout for atomic test on high core
 count systems
Message-ID: <aXD6vkhPBfgyroYb@bricha3-mobl1.ger.corp.intel.com>
References: <0260118201223.323024-1-stephen@networkplumber.org>
 <20260120015759.301155-1-stephen@networkplumber.org>
 <20260120015759.301155-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120015759.301155-3-stephen@networkplumber.org>
X-ClientProxiedBy: DU6P191CA0047.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e9a957-f22e-40b9-c0c4-08de5907c6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o2n6oCiTCiMEt/SEpojYpwQ7EZ/gLFnL2Q0sgMoTj5m6f5R6dW++ZlKDCHpq?=
 =?us-ascii?Q?c4qXnd01rc2eLj3VEPuY6U7XIqtQSoLl1LCCcMsx4odeXo89NQTuq/xsDCJV?=
 =?us-ascii?Q?9cDPXSjUwyLzUW0uNfmaENxamvfy+2bCGaMbjXihfWt2QyxCGBY9rRgnl1Kx?=
 =?us-ascii?Q?OCbinEign6B4jocdPDta7f5NFxkD0JD2iMDWMmmzU5c7gS+YVZXXO7JQkUaB?=
 =?us-ascii?Q?LNr43ZjDB7rB9UtdacW0UXq9r5yYqJMmTXpnBOvErjNo/oaiFa4dC9FZlja/?=
 =?us-ascii?Q?jskQGRoYH1YnwQtSka/XcyEcdOASJBEncGULH5m3UvDagfQjngxJhJW8aTud?=
 =?us-ascii?Q?rXeBIk67WVEudXSnAdKxd7Hrenp1VWD7p69mY6XQuRxIhPqcFkFeeyksc/i3?=
 =?us-ascii?Q?16x/nRWWtn8TwxXNqCtVvxHPxKx+MDACUYtz3xHcpla1GK1F9jMnUal+e3WG?=
 =?us-ascii?Q?iXUM4168xC7I7N8qg1GRB+boaDLuvaX/XPY/zfhwSVMwGiPxgwfs0pQwqbj5?=
 =?us-ascii?Q?wWxkwcdDBxkLXOibnw+eBFSG8uEl/kt2xBO9+IXqssB/bh9tt8k8XIYFm1jp?=
 =?us-ascii?Q?Vh5B9ddBWDvbFCbVbE5Q8g2P/jScYg2s9OdmwxwxoaGslgXTJ4SqJs+vdE4P?=
 =?us-ascii?Q?NGESLw3kK6w0eo58uvXh9TLJpfks2Bmm5qz8peN8GPbK4J91kjkJlJl/p76J?=
 =?us-ascii?Q?Bkji8QQcfZcSxJClWWy0hrZjZ6Ic/nrOuCEXajCfQn9m3b0CL2DPxWyPwAcS?=
 =?us-ascii?Q?mkDG758RWx+ki8jH6fo++EDSzud5wYQs9D88rdzH426acklj544mabZqfzMA?=
 =?us-ascii?Q?Q5NpbhNJPjObEFMHLbX8YM56DwSV/OHIJzZt7Z+ZfWaSTYXDUIzjVdzct5dm?=
 =?us-ascii?Q?mj1m4RAOuT2XakdoJwiNjunVXQ8iHGk16AfOxr7KdbfDcEWuCPUEqBkU0JCx?=
 =?us-ascii?Q?IJZjCZKb6PF81OiBPLCnYwleAloy7kinFDj6jH9gjRXhyRiU53Ge+Ik50Ef8?=
 =?us-ascii?Q?NKrlFbl6KE3uzCyaWdZUmwkhilcihFwmKORMmd4K0jdHdqp8GjXGwwDC61FH?=
 =?us-ascii?Q?Oc7LNSmiYCi8LP5PXf0zTcw+O5SPLldDKLKst2xLTOiLe6XARIcjrHtWPdUT?=
 =?us-ascii?Q?3afFEQcwaQYOZJa3RdQxCi2Ems7vaeLqisys7C5MgRVajgs/opy3JZI290h2?=
 =?us-ascii?Q?c9GQCws42Ryes8RtrHyu0fjBYv2eOcRkQQpbeonf2NWtVgzZKPXPruB/fcCE?=
 =?us-ascii?Q?gWwYi2DlN04m5xo5rJ9clvX2C1mj7OPepedhPBNt1fffOlKHhdr7VTjK9xHB?=
 =?us-ascii?Q?u3bC3iifdBELruDCCHGqQVr54/JlI2LG8k8KGS0qe29h128KLiQYjWvdqFHu?=
 =?us-ascii?Q?X8hCbfnoibXO1JEAu+MTyS2tjDd/OFxAWNIoFCLiaNn9uITlSbD9GOeOzl4K?=
 =?us-ascii?Q?tVKnlJFmt9wCNr3IvVZDte6WFCnKDTeNsH0/0tnKln2Bg9O7N0FaZ+RV9pjD?=
 =?us-ascii?Q?/l2n2FypQy6YMfVGefR3PsXYUWG7uxGO0L0lAXhQ7/ug8SCGcNPmqeYkxTyV?=
 =?us-ascii?Q?w4gTaGdgGsDw7SzrYwo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uG4Uc/J/XeJggN2mW+YCnmwDx427HTskPKyfV1BXI9beKPyQCIYxNOh+RZxw?=
 =?us-ascii?Q?Mtpwi5P+efnk9bGQM7NDghYH5dS7NwD2JqyYpmEB1nh+OUC/z3sZeR8bXzHH?=
 =?us-ascii?Q?gVmj/FYWcrBv57ICjQqf4U4TXv0docYoP9s9YZwdTyLwK8Z6PZBKpUlAlq9J?=
 =?us-ascii?Q?l/3HPIgc0Rsvll2etSfYw9XKtllijELMBxhJiREC6GTgur7YytB+FFkcxeGB?=
 =?us-ascii?Q?XL4OWjZFMB0+3hX9SoRoNF5Jk+LUvaynl8aUCuRVPTXjgcZ1OlImBh8SH0XP?=
 =?us-ascii?Q?lEeQ4km3SV7FdaK5baiFcNllGHoENw4eakya1yBMbEkZqjx7MuOjmKW0ywAd?=
 =?us-ascii?Q?+TAfiWFu7uGxakul95woXDrPZhHXZTShnVzo5OQ66pF6bQPGwyhdNtFsBs7s?=
 =?us-ascii?Q?jHfeXNZ+f0E516y/CDbTqafyhhEv9AEegkMqTNH6Li2ytXWbwEodgwOyXuyA?=
 =?us-ascii?Q?Msjjcjh6+rwuMYxaJdA92CsgPBzsaXaVU1XCtZY4wij8U1N9Cj+unDLrxa15?=
 =?us-ascii?Q?ECMk/wNYdXkDjeQqBcoRxmrNZ2gkmwN4lS9Smlij4dkmWUzRxUGAMLfblQo/?=
 =?us-ascii?Q?97fyeH0oHIf0aKg0EfUQrfER3i9L/jM4YpqIiNLev6qquHJzaq7R8oCrZ+nq?=
 =?us-ascii?Q?WVmRbUszold6Jne8H0nhoT3NRVtxJaWcgUOkaFqD9KRfpUjHlSdwyIs5vYiW?=
 =?us-ascii?Q?IZY1nEzAywfHuSMoAlg++cZ2yMqNIwtgRTIMuPCx02j9PvbfJOjae7V011sZ?=
 =?us-ascii?Q?RyjtITOhqgpp238uPEjVQMl98svJkhporZiWZWTco2oPHLTJ5XfwleTabT9t?=
 =?us-ascii?Q?/45zXmNoivEeuQWlTBP0lAa7MlWPDFT1jMx+u6OXKXtAOrdGILu2LsHQgq+F?=
 =?us-ascii?Q?sH+TA+IEUjCThLgGT81YwKjasmkoFp10vg0dEEWBXcFY1tMjtCYRfV84Y5X2?=
 =?us-ascii?Q?fZY3dSD1+i07WXt88Zwwk8s9mWkvxickFuKfBZA5G6JAeYI2eeCJTfYwXbJS?=
 =?us-ascii?Q?y9n+6HEU+c++IKKC+Ug7QyK/QwlWZSu4hXNU07DxAwQM1z/NJbV/w8VMIR66?=
 =?us-ascii?Q?tYd7PXFTBBwz7SrGOyUYGmDaBhNrzovtfYAFepQUnc6Tq9dLITqaf4pat8ZR?=
 =?us-ascii?Q?H4NqhOiV60a0hQPnL7K5dLuar74rZYlquypC6t6dEfkXfHS4ENNplZQk9+jL?=
 =?us-ascii?Q?4q8KlzERazm3kuxng00vwL7VZTYJN54/RYD/TThIIfsn58rEpaKmCbbwNaxi?=
 =?us-ascii?Q?iPFOCLEkvmBT3WTNR2RikNe06cz9pr6EBXIYvTdPP5lL21n/AtYrfvRNF+C4?=
 =?us-ascii?Q?yd067vOWBJz+AeFE1aXAy65D0eeTwvetYZdKesAnn4vmQnmslYuy/QrLihv1?=
 =?us-ascii?Q?AV5ZPEeCBGW4407zS0SdjEXZ0T6kMYfjM9WtoDoPYGJnH+Z4uMZNKjfNUx42?=
 =?us-ascii?Q?Eu4oswzhIjH6ZRAC8C8hsWIikB4xVKwG9AS6vtooMQEPRePgbae54VoZh9h3?=
 =?us-ascii?Q?QpFmk2eUaQ0E+ICgBUBRAOd7EnZULZ4cAfH6adA2j8sfaQMeBZjEQrqCDH1Y?=
 =?us-ascii?Q?ew20R7K4+XXw6Y+OTHoRHk+m0LGtG0X8IhR6mmlX3fxQ9dzeghX5+J+p8mjt?=
 =?us-ascii?Q?IvJcNMM/zX6s0BhCUpZ1d+ZXIZ/LbUTfMAfdCuCbUuLaRXFnpiFl0bOYuSrJ?=
 =?us-ascii?Q?noDf1LGQt+NgD67vDPv3Ia6ySgfI5bE160O7LBxK5RTdu47jP3MwVMqWA5DR?=
 =?us-ascii?Q?oJb9xeREygisezI+LlQJNmUfhivv6qA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e9a957-f22e-40b9-c0c4-08de5907c6df
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:11:47.0532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLPnfoSvOXr0WE3KK0DB6mejUuMG7yvyVAO0/fG6iXtdKgiG9+IsoHyZ0anXH+fBbGBoek657pjZezH6QUGYxCOC8Q5qDjW4Tlp2zX3RO4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7876
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

On Mon, Jan 19, 2026 at 05:55:05PM -0800, Stephen Hemminger wrote:
> The atomic test uses tight spinloops to synchronize worker threads
> and performs a fixed 1,000,000 iterations per worker. This causes
> two problems on high core count systems:
> 
> With many cores (e.g., 32), the massive contention on shared
> atomic variables causes the test to exceed the 10 second timeout.
> 
> Scale iterations inversely with core count to maintain roughly
> constant test duration regardless of system size
> 
> With 32 cores, iterations drop from 1,000,000 to 31,250 per worker,
> which keeps the test well within the timeout while still providing
> meaningful coverage.
> 
> Bugzilla ID: 952
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_atomic.c | 52 ++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 20 deletions(-)
> 
Tested-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Tested this on a system with 96 cores and test no longer times out or fails
for me.
