Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6B3E9E31B
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:44:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51242402D3;
	Wed, 11 Feb 2026 15:44:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 563DA40297
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:44:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770821073; x=1802357073;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=P/wo5zkK03/SqGVtvE7IevQzziPAH67tZl1IG+QTWME=;
 b=gaOs173KBi6nbwSZ9xbE8CrWerbvYdVSunnTEej4Sk/dpYOaT7XwMelj
 ch32Jd7YZWT7MHkX7iJokHgYGoC/Kppd+z/YsMlc3FXWaRLHsqiy54TjQ
 kD+T3cjDkE11EARa7hKf8sCcNp115o8Z9YcoY9aLCn6gHXjoCqVbc+cNK
 7IE7eSWTWH0Ehn3FSquJ7N2Z/zQQHIbKE2R9/bmeXxxUmjD59Vsq69fz/
 33fQvhfxSm0bEw/VtcwWVK6T9GOd3wIIfrSzVVKwd6SsP7sllLULGw3i5
 vF2plf5sg52JhR7cy7hJsM66nJpGvL4jeHqqh1iCLkWYkhZgVBzMELxRm A==;
X-CSE-ConnectionGUID: mnLiZmivT7KJKjgrC4+svA==
X-CSE-MsgGUID: L1cdvLDdStKkK+VOXPD5YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75593813"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75593813"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:44:32 -0800
X-CSE-ConnectionGUID: Ac2AQU8IS+mb0ydNhH2YCQ==
X-CSE-MsgGUID: derY1dSDTZqrXchhjEkV/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="242869327"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:44:31 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 06:44:30 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 06:44:30 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 06:44:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsqsJYsIt04+N2s7PKS6/cdteTK4TqnSoeQwdgaQywhQkhuKgqwxojSKsVrSTAJESyYM+k94Bv1KkPJf9t4CqLB7l5GG38ELQo3eHXPLnw0dM7Yi9l6K6XD+IK30OuXOg3WwiMwwaVObxDqg3hVq3fkEvG+C8a1Fw4O5UQy3dN7+2ajrM29t1UYkTMV9CPhBItxB1ZacauVg6moebEd7y9YVRb7aAfO4M+WPcJI3x8/+CeBeSuqycWIMMexVazczar64nApb4T7z6Pqfe75PGMNp2kVCgxa2y26FTnu6zymhKF/83BzvtYfISjE8UY1zTeJlhQrkRiXwChyK7kOuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vTYjJb2DX2mFpec4ePJi8yR1CjJGdyCKULWM5HVqXI=;
 b=I1SjjATt3u/d2coNFhCeoHjDOrVbtB9sBnMGwpNZWxCXmSqZDmd0dB7pb0T1QKnY/ZhxJHRatgHB7SpSEkzBuyRf+Bh24z98II2kksWgP/B9lO/nE44/lq44Ddf1K7g8GYdpJfmf53Omp+5+E5cnBI9zIhaLMtm7vTW7J1PgBkcFKYl1eqQbdB4SzIzbhDrNWnCkCRB8SbK5/TMc9Aqfd6vfrYYp2FIsu3IUqbdpYp2xBPdT7FWMvi5jTp2lDwI8CBUcDsmi+6CCDIagJPKHn+0v1zjD/J2Jk+Cv5Ib7GbMOv7WywdbJZOJ0HRzUMyjZvZZG3SthSRWUZsJV0+AMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB8826.namprd11.prod.outlook.com (2603:10b6:8:256::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 14:44:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 14:44:27 +0000
Date: Wed, 11 Feb 2026 14:44:22 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 20/35] net/intel: write descriptors using non-volatile
 pointers
Message-ID: <aYyVxtCg3u6t6IEr@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-21-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656F6@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656F6@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0340.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: e552f185-bf29-4b36-3b53-08de697c0e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?NMgJ8zOONMQn55lJkjv8sbQHGH3Tv8pl48QGSkTiLNJzTLxoPFwlUby7UO?=
 =?iso-8859-1?Q?BGJDgDIK9mkpLK1Lxtl9sIqKDUZT4J1KufZaSd6O8dQTHpPjCI0VaJIF4q?=
 =?iso-8859-1?Q?7qBdYYWDStu4j/TUlchG/9M3zfUis051+OwVgVbh2veWYDOBZI18M/4Zin?=
 =?iso-8859-1?Q?Yd3Pssbg09BZoCrQ6FJtfMhICleDim6w/aXe39NaFw82B7k9JQBnPbx9H4?=
 =?iso-8859-1?Q?Z52OGJOKKG5g9KDHWiCRqaj301EoisoJHA5jjgtseGSxH+9s6tk4A4Oync?=
 =?iso-8859-1?Q?BO6Wswo7fusvrZxFKRJHbMBwz5cFOx92JNrwfRmWUffKiNZZwuJOaUiyaN?=
 =?iso-8859-1?Q?XEZ5AtDmO/Mrn0jXdH8SY3OAzfImz0tuq1HpfAqASEVzSD48g5hQwCw0kN?=
 =?iso-8859-1?Q?YF5LpctCJ2Vi+xWLVfYexsLQgdMz+47lMGsz9NEwZCc3odUtMu/JU+FoXm?=
 =?iso-8859-1?Q?lzs3tNIFoigzR6qEsdGDc/LjO/HlwfNUbpllXiAq4D52I0Oxlv+ilNJ6d3?=
 =?iso-8859-1?Q?asRft+tzcHA/L7bulJkzUbS8CTBcKBYy9Z+1IqLAHhD7YGmB6kBtAIJVsK?=
 =?iso-8859-1?Q?Tuiv38PGUfBqlbkrt516fNXJHCOwoL8PkbuVS+FggdJzPK9Z12bgNUjeUf?=
 =?iso-8859-1?Q?t5R8UPxRuaGph3PU9kHIyGmQJtkWFFjKanEZiVAJb4BVduT3OhvbTpgKyA?=
 =?iso-8859-1?Q?YkDo3LemBEszqooaxdfcAqZZc4MGVKMTsdQNpuBL8Jm1FiMgix/oIls/uZ?=
 =?iso-8859-1?Q?cTignxRAGrEzFyzm6Cu/oZ/ICKxzgrouSrVqAE7or0aomnGeKI+5ZvmQZV?=
 =?iso-8859-1?Q?40d2821USedneElRlLDUOy8wwU1NDF78Xo3nE6KgdbsocoMXH2ty0Otft9?=
 =?iso-8859-1?Q?s53OrBDSSUrWOQNaSrThychqOdpSGsqI0tdveng3oMsQKgW5gH/z1Xen92?=
 =?iso-8859-1?Q?pk3lccqvmVowOxsRZoG4aRTKVl85kIJAOaykaxubmt8CEv5FviwWX/XoQN?=
 =?iso-8859-1?Q?wD6m1MXOlS8Lzc/BJUEHwQdEzQU9i8G03hZwNXZnhH40KSsTaCMQIXmZ81?=
 =?iso-8859-1?Q?F4VvrdhSNrKM0zNhZgm6/PqI/npS/avskH8q4OxHNyYJEFT7KXolH1xS5z?=
 =?iso-8859-1?Q?QUBJOoSW+pc8vZDUfnCO16hL01WPxl1bWHxJFFuQBZhAoJAPaXCi+X0bQ1?=
 =?iso-8859-1?Q?DVmJLEBwC1UABVZcFFP6LfWdQQCL19d+cXhYuYTP7KaY7rMPVtOzu3CIZN?=
 =?iso-8859-1?Q?4YUyB/Jcx8vEaWdd/nWVp9haceYXFSsxzd36XmG7zAtEP28QBWJ7XD5qzC?=
 =?iso-8859-1?Q?tJ78ii/Dmxc/NVWK5qp0K+lAWs/RGDSVAa/MP+9/6pec8lSUVXaqkc8m3m?=
 =?iso-8859-1?Q?d4cltkLGHnQa2tK0Wi2ZIoRsv4UFIXrxLd8GHziNLiTDPJjVaPSnnHoFN4?=
 =?iso-8859-1?Q?ipkQhYHMn2lh97SEdatzVopngsuUYEWoC7Q64OM4KV0Cv2aATfOSLnwf7u?=
 =?iso-8859-1?Q?Vqr7SiLCT0bMxjzEahKWWtscq/FOBx2TWcInAVWA2Agn7hKQ8pxCR7oJhI?=
 =?iso-8859-1?Q?qUoqKFaH7WXQIFcMtj+kvD3eEevRjoy8FhjHs9F/vm+5ushUK1W4bAWXfb?=
 =?iso-8859-1?Q?0GzCa3LC3X50M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+0zTRSKlHoKH94O6sPk1k2r62sxKros+1PsxA8pG9JU4Q0ISIsTfK8no68?=
 =?iso-8859-1?Q?6IVGE8QTyiI+NMtbegagjDDgpwh8HTfdw2idY+EpANTylkOUo6h/vH95mo?=
 =?iso-8859-1?Q?CG3ObsXCF7ZoyjdUYUBakCrebQcifu16L0PrURWnwKB3+4oIWQvodZFhll?=
 =?iso-8859-1?Q?sc2jenugaP3QcNKcw7YtOwVmQDDr6KvXNVoDdv+yhcOKJ2aux3vnA+Wq05?=
 =?iso-8859-1?Q?PxyAnrTuPYAfgJFg6tqjTiR8AJf130hkSKMbyzWZqGLHCFmlKvXovxMAHo?=
 =?iso-8859-1?Q?YF21WwEvKeYrBS/KcA68+I4qfBKKYGZXCS3MwBs79k6Zrt4uI/eKr+6xSb?=
 =?iso-8859-1?Q?fq6S84INhQvg6YGsaskeKC2/ykP37TvVq6ouMK873p1vOz2zmPn2YSbmld?=
 =?iso-8859-1?Q?immwV3TRAISS0X+5cSWbXYvxpJkzhVnDVGpgvUCFJl6QvVuwaKqGe2d+/Y?=
 =?iso-8859-1?Q?JRhUsdo54DZ7ghAA2t+p0WI9YNEocPHGw6UIPeOV/LcLEWibEGA/sPhN80?=
 =?iso-8859-1?Q?r9pRvOEVXw7TGoVf+7aOijM7YK5I3P/Ej8amSYUE7SI1ZYPrbLQxA0Suj1?=
 =?iso-8859-1?Q?z+8Xutv80h6vCkHNuL779jGzsKSd577RoC7S0Qa95HG5/bPOqaJPQ4UhvE?=
 =?iso-8859-1?Q?QyCiSacaUoyPXsAcS0zxUUJiVtx7rJzjyUutNfllMz3tH6emqsLUXNOGFf?=
 =?iso-8859-1?Q?4zxDlwbpw4bpVdWu1oXUWXv3nBU3Bw19JhWrEFh/wjJKIccuT48mvFN7vR?=
 =?iso-8859-1?Q?iW1QJ9+7QzChKbY9BZf+edMwHNSUV4KFTpYzDOWZG2CyJUwVhejDnwOdwe?=
 =?iso-8859-1?Q?Qv0PaMlH95sKugcAB/TEOlAdOg5L1CrHejI9SYLxjFAzOiqabTIAnx9hcs?=
 =?iso-8859-1?Q?oRiuBUdwVkj0rO3MCOV8BSZLX3WVWJJ2ioY93DoWtrzJ6KbVspxrNd980b?=
 =?iso-8859-1?Q?46ah6KEdxszEnTaH68WQO6cwsGK4OcQD8LCCXpPGjqNv5HerK5gn3Lay6a?=
 =?iso-8859-1?Q?Nu3G8nFUTuVRVxftx1YNTn0H5F0G3jYvYpiGCGVBZs+PVtNsKHKjc7uVnH?=
 =?iso-8859-1?Q?7ypw1zFOdRRysph5/NOPAoX/Me4273k8UFLMeF29IlVc99/46oHATmY6Dl?=
 =?iso-8859-1?Q?ye6K98hH7VkmDo2Ckf3iLNrxMnDDW+bkMoa9MzRElSbpqFCsWQf6TNCZn7?=
 =?iso-8859-1?Q?8k/15IQUZEq6rniqTW2dBi18hYeiGNZSeS2gPkqif1LGdSDjVziw2MC6gW?=
 =?iso-8859-1?Q?MFcFVdpmucPwT1qB6X/fig06UENhfbM63IT3bHrtECXh2KRnKTCYngVVwv?=
 =?iso-8859-1?Q?imPR4Gnats5d0xHI1Mqs4Ojy/NxOBYzKaLfrTOnm+Ev9X1Q1rYtz+U5fjP?=
 =?iso-8859-1?Q?CVy8EHpWgg7o21F6gzyoxbnRBVicxWsfOEL6tYf4UVWw14NP3cfls6hDYc?=
 =?iso-8859-1?Q?Wzx5tJ3sQDn3TteBiGEs8X5qkaOMD726rHKHSc6GzM+zP4P2VhsCJgPVok?=
 =?iso-8859-1?Q?n+qX05ZGIFgaHBkWLGEbpVnRl02YqEKaOTRwlThsfqHWYudGipWvZfLZ7c?=
 =?iso-8859-1?Q?QtRn+gqXdOGfqF7SxOpuSpJ5e0vzfVO+oi31CEvtEc0sHJrUm0LV6tPVEm?=
 =?iso-8859-1?Q?UlPQ0z/T7FzPRGrQtCIqV9KdHkqDkvFptmMmBu9CIIqjKDBGoQPIofIn97?=
 =?iso-8859-1?Q?KgxGakbBBwNHFr0PNn/DiKBUrhIW227NRojbTgULvI8s/fSdgFn1cX0j42?=
 =?iso-8859-1?Q?ZEB++Skk5Ckj4KOYrbFMIQWem/MHSVOJsU0l+y80ii4TApqQVuveBvwerv?=
 =?iso-8859-1?Q?EQK9MEJ77LGqwrh0ukP26a49Q7RQzmk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e552f185-bf29-4b36-3b53-08de697c0e77
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 14:44:27.4022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tF1x5MWzU76F+z8DWOpwQys5bNaAkqfV6m4uHR+Zszd8+khVZUggunfI3/0jQADx04fNe3tIbkG+RKo7EmjtwuovJFyxovpBNuTazJ+SSl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8826
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

On Tue, Feb 10, 2026 at 12:08:44AM +0100, Morten Brørup wrote:
> > +static inline void
> > +write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
> > +{
> > +	uint64_t *txd_qw = __rte_assume_aligned(RTE_CAST_PTR(void *,
> > txd), 16);
> > +
> > +	txd_qw[0] = rte_cpu_to_le_64(qw0);
> > +	txd_qw[1] = rte_cpu_to_le_64(qw1);
> > +}
> 
> How about using __rte_aligned() instead, something like this (untested):
> 
> struct __rte_aligned(16) txd_t {
> 	uint64_t	qw0;
> 	uint64_t	qw1;
> };
> 
> *RTE_CAST_PTR(volatile struct txd_t *, txd) = {
> 	rte_cpu_to_le_64(qw0),
> 	rte_cpu_to_le_64(qw1)
> };
> 
This approach works fine, and allows me to drop the previous patch too.
Updating to use a struct type in next revision.

/Bruce
