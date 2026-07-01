Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A12CC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 09:50:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D72C402E0;
	Wed,  1 Jul 2026 11:50:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4721940278;
 Wed,  1 Jul 2026 11:50:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782899454; x=1814435454;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fpv4WOh8P/fn+RvVSPJ2RUHV120PDVV1vQcvunkkTc0=;
 b=MXcBToZbtxqK+cHtqPr4mBX6NseqY5chb3eeUHt+K/fdh7NFHIxBXdRX
 1EFmTMiavjamf50LepYBNhGjnSv49E/rthWStgxjYTG8/OIKwgt35N7+f
 CJKlitRY7u5E+QeGCdhlDFDUtQnIR9ALPP4cFg6jJdspAuMzUIBN9TemA
 Fc5VA2VMvrpSGBJ251ffgpnO3l1cq7kIkmcpEAAN3FyoxYAucrOwK0rlE
 HdyOYidRqxM9DJ2Pm5HYQoCz8JqJOZXk3nA3vNufSOCOXPNzKGhQspS8K
 +T0FQrNdUbQUg5UsuFk4+RP91KSMcJBkQrogyWgUL/niljv93mu0EOzrD A==;
X-CSE-ConnectionGUID: 6kUCDPJqQ8q1WPsLRyW9Zw==
X-CSE-MsgGUID: 4SUR7DWuRCCHTcTnL7fafQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83825886"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="83825886"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 02:50:53 -0700
X-CSE-ConnectionGUID: 71X9Eld4SS2qAZIWcbnzcA==
X-CSE-MsgGUID: uB5j5FRQTNSf00VvLlcpYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="248061266"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 02:50:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 02:50:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 02:50:51 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 02:50:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eG6g98v4tOfVLE7VL5BUSHDRTnUrNkWe4VIDvi8Gs9vQQguFpjpIIwHsRW+7F0+V9XT4pEvlmYupS1gfmzS8ixMaRj1XyzUhRHT4KOIkUZkeZtkxgnvkTrSpycooFebnArVXHgno+Ji8u+vu0Y55LeWj+o+bph7Pg3lYD86MAhH2rZJ/N90S+cchYtoO8LyUC+dWy8BIwOfkaSoqBcT63i33mLQj1Tyz05BRoBRku+10DSeLfqlTaQkbAN7BTB1YIg4X/KKTwKGqZd5df+kHl/hLWfNsy7nkXUxTXEuN56iRO6hYRG/MALuJRuFTlIFzILGrmAD5Bgb8544ilp1gLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWxxRi3NxSmNoNb2CDfzWEYvIjv43WxoaJbX9djwWTE=;
 b=dBpmYoKRee3CBHWasDX1QR9ztyUhg+6ufU5/8eqhazKtSZ9yy/0vrTAEXVOiE5TF2jkOdV2iMDogc3yQ6rU7YBbl4Ky835/7J1fONmf2AJjTfDD0B3+UFcOa0fpZBGVmnUPOuVCvkEAgjWlsq+wIC/NU97E8g58i03vx7qtzQWrej/YwJmHMdy15xALx/nH6XwH/cbmNBv25fT+L+b9yCDYAoB+3KAOMSC8GuGjezN62DDewjfnYpPc5gQvjAHrMIIcyIC/lg44FFW3IfM43saCR+BmygqSa4z6aEa1dcIUzho3zlAo45X/RqjCtAUMr7yAdAQaA61h1kxQvvDaO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by BL4PR11MB8821.namprd11.prod.outlook.com (2603:10b6:208:5a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:48:01 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 09:48:01 +0000
Date: Wed, 1 Jul 2026 10:47:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/idpf: fix Tx of large mbuf segments
Message-ID: <akTiTRtGm_a954tE@bricha3-mobl1.ger.corp.intel.com>
References: <20260626134440.2108591-1-bruce.richardson@intel.com>
 <20260701082337.3176970-1-bruce.richardson@intel.com>
 <838a36a9-654f-4b32-b3d4-3457dd024b58@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <838a36a9-654f-4b32-b3d4-3457dd024b58@intel.com>
X-ClientProxiedBy: DU2PR04CA0057.eurprd04.prod.outlook.com
 (2603:10a6:10:234::32) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|BL4PR11MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6d6dcf-118c-497f-65c7-08ded755d74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: wKuN5JDHyT65bGDovjNuXMM4ueCEE1DqT+Q/45otKm0FjJmiVGrvJ/j7LdARUCaIdrPyIC1AIdXQSNWdbCZ7pP3zaT/axohPhE67TkJgoxC+3Iy/oXCyz8shH9eAJxAEbV4slYBUUgXbECdCZGPJOCmI/vh7BXUyqGQf3xUJfq7tyGzyLtsBP6Qso/Lc9He9KARMC6ZoMKshvdrQkE8tKH+NecJDYd6XSuN6LnCeIirXgL+KNhtNUnGCO4+GbrClmK0Z4hakRuPu0Q7yZzR17jJscBrLlcR4jR6/v0PU8LZbq/iMBdEqZB0S61XUJqWLKeskNk6X5NcyF3JFyviJaddd7sh0oCenEVPZKMRt985KZzUhtin1SwD9BrnkOsUINvvYyk43bYMweCON6G3un9jfX2NJ4brdwza9nhrd5IfFVhMsnMkNX3Ce5btuNW/jRKHmHzTg0GLmWy3uBVKbGf6dsuirE39GC5aSqfD4FegggsZsboJ38tLehvzepeqXp8pXQLl01E3MY0KSoIh3nmZDXkvVfNB330NYs6jpiYJyCkZQjP+3NnTMWPDcM3d5susVbUU/a4byfn6gBkEnUH4XE1mNbMMqBxC+SmA5fcxPqlkNwPYN9L0blzprYZD1utLzlxX521H5nJaeA6nqxL7N+yZJsuQIjMgNSiP7+rE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ceeMzF7N6zof93VhAHgJH3e2MWzuIPVndUIpL+epoc+8I/c6cylAUa/Io5p?=
 =?us-ascii?Q?pqGsbIATPQfszHZGz7xtE3m8nMO9+EfdhgS1Eatql4qA7CIWugPaYIBGzS0E?=
 =?us-ascii?Q?9/NGBpo98uymYYNSthWu/9ye7SlBdQvjibeCPbPJLRD/aMWZX0G1sxt5a+AX?=
 =?us-ascii?Q?6ZaIBjlAxWU93YYPnwkXZoDs8oAS0KHRvM3daew2j+cPALP7Sv0Phwqgbtn9?=
 =?us-ascii?Q?Y74PFIEOAwZNt/psa9BDPBxnRZkQkcFTzm1NkKWIF9ACwYiCMCaBeXTHOCBr?=
 =?us-ascii?Q?iRBtvmg+yTmt9DJVhK6SkCJC8CgYVHIdeMOBu8YSDSbq+1qC/JIUO6ws3qVG?=
 =?us-ascii?Q?UrMq7wFn+ks5EwGvjXshzuBdET/XDlYaJb22VzmzTnHsIK7kZVSZDxLPiONJ?=
 =?us-ascii?Q?EkeHPb66UIeuPwB2HpN0Yrby/lCPBzOgq6m9/jX1a4Qus2IPNMMxsquw8mdn?=
 =?us-ascii?Q?tXXLpzsMSPTzyEXJCiu5sAuy9KNwwIWivZ/MhMLj6QIalC0aES5b4Hx2NwSo?=
 =?us-ascii?Q?QmmMYOgv2VSugjHYJ8eO5KXt0ra+XmCd1ykAVvaYoR8Za1YBBEK5/J/u/5vQ?=
 =?us-ascii?Q?WuDQZ6NOLZwamu78AcE1akWCbzXttt0+Z52zLq2NDZ0n2VC4djMJxPhTpnin?=
 =?us-ascii?Q?0xY90Ous66KcOcIPntlEyLz34ozVZiBKCs6M8wWhPRercV1RSl98lkBFwnej?=
 =?us-ascii?Q?Pu9uQ03BGxUR9asJP83iErB4RqJO9v2X56O5v5obZuTFEflPUlJ7Lum4abrh?=
 =?us-ascii?Q?fZcZulB2DvWmxBFLes7/GeabE+OIaNYXwYaQm0xN+X2tJbRzh+zdQpW+kCdu?=
 =?us-ascii?Q?C/e2VbZVgEvX/P4zMG6f2Y1kNUt4R2A8MyeOIqfPnX518qI781XO9z/wuSbD?=
 =?us-ascii?Q?VBg7xqBNH0yNopGgNamXeeFh+SJL/j6rpvLxzTjWp43bL2L4qJa0d+w5Rees?=
 =?us-ascii?Q?bp8qNCW81m4SaN7LoQrxQQMmNxStxUVnzlMvLqRGSNLcijwnWEOJgZ2PtuOM?=
 =?us-ascii?Q?C75tja+9nQPQbXOliuNZVmNDVQvb0on6X+JSVezQdp0TIasmB85yA6RuMKhv?=
 =?us-ascii?Q?YxlJmeoWAjG41HZzafYzGqNXiIp0KL35/JyKxjiwapHQ8uNgXeGxYmZw/kqh?=
 =?us-ascii?Q?PXLBVMwenUSkxE5CxxM9e67GHpOdXtLtgp4Y5+WwYPS0E3zP1wJ/pWEO0Ni1?=
 =?us-ascii?Q?3YOsiQzNdsIbawCrcAhCtVcb9FxI8nuc0rAPNQUYC2ZUCYTVC0aVBI8vg17S?=
 =?us-ascii?Q?wOVFKtSg2i6pCOhvz5hfKdV1Cvt6cx48r98rlFbYI1ZxvoxZyRXZdfRuP2xE?=
 =?us-ascii?Q?PqxfD9FZNHqOjv0rbJYWsxa+s1ZAZzZ9/AKf7AuwpwiUOH0yKAa9ByI5yBqt?=
 =?us-ascii?Q?ytTzV9jSgntumQIQSo+0QJfyQ7Rn843E06eGNb43GcKuABOzWHQNdbB66jnF?=
 =?us-ascii?Q?AdktTNnzqi4oTyUW5OgPNtUtepzLES0KUkfo1YAd0z5xxhl0yLz18x+Oy0RQ?=
 =?us-ascii?Q?TDWeBmU9793PsJ+XRTAjnpzXALQ+938zJTehKs94mxD7XeVm27jxBfaQTrXg?=
 =?us-ascii?Q?sSJdSy+Fp9aL2NheeT/maXStpCH8gdMKOttBzxvo1V37IERRwPlqcTwxFfQB?=
 =?us-ascii?Q?Zt/PQp1M6FHEYoOLJsb2jksv8jfLm/BMOY+w8NYPXsexYmFb/+LYiJWALpgQ?=
 =?us-ascii?Q?0bldiPox78Ba30gkWSSrU9rlR0+TMbX1CmvruEiQ1zsOHDCcRX2rBScarHRJ?=
 =?us-ascii?Q?XRokPZa9wCmC0/OiRJDaaOLCc5JX9sk=3D?=
X-Exchange-RoutingPolicyChecked: NOAmibELmswudPxeB0Z5c7NuueWrA/HRME62u3z+0PV4f4AkQIoc0v0HyL/JSFOvbPLMmnQiFZfXWZykw56T1ijJA0uJvGxNQNvVHkPlXcJQP0HF/zevo94/mRiyljikh/fLROlfqumUN+/WiYjdBi02YG593phaqoL+oQn/RlzPbK92jmjorg1wp/vYeVywUj3SdXxmfKaoJqHyvmqbS/3dgVMSTMpKf2RcpfpWQaiap9RmrhLj7N6n3t6dNzaV+CngcZt9cA7OFLhqiYOXIp3E9JOlnnKauztqU17PuziTG5t9ItqxEEGg2fEh/vN5+y0MGydZSr2G/J/+9AaOpQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6d6dcf-118c-497f-65c7-08ded755d74b
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:48:01.8210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ar9WqO7k3DXrMmJl0Xm2+MoUh4aDTKodl2x1EBgWb79i46n2vvjEpQzLSgo5I7oE/LX3FXsK48WlB0UdsuY95Lo+bLjfqHKU4iqXIJelQt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8821
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

On Wed, Jul 01, 2026 at 09:44:52AM +0100, Medvedkin, Vladimir wrote:
> 
> On 7/1/2026 9:23 AM, Bruce Richardson wrote:
> > When TSO is enabled, and we get a packet to transmit where an individual
> > mbuf segment is longer than 16k, we need to split that segment across
> > multiple Tx descriptors. This support is present in the single-queue
> > mode of idpf - since it shares common code with the other Intel drivers
> > -  but was missing from the splitq path.
> > 
> > This patch adds the proper data path handling. Previous work ensured
> > that the descriptor count calculation took over-sized segments into
> > account but the actual descriptor writing part was overlooked.
> > 
> > Fixes: 770f4dfe0f79 ("net/idpf: support basic Tx data path")
> > Fixes: 2904020f8313 ("net/intel: add common function to calculate needed descs")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> > ---
> > V2: change check for number of free descriptor slots to use the correct
> >      count, rather than just the number of mbuf segments passed
> > ---
> >   drivers/net/intel/idpf/idpf_common_rxtx.c | 43 ++++++++++++++++++-----
> >   1 file changed, 35 insertions(+), 8 deletions(-)
> > 
Patch applied to dpdk-next-net-intel.

/Bruce
