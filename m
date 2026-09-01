Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38D2C624D2
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 12:21:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A77F74064E;
	Tue,  1 Sep 2026 14:21:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8367E40615
 for <dev@dpdk.org>; Tue,  1 Sep 2026 14:21:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788265276; x=1819801276;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=EPniEde8jS5tQgMF0Z+eamMd0PBIa1rnHNdEiHX7q+s=;
 b=dfExFrIflmljYoEUZQ1SqOgoz7KCbB2l8cJ2kJW2rV0CDwp7qB/79HfO
 EbOC+f5LpNvObFnU51Rog3Xpc35nK2BIJQtUz2CPUzx/usvBabHqWrrNU
 NfUMPYMfm/ID97vG80oLMgZ7h2cF5cn1cu20T7GThP+5mIbRERfspbYMr
 Cj2BEO6uJlkktln51huuFkf/HiLVR0AeA8bSH8LyEBHE370b2ZYIxAJgL
 GlBhX0sYNcsFPV4UWCsLwmL6+BxPrmbWY1/PgrHsd1aa+6WD2L/xUSpQw
 YkRXLNhHfFxr73HfZr6sE5mL440TnI1nWz7bSxSElftzLF4vMeX7c4p/1 Q==;
X-CSE-ConnectionGUID: EeChbz3nSomnWD1kIBd87A==
X-CSE-MsgGUID: mzI2U5cZS7S9bz1nFNO+Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="87631537"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="87631537"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 05:21:12 -0700
X-CSE-ConnectionGUID: +h6eUKG1R528m1GLJdsxTg==
X-CSE-MsgGUID: 3YSn18plSRSHegKbiAIJcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="269123769"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 05:21:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 05:21:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 05:21:12 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 05:21:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBWSTw3GBav5FkcLZp2yR55UKbsHczoh8YP2HhTv5KgGpxBbWsMIaTLOckRomEeTWq2vwXcpTCYxC7asoztnTg0k+BxAVVwRUQAJEgOs1rWlGIyN2rutAYTT29vZ0IMGezOAyFq5/6rxk7t+Fou3Wuwad1Qk1eh4p+IYzJvTEo98rKUVMa7Sjv/dw2NXaLfSYpcQPKBYfGv9+atdPsFMUNv2ShnEr3ujgRqvo/kHrCO5tTFJg+0K6JYrU99usktWu/XoPlPWJ668Kbm0qi7WQarx+YJePe3YWY+UAFphphGfNpFAnP41n73n56aZE8/Tt3NrViXB1OKoimFEV9j8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwjMgyGwzxE3L3BZFcPpepsYbkhyCBXFhn5an4VpmjA=;
 b=XxkNSMtsO4XXQKkDTg+QM5fOgkPfBGXY7FklUYghp94E7JYMnsGk7WWCSzf0u8wlxWsBfTaityqoZTV5Yl3RxitErvi44qn7QOK5j/xQAcTn4UY8+0G77CJ+kF5Ti3synyU9dnyD1LblRt6w66pV2GglS3SOHBFIo33QGpZ7ck/XOqAXsVCnAf5OcshM7CfDgl1wUx3D9Wqq/jlPzHdKV+EDYbKBZI5CVttMpKCPAMWW4kO75qhqm8Q9rUIYZBXHHad+NSDhPuUHS7ouKgH94/yCFEGcruoTYKY9PB+6uBNtadZZx2pVtERqxRxs+EO5ZGRCimNNXRqgKBkGN/ZFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH7PR11MB6428.namprd11.prod.outlook.com (2603:10b6:510:1f4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 12:21:09 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 12:21:08 +0000
Date: Tue, 1 Sep 2026 13:21:03 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Randy Tice (rtice)" <rtice@cisco.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC] mbuf: add configurable base private size for pktmbuf pools
Message-ID: <apbDL2mTUpOojbGl@bricha3-mobl1.ger.corp.intel.com>
References: <PH0PR11MB76163DCD87BB40C437CB54C8A9A92@PH0PR11MB7616.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH0PR11MB76163DCD87BB40C437CB54C8A9A92@PH0PR11MB7616.namprd11.prod.outlook.com>
X-ClientProxiedBy: DB9PR05CA0012.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::17) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH7PR11MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df97d15-cdc3-414c-70c3-08df08238038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +HRsfiEG8DmXpJ8Yjm8xZmGpbww6uBDXHLnLdhta6glVs2EA8aBuuRjkfSDGI4dPploGLWcdoVj/ntBFPwn8OWpteC0mp1ZvdeoK7U7RbtjXxR7qybKnpS/QEgONwJhuBANlJSRkP7gpE3NmXBgPgaICIeo0jI4TZbIvEoTHIu90f+UftqP2VpmNb5qWXXkEj87CHqBv6+KA2PlUWLfmn9OwyQBw11y4peLGM3BW14rcDwpfe5OyXrcCTY0wEPQKXOExOC1QHo5jvbK+SBkzkoidpA3sir7Lo/pFlh2V7SNwMxlr/C0XL43070Dyl4N/Y1Br5vQAymiY9nQrYvY+x6g8WYWyHhE9b/kc71DgHV+HeC72fHFvtfCHirIYtLHHP439QePYSGMcT5NiMpdlNaoES688vAUh1JAH65lh7Yn0/TtV1gOeZM+Hkh1XjB9KjO0I+7rVvthnrgmYahQ//Il8yPzL2/YNg83zX7m/L7zzkqJIQj0QO4c7HmNqzNRBPYuGocE7cb63CUGdDWP51UhmGe7KkxGuc9E2h34n9ocK2/6PVpLLeeJFbsBwloHgIsaCM8wFgehahALVaWpmwcebpj5e9FFMaBhOiyFVm5wgjlYyyf4VFzyMiszTc/mLU8TksneoQSgFkPEHvdK/0BN8VB+/k5z3lAx3ziP9azY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gXNOL+lPX87qA15UxZ+a/xY5LCJnowfgRuBTEWrXxwogCtW6WwLBm3tj2AM2?=
 =?us-ascii?Q?80wJo+VwS9v7Z4tvOaXYzQCmPDwE9mjNjG2RJO3YJND6k7NEZggPGL+Aer0p?=
 =?us-ascii?Q?lGTPP2dVjmormvAVPwI78m0cjr0xrPbhWwrJZ5nUbpI8cJhxeE4fyHBRFbu1?=
 =?us-ascii?Q?KtW0AOqKT+N/SiRKWCBKsIaD4uG04fC5g8FXrc1cvOWo+8059WLWeCAoPEMZ?=
 =?us-ascii?Q?lBnD9RzzKMYicM51hZatj0AxcRyEkAR6NWUtDSNJ/GIBec0357V93Gb8Qogm?=
 =?us-ascii?Q?1CYSKmch7fzF7s4Rk8GO+QuQh61cf6H7Tb3Xv+vRoldxpgRv/WggwPJPa3I+?=
 =?us-ascii?Q?sbfM9HkPujRMsxY7Fqi3oqRcNToH6exBqSQBycEbfm+JBKC+5Ms50daNHKDK?=
 =?us-ascii?Q?1AFwUedUYAEAjh147UL/MOFybMzNGTLUxPacZH54dMEwYwfA9OnEoITH96uO?=
 =?us-ascii?Q?sR/Udrm/nj851GUktwQfv7Qbc/QCLbfqyfysQ69elAhYv46WUTj7bGj6SHKu?=
 =?us-ascii?Q?ssFFYlO0RcMIhlqk2v+vXHelfBFfXQyyp6SPoV8GGzGNX400A/FgEcE/gSoh?=
 =?us-ascii?Q?sQogaoP+fxgL/lRnfpx1esL0+PJ3wIUATbCpeMoE7yGYELmJ875wjFaFKmG/?=
 =?us-ascii?Q?nBamaUQ2k4s40a2XKQthe0JKeRWx+4iKG6oPsrhp+AXqMLdYTUP6UNELghf+?=
 =?us-ascii?Q?bZH/0ohDV5GHRc/LIsv8hF1JEuMkUrVjDzoIvJJNF06Dytm2S5ZqtjZqwVyZ?=
 =?us-ascii?Q?lpXR2Xf//triQrSaQRSaECgZLGIu4eiv+4OMk7uhtWan95/0PAMx6iDzxlPA?=
 =?us-ascii?Q?AtUKht9HAVPGAjyz7aDST47Jx1kgxevt/+Fk++yk9eEmcDRNrp2GyJzS9t9J?=
 =?us-ascii?Q?nsE5p812aoY04FwjRQCdKwgdWM9tyIQyz+vaCc0xvnGFx8YyYuoOfgitAOB0?=
 =?us-ascii?Q?664bvbnCncgPvm9qLYs9NhEX/sHd+rwsicAoIoTT+hpampYcKx9EY9Eecil/?=
 =?us-ascii?Q?6tT4pV0zaBRdwioz+h86KfscLnOom6AC1qdIjxYOIbiVCepZMOeevIndJlq2?=
 =?us-ascii?Q?cKy30FI2MgKSDbqmk8V3RjYXqRLDE54QlBuRXI7nWmRJM/0IdZuTYRf0kXMr?=
 =?us-ascii?Q?k5n1JbiT8QOaPbFRtI8gRF8EIXAIt4tivT5yzUqV13RbFMXzArpJHUR/tdFJ?=
 =?us-ascii?Q?by+ZHiZ5iuRqmkOdYIFHX/Fc0CjlvAg0htGvXN0F12T9XxJjsR1QlH8bcjcd?=
 =?us-ascii?Q?LHo0daECulbjwK2FZmF34Ws98s+7rE6wKYyl7/lmKXnBTwXT+YS97886REkR?=
 =?us-ascii?Q?WWrIEDGXwZlmZtBpSzQQeupMzJw/INrJVK3o2/ZdgtI7XFacnFieEFCNYfUf?=
 =?us-ascii?Q?TcArq/F3GO9YM1TSZlTWl+PsS1wsIzb62GQEoPtfgTgcReIxgnotd4ARHVpM?=
 =?us-ascii?Q?oWDUTxfngWiruAs+j4vFI+lzrIw9FuTpWn/rRhYQMGwEJQixl3pPknT8kiAa?=
 =?us-ascii?Q?lGRAh/s3YNSl/eOH7fh73WVjcOlij66mBxG65SUoACSwLmhDb9JACqIMBVDw?=
 =?us-ascii?Q?2JDuzEB1ZrNSRHk9ZHldljdyft6TXqVfVzAvETUE/h5sxC87QZ1kkE5eJ8HQ?=
 =?us-ascii?Q?VbP+VwN1uYGosRh6xuycbrqYWMEUa4vnWDyoaZdqVXNW4BQ/dwUoEwwCyEfW?=
 =?us-ascii?Q?uuNxxzE2J9vVtwP3di6G8AZuI3KmtC+uYipBhndhjYupmp2/jyq20EAxC9KH?=
 =?us-ascii?Q?4gDkJLyTj4INp1mODdESOTp10XNHz74=3D?=
X-Exchange-RoutingPolicyChecked: C3Fem7LuKMFTtLVoE/m+TMLZvAaD55hr1wwTRq6oXL+DDSFmUxivl33mWwfWYOzGhWlOvggmiLhb1y7xVj1DBBoguvc5TvxM4bA52voDSKovoUDTOQnMSXmOuvpEXtXdiMrIrZXHZ2Gb80q/w0PRbYLYj9SD5wFcOQjzEVQwrQRJmDkhNlHoOHvzXKzylzj3DOJ5jybR8h+PnqEBOXv0Bp5n9gsg0NYmd2C1qP4LOlQwRFQkhE5Bi3ykcPORUtNb3wFFjorL7jVfBJQOWLB/MPNSnInIhk6IRl4/24JVWGAfZ8YYz1Yg8b3SDKeIvKZiJoRnzmpJ06yqX/hZwsieDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df97d15-cdc3-414c-70c3-08df08238038
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 12:21:07.9736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RjqbrL9MF1EHeUv9nQHBBff8rldLjcgRptNojV3uPoyUiz+SalfUgtIM0xg80YqHktzMBqiiYPQg/UIGTHAgPCzkLPpJ0poAokEg8BhnxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6428
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

On Mon, Aug 31, 2026 at 06:20:19PM +0000, Randy Tice (rtice) wrote:
>    Hi,
> 
>    I would like to get feedback on a proposed mbuf change before sending
>    patches.
> 
>    Some deployments need a guaranteed private-data reservation in every
>    packet mbuf, across multiple mbuf pools and across different consumers
>    of the mbuf APIs.
> 
>    Today, each pktmbuf pool can request a private size when the pool is
>    created. That works when the application owns all pool creation policy
>    directly. However, not all relevant mbuf pools are necessarily created
>    by application code. Some pools may be created by libraries, drivers,
>    or other components outside direct application control.
> 
>    One example already in DPDK is vhost crypto, which creates its own mbuf
>    pool and supplies a private size for struct vhost_crypto_data_req.
>    There are also driver-created pktmbuf-style pools, such as cnxk inline
>    meta pools and TAP GSO context pools. These are examples of
>    pool-creation paths where the application may not directly control the
>    private-size value used at creation time.
> 

My 2c.

Rather than having a fixed build-time, or a configurable runtime set
private mbuf data size, I think the main thing to be fixed here is to
ensure that all cases where mbuf pools are created, the private data size
is configurable in those cases.

/Bruce

>    A PMD-specific devarg could solve one instance of this problem, such as
>    a single driver-created pool, but that seems too narrow if the
>    requirement is not inherently PMD-specific. A deployment with multiple
>    drivers, libraries, or other pool-creation paths outside application
>    control could need the same base private-size adjustment. In that case,
>    configuring the same value independently through component-specific
>    options would be fragile and easy to get wrong.
> 
>    The proposed generic model is to add a configurable base private size
>    for pktmbuf pools. The effective private size would be:
> 
>    align(pool_requested_priv_size + application_base_priv_size,
>    RTE_MBUF_PRIV_ALIGN)
> 
>    The tentative EAL option name is:
> 
>    --mbuf-base-priv-size=<size>
> 
>    The intent is:
>      * default behavior remains unchanged when the option is not used;
>      * the configured base size is added to the private size requested by
>        each pktmbuf pool;
>      * the final effective private size remains aligned to
>        RTE_MBUF_PRIV_ALIGN;
>      * pool-specific private-data requests still work as they do today;
>      * DPDK centralizes the policy so pools created outside application
>        control can reserve the same base private-data space as
>        application-created pools.
> 
>    This is not intended to define ownership or layout of the private area.
>    It only ensures that a deployment can reserve a common base amount of
>    private data consistently. Applications, drivers, libraries, or
>    components would still be responsible for their own interpretation of
>    the reserved private area.
> 
>    Questions for the list:
>     1. Is a deployment-wide pktmbuf base private-size reservation
>        something DPDK would consider acceptable?
>     2. Is --mbuf-base-priv-size=<size> a reasonable name, or would another
>        name better describe the intent?
>     3. Should DPDK expose the effective-size calculation as a helper so
>        pool-creation paths outside application control can apply the same
>        rule?
>     4. Would maintainers prefer consumer updates in the same series as
>        example users, or as follow-up patches after the generic mbuf/EAL
>        change is accepted?
>     5. Would maintainers prefer this to remain component-specific, even if
>        more than one driver, library, or pool-creation path may need to
>        apply the same base reservation?
> 
>    The main goal is to avoid downstream mbuf layout changes and avoid
>    component-specific configuration drift, while still allowing
>    deployments to reserve a consistent private-data area across all packet
>    mbuf pools, including pools created outside direct application control.
> 
>    Thanks,
>    Randy
