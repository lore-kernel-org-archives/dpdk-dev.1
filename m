Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999D9CFA768
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 17:02:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7B1A4026F;
	Fri, 21 Nov 2025 18:02:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id AC6B240267
 for <dev@dpdk.org>; Fri, 21 Nov 2025 18:02:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763744548; x=1795280548;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=6mHoEY/J18jXPGhDJu0OHgxIDIFO3EXo/4oTO7Gzj1E=;
 b=QVdMZ2t8H/rbcTPzMJBbc3kzCPasM4UOpIKeFKC6SFzVlfVy8SW8UMIr
 EF9atSgpzG/dMEFEiaFTWCm2MO3ATIb58wxVu8SG1542socBevVgQVWHj
 RkWvtbGcUWk62RpVzOJq2ckbJefUx6aayW+esVX88Fl/7DOOR+cD/2v2W
 TASWkj9p/b9pZ+WAj5o9d6Cz2z7IKHtF6VfR+7e6ZJZLRYSVueLu907iq
 VX3KxDY4lEbk51gkTav60bPESVbVmnW2HjErUdln7spd9YxK4qJB2xNoy
 QUZFlza+Rvjj/UmN3wZ5PkxxA3nN0j4McX5iOb3BerE2fXNZHhl+ghQsj w==;
X-CSE-ConnectionGUID: YZAkm8R1SPSMdjC/fGHbYQ==
X-CSE-MsgGUID: zdBqJnZmSkqhh87DsU/wvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="83463678"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; d="scan'208";a="83463678"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 09:02:27 -0800
X-CSE-ConnectionGUID: /NGf+vxmSR+1sxMO7bJtxw==
X-CSE-MsgGUID: XYK5NmUBTXGNDQOpkSvZSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; d="scan'208";a="191519063"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 09:02:27 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 09:02:25 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 21 Nov 2025 09:02:25 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 09:02:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7ca1UJNHXdmyobZQwzolI4qOrpIBFjQQ2P8+VIVf7V8fhppmvOaznBs4+92U6rdYJzQkZr1Cac377PMM4+f5XShbC3QzWP77G6SKw2lEMRloXnCldL55d7qJlM1pZ2mQzELcPuqZJ/sFKUo4jW6bPhjsFwKW2EV82ldFsAo/NzdnuOVeo+7nraMbQ3kv9QHh3wx+gJ+pNuhdIBbx4DYd0n5wXF9A+wxV6KLIrZP2bAsp1Vw9Vv/wOals0E53m9Qv9qwY4jdXK+IeUG9Nai6LxBrTCfti1rRaUpHukMSHFKcxz3I8KYYxBMkWbFW8WGO7dLb4s4xh8pmtO4OuWlyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgFx7nJF2/ApYBY4I9++1a9bCsESytPRkAuYSUe26FY=;
 b=bLR903M+AWp3yJaZwyJByj/8su6sYx4tuNnf+FYdCok0D+PlKwgxbM35epe4F+sifIS+jn8y6efLls4y1L6zdunzk1+WSvEfsqxdu+5qGhmug7lQgviJOaoTy4VCU0AdjVdeAU5p0+MwdeZSC1VCujVv4XxNGyVrPLq2jbndGhOghefznehQy/V1IkJiOpfvYgmAYvyPcEzW3jjp22KbcQudFi1cGtLka+rv5u+RtWofvQQNX8cdFdJ8ADTMl2c5zWm9zK3ghtqiRTA7fvLb2hh8xRwEyusvPEluKCTqaHrSeNKSsb6sQWEhRcld5KX39guHgCIBx3v4pf5YR4q4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6314.namprd11.prod.outlook.com (2603:10b6:208:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 17:02:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 17:02:23 +0000
Date: Fri, 21 Nov 2025 17:02:17 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, "Vipin
 Varghese" <vipin.varghese@amd.com>
Subject: Re: [PATCH v2] eal/x86: optimize memcpy of small sizes
Message-ID: <aSCbGWNQ7dr7EE7A@bricha3-mobl1.ger.corp.intel.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251121103535.1273457-1-mb@smartsharesystems.com>
 <20251121085730.51f0466a@phoenix.local>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251121085730.51f0466a@phoenix.local>
X-ClientProxiedBy: LO6P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0ac1f0-ac41-4a21-48a6-08de291fbd55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?mCm/tnL9HqQY9LQV1l0ni1nmMn6ws51rEuj9OXrBEK/nDK+6msfeh7AgNM?=
 =?iso-8859-1?Q?zE+GLvfS2ZtCixT5Z9Rhwcf2Vh0cuKfI6BLXI0ritbMUqtF2m8S4vjL4Jj?=
 =?iso-8859-1?Q?xVkn1tdpDQVaELor6/kT9omGGpdjNIAD/JVI6I3rOe8rOxZrGoKuWJG1wS?=
 =?iso-8859-1?Q?7le96ri9k631NoeU2x5gHpEPeo6BK5erkvObJPSP+ww9dvr0JSUNzCzsBI?=
 =?iso-8859-1?Q?MEI5su6x+YvC1s5PRqTDQjpZuDjTT+C6z9NUgLULtvndu7tKYPmrtVXw1r?=
 =?iso-8859-1?Q?VcjPBXQAnodo/sumuGqu3sBgdPegHP01LBsjtdvc/3ILQ8GFydNkYvO9C5?=
 =?iso-8859-1?Q?6yijEBPerobrYUBU3rtpuIxN1JDTPhiBFchKon9GpT7aLnXi84n18Vpgfj?=
 =?iso-8859-1?Q?fBc3Au1EtSAwlWSeS7qaPjNjHsAvTU3F1MUl6On05sNWug8tXpN3YrHU86?=
 =?iso-8859-1?Q?jHyAH5oAeU82yMWEUsd+Dqp0Bb2ffqCW/7NnIgI0jehLiilTiCb37dJCG6?=
 =?iso-8859-1?Q?cKw2cTyHOoMN832+xNwAmgZW5jiMvvhfQwhSYqZmy16nRC7xUlRk/quZA/?=
 =?iso-8859-1?Q?IcRvmhKerCezI/rocT8ykz1x9teYMZjp7SJgsmBp7wGKmXYuiNt4a5cLO3?=
 =?iso-8859-1?Q?958ulfpTvEtcnMYjVNTKHIPo0qd80uPOg05l1jtcrqDJieNyQCnM3zOjAa?=
 =?iso-8859-1?Q?/YqbmBg2jkBP4d99R/vZnwhsjIn5OuvPYYmB3vCo/ESlbB22cbV9PskYdG?=
 =?iso-8859-1?Q?XVkti9vcYj0kUHUg/hbNGEw6W/sPwa1BHhZQVm2LqSfQJBgxxY/T7IZsjC?=
 =?iso-8859-1?Q?gmPOhp8SBwS+bbhwZAIowHVnqF5Ot3MCBn6Z5r/2ixlNOxNFKwBXTvfEkl?=
 =?iso-8859-1?Q?+IO+sgyi/zxE92iV5IBdmvK+9/PpzlKfDhh4ZmRD/YCsQU3SqCbPtMGFoq?=
 =?iso-8859-1?Q?U8GHU90wFd8SnHWihI1aSOyAX19/hFvSIuSC5+J95PV/h9ZWQW0fXGPwGV?=
 =?iso-8859-1?Q?UR4ahLAhO5DS0rf3PhTxZhGEZTKKpKIvv3R6jZLT8+vQV7S90p50C3uQUZ?=
 =?iso-8859-1?Q?bWmqqThNifXLfX3DD3ECSw4I2xP2w0s6D2RwBjRYYopNzSUSeu+XFwJu5+?=
 =?iso-8859-1?Q?gyM0rEszAavxDOpwiNusTRo5Jmui2E7rLDMgNTQclo5sLZBpkgWl+R7AIC?=
 =?iso-8859-1?Q?wfYxE+m+TlUuvA1YNgYoWAlM/lftmguzasH34wv5MzHiRwwFMRKC/HTQMM?=
 =?iso-8859-1?Q?rU8g4HTo984yc9ZaGN3HigeHX23YqtMqiH1FqEfr/gHqzY+iG4SNdo2arj?=
 =?iso-8859-1?Q?f7puQMz/6GPgM3foVySOqR2dNKzhtWql0xXVVWoHthPkSiyjKuzdpuhtFv?=
 =?iso-8859-1?Q?pfQn3oN94Tgm8KtjIA5x3ePcvY0BlzVaMWDpKFep5NWR5W7L9BMvaYR9jq?=
 =?iso-8859-1?Q?dPd0T+C/fBiQdYkPTLP+Hn/rllLfHEEOpsvrLSZb2Ys1hJnlsBv2WPWDgn?=
 =?iso-8859-1?Q?w1xRJ32ApG99HpJAmyMJX0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?83EpCjYq1FnoikIwgl6WkBYtgqESRgjlenIi1EvvjIZ8CUHdeUvWva9G8M?=
 =?iso-8859-1?Q?eElO8Ru4ObdRVygNcnfEtGhKqgILbBngBnNXwANPJpEBpwOu2rq5X+496I?=
 =?iso-8859-1?Q?ct4CB9djMMF66r3iq/m+8t1JtxNqHjbCZghxpc4yEJI01WkYW0mxevV7jB?=
 =?iso-8859-1?Q?ng0y2hDRYxxKogOJPKWWW2OpcMCFjxkkZLZWan29Pcqnamgw3za/VnI2dX?=
 =?iso-8859-1?Q?i7Lah6fp9cyCvbrQu43OFyAz90BvNBmf/uUjvsQtyT0zQGedCH+PUyGsqn?=
 =?iso-8859-1?Q?7cId7z30bC9iGp/ZkUDT5MKgVfFB3AcpbrhoUPJ+OCNJG0N7PJYgF0BId4?=
 =?iso-8859-1?Q?+MUsMUKe/xHhjpcqZwYszwRZ5NSGjkcpPHrkyQaCZuJzLxF46A85eWrWcV?=
 =?iso-8859-1?Q?KAeDCS3n+98+NDkMoqh+8eHTO8xpFpvA8xpXHxPOfYJd+xHU1u6amxJ+Ui?=
 =?iso-8859-1?Q?9Xwp2A0cY9DL6XIKYle9L+/mwFsj7jwVsWY+c5G1NCDc81ypOnfN6Rju2V?=
 =?iso-8859-1?Q?xP6xyHeDyfRZMs1TfQdeccok7T1B9fFGdliGLswbiXBx1cNx3IowvmWGS0?=
 =?iso-8859-1?Q?9J6FB6Plp0m2GuNRCXUUC0tTta5UYeFHe3IPo+A6BYg8gi5VFg5aA+v1XA?=
 =?iso-8859-1?Q?NFxsAJNV/ioHIzerFP6JNFgadvjotkOCq5hj4UE6BNwinvC89c/BJLt+Dp?=
 =?iso-8859-1?Q?QHNzyNuyBxpjF/qMjoZKTH7Yjwi+kWxdDdqigYq5hjU4CE1Gls4B22g5Ls?=
 =?iso-8859-1?Q?2IfWXlMHfdIYMCt4myT7bsXRHt2lzrVA3pNPzZvCOZ7HrZ5jsQNTFWWuvH?=
 =?iso-8859-1?Q?3RIWe0bFBpQAofTXA3oMvRzJkvt/2fCGgcdESz0WBMqdObPI/PcbgJMyLT?=
 =?iso-8859-1?Q?8/Sble4NOVnJ18xhIxFI4p2klNt/omOIs34oMfuDcLGoGfTH5/ZNYimesb?=
 =?iso-8859-1?Q?Rt5J4KCs1iR4F0Lg+O5VCWvhE+XbASd2XHmFGnfzSJneykzCI+xc6ZWLs5?=
 =?iso-8859-1?Q?K3/C7mc0NRfls0RumLexBe1IhK4AgktoFS1uAA9xQE9TBp1LhoubDcOvEG?=
 =?iso-8859-1?Q?PBTdgqng5wCChX48Zl1V7a/ztwbSgDdDLucvaAhNPhAL6wYvZNk0u0zRiN?=
 =?iso-8859-1?Q?vI8/3QOHcK0/uPOimIW/MGzcS8kcBRoZ6kv9nz6H8bYGc0uugmCK+LgNfY?=
 =?iso-8859-1?Q?V/dckV0RbnGLsNDrCt6cys2FGuSnwV7/MkYb7VRzMLoNrnPoa0jw/FnTJ1?=
 =?iso-8859-1?Q?calmO1THlqF0PH5NMBZgOR+CpL2yycE5aPvrF9tv2kzhQjUU1rpJKqdp09?=
 =?iso-8859-1?Q?61GEp2BJfCrM7KmNTO8HTP7WdKBVi8hTywE+YaBNiV8SPkwOmb+j8vouCK?=
 =?iso-8859-1?Q?ajw6EpIddJphvL54bogsptLbCnngYuwEggHSzzq0BqZsFncChtogyOCf78?=
 =?iso-8859-1?Q?4t2Xt/QIE7KeQbMl91bGLLgn9g2vn8+AFbCv5JcNMQEV9wkCMEK5s7UYKQ?=
 =?iso-8859-1?Q?g663Orx0SEmyMQm6FZvEvw8XAkjmYj7iDzOBO8uA6mWv1iSdmrRVUDpmaT?=
 =?iso-8859-1?Q?ccGvSyzWwQnhdHxnCX0VZWbhX36KUj/CPbvAYyzfIUbCl7MNYZrM1z3DzG?=
 =?iso-8859-1?Q?kzoeHypP6eE+5jpqps5tckKGDm2ny7RrxN0zvohdXDTZim8YZlBcCsVQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0ac1f0-ac41-4a21-48a6-08de291fbd55
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 17:02:23.2485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYJNVobxkGfLZWMkd7hH9PvWx+pvwxVBmDhv4MX5RkP5+ZZk7xj2/Sp7fwPOqaUpLLCeBXhZsalMu4ZS+2hz/SX3wfq9kRBg3/gspKrSZGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6314
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

On Fri, Nov 21, 2025 at 08:57:30AM -0800, Stephen Hemminger wrote:
> On Fri, 21 Nov 2025 10:35:35 +0000
> Morten Brørup <mb@smartsharesystems.com> wrote:
> 
> > The implementation for copying up to 64 bytes does not depend on address
> > alignment with the size of the CPU's vector registers, so the code
> > handling this was moved from the various implementations to the common
> > function.
> > 
> > Furthermore, the function for copying less than 16 bytes was replaced with
> > a smarter implementation using fewer branches and potentially fewer
> > load/store operations.
> > This function was also extended to handle copying of up to 16 bytes,
> > instead of up to 15 bytes. This small extension reduces the code path for
> > copying two pointers.
> > 
> > These changes provide two benefits:
> > 1. The memory footprint of the copy function is reduced.
> > Previously there were two instances of the compiled code to copy up to 64
> > bytes, one in the "aligned" code path, and one in the "generic" code path.
> > Now there is only one instance, in the "common" code path.
> > 2. The performance for copying up to 64 bytes is improved.
> > The memcpy performance test shows cache-to-cache copying of up to 32 bytes
> > now typically only takes 2 cycles (4 cycles for 64 bytes) versus
> > ca. 6.5 cycles before this patch.
> > 
> > And finally, the missing implementation of rte_mov48() was added.
> > 
> > Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> 
> As I have said before would rather that DPDK move away from having its
> own specialized memcpy.  How is this compared to stock inline gcc?
> The main motivation is that the glibc/gcc team does more testing across
> multiple architectures and has a community with more expertise on CPU
> special cases.

I would tend to agree. Even if we get rte_memcpy a few cycles faster, I
suspect many apps wouldn't notice the difference. However, I understand
that the virtio/vhost libraries gain from using rte_memcpy over standard
memcpy - or at least used to. Perhaps we can consider deprecating
rte_memcpy and just putting a vhost-specific memcpy in that library?

/Bruce
