Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A6FFF8855
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 14:07:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 312284027F;
	Tue,  5 May 2026 16:07:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6EF1C4026C
 for <dev@dpdk.org>; Tue,  5 May 2026 16:07:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777990030; x=1809526030;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VBUsvbTa3bx4ZPghBAqszs/TvVq7d7apfdo19vB2SYU=;
 b=XzFIswoNfGA7gqpHQVGn6moU/xF0mF7YiSD7YxW1OL8Siq7hJZqwqgDx
 vFNI4bL4uowUdx6TzQT0wXFxvbOrZBTfQ5lzeKJF2J/2boanXwwfRhvuV
 RnsmU0S7n1JaPHy7aSwkongOKjj/Tr0/jRdJImWAVJ3V/psTMjTZ1vRZk
 FweRnJdHgTond+n8PMP9Skhx7BMWzQUd18FyuTDLc2j8XrVux1i054KW0
 lbXB0VTY5ehvvjtq/Dz4W4rfYzvyJPkkseUNRDUB4TWCrY6W7eIc1BM8z
 078twijJBe/MwYyo+eF8FGBcnAMRDkS2Qhi17V0v8nBE7t6znWMDv8f9e w==;
X-CSE-ConnectionGUID: NwofpkeURKGVc6ygsngmNg==
X-CSE-MsgGUID: 9vWhFuQdQl2g+k+U4aor9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78797295"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="78797295"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 07:07:09 -0700
X-CSE-ConnectionGUID: +VW92hVjTXS44c3vQJ6W5A==
X-CSE-MsgGUID: 5hhbRvHzTdqCCt9iv6T69Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="259168862"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 07:07:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 07:07:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 07:07:07 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 07:07:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIYKqmB7NyXcA4Sc30xhj8WQa4TuPQkqqsMcpucOpswxV+sLVkwj//he835VDAmCnq/lmLXXO2UbbJkZIqf7dDaGzLL1h3cy3OYq1m9N1OHI/3kESaiIqBy4jQ+NB5geufdhZMM4y8QAmu3xh5t9sGrBS5uzuM0jW53FMA1HMLfgJXfQM5ztITrQFRkyM86ubmnIV8sYdfDQL2onfaOfJ4QNRJ2Lw46H0cycy6Hqm7GZV5e4GbFvtkhhywJbTtIYbz0mtHVStCvUGXi7HCC3O3QnLdDIMDrvBCE7tZIqyafAwvCkN+vIV7mX1Gf611Lly+gYRb8SpOLq2mfFfauQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcGAWhBvARiSxSsHYSSKanJ5FBMtUNDrwb2FCRF9x9M=;
 b=e7cKhS8VLIUz5Y+kzyGQQuvehAEx7sOxKudqhwihnL8o0nw5/YIfTLH87vAVqC7TKqjXvpJ9sL1CxUKMCknKginx53Ek7a/ru7XaNNK4supQKQK7JRurwOzQFpupsOpEieRuSOwpz4vXWLgHHzqecDvX5GZ1Npnf+URUWP188JBsGa6j+x5FrX/rKgVef1bMTRZ8oxgtpEhZZe7kcDClc5zXfNHNP6b9mjuC/FKcuPUP4C6Xu8vkH4KrKOGdPEl2epCuJs542gHem+1mfd8eFIu1z26Ic0McpcugldvlyfkZuAyVpwg0oMm3PLt0Ob+z3B3mtETyw44B7nnBruNfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7403.namprd11.prod.outlook.com (2603:10b6:208:431::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 14:07:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 14:07:00 +0000
Date: Tue, 5 May 2026 15:06:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jay Wang <jay.wang2@arm.com>
CC: <dev@dpdk.org>, <nd@arm.com>
Subject: Re: [PATCH v3 0/3] net/iavf: add NEON support for Rx/Tx paths
Message-ID: <afn5fokfUGm86iHU@bricha3-mobl1.ger.corp.intel.com>
References: <20260420103042.2836732-1-jay.wang2@arm.com>
 <20260505110745.206312-1-jay.wang2@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260505110745.206312-1-jay.wang2@arm.com>
X-ClientProxiedBy: DU7PR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c9a4e9-7baa-4f87-3365-08deaaaf9320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Ax1pbMqAT5RBR6rlh3WUvWyoa9pK6eP/lO0yUnXJQCgASsULohZIfSG3f8ngRIPM3ZHUnZgb4OKJB8giuz/MoCswsf9I7rwDio5kAt8PQrtV3gpMy/LYdoYjA8sw50nCVxBv8LxF/TE1RJ/HqCRriYNsih7UBYYtv4wsKKs+ImlkNsG6pbddNJ0XPGXijRT2ATGb9gQOc9mgeFj+qJQIg7ycfaUobhrb6tLSGOl5thU4XJpc22zZx+9RHfyaLGh2bKgCYVEY3mKNDWgKoACYVixp+mE1Y4UOaS/Jycc6tHa4ytjSqX6OET7A6jCSKBwE/eAz/9bPlcyvg3hoVvHgNC7M4i04CfKAD0z1KlaecyJg/V/tubtMHvh5BWk6JZ6lxO8ohiP7xAPdv4kTDCI7A2htGB3rbHcsyLzmOLQd3IIdOkOWdh4z3cFL3ro1Ag8kL/l4dSgwD3DyUFAYlyqILZHnBM+mvr2ODz4YjVJ9DXtZwNF8HELMJc+1MsSABkMlzPLRNuoslILhqVDT+aU7sqLSsqtwkiYX1XU6uxORIc/P/16mNeKbreNjTCYPwIvDVynl50wzLeVJJYmWJBvG3mCxIosoitnZGqqIk6mjofncelXyllmbrwqSGrpWbQWX7NUQgYtyhPDFRmiNcz8xP0mOSkg5RgeQzSO6ElrnbqONmI6xgfN3R+2MK3mI6QIb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fg2BxHKQePZzX9GvcYot901q7DSI/Gz0p6LKUbu7+9hzxOeRnpytKlFVtDOo?=
 =?us-ascii?Q?d9PIaiCKNs1rPQCkYIv//T9S651qERhJhci8xh2AsqlhIRNc/4WoyvXoXctH?=
 =?us-ascii?Q?atHBA5UGKmuYB0Et3BSeI4B7XV/sN3nGLrUtykQPDsbiIJVR8zWvD3ewH0aJ?=
 =?us-ascii?Q?UTDCWwNt9ivpiYLCMJR2/e8x3VnJYVMAazOeyZgxPZWELq6WAyUpLp4GbN1h?=
 =?us-ascii?Q?vBeSbKrmzebxrhWHOGqKzFDiz+q2ze0vHC/5X51GHZI/V9DQoac+CEWtL7no?=
 =?us-ascii?Q?tbxADD4LqkoiuZNbwMz1Ol3dvM3Ub2oU6hsKC2dnmKFG4vs8OyiEVyjS0CjF?=
 =?us-ascii?Q?k9IYm1YYnigWv6rGIgO9h18y+CQYhixiPc2THVv3I3m8HQNdKUE4hWHzBPgz?=
 =?us-ascii?Q?damSRUxZgNlwKh+pgciJwyc46RkjEfebEeuPUTN6hiwUu5rBIbZ74NHGcjNK?=
 =?us-ascii?Q?xQQlNcXyqC0Rf/2fJpvECcUvryZs0QeX8mLewvw3EUt822czJi7tpuprsd6f?=
 =?us-ascii?Q?aVJkjwaNXjdYy514RdlNIP1mVBZO5LOI0ep1+dKdI7U2GsKWzJvT9f1N+qi2?=
 =?us-ascii?Q?ZZeYSkDwO+64lEEFjMFB8IgyFXItgnxG2wS/ZFt/jvzieq8ku0OhWPSiEXrp?=
 =?us-ascii?Q?MSTNVHXRLT+gMy8TilBabggZcKWy+tshMpXwSwrq16WWbdIY9VUdJmmkYQSL?=
 =?us-ascii?Q?Brqr76gVcyhi2r77rfEEkAodB340urD6ccCTo+700WFOVELFByDDkmaMpF+G?=
 =?us-ascii?Q?d1q/mTEtmFtne1jR1dBPPSMYH9ZUZkAnYAWAQFVXJf5MrS6oXWQv+M+tE9yL?=
 =?us-ascii?Q?g3vms5NZYGtK3Q4TLDv+FktNzRWqnQZjCWYTzcRhwZVXBO4mJWLn7xfY0yhV?=
 =?us-ascii?Q?hWQD3fKe6NpeiokVocVy2PiQz5+cvBh37Lgfr8kGtg9JQUu/T93XjEI8FvF9?=
 =?us-ascii?Q?v6nrLKRm+BHUBdFCneM3DJc5z2QLM+pBFKnNbVURduZyGanlq2TBG7N5Td9K?=
 =?us-ascii?Q?oepUNn3BXYFIXJQ9aLEy7S8C4HQcoNHbXsE6FsnNPbgnSlQDa0TO2lRFTwRQ?=
 =?us-ascii?Q?V6zTo2PKUJalh0vbClLjS4JtYqiN7JPWcZxedGMFaSt7AIeZVyNT/ZC/RJzF?=
 =?us-ascii?Q?VsvpNZYgGHByPkYgr75HAx4DzWau+OxA+PSZCBWtdBZMTUgx1i0oiuFykyp7?=
 =?us-ascii?Q?n7fFa6b0aOVhogHXVAWccxQatXaYvqsdZBuWmAi7dJpbERii8bFczstWcATw?=
 =?us-ascii?Q?AzDkf7ga8i5u6SbRms3l5BXB8r20Vgz7AmpwLxj2vv9VzWuYC5QrRE84Lc7o?=
 =?us-ascii?Q?/oMK4JgSrVLpCLk28XLWvdhKXV4dAVdsqwT1Iz8/EM9HpwJaQyWKNwo1r4Zs?=
 =?us-ascii?Q?9qfb7PT9hpThWp60OF+xDT3SGjrF+7d8glplFT4kpYJ7tycgiZGeT2F15sjC?=
 =?us-ascii?Q?3qWLgKlwzI8bwoefQxODy6hG3U4YDC9nD7Re1JTVgJMCLSd+fM4Vi5u6GYOo?=
 =?us-ascii?Q?XLRLsouQ9eddRT8lWRE26+stmmfgDB8MCT75WGGIjIdgTIYRRrvGeXFwG97S?=
 =?us-ascii?Q?VrEJFUrtGycXTvZIzErKZdmRANo+2PtaUVIzHqLD1UeF/KCWtvxDQuDqIGtC?=
 =?us-ascii?Q?LoejkAO8oG5zt07t5Ms2R1cRb2soAxgdPwVM/nPOSOnr8SZ8bW9ldulrTtQC?=
 =?us-ascii?Q?ge42710ZV4ON6TxxudhAbJFUHx4vIqm+quZBRPnihDOnebYjpqYWAC98/emI?=
 =?us-ascii?Q?YOPqUa4lNIPb23Z7ltprcmFBrAhtpmo=3D?=
X-Exchange-RoutingPolicyChecked: u9PciEMAh00sdqnehIp+maqFmsL2FPjMVmNgLI3pIu2fv4B9ycP8obD+3hxSyqaPELHfi6G1uDw+cWp6rYgpoqw2LTuNQbsWweC8aGVgWFwYhU6pDGp4R1aD9Gx0R5Cpg+J1ojY7FHgzq5/rmPAPJOudVRqJrBBKfhTnRQh2YanujMG7Gwj1GIgucRwI2JYCmDBuEY3TsPsU8NhIsvZdvcs9OnAoQ5iDVqv7ebKS6hNj3az6HzP1LhPrpFwQTXgySmxusJRoSvp+zbfeDcXjm6PdzZGXfPgScvSj/JDPswdmeyuZmsOvI/YMsqCM4O14IY20Tiz71tcb3JnoxdmQgg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c9a4e9-7baa-4f87-3365-08deaaaf9320
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 14:06:59.9545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RH+O+jsJwXVPLgFoKhZ1PAZRbNzJ7XSenw+NmEdHnXyeu0rsxcyvPRTmsKUAh5wmTO5lb8v7fWqDmWcwNC4/oXPfV4TaExYlC6GPcxQZ9jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7403
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

On Tue, May 05, 2026 at 11:07:41AM +0000, Jay Wang wrote:
> - Add the scattered Rx burst function for 32B legacy descriptor
> - Add the NEON-optimised Tx burst function
> - Add the NEON-optimised Rx burst functions for flexible descriptor
> 
> Single-core benchmark result on a Grace server with an Intel E810:
> 
> | buffer sz (B) | prev (MPPS) | optimised (MPPS) | uplift |
> | ------------- | ----------- | ---------------- | ------ |
> | 64            | 62.241      | 86.010           | 38.2%  |
> | 128           | 60.813      | 81.453           | 33.9%  |
> | 256           | 23.730      | 24.633           | 3.8%   |
> | 512           | 10.268      | 10.380           | 1.1%   |
> | 1024          | 4.588       | 4.628            | 0.9%   |
> | 1518          | 4.601       | 4.669            | 1.5%   |
> 
> 
Series applied to dpdk-next-net-intel

Thanks,
/Bruce
