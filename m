Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05D6C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:56:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23CC64042E;
	Mon, 11 Aug 2025 12:56:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id DEA6C4013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:56:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754909786; x=1786445786;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bjWfZOSUHtGdSwXIpRfPsiKEKAxh8SHkyGPtJRV8yWc=;
 b=AW5L3i1hbGLhtyBJD1FGciKOObH5/Z36i3EJB+wvSxImVWwfJN77O3QZ
 k2T2y4ild6ILPmte7CRWQl0SxWtbwrnTHVZQhR9q3CEWyKSw0IuoSBWBz
 vusmBiFLYAwysU+/Qv7pudQBuARS+rTj24cktmM+rroNfOh3kX/teQJbo
 MDJUH5HP/B0FVVP9A+qXupPkcqhuY6Rx/cELoIYSliS/ucvJTlGlkIY1c
 RFuvIT8cE8bJgbxdcrbUB7lkF2QtIPltgNBix/DW09PSKOJnFgiMwJCXc
 hKr1HxCvamwJT2j2+gPue/tUIoueuo5ScLCqtZFBkbGHoDZbklKYaJCMc w==;
X-CSE-ConnectionGUID: BYRxSd2dT4SgDMjoXIab+g==
X-CSE-MsgGUID: cWuyeVo4SqKCb8YlRvQ6KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57238633"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="57238633"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 03:56:25 -0700
X-CSE-ConnectionGUID: 0QtACbDaRHKTr18hhI6KZQ==
X-CSE-MsgGUID: GF/dqU0hQ/mRdDTcxKJKjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="203077036"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 03:56:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 03:56:24 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 03:56:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.76) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 03:56:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTPipVJhnVn2P4mrSUH+ocDAu51grXqs9m/K2cOcfzRkU3Ivg+Why23ga8Y2ABume21SAum7h8PdvGkXwUvHxQPzG2Ct233P7PnA6dxr2sV/E5NXCSlv9jFQ1Wuz5Iare+urh+AnNH1VJGZJwZiRlSP3FxjgUGDdTy5WVpXy5/qbSC2TrRPsocgm8vD1gNxEMkRv5HvKn7RdwMRt7nYcXcB1dSaz5Wm6HtMk1V+gq+0PsRSHRq1MqBmiREVn6omFdizVJHTEilkQ2XSpsIwYzHsuiiSEveRONBuFM32jp71wttZ42CD2aQjsbDIOmA5AaA3n60V3fvwmdTLV4Xe2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fppYxbk/tZRRX6fPjn13KDc+fsf0QYzlEpfOSans0VA=;
 b=K+BF8kZfu4VBbl+mR49vNGYh7+ryj5xwTyeca742WGIbgUEvocBy5dwarloMzmuYQD0ed8/+Go8Bte0EvqUd2JBjKzKxsBGZ9nWyXiPRJyPBV5HUGK7xYVI3RgTVIg8rPjn39boZr2OV2uRdTmw5FzlYZvffT9T94qbYEKS0Hf9CUzCcO4LXiiL5nFH1hMNBWsuW8rt0zB+/rpWTqMlr1cZYZIhHxZpwHSU2gpDqQPd4gjbFNaEcN129yt9bHfI/QmTBK+Kgno5kQzrUIlaf5Ljp83Ix4KeVTTy6iFGqGDfn8rzKQWI2T76GwUyFJj1Nt5cAkGWHICLIoNKmgkwX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB5944.namprd11.prod.outlook.com (2603:10b6:510:124::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:56:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 10:56:21 +0000
Date: Mon, 11 Aug 2025 11:56:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 11/15] net/iavf: reorder enum of Rx function types
Message-ID: <aJnMULIdg88qH8AT@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
 <20250807123949.4063416-12-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250807123949.4063416-12-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0163.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 006c0746-0f34-4015-91a4-08ddd8c5b511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u3NJaNQERulTVVghSIvM/Fd5MRf+IV8j6myuJbT/vP2fwWGVy6T/GZDBbRXU?=
 =?us-ascii?Q?aL88hDGuzHVlkIPya/AZER/xnZb/Bj3mKW7SCAZT2knLa2Hbik2JVUSfqJon?=
 =?us-ascii?Q?uPi8b3aDDPtpnhV8967BZcmxSPmz5culzd4Tp1H/eI/p/Ba9GUwn9EyxHcYu?=
 =?us-ascii?Q?2XsaiMZqtxirQ0gaBDVFcHcWKEGeI2kGt62tx/n2Hq8WT+0cC+EIzGupO6nf?=
 =?us-ascii?Q?q5Ttg1Op0ILJvWtUXbYq7xSe5AAwp8jabkyjFCmCyIQAJ7bgeA2KnVsrY0N6?=
 =?us-ascii?Q?eu02NuXCoIjZq4TH/pI51kFuCc/tji0KzdHpYVWebaidQRbvX90t4AngPfsM?=
 =?us-ascii?Q?G034ak1c212ldlZ2Cp3iZ+z0dDaatrHll0GrYlljIQRYRafqFQwDLSxzQgF8?=
 =?us-ascii?Q?vJl/3MsoOws+ntt1tdap7RgKge2+Zqk0G6OPTtsBu8X4kyiQEQrTp9O2hfWu?=
 =?us-ascii?Q?eUylpthnQCdBz8Ao+H9DKczBex+58mSf2bws8kOIWj7XKp+qX3abWF0l6eQb?=
 =?us-ascii?Q?Ovowdzd0XDGYuIBYs/QTpR1Y69H+xzGr5Blp6CmxqDouOHa0kkrTw6nzFFom?=
 =?us-ascii?Q?pjU7RWpZNIeVQP8W/8oOFTd1CqmPdoGk/omkjhNtDfnPWiVdg9DHyTKKEGWF?=
 =?us-ascii?Q?HzQv0j2iQsAXSVn4TRiVg/ulSy3MhdGz0aueadvSm3ONQRk8+m3LhwxJTJpU?=
 =?us-ascii?Q?RiwdlNuJpJ2C/S6phKzExODVV+njKV3klJ98twxw4ZODMaZMsmB9w8eadszs?=
 =?us-ascii?Q?tfnTyrxGe+ZYxeb3J8ATB9AXMjstdAyD3sCX2+ELm4LxXRUEui6KL0fTYiEH?=
 =?us-ascii?Q?cxwOTNe0sIQMfvxXn+zT+6ZAhjbn961Dd0Rtk/ZgAMPvzF6DwBBbSOnwC8S8?=
 =?us-ascii?Q?zgx5+8Kpu22z2O46QnHEUVQLbFzANwK+9Cbs1RHUpDgBb9Yl5Dm2VdB9SGmp?=
 =?us-ascii?Q?voN9DbtiD5GFRUiC48X0HwFxcZMQZgZjupGJXJTQXQtclpT7qhiT0sDXapqh?=
 =?us-ascii?Q?2pRNpJPA1bralo+c1PTTXMw8BMEl/yDlAmbDiuyO8Cp4S3Ew1dUw4/B0ELUg?=
 =?us-ascii?Q?Pkc2SndYOp3B148WyzO6ysyEyvIy6k/FVT2oVSpzvQC0QQFlsI2DC1eGhkX+?=
 =?us-ascii?Q?ab5R7Ceq2w5I0eXYyCJQHd5Xcxc4ytdcAI9oXlJ3vbGXe3DYHKPZBuSRFxxw?=
 =?us-ascii?Q?aqUTac5hOGORVgHT+5Fyysuw3/5zSajKwDlZOWBG4hsFd/vAKUpttZgjBKjd?=
 =?us-ascii?Q?RiC3oJDHnKAVjymbU9KXBSONMSM0rHx9KXnmfZMqPyx0UlmzzcB9pOc9qgIF?=
 =?us-ascii?Q?xCufpu5Yvvu4capnsUUGaNbiM9sRf63fRIc/cl/A/Ordx3xrejsrf3kmd5v5?=
 =?us-ascii?Q?zLyjfEElqRTdD42mrnEjcmPuItipl4b0UfgA+vGop2lDLV8YwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zTYYKfiBLJ25JwVsAMUtghLo5f8VV10fxLn+QGnjI0T1iKnBSS5Gob8MVk94?=
 =?us-ascii?Q?tDaTKm8WLpPC05G6aFfpxCC+k8vQrvzry9saDzV9wdPZSXgwfLjxtHHhuYD0?=
 =?us-ascii?Q?rzcBrmJWj2ZKGn/7PBo8i/Ac2a7Dh8GXNwI0mJGG/yoK/ZmV2tS3SqIJUMTs?=
 =?us-ascii?Q?gbOMFnp9OzmLxJefVB5HdQ0fLNU0Fat4FZiw/oTEbvQXfEvXaJ7JVs7D9qtN?=
 =?us-ascii?Q?L55qjpFgu2T6vis72GRy6L5LYeL4uhoENz/8kOXeLTLIEFW/bv8+UuQFoz3d?=
 =?us-ascii?Q?1799gXyT1nPcBWIdoLBJddxZ1GkSVftzsmKkpWNDmAIq26o7zsQl2LPJgONa?=
 =?us-ascii?Q?C+8jQIeFOUS6Ys9sVSvBVhiWUruy+VMgtQGu+NsvOaJZ+42DyC2r26PRTzBs?=
 =?us-ascii?Q?JrClxtBpyWf4h1R8qHzNS4GGCRLsK5nezZQvLkwxqoZzNeSagA9SU117OKy2?=
 =?us-ascii?Q?g97XRuTzySD88nHfz5/QPl6l+PHNMXmZCwMS7HFgg4M9WmEPv1NnJ9DnUl9L?=
 =?us-ascii?Q?+fQIAChSEdT6aLKnXhaSMPFcVqOad+tUySjnNOY0uE8zsExZ8BnR+IsE+wRo?=
 =?us-ascii?Q?BoPGi1XUNIXcD+3ptenDcXD3eE+2H1c1Xwu8QEaLSEeNuU0U8PlAAl5nUfxC?=
 =?us-ascii?Q?PwnwjB3BR1Rk8IoKAK1kYcpXxbet5jWKdaXQqSBWBJ2Nsxfy08atTpvs3hYC?=
 =?us-ascii?Q?5/AZtiyBICjWOoAUzywfrOMZW8/wkW/fBsDMkBL0YdTIgiqoRBiXpkU/52FT?=
 =?us-ascii?Q?MU7ttyJnA/Kjdi3xNo9C/hrAsH5gofLZqtKq2g2/TMOrcm9ldBQ/AjTLPXrQ?=
 =?us-ascii?Q?brXnJrKFEME206ASra9kmRGBTT+4s2gsRbCHuWlU1Bgmjm4lEFsnNgdLUCxa?=
 =?us-ascii?Q?+GvMeeNHGWLs67pjrh2BaYagqTW0Q5HpA3j6HWJelhoZZZmFPRITi3BOx0jE?=
 =?us-ascii?Q?C6S2Vb9HwVnwe3eKXxVsSL8ubiXhi2xJS8jJEQdkT03HoMxKRU3+vfHhpPNg?=
 =?us-ascii?Q?LwpHAf0fBO8aTSkOELAmwX0NumJ9RdLylPdvZDnBSU+ApLHTPJ8fKPrlQNoI?=
 =?us-ascii?Q?nS0WNq+922Na7Uaa6ERbtyNOHODVYFFG5BftVvLkOPyDpEsFCPTKtSt+ZdLT?=
 =?us-ascii?Q?F5JDylfyVJMaT3ikYxmmtKU+G0HombvT5a6MDcp5T157iG5eSy186KPG/+/7?=
 =?us-ascii?Q?g1U6IDGupqN2EwDcWQSzUv6t70ULaU+J4YBCmPjSe7t0gTET/WdTzhzfLzdA?=
 =?us-ascii?Q?p+OeokG64g+2ubl4jnzkooMUIKlkH2Ikj2KPYxUFgXhPEugHomeShKeXCPJ/?=
 =?us-ascii?Q?hBXScUxXlG2UFgdLxW82CxfBUBG2oftdGY8wAC9bpgafpPVQIrKVdLOaEVvV?=
 =?us-ascii?Q?Yjr59of8tE2hyp/reltxLuMfn2gTC3pustdX0E2ynJjmXziIqYKAO/FTpluA?=
 =?us-ascii?Q?PIphBHSphMnF9myMVxjENySDx2STYH9w5H+ZoCfVjxtwehACFxfdk+DlldIH?=
 =?us-ascii?Q?AxulI8WW2TE87GHpL7/KFkwTXOPiymF3deIsPZt3rGTshNDL63TQ+oplzAAr?=
 =?us-ascii?Q?BsUmSFIWgZGslSJof2zfFB1Qp4htywFxxKbzu5jh7EnZDHzZ4P04mL7MsuRW?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 006c0746-0f34-4015-91a4-08ddd8c5b511
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:56:21.8368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0vFsnzQAy9RTJMRRrch0AGKDfLo8yn3rDY6ElEYTD8DixW4kSfGEygL2wTql/jgc1oPYU4Evh/fA8N+GMHmbymI1ptroqeUWyKYpyDG8Gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5944
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

On Thu, Aug 07, 2025 at 12:39:45PM +0000, Ciara Loftus wrote:
> Order the elements in the enum of Rx function types starting from
> smallest SIMD width to largest, similar to the order in the i40e and
> ice drivers.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

