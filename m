Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F6FCAC5A5
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 08:00:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F57E402AB;
	Thu, 25 Sep 2025 10:00:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id B1A674028F
 for <dev@dpdk.org>; Thu, 25 Sep 2025 10:00:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758787210; x=1790323210;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SMmLx8EYyTV95FgBoCTAmOglbCfL/BUonmdUnxH0EN0=;
 b=WW1Af+vGa4JtcY/F2J3OUBdKqPpFfgxo7nGiUk8EhkPI3Q8FJbZ+3lj6
 tiuuUuibug2+RhT0BiCu2lnGQF3owL1m1Ymq2qpGN2gd2dSDSgWyjyL1j
 GQgCt/0ALWsAugLZudlHnEK8JBFKaHou8Ref36lDpsn1Zmnls33HVVbuF
 ioUorfBDvEZz5SetOSQUnUX87BuaHj0GO/aO0G8ZRAWWRBwNL/EZtZcbL
 WfOOYihU+CenKwoPMmgNLbtp7m3EQET1y9hbwK7E8MFwHG+IGRlp6hNhK
 1aPQ3SJ/7fgE89LdFrau2pac9o+Gj7IuCy0w+1bfGvGkJdU7nc6mVhyOq g==;
X-CSE-ConnectionGUID: Dx2GxD0/Ru2uIfo4I2POWw==
X-CSE-MsgGUID: bGFq0NMPRDWFisW9ANKhYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61149241"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="61149241"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 01:00:09 -0700
X-CSE-ConnectionGUID: RmlyeQRMScCWM2v2M+VjfA==
X-CSE-MsgGUID: zCa5N+5fQjWtjnJXXUeF4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="176405671"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 01:00:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 01:00:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 01:00:08 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 01:00:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fs6jN4SdDTDm7aFMD53/455EDPZJ8f28tDuXua3qY8hL5uyZRpo6O/Cofl6eTmOuqUIeuLZj4I0Oe1syPIyKce8R+hJdKXVOx5Ql7jgwQC14q4JL07FIEy21Aj63PDQh1F3cE39ursfOhK4f6oxIyO6qu4NxgMdcCyGfj1IpDypEKwMd0ogVAnbmf1ZWIt+J5XVyJ1tL/m6MvVP0i8lndZ/JA9C5cN0wx6K93OFHitrm6gXfRsKTppJXCBfK/Bh4kXD5XOBPMQGbZ1TEh0a/hWzNEZhATHpJhwjE7tnBpTsn0r8iq1NweEBGa8CbL31TFh0q/wBnUsq5MP+Z9xF8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnbs46AeEocAoX/5W59Web8bsG7sAxixHmK8aYjkX/k=;
 b=c3a5dhFHAHrYxV+rgBK5Uvvpx5zXN82ZRHXPfi2FoiV02w20j6bZAzTTgjv7o33UxLAZUC4OxJXsm7nr/86G4bW96qxShN43cL3ay8nAXVgVXkbuzFSJBd73i1tR/TdtFN3TMikQKhIgFFXCPvYKlweBgb39cnoyeN+jop2/gmTiHDfmNXpH9M0SEbVnlXU1nzNwI87HAq46GVnCAGk+kc3zxXsJ8xubd6rLoaqbkvJlft3jfOC8IDQZMJYR8ISPwuArk+N6HLVjnZYldrPcS3zlnnvXHAIVISjNTaRRPKziALWdO7/9obEWwZIggx8EVfUiM1cH9b7El/K55s+Syw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB5985.namprd11.prod.outlook.com (2603:10b6:208:370::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 08:00:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 08:00:05 +0000
Date: Thu, 25 Sep 2025 09:00:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v3 6/7] buildtools/chkincs: use a staging directory for
 headers
Message-ID: <aNT2gMD4BH44UB3i@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250924172536.2447183-1-david.marchand@redhat.com>
 <20250924172536.2447183-7-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924172536.2447183-7-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 916034d6-dcb9-425f-1e3c-08ddfc098983
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MkAJ6Y3J69SIuxm1dfD9fwcie7r5BM8/tM8O7wbyMoTPgUcY990YjfarivVV?=
 =?us-ascii?Q?H0WeEPeD2V0wnljE6BI2qsvUlKEAuLqOBb4tZGEbE9Cu232PwWhQ2+bP3GFp?=
 =?us-ascii?Q?mcr3TOUqgLxsghAftd7GDqne/ZSFcCY0F4BH3ztnIO5zjg2KoB7rY40xojup?=
 =?us-ascii?Q?qIVWXIHFSdjZBIoUO6dudGw2eXgkxci7u8rrvOXUaXwMrs6kPflYQSfqxepS?=
 =?us-ascii?Q?z061BTjNeU6HYHYgil8oaDIli8ps+m19/DNdfWLNsgJbmPA/LAffqzuMHJoq?=
 =?us-ascii?Q?0lNW8DD88wX/06X98pH1J2fhYIt8/aotnIPPU1nWopY1Y5IR2bXzCtLXtIOP?=
 =?us-ascii?Q?DQQ3XjEIAH2Y4Wv3p7o3lmbEYuBAge7j9dUCu0M2beLOP0n0Ug+jMaiqFdQk?=
 =?us-ascii?Q?btJiKCbdixmQTn/sgCOfWMRaM4ePIawr7kO5JQAp3cwWt1PEImyjbOhOVYVr?=
 =?us-ascii?Q?gwecqtgYwF4fLCeIzevuU9F8ofLskB5Pp9XvZnwJ5TXfE4z7+JgoRQpEZWlZ?=
 =?us-ascii?Q?t96elnAD8a7iLab9dygwoB+2WCaukDJHvvieS05oz19gzYRW5qVX1IBHmaVk?=
 =?us-ascii?Q?+nkCPcKhL+XLfSPHzUMWemtaotPN8zGQjfGqGMsWz11u8a/ykTxTBtRGK8I5?=
 =?us-ascii?Q?ZaL4LZsQ/DfLubgmmX6g3BRYmp3583MPywwD7o590sP0ZxHjMOc01pagOrj9?=
 =?us-ascii?Q?2TahAB4JINIVp/poZqbKZ+6peC2J6eI9AydpL7uO5t4/2RSGA/hgxLYbaNTq?=
 =?us-ascii?Q?nLHMHfrWpRd1pKTgSDN62QDUFrtlwpXTtVH43NPPTr/jD3SYbJ6W7dQfN1k3?=
 =?us-ascii?Q?yrAvK6mgTFxiOKIuaB6w7J7eAQrQwqCmPxVJwa3/TNjZnn6gTNAB10Cm+IMR?=
 =?us-ascii?Q?Um/P+G8iKRcfeJ0bnU5iINuYPEvQA0z+xWgCrVp/XQoET3y7pvz3kG8wsD3N?=
 =?us-ascii?Q?slcfrF1gmJ237cRIxtTkb0izZtvVyMT8EhMVBW3S11X03aSlbHP60MbY+ief?=
 =?us-ascii?Q?s6WfYhidR9mDEbbKnQwkVe7L+aOdP4LSDlSGJiDfcfXgk9lobx7vuTobZoe3?=
 =?us-ascii?Q?uLXKZkUDD7BjSC+PTtWOFAF+DxNnKYTkZMddR20K+hJ11ew+OT2Qw2S3aTzy?=
 =?us-ascii?Q?IV1oV+0DbLQa5Cgx7hcQsPBOIwksT1EoWMk5BzYlFYB8CSfPqvrQfdCxT6hC?=
 =?us-ascii?Q?h2FlflZ+GPldE6DweZ2ZZ9fYlcZGZnluaFYA6M0mC2RQ9XRk9Xn2FXzCug5/?=
 =?us-ascii?Q?8P6O+ESsCkl+pnIYj8vnzF+3v3PQKh/eaoDNaRxEdJmjMi0anisOBdUqnjvR?=
 =?us-ascii?Q?AOSZ4ADiZzhJfZ6A8CnJc/QV5emSPYV/BUwcNwPhuNhp2zCyttKRIVGy41cv?=
 =?us-ascii?Q?X/xNX7GOsKYc8PH++zTNAeTYo43KI/tk4NsjKbsClVj5dX6gLAy/VjK7rCKS?=
 =?us-ascii?Q?z0RXblIaUc4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZM0UkpBXajyKn3K7d51uZYZLUIuJzGTYWSor8d1B/JvKQTBnj2bBib/IRd4H?=
 =?us-ascii?Q?RgOtleCMezlf743nG7cmkzu+BAvnYFyqU35h08xzxoYClRbQnU+3xPW09r0q?=
 =?us-ascii?Q?3u8NtE6iofOEwVOwFb/ld8esX0L5rzpA3jIEPx743G8YUD7MzoP+ynM7B+E7?=
 =?us-ascii?Q?TPq1vZFCY2k6mwemS+0Up0nwSqociu+MKtR4WazXG2adaHsTaG6lgo1uskjM?=
 =?us-ascii?Q?/gaQT8pYFmlo+PTFcKKqU+A7F2hCpEbL4tsQoHBfdRb85TnED66zLnK2+uZd?=
 =?us-ascii?Q?oaNDCbbAJqU+e471BMF0KPN0mRQmGGQyIuBCQ55YMzk+Cu/Gqxwua5OpXxQr?=
 =?us-ascii?Q?YnZddtmztuc4yGZssUqhK7q/2lRlZrTJ0tjSI+5sgQKzFGJgkbUB/Z02SMBq?=
 =?us-ascii?Q?+jMmfMalxFGTvKoPQj9XGZf+35SdOqz1lMh7hKkD7dF7HLCc6dPdzULZmw6M?=
 =?us-ascii?Q?xIjMxYwrCGgkcE879jPhsBUcSIwmY3KeD1h0FpQYMRHBC+XcLJE0XpwQHLzl?=
 =?us-ascii?Q?xVGDDbPyRUpOMMU4O10AO/yvk254Pc8wP5hX47LVvCycCPD7zvFreKC4tVne?=
 =?us-ascii?Q?aQDeZbkgRCdMMBeIbeu4EAJTog6jXsUF1bE3blfU0ZKlw/isX+VDPAltTtlB?=
 =?us-ascii?Q?1YOGJWOUE40xLDvknv+59wGxKoJGd4hW1GXa+vdKLs8WETO/w9I2XP14c/DJ?=
 =?us-ascii?Q?6GvKbDSpTIWInGCrrWvYvKD5YsLEMRuV8fnnuDJ7aeZ3Mn20V0mQm+bA5mqv?=
 =?us-ascii?Q?ItJ76OSOBAkMOzzrOOD5wUILYHdp9V80qAj8BXOl5Z+R0Lx4eps/NrrsX8Bl?=
 =?us-ascii?Q?CYaNvmQqPCeKHk6Uxkf0jTTGIl56bgIzi1n20xt/73qZYRYLWxiyo2d07O8O?=
 =?us-ascii?Q?s7WpXMt5hWKExGxh0xmmCZnkdqdr5XxT0sFrpNJxTQCXDEgXz7Pzjw8gvywd?=
 =?us-ascii?Q?bOCGvDY8M1Pi/P8cCQhErBvLYizj/GPQnh5/mdfxZ5yfMVy1/HpW+sF24R6n?=
 =?us-ascii?Q?7GKiEhKC4pPNn0FzDRPzSTf/Wshf1FQSyAqY0M774PBG0lr4p8ZPRrDjOWkv?=
 =?us-ascii?Q?CRZvfgTFc3XFEVdHEuzAS6odfvtb5uyOcDG4qg1UlZ1uVFdcx7pIQAag+n0m?=
 =?us-ascii?Q?FMBzDMlJFWeJGyPbIb8rI1St1//2aKSy+yMIdkpCDJOum9ye4D+KsoTfC/T9?=
 =?us-ascii?Q?ksbqpKXjLPw1WOsONGMy6Kvd4gDdY8NRsuPzVno30EBpGdWhiLDrR+FxZ6J7?=
 =?us-ascii?Q?8vx7sMBfoLIG5BKFLTP7N1OGyJQewlA+EXpSezMXAhQ70qWPB7CjI84ILgqU?=
 =?us-ascii?Q?aS6wsFhdBAc2mkj+q6MPj2sor3PXqMLCJJcXHI7OBmWMuhJTMlR/E2yZptYc?=
 =?us-ascii?Q?atq0AjiDbrEPCWJi3UhB86VGJU3Eu3iJZGpQIVN8iYX0R/3GPKRwTO5XceIY?=
 =?us-ascii?Q?E04zXbFEXT0iv24skAXgH6qj7HrIEM0sbbidufgbvjd38p06+EBUNbl2hSN7?=
 =?us-ascii?Q?L1JODN2P8a4Z6tR4cFuDX84SQTSrJia9wMGb/48ZLIkcoC92ttRwBPm7jR/S?=
 =?us-ascii?Q?1JKgcUQ6BiCpO5fz6+gmRgyBLPIZrXXOvUmi+QtKUS7KaK/FsKeW8pyM4WxG?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 916034d6-dcb9-425f-1e3c-08ddfc098983
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 08:00:05.1199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++TXlO1SSMvPABczfY/uGVVLPnIZ0aQUaQUqThyPvtW48vISaDKeG+3/0252xvtaZYYHJjYkN0JLnYT8d7YT0NR5wfO+81dOQM6rPvCImig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5985
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

On Wed, Sep 24, 2025 at 07:25:34PM +0200, David Marchand wrote:
> A problem with the current headers check is that it relies on
> meson dependencies objects that come with their include_directories
> directives, and all of those point at the library / driver sources.
> 
> This means that we won't detect a public header including a private
> (as in, not exported) header, or a driver only header.
> 
> To address this issue, a staging directory is added and every header
> is copied to it.
> 
> Drivers and library headers are staged to two different directories
> and the check is updated accordingly.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

In general looks ok to me.
One small comment though - can we not have "staging" as a top-level
directory, but instead hide it inside the buildtools directory, or even the
chkincs directory? I dislike having too many subdirectories directly off
the root of the project, especially ones purely for internal tooling.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> ---
>  MAINTAINERS                    |  3 +++
>  buildtools/chkincs/meson.build | 41 ++++++++++++++++------------------
>  buildtools/meson.build         |  1 +
>  buildtools/stage-headers.py    | 32 ++++++++++++++++++++++++++
>  drivers/meson.build            | 28 ++++++++++++++++++++---
>  lib/eal/include/meson.build    |  8 +++++++
>  lib/eal/meson.build            | 10 +++++++++
>  lib/meson.build                | 41 ++++++++++++++++++++++++++--------
>  meson.build                    |  4 ++++
>  staging/drivers/meson.build    |  5 +++++
>  staging/meson.build            |  7 ++++++
>  11 files changed, 146 insertions(+), 34 deletions(-)
>  create mode 100644 buildtools/stage-headers.py
>  create mode 100644 staging/drivers/meson.build
>  create mode 100644 staging/meson.build
> 
