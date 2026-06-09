Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA71CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 10:03:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB582402BE;
	Tue,  9 Jun 2026 12:03:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5E2704025E;
 Tue,  9 Jun 2026 12:03:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780999413; x=1812535413;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tCG8Y8BP5o55AW8A4kdKw6XX1wgTxZoSPKImMHO71bM=;
 b=eJApHK6AyPNgsBwTYUlerQGGuB0coFQP/RjcBMUBQQSBeDZEdFGh0zdP
 uKfJO7edU9OWQ/CFtlIftw6q+pSoDS6F0F1oiiA2g/RKMSIr3mU2kFePR
 +7K23azfZJkVqttqOIa9bhPZa+nHHPzREJlpg7B2YBY7EcwN3fVm4qkRR
 FHmX2a9KXWd7s45PNRqST1ehYFjw/CZR6L1yW2ljqnh7A5mRPNVYagRDi
 gDYjJnix+39diq7q3KXLFVGlPH91+nDS3RpaeGAEZsg4e/d9KZYGTEAgs
 rHJtkKTgKj6OpbkkexhES4DXk7cPS72R6Y/WCobr5/k4gLr+kmayfEuoG w==;
X-CSE-ConnectionGUID: nsv1VkfcT9WhGLZnySWCqg==
X-CSE-MsgGUID: lVrOnCqlQkyMCfWYNkKK7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="85645277"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="85645277"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 03:03:32 -0700
X-CSE-ConnectionGUID: okt5aLLHRuyTnjiSuJwNZQ==
X-CSE-MsgGUID: 5knucE5dRzmsjhI75vdI7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="242875459"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 03:03:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 03:03:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 03:03:30 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.61)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 03:03:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9Ze2Y6ZY0SPY81X+S0p6P3D9x29Xj+JXZ/otheHBKgJv1YRsU351YSNRvitEYNyb2R9JXAyUDU/xH+E0sU7r1QI5BGp8ixlKap7YPKV+xo+YCoTV0zu18iqDoukDSbh76bnw3qSLY7Apgf3FMBfkKeSR3mDYkWCrx/x13GUl2nUorFNiTs9ZW/DQDNkBWPWITSUOs3LGuYU3h4CX3x2zTFA1V4aCz8bL7J9l4T//99wFyjO0qWASS3Tr+8OIXPnxUENphcTNRdGiE8TL1vZ7eFG0Bco5xCkaswVLNnEUS1i06cDVdwpRIu8IfomrW9Y+0LOVNbvoos5Si8e0fxB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dCGzu7dsU7xqWb2SWhlL2iH1uuPAmNFO2kAvoWL8X0=;
 b=DMTNN08aSFYLbr/KGvWNXlvGpQWdO+/5ZbuIjnh5oZSkdCsHA1xaVwiivG6jE2EXk1pytQbrYiZERaUlzKdqFVmabRk16389kgvqdkyeML6lSmnqhIg9JR28iO9Bes1t47wgxtm4s7Qr7kfeSio6aWuWmA2sKlsDNEnC3CZK9Bklv4/tLeiTMk3h4iTX/yQKY/XYlk3QMCZrNrOkfoH4SmjtFxI11SgxbQVXgHAYPXWwoz9lWIeEgERz9CAX3DX0kqxGpQfQRNSkRhAiI900saLELP8QUymD8D+VF8NvMKjUhv0IJSXtaI3apwig+nRcoqQHHn1dtS4IMVqrW+OlAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB5773.namprd11.prod.outlook.com (2603:10b6:303:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 9 Jun 2026
 10:03:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 10:03:23 +0000
Date: Tue, 9 Jun 2026 11:03:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: KAVYA AV <kavyax.a.v@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <shaiq.wani@intel.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: use configured outer TPID for VLAN filter in DVM
Message-ID: <aifk5tpmr8f26gM1@bricha3-mobl1.ger.corp.intel.com>
References: <20260527161442.394593-1-kavyax.a.v@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260527161442.394593-1-kavyax.a.v@intel.com>
X-ClientProxiedBy: DUZP191CA0048.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: 9779ee6e-0a64-4ca5-fe33-08dec60e573b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZuxWwAkZtCDleSDR3MhGOYG1LLqGX8QL+LiXeOQOBreMa4ADOIdAeOSM7dG6y8K1jxVPRBc+iXvw6qxpwWqQ2awRwcVRJoH2awcT1UFBElqDFJ3+Vld9xr2eSdCLRrgZy6bRMBLFaSlQRyZ95mA5U+3seF67JNRxE4IcAyTt9jm9sqjCL2eGSoeJkVT7msF+dGZVluAueXTiL3nctH4vapwZw89SjxBZq1gDkCqqQyVOJlgQ6WfR4w2DExTrP4/woUNyhYGjktNG9U6vHycnJyLuSLEsaUQk0fFvxZrLI2tHmSg0mXEnTulGnr9xMxmyGLEbr31j9tQF6zMgNjfxeXMjhB4cyHfITi+8zRijhsozSGKqgTWKy6PPMBKxKpinDHUbXCVjO0AcpcxNP/IUUAOzJlHrXmsWRBvtWKcmSJ7hN0/CpVPrn3KRA0aJGnmOy5HgLKD3PVxIL6iOQi3Eivbidk0tnIHqbmwQXWwWOCkEtb0Z6WqtuHgv8SttoINn30lMrXG5oIamvcK45Sq5rf/fXnSVX88TD4oqGoBdzqsdGocmpgQTEd+ckTwvdnp6E9T1lIwdGYxY8s/dMlf6S66kx3RfKZFPN8hbbPX3Z0dAfoQ1AxWI5u99OHca2kTrndc6939GP9CsW3eWvTFxOE80KiHsxhY9c1lAbmDRlB/96sY7bzo+C7idkRB0Vqd+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CKXSLSf4c2BArdwTEj8e8xreZb8WJRtqE4BimhKmS0ZDtbAPZQcwF7FmBoYn?=
 =?us-ascii?Q?OOd2GT/GZ8LAcCzHJEyfw1pT57/qnJGJUyaAMGJtWl5ETNSdDL21+pYFe8fj?=
 =?us-ascii?Q?ejoswlpv+w1SqwfRLS8I0y/HqdWVMf2ZZT4RHqCPzA2JFnv9GV7AJsWixLbn?=
 =?us-ascii?Q?fFh4RLgMHvaTf1klXyC1h2Vm3IfDy9YZJy29fOQOL8PF9oQA3+dhwoCnAp1p?=
 =?us-ascii?Q?pDhhgBhEdNDkFicsYiUSBdcqsEB6EsHNlfX+vNyXte5CdXDa9Uo6zykLCdQr?=
 =?us-ascii?Q?a+xc9FYmrl1Z066Y5LPU3C5+u6sWKLIlUgWELKd2YLdGz7zlXDWdExMK1/sE?=
 =?us-ascii?Q?VsAsJ9akU5RAWlednvysIMFjFSjmivzwEvNSifuuXtZhVwBiBNsecqzis8pl?=
 =?us-ascii?Q?KdFJf+jeX9Ner0wI6inyYzvHHOMkFP6Y5gFITxVKiogXrHrCoeiLxIbIf213?=
 =?us-ascii?Q?FBqPf7x7TqzT+SyDlQyHhrnE6E0v0UjulhVCl9vs4+A3moQ/QDmw5m6iCFp6?=
 =?us-ascii?Q?PLHdOz6d+YHAfzE9U+17WoSZ9QzxfBaqW6vbBfFcc5kldp0T0ygjaxpDbmBg?=
 =?us-ascii?Q?9CoUtggpsiK8Y2fLkzJXAm97dc8BuoHUqnNL/+uxTE7p5IBIVON0qVJeMcI4?=
 =?us-ascii?Q?VwNICZ5/2S76FaHVUSf50jLQUnSRG7k+sv/ptzEZ2GQl+/g33aESv2PGwkBN?=
 =?us-ascii?Q?vE8uloK3rsAuETQIMMRuwTXyAZuleSFvfE4+0GqoQjb6upEF+ld7OJhEoOzU?=
 =?us-ascii?Q?frf+acgDThljBAlQN60WBuyHbxZUxcXBxg+TOkcTg0bZFTzMpPy3au3WAS96?=
 =?us-ascii?Q?RmiO3AiRF6gscYA7Um2+V5DDtfOKcyYKf48kazba2Y2b1qiim/q1TV8czBS8?=
 =?us-ascii?Q?lTOslrrIe9+j5JrxKnqrLYlzJEPzFB3r10mAV24QakFjWpiPXNXDN4HXjynz?=
 =?us-ascii?Q?w3XIePzbrU2miXYQCL2wdGHfF43Isz95QSQT/LvVrqRD/GugR/NED0HbHZoW?=
 =?us-ascii?Q?tMg7Gmi4SlrQ5Tepq/ZpoMad+OMdMh9Mm5ZS45wEB4bZ/mNaxjmCbOrQ1fvv?=
 =?us-ascii?Q?K4Dn1jbGM8kg+oeAVKgeqDeP6PHtSuS9IX1SMkWx+vzQAggNy0t24/h2fdMA?=
 =?us-ascii?Q?sMP/UFL/hyAjQJ99s7JwXyKu/GPC6//PgRbiOAk2rrO+jjFnzKwIzfSC8bYU?=
 =?us-ascii?Q?iKlVmiefgCzBQf6vFGxFnOf3LN0FfgkGY0Iw0XGTNJ2r2Cp0/3KZaEeHyNJD?=
 =?us-ascii?Q?MLJNlQVp3dGg5IufVIAWiwN1OS7hOwGDNiPM0znGdH0Ks40221ts09Gm3Z3z?=
 =?us-ascii?Q?w7g6J0LawH+6/NA4i2bXq2LR3VZIWo8U1V1Nq7eWQa+C5UhMFYEtuLmSgKJn?=
 =?us-ascii?Q?qVBkHNcJS1d+Dz/TyN5lvBpzEJu73EC/Fx6Lo50E+YSqml12GvXWCNhFkV+3?=
 =?us-ascii?Q?31ZMhzNTiXdiPs5P+Me9xXBd6wH0g5FT/bx/SCoTc6/Yw1nis9Mu4GTvBPcO?=
 =?us-ascii?Q?Ml9TZJVJEUfOiW2a/QNPOU7JD0afYLYAXeO4BLxFdfj2NmE9UVhzdKuosbc7?=
 =?us-ascii?Q?ndzxCoiN0TCqkQJDp2HwQ5afOcgninE80lUFxznUGNrGWTpGeHnqr2T1Qtoc?=
 =?us-ascii?Q?EyOSz/fMQBKpanGv2uM50jRJEESCw11iq4VZdXTzgkpDnMoa/lAQHpDc2919?=
 =?us-ascii?Q?PKkmPoH8yIuhTdbp9a/1VdoUHmLJ4FJa+HqH0T2CtIzG/dHCWl48XPGPmHGC?=
 =?us-ascii?Q?B4y0qQEU9Hqgp+iubtlsWcgUyTgwpQg=3D?=
X-Exchange-RoutingPolicyChecked: qOhh75gx/vt+9uYQ+5JnoLD6je5yBqKtz1tAwbFhFPeVOTOUOgdeiU49G5zDZKZvnMpuvGmOYbnrVJdyXoAhFIhlxgTt8g8jocvg27POVIT4FTJGOnQPgFc4kq0gAMu3WfA0mQwrDsMsexJurygail1HSDLlc/szgbnPoBue57lftVKlnDBba3Q0C/i99E1FOTsaE1q+EYsgr8oi+NWxO8+JSO4CXFrewmdqm8vmnSnxk2JKxtLxPF60BDPg24IljaAZOg4sUiDuqf7W0t5omO4QWERwl/tbHAcH/LBo9Gz/ErxFRYrKohmPbDFbdcLuFrBUhbzm68FkebCtgTyW0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9779ee6e-0a64-4ca5-fe33-08dec60e573b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:03:23.0042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6jwzQIMH25+yPgZU7Kxpbfcc+mxk2q3ISOAZgan5uR52GmeOO06cUb7dnz0Cc75ipA27QSlO5+18N1xQRqzQhE5ggz8Vq0s5EDDf6EndbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5773
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

On Wed, May 27, 2026 at 04:14:42PM +0000, KAVYA AV wrote:
> In Double VLAN Mode (DVM), the hardware switch recipe
> ICE_SW_LKUP_VLAN matches on both the VLAN ID and the TPID.
> Previously, ice_vlan_filter_set() always initialized the VLAN
> filter with the hardcoded RTE_ETHER_TYPE_VLAN (0x8100), regardless
> of the outer TPID configured by the user via vlan_tpid_set().
> 
> This caused a mismatch when a non-standard outer TPID such as
> 0x88a8 (IEEE 802.1ad) was configured: the hardware filter was
> programmed with TPID 0x8100 while incoming packets carried TPID
> 0x88a8, resulting in all such packets being dropped by the VLAN
> pruning logic.
> 
> Fix this by replacing the hardcoded RTE_ETHER_TYPE_VLAN with
> pf->outer_ethertype in the ICE_VLAN() macro call. This field is
> already updated by ice_vlan_tpid_set() when the user configures
> the outer TPID, and defaults to RTE_ETHER_TYPE_VLAN at
> initialization, so the change is safe for standard 802.1q traffic.
> 
> In SVM, the TPID is not part of the hardware lookup key, so this
> change has no functional impact in that mode.
> 
> Fixes: 295b34f55b00 ("net/ice: fix VLAN 0 adding based on VLAN mode")
> Cc: stable@dpdk.org
> 
> Signed-off-by: KAVYA AV <kavyax.a.v@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
