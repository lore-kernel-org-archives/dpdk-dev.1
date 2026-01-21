Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B48D46951
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 16:29:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDD6342D96;
	Wed, 21 Jan 2026 17:29:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id F1A0940261;
 Wed, 21 Jan 2026 17:29:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769012992; x=1800548992;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lbB8+RGGxqFZZN/i4OlwOfIBjMqJh/HMDmDzLJ0cTMo=;
 b=KZOHOaicx4EVBHZjdH0H8ja9N9b3oVGHjhsYOokYQPdBdBibqq9Fnw42
 zFemqln/xq4MQnwwNqNVe4tIUSVQEDqJMRbeEFQ13LyeHj41ld8hQyDwe
 c6ee3zFrrP9YIc7cXdpZIu60kJVQtnyvaQi0PvUrTkFOPZh6tzwNdM0Q5
 0hoiEHroZCae4gtpfFMo13RrRXW8jS81X3Vp9BQyCiiroOx6eRgXxGgkr
 YSIkz7EYAcy3tQlA/NNnbhBX0MAjcfkxC+BuocxRnuoal2ww60j842XfQ
 BhgHBfvlC7cm//Pof2xw0ipeifDncE9ZHDvBaRqCHdBol/e9TFJ3J7a29 g==;
X-CSE-ConnectionGUID: kdv24eufSzyzFnDMSZdeqA==
X-CSE-MsgGUID: oiOSMfdlSS+uFW5FqF3z2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="74097281"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="74097281"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 08:29:51 -0800
X-CSE-ConnectionGUID: yTJzI8s/Q8iuwh5kJm1RlQ==
X-CSE-MsgGUID: hQdXPgmyS4S7UroEW/T5Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="206722735"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 08:29:50 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:29:49 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 08:29:49 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:29:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mB1kVB4wBqMExd/EikdSbL/Ls2kyk7jx5Ti6uZRxhOR+bssR1rsOtcBXN3Ck9ycLlhwg7R3a0ghKZQSWFxHe66s2s/xaybdnQhQR5vv6c/jWS1WKAiRTvtmk+Sp0MPhGsqd5pHoGY67h9Ed3fUWfS6rcDaQH24CmZlzVouwm8b/XOmnxDKZeDUmvS4CDI8ks3DClgX9vViA5744N7GuYqfXkMczt/MHbMjlinGLrMSZIsabIKgXfxork5hwp9Gob4UquhmNYGatacg7rRbPQ4QIHzjITvAH7LFofMKTwRsQG8gahoAVXh/3IJVYQ0WILoq/AgWbir0xCKhDXRGaaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY2AOIljb+0v6+QwHSzGIBK7UnnvFhsbaGGuraKXe/o=;
 b=alWRTFehL258elslzJ8HVCkFXPz0ewwanlNewG6xpircoSrV2zvo064nPX/+DwU1RDto0TCQ7N70uIfW8BojRCRgI35eEipsO+FiuJUSrWuJeX10u5L/Bhc83wmPQV+5cFOeXqNRTaiVXayr3L+D8GkXMeZmMwjBFNLmlPy22LwYPdfi/TKLMmDbRLs7v1ShtuKyK8kv5slzn2njWn2zZnKiAagPlv+QIUn+8Lbyn24B+Qu7wvjRPNndr+5/d6+7j0UC6wubg3vHMcVGMHUVXy1rCfu4MULamjKmXU8eRCukdLHUVle/jmYJcOEg8dYUmMbPPFAJiKEffas1LayR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7826.namprd11.prod.outlook.com (2603:10b6:930:76::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:29:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 16:29:45 +0000
Date: Wed, 21 Jan 2026 16:29:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 6/6] test: fix trace_autotest_with_traces parallel
 execution
Message-ID: <aXD-9ESjPNWznocC@bricha3-mobl1.ger.corp.intel.com>
References: <0260118201223.323024-1-stephen@networkplumber.org>
 <20260120015759.301155-1-stephen@networkplumber.org>
 <20260120015759.301155-7-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120015759.301155-7-stephen@networkplumber.org>
X-ClientProxiedBy: DB9PR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 0708b716-2787-4f59-b57f-08de590a4993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D085AMz/YceC/p7vfADNj6m1hvP9p1pXf8Zs68aih2mTbKI+aOUanq5l9Qk3?=
 =?us-ascii?Q?bbdHRieS9EpZflcg07/U9mCM6bb4pDJLFCMV07d1/Bmm1Z9A/9+lghV8/Ghx?=
 =?us-ascii?Q?MAIyMXhGYTvX+4Sbv83H/A4+dNor1aURqh3Ma53MBLf1S8w8RINkt3LczJuQ?=
 =?us-ascii?Q?LtyV6eOmH988Dx6mXtG9HvMWEt1fG38v8Dc7EoCQ9GJWNhO0T26GbjEz9ccA?=
 =?us-ascii?Q?bzrZbulBpVnQyo+4H0Cub8fsEy1Y2xoYmBAC0FsLba8zvDQ/guZfpCX8b+Gn?=
 =?us-ascii?Q?tn2Is2xeukFWTAZpLfNtufzt8emCEc7PjcomE3dtkWbbqTbjL5LET7EpB4u5?=
 =?us-ascii?Q?UPBuVx9dmeGvwUoE7qdLcFhXmNaIdhPifDB1vHf/63AyZsI9CjjXLMQqTzgt?=
 =?us-ascii?Q?HfGfYNxnFh02Jk8hhyU58Jy2y1rzenAkGV7bIPCT99Yf3iJ5/vUnW0mets2n?=
 =?us-ascii?Q?g7XpVJFMkYrvcMxsDvfnf9WKs91T7WO7QIxJXRP0I4DjABqpID2x4sHskhHE?=
 =?us-ascii?Q?oLUIra6oo2C1cCcN/injjce+sLjUiLCR+i7qHvD4MAU9y2IF1RXbSSI/J6Yf?=
 =?us-ascii?Q?voFp8S4nEBHgb9cuYu2uKJWHW0P3caYtoAGHp3Sx8EsMAUMFyLvLPELcx20j?=
 =?us-ascii?Q?ZbVe4/HRyJ1oBxwzYANwlIBwaeyvSq8sQe+Mid6/QDOIhwhIIqigwUR0GdjK?=
 =?us-ascii?Q?qGfJ/NHLZ+rJQcqR3Jb2c4MzP5Y4/6tZ6VgVFzJ9ohgkcnkTzIjeGJVsnoOx?=
 =?us-ascii?Q?DiBnAI750VSZ/0N3wJbv9fTNa2yquWyfoaFs1i/RmeRvqXS3E4HR+3g4fL4H?=
 =?us-ascii?Q?SSyU+T2IDngJ8m9Lc2yJWvCe33bwUkYvbNt92mLg0lESfPBfbc8bS8QjBCM0?=
 =?us-ascii?Q?eXVzJ3FdeFBrMbhoI4J1Nlj+xkKeujyUYDlbfcp5TtQxJO0w1gm92AwhiLuf?=
 =?us-ascii?Q?av8cR9xyL78gK8sAWXcTsOB+V+2pkWppnMIBA8H14MCNMnBGnoY7hFrQ2P3Y?=
 =?us-ascii?Q?Gz3moAppBeUAfRfBgcGhzyhoLirtIDmvze83Q3aPNybPPA29jcR/tQKar/yU?=
 =?us-ascii?Q?DAw7aZwk6mIqmsxR9+SIYyQ8cyAl3KnG2HGA/39yDOwP+WjHz2P1dlBiOr8B?=
 =?us-ascii?Q?4i+mZxUrHcBjafaO70KZhvLU5jKaQVJXFO40HdJTZLhD3WX6ujw/8Kt6KrrW?=
 =?us-ascii?Q?9oT+pbpsm5UraqBL9qpogyD9+COWeMe6MS7fHyDeAoBx0PObf7Zaum9bM52U?=
 =?us-ascii?Q?2YT+RpJW0RjOZbqHe8NE59bZz1SdJF7NsAqxmgj9Fs7YdC0CXqN2bx3MDARk?=
 =?us-ascii?Q?tGs/CG+6awI3os4HeI1M5BFmDDipi3jueAfX1xVOFgUXix8r83OnqJJHxS2t?=
 =?us-ascii?Q?AZ5a94M7mCVM8wfi7a+A3C6Cjj+G4h2ySCEtTGPSZ9H+btke9fAOeoELh70v?=
 =?us-ascii?Q?NlCJneHSjC9EmZ00Y/qvc+eLIyz7dxEFYvbx9D9tbMbpmH4LNNXPy+Xd1TwQ?=
 =?us-ascii?Q?Q5Twhs+XKTcf+kkuojiwiFBK+WarynLdtbRahgYjHbwtu69sobm1guQ3ehxU?=
 =?us-ascii?Q?+EpW0zu+h2IYhzTIUPU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hdUfiVm5fbYgKqeIDMLwR5WIiz7xhwWPHoV/c8Ww6dsdLf9s9yR4imN2Knhj?=
 =?us-ascii?Q?5oZsA4C1fJ+cF15VoZqfZXol3DUP0K2bMhpdb/FcrsRnWVRmiqi6491U/O0q?=
 =?us-ascii?Q?hZCdZ6oS7jqpUytcYRij1ylB5o7rNCxe785BpEEibHDzpwEHhhSeRGYMEd+v?=
 =?us-ascii?Q?kOgMwZx8Ix+HGgT0/Ts4RVrVomWdzyccqtigBbm0xNaqRNE+IofrwBRPOiZL?=
 =?us-ascii?Q?CGgenvjfz8/geJnAjt1OERBVqWEv4h8Jj+N6ETTYgI7GjA4/Fpwl4VcxvdNc?=
 =?us-ascii?Q?DKUkjtatKJ6s+iXXbbQai/R/Rj1/U7xXsz9jmczi7UEj17Qm4Ke1/rX2/uII?=
 =?us-ascii?Q?yJtmb85hT630S/aS+U391G3HTjGmxwbGli3FaTpw7n6CyCMom2tSS7FDuZao?=
 =?us-ascii?Q?agjxvlodwv1HQbYEmudHkgkhzvy9YgvzrhW1mHkOBb+CVNqtMBAC4dMwKVOW?=
 =?us-ascii?Q?Sco/t0z3NuVTLi3c4FBL0CMrNyYnLKhGIZEX4GwYBsKmYN3A7YAzWZGs1QnE?=
 =?us-ascii?Q?lir95zXsigFAXqisrd/aHJfy7xKfv9A44b3tnHDvwNa6h+GNKQG40E34VN54?=
 =?us-ascii?Q?q/VRAOBIm8N2wcmy4sI6esxB0WqiGJKgCGFoOr5QL+tkwDdeZQSCbega37aW?=
 =?us-ascii?Q?pUtoKw2XiyJ2WGCwNwnhEgZ2rC9hbGjk4jUg0RVqX8JQNFdYzJQh0y16uSe2?=
 =?us-ascii?Q?uXme71jnVXOv6W8axC5eyKFQ3SS78dQ0wLY5HrEgwvSdNPAK7qOwEFiU7/V9?=
 =?us-ascii?Q?uslOMET0chcTFJxHStXUrf1pf1l/RMRnGRPtxRlK10UtFaiubeVI3w5KqneS?=
 =?us-ascii?Q?U9le8/BZEZ91323Ec+tkj0i0l8DH932hLQ3a09vj1+mZBzOkFt82xjbf7oQC?=
 =?us-ascii?Q?+d5EFaSiO55xHUNSE0elsvI8kOjpwmzIsgideHq9gUvb0O9DMgvob/elHLo4?=
 =?us-ascii?Q?bdo7/aoCjendicI5z3izARoGh1lfkTEV9Zvh+C2nlh4KNWc1aYsVVTl/Yfh+?=
 =?us-ascii?Q?mHqKc5XNHcqywPsW4BiOMbCjDFD6/cDV3sxBaP4BtDhqvGHI9YmdEo3cATSh?=
 =?us-ascii?Q?XiJcVHNKn+0/E5j/+/jf+lUnSWtIIFairKppIIcplAW6bC6Z/6JxCi496x3k?=
 =?us-ascii?Q?PvDfq3Z7pkswFtQpLZXh76w3CcK4tCJHmvsyCHnpPNbcUZ1su+Dno5Sg4+tQ?=
 =?us-ascii?Q?8rmznsVn5LyxtMC3aQfU1egM3NdPJjirkWMiHUeMVeZQb0HrQ90lFRnisjM4?=
 =?us-ascii?Q?tb9+rBx9923Kjt5Wn8a5V/XLcCNGS6Ef0XU5k8C1eoRbOz/HJHaeCf3n75XU?=
 =?us-ascii?Q?p2QZKGIzwsxqcLPiCn1pq5bLP5LohrVPMnQjDM++ZnR84x4T5AFTgmQbgsaF?=
 =?us-ascii?Q?gMse2zcpgKJKqAjenlC8+C4G1m5cIUa18y15dn8iy9CZ/LvNNbuajIsFmuLi?=
 =?us-ascii?Q?ZyvrTCvsjkdPIrHGBmvWo3Bx3B3n4dN34z5r1o/g2dgms5LOb4d3b/GeBtWs?=
 =?us-ascii?Q?wLJ37KJdIL5IzKrn2PD1rU5AZG92XnE0lSkTi4Lvc4fC7zm2Qx0zQcg4QuDa?=
 =?us-ascii?Q?4K9zZwXeIY3BNpw+5sMLV9/fQ85oyyHttztNJk/IQb9OArKe05spSAA4wDTR?=
 =?us-ascii?Q?rkhiz9loodIsDFFwgldfD2z1Cnh/oKlkTthoZicfRQUoT6QYoYUEDlpnqgut?=
 =?us-ascii?Q?TIvayZ+uc+ofhpU2gQUGYSBuHeg6XsRqAOh2y/eNIYZNa6Rv0lAhVqnS2oBc?=
 =?us-ascii?Q?fxfhKijjxsV3WTBlbIzRSiUGq6+YJ6w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0708b716-2787-4f59-b57f-08de590a4993
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:29:45.4702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNAH0ehXVewtjNP/4lMPsbl7nphA8g/fQ3pP+owS8qYih2mHl+sWtKNkKMitG+fbXckQayuuYGevU0Jl3euqEEqkqPT9nQgxMPQd0gMdM0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7826
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

On Mon, Jan 19, 2026 at 05:55:09PM -0800, Stephen Hemminger wrote:
> The trace_autotest_with_traces test needs a unique file-prefix to avoid
> collisions when running in parallel with other tests.
> 
> Rather than duplicating test argument construction, restructure to add
> file-prefix as the last step. This allows reusing test_args for the
> trace variant by concatenating the trace-specific arguments and a
> different file-prefix at the end.
> 
> Fixes: 0aeaf75df879 ("test: define unit tests suites based on test types")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/suites/meson.build | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
> index 4c815ea097..fdc0b77149 100644
> --- a/app/test/suites/meson.build
> +++ b/app/test/suites/meson.build
> @@ -90,26 +90,33 @@ foreach suite:test_suites
>              if not asan and get_option('b_sanitize').contains('address')
>                  continue  # skip this test
>              endif
> -            if is_linux
> -                # use unique file-prefix to allow parallel runs
> -                test_args += ['--file-prefix=' + test_name.underscorify()]
> -            endif
> -
>              if get_option('default_library') == 'shared'
>                  test_args += ['-d', dpdk_drivers_build_dir]
>              endif
>  
> +            # use unique file-prefix to allow parallel runs
> +            if is_linux
> +                file_prefix = ['--file-prefix=' + test_name.underscorify()]
> +            else
> +                file_prefix = []
> +            endif
> +

I would test to shorten, and merge generating a trace prefix into this, to
avoid multiple if-else branches.:

file_prefix = []
trace_file_prefix = []
if is_linux
    file_prefix = ['--file-prefix=' + test_name.underscorify()]
    trace_file_prefix = [file_prefix[0] + '_with_traces']
endif

>              test(test_name, dpdk_test,
> -                args : test_args,
> +                args : test_args + file_prefix,
>                  env: ['DPDK_TEST=' + test_name],
>                  timeout : timeout_seconds_fast,
>                  is_parallel : false,
>                  suite : 'fast-tests')
>              if not is_windows and test_name == 'trace_autotest'
> -                test_args += ['--trace=.*']
> -                test_args += ['--trace-dir=@0@'.format(meson.current_build_dir())]
> +                trace_extra = ['--trace=.*',
> +                               '--trace-dir=@0@'.format(meson.current_build_dir())]
> +                if is_linux
> +                    trace_prefix = ['--file-prefix=trace_autotest_with_traces']
> +                else
> +                    trace_prefix = []
> +                endif
>                  test(test_name + '_with_traces', dpdk_test,
> -                    args : test_args,
> +                    args : test_args + trace_extra + trace_prefix,
>                      env: ['DPDK_TEST=' + test_name],
>                      timeout : timeout_seconds_fast,
>                      is_parallel : false,
> -- 
> 2.51.0
> 
