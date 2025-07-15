Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0828BC83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 07:43:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE4A14021E;
	Tue, 15 Jul 2025 09:43:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 493694021E
 for <dev@dpdk.org>; Tue, 15 Jul 2025 09:43:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752565428; x=1784101428;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TjJ7mzNRkWCPwIuIyRhDnoI7wdzewOTV9seQkaHQBkY=;
 b=f7mKRxwYMoHpxCFRAZrvUdY1yLCU1iLn/9mnzhMp047T9+/fYlpgRjm3
 84YP8RlifWLsf5IBSXJKuDrehfuhXejo5AzeiAUPCL/orYGRZJ7cLZMVK
 4bKMFOqZvvKEFeO/k2aGMQMqjR5C2gO9fJLwuTmbBthiLhanpYFLfI+dC
 1ZHd+tooWLzuzWYJBJbBWbme+Zna0+nwx8n/jYA2RVCm1Nsfhvf9I/Acz
 R80tkGrDEfF+RBCsrgKyhEOEPOZC8Tau39GhIaVvDN5GxEhGF8LHwU+DA
 JZrWsBeZ1KQH8NhEXDl8APno0wz1wucLwbnJEkwhwvnqIqYPnZGOb5eqA A==;
X-CSE-ConnectionGUID: EL2DEI96SMS03yWYX63rIQ==
X-CSE-MsgGUID: wnyPUktQTEyev5/4A22wWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54710938"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="54710938"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 00:43:47 -0700
X-CSE-ConnectionGUID: eDfyy9L2Rgmpq5knnqnj4Q==
X-CSE-MsgGUID: N2qHQydeQmC85kFvSw4s7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="162701110"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 00:43:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 00:43:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 00:43:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 00:43:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eicXJB3K0u8TG+h3hi3ckCgOjdBzhW/A5aiGQFNkAGvYKjq0zEXiyQJNG3WJVRnuozSLb2jHsbIN2FsqrH+IjNWvgYvmP4be4g4pJjeSShwP+/G9Ji3gNtQEedFmozHRYxC4ic2aHXnvvSAvRb+Hy1tV936YYCGWOINa/i5dHiQL5iisivVW6fIROsDhZpiJ3BRkurGFkkS/9vtLWZ9pII7iiUSmeDKRXyYQEfA/lawvlX2Gcu5LKoWntHLEZUoFsZs9rY7AoB4Sy5cVZMXds1MD26EfLzo0tcRvDK/2f+ROiS+GRCweNrLE0zUOqYtTGnUFx1u9XX6iZCZwbJOdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCBvKa/wgy4T7ZWCvdJ7xm/1AE1ta8QgwVCOtBuoopI=;
 b=qCdtadj+j+fdM2Ec1pkcRZa2Jxtvp2K0nNFABXcRREtUyXvcPDdCHjoij7HByQSLDiFKpxTykFcKvwXHaL+vCbqg2CwawAXJtZDxrtoVGtTKEmPEtElJoWZDIFG5J4cwhfkz9WfTKaYVvTCmeztEphYzZc3jtuDjYelwqDNmxBXtYDU4A09YQ5R4kZo9BtkUXol/1xF7PyLTWqcl6M/koWsXs9HxyeEVF+dtLsc89LW2SnZL2xzVFiBsZKK6T9psOtLpBK4QDukvA+rKzoam4ddNSHMQiVMmOa0+d+biqkzHB/TrVIFHDGxuiM22h5Tt5PcVBt9lgYncEYjobxZTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPFCF54B2894.namprd11.prod.outlook.com (2603:10b6:518:1::d4e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 07:43:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 07:43:01 +0000
Date: Tue, 15 Jul 2025 08:42:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] mailmap: sort entries
Message-ID: <aHYGgfH-nqaPUxtP@bricha3-mobl1.ger.corp.intel.com>
References: <20250714204516.255880-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714204516.255880-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU6P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPFCF54B2894:EE_
X-MS-Office365-Filtering-Correlation-Id: 890a35b0-2226-42b6-46eb-08ddc373399d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gn+awD4KAtRmDizAXsoZCK6uj2dWj506UjBvjxGXrFv4hMAtJDVmiH3ciAkL?=
 =?us-ascii?Q?ljfbPRUAtSVO2w6si7swkj6XP/Tb+ji0FkZPjGpsOkhKtI9tj82KMmgAV2ox?=
 =?us-ascii?Q?T/mTyGusgDBhvcmOfi0u5obXIKgg3PFfjAGglo9w7HjC/DwDiLJfXJWpbUZT?=
 =?us-ascii?Q?DwWx/3NyGUHXzlgEh514jzRFjGZ9ZtZ8EQc1gxRo2lf1fb0oVGBQVtiK7Xvm?=
 =?us-ascii?Q?CAW6sI+jZLSXPWEEJUkWHDW6GA8jEDFpmMcnBHqvFgtLwdSDKmRiXagJKgyu?=
 =?us-ascii?Q?2oiqipvrxdq5j8JrHApKiGntc8XPD/XgllTLpPdZh/Yj0nnIgk1ADBWJYkdb?=
 =?us-ascii?Q?Jw1l5a+UTtqgBczRF7IwIxLdrUT/hxisU22+FNeYxUecgF8F6N8OVdkyvd9C?=
 =?us-ascii?Q?J8jUgeHd0/JyR0USQeahQ8csWihVtfXs5nMq32ktErwfnTWDotGzLvMnWFb0?=
 =?us-ascii?Q?KSPKE6xU8hcnhQ6Ax2TbX2j778MjlbhYXviY/F2TO7zKffn+J1D+xv2QSwu+?=
 =?us-ascii?Q?U4oHtOrQl56/V9fMzhaEHqU8DUthLRv2L9gevHlbhFMm7MgDV0qSXjiTCtnI?=
 =?us-ascii?Q?6S11oa2hBOa/qJynjU2N6Fn9AWDpUti7MDhyb+xFclp8lnURhury+4ea8+ik?=
 =?us-ascii?Q?z9ZZA9+YryAKK5uT7igZUM+vfQt9UBAE8apI0ROuLK131+Th+bznDbTiYRUn?=
 =?us-ascii?Q?DfxkDo/Pi9uzAN+SLPenGMdIU9ayk5yAimlW1azN40t8RLRelE4ZFq8hRFCM?=
 =?us-ascii?Q?edgp2Wx23HFh37CG4J6coaphKb+LYvEaljavMEmqx46FNBsBuB4FxT23gSAl?=
 =?us-ascii?Q?eIFPlJDwgp+FvhMmhbDpqDrW/vXSH18MiUCJi0MfAGMoWrqFkF86LOVGU4v0?=
 =?us-ascii?Q?c4EJaHq/tNuhwfNXKtM2xV7TvD2nPkApTCd0nRRY+yWbZJ3g0QUfBZasb/Qc?=
 =?us-ascii?Q?sKSSlqTITwwbe2leHlOHZZZkctkx458CC5bL7B6RT/SZl3M1JO5QukeRLJ65?=
 =?us-ascii?Q?qRXk+hOzwX6G2Am8kNlPhoYLrgofJXz5XyiNW9OUas3Ca0qC9SH8haFhLTuh?=
 =?us-ascii?Q?l1WfGexnG2IVh792ubL9LlJ6O+1BnFISVYb2DBEuSz+gHSfWyq1mds6qAbAC?=
 =?us-ascii?Q?J22+CiFSuOssbFymdhMGzhSR6/Klu8/ihKmwVPCLx95SuyPNci5O6y4mO0my?=
 =?us-ascii?Q?+qkeAUvQZ4VkW+DR+Yws8KW2Eu+ain+oIjPMA97u3nG0r/qZKkfha/32C2oU?=
 =?us-ascii?Q?Imz2sRmiERdq7oBkBcvI0W1FCJfGVgX7TWg5UKeva71k1YuZ5zEnHsB8m4X+?=
 =?us-ascii?Q?dOJ6yOSSqub3j9WlwAq/eXQsO3GVxGgS49/JQkihquDmhQJgC+4k+NYEuNQ3?=
 =?us-ascii?Q?Ca2amJAQ64oWR6m0BAICePrD6LpzWw+pdus8b+VQkouy64Tmxg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pQ8ELWCR/kzJzOoNnqDSvpxp/KyR+yG05I9A1rC+WI+XMis94w2xKqM5NJfp?=
 =?us-ascii?Q?pU3ea4iB/6MsOuLp44MrbCDM8C0VK18fLFGYQ0YGmMCHtB/NxCdUsf4TYVEj?=
 =?us-ascii?Q?M0HkxuVn9l/mvPDhpU+G7XIy5//fUzpDN/VOK9R9QOga0Dtxks/HNjPYc8CS?=
 =?us-ascii?Q?0JtgLhxrgsgg6HdIoHc8FpA8c/8BQL3Suo6jvmUomWo1eLi2dermHE38ru3E?=
 =?us-ascii?Q?HYy9Dlwq29uXLUIE5RL9a/VLr7fbfXNVzbx15AR0qAhq82KJCFDOr2F5juel?=
 =?us-ascii?Q?ihcI8+N+M1YruPCRw1E26Zj616l1u5TmtDYZ0S+ITc4t2z7s74g3q98qzlat?=
 =?us-ascii?Q?QqQaM78FvbmjbaQC3PEz6ClkhevpR6eIFRt5QHU4in3WwzxUF6ocn/nYr6kb?=
 =?us-ascii?Q?hslEgpMV4eLJmvWLc61ebgcVgTqdc8qlCl30+RPxThrlR4cumL71x3zir2C2?=
 =?us-ascii?Q?yiSluEk98olSXmKgWmFOlUN+Sob2bKxJO9HBniF9mqFstKvuYl9yJObXFXJr?=
 =?us-ascii?Q?A8Uz8zrA4MibdZlZ4XrPRWuK3Z97d2qcMhXTd8ykGPHmAFYEicv/aQAnbhgK?=
 =?us-ascii?Q?s/cAgcEE69OtOc5/hwWsEVJFr4qc+EHAGFuYualV/lWLuFLMQpmh1nJ/rV91?=
 =?us-ascii?Q?MhjN7p7nZhpm6QyQcr3uA2v99AvA6HaxHSfF17zeLql04DQomMzwnQs70ANg?=
 =?us-ascii?Q?eVKqwunjj9l7Q2I4VyWfxGSxUgzC4te7FQNHjDKPKwGKLWwmtYiHiwetdcbd?=
 =?us-ascii?Q?YtEuzQNLkV875ddU97976ugevNZH65nG1c4/p80MC/LgYwJBtSVHVhFl6m0l?=
 =?us-ascii?Q?mAXYUzG5b5f0eJwEnBdIPBZC/d/QFkDHvOhFURlIEuW3xHbHeqyRPMn8m6Us?=
 =?us-ascii?Q?fPJFDX5akSIMI1RlY/mFh+UpNWac1TQ8ABeqVJOtb0mX+zq9TRjr87spPcc2?=
 =?us-ascii?Q?FtltaT3XhtYgY+XeevpupbDxz0zuA/aOh52I/6lmZiUVU3A9n2czv5h9uarW?=
 =?us-ascii?Q?anmpQCAwOvhCaQjJ+cvAOd9kNBcAsD+xeAn4PJ2LdTxCgQuF85ZYOOsF12SG?=
 =?us-ascii?Q?/0VseiQCY33b9OEuOrcgoJU5LtbRaLbwHB2jk/B/SlVVs4J3F9Q4qLWjuMeV?=
 =?us-ascii?Q?GXpNID7Io5iDkTNiccjOQWyEL59hcIRlQxsEMaOzEv4sz2NqoiqE/RYF4ufy?=
 =?us-ascii?Q?NFUGXM7lbbYdOse1GHMPZMzUyjnm/Zyz/qaw6azJe70v2f1lK6c+YeQp/n8M?=
 =?us-ascii?Q?TlMZ04ZFDiNbOhlN3D9aeSbfBQxBT0EaB8nmYsy/S0aEdsyx+UA7gZ0Nq/pL?=
 =?us-ascii?Q?YTIsRMOXqoOplilVHcbOP+WqMm9GCQW6W8hFaX5eBNkugj+KE77Mz9RKb66K?=
 =?us-ascii?Q?BLhgD1fIJwecux36q3+vEg188qX6UpkpvaegxKMINjjBke6vpgQJBlsHKNlG?=
 =?us-ascii?Q?p99xLT0fvs0Lmd/RrmoHSxPHVR7IICijfwFLha54PdLapL3vIfFmrvss3ItQ?=
 =?us-ascii?Q?5I0yF5h1jqdMGb3YSOAObOtCXreEJ2IHCpiYID2+/qMKGkoQjA5J3GYQZ5ZY?=
 =?us-ascii?Q?ddO1m2XyoVLmt7szURULJwUyorb1O2MGmu2ZtMp1dKXZZclqaFypbmvBhY2s?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 890a35b0-2226-42b6-46eb-08ddc373399d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 07:43:01.5181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rx+jLjHJE5kGagX93kjePvKYKYHLQype4LOG9YfnCtPDYC9r/QlZS8nj59V5W7lyhGwYszZ2NoASGIx6cCOOol2WuMa3M1WGm4YLlZO3Ces=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFCF54B2894
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

On Mon, Jul 14, 2025 at 01:45:14PM -0700, Stephen Hemminger wrote:
> The lines in .mailmap are supposed to be sorted, they have
> gotten out of order over time.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  .mailmap | 70 ++++++++++++++++++++++++++++----------------------------
>  1 file changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index c7d55c7386..0be4d883c9 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -48,7 +48,6 @@ Aleksey Baulin <aleksey.baulin@gmail.com>
>  Aleksey Katargin <gureedo@gmail.com>
>  Ales Musil <amusil@redhat.com>
>  Alessio Igor Bogani <alessio.bogani@elettra.eu>
> -Alex Chapman <alex.chapman@arm.com>
>  Alexander Bechikov <asb.tyum@gmail.com>
>  Alexander Belyakov <abelyako@gmail.com>
>  Alexander Chernavin <achernavin@netgate.com>
> @@ -59,6 +58,7 @@ Alexander Skorichenko <askorichenko@netgate.com>
>  Alexander Solganik <solganik@gmail.com>
>  Alexander V Gutkin <alexander.v.gutkin@intel.com>
>  Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> +Alex Chapman <alex.chapman@arm.com>
>  Alexey Kardashevskiy <aik@ozlabs.ru>
>  Alex Kiselev <alex@bisonrouter.com> <alex@therouter.net>
>  Alex Marginean <alexandru.marginean@nxp.com>

Nak for this particular form of sorting.
The various "Alex"s should appear before the "Alexander"s, since the fist
names should be compared alone before the second name comparisons start.

/Bruce
