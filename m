Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E3ECAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 14:42:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D354402B1;
	Mon,  6 Oct 2025 16:42:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 47D4F402AF;
 Mon,  6 Oct 2025 16:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759761758; x=1791297758;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zvzJnKEBx1qbTb5KyW0tR7ZGYbeF9b0dSKKfYmFSmKE=;
 b=CXBAaFFs0yMBlBFfJwCHvBsOmG+qmJC4fE8XJSquzlITCinygtzeiwa+
 Dq0T/9k53LAoKsNmsc+cS1m9QE1Mg/DPVxiQIrqysYIPiLKEpc/z5Qmon
 R/RvJuypsXS2WLTKdIqP8VLq9Ewz2Fsi+F5ZBhlyVV1+f4P/DKlATIElP
 1LJkH1OkdD1WDFoGvkuewm4A3otgEmtnTb/1LJua/nKItIMNLleKJ9sg4
 iy1CTaALz0Y6K+eBWfzllRLIWHG4qOEtw8zDSRjSRW8X5o6ndYJCgFLWR
 92qWxqG35t4lUx+4nLUKRhTV3NMGozxovnpLJhgXF+Z1gD9OVWVGL2yvU Q==;
X-CSE-ConnectionGUID: SFs+g8VSSjCp8OD/HWMmUA==
X-CSE-MsgGUID: +8KZFdqRRM6CF56ICwX+3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="49490963"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; d="scan'208";a="49490963"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2025 07:42:35 -0700
X-CSE-ConnectionGUID: am+FSp0zTJ2wT0E6pKCIWA==
X-CSE-MsgGUID: F17ySTEVS4esmPFB6xrLxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; d="scan'208";a="210582184"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2025 07:42:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 07:42:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 07:42:33 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 07:42:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsdI7NAYxOUZlUkzwjSwva252uRCJXuF6l9Tqf0TaPFQMMQRkgGguFyXXEmBLEJiP6fjGaa3NKS5BuEP98iSpqFx+9UIo3wuxUy0hs4fZ/YB4dYLLQ7orDYF+oWOcnrSXwsNTAc9mGwuntIN545sEqdzTbJCDin0PGm50E/ffRvQ0dBskrFNV4KZfLP3BSKDu30UJBRYkKbw9ii0I38q+oMswB1Sl7ptbGLAQ6h4nhamY0xCWdzNew3wyLUW/DsDIYV7JbALdhYAgpseElQnJO3ZGNcgX8wgBZiPbNan3fLS+RWysjwd2iciiIu5LJB1OZ0PwL6WAcTSw2lqTw6BcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmJ/IkUOkivmgMstkAvovlWLl12pE1N0xeh3WwbJjno=;
 b=vvH9yiCkPjQfzxtgXcH5LEitiV6Pu6Gp0iTNAOlU9emEOu9RbNphOBJGp5Ieg/zwDiaDnN2CaICsH39ahmBs0VG1NwoGOUjVmpcaPFYM2YWqCZyrhUxJIhqKShnV/Zo4ofMI1erqXe2bE9E0H8HXyr4GIDmoMSnuGsaa2uplinEPAV9iJ9pNkoHyh0xlvYMN8xL4XkJ0l87OUdIINS36yauDsX2pWEkM1KUFlpQ1vCfVN8qEXMQDAyZv4MFjhwuTjPTkAqoZztdzpaoJCjrUg8cCIp9GXR8i4bLUGpkX/RqhAhPdML1wGKwHOEbdDLvwoP6hWlZERzJvam34rFE8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPF10DD61CAD.namprd11.prod.outlook.com (2603:10b6:f:fc00::f08) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Mon, 6 Oct
 2025 14:42:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 14:42:25 +0000
Date: Mon, 6 Oct 2025 15:42:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>, dpdk-techboard <techboard@dpdk.org>, Morten
 =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
Subject: Re: [PATCH v9 00/18] Simplify running with high-numbered CPUs
Message-ID: <aOPVSzwUNTrBjuTx@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251003081510.1197166-1-bruce.richardson@intel.com>
 <CAJFAV8yuo6vVSGKx4Cbs6Qqv9Y9dPsLteZtmN+Kr79BmnMqCbA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8yuo6vVSGKx4Cbs6Qqv9Y9dPsLteZtmN+Kr79BmnMqCbA@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:10:232::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPF10DD61CAD:EE_
X-MS-Office365-Filtering-Correlation-Id: 814c0820-cba6-4620-5c2f-08de04e69036
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iXAn3MsqB4Oexlqq8Rldyr31SO6p+ohsw0MfSKLGO8O8W1AsLSIkXzPpEtcv?=
 =?us-ascii?Q?0po+Wb2SRjIQIE/0GFWkbhZur19W7eA2FlYgRVlDV8ETVe0VAg1S1R8GrBqB?=
 =?us-ascii?Q?D7NyDpbRYVV/zVDKIjH4AMhupt8dqLdD1qTKY40WxtOO4F2donqxRGzcW3Ij?=
 =?us-ascii?Q?HagKiF8Xw4EPy8+q/HL68+H2T9j5YB03GbQtmC1I39BGEUB3cAb0Q03m9dHx?=
 =?us-ascii?Q?XWXJRM+YCtOr7FsdOre5qCSoQZWVv0k0DkyMhCJJeINsKaTiMnsenVmIe5T7?=
 =?us-ascii?Q?9J9YLhT16zMNYzX+kUklHdsjIBTVWQC1hEQUcG4bRAwwnaDN/lLe4SIADXos?=
 =?us-ascii?Q?IJEORk75vdzjJjew+3AZIlEPhRjShc/YvbSZEPaHOR/chVp4m2QtDwBqfQWo?=
 =?us-ascii?Q?s5/FsCHhiOtfffRCMArY2Ms31GoWWBm1Xv2jVcTj4Gy6GjEsskn0sTjUTXa1?=
 =?us-ascii?Q?sOv9ro/Aqf7yVmzXWZSAvKPxqXY99kTDEwJNQSYsbFrpSXUQyONXuEGrOBHC?=
 =?us-ascii?Q?jb+x0mPT6Cr2C2vtZnWrjLdd01ToqJx00mWGiFgMSfXz/jbdAhYl7S+GhVCt?=
 =?us-ascii?Q?9MQsIkglj85fnfyZCCwFiFbazybuwMZdSU2auOxuPU0YyopBOAqdyd8wzJdH?=
 =?us-ascii?Q?u64fiemIukRvUg7vu+d/pHyNZYugcqJeDF2nNBhYcHipu2h0WwOhUZ+ZUzoD?=
 =?us-ascii?Q?yRZQPSgx5wSohNg6Eo/LjFg6Uo24uYv6Egd7RFGWstncMDO+8wu+L1MaNFHp?=
 =?us-ascii?Q?SPLkfBDf4QJ48p76xbTDxEj3WThe/1kpl9pqC/OuOA3Ic3ywcWoR4uckvZn9?=
 =?us-ascii?Q?J7W77qrlc+qjP+1YinWibCr0Uf49Z4c3x1zyoszQLyT4zj0zLwqad3+HMlr2?=
 =?us-ascii?Q?142IZT4f3VYNB99xzCqUgh6Ew0ZYPMe8dmD6mfXZ71XFM+ZLBOlrK2ppCobD?=
 =?us-ascii?Q?e+jvKFxZr652D4VmsXLmoLSjPB7mCixEK/CdYJohpH2NH484JZW5L46rlcKY?=
 =?us-ascii?Q?Br9Xs9iNAOGwJmOKu3gc1lzfPI6ir9xPC91NcY22uuIStSa2zVnx8r/1ph5J?=
 =?us-ascii?Q?epnWZRMMeP/vJ6i2R8rvIE3WvjKNuJyB0tLFSaUnUTC/o8fEWyI4iHw2dDMg?=
 =?us-ascii?Q?SqSw5oQRqB69ZvAEgC0KL92g4s2oeJIc+RKdAgkYhLL5uaDhMdiRAhZE9fKQ?=
 =?us-ascii?Q?DWYa7rNiINHq4gKtwZGslVjVeHo1UWH41w2UvsWkjACcseJJHxmhh1+AJW9C?=
 =?us-ascii?Q?G0quduOkyPW2NJ1y2jkQMk1OVPUNRv6t1BVS0Kn2kU0oBq6EV/6nsdT12R/r?=
 =?us-ascii?Q?N+Wp0yLzwtG02NDa4ypnrPJAwn1xKIOJ2stOzESrvMy+N/+3YN3GHVJVrvTY?=
 =?us-ascii?Q?+phC3Q9YCeJlI0UiSiFuXSkTwncRDQ6eCgioGk3YDlPRD2feznVUBcNXQFwH?=
 =?us-ascii?Q?XPLDkQKB2fdw98nE6GgvP0Fza93GvjIV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5kbYJuVCatlnOir3zbTPSpgvE/ltAntoxqzS6o/d8fTs20dyAXpmEdZ7dXNv?=
 =?us-ascii?Q?jI1Ir74BhQyggXVccP8+J/prlK2BzA/lLw07ejYn5/lI/cfJcLVL0gAymE2F?=
 =?us-ascii?Q?wx+fwOUMYSUfPywDXW+4U3rBDFgDwvdXarbKqgzT1GcBfk36v35TfLitIC2w?=
 =?us-ascii?Q?z1ZqA8VO590YsorXjuKMS/8nm4PX0MipPXuKp7L5UApBFHGe7JaXB2ywdmoJ?=
 =?us-ascii?Q?i/Rt3Kf/3Zv8IZZExorhZpv+Cvq2RzE7LICtrM/mxj6TFj2icmOc3YpvWInH?=
 =?us-ascii?Q?WVSPmyV9BLIv6vZhewPvjm03ngcA+LObX4EwK2n/tA3GoKjHdy6xCc31VjnU?=
 =?us-ascii?Q?upY0r0xyLQolGLULgze4JmQooEcpGwJr4ZvFuGgCQkWYXukccADH9jWFkhjl?=
 =?us-ascii?Q?Ncy2hefXNDzJPOcluiZKWXfyxQFXAflb209ww5H7CmJoia7sbVxL+uiPIZ7g?=
 =?us-ascii?Q?mX0qHtw76TVVUxwAWCX8GKrI/xLt1QcBaowyJxKu9kIRKqiALDXVcsZq/2zn?=
 =?us-ascii?Q?vs07jEw1Kv6w9IPaBpBVdzLGjN8FOSoqwxMjr9btzjOAOcS3+eZl4TVtm16M?=
 =?us-ascii?Q?Heq1SEY5iAHSTVsHqnTeHXGmF7VMUAMkARV6Z+S0repVPwetT1+1V4cpW8kX?=
 =?us-ascii?Q?DoTdzOJPpfpOMwjKH9CH0o/n5NL1IYpo7iSHpNgut2zbWBFWqHRZOKdptidT?=
 =?us-ascii?Q?uTRx9TgT/BDymgmd3TElx88ceJ+neHg94jSrl9U5SyZwL/bxwNPpkq5dhBo4?=
 =?us-ascii?Q?dUTYZD7fOqKX/m3SqKAOmStQD6ISgT19Tu9Fbex46xoUwtuJywf3pRlL5u1z?=
 =?us-ascii?Q?w9lvd/sdjBOslGCsyKuteaGEB8gLhHuuBv4fieC6Pnlg9nXeokQRbkINj9Gt?=
 =?us-ascii?Q?2SAAiMoKvi89MGUM1q5Znejyh35PSfAvmLibHLa+VYvBlF8oxmgLX1Zljdx9?=
 =?us-ascii?Q?dz7vJT4nhZ2AX0M88hzYC3Rp9urzv2/xRBUjujLHidPFbmKI6jSv4bUatSBf?=
 =?us-ascii?Q?yZYSpkAO0gqd1My6nVSGbA4tF3bomINa/Aj67fv5gwnlLmsXlQlz4dyrh2qN?=
 =?us-ascii?Q?rn6WSXKQgl3TlZ6HVAeVbxSdMZrozbOhfq4N5FeRiaHh1XRvdzL0EfVPRrtW?=
 =?us-ascii?Q?KoCqzwn21dQJKjmLgqEuGhq//H5WkuAszRNZoKd0xNVdnX0EQ9i+OMOmtO9H?=
 =?us-ascii?Q?ezVL4fsu+gwh+Q8vtePZwHDrdz7jALbDJrKvHWVtBPV+K+8NvmRBLJbq7a+3?=
 =?us-ascii?Q?QPHJycXYxP3wAD6zqHg5YHlC+DYxjPtbbosBVljlMYxxgAHBaBuRdYUz+X2V?=
 =?us-ascii?Q?AEUGaxKrd3dBelJ1WR0PoXLDtlvmFdHBrfEi66zePT1DLHh1ZU1EeYYLsyoa?=
 =?us-ascii?Q?KN+S6R2E/gxR/h6uoQSbTCutVC16wgPnYrslWXWQW9nHGmFf48DkzrbpnH/2?=
 =?us-ascii?Q?PpASitNm6zxit9gnX3X2+erR7zWZkvv+pd/ZBt6idpvjbEj3pkgf6xfes6na?=
 =?us-ascii?Q?GMUSqlT4inFpBzmhj8CKBWEWZIPw/oX7rNlUr8E6+J93a83qPm2kMgDExUGV?=
 =?us-ascii?Q?ksLE8gTSEVm2GQRHUNVSTPZzhhElcDWdelq0L6ronftsYI7/OJiA+DZnqzrz?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 814c0820-cba6-4620-5c2f-08de04e69036
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:42:25.2236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFLuHzh72442mi0XLjLNfgUV0RnRLolYCaIymfdBA/7nDMI4laaPzREyVIVbsBMK1BhtuTd3GbLIVq6pqcRfMsCvEOYiffYdKLOMjNMOXnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF10DD61CAD
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

On Mon, Oct 06, 2025 at 04:10:52PM +0200, David Marchand wrote:
> On Fri, 3 Oct 2025 at 10:15, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The ultimate of this patchset is to make it easier to run on systems
> > with large numbers of cores, by simplifying the process of using core
> > numbers >RTE_MAX_LCORE. The new EAL arg ``-remap-lcore-ids``, also
> > shortened to ``-R``, is added to DPDK to support this.
> >
> > However, in order to add this new flag easily, the first dozen or more
> > patches rework the argument handling in EAL to simplify things, using
> > the argparse library for argument handling.
> >
> > When processing cmdline arguments in DPDK, we always do so with very
> > little context. So, for example, when processing the "-l" flag, we have
> > no idea whether there will be later a --proc-type=secondary flag. We
> > have all sorts of post-arg-processing checks in place to try and catch
> > these scenarios.
> >
> > To improve this situation, this patchset tries to simplify the handling
> > of argument processing, by explicitly doing an initial pass to collate
> > all arguments into a structure. Thereafter, the actual arg parsing is
> > done in a fixed order, meaning that e.g. when processing the
> > --main-lcore flag, we have already processed the service core flags. We
> > also can far quicker and easier check for conflicting options, since
> > they can all be checked for NULL/non-NULL in the arg structure
> > immediately after the struct has been populated.
> >
> > An additional benefit of this work is that the argument parsing for EAL
> > is much more centralised into common options and the options list file.
> > This single list with ifdefs makes it clear to the viewer what options
> > are common across OS's, vs what are unix-only or linux-only.
> >
> > Once the cleanup and rework is done, adding the new options for
> > remapping cores becomes a lot simpler, since we can very easily check
> > for scenarios like multi-process and handle those appropriately.
> >
> > V9: rebase to latest main. CI complains cannot apply v8 patches.
> >
> > V8:
> > * dropped the final two patches from the series, dropping the new -L
> >   option in favour of the -R modifier.
> > * reordered patch 11 to be with the other argparse patches (now patch 5)
> > * added patch 12, which uses macros to initialize the args structure
> >   from the arguments header file, avoiding potential issues when we add
> >   new args.
> > * simplified and consolidated lcore mask and core list parsing to always
> >   work off cpusets rather than arrays of uint8
> > * enhanced debug printouts to also work better with cpusets and handle
> >   core values in those sets >= RTE_MAX_LCORE
> > * for completeness, ensure the new -R option works for coremasks, and
> >   for cases where no explicit core-list or coremask is specified.
> 
> I was planning to merge the first part of the series (before reaching
> the cpuset rework and addition of remap option).
> 
> I am facing two issues for which I prefer other's opinions.
> 
> 
> - First, I see a change in how non-option arguments are handled with
> the switch to argparse.
> $ ./build-mini/app/dpdk-test --no-huge -m 2048 -l 0,1 func_reentrancy_autotest
> ARGPARSE: too many positional arguments func_reentrancy_autotest!
> 
> Passing the test name after -- does work, but it was working without
> -- before the patch, so we are introducing a regression here.
> 
> 
> - Second, stopping at patch "eal: gather EAL args before processing",
> I see a crash in this same func_reentrancy_autotest unit test.
> 
> Here, I would fix the unit test itself, as it passes a NULL argv[0]
> which is invalid according to the C standard.
> I fixed this unit test not so long ago (978ead0144c1
> ("test/func_reentrancy: fix EAL init call")), but the fix is
> incomplete.
> And if you wonder why the CI did not catch this, the next patch hides
> the issue for the unit test, as the run_once flag gets set earlier,
> which makes rte_eal_init fail before evaluating argv[0].
> 
> On the other hand, even if DPDK does not really care about argv[0]
> content (well, until eal_save_args is called and crashes), we are
> introducing a change in behavior for (arguably) non standard argv[0]
> == NULL, and some programs, which are not passing C library argv[] and
> instead building a argv[] array, may rely on this... ?
>

The second should be relatively easy to fix, I hope, so I think it should
be fixed both in a new version of this set, and also in the unit test that
has the bad behaviour 

/Bruce
