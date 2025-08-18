Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248FCCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 07:59:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39D6B40267;
	Mon, 18 Aug 2025 09:59:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id EEA164013F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 09:59:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755503994; x=1787039994;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PmhdRd4p96AUUfFpTuuIwyRA+h+CCFBxDTxZwsg/4NU=;
 b=VBUBMc148BrICzMslUk31eSjItGSpuXzXah6WXEI0EUDtsXbJoHvnZ6q
 2Ndk7pfp/ChXdVVef2zMdJa4WIdJwbZxgnJwLBUavLl+V7p8Qwwed599T
 G2W/E/bAy5WMbVjr6HLeIY/+eS1ghiLQEFG4JQ4DYYAyaduPlrZPhohu7
 QMEyWCxZxN+AeKRjuiApfQdmXmCgJfhqgC0pfwb9jJkrKO+Sk6uUJAIWz
 e6SFc2E/KBzo5dF+8Fu0SHq0sgtAZkAVblaHE5ujv3Rllt6XBYMXq2JO3
 g0YjjZymkZ3dsOV021lbdFEs2heD3z1sspvU+vdgZ8xnUUaJD+SNDtRxi Q==;
X-CSE-ConnectionGUID: zHueT9WhQFK5jwl7+fCUpw==
X-CSE-MsgGUID: me76A5BxQXyyjMjFvuYpbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="69092076"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="69092076"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 00:59:53 -0700
X-CSE-ConnectionGUID: UWkCH2jWQv+XRhWf2Kxj5Q==
X-CSE-MsgGUID: TJMeLlFLRvW0NKeLwnCQ6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="204677898"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 00:59:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 00:59:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 00:59:52 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.61)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 00:59:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZj9AORJ848+K2skkQwWnL8nRu81TJ+wJ7nYxMP6iuKuujdATHTczzbssae/EgNdRe+dyBYFMsPLipCeWwDQu6GgN8BCwHO/WTQXi2QgSWLAj5G0221Z3BBZH+kNq/8FNu9C87k7lJbUVy2SZ1UbrNnZCOvqSsmwX/XKe7Ha+ZabfXPleMeRLFFXLo2O0FPPB1SxVOwqxmXc3zC28XBCjniath6P2orTNJQYWFL3JfjcrzGIjykEuTBt0TrgyVAAVDjgJ0nuxo/8mfjS3tMuqPIaP3MzJO3hjnTVzw4r3Aj2Bb3XoMzXwaoAskTnhWhWyyMrKFCNhG8hez1+A+k9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMpasnE/3RiqAQdE9S28nrrFUBweTMgw/YPlL6q6QFU=;
 b=Xpo0qLBqaDxYA7fJRu4AFEbWh78QY0ApO3zvOq1Q0ahMzGtRhikXb1NzVMTezfduiqSepTIVZJzI8kbRomFZstefp4miZ4B4dtrjfOdCbxuRGGuwG8Nw6oQnd/GMEXQQiDnmZa4NFVJL4zL5rc0frAQrqQoOFyrBG1BNC84rTCvfP3+0lHhXt9J+sOKJhV3CdDOusGEBaM2hp1KK0y/t/a2nVpDLEa+GdZNGAn4LOaCYZsRCQFyHHdgDkoQqyiqtjz1GMbEeSgDBGUg55oMvRzsjK2lbB3alEMF3/LUTXeWHkNW+vqrsq+Bsbo0YPeLhRu/Qdgd/qwXxKQe0zc8fFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 07:59:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 07:59:48 +0000
Date: Mon, 18 Aug 2025 08:59:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Tyler
 Retzlaff" <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v2 1/6] eal: replace unnecessary comma operator
Message-ID: <aKLdbK0e9HXQZ8kY@bricha3-mobl1.ger.corp.intel.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
 <20250814212901.88863-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814212901.88863-2-stephen@networkplumber.org>
X-ClientProxiedBy: DB3PR06CA0012.eurprd06.prod.outlook.com (2603:10a6:8:1::25)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d73339-db1b-4995-6a89-08ddde2d342a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?djKEvXKsRpVabdbZ6m+C7SEvZj81wBiuZn0Q+JOknsKSliCpIkgRrtWJJEu0?=
 =?us-ascii?Q?ho4mMJia4IRMkYj/5Dn5OlkPgcbi8hxlIcvtigZZt+ZVB3pPrjlPEQGu55Xm?=
 =?us-ascii?Q?fcabA8jocIk27urYl308wuE/0y4xidrsTqxxTW0nSdBIQTgF6gsvVvSwiKX6?=
 =?us-ascii?Q?kOOpWkTMhG2xXC6iknphgUkrvgAE9w/r6oeT5188x+4+OZHLpP6AxQPbyy2s?=
 =?us-ascii?Q?V/kBwnvGMSHQ1WLga8nwNV6KRPpf9fawYLtTXEZYVMyZIYk3isDONvDsv+3C?=
 =?us-ascii?Q?wjx0Aa5X2MbcYA3YGfJCSm0RF+JOa17KZSLyqjlevcgS4MtWpAKzaB+snVNX?=
 =?us-ascii?Q?HqALC4KxMoNbD4IyDB27hbSi4NWIn7scn7h2al6fAYede3bxraEZsOranazt?=
 =?us-ascii?Q?4tyLHW05ODkuk5sFiKklK7nHqPtj1MKj5IjX4sAwiw69VWOpVJrEEZ5PKrPU?=
 =?us-ascii?Q?wk6BZOi7NfxjKSpMa3hMFgo4h8x4/tWnvZGED8dz7pkr7aC7nkBTlR6GzWNK?=
 =?us-ascii?Q?2lWqv/XdOpxCYPGODS1MwT60niQlavObii/xvK/VfS+Pcdr4aDwTS3dmL8Hs?=
 =?us-ascii?Q?wOj4W5yZcrmqYQIq1ffsaILGXnf/LJF2Q3EeaJoAg11f2UM18rWU+mDez/5y?=
 =?us-ascii?Q?RRnYVvZUIOcCcBAD90Oc/09Lvi9CHRHtav3XAf523q5u5Xe74yUeqF7A97DK?=
 =?us-ascii?Q?5rTyKhgfa0ZIz1cKuZuzXtMVS5TlYs/EE2fJFa+ALrZJ4xWbwRUaajuVAR+3?=
 =?us-ascii?Q?sY5oCioLANzcOt2LNdIqJxzfEmMqpFYgOVKdEfeGp3FBAXaO34VwH1OblH7R?=
 =?us-ascii?Q?ZHJvEpxtlcmwvAAFedK/2q8Lz1OXB7FEfXKDZ6uPRiykLWyruY4LifHaHb3q?=
 =?us-ascii?Q?CA0qT/kaamkbvkJnU0hmX2sx3tQcnCodKdUZcHzRs5+s4djHETyYRGiRRm4r?=
 =?us-ascii?Q?07LIKIXCYqvhLm9SridBHAVzXypYE7nXjej/ivjldpOmgWl2oVP2Q40cdXDk?=
 =?us-ascii?Q?Zt5bVs2mMeCgaS+dexCHlhXS07ma8+t8bZLvyJD4bQvhWE7acH9+bt5iZYqw?=
 =?us-ascii?Q?e0q4rBn7kpNMYdCmVKTDj2EOUPnZ4NyIXEEssVlZRYrxByte8kc6QCSZ5PHp?=
 =?us-ascii?Q?UMysiL8nuiJvHgBmLWKyWUcnO9rSOQoWp/bZ5GM15Ax3cX9vJmsOxovu8y7/?=
 =?us-ascii?Q?MelXuJ9mZrbfS+L7tFwGSehcUXYZE41uc2FX73e9UzaURc/cngYvOb2pQpXX?=
 =?us-ascii?Q?ex1MX8Jshq7Q/ACOi3sf5t5Q3k23Fo1Mvcd7Mxgk7q2VrMNEx9TUvFRv5mPP?=
 =?us-ascii?Q?FOyCXqLkh001CroDryBuGzAOLnIGMz0rSzFNZ/z1NjYkss4JY6PqT3IyypWZ?=
 =?us-ascii?Q?7RXOb0PAl4s/fdPhU5AV4/TdCMq+xiGYSq4LOJSX/IxJ5fzP6hBiFpkubp9k?=
 =?us-ascii?Q?LKohoHh1yKk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cl2VcM/iPFzffD1JQPEl5t5ZPuSnFoCqiHbEPrbl4Ebl2w7sxdBFKI9JT+IB?=
 =?us-ascii?Q?6gfY+ApfMgJ4513RQWB8t7KRPXBmDOsM/CjqsGmUPdAiN0ljNsOqFKTgB09g?=
 =?us-ascii?Q?cRteiTG2oiyyM3xOTPpTzl7N6BNSziZDUQzlbFIasOH1qBFZWBpmE30jdp7Q?=
 =?us-ascii?Q?073hICD+udbtderjQbbogN38Ra79KfPT04K5L1waz1ewfWqDRLwotGKEYPuK?=
 =?us-ascii?Q?aHduWrxWa9XP3uyT0qog8uAdWRv+j8v9GeTL5E58BicA4qQ6fRqjk053RUbe?=
 =?us-ascii?Q?/dIdKthxU41jOVa63CSqAnr4F87muZKlEMT2jWUfTCpNs9Qe+Y5TlEBwKGDa?=
 =?us-ascii?Q?iMMYT5PE6EnlBK2dY2RwTU7NVpHHFhwz3UO/jYA9BnCm+TUvlQRl4Dg16wTX?=
 =?us-ascii?Q?9vKe2rnylqE9hG/t/9lcdSt4y81w2hQHBEfAASsVo4Vl3OMg3qQuZzHOsj6i?=
 =?us-ascii?Q?IutG/PyjgUaF+U5fdATsnPolf4fWz+SMXk802km1uHMJffSuBlNvwnj/6fl3?=
 =?us-ascii?Q?zrCA9V1UY1eIShXRlArVgW+0pHEDqBaFBsrH7NypZLQbX/b+G23fVjgI2WxS?=
 =?us-ascii?Q?27coubQyESFoern+GivfrX/UCzGZOztvq/H57aCyQBFOuR1bWcrnFCiiQTOp?=
 =?us-ascii?Q?C/xxB0GINQXmukDREMiE3Yl+jzF8Whcx2eS2RNHmL5yjsIEjalP4gdMSZt8x?=
 =?us-ascii?Q?Msyf9QxdyU354c5srg2I5bpf7trWRYvnk+T67E5Q5+OsGaODva3b8w+oR8tD?=
 =?us-ascii?Q?tfdK50bKTKXME4rHQuy2Jn0wxIMRN/4jAvbC7UPXIqklT0v+tndyrB8woFc0?=
 =?us-ascii?Q?V1f5JCMwpFgb/rDAR6imbaNiRr5FFZV6qI/JpVM8EW6ZSmFi7rPDUDca4cDJ?=
 =?us-ascii?Q?i5HdWSnGX1yN/8CEyojfK73lJE56E2o7KQ0RVAy21l9Nr8yT37PUUKELS9Jl?=
 =?us-ascii?Q?8zrekQtGgdpcbaVdYJv4Eha6v2tZJ5tti6+PNhkfgTXzG4HUOClv5uOp0WmY?=
 =?us-ascii?Q?8TEh1lhF3DGCqdrfHBa1ANHWolwSyHpahumLb3g3s5dG2BI5fQiRLqPTNVXB?=
 =?us-ascii?Q?Ctu4ZYMIbiU4bOTXNqa+26rxVFqYG9MrPrysrbkk36e+0UT125+MWjfzvHXe?=
 =?us-ascii?Q?T6iTglu5tjWiuBIKaM4eCKIo58EthcUC9K9vAh2BOsAUOah0hRU6lMbpNMuj?=
 =?us-ascii?Q?X9aaUHcNAzHj9GrsjH4VEr/IhhE8E4iI5ehNIOdDY9+YfoCsw+p8azGrSqEU?=
 =?us-ascii?Q?j2+ZGhlAj/g+QjMyE2tXOWGpPGIiSMrB1N30s8B8ustCwkLqqGkr7P5kU+BG?=
 =?us-ascii?Q?AjfQC7pXpu5zRKW734p8rTrxZWkGwVZCIsRrxWapI5JrA8AerT87y2rZbp8i?=
 =?us-ascii?Q?DP6QnBMLYvBrC7YwXiMLRITOUTKRBIaifZ/SNd7pVv78fzSwtzTp6sZmYDsX?=
 =?us-ascii?Q?UdImESbC5whV8zMHnPx1r8tNXdsLv4shUL5hAyaVGzGXcDqjzUn9CqOqcTzt?=
 =?us-ascii?Q?rgKjrQxmFSE7o/GXUEZpJdezjoOzY/RqNi4kKtJ6shkDzSKibW7JewrQHA9K?=
 =?us-ascii?Q?j7znIGC/GNbL40EWvolgiwaE7oiF6guMJksWknuCK+ubnCy12LamG/J/6QhJ?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d73339-db1b-4995-6a89-08ddde2d342a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:59:48.8847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDAgAGnA0hfE0jr55v/EuSDdJP4J23jvSAlOS3WsIPzaRmTCdIk6cqMTHNGlT8iJURDtqpcp5Ay4CPZGQPXyW7QsdMUFMaT/c95rpMODLWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
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

On Thu, Aug 14, 2025 at 02:28:47PM -0700, Stephen Hemminger wrote:
> Use of comma as statement separator is discouraged and
> reported as warning by clang with -Wcomma
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/eal/common/rte_malloc.c | 4 ++--
>  lib/eal/linux/eal_alarm.c   | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
