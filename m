Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F6A1061B09
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 14:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EFB340650;
	Mon, 30 Mar 2026 16:54:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id CA11540616
 for <dev@dpdk.org>; Mon, 30 Mar 2026 16:54:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774882484; x=1806418484;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Jx3FEz6aEgqyr/0JerAoxWawX4Fd5F8KAPy4H3dZpYg=;
 b=SDJmUOqoHxEPszVd8VBt9q4MydKrjJ6Hyms8VyIJDym7Yq02E1vWbczK
 0zU+/1VzXSLVIi/gxmURkvZZ1nTbASkR+AleQXY0OurTk9rPTuln7+rRg
 FpB9IQnAJUYyiFkdICugWIUMKaWjsNDqPykI/F9Nsw8X2d072pI+M3/SO
 0DFMVj3TbW0o2avK63su2hHyPGmH4/YQjRQxnTDybTVgZqF5wTrbGcMXY
 PJUSG5UmLckPFkczLbAwJTyhkDKGDuQZ5NI/EF2xZdDqVIcmC6CrGV9ai
 jNlKa+gsu0LMqJGBA5VotfA3Z1TIN3R979Yt4Mz829F4WW4AuYbd7gk3m Q==;
X-CSE-ConnectionGUID: uwLHHvibS9mtKynVs5ZiJg==
X-CSE-MsgGUID: UAe6cp23Q1mdzfMhqu174Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79478953"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="79478953"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:54:43 -0700
X-CSE-ConnectionGUID: KzC0GPYkTde0SorSBIDXVA==
X-CSE-MsgGUID: t9JccGVcQrmshK6rwkvSdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="219428509"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:54:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 07:54:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 07:54:41 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 07:54:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWT4WIF0MvkICt3usPBEBquUNLHfVilRpOPfrsqNz/Zq1v7Vf9NBeXpGBajlx87N67jp0DzdJXRxxibFu/QPlGiKH82k9lxza/bvl7m/2PRL+Zmq/SUIumP2S3SP9UiXKg0YEnz1A3jhNU2BAs/LUJG9XfToga9aU6q53CX/4vz16mbOU5wjmTWhTj2gMRKs69Wb+sZJ/tMCbwMc9XHMO4zbeGBm5juqBgaplSO6lUcdVat74Ua6qOZqJbzWIk9CEWMWBWfafVXmSZWHcyWB1OvScWR5+agX5/a1BxUTkx7BDLR6S6EDjw9fWT5xLxYgsgSyc4kU+dxt+YBf7YWE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoNU239WYci7pbK6YMrET7wXccWI0xMhxWZI02rbr0s=;
 b=oKzT6SWrQzPnzJdDdQqQ+5kI5cflPVJYe+gusWBGiARQhBUp3h+huRC9B13vJY9w9AolDKqGbjYKJi8UY5P6EkZTzjxLlptsGvr99+38yecYMbduBc267df1mRaPnP5stKzLgWoNFiXatRLt1FRks6e+bqBEMvfzFkEvPPtYCT/9O7yJP6g96VwEzTt82sPulEM5s/YnqAm68INCyY2UGJdHtLzYeq787uTOtNI+hCRGXxLXmcZqjCxQIHkiN59sDGpNlheeBxNEjSnD5TMk9s0lJYeuG+gpxNbV0LLJspNZBO8rzwOPoL/NAYXex/8yKIB9ho+aoCDYyZE8nnR5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB9748.namprd11.prod.outlook.com (2603:10b6:510:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:54:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 14:54:33 +0000
Date: Mon, 30 Mar 2026 15:54:29 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: hailinxx <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <rajesh.t.puttaswamy@intel.com>
Subject: Re: [PATCH v2] net/ixgbe: updated ixgbe recommended matching list
Message-ID: <acqOpU2mvjABdXFU@bricha3-mobl1.ger.corp.intel.com>
References: <20260330024518.713013-1-hailinx.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260330024518.713013-1-hailinx.xu@intel.com>
X-ClientProxiedBy: DU2PR04CA0186.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c29712a-2b42-4611-f197-08de8e6c4144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: +AcRf5SnuJfnBwsv5IZqBNr3dYdg/2Z0mSt11PaNMQkNw0z9TVf5KfLTRQVrcdAx6Ugtpua1fQwfCsF9QJaAD0wuD5fxY10Vcf2d7ztgN8qZQ+WTHckIb1yggwJPkBtT2uoYspN5loqZcC6JJU2zFKGlc02Tlp+PPY0VUtqcplO4yvL/YnMORHA9b/FIfSmIg/Bc8ZhOS7isPAkIESeSN5HLx2+EWt2jKtIWeu1SUP3z24Ro5LdClC2ZSWvFeg+OEQM9mKW3DbyGCKf0AUv5iadZfOK2T+aekPa/nCuplY0skGdH4YgcL6kL3lhGJ/V7EH4UT1xWgEPeliIzuHq1wrY7B3Fl4y5maf0djbXUrwEDErVXKve8XPcvERWNPKrGtYiI/9SazILgl6s/Eyabn8GaRrE+CGWzfhxaL0f/H29L8mWkAolC1zI2LNn+aDyMQmrJK4j9dpWqPYH+PrqJI0OQ4eRBZDxR1MP3R1ko3ic44akNAe7FBujRaiOY/3qDAM97oRm9eZq3Yesed8TE+px8H2OU/wO/m8t8Ehg4noFObmo5ky36nFr69o6AzwiUOBwpTPDymVxJnbasRw8S+85xCmLT8sx0TNCeeBJ6/1Z2kk9gmJty/rsCdXol+GrqT4p3ueynjNaUE3L3DaNwVrTw9flHvOcTbkdOK27R1tT1JYBI+IY0ycMRiPvXdm/55KQbNm7I6CN9o1bONziYJsdLKRq8MgE5GNM7RO7nYnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ky+llFXu3LzeXMfSKtLFQG5zrWYBew9iCkvIRy2df1n5CNkGikvDw03iudmE?=
 =?us-ascii?Q?t0CK0TSykPqeIRSIxmwSia/UtBxkqve6+Gf8fq03Tpgn9pAdEhtkhU8xpitH?=
 =?us-ascii?Q?RV73Yh6ymJiLuKeElDaN45Rx/AjrxSz1GvsGEsJ/GglAYDSOnTts9Vh81DLb?=
 =?us-ascii?Q?GoKIgzsKjqu0OCW8nj6st7vHo/vwRo6DS3WE7ILardKuoPDtCk43aaSky/MJ?=
 =?us-ascii?Q?9OnNbjTcSLXgwk0xQch70zx4YjM7lhfbOldO2t3VpUmtOVgyaLK3UwMIVazw?=
 =?us-ascii?Q?EDcdgOkRbQTxeu6g1kygzW4seTk3nTqQ+tBcXh6UoEQcIuopgovvxgyfxy4/?=
 =?us-ascii?Q?7fGYyJbkCcTK4Gl04sNyAADY7IOhbSOWeTtQOZtPcOLNFowjDA19KoJ9Tpj5?=
 =?us-ascii?Q?GlZU/cQjhIBcEp9492XfQORe5vdHkgMJCe28lxmrtrDl2eU/gSfc+L1+Etp6?=
 =?us-ascii?Q?OhYYDi+I4ZZxqKlOkgc1W0czCunPU46kQqbX+sAvtPAhtqNBMq58Cj1CCEim?=
 =?us-ascii?Q?TppTzGWDUk0t1qImncXf2miOD0Gvsuwsx/bW8aYEFuTfXUU//7QRscmVY6T0?=
 =?us-ascii?Q?JuJzvlybIf12drzgpJ+aQ9esJ+e0+N4mLOO1qBkQAxsmmla4zbKOQJmhFj2k?=
 =?us-ascii?Q?5eKXnJubgVcCueyhMqSjxBCudEmxd+hknOdufJ/cgw4bEiiw1v7+FXHWwJwJ?=
 =?us-ascii?Q?sTRlwp23u4dB+z6PhHbelKf1eXFzbhKIjOnrff6GS0OQxQxUwnqGwhxFuFWK?=
 =?us-ascii?Q?7spLAGZ7MDW780a4yUQq/UDonD4chZC/quJn/7F5yBLYtRnWz3fDbwoF6Lba?=
 =?us-ascii?Q?6h7S6YIDYrwK5+IcedoztUnyo0/xdMqnYgxxkjplAQQyKBLjFuppWGS1Quog?=
 =?us-ascii?Q?LpNDjq+7kuLuPu1/FKkAta+76NuAyECMGIdBNGUuxpel7DbSKUeH2ho9jetz?=
 =?us-ascii?Q?dr9m6TEfPN30mUtnbTR+Qt/aTizbt25PE11q27DBphIbUQPImR+LW02xEOxH?=
 =?us-ascii?Q?En3qVfh7MOgy1eIvPThUfm1mIduNjj8RWji0EHGF2TASnzPUmIqY2mwEiqiK?=
 =?us-ascii?Q?sGUDAk5HWIXN8uB+XpIj/ZBNaDRP1xoRbtHPjK0JBt/Dn2KtPcHLp9bFdAbV?=
 =?us-ascii?Q?69mvA9FTbGXvMwGhIy3kzzE1lxdfT/RXfHTZuyj4/zmycfIfz07Pjg4oxEbW?=
 =?us-ascii?Q?EH3Xl7JjqdC8uq/T/UzNnL2xcISGAPIW0pYP9bbpGAT0Twmjo0JNnOdwHK8l?=
 =?us-ascii?Q?nzUGVPRlduFKUgXw6erC2KJN0aNUMo9PqqBL0GltKnVMJsAgsj7lSmNFO+qO?=
 =?us-ascii?Q?a1wYG5qslbl2D3A5ZZgD8uoeBR/5GtEJ4Dm6o2yVJXnsKroVMYHagnLBCLap?=
 =?us-ascii?Q?RUZdKKvvIif2Tjm9p1sye7fC1/4cVNGYMRd7Rllw50bu5goi2cRd+RFjHW3Q?=
 =?us-ascii?Q?XusjVUlKPEElsF+Nk0YEJGJr/JJVtPuEHAPlqj4XXKVPKAWiClWLE9m9pq+R?=
 =?us-ascii?Q?42XiBl3vcCJvpxHKN9bvfDlRkqbGxMjWWKnSONKhmC9SZSqWaRctl+pk4zSC?=
 =?us-ascii?Q?jZedVsSIwXngV5/uPN+ALpA8CFUlLtCiMlcVTYKF7T3z5Jf9HGMVy5Y8bKmC?=
 =?us-ascii?Q?7+aJBWBifKFh6sMa8GPpebfHn/NMQikXJwL038iUMo69IFqpsIbzNyqUW7BU?=
 =?us-ascii?Q?eNi2gOl31IhGkoc7gO67Nk3V6xI2h/ntWM92pwKzc4qJyFTNckblxrIWxnIr?=
 =?us-ascii?Q?GImGYvYms65yUJrCWiUGP6HydGnEHxU=3D?=
X-Exchange-RoutingPolicyChecked: aqOVR6spuO2L1bfA4oN4JZsnphv3JZZhJEYiPp05tGRbBQ/Vo6aw8V9JculCx76DbSCiHcg6QGiGdTQvarrVAKBQzTlRBScVi+VKnkEtUfmsdGSmigjwFbcsDwnjqHWPPbxyJ0yKPZR/QheN1Vu+xx5Q8+0YSu4bjsYrrrOL2flt/W6Mqw7Mixc3pE73StX4fq/L8ZJJ95MQSDb1Dp8ZBsFaR7kyIdpRcsqhfFqbocmaopUWmjgZl/BBR6pZxmbVuL7qvK4cbacUdCL8u/JGohqFYRnUqbgRXMrn53dDUDPg0tuupyLip3oHUtiKTMKR3bCm6rvhzRG0MaY9PnFiIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c29712a-2b42-4611-f197-08de8e6c4144
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:54:33.8106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZ+JV1YfGZwqWgD0gPfQWEqndALmHrsLTmW/zgb7tqaedcRuagFRvFt3wdooUWa6Iwgc3J+RbY1n9Qqig20puES6PbXXmxZ82vM7oAuRdZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9748
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

On Mon, Mar 30, 2026 at 02:45:18AM +0000, hailinxx wrote:
> Signed-off-by: hailinxx <hailinx.xu@intel.com>
> ---
>  doc/guides/nics/ixgbe.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
> index 34e6dd361c..ea241927f6 100644
> --- a/doc/guides/nics/ixgbe.rst
> +++ b/doc/guides/nics/ixgbe.rst
> @@ -54,6 +54,25 @@ They are transparently registered at runtime RX/TX execution if all condition ch
>  Some constraints apply as pre-conditions for specific optimizations on bulk packet transfers.
>  The following sections explain RX and TX constraints in the vPMD.
>  
> +Kernel driver, DDP and Firmware Matching List
> +---------------------------------------------

No DDP for ixgbe.

> +It is highly recommended to upgrade the ixgbe kernel driver and
> ++firmware to avoid the compatibility issues with i40e PMD.

s/i40e/ixgbe/

> +The table below shows a summary of the DPDK versions with
> +corresponding out-of-tree Linux kernel drivers and firmware.
> +The full list of in-tree and out-of-tree Linux kernel drivers from
> +kernel.org and Linux distributions that were tested and verified
> ++are listed in the Tested Platforms section of the Release Notes for each release.

Line starts with a "+" symbol, which is strange. Also above.

> +
> ++--------------+-----------------------+-----------------+-----------------+
> +| DPDK version | Kernel driver version | E610 FW version | X550 FW version |
> ++==============+=======================+=================+=================+
> +|     25.11    |         6.2.5         |       1.30      |                 |
> ++--------------+-----------------------+-----------------+-----------------+
> +|     26.03    |         6.3.4         |       1.41      |       3.70      |
> ++--------------+-----------------------+-----------------+-----------------+
> +

I tend to prefer newest-first for these tables, which would match the
latest commits to ice and i40e driver docs.

I'll make all these changes on apply, since time is short for the release.

> +
>  RX Constraints
>  ~~~~~~~~~~~~~~
>  
> -- 
> 2.34.1
> 
