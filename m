Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CC0CD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 09:27:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56CFB4060A;
	Wed,  6 May 2026 11:27:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 02BB6402A7
 for <dev@dpdk.org>; Wed,  6 May 2026 11:27:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778059662; x=1809595662;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UTOG4gGjAMHMSMjlfe171w8frZnRbGD2p4CMqiaa5Bo=;
 b=lUdfO4U4U4F0BVK704dnbLW2ofTSABqM+RjDQLzT1kY32hNofqcmyKIS
 NfC7XevYhLlv01lZxVPtvMCMX2pT54IngvrWbdRdp6BVIjxtwbBjjlNpg
 ej8bpXCEAeUgPbd/ZaOvEJXAZhN/VpKPNyxEJq86lGdxI9ulT0W4P1H/6
 qfFlpzo5IFjQVaePd5rbgFCh3qTXyYY0E8AsQ8t6RsQnR5JraYg55Jm5N
 4BVjOakuPAmWwa1iKr1RkY2spqqXH7Hk8qxEPOYNPmvjcAhZouXlIJaLS
 FLpIhpD27rJMKQJDEdeuUKPVLYRX3sf5Bp8mWBisTMIUW8pVQW3cyWtM8 Q==;
X-CSE-ConnectionGUID: dEeaG6tsR5620kdu8IMmSQ==
X-CSE-MsgGUID: FORXvkAYQO2Hcx3mMWe24w==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90441748"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="90441748"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 02:27:41 -0700
X-CSE-ConnectionGUID: yQlhDd8pSLO9egZnC29NAQ==
X-CSE-MsgGUID: s68NxkrcSZanFzfMIPLlAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="236190300"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 02:27:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 02:27:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 02:27:40 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 02:27:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2ezaXxDA9IAEreYz4AkMxxMkQ+/svxw8hYB8E76tO/y6wQr1Gz8GL85bIA36BmTqNjwNp7Vm0YXByINVsWhXHQdjMKvHatFpx7Cg6wkG9h4Z7WgENQESb+RGWmuTScMf9ISofibKIQ7wbUM1rlx9UYQko2NXmu+tjSF/nH5KMv21wx3JsMRg6MznovzVNvkf5ObshbKm9i15yrzr0SYZ5hN9ttiExcsz8BSPbit+vNfeP23XM3t7GHjtbMemx/ZByII84RAiUT5H++gAbfjw2O/dWT8udUTCUQwWndQWuO0k42yO0XEPJX6wPhfpf4wjI7qb4aTye9j0vOXi0Y39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ny5e6ovahI9oUrbpuoDi9twCcNe/wN3K2Z9GzFT0OXc=;
 b=oQU1Ayui2Thdack014BJbbYdbQKmBKNtY577fBFEzswlB980pFlumUOkSO4jTQMPpSoEeQbBCfgoQZ/x2FBUBQgiOuEqfuJWsG5SxDnnfDSLU6TXJJ49eOHSyLOveRyqHvOpG+9esIrIjuUrV8tN2JiWKFqr17jSw/g7O/fc14PtntvU+r7NIc0w8GSQFEeNfp8GjKTCNiPush8W/iRgd1SQsEEm0MOq/X+hi0XCCdkehpVWqHiSA8Wn3PNK0uOgnwyUQpZa/qEw78cc/1h2XbD0UzuX0TmPx5QM6RNsolpcvrvNIt4EKsbMEoz7Bv0yi9yQmSIurBcpxI/fT4CiOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8533.namprd11.prod.outlook.com (2603:10b6:408:1e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 09:27:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 09:27:37 +0000
Date: Wed, 6 May 2026 10:27:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 00/15] IXGBE fixes and cleanups
Message-ID: <afsJhAV6DLiLnWWy@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1777547413.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1777547413.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0119.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: bc44b93a-4842-40e1-5b9d-08deab51b652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: FedY4Aoq0EuxDdUk9R7FnCP2GsVRYkIEZYxUs2RcedGOkOHflJxti9AfXPqRdLixryPzzVXR/EG6pGNgbvZ4/+uVZ6N5WPSuzKXMNg4sDB0e97pfzwWLRovMOgRd2NeA0SQz5Xj+ZZzJdy8sBJHldchhYaAT2hjMsxuaYB5TWvgLHHGkTF1KtayzDw20Gxp3QGNNLHxzQo6nQiZAHJklSI6NUopHWXgoxp4OWF6eVTIltm9kW/1YNHcSzZagoOQn0AC3xByg8FyCmR2eGTQX00T+jatkQAUE88L/r9Vs1WEwIoHQhvL6RGWnMVNN7SvA+/jZN4zwfMEUBC8Ef/hjbNi/MMhQ2OP/KDVT0IzCLHtLS+ttrQtdvRFE/TIuTBoHdJWTwaR1gzKmEjYiCA9gidfylmbhue1PmoJ5SIiodv70MLlkvCWyh6rZCk1/XbCJqHID2yI5IaRyZuxlT5JHe3Aj6F9jNyOY3wf4yb8OQ1KwdCtw1LFBm7wlfJ+6Ds7DxlII1qUY4Ps+dp1k3BYj0z3NFWYyouhaca7Vnx/fkM1ooAFU76n8hpSKUdIlAjB6YUXGdxidW7hcW6s2cjNPOxivGQZDrQzJy5X/HY9TFX1Tal01qx5u6wSmMsOEhqJ1yQzAgjoJlfxk6q0K1zWfsojrsY2uJgPwEgPTQ0eD2RIwf6yVXQBO/JV1Ng3NYbQc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g66LmkT0UALoTan8xhQh2BPLYwN1o88pk+Xb2QQ3gBT5Bqk15ntrvzNojN3U?=
 =?us-ascii?Q?qBx9Fe4n+KIQcg0qx0O6LSzejIAoCIspTpQBImx0VOw79QihcRdro0OxSYbK?=
 =?us-ascii?Q?BjemBVeJVEDlqCexpcu7VmNu+uDDT3p9U+ht4UzKYF/xZuUK6Nemwk8sdf94?=
 =?us-ascii?Q?AyEyyvq8rsWHPZyO6PBnxHlm9k84NXd/LBPpxepXUJ0GuLiJW5iMMW5JJs/u?=
 =?us-ascii?Q?p0KDlCqQhvETbh+gqSJ8tsFNRrTAlKtCmh2Zsdzfqf7X/C7ssQA9s5cG+/RP?=
 =?us-ascii?Q?GaBJeR5JHbnQmifKo/OGLly8lLcduMGqDkUUvyBNIAmNnx66o6UxwzX0mqtm?=
 =?us-ascii?Q?Seee9CmaIjpOweqka68THPK4UwOlSffzCV04rGeg3QsaNqGd50ok6hRdzvGK?=
 =?us-ascii?Q?hT91lky+65MXr3/UOPm5q6eKAzHswj0N4IAm1GUSPkxt0BWs8fe400q46hrB?=
 =?us-ascii?Q?KOT8UyGlMo/+hdyUNSGicUoG9SMzG2PYBUlgTgxTderl8PhFE++r580C1chY?=
 =?us-ascii?Q?BDgcOl3zpxLVYzAym8tri7H93I1xsm6U7pLqZINZJufhMrsfko2ckW3gCkrp?=
 =?us-ascii?Q?yxrIazOnscDLgXDIIuOCa1u/OtwEzGKwc3g0BH0AdPALHmWV5aDRafN67v2v?=
 =?us-ascii?Q?z+YsH1u4durk2ulnmPnjV+/WokTqV1wY9+ROcIglvy8KlpNnHk/qXZdu7KAb?=
 =?us-ascii?Q?/o6uqfsHxe9hNNkEmLCHv2iQVS2qCzzsn2M5TF4uVCKcpZ8hEvYn7OfMPYFL?=
 =?us-ascii?Q?xW0UyUJC3aoHkFs7x30ocMqSuGiu18uhJdNrN08Q4tFRMYDrXBQRO8twKQcp?=
 =?us-ascii?Q?KnXS51qvHenbuJbAcSn9CAiPgOAMXPoqIao7g5ut1d/pWmw5HFMripA2+IIw?=
 =?us-ascii?Q?g+C/DoBbVk8+GnHAFOjdLuokEnFzb0sTdnDL4yUPfru3hI5/eODRIsnvmeEd?=
 =?us-ascii?Q?JfSo/mgjaW7CfU6q8wWYqDcVDYF5BKid2BH4UpjwT/ziVEZW2jik4PeLWWVz?=
 =?us-ascii?Q?x0GXmPdtuLg5Q3PDxdCCnww+pJP/CX36ueM7v6L8H7tyTPIDPldWmyhJ6yhQ?=
 =?us-ascii?Q?xP34N2czI+XLHHQdxHNtOfhGgDuX8lvsw2OEZgHNC112IoZQW64KlURfCKeZ?=
 =?us-ascii?Q?UjqgPz1NBKEfmp2fMuRUhT4MVUowQXVkQmt3UiIrwhTRbOKJtnRKL+cHvvZX?=
 =?us-ascii?Q?LGzhST1Wh4/rQjSfBmtT+v3WBrr3jDaWN8DCa/WY+jw9e6HBfUTVPr7KRtYN?=
 =?us-ascii?Q?KOlrTA6uY+vVwUBstI6Bhi3OQwkc7x1jssQiOA88gaD6tBatEVgzaueHJfaJ?=
 =?us-ascii?Q?sK3S7LylFkngsY2I5Og2K3sgjz3cc5Oan3vM4o6fL2r6dTSWJQNzxWtrcGzE?=
 =?us-ascii?Q?uuSDxIZ10/S06rxT8J1tpu/q+uePARw1DvQWROkleybvYQ2mAnYQyXIHhG9d?=
 =?us-ascii?Q?3ajKmntTqw+71xMR3XZ9XEpSYUwsZMlLkHI+qQxcetiKwRxPTtjN1pB5FT08?=
 =?us-ascii?Q?/ff3fGCLtQUP+icIngonSLT5rEmJEfhOdXfl7IJNoijezkcQWKhXmVCpgRlv?=
 =?us-ascii?Q?ie/uscSg+Ak55qyPWuZ9+uhbNj+CCbPJ+eLilNMWyrBcJOyW2whVu0QASsGg?=
 =?us-ascii?Q?vLtxQx38Pee3L9YeeC3fBnHrWfjYiivJHkFHKsLRABa3wCGAkT9BVeVrEWSp?=
 =?us-ascii?Q?85vgdap93lf8myh0i0F2o/1hzxdxzcWcLOD5vgXSNXMzYZlhBnbstc/HVJMZ?=
 =?us-ascii?Q?9Rbu04524bsEtxypAJP2AvQ2WFOE0/g=3D?=
X-Exchange-RoutingPolicyChecked: YPlZOjbgpUBdZY92D6N6Aw2sDlNu+FamDVtnMoHDqtHASgxgJ8GKMMyOINu79TY8Udq9A/w/vKstfm+yKPpSozZMJp4pNa56xpReEa6Poq9JBcGASKg4hlJFZpfnmWeJzmP2VQPJiGGfTKM+7vLtlKJDwTcnBsuDMBes+lSGsFDTUy7LZ2O2vtIonr98/I+LbMlbt1Dc3XBhDXXOOOall9oxSULsFA/nT+J/VmBDffAapYJsh9UNk0eYzQCgBYDq8rQ4GIjKSiAFiNiE7BtfdJz0l41Gc627hjTchyFVFQp0Dlq1wmuPitkY1Ko+5g4JcFUGUEeSUsh/7ZXX0FE50Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: bc44b93a-4842-40e1-5b9d-08deab51b652
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 09:27:37.4879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWKQ9uM8EeUKT5TaUF04+mqvZjI47Bjgcf/yFiPsl2OQ+XWhgg79RTtBGOwC5AV3uo7CDfBZmkwi+9ALPcxpvED/zSwj/6tFpUu4u+r42yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8533
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

On Thu, Apr 30, 2026 at 12:14:29PM +0100, Anatoly Burakov wrote:
> This patchset fixes a bunch of very old issues in flow management
> in IXGBE driver, such as:
> 
> - storing process-local pointers in shared memory
> - incorrect L4 protocol matching for FDIR
> - wrong handling of SCTP flow items
> - reading stale FDIR state after flow destroy/flush
> - storing all flows in global lists
> 
> In addition, some cleanup is also performed - refactors, moving
> things around to avoid accessing process-local state, and
> writing read-only values at init instead of deep in FDIR.
> 
> Finally, FDIR was also rejecting protocol-only matches for TCP
> and UDP, these are now supported.
> 
> Depends on flow dump patchset: https://patches.dpdk.org/project/dpdk/list/?series=38016
> 
> Anatoly Burakov (15):
>   net/ixgbe: fix flows not being scoped to port
>   net/ixgbe: fix shared PF pointer in representor
>   net/ixgbe: fix non-shared data in IPsec session
>   net/ixgbe: fix SCTP protocol-only flow parsing
>   net/ixgbe: fix L4 protocol mask handling
>   net/ixgbe: reset flow state on clear paths
>   net/ixgbe: store max VFs in adapter
>   net/ixgbe: do not use flow list to count flows
>   net/ixgbe: remove redundant flow tracking lists
>   net/ixgbe: reduce FDIR conf macro usage
>   net/ixgbe: use adapter in flow-related calls
>   net/ixgbe: support protocol-only TCP and UDP rules
>   net/ixgbe: write drop queue at init
>   net/ixgbe: rely less on global flow state
>   net/ixgbe: refactor flow creation
> 
Some good cleanups, thanks.

Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>
