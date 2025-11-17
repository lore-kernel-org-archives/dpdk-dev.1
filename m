Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10981CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 11:49:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FE3D40262;
	Mon, 17 Nov 2025 12:49:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id C03DC4025A
 for <dev@dpdk.org>; Mon, 17 Nov 2025 12:49:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763380192; x=1794916192;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2dZa1oAmz/XOOd5Gwx5FN6rp5CXPUDOIlYWRnRsxQeQ=;
 b=L62C8p47jdwp4wOnGQ0PNVXnXQNYP+gQ9SD2DnBENvh+sObSp1bOKiIO
 EQKQiToTJK4iPmRn17zJKNsM6/NspHDO7IsiMa2/XIfbkFiQumP9ygHe8
 9ZLPusNUpx3kAwKExErXlvux8ZFTY7hR4TYU2JKiZ27iLEfwoNGn9us1S
 zpd1BDPrvYsBYg9KNp6UPN6L5QTjLk48qR/9r3sCysQIxhnV2lOmIWD6R
 hyr1omKIcLmV7Uhaq1lKd1DaVHZYzqmqXunc2JTul6AHH4fQDKt3rDlkF
 Snd8WLYnGTM3fFKOBGosGFyt/YDiGiTOuZr/8eDbGzrusVmWYRZ1g4xtw w==;
X-CSE-ConnectionGUID: mHjDkR+cSJGe34t22+GaGw==
X-CSE-MsgGUID: EatuAkOWQfe4OK8yX59THQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76479026"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="76479026"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 03:49:50 -0800
X-CSE-ConnectionGUID: ykBR0ancTjyoePlt+ae5dg==
X-CSE-MsgGUID: 91hQc7hkSH+koM03aZDfJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="190583584"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 03:49:51 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 03:49:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 03:49:50 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 03:49:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6DUq/mOvBX/hhM1dfn2jeTTc7kHnyh6mW3qKZzGcyYFlDUto1z1ChaBkcUtGzQAqsgjU51lMmKQ9d7Tmvq0E/WbOyvLLlv7FYflWKYT/hJDFsV7TSEa3Cd1V7VZ+9TB4s7lxBcenkbMo/9v8a8sIpneuIDBbYPFO/xDbKyiCGxBLJsMKgmwV/dwiJkf7YrIhbhruIei/fKoaztXYQYmO0gzRizT0yVZxZkiLFWmTSBKUhm1QGqpB4y3O4fqO1IIn5DNZAwIiTauEseoXDwP1l/lD96//uGE26SV084g/T7OmcAgFheNCt8Bgyaqbv/DDgEo0JSur3jJhvqfpdBQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3BY/edDoXKovxKEgHq9AUuO/fJVbcJvhBVakm25Wjc=;
 b=VHdu1JblqpKIxwALTAffv3zazhlA+YArXQgNGde3GwSgsoKo53CdLvpmeDzFe+L2qwtykp0dCLJq+Qqefv6Dq4GBgY+eps4j+4ApCZEdxfU7AtTjIJM9ACIaMnOMmRtc0yF0fjRPNtd3sGFwOHssZeJ9LrfS54LpmTwsPX+i20N2H+NfYnD18OSuyCJ6po5glAy3oqnp7DyJUg/+qwYtlZEpkGSJXXQKJet/ckAjD5PNOlqTBVhwUpq+ujm3BmynosQYHfQb5OGg7KYd/5mpRb05Njq6Xlnw2rHGDM8+gdknKPHLIAVFZhSIkdnobPtybYpsoUWiGlOF6EnwA8uUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6992.namprd11.prod.outlook.com (2603:10b6:806:2b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:49:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 11:49:48 +0000
Date: Mon, 17 Nov 2025 11:49:43 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: <dev@dpdk.org>, Paul Greenwalt <paul.greenwalt@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH 0/2] net/iavf: handle PF not enabling Rx timestamps
 properly
Message-ID: <aRsL1yPeV12ZV-ae@bricha3-mobl1.ger.corp.intel.com>
References: <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-0-3d9a0168087b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251113-jk-dpdk-iavf-rx-timestamping-improvements-v1-0-3d9a0168087b@intel.com>
X-ClientProxiedBy: DU2PR04CA0235.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::30) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: a8714047-c521-4b11-fd84-08de25cf68d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z1RUXipOTLBQMClLIPlsIa6XlWtQcoJ20wwpXX8i09QdRWGledw9iaNHBp37?=
 =?us-ascii?Q?w4+aV+5jJaf5+3V5tPiM/GWLn85kmY9oyW55hae1rhuhYNkYxPA9Frs3trCm?=
 =?us-ascii?Q?DZg6q/MtHzjOhP1WVL+mYNJghNUHiQTveLUhqqSfNZZFwHS3IRt3EmPGoZ4O?=
 =?us-ascii?Q?0ICymSZMes6emvYEL3naHff7MpBQ4f5KTxHD5BD0gI8VEeGhPGJyDLbD+N5H?=
 =?us-ascii?Q?81X7XDu29IAlGRxleGuW4Lxm2hJVxsk+7QULLpn0p4Vj5MaED06iDYi/6GVb?=
 =?us-ascii?Q?6KexT2/m3BQ9nzUMbHkl/klIp7sDXqlWxQHh8ke4p2CFfGok3nokuMY6Za6v?=
 =?us-ascii?Q?uA+vfa/LYeyCkYNbr0vHrb2NtKmzOWtdZIfcvOyV/t6J/WN81rFgFggJxbTc?=
 =?us-ascii?Q?lx/nbMwa9/8B0wHsdNHfV87H3uJAuSecJTqnZVRNvKHu7wclO2q3nG25xXPX?=
 =?us-ascii?Q?I8NfJBLm3zksU/DPhMWXui2udeKsQZdreyRmb07V6StQb0AQCMHSUzc0jftp?=
 =?us-ascii?Q?3ocj2+HBVUzM6I4Dje2nSczB7v5OtZUcV7HOXbh1wHhsyKNAJN9OY4g7Un7+?=
 =?us-ascii?Q?ilZsuxtg5AjH5H50oL2UR2pVex/zkRW8LQXC4Lb6fN3PsB3WU8jSuxkwghW7?=
 =?us-ascii?Q?6vzR9f2jCRzA01+pvfrBXZ795reAYXSpkQ5IDzZT496XkptN/QCnPBSZwgv1?=
 =?us-ascii?Q?Tw419FHG69YntL2HSUIlbMxCAsJhfpxqcEk6GCHPMa4f813tH8Q6d4mXmtNa?=
 =?us-ascii?Q?K5bAbgyugWc4ysxB37De4uGb4U/IgdPAXNExEu7X5Ps/hrCnAu94us/Q2RG7?=
 =?us-ascii?Q?h1uN8GjUvqvQzMZ7Brkx5WJeH0JpuV6E4BN/6ctiiXltFKnTzKdRZp5qUOO9?=
 =?us-ascii?Q?WXKImg/GTHBj1U1R1ZM5cT+gtqzvbDXtIchSWX25yqc1EsrUcBShKBEPBJQG?=
 =?us-ascii?Q?50NPgO58phd3qL7WDQUSN8YExy5cEGjKJ69m2z16xGI2F/QGn4KBEaxV0NQW?=
 =?us-ascii?Q?S1XIvXuOsnA/IjFs3mJXhdoUe8Umeh0zLZpFNz82lh5AFecrYffPJU2G1otj?=
 =?us-ascii?Q?LEjeCF82fzOj+0RB8Vi9ip+D3XPsGhkrtTxIn6u1YHBAao5SfYW7x/9xiYiU?=
 =?us-ascii?Q?J7+bxDbDSf69au3mDXnApUyUMXQ4rFxAVSNT0y8fpMi1ZiBlmXpuZj/hQ8jE?=
 =?us-ascii?Q?+UiZAurkaPdk4O+Og/iCMYKVYRwUHbTCqvSt+j+bylvaAXzrdVzyurxsK8/L?=
 =?us-ascii?Q?GxKTQltj3dZLNH3KB6jFEyn9ccvqqQ/IBOOTzeLYtQD5pNiI/DykNS4v+Il+?=
 =?us-ascii?Q?8FnB62X6L1oaCxl8Ui0ZjlukD6gwBtF41nbZRsvbtWsg7hZQZph7ul64gwmf?=
 =?us-ascii?Q?GSNys/JLrGoC/vSwyuOSCBTECDNccepY3hf0cz/Jl37B7KuXl96d59fgjNPG?=
 =?us-ascii?Q?1mNudoNLYtiJJRWRk3pc9Sw8qtUIyzmQshXlY+JMyDv9NujPq1CZJw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ZNNqT1aCKfrHhJeg5YVr/jECPGtNctnt3s0ohyHfirpmW6NGJ8icVI55Cea?=
 =?us-ascii?Q?uvxQcvoRpSSZ0jioiMl3k9jj1eF1YpfqtIMrjMxe0b/sRXpMi7Rr6Pop0x1K?=
 =?us-ascii?Q?kzMGRbZ8/Zg75FZU12t8fdT7lx0YdbUl0vVS2DLV9+6/1p6gbLTQWK0NNGNn?=
 =?us-ascii?Q?Oup+77EkQ2Proy6q6oYqc+zbATJxhSHyVyfUCvjQDkaP+kKb6BCEUWwB9Ls2?=
 =?us-ascii?Q?XpVb24Pwy8myXgbKnKIS1VpBUn3dWwNV2tix1xOmIK021I6LMBEhQXNU8VX7?=
 =?us-ascii?Q?zgHmgo3QvQndzu6Aoc3rmrigWOkjFAmkeLEMWH8fwLjHhcudFT5WXlyenq6I?=
 =?us-ascii?Q?bQQeNBC4DR01npsITwsz0DMnLw/kDuZEN4hpuxvd7c3iwnfHnKAB4M8ZcDab?=
 =?us-ascii?Q?rA638B4QNYuuhvMkJOgbMLNHWtE5KmMAqhBV4RUUHaJfbVuMJw8YzIUYm9yd?=
 =?us-ascii?Q?C90TKywSaGkqMOvvJBTXZdgubN2xbJPc1+jI9Mly1Gk5o+63iEXDQyj7uYeE?=
 =?us-ascii?Q?Ec6Daz6zFEsU5gDk/azN9aCU/bFvtpwPmlwVTvMrSBknKsFSwQMO00pMOZp6?=
 =?us-ascii?Q?Ol9CFzT8LoBcIcO2BtwNfsBAdcytrKAKH/C3flj0uSbK82abBRLW3y+bEXGA?=
 =?us-ascii?Q?m/+9tfZRB+Axm8J21pfomUofbLGZB13ZceacYb7/knD8Y/uKbEZe4yRKrWXo?=
 =?us-ascii?Q?EOMQiubUZjY+I30kDtO7jmp0xQ4tsK6/ucIC+ez0p7o3lOh7WUcfluy8xnz2?=
 =?us-ascii?Q?VP9OOjCu3BZFOxFC38tWFMtGDLQvZFUDwP8cbdh4/PJ1aI/+ykvmzLKdTR6P?=
 =?us-ascii?Q?Eye9sHqlUWPAeBuvdfVonn2ejwDx8ahpbhr9A9ey+vR1qKg5iU9eQsjZV12y?=
 =?us-ascii?Q?qfgosJirlEaNYs4X+drIw8ndpMzJaMe4TePUf1b6RJUyaGXFhbmInQvwZPCy?=
 =?us-ascii?Q?m5jXrdg41sT7SCaL/de1KizeAusW8jtuAu+oXe801mIixVoHytAD4R71tEkO?=
 =?us-ascii?Q?s5QbqG39NcxUm4ky8wWKozMe8781X9g5Y/v4U0Q5UnvKeuUpvTH2bEY1qjdc?=
 =?us-ascii?Q?BqM08QkMpJlypGuTHXlItEVinwRgdPbz5RK+p+v0jeo8DuL5GlaL0HfdJTcc?=
 =?us-ascii?Q?JUCrY5+D7oEFo85VOiUVOIaOzijrkVdRTwfkfU809SdkWU177GidG7jxpJCM?=
 =?us-ascii?Q?UIzcV5Y2aeuW0hzm7lUMwGZIJsg7AJO4yZ+vDn7Y8mdaYQSYDCpOdP40YBtG?=
 =?us-ascii?Q?gSK/INx5XDXgabRUcok5oP8OHUZSiLwH45foBS6ya9TnIqZ4ZZUgw15Qny9N?=
 =?us-ascii?Q?CUugQeXT+cdxIucvVBBNmHMa9niKEGUoJ9rrxDBIev6lkUfVlzlyVLNO/HLt?=
 =?us-ascii?Q?UDDpdmZjdrKUJURtpIgaKNY1QA59oygW/RYz79Afl6AcWsLAKeDT5ZAQditP?=
 =?us-ascii?Q?orH/PTyIeaGLSw1swWr+MwWMAx0Hg3q3hwp/wmkPI3aLV53DY5g9mAUe/UP+?=
 =?us-ascii?Q?Bi5o7BzCfJnXS1y7DEFmfon1265M3GXHToCB2L8JH6HPx+OxQLoj5+jwr0CO?=
 =?us-ascii?Q?rgtF900mONAEYhYVeXgUoVKrtzh4vW8A1S6k1d/wUN7qZZczwhVpzYeVjlVT?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8714047-c521-4b11-fd84-08de25cf68d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:49:48.2545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXNWZ3I55g8wVU3MxLDQlvilRcSdmYstvMukVjPx/ri22IwXUq4d295SShdXuvB6wqMegLa9+beWhRH4nSLFAiQ8/X4Q/cZzTKtUw/lCznE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6992
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

On Thu, Nov 13, 2025 at 01:33:43PM -0800, Jacob Keller wrote:
> In certain cases, the PF for the iavf driver may support
> VIRTCHNL_VF_CAP_PTP but will not enable Rx timestamps. If this occurs, the
> iavf driver will attempt to continue anyways. When that happens, the
> resulting timestamps will appear to function initially. Upon closer
> inspection it becomes clear that the timestamps are invalid and bogus.
> 
> First, when reporting a timestamp, always check the validity bit instead of
> blindly reporting it. This avoids extending an invalid (likely zero'd)
> timestamp value from the Rx descriptor.
> 
> Second, don't enable the RTE_ETH_RX_OFFLOAD_TIMESTAMP capability if the PF
> doesn't indicate we have support. This will prevent applications from
> trying to timestamp when it is not properly enabled.
> 
> Typically, this should not happen, as the PFs which support
> VIRTCHNL_VF_CAP_PTP should support Rx timestamping. However, we recently
> discovered a flaw in some implementations of the
> VIRTCHNL_OP_1588_PTP_GET_CAPS command. The layout of the capabilities
> structure is incorrect, with the caps member placed at a different byte
> offset than the expected structure layout. This is the case with the
> upstream Linux ice PF driver.
> 
> This results in the PF rejecting the request for Rx timestamping, and
> leaving timestamping disabled. A proper fix for this situation is
> difficult. If we merely changed the structure layout in DPDK, then it would
> stop being compatible with other host OSes and with other implementations
> of the Linux ice PF. If we changed the layout upstream, it would break
> compatibility with the upstream iAVF VF driver.
> 
> A proper fix to resolve this will take some time, as we will likely have to
> introduce a new flag or ops capability across many drivers. In the mean
> time, we should at least make sure the DPDK driver stops reporting bogus
> timestamps in such a setup.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Jacob Keller (2):
>       net/iavf: check if PF actually indicates Rx timestamps
>       net/iavf: check Rx timestamp validity bit
> 
Series applied to dpdk-next-net-intel.

Thanks,
/Bruce
