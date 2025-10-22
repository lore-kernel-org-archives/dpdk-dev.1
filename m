Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D93CCCD1AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 15:03:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1191F4027D;
	Wed, 22 Oct 2025 17:02:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 119FE4025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 17:02:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761145377; x=1792681377;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=mCY9hfjflmnDJIabsbnEdODnQ9olu+fohPTN2gXa6MI=;
 b=kCVO3+tQIjI33MAOzn90ct5Ukccqa9cD5vhlIR4msfXM4vwkqEmSAdJ+
 IwzzamZAub+V64vIdNfJImLg2rRGA8nwObHGpXiSI33wwQQmxTMcB62NO
 P/1KFxH77OX0LSLkuQPeegWvE/+wOTl14lscLLDWXTFXYIMbRbi32FS2Y
 mVWLA5GOIep1TnW90+nR59IdvSF2t1T9oMGJgx4XYfiPG46OGz7jUfMKQ
 UcmWX3+hs4EKo/4dC0OoYvGPV54ZlQAmuybd+lkpLawiwpE94bKQoAQqP
 grqHld9RvdwS33QYD+VZ8l8cv1/gz99PpJ8MBkyQkqR7r1N2AOMcXNqmm Q==;
X-CSE-ConnectionGUID: vmV08oWcTpWQKQg+C6CoYg==
X-CSE-MsgGUID: SBOfQqjiRxKPRZ5MpU8HbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62506465"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; d="scan'208";a="62506465"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2025 08:02:56 -0700
X-CSE-ConnectionGUID: 7+05NJpETnGsZMRbP3oKXQ==
X-CSE-MsgGUID: npSPaveKRZmAOdWaP1HWtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; d="scan'208";a="214543441"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2025 08:02:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 08:02:55 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 08:02:55 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 08:02:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzFUun2yNnFouYGtaslxhYqNoZvMojjbf18CYUHOYB/LOHFTI3RJ9HKdH6ZW9yMflMZdajB2WZNjIAEDsuu+lxNLJQV9rVPvO8sbbvqpsayBYO8ocO5AvduAuKcV+uM/eJWbjQiCAqX5niHQl9QS+rnyGMiYitC4TiTLmGqkkZp4Y5QIj4IDPbqWgmmTSBGQHqZVn99nTwNXmg5D3tKDNE3W/98RjlTXCX9OyPSVgnsyrjqVX+vu7mQeF28IX099I5WEFr7RyJSzZQrkQFXD0BMWiLqqOtje93PfSoL1NFqg6ibFWD+2wZgEgH2ixDfuixid5tI2C+WtBHRnvAgJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6YCsu2KYlta3ibma4zp25UVTXiEjQXc3XWjBqHXny8=;
 b=UUu17nZxPt5ug3mhTl5LxR8fv8bvKzKrgINIj2PzzyYHeG6p9qxKwiVshd4z4TeUJ6h7axtcsD09HHaUyfB3OPLT2jUUjlDGBjeW8UkUuLJLWGrvveOUDi+nBekrvs9cBNEJxxiBQkXVBueOy1x+xTcsAxoNGfwEkXj3chMlqM8lQrYMGPVYJl0wJl2+PBRDLe2ucGJWRPI7v2LGdA7UmvnU/fbknRo+/R6gKPwb6Mt2d8IdkQbSI8A1sR+dkVW7yDXwNUXrl5RrnvC4A1tuWzxadbpJgh9xc+ZhQIh2y0EyJuAu6kxYo/0BAxTEgsU3Jp6MgudD9FW2lXP7srFOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6403.namprd11.prod.outlook.com (2603:10b6:510:1f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 15:02:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 15:02:50 +0000
Date: Wed, 22 Oct 2025 16:02:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>, "Wathsala
 Vithanage" <wathsala.vithanage@arm.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v4] mbuf: optimize segment prefree
Message-ID: <aPjyFK392slWz5R5@bricha3-mobl1.ger.corp.intel.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20251022144708.150069-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022144708.150069-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DUZPR01CA0250.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef6e6ae-adcb-44d1-4430-08de117c117e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?RKBBIUpusz99yGBIXzZ7sA8sVrRnsAtxsb1ls2s5ZRny0dPyYOATJ0WLe5?=
 =?iso-8859-1?Q?feGbBYKmq3JcL10F6VPYfgarNX66MetkBCWxl54lz+jByvqygL6kxnbVbC?=
 =?iso-8859-1?Q?DqjSRi2upscaxXSdSP8SoGaJt3UvkonKb6uuMM4IfluQY4BPedSG2xV6YC?=
 =?iso-8859-1?Q?cAOHCZoT+k8dBdlYe4muqg/1JKMxXP1XhthxNKC9Zc8g8ll9/FZq5bv+S6?=
 =?iso-8859-1?Q?l76+0G/uzIGwzzjj/YPj/3gKn7W5r3prUAx1vKha8P31B0gUxsZ65IJLnE?=
 =?iso-8859-1?Q?JXQmEg1yYvK1mvw2AD4ZvD91nM037WkEME36o70W+BTgyMieo7w0StJwuG?=
 =?iso-8859-1?Q?3Nt5ZmlEOnNEt85kC6HDSpMsUNOWQ6XLYuxgvL+gRu00ZQ+z1tCpDWJ2RO?=
 =?iso-8859-1?Q?BZkARN5OaOQeDOmWkRhTqtCxT8AM8ozYR6/2THm5jb2cFJO7cHq9ro/REx?=
 =?iso-8859-1?Q?GnsHv2+s0k3XNKV8U4PpVY/QOBj6OAPbGMTowewvLTbhQOlfKYxquGA79O?=
 =?iso-8859-1?Q?Xer7MD03jNM5WGWleEfi+tusKOgPKJ7EGigjwAs4bMJC8RqgrC3qd/TDe8?=
 =?iso-8859-1?Q?8h/kgULLms0EKNkdB/WafAQYM5325UUnnHcdp+SU0OAtBNAf0IYvHURB6Z?=
 =?iso-8859-1?Q?PDlw/VeaE5ASXA9OIOdxScvVYFNyet+DLZWIvXKprR1hodpVc3dles31Rs?=
 =?iso-8859-1?Q?okBlzI0OG9kfgoON0GBkm5z3ooIhCDhY1/v4VuRIW1InTz573WQsFaH+bT?=
 =?iso-8859-1?Q?YgGbrC7JnEOwdM4TVmGfYROTncmiS+SqttwM5N/pUeINgHUxrRfH5uyuXg?=
 =?iso-8859-1?Q?22rct2e8sF7ZImrR6I+iIENDlCai4CVzBlbq9I3oHvUu8ga418dlAU8rtQ?=
 =?iso-8859-1?Q?z41lzZi6RmTuJXugMUXs9/Cdg1w2HFDn2kHd/lXJYj6VblEONBucRhH5As?=
 =?iso-8859-1?Q?5tSIxl/JYlwqrGAON5bY5fGEXh62hR6hwSzyXvz2VS5P7v9WULQMW6nalU?=
 =?iso-8859-1?Q?M3Lzd8VPLi4oZo7Q8+99gBgfc/GUgawepMgvregI2hOB2TKr42OZWEEZ9Y?=
 =?iso-8859-1?Q?V7OKsJ8nohRxUF4xPDKuYAVu1rGXvqwtfS0dQX0jCwJHtv+APFG52Ahtk8?=
 =?iso-8859-1?Q?Bip7UwOpnb4O6VN7LYM5LEPgeLqaNn8f/iq9QB5T6roaR/JQ/ogwlGQ/mx?=
 =?iso-8859-1?Q?YjWOo+1m+Gg/2iG4qrAkkFMqx3X4FYJny8taopqOuXU/ymR7X9dS/QM5QK?=
 =?iso-8859-1?Q?mJIf03bEPB2NZl3UFN4rOts5nea/14RRbjQw0NVAEW+hG7S8LKFQ7K9EHU?=
 =?iso-8859-1?Q?+mS2oOhXSlxPASsbYpI/e4Miee/+CcsejjE6sSSUsv+BzXDD0yEaZbfQz2?=
 =?iso-8859-1?Q?cjIomBT7WkD7Z545+DoK/wTn2+YJjUElC6cpeXFkNKrxe7lRE+P6oX0d3g?=
 =?iso-8859-1?Q?lPO+1YO1XnE7sSXrXyim4lkx27/5XhYPNdtuLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3sppYFfVffZKBDfZyaKsw+MsPKvKukITpflPvbCVCTt2TuAMhSCmxjfwgf?=
 =?iso-8859-1?Q?UtGHNxflR1XRXpeMOFx5m8l5Goquj/QbqzaP5VgzO+VwUpP7UuEJKj78vw?=
 =?iso-8859-1?Q?acoPpPQclYo5kRjgJaLdbFCBCC46q2tCjhFm7Q1KwAzFqutDYMV3iiBETB?=
 =?iso-8859-1?Q?ggBDajJszC2YZFMk2NXx9GM7K1MpSaJTGuP6I2bQWyHV/FLu+0JVIo4ltT?=
 =?iso-8859-1?Q?/FeEWqLeqeVPBd661HwqGN7J8p4B6NSDE1ePxUVUqrZ/Gsm62MCskf4jfO?=
 =?iso-8859-1?Q?MShAjANQ6AoV4Ey46tw4qBjn2o7YGAwWQqZ0ldHeTbOl4lFrkIgNA6YyyY?=
 =?iso-8859-1?Q?8ghhIpQiDlyWUxhe7wSewXLTQewvE0nen2Heb9IpHdarHWEbfQ23n6KdCZ?=
 =?iso-8859-1?Q?imrQ9hSBz61ZjVax8ygpOBRdnz/VlHiOK4gz09iyrJjETavREIcb3Es4Io?=
 =?iso-8859-1?Q?GhiXplnRqiuhC7gr9JspIgD3fFBi/zKaehws2ETFtw1YM/4oA8OGIOWUtp?=
 =?iso-8859-1?Q?6KfpDJY7Inda5KtOQvHZQ3iUZhHcEYDDugPr1j6Rzm8Dp/b4gHuRKgROvv?=
 =?iso-8859-1?Q?mJs1cv/22mjHfufdvmNZFkGkmCLOrup30wedq8U0xweAmKaNeRQ9gygNpi?=
 =?iso-8859-1?Q?nigGCE5NzmpNKqH1mBlfI0RHVMA7JprUXiU+9dFvfjTAV5OaPj/HPqACC8?=
 =?iso-8859-1?Q?b4Ql5FxM4Pb0Qdnc7GsQmrkSAX9dj+QuFh80RqTraBFNg5t1e8Cy+W1/jo?=
 =?iso-8859-1?Q?+j2pVbaayxYHCaOS65OR8FHmH8m6cu5j/Y0SZy55n6isxtyHyzbb2JprMU?=
 =?iso-8859-1?Q?QV10hnBNWPQM1J6dDh98TnoIqILgPbeGEVy/WFgJ35jQpUISMOowYx7UO4?=
 =?iso-8859-1?Q?oiNiHG72lR2BqnmM+pDXsE4T8m3tTF7RpQg4w8IHLpvRaACDah+KtL68V2?=
 =?iso-8859-1?Q?X3ZveWFukJEPRqLggcHiXzHPwag+4lRw7iZUpx/VT1sg6gG1C67BKqnWB/?=
 =?iso-8859-1?Q?4VUN+ty6+LzntRwsTuG/1zdW2fvBynKQT5DuWIU83ySkcsYHDSyY1TJH7T?=
 =?iso-8859-1?Q?BdZjHXF3l9dPWLYKpniBIkTenE/XL0FKZuqVcuHakpRBOwscgigG0aeL3N?=
 =?iso-8859-1?Q?EJhN+qkyjqewBloFyqMPRgN/5wWOR4XVR2sEtwiDjdiAcMrL1QMeexJwaS?=
 =?iso-8859-1?Q?sdnMCrdOW68jrGmiP49tU6PeP46Mrapm+ohn+26v0kAuXcbM4oGNNCQuvu?=
 =?iso-8859-1?Q?vDwbAuTIl9IERu9tL418GxFhO+BUhcldn01fHDnLcgc4mtKF+LIF8b4iPd?=
 =?iso-8859-1?Q?CrYZzpseoBGzHCkCuE6XuaIbgIUzNhZnZCTdpZonStku/NbzbELtLQ3miF?=
 =?iso-8859-1?Q?48Gwke7clPO1XAuecrhYf0UfuzfUANfKUp2bJPkvYd5Kk1igQTu7cAVeDA?=
 =?iso-8859-1?Q?W2uZqKHYjKz949KZECEVrlMacAM1wLnSeJmVlZlN7r2maGmj3HFoxB8uwa?=
 =?iso-8859-1?Q?a7hK0COm0fvglX2tjhtHRDWbeiWzOHq+YBB64wYhTFdMllDFDmw0UTmHCU?=
 =?iso-8859-1?Q?c6i2nqrfuRzRDmKVGBxwCLoMeBtnfLi5pMPMI+fKaI1j6evS/+J24F3zcW?=
 =?iso-8859-1?Q?yO+WvOw7lQDjEqhk9NFpaKk0dphlcyB3EYjsdDj4IfSQEvAE56Y4r8Gg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef6e6ae-adcb-44d1-4430-08de117c117e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 15:02:50.3084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVcUQH5jOrD4w/cKGpyTNdvkvqARj+pcwAa1Tmth3HDxGrcrvOqXLQE47RjzayuBDOt3bjSW9gM3ZS46imHArCiNWSqa4QHa9BqZwiQE4Uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6403
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

On Wed, Oct 22, 2025 at 02:47:08PM +0000, Morten Brørup wrote:
> Refactored rte_pktmbuf_prefree_seg() for both performance and readability.
> 
> With the optimized RTE_MBUF_DIRECT() macro, the common likely code path
> now fits within one instruction cache line on x86-64 when built with GCC.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> Reviewed-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v4:
> * Enabled the optimized RTE_MBUF_DIRECT() macro for GCC on all
>   architectures.
> v3:
> * Rewrote the optimized RTE_MBUF_DIRECT() macro for readability; use
>   numerical value instead of long names. (Bruce Richardson)
> * Enabled the optimized RTE_MBUF_DIRECT() macro for Loongarch too.
> v2:
> * Fixed typo in commit description.
> * Fixed indentation.
> * Added detailed description to the optimized RTE_MBUF_DIRECT() macro.
>   (Stephen Hemminger)
> * Added static_assert() to verify that the optimized RTE_MBUF_DIRECT()
>   macro is valid, specifically that the tested bits are in the MSB of the
>   64-bit field.
> ---
>  lib/mbuf/rte_mbuf.h      | 51 +++++++++++++++-------------------------
>  lib/mbuf/rte_mbuf_core.h | 47 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 32 deletions(-)
> 
> diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
> index 3df22125de..2004391f57 100644
> --- a/lib/mbuf/rte_mbuf.h
> +++ b/lib/mbuf/rte_mbuf.h
> @@ -31,6 +31,7 @@
>   * http://www.kohala.com/start/tcpipiv2.html
>   */
>  
> +#include <stdbool.h>
>  #include <stdint.h>
>  
>  #include <rte_common.h>
> @@ -1458,44 +1459,30 @@ static inline int __rte_pktmbuf_pinned_extbuf_decref(struct rte_mbuf *m)
>  static __rte_always_inline struct rte_mbuf *
>  rte_pktmbuf_prefree_seg(struct rte_mbuf *m)
>  {
> -	__rte_mbuf_sanity_check(m, 0);
> -
> -	if (likely(rte_mbuf_refcnt_read(m) == 1)) {
> -
> -		if (!RTE_MBUF_DIRECT(m)) {
> -			rte_pktmbuf_detach(m);
> -			if (RTE_MBUF_HAS_EXTBUF(m) &&
> -			    RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> -			    __rte_pktmbuf_pinned_extbuf_decref(m))
> -				return NULL;
> -		}
> -
> -		if (m->next != NULL)
> -			m->next = NULL;
> -		if (m->nb_segs != 1)
> -			m->nb_segs = 1;
> +	bool refcnt_not_one;
>  
> -		return m;
> +	__rte_mbuf_sanity_check(m, 0);
>  
> -	} else if (__rte_mbuf_refcnt_update(m, -1) == 0) {
> +	refcnt_not_one = unlikely(rte_mbuf_refcnt_read(m) != 1);
> +	if (refcnt_not_one && __rte_mbuf_refcnt_update(m, -1) != 0)
> +		return NULL;
>  
> -		if (!RTE_MBUF_DIRECT(m)) {
> -			rte_pktmbuf_detach(m);
> -			if (RTE_MBUF_HAS_EXTBUF(m) &&
> -			    RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> -			    __rte_pktmbuf_pinned_extbuf_decref(m))
> -				return NULL;
> -		}
> +	if (unlikely(!RTE_MBUF_DIRECT(m))) {
> +		rte_pktmbuf_detach(m);
> +		if (RTE_MBUF_HAS_EXTBUF(m) &&
> +				RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> +				__rte_pktmbuf_pinned_extbuf_decref(m))
> +			return NULL;
> +	}
>  
> -		if (m->next != NULL)
> -			m->next = NULL;
> -		if (m->nb_segs != 1)
> -			m->nb_segs = 1;
> +	if (refcnt_not_one)
>  		rte_mbuf_refcnt_set(m, 1);
> +	if (m->nb_segs != 1)
> +		m->nb_segs = 1;
> +	if (m->next != NULL)
> +		m->next = NULL;
>  
> -		return m;
> -	}
> -	return NULL;
> +	return m;
>  }
>  
>  /**
> diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
> index a0df265b5d..37f2975158 100644
> --- a/lib/mbuf/rte_mbuf_core.h
> +++ b/lib/mbuf/rte_mbuf_core.h
> @@ -706,6 +706,7 @@ struct rte_mbuf_ext_shared_info {
>   */
>  #define RTE_MBUF_HAS_EXTBUF(mb) ((mb)->ol_flags & RTE_MBUF_F_EXTERNAL)
>  
> +#if !defined(RTE_TOOLCHAIN_GCC) || defined __DOXYGEN__
>  /**
>   * Returns TRUE if given mbuf is direct, or FALSE otherwise.
>   *
> @@ -714,6 +715,52 @@ struct rte_mbuf_ext_shared_info {
>   */
>  #define RTE_MBUF_DIRECT(mb) \
>  	(!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL)))
> +#else /* RTE_TOOLCHAIN_GCC */

Do we need the non-gcc block?

> +#if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
> +/* Macro optimized for code size.
> + * GCC only optimizes single-bit MSB tests this way, so we do it by hand with multi-bit.
> + *
> + * The flags RTE_MBUF_F_INDIRECT and RTE_MBUF_F_EXTERNAL are both in the MSB of the
> + * 64-bit ol_flags field, so we only compare this one byte instead of all 64 bits.
> + * On little endian architecture, the MSB of a 64-bit integer is at byte offset 7.
> + *
> + * Note: Tested on x86-64 using GCC version 16.0.0 20251019 (experimental).
> + *
> + * Without this optimization, GCC generates 17 bytes of instructions:
> + *      movabs rax,0x6000000000000000       // 10 bytes
> + *      and    rax,QWORD PTR [rdi+0x18]     // 4 bytes
> + *      sete   al                           // 3 bytes
> + * With this optimization, GCC generates only 7 bytes of instructions:
> + *      test   BYTE PTR [rdi+0x1f],0x60     // 4 bytes
> + *      sete   al                           // 3 bytes
> + *
> + * Note: Tested on loongarch using GCC version 15.2.0.
> + *
> + * Without this optimization, GCC generates 5 instructions:
> + *      ld.d        $a0, $a0, 24
> + *      move        $t0, $zero
> + *      lu52i.d     $t0, $t0, 1536
> + *      and         $a0, $a0, $t0
> + *      sltui       $a0, $a0, 1
> + * With this optimization, GCC generates only 3 instructions:
> + *      ld.bu       $a0, $a0, 31
> + *      andi        $a0, $a0, 0x60
> + *      sltui       $a0, $a0, 1
> + *
> + * Note: GCC also generates smaller code size with the optimized macro on many other architectures.
> + *
> + * Note: GCC generates the same code size as with the plain macro on ARM (64 and 32 bit).
> + */
> +static_assert((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) == UINT64_C(0x60) << (7 * CHAR_BIT),
> +	"(RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) is not 0x60 at byte offset 7");
> +#define RTE_MBUF_DIRECT(mb)     !(((const char *)(&(mb)->ol_flags))[7] & 0x60)
> +#elif RTE_BYTE_ORDER == RTE_BIG_ENDIAN
> +/* As described above; but on big endian architecture, the MSB is at byte offset 0. */
> +static_assert((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) == UINT64_C(0x60) << (7 * CHAR_BIT),
> +	"(RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) is not 0x60 at byte offset 0");
> +#define RTE_MBUF_DIRECT(mb)     !(((const char *)(&(mb)->ol_flags))[0] & 0x60)
> +#endif /* RTE_BYTE_ORDER */

Minor nit, the static assert is common, so can be put out of the endianness
check rather than duplicated. I'd also suggest putting the the comment
outside it too, so that the endianness check only covers one line each.
Also, in the comment, showing an example on one arch is probably enough,
showing two sort of implies that you should show all, while if you show
just one, you can clearly state its just one example.

BTW: if you want to remove the endian ifdefs, you can compute the offset
as e.g.

#define OLF_MSB (7 * (RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN)) // 7 for LE, 0 for BE
#define RTE_MBUF_DIRECT(mb)     !(((const char *)(&(mb)->ol_flags))[OLF_MSB] & 0x60)


> +#endif /* RTE_TOOLCHAIN_GCC */
>  
>  /** Uninitialized or unspecified port. */
>  #define RTE_MBUF_PORT_INVALID UINT16_MAX
> -- 
> 2.43.0
> 
