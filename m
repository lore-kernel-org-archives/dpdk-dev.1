Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EBDC44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 08:41:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA84D4028B;
	Fri, 17 Jul 2026 10:41:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9F9294028A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 10:41:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784277711; x=1815813711;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jl5+ixjJohxG57PYHoqwtWx+s4sFpk1Asy55r0bLbqk=;
 b=m5nSxK8rhN7iZzSWT0DB9tCbD9YA7+Il2RJs1Yfy6cP5AkNt6FZ+rgSj
 fXnMYTf4zeKKKe55OMaF4mCfFZEuz6K9oKjjgjatjTRzrHWz/tnpGBLkv
 FIppOSic/smDt1V/+kpXvB7atipjjbAlAETA9n3TrSuxUmGLZjOS5gg8D
 E/wRGPbKjISsQ2fM62ezCZ2sYXkXaD4nduAzcgS5CZFGuBawEZO/+4ub6
 ih3sMzDaEXLUvYUdhNBwZrKvP0VtlI0PrGSIlzO/cFbjpAZKHLR0qjNXr
 GHe7avx8oYKsQkjTAAqGhgmDVGHNdr6fEcyNm4Wm751NL+Zeffev0RLMn Q==;
X-CSE-ConnectionGUID: LQYmwRGlQyyh2jR95XAb7A==
X-CSE-MsgGUID: Fk5jQVWZSQedY4x5A899KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="96459731"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="96459731"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 01:41:50 -0700
X-CSE-ConnectionGUID: ldWWc0jARPeb/2Aadhp9Og==
X-CSE-MsgGUID: 18sddMT8StuRR25iBn88cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="286809744"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 01:41:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:41:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 01:41:48 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 01:41:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPxqQWU63XZDsrIkdfq6Fg9wSSzYlxSpgpQm3lH4Pt8inaMtE+J7IYzeBKAhTMtpt7S8MNOwPm8FPdaLzDJwJXWJ6+aHy959m1kaTBJ7v/mSb7b+mvOFD28CFhK7OwrX+2WRfjiRJ1FHKcmSjykKHPRrEo4fJBZaT3WCLIOYgIXASlSolCHrSg4AlZa7+fntNCiQOiTyh+jlJu/4ZwoPJ9jARlLMNm7Ltwd1e3l4A9lYtgUN5UlpHnojtxvo5cmwk6FM5SXO1GF9uqFoEaNRziQtNxCfToVk3nnZjo2GN/T8iapsRZJnFWDUrG8wEYZh0Wz61fhgE2tVflFFdGJ0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXqoQ0dbWEA1pHHYnsyrUgn2TaB6p+7TtERPNejVRGA=;
 b=ba253EfgQYOUL0Od6gkiPBGkrjCMTMZV8tc8HWMiB1RmjsjRG4ojabhv+IxiRUWbIlYYwVSMmy75Sz2LWTLi2vSPiX1Gwl4fmlxrnUO8iAF95zPy3kae7wQ+aWIzD5LWtO2Sa1mE7uHxrMltaHQT6AXsECQakDgRRhT6YBjuGw69CBzI4JYAM4zXp4XHaNYBO9ugELfJmZgIIqsVs6950J3X7/HAo8MqdUqZEdk0t/F7xg3yikzveHLjPsf4YYQrQ+JrUgLqFgvbCAJgJo3jNwejmj2RRNFVGXLHnWEXUdU7bKEs4wf6waJbEYLTQCs7SLyuPdFZx7FL8qXa7VBZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SJ2PR11MB8469.namprd11.prod.outlook.com (2603:10b6:a03:57b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Fri, 17 Jul
 2026 08:41:41 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 08:41:41 +0000
Message-ID: <16acd53d-6d66-44b5-acb0-feb495c96502@intel.com>
Date: Fri, 17 Jul 2026 09:41:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: add deprecation notice for iavf devarg auto
 reconfig
To: Ciara Loftus <ciara.loftus@intel.com>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>
References: <20260715105959.2216756-1-ciara.loftus@intel.com>
 <20260715122045.2256082-1-ciara.loftus@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260715122045.2256082-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::16) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SJ2PR11MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 773ea36f-135e-4f5f-b25e-08dee3df390f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3b1iNRrT4LlfRZoyH2WBAHbhy0HQLwCZONNVLvhSx9yEqCmfuPy5Z7nQInoRop2XFU1ArqB8F+xj/xOMJYaBQv/yquf6vqLYX1SEMopSUKyXMz+3Nrlqi27czgOx4Ts6IJLxjcds67q5nyThibJ/3zGTzCMRoLussn0nROgoxDwteA0cLiHwVaP5JqZtlyBKuw2XhvXad+W5iJVshacRESl3hbMnYzq1m6gtWjKMXR6dlmndJ6tm9Mf/yKuOxnLEbLUfy1QsAB/POng+C2anTbdw+49+HxUdUrfhZo2jabqWvKAony3aGzH9I1KMtwHCsemu9EfjigMS8Pj5wErU4BcZvlPNy5SXUdbv7aSM64Wdl425oRZNbpYpsyzx4KBBGt7WBJ2VqLcRCX5klHksliCVtKmVYlVEULTBaktp3p7hywwmPEH5eq8u+2IwfVCK3NxxQCp08zUVUwgtFISyBihFsvkD+wqYwpEFZ9ka6pfC/r6P3X++NWOSfgfRXqIs0rZsobkeoL+z4aRKATqG4km4W920gQeu3gfbZAkv+RqjbdA2oXoXIRS7L30emPrbNSfrHIY4x2pP0R7hq2S0M4o7JtnTA1lid1n2E9WQwL27jdZN4C5DBaLtBifjdiNxQTLvO01NfKhT43Jw/eKU+z3m2olrRUZ9HqxCpjN+SVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkNJSjdVdUVRZ05hc0tHOFo1L2xicVpPb2dnQmtNeWdGWUZpeTJHTmc1K0Jq?=
 =?utf-8?B?VmNYZXpRVjYzU0pNRFNhOXVqTXJYbW9TNUl4UjJGRGZtT01oVVRJbWt0TmhH?=
 =?utf-8?B?TVdOTHJUNmwyakFiVi80bVBuMzZac1ZCck4zTFgyNTVNb2kybGlqUFl0OC8x?=
 =?utf-8?B?ZGpMdFBJVG43R3ZjSzdDS1NEZEY5MmFIQVYxUW5YQTF2dnVTUmdCYml2N1g1?=
 =?utf-8?B?UHNzMFVFR25aRnhDM3pTZnFiU25uaHVzaFFqVUcwb2pDQ0RXcXlTRFhUNmxF?=
 =?utf-8?B?enp4QmQwR1RqMGFTZWZQSnBKV3NZc3pTbjFWb3dxWnEvbXRiN2prL0wzQ0gz?=
 =?utf-8?B?Z1BNeUZXbkZiSUNBRnFUMlloNlN1bkZMY3R5aFd5Z3dYTzhic0dxQ0NXdkJH?=
 =?utf-8?B?cGpSdWhwVDBXZ09pcVFwbUczQ2Y2Y3R1clZuc3Z3YVQ3YjE0R2tzYnNoZFB6?=
 =?utf-8?B?TzA1aGVySHVOTTU5YlFCZ0E2Si9yYVpZakV3MUdtMW5RRTdUM3M4M1JySDdV?=
 =?utf-8?B?Vk5vdlBQM3hLZ1lsbVRraFVXTm43OGZWWndmck9ycm52M2lEVTRpUXE1bGVI?=
 =?utf-8?B?NkFOSVBjSVcxekt4TDFPeXBJWit4cjlRaUxUZmZhakhqdTQyVnFhamZIQmpt?=
 =?utf-8?B?L0FMd3lXSGxsRWxyWFNsTmUzZHJsYlVMeWFFam1ZWXVHaTdiUTZlMzZmSloy?=
 =?utf-8?B?VmZ0SnBQMjkzbTZCQUpqMUpkemIwY0NmSmlDRDlFQnRoWG0rc3NxU1d1SHVm?=
 =?utf-8?B?dXN2dkE1UnNuRVM5UFp1TWc3R2ZkV2NMLysva1ZBUkJrVzBkR2J4TmE4cXhx?=
 =?utf-8?B?ZDNqbEx3STRKRlc1QjlkNnp2b1ZISml5VW9VTjY0YjN6M3NrakhVMkVUYk5S?=
 =?utf-8?B?S1FyUHljMGJKK3k4cVY2dUFQZ3BTVHRaVXMrUExlVW5PMnZhc0d6Y0k3M3I1?=
 =?utf-8?B?YmhGVzUzU09CVzJVdzlyUXpiUGRxMVY3amRJOXZOWEMzeVZMWnpXeTNUVVh1?=
 =?utf-8?B?R2Z2SmJJK2Ywb1ArNU0ydnZPK1hidUR4eXZYZzY4cVF6cTN0WnBBV0d6U1Vs?=
 =?utf-8?B?QTVCVlR3OHJCc1M2NGk1L1hkZ2QyYkN1NndpRHhhcHlWb2w1M0dIanRiRTJr?=
 =?utf-8?B?RTVoWnZtOS9ZaGNjM0tERkI4OGdtR2JkUjg1Szg2RUFGL2h1ODZvamdUeE5T?=
 =?utf-8?B?V2l1R3JZY2dlendGNnlYQWJ0NlRBUWcrSmF5TVRBZmJDa29KVlFuNWNPdk4w?=
 =?utf-8?B?YmttQWdNRnZndzA3VWZVUi9lWjNCdGJ0dU5VTXpuQ1dPZ3VTZkgxL21CTXdY?=
 =?utf-8?B?QkhkaVBjaGFvWGNXdXp3S0pMVEgrOVY2SkhVL1gxa3ErbVBXRkxqOWNhVW0w?=
 =?utf-8?B?N3dYTVdranphK01WYUJzcHlKUTlVMTFacWhFR3lMeUd4cHo3VUdkdzhFN2NV?=
 =?utf-8?B?LzdkcHJKald1VUtRWGg3RThmUDZ4Y3VpSzVjUmIvL0xOcmtSbDdZZ29FY1NX?=
 =?utf-8?B?RStNUjBrYWQ4UGkvZFFwd0taUjRYM25pOGtxWW9XRkxMaHRiYmp5cjB5dUxN?=
 =?utf-8?B?cm9JUWlyM3kwNG1KWEVLdUZjU1gyVkRLZkhWMkM5L2VMYzBZaWczVlVIVjZl?=
 =?utf-8?B?dUo3U3czN2RJaUg3N3Y4WE9mV0hjMnZKMWcxN3V3RzFXQnhraUo0enFrM09h?=
 =?utf-8?B?b2tjZUpPaEVqU05BSzdpQU1FeCtqRlNrZk5vUzdRdTdWQWtsRlFFWDEwOFpW?=
 =?utf-8?B?MU1iNURVM3poVFdHY0Rmak1JaC91RXMzQm1kK3pxYllmRkM3dnZrUmJPUjJ2?=
 =?utf-8?B?VFlNQyt5eHV6QWo2U2l4WXpWM2FObCtyMjBmNnVWRFJsQjBXclhxdERUNGhu?=
 =?utf-8?B?M0h2TU8xd3RuZTRvSk5ockZQSk1CNWk5VlVlaHFtK1ZlN3ZmSVIzUTAvaTNE?=
 =?utf-8?B?VzRFNmxyRUl4Z0g4VkRic1Y0R0hDeW4vRlE3ZHlOL0VlSXFxbmtpWFhQZ0ht?=
 =?utf-8?B?TFFVWHR4eVNGajNKcnBkalFBRHhVdnNrRGxqOTY4MGhIbkFSOERrYml6RVJz?=
 =?utf-8?B?N203bkg5b2JqdGd4Y2hGOCtLT0FrRjM1NEpwZUcrc1FTeFlLZlhzU3IzSTFl?=
 =?utf-8?B?NUI0ZlVYd1BrUlhUYXVpdXAwS2g1ZUNLc1pYRS9FeTFTUWg2QytuUGEzaHJV?=
 =?utf-8?B?T1JuRG43dm5zZlpMRTJJSTh0M1huS2JYYXhJUTdIS2JIbXBiV1ZzQk5KV3dX?=
 =?utf-8?B?RUpxb0VlQkpSVTQwbzRsNm5WZDl2NUtiTjdCek5aNVQ1S25JalN2eXhESnNn?=
 =?utf-8?B?TDBOd2hGVnNLaUE4NzQyam1KL0VoTDlyNU16bjVqUnRkRDc4ZVZ3VE5OZzkw?=
 =?utf-8?Q?Z+ksWis8XdTBnE2Y=3D?=
X-Exchange-RoutingPolicyChecked: MWFWPWEvogcZYU7orDF0YqrCI/CMDUnVkABDGgUt5oa6c9Spvq3jwCEoXoUz50gN+Ip6BUTEpz3fvgzrq+9zwR5j7Ytc9LgpPucHyfjDcps/krqFJBeCjU7MAuCGqkl4/6ucU14l5emoTZV0lh5G8amPOtjk+dfPZCYxhq+c8DFIQvTQ8sFiU6n+/HhjOREEgQ1cvCIWgXL6HkymhBL3m1MVTB1hMEuPIMJOaN9yPOcwQUsftIRXCyMAZkPLRxdLQB6acUxrobN9fvxVIcq1W46Ybpe71OD+RjGauD05Bhg9x2YYk/+/W6ot3TjPF0hkLlTPWi37Tcf0t2LqY+O5/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 773ea36f-135e-4f5f-b25e-08dee3df390f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 08:41:41.1163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wl4wv5J7W8NS4v8P7YVc4WrXWsA2ejZrHIT3PZNgx1L+m08iWqCVM5OdmPEoA3KGLHz0Be/PtBB1yEThBi7L+Hvx57i+4B3dlwmwwJ1lDgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8469
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 7/15/2026 1:20 PM, Ciara Loftus wrote:
> The `auto_reconfig` devarg in the iavf driver is enabled by default and the
> case for ever disabling it is weak. When disabled, it means the user is
> requesting the driver not to restore settings (unicast/multicast
> promiscuous modes) when recovering from a reset. The use case where this
> might be desired is during a VF initiated reset where the user initiates
> the reset and wants the VF brought back up in an untouched state. That
> scenario can be facilitated by extending the `rte_pmd_iavf_reinit` API
> rather than relying on this devarg, so it should be safe to remove the
> devarg.
>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v2:
> * Shortened deprecation note
> ---
>   doc/guides/rel_notes/deprecation.rst | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
> index f5c12cc747..910feb7cf2 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -159,3 +159,9 @@ Deprecation Notices
>   * net/iavf: The dynamic mbuf field used to detect LLDP packets on the
>     transmit path in the iavf PMD will be removed in a future release.
>     After removal, only packet type-based detection will be supported.
> +
> +* net/iavf: The ``auto_reconfig`` devarg is deprecated and will be removed
> +  in a future release. It allows disabling the automatic restoration of
> +  device settings after a VF reset, but this is of questionable value
> +  since most applications expect their settings to be preserved
> +  transparently across a reset.

-- 
Regards,
Vladimir

