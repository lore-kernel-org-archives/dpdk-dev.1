Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE08CC28B2F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 08:39:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAA0740289;
	Fri, 14 Mar 2025 09:39:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5D1004026B
 for <dev@dpdk.org>; Fri, 14 Mar 2025 09:39:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741941586; x=1773477586;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6r8ZjDD9bW3stZIah8kTrJQtkagBEERuoKyjw5oU1Sw=;
 b=QJ+RoXJ8OBxPU5UiytgViaCPrtBCvfiHJ81n5NANYeec7dW7T9cO8T/7
 Gr+YRCjh9nIXRzuwJGT16GRDqx2Z63BqzY4PH1+1cNJaJyhhC0n2GRYMk
 Jz4Mp4OVXcXfR7Js3KN3+VDrFHIEHrs0vLdQnUUjI+6kUFEtlupD8sY1a
 K3vX7DC+CYaMqIQq3B2RbVbaf2izQc6dSkxiQ6s7rOSWPuxS9DFh6nog4
 2hppWJjCDk1Mcw9CBT1R/3MGtvQe/cSo37j+1y/AnvcfdwyzO2mo5tfkx
 WPt8oc76cHqHz5F3FsVNHGOZifMpAumzRM60kWH1L+deg3PXmf8VvQ/FM Q==;
X-CSE-ConnectionGUID: fBG3RpdcTEKvJM1Y2DWqMw==
X-CSE-MsgGUID: ecffbhfRQiqm8CcbR/xltg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="46874890"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="46874890"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 01:39:44 -0700
X-CSE-ConnectionGUID: iFxdAAjaQZmyFxv/FB7o8A==
X-CSE-MsgGUID: Hi6/VjDfTTibf7J327OdWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="120924260"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 01:39:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 01:39:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 01:39:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 01:39:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gN0ahajxcwp+YOUlSl+drtPLzBJkqzm1hCZMSg2oZtW2x1eRPDlwTsnFTSPKQFLxU1Tv3v/7CnyFw0SkMHXAV3EykccJTLu5kmBppKLQ3Gy/9RmUZO7rle7hBg+mH0tk6BDIS5IWfbI2FjwcLcSHBQetvz6ucUyBNHBSVI5qKaE0va3PAq+AKdf5pVoXVjZtm2/wnp3c4yj0OqWOT3yY605AmtLz5hGYCxv8xQV+8NIIMscTmzM2zklP4spIFs/v0nNEQLRMMtMG4YFbP+KzkDGXZvJ3fT2uyiNmuBk19CKIJX/K/4Eq17RLMMHgAOQWV4NNKK1Z7ylNesaU/KwTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aER0C1+1pXA/veSJvw2gqI3FcO6tN9CA/iiVutfQduM=;
 b=j7GxxJpllRJwpKPbWWASpBA1bfTK6YCiNk03I/jAHoBkjrhw8wzwfrn9uuD0i2a3LvuuR0rlKOQproW3OrBQJ+cHzfhGKMGhHd6sxZq6Y+pWMlIw+Xymvs8Ou0Wul8PWkHPYg2D6YmmjbB4Wz5L7zhE+cJRzFa247S4NGUUnTv0Qyr6yrzgnkkyqXDszSVT6CdDR1ARtdK5Ie2/2/h1H43EtWO4g/4hLH9EM3nhdiv49PMhH3jetyXW82gNzjntzctq5ibNsod+fkTPRGaPDzDL4nikrmQIbGVQOF/QVwI8M3lB85NJ2Z4+wCkWUWy5+eJ0AgD8ZsF/JDrTiLkhaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB8119.namprd11.prod.outlook.com (2603:10b6:806:2f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 08:39:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 08:39:23 +0000
Date: Fri, 14 Mar 2025 08:39:19 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, <mb@smartsharesystems.com>
Subject: Re: [PATCH v4 1/5] maintainers: add portable version of
 __builtin_add_overflow
Message-ID: <Z9PrN5eAYNB6r_tU@bricha3-mobl1.ger.corp.intel.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741896043-10115-1-git-send-email-andremue@linux.microsoft.com>
 <1741896043-10115-2-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741896043-10115-2-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DB8PR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6d0485-699f-4816-6fd5-08dd62d3b8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?39GTgWJPzwFuGQTZoQdUu24OcioL5woitW/tRhZqjZeAjpjju+UfmzqYNPsN?=
 =?us-ascii?Q?8YLUGlTM/RcmRCWIyw8BG0ARQRRNiQtdYPMBehnF0OmOKdyS6vaebTyAKhph?=
 =?us-ascii?Q?cCLyMjX1nrOqXEfRNjXx36099G6FiDnSM5AtAld4BGZ4X7uhRqhFRLbCv66m?=
 =?us-ascii?Q?PFhwEPQvFidIERSR4Oy79n3mF/p9swEIl9Pbw2votfN85jhZ4hJA+/LAeR5O?=
 =?us-ascii?Q?kgVTddpXOMzJ6D5W45Yip3KwyHIKxH3H0PhllOGL38v27JwAKw/DyAiUgoZa?=
 =?us-ascii?Q?1hqUdhsY1ZdIbvlc9/NC6pFkIkFZd/fD0TNJeAIgl2oXjJw7VGK1JKy2DQpD?=
 =?us-ascii?Q?e8w/Y2LW4mZG8s/2CoGgmVOwEkdV9xqQ2QXBP/E1Z/fe9kx2b+efCBErIxYf?=
 =?us-ascii?Q?swzWYDlUjov4OuBEKHksYVs945v2hb+2Ps7FuwLdRQjrpnWI14w3m37vVxKQ?=
 =?us-ascii?Q?4DZh0lJzPhBK+sMsNtj4pIz5HXACs4Q8E8uRwBK77rW3wCay8TJZA+XWkrxt?=
 =?us-ascii?Q?s4LR07K6kZrIXgj/HBj6m8/WAqA4NQPOBcMpkWt8aL+NQlzfZ+H+1tzovDB5?=
 =?us-ascii?Q?Gun6XxnukhKjNfF6r+M758uinZMO/5LywIsBpRyAGdKRGrvM6SvZute+8LZo?=
 =?us-ascii?Q?dqFqwQvGZDTzQjzNHZl3vWJUHFHew8gtPMg5ALmE2Xz4swSVfxmGgQ6yqZqD?=
 =?us-ascii?Q?Gy4IFPyPfR4bIhQaX7d2UYPyPI3nU49z0ZXp8Fm0MSK86B8UFCLLfRBKmw2X?=
 =?us-ascii?Q?mt9O5jy2i9II9r/+E/eqj0uyDca01rrLhyDSEt//Rqv7QbB95Fc3oioGYHt2?=
 =?us-ascii?Q?LkyO+wW8ofjLpNouFVpU4+FR1YPYuJd2XyXtQ27nrpG/YyvO7UJuybu/LjMR?=
 =?us-ascii?Q?TqX9ji71Q8/CJkRYAdLtZH25/fwKX7VOGLh5RmpbiTz2WrhZ3BcDz19YUVIh?=
 =?us-ascii?Q?8AnQYBL3KIrt971SDDNR0IkAf8TATAcnlbz9EPpzL12oCRSYb9ghpmo7qnuo?=
 =?us-ascii?Q?IaQxD/1apxl9a9DxuYxm+2/MsdwvRa2UxNqyUMghIOAyahMEzT4tMstKradf?=
 =?us-ascii?Q?NJoupgzhc5DyK4+mr/xD2n/MiJ6qPeHXgnUbnh8BHL1A6w+lTe7CSN5MHtnP?=
 =?us-ascii?Q?8McvTS0EyC52NYndjTiPBfNq5QELUkSyydNKDE1aMQvHKszpb7df0xY9fB+u?=
 =?us-ascii?Q?JhI29ZKcTJm6sVe4ClJ2yE64BgtGZSLcCEzTC2w27j1beyaGxjWjXfvo4Eya?=
 =?us-ascii?Q?B6q26PnWVSPJZk2LzPQMtP87YHHagaBkdNgzSm1cEgCIfQ5C70Cy55hoQr+q?=
 =?us-ascii?Q?bOV1Jx4ItcB0SBOdqlo7qO6XN6uhoF76HYhtykwoyzZwo3/X1FDWAVRdfRWR?=
 =?us-ascii?Q?JmnvlOqN3GBqdaJ3BoaeGwCAzEvT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IhVzT6XXo8X0FU+0AAq7fk9Zt6WMIzlGfI+eJRtsSw9xJcGUxvyOJsttXG3b?=
 =?us-ascii?Q?HNEKE9uvniy9933Zt0dS9yyWVifxF8sJyl8axqMg/sorQmR9D//sCkNQAA+G?=
 =?us-ascii?Q?mjPJE1a/aCNYO54rF1FTH3lr8M7EJZaL9vqbJBk+ooafWZgK9QVThom1TnfZ?=
 =?us-ascii?Q?o/1yslWdal3W0XDUlx6qmwDu/SNsmPfX9tS3s2QccdqILWD/9Ii/vAkvljOR?=
 =?us-ascii?Q?iaBAGh/9HRkDbveB3rt66/aS+T48vbVCw+3HO8I5v8E7EVh3zWcDZjgWaSsB?=
 =?us-ascii?Q?NE6fnJaBdZE1x1PeW7WNxF4H13EVDfD0p8If3ky5Baz5H0nh7s7+nL4Jy7JI?=
 =?us-ascii?Q?q6o39Q19KCpfZ16IlyET7XW4AsPg81gQGHNVGyc6uMbvcfwxKKfVE/Lm08zQ?=
 =?us-ascii?Q?Q1yJh8Tev1D0LVQp5He9CamcaCCBVK290YW8Zqgk9JDNJpN0YtORCHVqt3a0?=
 =?us-ascii?Q?ISOYy2oZfM+MMHWXfv/3H1dB6JLY4V+3sRoCGe+xUA70MdYzeNWGrEnP3cSD?=
 =?us-ascii?Q?Sp/xj/MkAHvuFNCTUqwLggIWwRBbGdJf9u58JruFOgFsGqTg8CB/tQlYdNpb?=
 =?us-ascii?Q?2qmF/G2Xn+KBy4cxG2bpspXKklp22sAiN3X3prjxauoaESIGIylpIr76CEc+?=
 =?us-ascii?Q?4yozl7Bftepj2z1YBTpyXXb8BCkynxA9dG8MOXYODrZy8io52kDHLfUtU01a?=
 =?us-ascii?Q?FADov37LuwdsGsPoQuhfASR5BgZJDj46xp8sTnjC3GB2thhxlasY00dvtYcL?=
 =?us-ascii?Q?7zCBoe9iMTDdod7kuwREouRsUfZLOuETK1TqwopsGV+FNgfwX1SUXuSMxPXA?=
 =?us-ascii?Q?Z1CMd4DV4joZFcan/Hm0ZtXTBmYvnUzqTbtaFJJe77M9dzXUSKHnnQJH7Hiw?=
 =?us-ascii?Q?Z6h6lwn0iVllm/Ic2Xlvg0chfW2trQ1Zg7gWH2YJPiSd0aT/XkrFALu0/YY1?=
 =?us-ascii?Q?gNu4XcRN0qcK94JHEhp+XfVB+CTXXq/EVl0TQFstAViKSrI/v4JEPYJ8vsIb?=
 =?us-ascii?Q?U9/6N/drVJEWCIxCFz31qrqa7l8Va+JzW5sVxSgy+ZmyqQ3D2wRcw9iVKpJ2?=
 =?us-ascii?Q?LU5MLxvDU/mbzgZ6hAP416vt+spS+y4p0tYhrsg16M1Atj54lN3oqmz/TVUg?=
 =?us-ascii?Q?xIzuwclyl3XlCDEQhyn1DVEtCNTJ3yC7P4T998wseZM8crNTXegp3G9d4Z0n?=
 =?us-ascii?Q?FItVZgEo8cR51zPZ2wfEpokwsnU5wOJmckPheiA2F22fx0o4ZWjsFidFuQU5?=
 =?us-ascii?Q?2kMlA5DR4bGZfT48m+CvhGd/L5YwlT8Qaga0nMSZmavS6R+F9DlJ8c2VZYos?=
 =?us-ascii?Q?GdiuUh6vK5NYhQY7DLUk+mAR+KtQV8ip/bRoJelhmYuTTQKpHpu/vWZ1olNR?=
 =?us-ascii?Q?nrZY8TuAMreIRPy8B5DPPLDpCGdWaeVYh0JQpvCdnL+qVITIqs1EtxI19K3H?=
 =?us-ascii?Q?Q2RoN8BfNmBd5U+4UqAPHKittjhPKo7lAXJDsws7k08HenY7sd5S5E0zExXb?=
 =?us-ascii?Q?IVmg8Hhc9qtNlzayNZ18X4WuUbSS6dJi671smEFKy707CEvAvGiu5+xGTed5?=
 =?us-ascii?Q?xF1fHibXtV3tvyIUGlorlCOep5mAXxi6Jdyqe65uXi/xn7dlx9EnkWbioR/i?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6d0485-699f-4816-6fd5-08dd62d3b8b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 08:39:23.4369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CB9muSfUiU2isWn3QPXZ3r/Z0EZLtuFyRLOx7fHCU9sRPai6bgi6qrWj/0VGion87Etva8lSND3xjB9l/QPC/K6Whu6w/DYz0XV992Wh0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8119
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

On Thu, Mar 13, 2025 at 01:00:39PM -0700, Andre Muezerie wrote:
> __builtin_add_overflow is gcc specific. There's a need for a portable
> version that can also be used with other compilers.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 82f6e2f917..a60fd0f976 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -179,6 +179,7 @@ F: app/test/test_devargs.c
>  F: app/test/test_eal*
>  F: app/test/test_errno.c
>  F: app/test/test_lcores.c
> +F: app/test/test_math.c
>  F: app/test/test_memcpy*
>  F: app/test/test_per_lcore.c
>  F: app/test/test_pflock.c
> -- 
This patch should be squashed with the last patch actually adding the file.

/Bruce
