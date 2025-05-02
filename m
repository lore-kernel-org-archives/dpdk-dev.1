Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED1EC3ABAA
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 16:00:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78BC6402F0;
	Fri,  2 May 2025 18:00:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 0C2F0402E6
 for <dev@dpdk.org>; Fri,  2 May 2025 18:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746201652; x=1777737652;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Q+auIofvJwQNTqxLEs9GDP4QsO72MH8nwuhLJ/jBBxQ=;
 b=MnVsHgk7RU6YyM3O6cxCpxbZSnuzGWKYLZ8w1bCYnQrXtlVX/XKoUolT
 xTVc8XMlysPVThb4YgUv98C57BVyWl62gflGjj3XfV15BSLy29kPANTNR
 A0azG01I9m2i7b2dPgPiCnOJ0bwb6mEazH98Gu7D/n/eS01rydSwIff0k
 dWC7TFbaDrr1k6BOqU83pcbCeTeFGHqhBWmpN+Z4KLJF6kZW3XqYSnQEs
 zq0OXWuNYIg0733z5ujMpDNsSt9otqofSLsnPpztAiC7pCNaSY4XYhwwf
 xzIoy7HBSn6yvkfLRyNwf6VreX9sylfhS7NO195ra6zjWuoMCLB6qSu5I g==;
X-CSE-ConnectionGUID: YGS9qZqfQCSEsS23TvkNBQ==
X-CSE-MsgGUID: Y8YcVUWnSg2fD3ZHY6U62A==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48029552"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="48029552"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 09:00:51 -0700
X-CSE-ConnectionGUID: 63PnNPF4TFysSjiWlpIb8g==
X-CSE-MsgGUID: blbYPIS7TpeWuFjXz4JaKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="139458939"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 09:00:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 2 May 2025 09:00:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 2 May 2025 09:00:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 2 May 2025 09:00:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1/5pOfklQDFPs180YPE3YRYHHZWIpGlzCLetf5G8QDVDawWUNj9CfgfdZvEHLvriLGCTLTPfQ+pit6rzWqm6KLyy5pw5XFRj47me0HIuxibE1IGQK5erD9UYSCvUNVVA0ZB68sftuXeVOMazTsBts6qHLA8cx+0d4iv+FOG/+sXabKFAPG4s/IBui2BGLlzZEVk00+z3lh635DfEo/U7AHxCZsIE8TO8B7Z/FKjppFxkdt1yVsTgISg6KT75XMPXAlv04+aPuW6ZCTwyHBclMPCGInP24OHJ9Pz2jZFidbxYIziTDJosHS3bCy1kxZwCsiMHgBRIT9ZppI4Kj0Fsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2sCL8Rj0vEMtpSHWvLgh4n8iAUnfRaWrYuPYqhigr0=;
 b=aZ/Di/CgPT5yELamrtt1f9G015ophE5T4nljqgSoj9k/1GPps7WU8xCG13wEpvHnyXfnYv9TqvB0755cBu6kPHkf+5IVLoMdjfkC8WMn0cD7wGj7e1jir2Z5wjb3Gin+jWq+lKghStIDfBZmySvRYr+5HBrdZQ43BHCJmbq3khQ6rKZBuaAlIdi0ne0OhX1h2sM0/YsnWlCE+Fdijpm1hUYnn3FKlbA0+PioPgyHqyWj/zEckBripD1mhjkONuenXCZls5jao9i+T8hgNtwJBZqzjfF963K/UVB9N6MvKFUb1ETK8GhRW+2DLAgP7qS+VtcDDk71LRppUMjR0bJ/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF10FBEE80C.namprd11.prod.outlook.com (2603:10b6:518:1::d09) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 16:00:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 16:00:47 +0000
Date: Fri, 2 May 2025 17:00:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>, <mb@smartsharesystems.com>
Subject: Re: [PATCH v3 1/4] eal: deprecate old coremask-based EAL parameters
Message-ID: <aBTsKvlL_Uw-G2wH@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250502151134.536799-1-bruce.richardson@intel.com>
 <20250502151134.536799-2-bruce.richardson@intel.com>
 <20250502085122.2e9db643@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250502085122.2e9db643@hermes.local>
X-ClientProxiedBy: DU2P250CA0015.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF10FBEE80C:EE_
X-MS-Office365-Filtering-Correlation-Id: c9866be7-1e8f-4749-f281-08dd89928061
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?djTo4gcZHNom2tr6q9v1tVlhs+qElVS8qxmncrsZfqxWQlDX8hzxMNGRo7v6?=
 =?us-ascii?Q?Axa/e05ggiGfyvrjQRh8R9YjDF8YzVUB0c75zJ8RChxVuXb2d3aqAfPmk6Dw?=
 =?us-ascii?Q?kxjRSZWSpr+1wmUNtDgOUVms1Kp6pLw+okDGn5J5ffVzijHYc63UjQAZ+dmm?=
 =?us-ascii?Q?x8O7VRHZv/1SM8sXvEq/buul53m/B3giRBJEujGPGQTy0fw3uOscxLrWoOTo?=
 =?us-ascii?Q?8uzUR4xqzIFmtDK+QiC2UPs5SY435caRbVOKm4XixEH7a4P9HWTzC7EfKhuy?=
 =?us-ascii?Q?/MnqewGFwRfP1HsR3Rj5DOs/MfMqhcbNT6pHMSxl29OZwoAQ4cl4gfpe/LYM?=
 =?us-ascii?Q?sKeIQn4TL8UHXE19h79Sz43jaIyw3UUdqN8u1N4iuf5LDarWlSHHpSG1XM8/?=
 =?us-ascii?Q?W6uxUjNZ5bep3k64VteENfNZ1VfHy9yeb5Vc+7L3JAwlhqFOsP+8gRMXlz7r?=
 =?us-ascii?Q?m0sOLXLx36D6Rk3wtE8gMKg900Nxrg2klfbhDWKdau/DCyjM1Ww4gUt5EBB5?=
 =?us-ascii?Q?uFSvr26y3N2vaTtcHtErdRLYJVK2F8D0EUN6e3fcxgWa0YHQ7RnuKs0Vo8ao?=
 =?us-ascii?Q?H4wn1Qy6InsEeYZBQCYHHulW6hJgRNdzOF0FNhzBRyeyPQBfBsdSomSwYSSK?=
 =?us-ascii?Q?DTmPe3UMTW9YXL4vh5d6u47TQtYxX+oeQyQOLGcCgA2bYYicFAQTMKV8ziav?=
 =?us-ascii?Q?SgWpatl2jVYuoVcOHLLu6ORnC4DCIG/hHmJrxAOFc5TnMNvjsZLLF7q2IdoM?=
 =?us-ascii?Q?BRb8lo/5sWjnNkmjOm0KWE9V8EosRMdOVKrixlTYgr9D9mo8bxSV06g8PRAs?=
 =?us-ascii?Q?dEb3apG62efmpNsEPwM0m7b5e3qmXp1zuvQ20biEZG1S3foVj7yPe7bo+lEq?=
 =?us-ascii?Q?GrR04gq9Ox1sZPCo5HYYJHJghj/q0u84leQ7QFWDvznG4QSjkVExD7XaQN3O?=
 =?us-ascii?Q?XZs3E9tYxgj6G5brX8AenAHhrHp1xi5vsDXJU6AoVvf6hl8h+p3WSz6/k1BL?=
 =?us-ascii?Q?qulqCNa6Im1tFnZAQiGWmR1bsy0/dQXsWt26EQux3+wC67fOGFz1p6WiJtRK?=
 =?us-ascii?Q?6/6/1VGbyq1u+0CEakj5wFl9tERHgts4TrpIYUxbr+meQmd880+bTCKRqZfj?=
 =?us-ascii?Q?KKS60Qc7/GAT3OVbhH8BGr8Z7aARJ+eJ7T1zNARp9vI8kJNSVI308j4sBgyu?=
 =?us-ascii?Q?v8LuBSF1vWQOY7SfVxs3YTrP+5c6Jq0h9B9uTQXqMHX8LsR0Wr6Y1pYCI2Vn?=
 =?us-ascii?Q?Wm7/e1K/W8Zs9k1szip60m0I3I0oGUUsTFG46OPUVuiIog9t/LRcaIBPDMgy?=
 =?us-ascii?Q?Uy+qzj/p3VEaqCsjOcOK6FdbItjq0TgejzgWK0dYwUGTy8y86/g+yNbXu/Uz?=
 =?us-ascii?Q?o+CKoJg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vhmI19mir1dqKI2CKR/jPmMDIhsDfqP9W+k47u5MthpoPZmGI9b5PcpLR3Q+?=
 =?us-ascii?Q?8kUly9ZxzrvZyBm2NCYl61CH6qMQi5ee0uMT/WkRZtPagIIBWNuVpX5Hg9P8?=
 =?us-ascii?Q?E5NDOJNPDixSbKY5K+f3x2LZThakDuonVsMKk+V/kks9zWMihHq/5x5WuKKC?=
 =?us-ascii?Q?nWTr2JlmB4WdQbWxXluk+t60RJmYUnajITsxog/uotKRXY0FYcGWeKEAWTgI?=
 =?us-ascii?Q?vYHjcJRMqcMG9Kcwwu7rtw1Qqqyrt8sTurUTE6UExGyTLWWQ3XyT5+jnSz3t?=
 =?us-ascii?Q?95OqgHow01OCBnBMVlMWEA8mxr/m3gwa/qZIFEj3lzNNEK2VKzEjs9XepTHF?=
 =?us-ascii?Q?VA2lWYv7f02tP/2ZiRchg9vcWqCHvYBmLnG0Pp3GKgfeXFIBk/ehx3YJCIit?=
 =?us-ascii?Q?moP1c/TlqINauLQ6Ml61bx96zilG7/HMFZVjG4XMqGwddBKA9Ww55IGF82QE?=
 =?us-ascii?Q?kXxDawDI1w3tZndx+D9HMU10niVk2ItmPVnstrQfKqlwQ4s0OGTJjO9UI/o7?=
 =?us-ascii?Q?0kJoqi0KWLP5J3Y29+GW1WGmlp5mlUEXbuz5pKmYp27kXdZIWC3cisY0+mkf?=
 =?us-ascii?Q?gKjrU3IxuSB8YkQwMn3aNAE8jn1MQOei0CaU4N6jgtsHP3CKVO+yvR6bK0iM?=
 =?us-ascii?Q?YYYGiZd4TQDz2uZa3DkYrpiQytwKXb/kaLJB/wT9vl0eCKJln2PjCnqWJdrG?=
 =?us-ascii?Q?tGI/ebPj34x6Rfsqm2fNf3kzagjjPr9TzdMxwsHDE62J3fEuKTqISXvvi1/D?=
 =?us-ascii?Q?wi+7qXEadu64br/pqf9WnEM0LX46tnscmwxDtlo2g7D5sTzMU1c/xZoAyf1b?=
 =?us-ascii?Q?Ch3UsaAj6Ck+dmCdVthcL3szJWl1sKjKjpG+DtWZka7hfPyQqVanO7GAUn5a?=
 =?us-ascii?Q?UIRmEl6zJ1mEK8pmhZEOaURapy1aIklyx0XCLP96pqBTBpY+IvKCyppiJmxv?=
 =?us-ascii?Q?z0oIBoFGzXwzIV1gtsVlOA/TZ7/Q2tHl9lY28DT9Ofg31BDK4WmzkJFmhlqU?=
 =?us-ascii?Q?Sc8GiMBKHz0bzI6NIiHw7h2mCi2zSxgSjcnovsNAYdgjHKRRiv+btC/vU0jm?=
 =?us-ascii?Q?rYH992ApQdnu+7uO6luI9Pd7E/lHMeFCdVIiwtgJvKyN8M7n0Tn+LtgDe+o4?=
 =?us-ascii?Q?p12/iI7OIv8AmBrtFFgbm00hY73ujtxNMRtUxUvpCX2DMyJWje/1KulmsDcW?=
 =?us-ascii?Q?PfpkXVlIJ6TNntLyQZfjmJbxP0Oox5C/qnpM7xRNhfKHP5WQvngnU0fpllOs?=
 =?us-ascii?Q?wwQ5xx5WEsfkBnebCGoE4HR48KbiytcFg4MTd6+YIY4c3a7QBXSiy0Wop0gt?=
 =?us-ascii?Q?cBTgIkIRTaJh0nc2DkojW2O7S4UoWYX5ibBvhAHezpehF/CBJCm5yqx0DWmk?=
 =?us-ascii?Q?v/9kK1O/fmYug3EZx+gnJ9X6bkYxId1+4p2hdDjSYwQ+pomyQcRBGO9w63TU?=
 =?us-ascii?Q?H9zZeeCD/XAidlz4qE4UgkVAICxW7VDjQlFl1FTox3sPbrZdu6Km/kc4uEDh?=
 =?us-ascii?Q?VyzAw2OcPcHH5HUVBFPIg0FrrTAooxsdynWrSBFVluE5+G5fQccwFnYPZc3t?=
 =?us-ascii?Q?pYRTGbxTosamn3iLZdhaqN8tXFxeURJ8U209/vgxm7nNEl0+JBpHhMtXTfuW?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9866be7-1e8f-4749-f281-08dd89928061
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 16:00:47.0386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dj6KnGTSL3Zgf/5qrnctZMDZ/ejwGGiL1CwYqMFeukuirIwNu+sCdipVZhEKa70gBR4FF+L5J78GOlxYrZuaCt8h8lDixUiY73I2M1hcr6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF10FBEE80C
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

On Fri, May 02, 2025 at 08:51:22AM -0700, Stephen Hemminger wrote:
> On Fri,  2 May 2025 16:11:31 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > As the number of cores/cpus on platforms has increased over the years,
> > the use of coremasks rather than core-lists for identifying DPDK cores
> > has become more and more unwieldy. At this point, let's deprecate the
> > coremask-based EAL parameters for future removal, and point users to the
> > core-list based versions instead.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Agree.
> 
> There are some more syntax options on Linux kernel command line:
> https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/kernel-parameters.rst#cpu-lists
> 
> cpu lists
> Some kernel parameters take a list of CPUs as a value, e.g. isolcpus, nohz_full, irqaffinity, rcu_nocbs. The format of this list is:
> 
> <cpu number>,...,<cpu number>
> or
> 
> <cpu number>-<cpu number> (must be a positive range in ascending order)
> or a mixture
> 
> <cpu number>,...,<cpu number>-<cpu number>
>

This we already support.
 
> Note that for the special case of a range one can split the range into equal sized groups and for each group use some amount from the beginning of that group:
> 
> <cpu number>-<cpu number>:<used size>/<group size>
> For example one can add to the command line following parameter:
> 
> isolcpus=1,2,10-20,100-2000:2/25
> where the final item represents CPUs 100,101,125,126,150,151,...
> 
> The value "N" can be used to represent the numerically last CPU on the system, i.e "foo_cpus=16-N" would be equivalent to "16-31" on a 32 core system.
> 
> Keep in mind that "N" is dynamic, so if system changes cause the bitmap width to change, such as less cores in the CPU list, then N and any ranges using N will also change. Use the same on a small 4 core system, and "16-N" becomes "16-3" and now the same boot input will be flagged as invalid (start > end).
> 
> The special case-tolerant group name "all" has a meaning of selecting all CPUs, so that "nohz_full=all" is the equivalent of "nohz_full=0-N".
> 
> The semantics of "N" and "all" is supported on a level of bitmaps and holds for all users of bitmap_parselist().
> 

Those would be good/interesting extensions to have, if someone wants to add
them to EAL. Hopefully after this patchset, adding them should be easier as
I think we should only have one place in EAL where we parse groups like that:
"eal_parse_set()" function.

/Bruce
