Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95519E81A48
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:15:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED99E40608;
	Mon, 16 Feb 2026 18:15:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 2B9A840289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:15:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771262103; x=1802798103;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vm5Vs0gmUsoglTIXXD44ZZn6G5H2zjyGEeto2bhA8dg=;
 b=Qec07N6+awk0OL6hmuozvT4nwv3C6uS/ROBqZ+iVKYs8Yb6kA/rboUDq
 5boVYy3LlE0x1wSokmtwI9aPqB1MagBZ3VnkXDj3NEV87Z+KxZWqCpqoX
 q1RcyzZdskINZKvRbie8abNOT4dMoMxLYx3zMCZI/0G4abJw1gDW9W676
 TuKgjhlQZsXfcsomX8Hp9ddZOYqPC1nDLNK68V9doQeSqWuaZprIxwhmT
 3I3ekLuhnPgVx1ouS06mStu/2Nuv2s0mSqMCLRtyU0Vz4GI4JzyIqFZEo
 vH4nv5PK8Ldp6McAs6CzDfqk6HKmEWipJMFda+rAOzfzPM1AW2k5HH4LY w==;
X-CSE-ConnectionGUID: 5isYnJ23RHSMaiImtnODqA==
X-CSE-MsgGUID: q9LDBdCKSyKkWStTRE17XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="94975712"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="94975712"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:15:02 -0800
X-CSE-ConnectionGUID: vhHx4HmsS46ya5SzhJiqQQ==
X-CSE-MsgGUID: 3ODmmzrZQimabhx8NfxrsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="212966077"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:15:01 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:15:00 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:15:00 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:15:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmOauw+uh/VtG7WYEDswYqkCgRaWR/w1YSNUCVe3m/CEw7j2aqR6FMg3OtcP/MhJJuBFtBFyzTKS/w7xlc8V4hOrjznI88vozm+KNhV14DWI86Sx843T0GJw8UU1wwHgANwzfjkFGvcw8kTdR3bkRYti9IRVGRe5aw2NtrCMjg6oBz65R0TnIbFmS4W/T31joWYHKVsZ+x5hrcUlkc2kXKnnk7PsfDZum2iiMJ/ctxBLa0Jn+3CkiFhikk33MTbewYFyWOUldn9tCZGf4ogQtWUZgJ/ZFtW6A7K2zRmozaAAfgALlB+YalC5GOz+wFXr2GSSaVTtq2HqJL6PTNTP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JI83jNQ/mCEmBcdHyNqYLWU8y1BOAhJF1vVvBye9neQ=;
 b=thb41vwTV61ywb1L6EqCoikq1YIvNtEhg+dVLTahqxk+XfQSOnXpKe6xtsfvHd/u/EpqeQ+Y8TbJoJRF9ooxlGYiCSebahwWCJfC8+6YjJfXSZlLI7OWwiC0e4DYzNCkCipWiG4n1WZKX+tX0p+VJqA8zuDh2STR8CIxnXt5B8X1GZyLSW+NT/HpAndIayy3S+iKshCmIxU91Ng4Ik8+7G9CtdMGCDCiViVVQuHo84GaaKQcobzIlefI2ebKV2WTUbpe4DmYPm1Jy1OZEXdkYQQSaELudoPVPGMnwGfwnR3vN50RbSA10i7n8ampLiMVAT8gW1GLZe0xXmSpepInpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Mon, 16 Feb
 2026 17:14:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:14:55 +0000
Date: Mon, 16 Feb 2026 17:14:50 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 12/27] net/i40e: avoid rte malloc in VF resource queries
Message-ID: <aZNQih31--qw3ppF@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <9ff371b33023fa39e4c61774d478fc62c6fb92de.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9ff371b33023fa39e4c61774d478fc62c6fb92de.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eaa0c12-b858-43f0-8967-08de6d7ee76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V82N5QjV2lsnJAf1hhtqu6kwqsYys8096pcUs97uqgww4Xis/OZPEQRmsl9k?=
 =?us-ascii?Q?8u5B8OkYOBMOzW3kxXw4n34bapLf8BeZ165He9MiNvwJIlhXh+rPPHujlWOC?=
 =?us-ascii?Q?ai8bCGsGnubhvPAMQXymCBIuXbawdHt8xsI7O3hMwcoGePSnNpW2xsGTyDj4?=
 =?us-ascii?Q?+s1O39JyG4tSET56sh8m+D7lEXVdcEcx8nD6lH+Oxj3ZUF7+1xAFfXqMEB1F?=
 =?us-ascii?Q?I55chw07jRt+ZixDd1AJpwt41KGHD2qaQe3bFkg7cTABhe95RM0bymxqMtVs?=
 =?us-ascii?Q?QzMdJqfsuVeU580jqQ8rbhWvcsRf60JqN0qphdX0s+CKn9w6ZJVfg9xuHi2O?=
 =?us-ascii?Q?KauGoF7fQ4s9aJL/7FD8234LUifc2MBr0bOLmuMMFOWp/2swiprhXvjV8rTk?=
 =?us-ascii?Q?UIr3r1DwL24FbmyMjqxXlFwvU4IeSiShGpnmJd0x/DGXNmpCpP6WlfvKCoin?=
 =?us-ascii?Q?APclNQyZFw8Vol8ORVLqv0on5U5dI0yewEKaQG6/lqdbyZjWx1kfI7h3S5BQ?=
 =?us-ascii?Q?l02SkW6rTVE6pwz8mqoG2xZZQfA1DgNaDxRV8kzM0uA/AhB607QG8fBNaJQh?=
 =?us-ascii?Q?v8ZwklGxwUc6B8OTtPR1+iHiS8pHFXJPG0YM6rXqv3oT6Jbbqit0TQ20MOAe?=
 =?us-ascii?Q?dUmj5UHRfD3z2fTzbSy0BpBQONk/bV4WPrRtSdfzy4f2LA3wp1M3JdWxB3TR?=
 =?us-ascii?Q?gTSdoG1V7kcAl0bsXMnhtZiVRc6TRgqs4wxEWWDm1ET5iofmHbZB0jWapTTG?=
 =?us-ascii?Q?QAR3nOwi9pg7ZL7KDfFQGzMPF8zAaGoeICJzSmU3wzsl14Iih9/o9fJNX9DQ?=
 =?us-ascii?Q?Tht2OXwDElWTjZ1P2JWpqo5IuwddPwh3c3azY6ZdmsnyoiW/xBFqmMTeEQsr?=
 =?us-ascii?Q?1x8HOu4EZnJKQhFrjI+nBnQNzDXL24KZGsAX8/GNdT/ReBVvzIk2c3lynepW?=
 =?us-ascii?Q?q6IKBPfEndRbmZXirNYQ9+DRHFhyGUUWnRaeS+82lSFxTwxMKkRfeAEigt4D?=
 =?us-ascii?Q?b0bu1qFouYWBOVAdwFq5iifWnpRaBf9DRLNLk2dIxZ/IL8ew2YeJlqPGBP//?=
 =?us-ascii?Q?OlMfOSH8Spe6qNBZB2NoVmvFWV3XtRj0lEmUydmTlMNn8PMA83DIs3/3lTu8?=
 =?us-ascii?Q?xDDC1cs/QxWBvHkB1ZHaV2OkzMCxtlTq3mniybRUSQC4EnEfNmG3pjRbCEvr?=
 =?us-ascii?Q?Q3FFLXG2U+BBqUS3f0bk1bCzfb2Sz9ltMjzQ6soo4HzFIWc6h3FfKSSUcoUT?=
 =?us-ascii?Q?5bSSqPx9rNqt1gqa8jrw4yHWPcVm9sXHxS8oFjZpZrPrUSiz/0gr9XqhSqgr?=
 =?us-ascii?Q?XHQMyFq/fVZbzjEWmNprYztXyzX53JYNqYZkq8oEpTwEGHImi74fOo4r/hB5?=
 =?us-ascii?Q?w3uHMzO4ZbT6GGxeY8w2PMI3ZHygPAuJ9FHiFi1K+XEN6EITmtrOqRvNdqn7?=
 =?us-ascii?Q?/75noLpX/AWbzQWkZP1haSQzwb3mgbtvf2Y/Dxrjm7djDizfxQnlG093KnPy?=
 =?us-ascii?Q?Am+ZPZp6HOvXahTBRsLTpe8oDR4z+ErG0noFszV2RQxJm0oh2IXO+/qzU6Lq?=
 =?us-ascii?Q?cO5pBVmwq+MFd2oWzGw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qGjREv6hCOH7xWZUcDJkt5SFU9AAVqlli90rs0pnvvmW0mcTyi7fHfpQtNid?=
 =?us-ascii?Q?/C1l0fKEJXJDZd11MXcsR9Zo0CvbWvNwIsVQoWIY8UDfMnr84hdoWmWHfREL?=
 =?us-ascii?Q?sHRwizzwsC3Ig4b+W+J0tvudqOIKnTehnxAzEh+nDEgGgHqZ6/w9ysTpGayj?=
 =?us-ascii?Q?9QEBWqFZL9L+IVp82aicVj9gIPuv9LnLOzj3C/5ZgXR41xPlasI3RvjQgx5g?=
 =?us-ascii?Q?zCQxpvpqOGILlXBnLy2zpQf4nb6pBusewrbpmoCKmoFofX6cNDLUCEH5Cm2b?=
 =?us-ascii?Q?0L/bSpyak4v07Xw7uyAF/sa5R+paZLi0xrn6iaeWunS+hPqfHq/1EmD/1ahN?=
 =?us-ascii?Q?GS3dlKR4ROWVNptvsctp7FI+O5RhSIRsXkDNvYqzpIx4fzI/5Z7fHHMTI6Al?=
 =?us-ascii?Q?HrHxdlHvZoEtbyHHF0CydhqkUIjidwTXF/mu3uEH/LdhuB7hxLVyydNtFj+V?=
 =?us-ascii?Q?rJ7PvgufYu2Bkpp+PvoHVXKsNX0a5AzNhhtyukS+1597tKjpzzKm/nl1wF7z?=
 =?us-ascii?Q?ut3q6bPATulQyBONpj45XQ7PGaZOtJuhLuws+xzLenB5CAxZtrnQRmSQnMV/?=
 =?us-ascii?Q?f0fDRetHFrQfS1wVDYuBXfvIXCmyVI3QMoSM+uCtyiUgvu0xvjIDx0JzulwL?=
 =?us-ascii?Q?mpBx9+pTLchDcxiTuak5gzNdLcJz3nmHO05d2uaZi1xjltlswazj/Ln7/Lvv?=
 =?us-ascii?Q?/NtuYkMr1BSOBDkTWLlNt0UEmqkuPUZF+Czp/PKJH+vKLGPXEyvlCxJ1p0LX?=
 =?us-ascii?Q?T495hTftvzFL4kIsnOJ42m2dx7XE/YWAzFjXj8I8VM4nC6z7sCbqhP2iHfNT?=
 =?us-ascii?Q?X+IUG72mY+lrGYLd+B0PbmchUNVMQOIXuEoPDv/Uij2yxbt2C/44eDm9n+yS?=
 =?us-ascii?Q?PrKkAVMFQgKzhn82aRI2QmQqQRjf8U+9hTVVTZeI85s2I//FoEipnmmrf2/0?=
 =?us-ascii?Q?0+nP1rq/yYDXghOWPKZtdgZDn+LRUTiDRW+dfwYur5y16r2rRytWGyIxGa32?=
 =?us-ascii?Q?vBMZBR6EwNGkWKd7ZwDJpXanmzEUjOCYy/uxtm5SKPDPxlmhfzyWC2JmHIfH?=
 =?us-ascii?Q?0O8Ob5Q3ABGeXwbQULoZ8/Y4vxdNNybIhRv0VCkwjaWvcWnaibDFaz2pHwfR?=
 =?us-ascii?Q?EpElCl5CybN2gOg1nqTfo7njEGkAYbb1Wwz+lwzylmaxejFdDxfJfgkoZNKF?=
 =?us-ascii?Q?Dt5GV7SIrr0lLU7Q2NVYqdQc02iBwDk/h98pjf7NWtWeqSGIrlZ/AUHz9W/W?=
 =?us-ascii?Q?LV6ithAgE4kNFkA3URJJChJ/HN/t/rM5+wpZcJh3SBXqAHR0oH2SLj0UP2JO?=
 =?us-ascii?Q?aFK5e1DqQcoXhBN2IKafVUcW0UAHt2mymDuCqB7alvqT70Vyo4K5yRUqLXhV?=
 =?us-ascii?Q?BCOI9zS1AktxfnEtMUrNoE8igsThb94AkQlAHRUvNdGETya8eO7GKg6INjyX?=
 =?us-ascii?Q?wOHDyjIUpEScBM1W/qFGLM7GUE/KClmobKv+TpyqV+0Cl2YSxY1mZ3Xh4krs?=
 =?us-ascii?Q?Qha1Gdiu6f1P1oJmMn3YjZKoSqmCNQGBzUN9Up1XCZfOUtR73VvO9sRPpmrM?=
 =?us-ascii?Q?GYnwwHa1Xe5pISVX/wemjh0JMj0jVIAcCf7Y3wTM5g38cv7vx/Zb9byRrCIX?=
 =?us-ascii?Q?kRtk4c/lwFwQN1fYAr+lMeL6KbbVrgm8/7mCHTRuhcnmONvl7HGM9Qy0ZDpJ?=
 =?us-ascii?Q?5zSr3qOiiBnDMMF2nod6mEDHCU4u4wjPq6WxsphYsbmkMABL97DLP2KUy11r?=
 =?us-ascii?Q?Upr3goI3Q68D/kwKgcizokH7IGtR4p4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eaa0c12-b858-43f0-8967-08de6d7ee76c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:14:55.1099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mR1jI3FEPm7WsRlAuegt2HcivHQdWXfGl9c8gOYoupgb+N4SGYu9KBmzX8IXADdfIoQNttr6HZ4jWYa9Uamfw7swto4YIRIQsk5smtO7z+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
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

On Fri, Feb 13, 2026 at 10:26:23AM +0000, Anatoly Burakov wrote:
> Currently, when responding to VF resource queries, we are dynamically
> allocating a temporary buffer with rte_zmalloc followed by an immediate
> rte_free. This is not needed as the response is only used temporarily,
> so replace it with a stack-allocated structure (the allocation is fixed
> in size and pretty small).
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
As done on v3:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
