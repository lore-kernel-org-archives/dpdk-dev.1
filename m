Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84554C369A2
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 15:06:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D8F540672;
	Tue,  8 Apr 2025 17:06:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 641EE40264
 for <dev@dpdk.org>; Tue,  8 Apr 2025 17:06:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744124763; x=1775660763;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9QjxbhIHli7/N3FsfjDs8NW/StUIF8Tid54eQjGprpk=;
 b=INfuW6oZIIlXXvMSVpkJFdxsvRyStq96FATiy2pbf5TaLRUqjYPxVpMO
 d6U3zCjJf/H7usyGjAi7w6yvUCl2dlgm5c0Vogx4C7H96PBvEyjnrb4zi
 rpRiQSDbBXkL103glm2i4x3yIt0ICeRVM9fkwmoIhJgb9SU62SKjaihHi
 IYzSxIUU7iKviHc3gDqv3H+3ZYZjGWHBSmOgYcQfsTRJwmILLWAJGuX+A
 n2vgjOf80pvBLOtAZjGRW/bXBA9qn0gGrA+Pd+VyQlmsnYWAq74zJD7ZQ
 mUyf6Qx7rd6UBgVLeBu+J3jG7qcYnd0HKKW4vsBOWKplsU6GsuE+BqYUS A==;
X-CSE-ConnectionGUID: g/37jovLQfmrPmjjSR6RJA==
X-CSE-MsgGUID: C0A33bSsTAqOdUd4gTQwtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49359332"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="49359332"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 08:06:02 -0700
X-CSE-ConnectionGUID: kjPM0QMGT4uwNiMRjUrLeA==
X-CSE-MsgGUID: 9DzyK+ffQZ+5sNHdbWH6+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="128190044"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 08:06:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 08:06:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 08:06:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 08:05:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVIcWKTPQfwJIJXaGkHZiNPdDK4D32TTXwLatiXDNesoKs7ekQLKiTS0wxYxdpvquCgRfSkoxtj8XZw0WpFDN/3g+mwh2WjUfTb1y+oSkrzDKjB9YFb/EAwomC4UFb4pQTMHHeY85iDf+IE62uy4WcgtF9CFzGj//yijHSaykIjovUYjYrG7eaL2F79XIJ0TbvAlU8YMOiNhOwN5b04T0MR010CZDkKyaHh8bL//0wTdiTc64wzOD2JhxIGh2QCwihh0bh/qAMT9wmJrsH2Onjwny1D3zvtWcp74sdppK8jkpz8tyFBXRb2+TX8uivTNAzI/tNzPPiSI3HuksEa4Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krs4cx1GF/cYnN6txtJ9sxxx9vsdF7LU49fMzbgH2DM=;
 b=xQKIMc5zEMIZupV2mSq0tuNJlx8I7uLLLs8v2PAzPmEgW2PA838ItkVnArsDri1/LemqQhNEbG9p2/OnXIWgY0MbCluD2dfXf1ZtM6LVhjvMFtzJExpLXVxqNeYnPTD3eLPEIxQKHaLP7UEii4Cqtp7G6cJkU+4dgjeYehJ6rRVf3guKp1Qpvl8Zq9WLPoLLfRBc7j2P+A0pRGlSn3oJwMICAAbgIVaRsEEz6HsIzyY/ic8+ln23g+3yYdWmp2KV5tpCN6p59EVl640J4CeEoBNG05sxEJy0qvkKvOKhZxcQ12xTW9JZ8k1b17oLRLBGgcaBCilHo3LaubENl9I7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6090.namprd11.prod.outlook.com (2603:10b6:930:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 15:05:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 15:05:56 +0000
Date: Tue, 8 Apr 2025 16:05:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>
Subject: Re: [RFC PATCH] add rust binding support to DPDK
Message-ID: <Z_U7T9qFJzvhmBuP@bricha3-mobl1.ger.corp.intel.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250408145838.2501034-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250408145838.2501034-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0360.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: eac98a92-b667-4ea0-4e2a-08dd76aedd26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ynqkrWedBmFpS9QVC1MmL6QzT4xwas6Aq4/m25JPcagWX0EVF5LX2/TzFkPn?=
 =?us-ascii?Q?eZQOpq4mWqUaflb7Jld2DcsRtELZTK2+Hdv6+BFbmn9pQpbzWXhSDqWTuWrk?=
 =?us-ascii?Q?VcwkZtZNwwwlNq/f9p9ahEe/UeDWogMoDf9poF6p9CJxYqmdHCn+RP+Q3zJJ?=
 =?us-ascii?Q?5oEpXJfgOHZ0dNraYXc0bde1HfWkndJCv2UMkLHYXzO2c6Sz31G9riTBcQJc?=
 =?us-ascii?Q?bJaExl6NBch9gwvVWNElWXeEn6p9AONIMPOLb93EZPuXtS/1R5UaCsLHmBNG?=
 =?us-ascii?Q?XwZ/H+bxb+bpVq6NsOgR3oUtf2R/xsAFrTc8fs3m98rW7shuiLLWo3y0/nFL?=
 =?us-ascii?Q?cIPK+ha9HH4pW83foVaTshfpfCtC2XZTjLF9RexJBKhq2+EKCBKqsCZzV9jG?=
 =?us-ascii?Q?VC1JxKCeT6IBqAm9IMfmEwd8EQ+cM5xf/JvUibpvUZ7uc3V2zrhMu8FST+z9?=
 =?us-ascii?Q?4s3evPx5ryS1oW/7iZh6W+zYCoBHeanKIL1vCxbTuc6Y39KljykIG1RhShL4?=
 =?us-ascii?Q?yPeA+vq74GLJP5FXwH06SVGHMFALif46vMq53L8pMtXfQN3GdC0yU3YhDy49?=
 =?us-ascii?Q?HL0Ia/g52dPew5YOg1/UzkGnGbxSa9ypq9Sh4gWUSfF7orz+e6hpob+oXkcm?=
 =?us-ascii?Q?+TI0R/kANfPgA70Rl5WuLtzkDO9CrrLgJrX33XeioHuqC41kv8spZngfTSnb?=
 =?us-ascii?Q?0oe3K4LAYsji6mAAybIyHq3vNkRZK5nCBChOeh7xiuaUHfEL3gN+E4yf79wN?=
 =?us-ascii?Q?lZH/qae2Oud31zrHwMmxNHJDNVbVhQCIwKKSslvlNP/1O4novcs1VK+YqeqK?=
 =?us-ascii?Q?nFwXh3SLrR/7PDTSP+JJYGiacRQy8gFytqbxhw65Kd9d2ydoPNEzzeF9HKeq?=
 =?us-ascii?Q?k4qTmuC5qKhE4qztPkcJojDKDBrvKyZlbGxlaBx5xbH28nGSvom2TTgRN164?=
 =?us-ascii?Q?J/jBwkqqS6kGRMuTDqEZ0igAipIv8hMm1AiDEOgNIaF5DxdR+OXZA4ZtM6Q5?=
 =?us-ascii?Q?B42CxibEy4WjVWyCxS0I3Z84Q0oq+BSF7yz1BNCb+2kwWtSbEMgRveNRLeF8?=
 =?us-ascii?Q?2Ktn9kS+2wNPU6zE8L0C+5198MRDa3cExaFXF058YQaO5qlr/FPX8hMvBdJi?=
 =?us-ascii?Q?CrQa1n454yqVCn50eleVNgRcqR0MZLXZit4rUT4cctR+8YoS1TYVinkgKzGV?=
 =?us-ascii?Q?BSpRlICVo6Slagm5DvYjYYESrQoE6KkH6lk5YLdt3wMEWu/xjXbMim/nF/p3?=
 =?us-ascii?Q?0lzG/K1qS1K22uPcBmg0AcjY81ck1I6A1eXiGXeD7vsuB8Gxzay3doDNt+Ea?=
 =?us-ascii?Q?6pGGGcI1anYapVze5GTGJbUm8seVGKxxIYM+k9LNtYW3ZiBSdor8hnraztIj?=
 =?us-ascii?Q?o3szfRbdQgDYtzlmWq38TqNpfQtX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VeYoNo8FPbgS3sXp20tYxPhR4n8xeWvLbrTR9lrhw8eNyhHvcsEow2QelTVZ?=
 =?us-ascii?Q?4iYKSDUNH/6gNKgeuVtPvTS/ao0+/E/6UuCF4MkLs/DUHS/oLMOrnkUU5/+i?=
 =?us-ascii?Q?VgsKomIKWBc1i3ssKPr6eUBNbJySSg37R/EFVrUKu5FyqbR5LaLW8P4z9KDL?=
 =?us-ascii?Q?iGKcA1llsPA0ExQxS1GXBtTMEQ4wUb0PD/2E2ZSJg709uvR+dPnhm+kadKWH?=
 =?us-ascii?Q?StxTfd4TFvIis+CxZZ7E/6SGVMCHHz/DRzTcKIoPGxaRBfBcW4UOAof44jOv?=
 =?us-ascii?Q?sSELd3z1nfjkcLahPVptAzwQV9lJLQ9798Smq8RkezIec6gezmnWvAtBrPIO?=
 =?us-ascii?Q?qcLT/Y9oJp9HiYo0ED56i0nclqoroLyE3Ws3OAODPZHo5A0/h32XyYoZz6Z0?=
 =?us-ascii?Q?4jSgMvDvIyLsHyqFtaDtU4iX7XPPEhSw2gJjlNQa1BiTp8yDb5tfxLepEa4s?=
 =?us-ascii?Q?j/eHjh0kU7iMdys7A1KQs4+Ih6jLmhkbOFijV9NZQ2JRAHnh6Xwfcg8y1WfE?=
 =?us-ascii?Q?QvalcLuCNZIlctief5aargImShGMv53tv7bBMBWDCC4AfFWJLawLF/s3j21l?=
 =?us-ascii?Q?56LcCyT7cGSLDqxGj/ZiSkNLorg9oE7OYfeD4Jw9rKVhOJAO5WIhsvMJmW55?=
 =?us-ascii?Q?zVVoIYedHfGUgvW6ceOyIoimUmdszNm1xH0C+kiOjrC0YYayE0YK8nfVz+9p?=
 =?us-ascii?Q?Yz2dyfZWNg18/uxjx6fJRaiqZbqQHRz1JDPN9d8jwc/6l2OArwQAHY6t85RM?=
 =?us-ascii?Q?/Ps4/sEBPFgY5p38dkuITw9tsRAgyPAstbSAOhM3UXxbh14OKZbb5eg51aUw?=
 =?us-ascii?Q?Sn2XBxEle8gtBxBD24AJSRFlda6jzUc1xDcce3cfWkVi9Xvx8U+QioKVw9iG?=
 =?us-ascii?Q?VcG0YbRBjzB3d/PrGbl/ELIbBMPwZPjxWCjIHkc2yoVV8RUVsQ4wh3G/N3UZ?=
 =?us-ascii?Q?X1vuwEOQ5djkJUfKOyHLB32WXpSUuQ5CWDscUBCldR8g/Uk/yTulQA+7b/Fg?=
 =?us-ascii?Q?LAejvEPbApKbDx7TVcQcCeWkAxDj8vpgmdSEIo2AKYvVMum8P0qfU7CWY3Ck?=
 =?us-ascii?Q?J9YMl8sW5zGHpQsadnc08zGamIsP2ZNQLqEVJ1tNhlSYXqqO5A6KgqB1SIZK?=
 =?us-ascii?Q?N/RvtI0bFITDb/w7M8LaADV62dNB49oqgQH7zoEvNIVfpP+lgncQFKUXFl6M?=
 =?us-ascii?Q?gPBSaDu91WcA6qhHQEq9ZeIvoOAWz9bbyeBPJRlxmhwxRL0DBNZVQ+JQ3pU2?=
 =?us-ascii?Q?kZNxvKnMbuddT4g36KARo7mUnmX6M8c6ZWEXe7k871ycCYsffw8oUq55cYlu?=
 =?us-ascii?Q?S9FfNIlHpKhFqgKiiGO8adDTj3e68blWfBPve9olCdraGA7mJqQ7R0n1IFYw?=
 =?us-ascii?Q?spMRrmqVbA9/RM6E/PsCY7jFkvI8fY0nfnRRZ71xl2qLyB1zg64x8Uz5JcI3?=
 =?us-ascii?Q?GNBJfW4z2KFCaCb789aDwnuwF1WwTq11JYBf6K3LwqPQc/Alq0jPD2A5FaXS?=
 =?us-ascii?Q?uhNBj+dC9z/YHH5nkjccCWGYUXZpi/3neTYhP0se0ZtSPXk1UMKlhkiEvf8B?=
 =?us-ascii?Q?nd+DQretaKicuA+qnhWN4LPDeg0OItSzoqqBP2wRlVsQv9DRfNLPIpBvpg+O?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eac98a92-b667-4ea0-4e2a-08dd76aedd26
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:05:56.6136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0hChrEP0xyxDJt3uulmzfcgSvSQpKfUNE1J8lT+QSfhCLc53eQDIgGtR2EWECyC5bcx5dOEXS56jbv7U9g1PuESb3I/hcI/OaFfw37ews8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6090
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

On Tue, Apr 08, 2025 at 03:58:38PM +0100, Bruce Richardson wrote:
> Add a Cargo.toml file in the root folder and a number of other scripts
> and rust-related files into buildtools/rust, which then enables DPDK to
> be cloned and built as a rust crate - all-be-it one with only two
> functions: rte_eal_init and rte_eal_cleanup.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> 
> This RFC is proposed as an alternative approach to enabling rust support
> in DPDK. The key difference vs previous is that we are taking the whole
> DPDK project here as a rust "crate", which can then be used by other
> higher-level crates as a dependency. Building the crate does a
> (minimal) build of DPDK and statically links it in, so there is no
> "install" step or anything needed - the Rust app just adds DPDK to their
> Cargo.toml file and then should have everything they need.
> 
> ---
>  Cargo.toml                                | 16 +++++++
>  buildtools/meson.build                    |  1 +
>  buildtools/rust/build.rs                  | 45 ++++++++++++++++++++
>  buildtools/rust/gen-cargo-bindgen-info.py | 52 +++++++++++++++++++++++
>  buildtools/rust/lib.rs                    | 25 +++++++++++
>  buildtools/rust/wrapper.h                 |  5 +++
>  meson.build                               |  3 ++
>  7 files changed, 147 insertions(+)
>  create mode 100644 Cargo.toml
>  create mode 100644 buildtools/rust/build.rs
>  create mode 100644 buildtools/rust/gen-cargo-bindgen-info.py
>  create mode 100644 buildtools/rust/lib.rs
>  create mode 100644 buildtools/rust/wrapper.h
> 

<snip>

> diff --git a/buildtools/rust/lib.rs b/buildtools/rust/lib.rs
> new file mode 100644
> index 0000000000..f99c54ac42
> --- /dev/null
> +++ b/buildtools/rust/lib.rs
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Intel Corporation
> + */
> +
> +#![allow(non_upper_case_globals)]
> +#![allow(non_camel_case_types)]
> +#![allow(non_snake_case)]
> +
> +include!(concat!(env!("OUT_DIR"), "/bindings.rs"));
> +
> +#[cfg(test)]
> +mod tests {
> +    use super::*;
> +
> +    #[test]
> +    fn test_helloworld() {
> +	let appname = std::ffi::CString::new("test-rs").unwrap();
> +	let mut argv = [appname.into_raw()];
> +	let ret = unsafe {
> +		rte_eal_init(argv.len().try_into().unwrap(), argv.as_mut_ptr())
> +	};
> +	assert!(ret >= 0, "rte_eal_init failed");
> +        unsafe { rte_eal_cleanup() };
> +    }
> +}

This test code is included in the patch to make it easy to verify that DPDK
can be built and run with rust - at least doing EAL init and cleanup.

To test, once rust is available on your system (e.g. using rustup), apply
this patch and then just do "cargo test" in the root of your DPDK
directory. After waiting a minute for things to build you should see the
test run output of DPDK initialization.

The whole approach for now I'm deliberately keeping extremely minimal so as
a) not to invest too much effort before we know what way we want to go and
b) to make it easier to review and comment upon.

For anyone wanting to try this out in a standalone app or play with
developing a higher-level crate, I've pushed this patch to my github
account. This is the "Cargo.toml" file entry I've used to pull this down
when investigating wrapping eal_init into a "higher-level" rust-style init
API:

[dependencies]
dpdk-c = { git = "https://github.com/bruce-richardson/dpdk", branch = "cargo-build" }

Regards,

/Bruce
