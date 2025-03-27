Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300D6C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 16:22:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AC1B406BB;
	Thu, 27 Mar 2025 17:22:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3D0D740654
 for <dev@dpdk.org>; Thu, 27 Mar 2025 17:22:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743092573; x=1774628573;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=P8FYOui8wMyajdGsHbjemV3N/0vB1iWj9nO1miKWQ2o=;
 b=VhtU/6klv1cmwuimwECgrSSGdx/Sxe2KBHqBIBVlQRUpZLgYZjG/Atw4
 nuXw3hYHjuo2OD4hYU1+iCm1GZ3NZArqYqlIXvWS/otKevTm5AHFKYa/s
 M0JwVNT4gCkaWeCr5nhjK33Z9NbseakzcJRS/KvW86tiQxIVyojOUQTig
 5KQY5nK5/IyJYIhiE+73afwZibP9wPf1By8akPqBWYigW7trv/Ji9FL+p
 0w/r0n0WUMkvvj73Yd7IS+gAjTf4QyTQ4nEevT25jKFwc//pACsp5WKEQ
 M7OMTTXuRyn2n2K6Sm8nLBq/jO+DTAbswjuB+MWdGdYDsgejdziiereSZ A==;
X-CSE-ConnectionGUID: eLKvA5eqTj6/KtIhhCLzUA==
X-CSE-MsgGUID: iFVuuzruQWyvLzmI2q2Gyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44353920"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="44353920"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 09:22:52 -0700
X-CSE-ConnectionGUID: DcpxwRJ3T1S5Vriv7feI/w==
X-CSE-MsgGUID: pkZExl77QUeh4QZ2p/ylZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="148375939"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 09:22:51 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Mar 2025 09:22:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Mar 2025 09:22:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 09:22:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNz9T3X2xSo8UYUD26VaShVTkCYE66vm3jiTvqSHRjfdP4uoRNlHleA6v9MDtIKruQQWqu1HrifIDZ6B3mHUqR0Q+lBZorRPVuh8mKFN2arWU0UusApfIYQw3JUrxec5pcrJ5dsLCgl6CiImf2oMqqyaInPrU3EN3n6nfkwy0qLgj4g6nvAkEg1kL7CEQyHfh0Z6GP489zhDKsklp6Nb8Og3HnJgk/uNByWYAFVfYpmJNLD52G+u7e9wvxzxaQ1ojeVkrxJkjcBXWAt97iW8hJRnQH1TWIsvmYAzumzQoDmvl4Zm03bqYxvN8/SDcDTEbHfrjEQTIhaprYMGoqkPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82UiI33CWU/vMvB8yLFJLVplDtM4BWvOjfUgC7CS9II=;
 b=brjPl4PhqdfxcvzI3OD2NmBKh4QPOChlWpZtJZLvhXB05UmC7qB9/72BGcZvgiWJL3G9ypI7+G1CZ4jCx8PhAwIn0qSFArIFcpzUeLlLWHofrin3s2V8GAEy/Z3KXmOiI5bOG2h5AsbM4jnmkjFQfAJY6mzkFEa/uWkyFEdXEmIpUDSxLu9xNHomG7Pf/RZCm4kChdd35ReZs0M3+6UTDc7rfG9au0Da9MKXxcw9i9djhV901bBw1g63x+lNmG9XaEsH/z6eUIOV6k7EBTCBWJ6ovSRnwTNFJjPgH2w77CnYhPBdERhdmYX8n2ykZFRSl3En33cUrCSlmjPEV8nBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7313.namprd11.prod.outlook.com (2603:10b6:930:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 16:22:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 16:22:48 +0000
Date: Thu, 27 Mar 2025 16:22:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Gregory Etelson <getelson@nvidia.com>
CC: <dev@dpdk.org>, <dsosnowski@nvidia.com>, <harry.van.haaren@intel.com>,
 <igootorov@gmail.com>, <mkashani@nvidia.com>, <stephen@networkplumber.org>,
 <thomas@monjalon.net>
Subject: Re: [PATCH v4] rust: support raw DPDK API
Message-ID: <Z-V7UmCfYEbkWOeY@bricha3-mobl1.ger.corp.intel.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250322105911.12378-1-getelson@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250322105911.12378-1-getelson@nvidia.com>
X-ClientProxiedBy: DU6P191CA0050.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: d314cb11-b3bb-442f-b25f-08dd6d4b9ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MxmAWXU00KciYSdS9M3mFNGrUm6Cho08XIxD5Gi8AjrAH60QIJ4LbPYYVftL?=
 =?us-ascii?Q?v/dznnVITU3ehb+TF5rGZwMHBadbdjjbGJkIMyUSo79As1lk+Ll4CucbZ6uV?=
 =?us-ascii?Q?I3Hou6OkgEPqYMqMczh7H4z0gP6F8nAnW8qypbOfKtCDFCT/j8rdec2DbNt9?=
 =?us-ascii?Q?UXV6XxBVsFoJ9ntEwb1GYrJ1eo6ykzR2FUrDctRPQ9WZEM7RZOf5Rrw5T0pJ?=
 =?us-ascii?Q?OXwITvmY+gnMPktiS/0ncfGFSImYsD/5VDK/oqmwN/0f5nCMMoqT8BvWBZ2P?=
 =?us-ascii?Q?4n3nNvHTdWFTrdj3dnX/FLGJi2rHJHh2Pg1JEexVrdxwaZGr0oj6Fu0M+qc0?=
 =?us-ascii?Q?HJsmCGAsszWCr9n1FmfVu33UiGU6PDYE6XaWsiBhmunuMDssSGq6q1qX1O+E?=
 =?us-ascii?Q?6PeGtmsroZP5tKgkMqHJy10fo2atxEwbGR3bAWEZrH5bX/nz8i8Hu3tK/W36?=
 =?us-ascii?Q?2RFAJq05zrusZ+CPjKFnh9e7ZTW0xm2IdCm8lt5f59eBMU7YakjYlpwavOuZ?=
 =?us-ascii?Q?WIHRfWu69fluRjOaDCr8BjyvMzFw4Sbmf9r7g894AiHGmCx80e9DO+c3Wpyv?=
 =?us-ascii?Q?z9BAhvXgWAi4Iey/azM6CCBdBrket918mKRcv30fKAm2oe7M5GZCrH7R0llw?=
 =?us-ascii?Q?jVoTI4Gk+JkX2m6HB1nJ+I0d4g43h9SkdQ4quUZNABvXdXd464aDX3HLE7xv?=
 =?us-ascii?Q?ZqDD56GPHHZyMZeVnGveihXqTgA5BRRlz/0lnFC9EpKoRmfxOmDmuRkTYilQ?=
 =?us-ascii?Q?NW3SB7cXkfi8sc33LXlHYgCGEL/AIZ7BjZF8sCOhh0GydK9Kmjj6eq8i6bcA?=
 =?us-ascii?Q?dInpiaJwj5KIMVRmN7tyHAom3uvMMkgxKZ/0JEgMrrEPtTi7PiBdCo1fXwkS?=
 =?us-ascii?Q?WVi7ccPDkMFYTvzYRRq7iHeROgb37XfTLgr3wXfAUMoI++wENyeNErq8x4Xt?=
 =?us-ascii?Q?b1idxIosrWwnfpLGIG+Kyju7Thrd99X4d5kMlFRkgSGRGG1y51Tin6QJOyAj?=
 =?us-ascii?Q?TiuVh6wBWnJ+trqH7Obiu782cNFxQE5zyIN//d9lLMaP0k+sLazP1U1aGjps?=
 =?us-ascii?Q?+ZXOOYtdntBtySYzocUMGkkJHF/QdnlDDmrBBzPxp71W3YxOiSsSK9rGo/PD?=
 =?us-ascii?Q?W3siGj8KdB/gUwz3ZiV0C9Nll8JQyAX5sCVbCdIBFAdmKR+a19O4H/kNYfkn?=
 =?us-ascii?Q?UD1rDmBl99DMivV9TQ5nyRXP+iswK9B7KS3YqPgMaVTH2IzZU/c50pLQXQmM?=
 =?us-ascii?Q?OvaY5UZDVVBH5FR3jPKs1it3pqL6ihHUhKhBvDy+lD49n4T06bslmVmEGijO?=
 =?us-ascii?Q?VNB3MY4kHULE2QRoFBVOiXeXiAsQFsh93sM90aBrMGXqGCT4NvuD7IgGogLr?=
 =?us-ascii?Q?Rlx4eFu+I/2TAys+BKiFc9jiYdO7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DSjYI/yJZGli0aY0m3l5XTo50ntwPxc4jQnre3WHHvTB6zI2J2oeU8bjpQ0R?=
 =?us-ascii?Q?SXPTif/Tu6HyxRwJHYjwuWQn9TMC79Mto6gIIeb5nADi/1XXByyvtPIv7QQJ?=
 =?us-ascii?Q?T6A6tnYBg60kC8LLhwPhU0gl/dtkjo8WHO9o2xdAglO0Aw1tdZ9eUgOw8xvt?=
 =?us-ascii?Q?h9uavmsYfh/bpeRBw7cjHG6blS3PSiXlZawS/ifMK9UM0sd2pybvEgy8RFb2?=
 =?us-ascii?Q?dgeHqkptiuzv9yDxTi7Vf2TgJi2Mgpn3NXpy8VmItThB7vr+xHvTG3vVeL1X?=
 =?us-ascii?Q?5GAhuXDF6msbD6NkGnl/LJdUbT1G4pSHW7CGGQ12iAiBjlUr+Z9C1DNtFAgQ?=
 =?us-ascii?Q?06YQikYMw5nmYFgn1tUS0rTaAW1t1ZTIkm19tSRLMqIog6sSGjvz05KU8dbj?=
 =?us-ascii?Q?0l0NuYZTbFvVF5vdk2Dd/6NNmQ3c8sqXOQ07uZptDPoLDCjhZUd/YLjvp9rq?=
 =?us-ascii?Q?aWyFkqooKiINagn4xsfdn++IxjaarlSyAndupuq3foMHfN5RLaO0lBI6YHbh?=
 =?us-ascii?Q?pGpFG7EYVNeWh8RRbBLg1qgh+gO5M1ivu0+XTzfDHDrWxzayWvaqxubsVTUP?=
 =?us-ascii?Q?mrXXr3bPFLFGYi0JkUn/610/FduwWAJOR9zKpxik0aBTXmTWtn0oDpO+EjaA?=
 =?us-ascii?Q?V/Jw1xqziwu+cCh6JETr3hQm+N+qC1FD/NXqa4ij+Jalg1J+WWPpbqwRsqaf?=
 =?us-ascii?Q?2qCISIJxW9Q6CNq0c4pN7PVQ9pXpmWnJlDezKEumUHQ2b6b6arzt9zMi/ogy?=
 =?us-ascii?Q?SR0SyrdNkgsSN5AO+BEPr+vyrsBEL02cEOg3EuiswNJrL6fbtxxTTDyq+Npx?=
 =?us-ascii?Q?Tl1e7fT9Pjg12dAXU0ErhxHVudA8XPfV5xEBG90zp7Q1yjBOMNT3kLl2EQEY?=
 =?us-ascii?Q?BuqkK/lZZjSIeWvAB9undlc8ioryhkhDmfQZGf4TWaDcq6wN49UUuRNVk0KW?=
 =?us-ascii?Q?ffRiue6qtu2YUYnhq2cDFSn6PXxlbY4knHwcLKYem3MDwk2wsTeY5s1HFm6a?=
 =?us-ascii?Q?NP0wCNMLEtuW4HlPK1mjYb3yzjPO6WTmavZm3Tg1D1nV69gYPkWtkKlW0q+F?=
 =?us-ascii?Q?tRJZ8JKkZm0REkxA/oIxM5X0yKvCSQxzy/Crl8r5YpSj471i+YWddLyoTQqc?=
 =?us-ascii?Q?ZuKQ8qK+C1YK+FtTAqIYCmdkrEVM2MP0XSGQJNddnZ99egsHdHgJhahhapkP?=
 =?us-ascii?Q?d0cnGFu3BCUcDvTWEvwSIp9YRlNMPf5aleRPmbH/kPdxp8OeQ7lRTRQFvMAq?=
 =?us-ascii?Q?aYtSbe1ZRtWMWWcbSaxKBy/uE4Wg7Z+0ycT/I2I+nT7t+oq3rSft4cO9TP8S?=
 =?us-ascii?Q?dMo7u7PccbxNs8JrWOybbttn+T/K+eJL2zFMURizhozcgjmcSO/aApTiAqRS?=
 =?us-ascii?Q?f4YlXLAxq8H6cf3qZI/WV1ypY2vl3qAR2TCC0GoEP+V5e2ZYL/xfT0uEp1my?=
 =?us-ascii?Q?Y31N/7KbeVQlmZpqRrqpDukhUjE1mGRvHWuTuunsygm/5ElcEG4Vb+zfvs0h?=
 =?us-ascii?Q?6qUQPa4z3cBQV2KErRMdXKjuCGkccip8HkihJIPmCUHM9IgXYDz0oTHLlrXx?=
 =?us-ascii?Q?RLgS2V2er3Vx8mVjjX1rXIUZEi6/mfqx6v5eBWp6JaxHBCt1lNtkvFoi4J0o?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d314cb11-b3bb-442f-b25f-08dd6d4b9ce1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 16:22:48.0999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ytw92CBksWg2bcGoJdSjDOTPEaU54VURAc7JWIG1jm9VofHw9nSHOhW2dJ9+4lLpkyEZeOoOaCAgJe2K27yEKsxbUEBoP4Y1N4WVDtnX4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7313
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

On Sat, Mar 22, 2025 at 12:59:11PM +0200, Gregory Etelson wrote:
> The patch converts include files with DPDK API to RUST and binds new
> RUST API files into raw module under dpdk crate.
> 
> The RUST files and DPDK libraries build from C sources
> allow creation of DPDK application in RUST.
> 
> RUST DPDK application must specify the `dpdk` crate as
> dependency in Cargo.toml file.
> 
> RUST `dpdk` crate is installed into
> $MESON_INSTALL_DESTDIR_PREFIX/$libdir/rust directory.
> 
> Software requirements:
> - clang
> - RUST installation
> - bindgen-cli crate
> 
> RUST dpdk installation instructions:
> 1. Configure DPDK with `-Deanble_rust=true`
> 2. Build and install DPDK. The installation procedure will create
>    $MESON_INSTALL_DESTDIR_PREFIX/$libdir/rust crate.
> 3. Update PKG_CONFIG_PATH to point to DPDK installation.
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>

Hi Gregory,

some additional thoughts and comments inline below.

/Bruce

> ---
> v2:
> Change rust crate name from dpdklib to dpdk.
> Add raw module for to link with C API.
> Add "cargo:rerun-if-changed=build.rs".
> v3:
> Move init_port_config() to Port.
> Move start_port() to Port.
> Remove Cargo.lock from git repository
> Reformat code.
> v4:
> Blocked bindgen to convert stdlib functions with u128 type.
> Allow compilation of C style symbols.

When using bindgen, are we better to take the approach (as in this patch)
of running it on everything in the headers and just excluding some things,
or taking the opposite conservative approach of just listing the functions
and defines we actually do want exposed (with wildcarding as necessary)?
When playing with rust apps on top of DPDK myself, I've tended toward the
latter scheme, but maybe for this effort we may want the former.

> ---
>  buildtools/meson.build               |   4 +
>  buildtools/rust-env.sh               |  96 ++++++++++++
>  examples/rust/helloworld/Cargo.toml  |   7 +
>  examples/rust/helloworld/build.rs    |  24 +++
>  examples/rust/helloworld/src/main.rs | 219 +++++++++++++++++++++++++++
>  meson_options.txt                    |   2 +
>  6 files changed, 352 insertions(+)
>  create mode 100755 buildtools/rust-env.sh
>  create mode 100644 examples/rust/helloworld/Cargo.toml
>  create mode 100644 examples/rust/helloworld/build.rs
>  create mode 100644 examples/rust/helloworld/src/main.rs
> 
> diff --git a/buildtools/meson.build b/buildtools/meson.build
> index 4e2c1217a2..b9d0092f07 100644
> --- a/buildtools/meson.build
> +++ b/buildtools/meson.build
> @@ -50,3 +50,7 @@ else
>      pmdinfo += 'ar'
>      pmdinfogen += 'elf'
>  endif
> +
> +if get_option('enable_rust')
> +    meson.add_install_script(['rust-env.sh', get_option('libdir')])
> +endif

I'm not convinced by having this done as a post-install script. Instead I'd
tend towards having a rust crate hosted somewhere that does the bindgen as
part of the rust build.

> diff --git a/buildtools/rust-env.sh b/buildtools/rust-env.sh
> new file mode 100755
> index 0000000000..a239432a28
> --- /dev/null
> +++ b/buildtools/rust-env.sh
> @@ -0,0 +1,96 @@
> +#! /bin/sh
> +
> +# Convert DPDK API files into RUST.
> +# DPDK files selection is on demand.
> +#

<snip>

> diff --git a/examples/rust/helloworld/build.rs b/examples/rust/helloworld/build.rs
> new file mode 100644
> index 0000000000..bd5737d209
> --- /dev/null
> +++ b/examples/rust/helloworld/build.rs
> @@ -0,0 +1,24 @@
> +use std::process::Command;
> +
> +pub fn main() {
> +    let mut pkgconfig = Command::new("pkg-config");
> +
> +    match pkgconfig.args(["--libs", "libdpdk"]).output() {

This work of using pkgconfig should not be necessary in the application
build.rs file. If we switch to actually producing a proper crate, the
pkgconfig handling and linking should be covered there (I would hope,
anyway).

> +        Ok(output) => {
> +            let stdout = String::from_utf8_lossy(&output.stdout)
> +                .trim_end()
> +                .to_string();
> +            for token in stdout.split_ascii_whitespace().filter(|s| !s.is_empty()) {
> +                if token.starts_with("-L") {
> +                    println!("cargo::rustc-link-search=native={}", &token[2..]);
> +                } else if token.starts_with("-l") {
> +                    println!("cargo::rustc-link-lib={}", &token[2..]);
> +                }
> +            }
> +            println!("cargo:rerun-if-changed=build.rs");
> +        }
> +        Err(error) => {
> +            panic!("failed to read libdpdk package: {:?}", error);
> +        }
> +    }
> +}

<snip>
