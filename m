Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46927CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 08:09:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A7B14025E;
	Thu, 23 Oct 2025 10:09:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 914C1400D6
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761206941; x=1792742941;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=mQ81+VTn70GfnwvNqpAtSex906G/rAK/K6oWYV4Uj3I=;
 b=LFpaAejVglKG+LybUV2e14gqKbjJthkxWr/BQ02QvDf27pmfJkS3Iwo0
 FOxtljc4VtGcDWQ4M99EuSefBuA8CpCdNnX5bkFsphxTQ7ghy7vX/e6mK
 MTbHN6xCwS3Nllvj2VZLB2A9U/6ThE48t1ernj6r5uvsw3lohY97d0pJx
 7aUHok0Um9nC++XXd0vI+Kyfi0ZT9yQFCKZFwN5KSL0dEXk9XX3B5srjD
 U99036k7rZg+0DygQv6/YWdNaYNAi9fNkCF5GTDYFFlZs+Kzd9FKhasaO
 EeJs6UFeykRzEVQk6PSUeOrqS2Re1INYzCX+KVlJIwebpxcwM8nAAavci A==;
X-CSE-ConnectionGUID: bWIRZ/cJRAG/LK2VTzNauQ==
X-CSE-MsgGUID: NeqBRBZASki+FppP4QKBiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67014721"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; d="scan'208";a="67014721"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 01:09:00 -0700
X-CSE-ConnectionGUID: b+bKGr9lQfSs/DaP4UfBng==
X-CSE-MsgGUID: AbIfZLXgT42ZCwAAbGTXJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; d="scan'208";a="189360433"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 01:08:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 01:08:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 01:08:58 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 01:08:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlxWioOlimlf2LJicAyO6TDBovQxInMhsqTD2EHs0njhw/nABS6rZbfcdy3v+0SC7FKpu+pGZaRrloFUmxn0YV+9h+y6NkVpHdIWIFFbWsEAvawkGA7xo6MLYqvqE8KYDxqCqSAVvYijAIVmMwUio77LGfdPbA32lC8xxPBAymxPxkjfsa9EcnHAeE+G1IKUY1cOmxIgl6ztkBwIj0Bh6S17xq3TVpG8JNxsQrOGTeiqnyMaSI734PBuQoy4r/hs14wBb+FYfazGViuWnr86Ce04ijFYxkeLt9aUDPAoqSm+f4s8+9BOIjHvS/am7nk4VbbV30IpfSMRByiMnnDYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSnRIvtfmDKXF+SEa+QuZtDnOJJ5wxhncf2lvRvZma8=;
 b=C2XxAGycloc1qraRfUYT3IIC+yakcKQhEa2qLl8p1kuGNSFk3R2NkPKXMDpy8JvWIjWqf7vqjVgDgc6GlNX4siiDwJ8brXASeKU3M9GB5SdCQIlB0K5p/RsROFd3ga+Ek9X5Tsr378JYX0d30nodOD56QEKBpozNOxF3S/i6XD+7ZbAM/kQd2dkYBaRCsgi3iBmlGKZR+C5IupREQZaUsJHuCwXMcXIpW/rtg0z/rArA+tXN7n2OethAcoa/boovaDQdQ0h/hGcwL2DjvHSKVTASfRGKUIsaZpwmmjbYL910H/3ZZ+G9VKC1Abhjc+H0NiLHdC8y9n9RLe60gba1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7464.namprd11.prod.outlook.com (2603:10b6:806:31b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 08:08:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 08:08:56 +0000
Date: Thu, 23 Oct 2025 09:08:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>, "Wathsala
 Vithanage" <wathsala.vithanage@arm.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v5] mbuf: optimize segment prefree
Message-ID: <aPnilEYrXBC8rwv4@bricha3-mobl1.ger.corp.intel.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20251023080136.165513-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251023080136.165513-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DB9PR06CA0010.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f8c90b-a276-46b7-a9d3-08de120b6a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?SHAuYxP+V17dL4mZT+m2wxGi5jljpyUDC+85KaP/K/T+EpoeDJtnzMojfq?=
 =?iso-8859-1?Q?V6F0w33at+nW+wIO2ZapOuT3lumqnZ+vVKrbUAsMyYuZ6mtRD5z+cBwvqW?=
 =?iso-8859-1?Q?BEbkNtriYr4ckPFJXIIaHH2nXiFBLcsI9cGxFFjJKUkAwbFB+PGaRINEBG?=
 =?iso-8859-1?Q?gNFVB2r2Gn8Ldh4KJknxHqfy+QELeqZZAcEygqVET1DHiU070rYU/214po?=
 =?iso-8859-1?Q?DHHywltVzEm54/dhAx5MGmsTNuwIEulLdZ+54gSn/9rgMDjgeI2J0zmSbF?=
 =?iso-8859-1?Q?vbl6cFAuohon8aKiuNzvWhvoXs0UCbyYP4oayl3Z4A27YQuDzBdydiUdkZ?=
 =?iso-8859-1?Q?OOP9n7UGhuI5ULVoEtKTBAVSY5C1s0DCMmaT+0dzLgQ3DElkbfWJtiOmUB?=
 =?iso-8859-1?Q?CDGSEp0zKtglxetLW4dtgv4DOtALSgn0NNxlMWQ2dc5AXeQU8BNOh+rbXN?=
 =?iso-8859-1?Q?IEIZR2jt7WZ7Cx3KXFBhC1EdZr45wGF18iSI00PzwNxqzw/GKHut9DO7d3?=
 =?iso-8859-1?Q?161qzhiCUTkw5aU/ELJmjImFQ5Pwc3KvhN5jEZAG24aQMl1OK+Wo8Lptfe?=
 =?iso-8859-1?Q?jFKEp2pJXk8+ooNpPtmK5MBXv5R6OQBFV23t5Q4Zn8frKB8Qp/WeUMDjJk?=
 =?iso-8859-1?Q?Lg0zmaFLucBtLyEHupV1O7wg/XXDuthWh0Gf8iv2e9azqOHxUmHKqlXf6w?=
 =?iso-8859-1?Q?5S3zBY+SCEVTfVu/ilk+WU8oroGY0Z06dHgE0qoCTVfHdkC9fJHFuD04Cb?=
 =?iso-8859-1?Q?269VY05p2LdsqDYfWU4C+NalV1DK5SaaevVbN0+Jj4HltKNhr2BSlya4o/?=
 =?iso-8859-1?Q?71gHzMsSwZ4/xMExCboucUC6Afu7qz+ntBbm2JI5c/q0taPZmyylhacJBa?=
 =?iso-8859-1?Q?6MG+u75Xa8CxKETsR9gpIR/NugMTfvifR5xh1xTQErbovfAMMf/MmEG85E?=
 =?iso-8859-1?Q?HRRCzzoN/dRq+BPs9fRYCwZzGuvhuUakaDptJGxrcs4uQk/UHev9NCTnyY?=
 =?iso-8859-1?Q?frduzI1r+ArfKm9BIwQ88S24dPgCc9acjLRU11WaAHIwECSUCLpcYsL6Np?=
 =?iso-8859-1?Q?0P/nzSvpZy3uv7BwLtoU+iJz7+hUZeXOcp+GRgY/vAcsmPkYr7fLyVgQvq?=
 =?iso-8859-1?Q?1o2ngUDaIhCNsLZ9f5+u7JZtk+7wz3X4csuj+LLr+LNCrPGj3b9V0symNz?=
 =?iso-8859-1?Q?dzm2vvbVkfefRX+SeXXpHsDaJo8CzybryW5ZnqsqTx2nlf9/FabXLM06Rg?=
 =?iso-8859-1?Q?GdaNr4H6ohK8K1cVPFXIjurjgfnlEZqEpA6/HYiJTiRmJy1f7kLFlxtdrd?=
 =?iso-8859-1?Q?jKGgxbznEZrH+m0L+zFuRJF9l5QvagMpTi6YM8zmeGZtm7MY9zySkvILUx?=
 =?iso-8859-1?Q?D31v5yf7Zuonvs47vBgQ0lfDEsjUNchIcS9C0HCLIuCs3rUpq6UN+72cqe?=
 =?iso-8859-1?Q?L4J4u/DN+RTQvK+ZA3Mc3PUDTybdVqcXr9gVCLIg744IS4aRF6VLNpMx2Z?=
 =?iso-8859-1?Q?WyH6yEyzHXH33T/r+YW7rK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?STeKpE3mIf1ZPZn+8CW7V+sxAmjpDtZ8hraAB9OM1MDYiaIhMzt28Gq4zr?=
 =?iso-8859-1?Q?DSdZf0kalIAO9rYZEe0R8uS/DeXsXlUwTULjhjMWvXdPrJtIABZc2oHq17?=
 =?iso-8859-1?Q?xdjc91KxgeOYh0sutULs79xJls5PwHJMiVGxBSg+u96YoEH2jqtERP9djW?=
 =?iso-8859-1?Q?H1IJONA+RntAgPkGlL22XBn1uD8Xij8YHuXMZORKO8h0QSFi0LB2v6ewVx?=
 =?iso-8859-1?Q?faASdyDwqDtpX7R5XKR2bG1Qv6wTe4fqUbXMSpLDX8fhr1dYTLGbk4U2We?=
 =?iso-8859-1?Q?6CXWxpWBsxg3gmoZYEzVCWQ/N9UwbyaSJ5oBGIlr/WZHTfjV9h4xU/PxB1?=
 =?iso-8859-1?Q?4iDfKl47YH1jPNGpuW/Wm2/ZLjCY9iUUvbwmGar15I+clj6DRNS/R2fnQT?=
 =?iso-8859-1?Q?corzJHK5DJlYR6HGKb6PYjVX+pcKAkckCrJeMeLvPfhHFSeqvkQ5xzgH8P?=
 =?iso-8859-1?Q?ei4urR3woZY25+i2obWY0Ub+GFzS60G0ABWHwhHB07NTvjz3oxBv1L78ZI?=
 =?iso-8859-1?Q?AeRKDt1QQEkQE5T+TGe/zP04O3cfA50WcNZAk5061WB1fVk10Jjqh0o3CK?=
 =?iso-8859-1?Q?TO8pP+5fBQJwxn1VhLdj8FO0NLQXF0tg8iqsoUNm4QZHkK+0EAME9BpNXS?=
 =?iso-8859-1?Q?EG7rbOcJezaHhKUdQIexH1aWLIO4vwcoLb2nqfyyjloSIk9rQCi20cVNyC?=
 =?iso-8859-1?Q?1sKaepmfHfKr2W2M0D///8bOG4TwffLYHIpFpZPGbRNw1ZFcWnuR32mqRA?=
 =?iso-8859-1?Q?AB0X4ZN61/oqFZ2XTZJtw5nBAAycJDmRX+OwNQnbSU9IgzdIE08L1o+Cw9?=
 =?iso-8859-1?Q?waXpxt323K6bHP9ctzokoGplw57PCY9cEy9a3rk5pA6uH8GbTrZotn/zjF?=
 =?iso-8859-1?Q?UUvHarNdxU/X1CzszFZkwrd6ekXpGcU39AQsWgZKkAyQhUKl9hQrwtIISR?=
 =?iso-8859-1?Q?D8TFuUCFoHZbeej+o81wDTBpaAYxjQihWOTYWbeuY4BlJcUJwrK61odu9x?=
 =?iso-8859-1?Q?A9oMIDMPCUUjTSy23SDc1n4L+OVqgdvD8ertgJhKEvasuli9rjN0YC6nSs?=
 =?iso-8859-1?Q?mMZPxgrTF1foCFRcjItn05WKLAfkZAB1EKLS5a/T9URtq844MSndoSEDk1?=
 =?iso-8859-1?Q?erf5Z17PhYTGr0OC752Pqs9MK2W3MEyRuTXnqDzCUh73ZPtEyOGAbffvSs?=
 =?iso-8859-1?Q?uC9DTBIkNeDCInO9/AMj6bg+Q8iE/11GCzGpiZy35iVff651rFDJFinlHO?=
 =?iso-8859-1?Q?qdwxjqEF29PeW7QiDKCb3wKXUyPoVdrOlwpezKeMlXgQYBxUlctHEc2QD4?=
 =?iso-8859-1?Q?fdqWxZKqID1j4XA5D2zDgcdyHwLUN81oqwgLZHR3o0IRsJ+8KyYBBNdjHj?=
 =?iso-8859-1?Q?FS8wCjbatkDnEoIhZNpJXlCWm6oVr79zyB69TrzqU1l0Ytel5+nZ6LkUSw?=
 =?iso-8859-1?Q?1SsrHloLCs4Va3diV4l6n2G7TkbGfQb4r+GhtZhcMqF1XDf5GtjtFhR09x?=
 =?iso-8859-1?Q?0jEkSvaBiiwhChV9A8VqKbYYr3Ina4umBI1MvpxJaKruKRinmoK3Ff+RYu?=
 =?iso-8859-1?Q?UHYpT1G+0IWDjbg9mJ/1gkoOQ7GvMYV1lidYNxx9EEhk47p2mBoQCMk5Wx?=
 =?iso-8859-1?Q?7FNY/QaTjqoclOpwFo9jFupMhZ+ReM8wbPubEFXGkdqqiQgYLsuyUvVw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f8c90b-a276-46b7-a9d3-08de120b6a07
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 08:08:56.7980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsAQ/xu2UDpsSs/jHLd6Xg8xBXv9OhoNHmWgjGm690IiQJB+h+oaXVdf4VY5cClfJ72ds8Ts3S9j5D46HPOwmgfxKM5OxMdhHDesx/6QxgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7464
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

On Thu, Oct 23, 2025 at 08:01:36AM +0000, Morten Brørup wrote:
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
> v5:
> * Removed the plain RTE_MBUF_DIRECT() macro, and only use the optimized
>   variant. (Bruce Richardson)
>   Further testing on Godbolt confirmed that other compilers benefit from
>   the optimized macro too.
> * Shortened the description of the RTE_MBUF_DIRECT() macro, and only
>   provide one example of code emitted by a compiler. (Bruce Richardson)
> * Consolidated the static_assert() into one, covering both little and big
>   endian.
>   This also reduces the amount of endian-conditional source code and
>   improves readability.
>   (Bruce Richardson)
> * Added comment about MSB meaning "most significant byte".

LGTM now thanks!
