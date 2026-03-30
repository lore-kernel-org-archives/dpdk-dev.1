Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9CFFC97F3
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 15:10:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AD4140650;
	Mon, 30 Mar 2026 17:10:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 6D7AF40616
 for <dev@dpdk.org>; Mon, 30 Mar 2026 17:10:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774883402; x=1806419402;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3iTcdxyKmoFVptifwU3iheu9i2n/L+cZulssniPz2xQ=;
 b=gl8qB2C0rmQ9zcIf9wAAVOTugONpSoApZyklxcBdB8myYOIrtlRSE4Xz
 j7ZP8wwNmDc0aDgutovPkLssYCgNlUoecj8gbtzKguPELU20DRASWO6Dj
 DQj79yvMVeIDt+LCPc++xKe+uFpRPGLaDNzGt2e3Hs/in2ozQpcwL/aDF
 GFKC08aT5Rx1ZsfoeCXJgb3aR3HsmLHWoR4DJ4r/fIpu7UJFIu3xEIeE4
 786ysjiqymZEPmxNE95lpQu5cEg2TjC0669Nqby+6wt23UzGOr6JfrUR6
 t7HulSY/rHYwmQCG6OoFJx/PosmRlPP3IIG+qJgxkvwn95M7e0HMxcgOf w==;
X-CSE-ConnectionGUID: rGMhhXs/R3ignoGZrvNjyw==
X-CSE-MsgGUID: 1DiEaEz8SMuJhG/lYSKKWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="98489082"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="98489082"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 08:09:58 -0700
X-CSE-ConnectionGUID: OWrlRbTRRECcGxnVAyt40g==
X-CSE-MsgGUID: +XL6wg5JSX2DwjD8y8VL/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="230131931"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 08:09:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 08:09:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 08:09:57 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 08:09:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBGxWvvjzss10UFPdjzi8eXTDt7T3GIKnTwqRm2Yhmv7zjo/B/gmjCx9C1gxGxQtAR9O7856ezKQ1LLNBwCKySeS6w9abpuKq0+kyXQU/zNSk4Hk069/YQ7+SC3UDqg+LWHxiWsnwYrHCgyY5B6a2RZDSnVowPT6Y29jRUu1mns/NM9hUQd4bkU+5Z39yy1LFCP1NPUXTlzsFr+O6RMDAW1znYKEKv0vAMbxX37NvLY+n6W4SZUSdtOJyzuSudCBXzw3Gf7+9xLC34yU/lbhOELyxRdA+gPSlm4moXNZAFP1DvgeT/qkVoigUIeXm7oot/Tn1hQpise4J0lPzF+8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bnt5aqyJmi268kv1IUlW/pdp5C/ofinwSiVly3idgA=;
 b=H7oSW/CDbuYsIEel+EOM28w2qrG/4C0UbUr13bk4D1wq1Q5QVWnQNd1JjV4oBMK4kN54S8Gk+HlxgM/EJ2Z3jNsKMM37j61R/md8ajeaS1iXypZUomeNEdayHaax1cP4MWV6C/D8pAYSaqCc8eEXco/qziBelyB44REwTIbyJ0O+NKHsrPc6OB1QX4WD9YI84mSXSPkPvFlhrtn3jSiIYjJpiXFR0nCNEdiGkH8s5MJAv4OUEPNLj9pGMS+E22eYkt7ehno3GVgFviwf8VBWaV9iTVl1GsfyF/29qMzLjdzD8B2ZZO30qPQLhfu+SH48QkZ8BnkjRN9WM4hyh8m6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6858.namprd11.prod.outlook.com (2603:10b6:510:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 15:09:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 15:09:48 +0000
Date: Mon, 30 Mar 2026 16:09:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: hailinxx <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <rajesh.t.puttaswamy@intel.com>
Subject: Re: [PATCH v2] net/ixgbe: updated ixgbe recommended matching list
Message-ID: <acqSN7ElrO90oUAj@bricha3-mobl1.ger.corp.intel.com>
References: <20260330024518.713013-1-hailinx.xu@intel.com>
 <acqOpU2mvjABdXFU@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <acqOpU2mvjABdXFU@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0151.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 55fc17e5-10b4-4a1b-07a5-08de8e6e6259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 0+EZbTdiQxS6zi1ARG2jeq6zws5unaQlncgg768wNSsEyFCwx0G2JE/N3m9Z0OEaK9gX+Tr4yDKqFpeJB7qHHxgKxbPV5Ox+9EuhDjZeazpphS0/S+DS32tkh3dCI3/JXSUNzVrlycSYgvwZvkkQMADGpw2Y29sfNRJAMO9QK6qU5I4x3UyXq8VKwFnJQFNJEO8l61mPuwB2AS5W/b5xHAFee/Q3wOTYo9+NyXsXnZkgZi2dTMXIDOdEouH7PhM5ggxZjPedenZ7/EuThTNhsZJEnpUzeHGs5PaEzYCsjGhq7dXbmHXQVnwuM/4vmSB3cBdHEqsEFk3oyDUgQIwvUV0DpS0FqGLrlXmhrEjeD0/aatw7bz87QvqncEiUkTRggZgB9cFMj/UqJs9bMXIo1WbwhqLXhWlMcjYOpDwezEXrS8Yksd2w04Ng4ZUHplxW8sYKPBvvnkHo8pGfliJ8egE17QJvgF9yU67RLxHARfmXxr4WwrQ1YmrLmYnATxIyeL87ZwQHP8ve+c6XEeCQ9VBqYoFuwC5zQ26pLNK3V8u0Q8LjNRts2r3wERifhHZCoUI+Fl+Mb2TJrlCNF6Vp2B7G2bWX6Tj8pnWMJLEFZkMmVyoRt21tO9jBH6v1ZeD5hjoKnNUg8BcfEM09nSfXijxjFwHgFqHDsXVZitXnmbDhcaEKWwkzmK1ZRyOQrp9Glk1InwuDCpRciftCHHPRzxOIuvDo1RiyQyO1M3VLWwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7c6IgzsjGoTmh0BnoWK+UJqAbl2em7+CmKbNLAiX+vN6Vou5aJeqjhfOj0Ky?=
 =?us-ascii?Q?wk1vw52t5ysOzJWEGV3Z2mmbwYDMqaFBubcA8rxzGrBsDhZZ1tX46lgmvmO8?=
 =?us-ascii?Q?p4HQvevTGHpsmBQGYWACzzvoB/k0gKo/79DSaAPE+altHqaxC/dqh2qX9o88?=
 =?us-ascii?Q?cFdJUSwsutWz7qk3uaDm9N8wapX2QSRsLL3sltiWWickPkjasd99z6lv5oQ2?=
 =?us-ascii?Q?aAEZHrG4LnXns42uTwFPEAuZ1+RZuvo2BzGIZvRNG7yWcmm6XOcnbLLeh7vz?=
 =?us-ascii?Q?ITybtXF/5Y2i7n627RjIN3P66QFtTqI8ectNVah0lMn0LIPxL2btVvBw+UJn?=
 =?us-ascii?Q?ygr753ZiZ+mQhIFUI1litMqIrQpReKnlG2mcwhMXb/h7btfpkrHxGFMEnjUT?=
 =?us-ascii?Q?4DGtfCFtQExD+ODsGCN9d1tbpSIOQ8aNx9qXE4yXnQRpnRLsXUCW0c0/64MP?=
 =?us-ascii?Q?PQQ4MQe2GFKRwEUom2HsmjY8hbkPQAqOdePS1zfgr1DLBluQ6NLn1/F2Z07p?=
 =?us-ascii?Q?XbNYW9XjCSYEsWvybGF1yujVGbjI2zPBbDc/O5RzTRZ0UaLmLkWR6ZN4rZKv?=
 =?us-ascii?Q?+GKMLzCgbUCHf8usGx7oEERRAjVp4FGX94IUB+SzHMwoT5FJ5/+UmHEh7eyJ?=
 =?us-ascii?Q?ccUVs9ZEpbopUfdN+VU+1V4GgR+ASBV7dw+2aevgopfByIr00/+iiTIKMVjs?=
 =?us-ascii?Q?InYwRJ5fMVp09IfSCmSWxIxwBRhyX3S4OBbJdDl8O62tyzwEduPehgCrrYIl?=
 =?us-ascii?Q?dmFqMLcaac0DeK0RciwFztCJ7ceqhUnVdf6SPx4dmMTCNSFCc60rWk6Yi1gu?=
 =?us-ascii?Q?yXMLLQhqJFiGrl/z68WVumjvV9RKsKYOVWZyVCt9jHnfOGvcuzQP9etH1Mqg?=
 =?us-ascii?Q?5qSQITHoPkPSq4EJkuM7xltiBClOIwgtxN00McIWPLbcX8/KKtPuH75xT9KY?=
 =?us-ascii?Q?uoPnHYpHF6n61igMvtBQ6jnBoIFbRcZmyCNRh3S40hwWcLG9gRyzYk85xFnV?=
 =?us-ascii?Q?wxLFnUoYBebk3ja7wZzptpQvdBt12BT0xGjFHxG9JO8KYRDo7Csel5Bg3Qe/?=
 =?us-ascii?Q?5iC4Q3Smv05Bp8VH0x5cL+iQ+fg+pjj1MSKbQCXLKst01N0LlzUYE/XnXAd8?=
 =?us-ascii?Q?eltkl3pv0GqqWIjlmd8n0vLonGS46OCSwcxSo6ybNZhEz/pWb5lXXFawZtVJ?=
 =?us-ascii?Q?EqGwNyshtB2T+18Ysgvmo7Jp81uG8/cqf68JgHP3pPGqRLpeAL3Jf+yRZZ2h?=
 =?us-ascii?Q?EY7ThXlrNgfFTd+Q85PH9brt3n2dX8oX76fkKbu4wcBzCZNmc7NySMFWsTRX?=
 =?us-ascii?Q?oomcGLtZvlpoV5PqMYUiCQsA/eJleVQ0EFnh63/d0nrJEeK8ukbS4foekdbH?=
 =?us-ascii?Q?94r6l3NCPcl8jAruLoGOYkFWaKQZZcj4xOdCud+5qfa4dhSigfFE6beXn45/?=
 =?us-ascii?Q?HRIYLqTYbh26Y4jZyk1FdYYHfL1z3fJx7nDECP6McLTrsoxsgfzQwtvznrB3?=
 =?us-ascii?Q?L+cZ4FN+N/gl36Dtafnv9Im/nLJPNaYQ7ABeW4yoZhZu5oYwFLNChIdQ1Nb3?=
 =?us-ascii?Q?SatMmQpBjDq5PRS7l+7KKk84O1ZaZwbszBG5RcSbcYWpwzyts5buCZLYWwRs?=
 =?us-ascii?Q?cvdWimjopn6HOGT6hLO4SPc5CK+hSFOjScz5qr/6jzsO9FVRSWSXhlglZcrD?=
 =?us-ascii?Q?J06DrFh2X+xh5HENer3DWYO6k7oA/rwNdzHStfVDR9SsX5O5eehKNJ3kJhGy?=
 =?us-ascii?Q?9OC4MTHGt7+AGHFm65CdH0VKUCOq/Oc=3D?=
X-Exchange-RoutingPolicyChecked: XZZqnz1LKLnpq1hsY2JcJ/JtikuusMSAN9TUxFJBBIfPkGfbDuCmRfZrKMCVt+P14oEL3qAFeHdS/jcUHuxy/4x4HwNQYup8VDb1hhO7FOXjw5U9ShNHoXTXSlOtjzdZRO9XXhSiC7bfjH1rghPW5tbRXCgiOzGX9gCsw1DiQt+ou1CfhZDizmZpBuJ9/mHDgV8sl9qsYhsz0EnW3lojYOVEi57pvPFvm4nkEGyqyy+LC5zbmXR24YZ75LFYT0Pe+nHcoH5/uYHZDEcyuZduIqjktLoPyOgaEWNpBcRn8TKSPso6Yw00lSAz2NBSEw/T+ONv4jbyZEXIgJ2FBEybZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fc17e5-10b4-4a1b-07a5-08de8e6e6259
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:09:48.2846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9M76UD2k+leyFqBIo0FadnIwvxp2PtkXq+z+hLgO1VH1leg7oDSoyuHhYqvtJIW/ly8Mctd8uXBaswHySiINvdbFyi1x7db5NWxzjYCjYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6858
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

On Mon, Mar 30, 2026 at 03:54:29PM +0100, Bruce Richardson wrote:
> On Mon, Mar 30, 2026 at 02:45:18AM +0000, hailinxx wrote:
> > Signed-off-by: hailinxx <hailinx.xu@intel.com>
> > ---
> >  doc/guides/nics/ixgbe.rst | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
> > index 34e6dd361c..ea241927f6 100644
> > --- a/doc/guides/nics/ixgbe.rst
> > +++ b/doc/guides/nics/ixgbe.rst
> > @@ -54,6 +54,25 @@ They are transparently registered at runtime RX/TX execution if all condition ch
> >  Some constraints apply as pre-conditions for specific optimizations on bulk packet transfers.
> >  The following sections explain RX and TX constraints in the vPMD.
> >  
> > +Kernel driver, DDP and Firmware Matching List
> > +---------------------------------------------
> 
> No DDP for ixgbe.
> 
> > +It is highly recommended to upgrade the ixgbe kernel driver and
> > ++firmware to avoid the compatibility issues with i40e PMD.
> 
> s/i40e/ixgbe/
> 
> > +The table below shows a summary of the DPDK versions with
> > +corresponding out-of-tree Linux kernel drivers and firmware.
> > +The full list of in-tree and out-of-tree Linux kernel drivers from
> > +kernel.org and Linux distributions that were tested and verified
> > ++are listed in the Tested Platforms section of the Release Notes for each release.
> 
> Line starts with a "+" symbol, which is strange. Also above.
> 
> > +
> > ++--------------+-----------------------+-----------------+-----------------+
> > +| DPDK version | Kernel driver version | E610 FW version | X550 FW version |
> > ++==============+=======================+=================+=================+
> > +|     25.11    |         6.2.5         |       1.30      |                 |
> > ++--------------+-----------------------+-----------------+-----------------+
> > +|     26.03    |         6.3.4         |       1.41      |       3.70      |
> > ++--------------+-----------------------+-----------------+-----------------+
> > +
> 
> I tend to prefer newest-first for these tables, which would match the
> latest commits to ice and i40e driver docs.
> 
> I'll make all these changes on apply, since time is short for the release.
> 
> > +
> >  RX Constraints
> >  ~~~~~~~~~~~~~~
> >  

Issues highlighted above fixed on apply.
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce

