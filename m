Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F61CCD1A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 11:44:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1881B4060F;
	Tue, 21 Oct 2025 13:44:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4CBAD400D5
 for <dev@dpdk.org>; Tue, 21 Oct 2025 13:44:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761047073; x=1792583073;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xsvR5t1kYL62whEnaBWEIgKEmm5lC1voxNAp/kmUt5Y=;
 b=IC9THVfXdDzx/OhSrOfhtM59Qmn77pVzI2UOBrawmY6jyJ3YzMv0eNsB
 xdDvr+90UQkAc9IBytib6ym3d81oCAgEXcfWK2XweTNNHmcNc4rLzMkqQ
 BWKmX9v33YUUxgweRBndTQQM1FiVnNGsPi9PuN1H9YLztlwMIO9wcSDvh
 jj6PTZLlV+Cr1K+o/DO3i5kBJmkmklpelyftAwgyPoFQ8h1qLrhW+uZII
 7nBSOX+LISx4ciXgIeXP7nXfl/0PMc4S/scwr6+aYPm8SzFbdz8pj3GkH
 jTAfxSXMlQjiqljNkn76WMDDqqfFj4UgXA2ppx3jHhQUjtNZ+EpKkockK g==;
X-CSE-ConnectionGUID: N3IgVAwwR8eaZxoqjwOcag==
X-CSE-MsgGUID: Ji+acXkEQP6NPPZpKctBhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65785628"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; d="scan'208";a="65785628"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2025 04:44:32 -0700
X-CSE-ConnectionGUID: 37qUE1CbQYueAzrtHclbSQ==
X-CSE-MsgGUID: obPMhke1RlS3vsuq3O8kbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; d="scan'208";a="182728467"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2025 04:44:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 04:44:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 04:44:31 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 04:44:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEiNpcSzxltMlqNvB2bZWyZjeyHVns+tPdWC9YAl1M1snu2Vv6IAhYy3J1B6qgKDBQW3RU+fowGbBg4crdkjf/9vNWtmfhMzPdAPzBkpdv036l3NC1gd2M7nERUqupp/rK8Dv9iqQEIYbL7XgacgSomXBgAwApeNYZJDWnIv0UXZTOXT5IgPl4Q74N2/dok7ILsM0zOEEsi88VRC++oTXRqiBzrqQLfgVReKktAvMWL1U5JguWOh9DPlCnTqMIUd2hE8DPrmZqkiovZ+3Jr6ax7SRU9V3zlq7eIjy84C2ayLELsnsAHKQCaC5ZjhP7Y+drWWp+EMhYDo4EPlNsO9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkVr35J3Lq4RW9f9odwevzpA+7c24W67LbKUYCUGzFE=;
 b=AsS0wTyEv3/XWTZiTSgNHs0qMvJRLywFZhunSKp/vWEqdpSwDy2/BZfS+Ip8hpHm3A2TZPEkLJx54Z5ZysovmgNi+r2JvKIEyam51LtBRBww/oj/NF0gfirdPErNWLCIbSFgubMvebcaZzyoW4Rp6iWbw0t1/N6X1gg3sD2pg2ADKCvljQ8XCzUDCDRccS/x4o5MdG7g3TWFgQnjQMKktJWzgqoecagBi0bmdpqPoAUhKmHdf2xMGaWyKtgvtu9Qzk2hIoi8GTWN5IrxqSPLJtfiUDr3LtmpRUvidLUAsYbn9HGjspNl/+RHxS8cxa4p715elMHV1Ov3JfPHZIiHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 11:44:29 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 11:44:29 +0000
Date: Tue, 21 Oct 2025 12:44:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jeff Shaw <jeffrey.b.shaw@intel.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH] Revert "net/ice: count drop-all filter in Rx stats"
Message-ID: <aPdyF7ocfwQew174@bricha3-mobl1.ger.corp.intel.com>
References: <20251020164230.3724539-1-jeffrey.b.shaw@intel.com>
 <aPZno9kkhEkPhIw5@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aPZno9kkhEkPhIw5@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0152.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::27) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|MW3PR11MB4748:EE_
X-MS-Office365-Filtering-Correlation-Id: 27241d35-4ad0-4bd6-86e0-08de10973142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xUxC6vmWrECJjaQb0mgKAflm178VAtddQxav6ahrqxyK5HGGqrX8GZG/LrQ5?=
 =?us-ascii?Q?dwFV9tmeNeo/ao/sRlTkOHmyQ+D1Tx03Z1ELx7wEgtsQ7t5A2kExxzzwNgV7?=
 =?us-ascii?Q?6KWJQrtytZnK1IV/0Wp6WBJOZcriFbhwK/DK7GS9muDURhAM+YzlIaWr+6uB?=
 =?us-ascii?Q?m8bvq0rVFKswXh2eB9AzhTRTNskQ8ZX2z6azTtqewYDWZRw22wf7eZLmc8oy?=
 =?us-ascii?Q?0JqGzX2TGUEUFxhzWm5ondh8JSBn8XI2Jyl12aUd7hb9MYXiCrDLtWemP04Q?=
 =?us-ascii?Q?6Ef6eGp8IUQVQD6Qcsm7dp9OYurnuCPqzSiC6kl8h/hXBwAj8Yr+BShow+HS?=
 =?us-ascii?Q?/UAvEVbcV1SlaX0DYFAnHlwJY5H5FzOdHzPP+HbvB1i8xM6YlheyOquSwjAZ?=
 =?us-ascii?Q?iYGl6sNSxxebQxloyZRnQ0hM4halYC3fFhzOfFcxtZUpoUuEPq4urnqoOJdU?=
 =?us-ascii?Q?npNtmSZhARsyyV4rf47ZTO3bjCttJrAxFMMqFsGCV9XFuS/LHyQSXtMIluqQ?=
 =?us-ascii?Q?2Os2UQxw7l8Sv2/RCE/nCQwvCfR9cCZvlJ51zG1yr8oO1Ix0PrX8MlKNYhCc?=
 =?us-ascii?Q?TGPcqLt8OE2SwvA6m/0K5h0e9/I/BYRTsDSQkkRHt3wCxUD4JFzFj9b3pbFX?=
 =?us-ascii?Q?xEYYusjFE9gavW43ZIWyqHNRqac7caPF9VIICPkF2IbW2NAESK9S+LdBEVZK?=
 =?us-ascii?Q?JeihGRLtDSsRIPFIJ+Pa7FbG/Vbx+YDet+kKtlrYXocUYnIlDvnibhyI23h7?=
 =?us-ascii?Q?stRH3mOmmo0pHwpaLZjd6ndNtGjymEN+VsKMRwWt473k6W32WJ2e36Kv+lOj?=
 =?us-ascii?Q?mVwZtGBpU2Dc6yG+VeroQz3KaGCZ3IBiMW+aVVdir2j157SS9b5VC/QGtErP?=
 =?us-ascii?Q?SpLy1BXQnNfqJrYqmP8T7uEwTajikOt/CsXcHhXlnC0C7nF96jfQQNZ4lfKP?=
 =?us-ascii?Q?gsyrLZRW6YU34XJqWHVg8PWrJOdAtgR1U1VUh+sfN0mHGsxlBaU8Tzrf0rW9?=
 =?us-ascii?Q?mfYEvL2qk7U46OKr74VENfnoPSB/tm+SBcSi/OxydPnB3NgqjRQDk3jEXhDq?=
 =?us-ascii?Q?WMPJSy00OWwh59ygOK0HmTKrbTCcU3ZQflZ1+Rq6vOVxqTycnBSsrOkeWx+9?=
 =?us-ascii?Q?n/vMzBf8xISw65g4BsmbghdGLBYN8J2DrK2AKKj2La4z7rUjWLsjXobFl/jE?=
 =?us-ascii?Q?r4lZk1boDK4ZUw9zZoPV3pPb7kVzEGNnfSXzWKcFVErnTPzZl8PudoALAIVt?=
 =?us-ascii?Q?bieSdkcHc0oqpYM2kCQI1RInn2w16/6AYSHiGkulHpZl7QZj9aLekBKpF66R?=
 =?us-ascii?Q?fvfELbEGuweJ4I14AFXldnudWA6/ElxraUlrtP3JvwpofUCDxsmzwsqFEgVs?=
 =?us-ascii?Q?5RLaP3jnZxcw5UQHowN7hliD5XS8oWWcEJ0NBvXK35xGZkUTzyIUXJd5aPv1?=
 =?us-ascii?Q?pTCj3nZXR5U2j2FOuAxoEgf1ivShv1HRZ2opUFg8kRNttC+dELdylA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?waMird4kDWTrWdlSYDN2iMb3IjWAg4pvpliJSYWrFrObeJjzjUcmI/yFu9DH?=
 =?us-ascii?Q?v1MtP00f9fn3LC+OtMIEJTa3fxmMkHzi+K/UYwAj0U/ScKG5c/yauThrzHIY?=
 =?us-ascii?Q?d6IzV8F7D38mNNYGHHHZnLlutwaVqvOzHSyGAHzOQjJ1RarOqx4i/7OF/VPa?=
 =?us-ascii?Q?LbasYyvop10BfLC8eE76kQHzlYayJ/gpACAbMTGR8CoAlpFU+x5gH9VV1ULV?=
 =?us-ascii?Q?TYsSoM/dNlwqTZqnfJ7ln7Sn7LUM3TQVZqwqn/Dowsm+du5AOFHDsWcR8KrV?=
 =?us-ascii?Q?GnW/4vAY0QRlXk6rl1w+6c24NtJOUhZijf5dbYmeTJYBkzn9hLSmU5ZgYdm0?=
 =?us-ascii?Q?V+nIzLFNJWgnoCMP5dk8Lv2NWAJDUG51CgTaxhsbTQmdVZgEwz+YgcNiJsN9?=
 =?us-ascii?Q?xNA0CrDFFaM5Ca/+WdPwDuqOA7UJaVkHNVtvDugjOTyJnQQEiMazVuU+7mDO?=
 =?us-ascii?Q?Y+RewnYj5o+tlOEjZgcWBMrq1jqZCoEhHPda8w5lW351D97Wo3H5IGd3WFlm?=
 =?us-ascii?Q?EuFF+4GgSMHW6Z25iC99jQBMPPeGzMDCi+fDucFcbMwX+TtoGvUMXC07LZoV?=
 =?us-ascii?Q?deaaDUrp0TGNAF97+TGPegBWSEezcHmQQwMEIuKK4fum58vAz+mDH8eTq3fO?=
 =?us-ascii?Q?aTuyOrcLLQyaNUYSMW5Ibuy6lV+n98KqAUQiZa32cK0RYdZBM27NYfXYryVG?=
 =?us-ascii?Q?ikIcln8iv8ExrpLuGi+hXtgsVnPsBjN/3f5f1oVgxiJNK7D0GALkXoH/U0bp?=
 =?us-ascii?Q?2pbPPRMibelvh5TSQV/IeH4UIPk2R/zg9dUZdff0p8SscurZqvU7zWf7YKCX?=
 =?us-ascii?Q?UmJSNm0OmhRYHFpbJeLLawJp67eo+Zke3E3xbGJ5V+kb5Iot3NFsisOjLbOE?=
 =?us-ascii?Q?uy8Y4G/chUweItrprhgTGvgA93rQdeO7M7Phbtk03vUfWIXRzSD52xbLPFKH?=
 =?us-ascii?Q?IDTU60r+mg2Guydj/0wRE8Tg//CVTnxc5vGaPwRnLkUOGnX+nRr8NlKvxR5O?=
 =?us-ascii?Q?eoiUmS2bZI1eudPbu2AvIT8UojmW2Kwn1e9tnFiDm4QaxSCT1Tp15KvsnOgR?=
 =?us-ascii?Q?R61shbOgmXa4mO3a6+D4n3dMg5Ksk5U0H5zww9d8E0GbDlU/q4tmV1kykkUE?=
 =?us-ascii?Q?6cZ84nfJgDxTrIonO1DPg8PR+ejsrtcDAEjyzYmKmAhcAUVywend5WvCj8jp?=
 =?us-ascii?Q?NdPf1ef9Xz6m+FaIy9s51psm9qGY9Lp0vPDKrfPdSrMc6gsoQOXmhdw/T/k9?=
 =?us-ascii?Q?v5Uhbw2sMdnLJaG63kQ77c/o4bAY9h2kf1ODOH4JyevCEzxMv625rcC5N9BS?=
 =?us-ascii?Q?gRSP//vpGuk7PoZomZfRkIN2wIyLsuRPHjbZmN7oWVOrZt/iavIhfPP9O+Yg?=
 =?us-ascii?Q?WbD4C5SiBFANvuuXibIqn7bB/qEqMPDj0+fVQ+VwHSsKeavR9df2426Nzdfs?=
 =?us-ascii?Q?oI9jXKcTKddtQwZFvsKvyvYygdfB8MZK8p6KZ0nQ9CTXFCE3rdIpOnR45Etm?=
 =?us-ascii?Q?UTsYZtltckfHjVwP+iKNCpITVYcyz8RieMAjDvtPUo8X02Sp7R3oDrMOMyii?=
 =?us-ascii?Q?C3HaQiE9X1P9zIBG7os6llAmTOMUoeHT76OKrvCxgu4VT3cePSYGayaMI7ky?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27241d35-4ad0-4bd6-86e0-08de10973142
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 11:44:28.9366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E52sM24Tx5Fzh1oa7l6kQJIyFjPfLVYX3HphiFZApekl+CaXatc1X4hj5bmLXCm1hbwBs1plZLkLV81IwkYkPRcX7tmKv82ojKCzhIY2/ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4748
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

On Mon, Oct 20, 2025 at 05:47:31PM +0100, Bruce Richardson wrote:
> On Mon, Oct 20, 2025 at 09:42:29AM -0700, Jeff Shaw wrote:
> > This reverts commit af05f9e37153c53335938bcde2978a359c5f4efa.
> > 
> > A side effect of this patch is that it also counts frames which
> > are dropped when the PF receives frames not destined for it when
> > promiscuous mode is disabled.
> > 
> > Signed-off-by: Jeff Shaw <jeffrey.b.shaw@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Actually, patch has already been reverted, so dropping this in patchwork.
[No wonder it seemed familiar to me! :-)]

https://github.com/DPDK/dpdk/commit/88132dfbe789a8705626efdb8f603206d716cf93
