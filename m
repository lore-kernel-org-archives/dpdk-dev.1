Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAB4D1A618
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 13:08:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFF8A402A7;
	Fri,  9 Jan 2026 14:08:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 2DE2F400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 14:08:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767964130; x=1799500130;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=AGIZr25bvvBR5+loEjCQ5aeFRuvR0OQHSXwB2olI9No=;
 b=BgmwqWTXvzfRwLGZAUcQNtfrW65r5SSzWvp9VBXZki9a3kaTCKYUxaz5
 K/IPDyKor9PpLjhEFeJy80N4p9IrDJROWEgG9/5AnHQ6LTf9W92YulDBL
 nWUMTPzUkOyBQpjPJqztb5qpp6entj/FWhyOk5yqFB0Kk5nkqopibxvih
 KHSGadF+j/sC0Oafhhb+UrJCe+l37DBh5aFg/euD7kMc7YliZi1XDqQFL
 CstFafLT/Gx6USrTd4C8VvKcb8GcGacyKh1XtktaHXwlOSBmjnAEYb5zS
 x769wbS2uOk2z826Z0iYZr7KF59+/luXjLyUb4W3ecfiunpRgNunW8I5R A==;
X-CSE-ConnectionGUID: 2K/YOEArSomTbILxVBnAjA==
X-CSE-MsgGUID: 8LaIsmp0Sn62FmJXPld0uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="86931906"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; d="scan'208";a="86931906"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 05:08:48 -0800
X-CSE-ConnectionGUID: kCGU8fLXRDa9ov6AmYXOuQ==
X-CSE-MsgGUID: 7vJqZQ+nSmGOeKCMS3qY3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; d="scan'208";a="207617625"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 05:08:48 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 05:08:47 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 9 Jan 2026 05:08:47 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 05:08:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkCQP4HaqiwSvfHHkVklb9U1KDrjWzXeUHwP4CGFwzelS/+iwRRez1Cb5RwzaSfwIq0yZH310Cwb7DzRi+joG6jx5wZ877s6AUgF2PjqMLXQHXzKOI17Bk46roKPSi7RD/xKTiT2112HZAyrztU4IT7MXlu31jFPrTlRmAWJo6H+4rGNgIKC0+qK/PhhQ2xfQ1ebr/ph+k599I2ZiiouVpJvPxRJgesTStTL5IzeqNOw4w6Cw2DohoBB/6JipWW2Xb7XmniXXH8kpWRCblQWyShsSV+Ii/uY8qvHdqs45F6MUH1FREixwhCkpUtqSlSkc6MM9KvQLzmTae0+tOUVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCc80OAhdTbcAQCCrDIHJOnhCa2RsX5HFd5vsWQmZ5U=;
 b=piLDknQdN99HCHDV7t3fjjLilvgMGuVhfYpF3jnU5r+mpR7iG2tnE29WgCWthWj9N5iSwdPpxs1BBZSmRDCo5iGi6UEA6lNBaR2++XbSVEJymrvCFPjH/x2RS/S+i20k0iNUDzqfsDWAB1XRCmFJapdkowVqj4E8gJbg+S8nV97fzDdoAXBbbolaaIbBxlWWR/ce0xH5AXiRWZLA3GYcg3V86i5favEaIDE961J6vmTklzY2PcdAw2TAY1z7t4IRMlGl7Lc47lHaWMdjNyoHe2DKhjHpfCdh3d9D+XGL/zrjcPVSLmNgIjI7WymtUershorAuHftpO/PRW4dIodD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4643.namprd11.prod.outlook.com (2603:10b6:5:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 13:08:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 13:08:45 +0000
Date: Fri, 9 Jan 2026 13:08:39 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/2] net/i40e: Fix aarch32 build and vector flag setting
Message-ID: <aWD912-f9cwPIHkV@bricha3-mobl1.ger.corp.intel.com>
References: <20251218154244.4001917-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251218154244.4001917-1-ciara.loftus@intel.com>
X-ClientProxiedBy: VI1P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4643:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee09c2a-c02c-4dd0-eb9a-08de4f80383c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b+RFQ1iFlCY3lnsgL5OS+p/GV4ulI9tIbJgE+7dlRN5efsOOeK726EkoD3Q1?=
 =?us-ascii?Q?899pOM7kw5gPiEVgiN4Iy9H6KSB0l10tpvRQttlUXa/qOkng2h/0k0N5WcJJ?=
 =?us-ascii?Q?g8mdSlRysvgHIYGuUnv6o4oNk8rNNFCIirl7CKisaQ4SD6eb6CeecKyt1UpQ?=
 =?us-ascii?Q?6kgDN1W2K1bFaO3PMGNQMhUOhib0Yy0IsxHRiGG16XUhCSuHspm+RYnXoOSg?=
 =?us-ascii?Q?7Nq381RRWfZTAl4MdUUgMsikvbTNzsETlnKIIsCDMmfiybkA6Ih2oY5R+fxi?=
 =?us-ascii?Q?qXI30cbZTMD3jB5pGJD6Y86gMC9WIF6dNrZsvXqo2JL8Zf8LxDM072zmHTes?=
 =?us-ascii?Q?EAFaViclS3vUxr7ncJgHomz0D8y4rQI7WnhoygJ7wb0OFKYwdjtOOrogzz/b?=
 =?us-ascii?Q?/lxgpnce68v4h7YTtt3bODuPGnQ6JGUebqrO6J7FO+TLLKUFAOyAUtUlQAIC?=
 =?us-ascii?Q?mUFCIqHrHy+g1o74iSPuLSklTEFH+oU4u1jRHqL8PwFLeZ9YdPOFGc+tf10N?=
 =?us-ascii?Q?2Lq4XAFwiw5nJH3ZeknzIVjv+Djko/4ELc7Aao+W0m64aF3arU+Z1vanwPLz?=
 =?us-ascii?Q?ynjcOsmKLA4YBrgXhSzAXv2Bt2A78w9K7sxtwoWsxkf62EsxoZXskxhnyCQH?=
 =?us-ascii?Q?IX1uwa0adfVlLATRiUsjiYBvNCpq8RA6K3RITw1AKNXHMJMHkLtc4YVgddkn?=
 =?us-ascii?Q?HFxqhN6x8lykVh6moonWdBGopFLrPVJ+pHYQYoOKXswuj93qIkWmJXO0ryO+?=
 =?us-ascii?Q?pc1yk+84SnDciqGYnqfcYQ0K4gtAH5+gASM7Ko/v8MIKrJ1LqSqHIHSA8X/t?=
 =?us-ascii?Q?45NaCS0abhnga5BxLK6uccij9jFOF03lhII7ofhKfnkFMQG3Oh9X9Gzt6UhJ?=
 =?us-ascii?Q?X56IXEnmpeGeyHkmLoI6ArdVoP1jcO18Sx5eKYEVEiGE1QUhW1D2uMWttHGY?=
 =?us-ascii?Q?CEUnrO2+/agY6cFGzSKbgil2KIi9As6Qfuojat16WjW1NXtxLptC71Atssw+?=
 =?us-ascii?Q?b6DhN2bkehPfBs9MfvQt+LceI1c6HFYV4F27chwk8F1YtjDwzcysnk92w2yF?=
 =?us-ascii?Q?3NB0PT+Sg1XVFQR5SpAN5uaRY1YK7rWnjZwDzJkOIEaZuUYgp2l2tCgut4AV?=
 =?us-ascii?Q?SxK+Bku78mh5cr2nvzlgefFhCmSA5U/TNTM4Hfop1DF3S4qLF+em+jfqvC/g?=
 =?us-ascii?Q?f12iinK4APMRiSejrBM3Sd/br3OBPOMFelzKX4xJ5qKm7ePBR5l79fKJy2gH?=
 =?us-ascii?Q?BsiAHCGgoXogfmY/z9DK3vo2tWJtV8Jv3wz2rxQIaTdkIiZ6zsx+JphNwO0s?=
 =?us-ascii?Q?BW/bF55wkg9t1sbF5mzlJACaprl//ok35erBpkCzrYpy+nrmFrIK3uJ2n3J4?=
 =?us-ascii?Q?1VxXGe/bbhXnBRyN+40ymrT6YW3rLekMcpgUKLYiUMDq4qf+WpVTypxd7xIB?=
 =?us-ascii?Q?R6/FLbd0C7lTEzv4d+K/Mc2EwBLPLFyd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WFda8857ExhC1P8+6EdbQLjFufesunJ44EPyy3A++9ygcmQlHtRVDoDkG932?=
 =?us-ascii?Q?KVAOzAH+4ctJRHtIAqxnS+ruPABpzz4UCUQrg0aGyAbsBdenL8m/Vh3a3FpP?=
 =?us-ascii?Q?nrEKW/PYTwdXCI/PtD+xH5wjdeTEa3JLF73Bcm11OjRF7OnGB40nW8+oYSg7?=
 =?us-ascii?Q?PTGmsXs95u+w92esZpXjqvsUJahDhyB6OmNTxltFVCEa4KxoR3GdlY3FXot2?=
 =?us-ascii?Q?mRy2i09BQv//ONy6EbbW8B5CGUsePDfgLPYI5oQ9CbYurL//VqdLSKT9bWAB?=
 =?us-ascii?Q?LjKOlBEeHC0Jw6SLIvUWIrnQRuH8w5fgd37G5iacoKy1PLbVf4iQA4RZmvnC?=
 =?us-ascii?Q?PJKtAKCSbdhXuaf/qqZJ/oVZ+tK3spveXWIfIdDH0B/q0k33wk5dCvWT6qqp?=
 =?us-ascii?Q?L+2kLwGGPS8VP1a4J52ZTvKZ9A22HpciyHSzO+9OAstmqpDIMT+rxoqGyNuZ?=
 =?us-ascii?Q?SprgwdglSPQ7NC2X5UES1ituaZTYZnJ4fPZEvGELtUxvfqQAh4V0e3IwEXMv?=
 =?us-ascii?Q?iKML3/sRLaTi3xCsU8mW8p9V8Pw2u+zpOJkn/eamJ8TVXwuVvIan0riDWWrX?=
 =?us-ascii?Q?RLjys4TNrrXSSmCGdvCaYekixpScciuv5N8MiLMRiyNEPE2rR/DS2fk1V9lN?=
 =?us-ascii?Q?1I/1ymsGW5njyoTxVL2bU2u4jDp1V8SSoRyBY+2eBcQKaznvP1sIZGs2JHrM?=
 =?us-ascii?Q?oHZffHdTMm7I9qxOD1ALdjUHp/HMtnXMxvpklFi/nb2SPTvm5jihDm0LdGSn?=
 =?us-ascii?Q?o6ifQldILAG4VntwOe9Uu8mSKibMEJc3rCdH1GMfhUtzvXQJhO6JsrBSZPyu?=
 =?us-ascii?Q?uXrWmYor/bKOkPDOeijftZa3QtR7gizLf4P6Dccfa3vlHiCHf62+sS7a1lNF?=
 =?us-ascii?Q?gMvAP+MMpaNz5FAais83LB0Rs5qkPnRKKuT1+Ttx5Sp167eSegmxcNhYQ+WU?=
 =?us-ascii?Q?+e6Ryt2/tN2dzCD0SMVmz28RHF2cU9xpBww/L5CmltrgugR4qpCwlWoKzQbr?=
 =?us-ascii?Q?kKqOGCTzyjgdoHvSHyToUJ0chAyLlXJbsM3vE9/ELyMZxpAgq3jBbTNRIiWn?=
 =?us-ascii?Q?oXthEfYgeB6hnW/Md50meAF8kHnWNzng6xE6JYNGiE/5cVhNwyrKQwRXQrKN?=
 =?us-ascii?Q?EIe9p7hcMPwxwMxDP+vOt4oV4SWUgQfXMrqrgIAQ4vTy3xpyie4jCOCH2qXT?=
 =?us-ascii?Q?zzX/nNIFRd2kbT/xSVv1HZiWuB7tGUkIMKdvxTK3FzxX7O3BMw4UoilTtok8?=
 =?us-ascii?Q?ICsB4bDnU0xxjfQDm3kN2ou7QxKKURV5TU6Q2ws4k02ZAJYjeX16Ac/6Cr/q?=
 =?us-ascii?Q?rs9o0MVv0RrBFPtDWC0fPw0iKpSTu2+XJMWJqGVyyyO6vdscCHWE/iqRvE4/?=
 =?us-ascii?Q?HYOiXmv56LL+gfpRPRp875y4L1bNcm1m1qusyuL8gpf0SiI92STsWl/+SCpX?=
 =?us-ascii?Q?7427rzQZWTuven0QG+CoxEExxLHgZ+u9LPVmit1Rm3Z12XXfVFXARDxYcImg?=
 =?us-ascii?Q?fzK07lBxxy+JiAEZfC8HAWpqyZWskCvgDLOzxgQC9eL2UbKLCHk+3llksRvJ?=
 =?us-ascii?Q?gXy03Qn13/NgKFTVGanMGDW5TAkLSC9Z2HehjHAAQY7ExBXosPevtYgxCGgD?=
 =?us-ascii?Q?sCzhkInj2dxbyS0gagz87c9qRLIJUPzIOu0UdVex/5lB0ornMUnr+SieFqcE?=
 =?us-ascii?Q?Batsr2IyKOkBplgqZDV+vuBr5jYbl2M2Bq1trdV2yLnlWfxYUIAGk0fQeDx2?=
 =?us-ascii?Q?ulXCP4TzT+9KaSrM21Wwntn38UL5uig=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee09c2a-c02c-4dd0-eb9a-08de4f80383c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 13:08:45.2744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16bfLgCSBYxmNUhBaNXluGodbZENHARz1K2AVQHsHIJkUO44sMWJqOxg+6pNVEq5wFV/vT9L2XknTFJ4Pd9tyMuLlHDutR1ljwmq9CvAW78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4643
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

On Thu, Dec 18, 2025 at 03:42:41PM +0000, Ciara Loftus wrote:
> Fix two issues present on the i40e driver that were introduced by the tx path selection series:
> 1. Fix a build failure on 32-bit arm caused by an unused function.
> 2. Ensure that the vector flag is unset when the scalar path is chosen.
> 
> If possible both can be squashed into the commit they fix on next-net-intel.
> 
> Ciara Loftus (2):
>   net/i40e: fix 32-bit Arm build
>   net/i40e: unset vector flag when scalar path is chosen
> 
>  drivers/net/intel/i40e/i40e_rxtx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
Confirmed the build issue on 32-bit Arm is fixed by these. Patches squashed
into offending commit on next-net-intel.
