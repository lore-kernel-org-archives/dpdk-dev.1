Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817B7CAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 09:00:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D04940264;
	Mon,  8 Sep 2025 11:00:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 9E7C4400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 11:00:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757322037; x=1788858037;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8S+ZWE3fTxAyNQQhRR7jFOp3tX5G6mguyJ1MQwAr9p8=;
 b=kGrqPoGPkQQQb3nCN4pqIFEK3V4E5lat+lIIllTJwpHiRq6Kj27ZreMg
 Znif8iKzculK8lL5rI6WQUl9/c1YxwTq1Lj3iRtwymXm3dllkflDNyR5N
 NKtwJws6m33I37z7DR8HKkCvyWDdqkNEGHip6Ntu4SRZQi+MtYUUcEQl4
 twtm/kLGc2DqUZPwnzc0VwOvW8gPlYEL0G5/WJr0ZY29Ec+oGvgMNUmbF
 wqJ2uc6CxNvg+FS7i5dANyChNRKswhdUN7HEDERtNiECuad6BKuHWxxw+
 +2hAuCsm2OVTkFVOg/H8ZleItZoTuPnIsyCTxiqxsaJ8SxIZyxwdgdZIb A==;
X-CSE-ConnectionGUID: cjfWgtidTzeFjQ7da39akw==
X-CSE-MsgGUID: NkMFg4dFT5yWneZwxoDjlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59526698"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="59526698"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2025 02:00:35 -0700
X-CSE-ConnectionGUID: cIWFBGCmSVKWZfWSz6kacA==
X-CSE-MsgGUID: gYCqcwKdR6u89pFVwRDsMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; d="scan'208";a="173528431"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2025 02:00:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 02:00:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 02:00:34 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 02:00:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFi9PdnAyab6lpgkPxNIqnWfT2KveNtDe3/fbjg9Ob//fxXAYQP4JCaiYV4Jpz8iic+q+F3bcDbIrTOfNnxVH+rE0Jaom9fUtSBqX6i+r7pr+ngTdiTqWLynTltw/TDB7YaA8DFjIW0OetRyjf8oVrIR1tE/w1Jub/BieuHtu/kNKjfTzS6tttu2qOxzFFOtsMQaSL3Sg37ZygI2eLSkZtXAz7ADHW749HJKNGPH11dsa7U5EwCe/vbqVyjJk8wuOa4LRh1vQ/LBS9ub2epTZ6dSEAszi5wl9S5oEwxr+zBg3g/fz/vUTSRFKN4NECUbcG8wJ6iOUaV4rjAVcnRKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xfH+sF8j3/GSLjG1/uSRBJV/SmjNfYxJ5q/RuayIGY=;
 b=K3k/EDL8HUH7gtvB1Mh1AquL5nnBHVGrpu+NKyWLZL7cSdhqvXDtJL9YScyA7cz0knqelEG1r8NRa6B10smwCB50GqPVHCz1SaZngu7fmcFzofwXoDLVHYaxNvGnforJQAbT8ywA1P2X/Zl0qpHnglYt9VMC9ne4Ad+7VLInVkgbd3VsAoWG2uBJtDISuE8gCzcGcvDYGlKWDwM2jWP6TqRkraXCF7ip6tSIb6nmCL2a6VG60s6z6Mu7AGwN+Adv63qyyWjVo1jfXJuz5jrElV8p8Kw5UpSccIfSyZ/ZfQKruj63y0fL4Mri1c+v1ILbPMloOfhfxhJJLSBj2lTK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPFE1E3F709D.namprd11.prod.outlook.com (2603:10b6:518:1::d56) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 09:00:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 09:00:32 +0000
Date: Mon, 8 Sep 2025 10:00:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v1 09/12] net/ice/base: improve global config lock behavior
Message-ID: <aL6bKzJd2sk05wlP@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <890cfe97d9f716a7a65c028578bd1fc90ff04c4b.1756833701.git.anatoly.burakov@intel.com>
 <aLsCf6Of94EA3aP6@bricha3-mobl1.ger.corp.intel.com>
 <f2bd7403-b79f-4f7f-9979-d7cbe442c2fe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f2bd7403-b79f-4f7f-9979-d7cbe442c2fe@intel.com>
X-ClientProxiedBy: DU2PR04CA0338.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPFE1E3F709D:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6e2990-0c88-4a80-2b3b-08ddeeb62a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VvDgR+qhUlvhYtqpOqeiwBSzafOGkDNQ2O98mnujeLPyy/kCM5Tbhs+3Er6t?=
 =?us-ascii?Q?SlOxz15yowC4ZkY1EiLOWlAN74suZ821xcMRSI01lXURAVKhf401iClqiufe?=
 =?us-ascii?Q?ySrQDku89cg+vLTaAlLQcRoysRcaiBVDrglxp4b66bpTQlgnZiuqjSLFOkcT?=
 =?us-ascii?Q?fmpiA1CljCg1gFbI/uOF2eN1CEE/QQ/a37PzPSGGjYXRQNr0jNb4A4F+hEAs?=
 =?us-ascii?Q?Gy+C+0VJWgY/kVXFJkjaM4EjXwNpEL2QLiuBP0eCsgvsCv9xXh24VzxHreoU?=
 =?us-ascii?Q?H2oYtJPaVRz24IRQnhjR/tULYdfjSEwmJIDKIFSkqN3lqrVJAjVuaHVPXZ/i?=
 =?us-ascii?Q?fBM1lGwNGRxsDHlAX6FyAyQJlB70LthPW0Z8Hqb5a//6BM0mZ/9/7FKr0suX?=
 =?us-ascii?Q?TiYQaFM4gcBV2IlXDWI13RMar+dxZvndkdxB6AZ0FYdfjV0hbMdqZcyKwkpD?=
 =?us-ascii?Q?tzyWeJX69B3VT1pvUFsTqhDgTNZj1d+UH7ZmYhgJJASLdPA0JaCiLF3v1zJn?=
 =?us-ascii?Q?/C+ZOBMy810KxW+yZxSDaa7Pm6z7HXpgG5hCivm/VPQ87su7n1+1qTEoxosQ?=
 =?us-ascii?Q?T1f3fkL0Op/IAz0bI1vsrBRSeTgA2gpdFvQhrYIqb9vLK9bg8am45vUAFQ1y?=
 =?us-ascii?Q?WtWmn+bXzoWv2aF5tiBXwQzYv9r9YRznUIbQwVV4e9kDhj6iglMII5oWkyVD?=
 =?us-ascii?Q?qr8EM9H2d73E5x7sRGvJwwb1n0xPDzx76F1DfDPLCVdIHTLAF4JFWHI6tYkG?=
 =?us-ascii?Q?WVSaAz7HPIIJX9CM5D1Q0rh5KZ5nywHI0WL0Z2bY5mKQg5WcxaRpOgjF6OBF?=
 =?us-ascii?Q?fpncEGzizdYycFYzrpd1im3o3JYc2XDQIbr8CxmuK9Gelh/EjeSwQGn/PkTR?=
 =?us-ascii?Q?U5j3WBICVX7QVO9lVM8W/NjtzlYvjU+rSFf6SuzUAgrnTdur1987st7TJAFx?=
 =?us-ascii?Q?WW4t9W1HFYoO4TgTNfehAeQiikjWi/x8bZDZzOofa0f4cQKT2RD2gGEMMIG+?=
 =?us-ascii?Q?pPOVcfz0m4HzynUDJIsVg+jM2zFrY2a8fv9zVPfnTgbARw77kMhvKAEef/Qu?=
 =?us-ascii?Q?kw7vdU1+VcKjAqdGCnt7tVz8C1yTWfY1Eyrk+Y6KjDxlujQHEu20Eg8SOOJQ?=
 =?us-ascii?Q?nk59rgBGu5w3SLZCTsFo2qKrkfJ+ZFeQgU5tFQEBrXqOoF5ioICMfPAbT6pn?=
 =?us-ascii?Q?SnIPod0+z/lweJ0wNQsW8LtXABrKDhZqsoW1gRDXqBDYMz05g68oa248j1vs?=
 =?us-ascii?Q?R7RQyrUv408JfW4QWFzsDSSd6BPAsivDMcj+7evqgy9NaJpKr67u1oMv9yMA?=
 =?us-ascii?Q?rjCrVESd6AvQOQ0EfOWVOOh7k73OkCg9qj2h+u2Wes4pZT/fIk1WmETE2Pqn?=
 =?us-ascii?Q?FMVaCT7Xb0ksx+0x3EEF+bkModokwMyiiIMQqk95mMJzZithss4pOOfe66MI?=
 =?us-ascii?Q?0UjEMtcanww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X1azCWuyU5oUZOd9ZZwrMJbi1q6dyyskDL5UL/wRprmjfOGBhKId9iRG5FYI?=
 =?us-ascii?Q?fOlDd+FeUEx90CMnRpOb2qtq8aw73jFiRtOeHYpEb5DzYh2enr2ZSP7qQRYI?=
 =?us-ascii?Q?hBo7Gy3MIeVj59WErw6mZmJfg8k/q+mG6zLIA4tS/vmcIGkqqa9nmZq45cMY?=
 =?us-ascii?Q?CVAMLCmI255c+025o8LYoVw1zGacC/pIEq/NZRFxf0W9SbdohOcMDMBHcjGW?=
 =?us-ascii?Q?jCfKDd5OaO1Or4RL+CvHkvx/aCkdPHNuXOtnkrGFMSOjX3ohuY/fnODzMCQH?=
 =?us-ascii?Q?QxudvfyvE9s6iSczR6IQojooQVrgF1+xLf6BRySni4G0/WfU6aTvox44IZgz?=
 =?us-ascii?Q?3+0SJ9dPIr08uVMAv50onoK/u94DQmdPRfmBbGZjkHb4SzuacebkiMjDpXax?=
 =?us-ascii?Q?mX6QkbZEXCk5ySh7WEZJmIg/GvkD1sQJSPoA2vfA5yu+BI67APn+3i7SV50F?=
 =?us-ascii?Q?XoosgwtFTNKSfuIrXQZ/TEALfeYtAp8LKrtuDEvlxVh9glvTANmwA1CSzSES?=
 =?us-ascii?Q?rnT2HY004MFfh7cl1KDOTGeZ0KCnIfKALCOJs27RGrsfu5E3MCbNLjxka8/y?=
 =?us-ascii?Q?wEUZqG1ODMUtx6S50bnWFQFKLeIpbbzxGQHym2uALOLc5+eIsqCRQvJDpNUQ?=
 =?us-ascii?Q?6unr4Wwrlzjqn1FeBnMpiYBmb1cJu8ncKggRRgYHF6jBCUvEkvxcYMAfhWiN?=
 =?us-ascii?Q?uK8o//RvpS9xu7CSw6SIt7HleHh54VtPzl5woTeO018A2cWQM4hh42TZO7If?=
 =?us-ascii?Q?4Jg3hOnOoVO+eNbXG1/U5y4yCNlc6OXwmJ5Jbi5XpO4xfym5VUKlBQl41LyU?=
 =?us-ascii?Q?8jbwysoHv6YDT4h2Rks/a+LPWznAx+9n4hCX0n/lryhokCEfFUgYISVs7kAB?=
 =?us-ascii?Q?AxxUM0qxD+BL46yxnH5ytN89rmYgef2l+HSLlP0xYaf6uqC7P71Mf97wo4xX?=
 =?us-ascii?Q?tey48EbfnR2fKIOTQRPDf+c8zG4028V7xiyaK9fx4voKQ7PY9FDkLursDEtz?=
 =?us-ascii?Q?/uSG1ZY+nG6dmkhccIzmLyU0t4V7nYqOpcoO3UyPzqrTJJ0/C6lntU9VCPJs?=
 =?us-ascii?Q?ZcwviDr7Sr5wFf3004Liwf529XCYX6pHxCB+QQV08N/WEKxkYo9zAtR6UGLC?=
 =?us-ascii?Q?IOlb5dgAD6Zph3UF7doIw+Fg8eoBvMgZkp74OnFo8oP4ShDONM+d+Wm367dU?=
 =?us-ascii?Q?OBsHWXH1dUb5nGWTyO/qdSVH/lMKXaXcUZ9x/Bdpf17qoAsjaL15DUwB/P19?=
 =?us-ascii?Q?jZFtf+udejXP1VExWjM8MfvoSVCwcU5OrLT7Rwb8jTwewnCndDUH5QmV9Hqo?=
 =?us-ascii?Q?zbZ07+m3k41K8Ud6AJx1Ie9D+0W0Ya0omQJ4f+Pb5ZP3mAf+Ddwjl/imipFV?=
 =?us-ascii?Q?1qQMQOWgkQOH9Maie9HYLcrWXLf86pku+6+5hfMT0ocj5YRE6wgjQqEOmmVJ?=
 =?us-ascii?Q?1O3uyzdXDYKMI+OhyyAicw962bj6RZiF8+ZamPc6nIIXMBu4eEJ893xvxGi8?=
 =?us-ascii?Q?5dmeHDdzo00anpJXfxExO1bOPT484i+psJBbE2NTONrRVV+c67CZjNKz0R6A?=
 =?us-ascii?Q?h5Cnv0K/E2KxM3gsxIWUyydVrLr1rsW5ZdfYS/oOy9fkze6jdRu9tCDbcxQv?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6e2990-0c88-4a80-2b3b-08ddeeb62a3f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 09:00:32.1591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtkfu3OVDJVSq8UUP1OxqWOf2zowbdMVCtmq5B/d4zwAyVhkD/WzLWsW9RDieVBSdf1wnSHepItmoFaX4Y4sbocWcHPng70FZ0zWMOfLq+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE1E3F709D
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

On Fri, Sep 05, 2025 at 04:25:19PM -0700, Jacob Keller wrote:
> 
> 
> On 9/5/2025 8:32 AM, Bruce Richardson wrote:
> > On Tue, Sep 02, 2025 at 06:26:59PM +0100, Anatoly Burakov wrote:
> >> From: Jacob Keller <jacob.e.keller@intel.com>
> >>
> >> The ice_cfg_tx_topo function attempts to apply Tx scheduler topology
> >> configuration based on NVM parameters, selecting either a 5 or 9 layer
> >> topology.
> >>
> >> As part of this flow, the driver acquires the "Global Configuration
> >> Lock", which is a hardware resource associated with programming the DDP
> >> package to the device. This "lock" is implemented by firmware as a way to
> >> guarantee that only one PF can program the DDP for a device. Unlike a
> >> traditional lock, once a PF has acquired this lock, no other PF will be
> >> able to acquire it again (including that PF) until a core reset of the
> >> device. Future requests to acquire the lock report that global
> >> configuration has already completed.
> >>
> >> The following flow is used to program the Tx topology:
> >>
> >>  * Read the DDP package for scheduler configuration data
> >>  * Acquire the global configuration lock
> >>  * Program Tx scheduler topology according to DDP package data
> >>  * Trigger a core reset which clears the global configuration lock
> >>
> >> This is followed by the flow for programming the DDP package:
> >>
> >>  * Acquire the global configuration lock (again)
> >>  * Download the DDP package to the device
> >>  * Release the global configuration lock.
> >>
> >> However, if configuration of the Tx topology fails, (i.e.
> >> ice_get_set_tx_topo() returns an error code), the driver exits
> >> ice_cfg_tx_topo() immediately, and fails to trigger core reset.
> >>
> >> While the global configuration lock is held, the firmware rejects most
> >> AdminQ commands, as it is waiting for the DDP package download (or Tx
> >> scheduler topology programming) to occur.
> >>
> >> The current driver flows assume that the global configuration lock has
> >> been reset after programming the Tx topology. Thus, the same PF attempts
> >> to acquire the global lock again, and fails. This results in the driver
> >> reporting "an unknown error occurred when loading the DDP package". It
> >> then attempts to enter safe mode, but ultimately fails to finish
> >> ice_probe() since nearly all AdminQ command report error codes, and the
> >> driver stops loading the device at some point during its initialization.
> >>
> >> We cannot simply release the global lock after a failed call to
> >> ice_get_set_tx_topo(). Releasing the lock indicates to firmware that
> >> global configuration (downloading of the DDP) has completed. Future
> >> attempts by this or other PFs to load the DDP will fail with a report
> >> that the DDP package has already been downloaded. Then, PFs will enter
> >> safe mode as they realize that the package on the device does not meet
> >> the minimum version requirement to load. The reported error messages are
> >> confusing, as they indicate the version of the default "safe mode"
> >> package in the NVM, rather than the version of the DDP package loaded
> >> from the filesystem.
> >>
> >> Instead, we need to trigger core reset to clear global configuration.
> >> This is the lowest level of hardware reset which clears the global
> >> configuration lock and related state. It also clears any already
> >> downloaded DDP. Crucially, it does *not* clear the Tx scheduler topology
> >> configuration.
> >>
> >> Refactor ice_cfg_tx_topo() to always trigger a core reset after acquiring
> >> the global lock, regardless of success or failure of the topology
> >> configuration.
> >>
> >> We need to re-initialize the HW structure when we trigger the core reset.
> >> Previously, this was the responsibility of the core driver to cleanup
> >> after the core reset. Instead, make it the responsibility of this
> >> function. This avoids needless re-initialization for the cases where no
> >> reset occurred.
> >>
> >> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> >> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> >> ---
> >>  drivers/net/intel/ice/base/ice_ddp.c | 34 ++++++++++++++++++----------
> >>  1 file changed, 22 insertions(+), 12 deletions(-)
> >>
> > 
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > 
> > See one comment inline below.
> > 
> > 
> >> diff --git a/drivers/net/intel/ice/base/ice_ddp.c b/drivers/net/intel/ice/base/ice_ddp.c
> >> index 850c722a3f..68e75be4d2 100644
> >> --- a/drivers/net/intel/ice/base/ice_ddp.c
> >> +++ b/drivers/net/intel/ice/base/ice_ddp.c
> >> @@ -2370,7 +2370,7 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
> >>  	struct ice_buf_hdr *section;
> >>  	struct ice_pkg_hdr *pkg_hdr;
> >>  	enum ice_ddp_state state;
> >> -	u16 i, size = 0, offset;
> >> +	u16 size = 0, offset;
> >>  	u32 reg = 0;
> >>  	int status;
> >>  	u8 flags;
> >> @@ -2457,25 +2457,35 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
> >>  	/* check reset was triggered already or not */
> >>  	reg = rd32(hw, GLGEN_RSTAT);
> >>  	if (reg & GLGEN_RSTAT_DEVSTATE_M) {
> >> -		/* Reset is in progress, re-init the hw again */
> >>  		ice_debug(hw, ICE_DBG_INIT, "Reset is in progress. layer topology might be applied already\n");
> >>  		ice_check_reset(hw);
> >> -		return 0;
> >> +		/* Reset is in progress, re-init the hw again */
> >> +		goto reinit_hw;
> >>  	}
> >>  
> >>  	/* set new topology */
> >>  	status = ice_get_set_tx_topo(hw, new_topo, size, NULL, NULL, true);
> >>  	if (status) {
> >> -		ice_debug(hw, ICE_DBG_INIT, "Set tx topology is failed\n");
> >> -		return status;
> >> +		ice_debug(hw, ICE_DBG_INIT, "Failed setting Tx topology, status %d\n",
> >> +			  status);
> >> +		status = ICE_ERR_CFG;
> >>  	}
> >>  
> >> -	/* new topology is updated, delay 1 second before issuing the CORRER */
> >> -	for (i = 0; i < 10; i++)
> >> -		ice_msec_delay(100, true);
> >> +	/* Even if Tx topology config failed, we need to CORE reset here to
> >> +	 * clear the global configuration lock. Delay 1 second to allow
> >> +	 * hardware to settle then issue a CORER
> >> +	 */
> >> +	ice_msec_delay(1000, true);
> >>  	ice_reset(hw, ICE_RESET_CORER);
> >> -	/* CORER will clear the global lock, so no explicit call
> >> -	 * required for release
> >> -	 */
> >> -	return 0;
> >> +	ice_check_reset(hw);
> >> +
> >> +reinit_hw:
> >> +	/* Since we triggered a CORER, re-initialize hardware */
> >> +	ice_deinit_hw(hw);
> >> +	if (ice_init_hw(hw)) {
> >> +		ice_debug(hw, ICE_DBG_INIT, "Failed to re-init hardware after setting Tx topology\n");
> >> +		return ICE_ERR_RESET_FAILED;
> >> +	}
> >> +
> >> +	return status;
> >>  }
> > 
> > There is a similer deinit + init combo in ice_init_pkg in the same file,
> > which is the only use of this function (in DPDK anyway). Therefore, I
> > believe that that code can be removed now that the reinit is handled by the
> > cfg_tx_topo() function.
> 
> I am not sure we can do that. We program Tx topology by taking the
> global configuration lock, then programming the topology, and then
> performing a CORE reset. We can't simply release the global config lock,
> because then DDP won't be able to download at all. We can't avoid this
> re-init, because after a CORE reset, the drivers AQ setup will be hosed
> and thus we need a re-init.
> 
> ice_init_pkg should be called after Tx topology is executed. If another
> reset occurs there, I think you may still need to do that re-init too.
> There could possibly be a complete refactor that removed the need for a
> double reset, but I am not certain.

Ok, thanks for the analysis and explanation. Taking this patch as-is.

/Bruce
