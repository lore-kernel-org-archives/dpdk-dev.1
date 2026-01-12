Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD4AC9EC9A
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 16:09:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6A2C40156;
	Mon, 12 Jan 2026 17:09:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 983F040156
 for <dev@dpdk.org>; Mon, 12 Jan 2026 17:09:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768234154; x=1799770154;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cy+hkPkitAsvRMsp8BO7cuAM/o/lqcWhidlPK+tqMeg=;
 b=K51u4W5wN19YXaRSf8vl5RehS8ah1AyxVX7psAVJH6LPAu8IyzHXD2Lo
 0Bqz6u9eUJ9l6qYy1MM6O1Q9PxLW82YZEKKX0VqyD1owdE+NPH/iZTE/9
 HA/OCoDXGgEK41P0FdlFASbGW3VlOnLjWq7xMwq09aDvdokk/CdNUy0QI
 3Wv/8pEFO6NDx9l28Au+bwqCZibRbrv4f3fJyIduUFxyOP/Y8olYchH+t
 Z7ESJkq0Bc7vnKI+QAnfiYlLEqNqgDy2ZYdUUYLD2f/82iiZxjVgeAKqs
 n5QFJmQRP3+DNNGzXcqSPzMxd+yey8sqhCW5Wvj0UAuCpR2/NPOKxNGlv g==;
X-CSE-ConnectionGUID: PM1EoJp3QAm3TV3Nik2QfQ==
X-CSE-MsgGUID: fWGZNmYOT4CaV/aq7mqjmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="80231788"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; d="scan'208";a="80231788"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2026 08:09:13 -0800
X-CSE-ConnectionGUID: iaBzVyjeRSSH+rZlceJVGg==
X-CSE-MsgGUID: Q2m57vouTPaM+m4++ZES3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; d="scan'208";a="204035701"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2026 08:09:13 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 08:09:12 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 08:09:12 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 08:09:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEQyj3FMa15VpFRhMtyYNMJgLlmyLdAUJCucYflliCVtg3kS1747UyScPbxaA9Qku05FGW7X5/hieoJAMZSas+X++Lsr/K+RNeRlACyQNMgt0JzC5FS4ix9RfXPq3Kcf69X66+AlcISSZexgnMaYAKCHshlj18Osaf78cOWWyFlYzyeX0NRvDsUbFh2jDutFncCjoo7KjkCAyRQJMOTGlFQJddBuGHF7QYfTZiNTWJ4wkjgdEnjMR2cci/JZ+puEyQRF0QQEV51AwmnacZuKjYBS2S0RIIP9IDmcyDbfNPpQeln7A7UVwk2+p2gry90zc3+Dtn3qY/8vMbidE4zLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vt09QWT6oLl+vAksHRkv5LqFbJrYJiJ9JRC+490OeY=;
 b=tXbb+X3ECc7qm4/VExr1YnhfQhoMnyNdTcWwcEOLMlv4bH7J2ohoteH9VCotFhBjDbEdvUT1hNVC6nPhAEmgIBVMRyDw7LWfbDUfVnzEr8apAWoxVqisXQ1p3RbRT3LccXBInqTv4ct/jrAPdFXa+k2yzlsClUOqDHEBkEzuHZylLusQa2AshIXO/n4dcNBgT6FypDJ7AxvbqXQUNMJJpj7x4RD4wgXhksDGbaEkYTa0Lb3rcml7keeF1ggaXU3nGpyNJDXU1VcvFoa/8T4aiTKO+dba5rFh44l6yshWgoD4sc+uYhGHR8d8+31R4mSbooIzPPwiPcPktYeGGPh5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB8077.namprd11.prod.outlook.com (2603:10b6:a03:527::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 16:09:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 16:09:09 +0000
Date: Mon, 12 Jan 2026 16:09:04 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <scott.k.mitch1@gmail.com>
CC: <dev@dpdk.org>, <mb@smartsharesystems.com>, <stephen@networkplumber.org>
Subject: Re: [PATCH v5] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Message-ID: <aWUcoGX-k12L55KP@bricha3-mobl1.ger.corp.intel.com>
References: <20260112154059.36879-1-scott.k.mitch1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260112154059.36879-1-scott.k.mitch1@gmail.com>
X-ClientProxiedBy: DU2PR04CA0324.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: cd59cab4-fae4-4355-8726-08de51f4eaee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZO123BGn4DiEQv4VFXaAMBAF9WlyXpX2zvHUVXkKwwojGOQgwAHvn1WJgp9f?=
 =?us-ascii?Q?Zitsle0bu9cluvsSFPEnIt5cxmmOn8Ap9PdzBJXi5cn2P4OgVdwtcewzW3EF?=
 =?us-ascii?Q?Nodj8DcO2iFBpr1Y81XWtPdvTizo/8vGd8tywRFTsuneC3mBZyEcfMduOWNx?=
 =?us-ascii?Q?XHscJmN6Ec6nwouIfBPHxa508UNpLyM8VktVyhtCEXMfjMQc77Dvd9xUhs6l?=
 =?us-ascii?Q?/gSyr8BozhmlN8Cjkm6wTZJ3XnRhw65/QyytrxJpIkE0PHnBBvlXhT5WOoyN?=
 =?us-ascii?Q?CMUK8OTttdZJQ0Rsr9tH0NiQveGoiqK7cL4ykOPPDP8ZbJa+zQSc2AWTbYk0?=
 =?us-ascii?Q?ub+kQC4SK62pHIuuIlHK9HmQMTmuZ6lAjptXTwwYVaD4GkF+WhsWBC3X8jW5?=
 =?us-ascii?Q?y0guZrNWKqIL+tvj99OnDc10dAkuMtUe3TB8/lFqNFRVmOGDuevKJmoI8IKO?=
 =?us-ascii?Q?IxZbsIgh9UG2xzibJn2n9Psb4pXpQcaclv8gZ4VF0TxSBGm3nzAklBba1g+r?=
 =?us-ascii?Q?FUmjfhiUbN2+WrDkDjOLozpRjo1YKn7lSaeL/O5tAkd9YIJFWHHedSrSQ6Wi?=
 =?us-ascii?Q?a1APon6nkdt4GU/2J11FWgOs9q2pNC8x2zCyRpgPwUX1u6DK7uY1SmGQy5jJ?=
 =?us-ascii?Q?emCMgJB7ns8y0Cs1V1UKyWORHY1UNQk3LWVuFoZbUQOL0VmR1qKsS41mvdOw?=
 =?us-ascii?Q?LAVss9Dco4UN4lajdLHizVsQu2So/wY2BApASM9/WMsBOYuGcKmL+i2RxmrR?=
 =?us-ascii?Q?HJriLZ+SMangOvr43obVAAiHR+GYhwVmKuPwTmS7oNsGi1QMica1TkoXAkB5?=
 =?us-ascii?Q?ITWm6lnwob1x1p80hNgiNrixmNAytkhY+jgW7dXvPYhTB6tBwatopLBoUZkd?=
 =?us-ascii?Q?OAMnLPTC0Kx0+FHGTydew5kOTfVLuq7fyWUDjs0mhggU3n0JJZ9WqNXrjIAD?=
 =?us-ascii?Q?rzqXBKEsibsQkxZP95a98xYTXP25kdpUrU54LMt7We7Pjh1XnfXY+JxlvF9D?=
 =?us-ascii?Q?xEx1VPcCCkZoMZJEDHs8xZS2WCRNY22DQRJmAt4ldFeigmmHtR5g+6jJKl7R?=
 =?us-ascii?Q?NpvVOgpqe5FrwvlUxGmKuYoMCWNq2Fy7Nba+z0dSyuQkdZBj3AQyo4e3VmEF?=
 =?us-ascii?Q?nA4/kkZwVzXmuTAQvE/Qdyo4Z5jakUxIoNZOfYy/SoBgUDg62xnTpQM7EiQW?=
 =?us-ascii?Q?PM8+4lTuLIfGlX3F26kMjgFE9rycIqqvWyqZCV7ZgV6DgIDsmpexKjeHKaWS?=
 =?us-ascii?Q?/1/3Yx0QFAqet0Cl0VABgRYLaZJhZKnR6uq8JEcEjcI8IDM3yd01sg+Y0204?=
 =?us-ascii?Q?j2QK/c6nZ2GBYxFHbQoylvLM5SY3zmK0R12JMDnn09haD4SFvJ9imQcuHApA?=
 =?us-ascii?Q?ksQBosFSSnP9Tvq4xxCFm/cu1gSUhtGMzz8EHnjVJg01yjKxid4zAs7IiRKk?=
 =?us-ascii?Q?5f0M3tPS40sdDOCjgi46ZmZ+QOifzeQd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OyzjCyfRXYS941/XoDLpaVzRGqotju9MqdlCC8lwtBbgCnYd+4XpWgaiHbLV?=
 =?us-ascii?Q?mun0vN/RUmvUESi4cROGPHT77O6z1YqUUEkYN+oPM/prdeE6ETWtDJNXqjE0?=
 =?us-ascii?Q?5FcM+3mISUHetLiO72QfOVjLmAVdrlBdF9PB76zoOoh4WakoxbQQntbKrX4E?=
 =?us-ascii?Q?1S4/EubkrQnb+brWu01sGt6C2qimhamgZ5f8Ym+BSOJPgS6nEIiCozmiOyzB?=
 =?us-ascii?Q?H8naslhWZR1p4Gwc7Ft82ef+ZjO8GvuOC/QJa+RzkgcKCVVv5adfCcTmArEg?=
 =?us-ascii?Q?zSjxkMiY7YjueiKfgHsqKQgU5dDB9eT8u2Ulb4bnRQpyGGEhV30ZeD/Rxslr?=
 =?us-ascii?Q?JXhJG6ETixK74QkEMKihm+bfl/c05DlcmSYKXdeXf251mBtelSHc5XoyWWHW?=
 =?us-ascii?Q?E7CMiKjcAEjnm3KZUxr4rkXLQUCQt0H8F1acLHSJn3g9SZPjCvZXAZTakozr?=
 =?us-ascii?Q?EWiB4ZzNVwG2FcPgXH1Mb+MzAqa4OpiAlCtWKvoa3L+i7zKjrKlNIqHylC5n?=
 =?us-ascii?Q?h/SFGGRXiqMXFGTLh+hnBtskGN2C1mrWpcY/VDSVDIKLqt7SGQnp838GbaMT?=
 =?us-ascii?Q?SZztlw/jrt1pjgPNHD6kbXNt4xQRVf76EbfEJZ6SY9dOJfU/C5YcfF5XexU6?=
 =?us-ascii?Q?n+JdVSjr4bNtXHMx04U2slX5nyOPD0o6qxU2f0snmcsiTjflrDvK4obTRZd2?=
 =?us-ascii?Q?eH1/eWrYLmo2UjImcC6DlhUgJlZ3t8GpbmhYn+Bsf9RPMPoSDfNsmi3F0Ns5?=
 =?us-ascii?Q?xEg7If7acO6iakjbwTMokFFPhNDcGjeKh3fk7wjFmmDtYbSrVhsr6bMlYOzs?=
 =?us-ascii?Q?cWZTjIE7jTeHN/wLnpHZfpR5B6+d1aQJuQzFpDPrlgJkaJW1cSczhaCQKERe?=
 =?us-ascii?Q?Y+T3OTkVscT6bTUO7DYbQ8j9oOc8oxWpEsGkC/H3xT69jrB7FYWksm6Rz8hS?=
 =?us-ascii?Q?fGT1bZNf/MnaAH/slN8dnUMtGh53l/vI1hp9aWVlPns8F0T061fmjzDbfRh7?=
 =?us-ascii?Q?CJOnha2cmSm4blxKIz6CRlxFIW/NOGnFMHKVhD1wIWsg78mAMPK/br8S5C6I?=
 =?us-ascii?Q?wvh/h0pKR+rxVTSAITkR7RsAdAfbykln4gO+Q+mUm71zIiDX8aa5wN1wJ7Bs?=
 =?us-ascii?Q?pOnM8ClyjvzPbmZ4dG3G2pDr6/KFXSj56s2M7HlQNZFnLkG9aysKXowuRchp?=
 =?us-ascii?Q?rcWw6abRGrXNuCqDcl1f8jxYgqvWNM/X1g+JFfbqOpFzD3JD4GCyl2AjlABk?=
 =?us-ascii?Q?M7H6xrQW6sLqc8mNIyIzPn877+FHCeG77WBhHDAdT1tU6G8IuKTxleU03SU6?=
 =?us-ascii?Q?eUylNdYQ1Fv2ImzL7tNYcDqtrK75Oj6adwiT9yezOdg+nNkL+rZkObHFmJ9w?=
 =?us-ascii?Q?ygR6stfsyk3moaST0D67CFcsqPTbDaI1BZN9/YorwzuSYytqOOvcEl9zLmEZ?=
 =?us-ascii?Q?/W+vXXeNQLq7ZS6WLkuQF2zvSCgl3ItTmF4JXtNIAYmYomU7qeLhDtxa6fQK?=
 =?us-ascii?Q?dKRLWuKyotG5x6zhzD/QOZ+y6iXnZwqBPRD5HpsVOe4pfP8virm0IkVWNcjB?=
 =?us-ascii?Q?gV6LDRJg2cQPB1lfM1Sex2HafOWLaGTYu8bQjAUmCggCM+ngCcT/kssqpasm?=
 =?us-ascii?Q?sNgxkBuVVo8n92q2fZ9oda0YUXs/Je5oCrxuxih6G30zXmqs5kRp6LuK8fT/?=
 =?us-ascii?Q?EeHHLSjjn6SgvuKgBWudQkSfnr/fNCUD49FmJE8dpjavvmvk99H7teXPjPg2?=
 =?us-ascii?Q?9y/SGGkZZ41QyKfbw2sZsbi4Ns0XsHY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd59cab4-fae4-4355-8726-08de51f4eaee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 16:09:09.2075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUFd+YKrVCHckxLbxyPyBngDbgI1ozNI25iBHEhlGvw5PvTuKFjekswn0wmAmaJkgIzOPHaO78n39na9kIROM4xOKwGV/NCCccWgz9pJKGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8077
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

On Mon, Jan 12, 2026 at 10:40:59AM -0500, scott.k.mitch1@gmail.com wrote:
> From: Scott Mitchell <scott.k.mitch1@gmail.com>
> 
> Modify RTE_PTR_ADD and RTE_PTR_SUB to use char* pointer arithmetic
> instead of uintptr_t casts. Benefits of this approach:
> - API compatibility: works for both integer and pointer inputs
> - Retains simple macros: no pragmas, no _Generic
> - Enables compiler optimizations: Clang now can unroll and vectorize
> pointer loops, and GCC still can apply these optimizations.
> 
> Example use case which benefits is __rte_raw_cksum. Performance
> results from cksum_perf_autotest on Intel Xeon (Cascade Lake,
> AVX-512) built with Clang 18.1 (TSC cycles/byte):
>   Block size    Before    After    Improvement
>          100      0.40     0.24        ~40%
>         1500      0.50     0.06        ~8x
>         9000      0.49     0.06        ~8x
> 
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
> ---


The macro implementation LGTM

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Couple of comments on the unit tests inline below. Most are only
suggestions, so feel free to ignore if you think they aren't worth
considering.

>  app/test/meson.build         |   1 +
>  app/test/test_ptr_add_sub.c  | 190 +++++++++++++++++++++++++++++++++++
>  lib/eal/include/rte_common.h |   4 +-
>  3 files changed, 193 insertions(+), 2 deletions(-)
>  create mode 100644 app/test/test_ptr_add_sub.c
> 
> diff --git a/app/test/meson.build b/app/test/meson.build
> index efec42a6bf..80a19d65ba 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -152,6 +152,7 @@ source_file_deps = {
>      'test_power_intel_uncore.c': ['power', 'power_intel_uncore'],
>      'test_power_kvm_vm.c': ['power', 'power_kvm_vm'],
>      'test_prefetch.c': [],
> +    'test_ptr_add_sub.c': [],
>      'test_ptr_compress.c': ['ptr_compress'],
>      'test_rand_perf.c': [],
>      'test_rawdev.c': ['rawdev', 'bus_vdev', 'raw_skeleton'],
> diff --git a/app/test/test_ptr_add_sub.c b/app/test/test_ptr_add_sub.c
> new file mode 100644
> index 0000000000..ef449ca9af
> --- /dev/null
> +++ b/app/test/test_ptr_add_sub.c
> @@ -0,0 +1,190 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Apple Inc.
> + */
> +
> +#include "test.h"
> +#include <stdint.h>
> +#include <stdbool.h>
> +
> +#include <rte_common.h>
> +
> +/* Test all C11 standard integer types */
> +static int
> +test_ptr_add_sub_integer_types(void)
> +{
> +	unsigned long long ull = 0x1000;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(ull, 100), 0x1064,
> +		"RTE_PTR_ADD failed for unsigned long long");

Given all the typecasting in the macros, I don't like the casting to
uintptr_t when checking the return values. Maybe use (void *) on the value
being compared-with instead.

A suggestion: can you maybe put at the top:

#define test_initval 0x1000
#define test_increment 100
#define test_retval ((void *)0x1064))

and use those everywhere rather than the hard-coded constants?

> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_SUB(ull, 100), 0x1000 - 100,
> +		"RTE_PTR_SUB failed for unsigned long long");
> +
> +	long long ll = 0x1000;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(ll, 100), 0x1064,
> +		"RTE_PTR_ADD failed for long long");
> +
> +	unsigned long ul = 0x1000;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(ul, 100), 0x1064,
> +		"RTE_PTR_ADD failed for unsigned long");
> +
> +	long l = 0x1000;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(l, 100), 0x1064,
> +		"RTE_PTR_ADD failed for long");
> +
> +	unsigned int ui = 0x1000;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(ui, 100), 0x1064,
> +		"RTE_PTR_ADD failed for unsigned int");
> +
> +	int i = 0x1000;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(i, 100), 0x1064,
> +		"RTE_PTR_ADD failed for int");
> +
> +	unsigned short us = 0x1000;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(us, 100), 0x1064,
> +		"RTE_PTR_ADD failed for unsigned short");
> +
> +	short s = 0x1000;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(s, 100), 0x1064,
> +		"RTE_PTR_ADD failed for short");
> +
> +	unsigned char uc = 100;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(uc, 50), 150,
> +		"RTE_PTR_ADD failed for unsigned char");
> +
> +	signed char sc = 100;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(sc, 50), 150,
> +		"RTE_PTR_ADD failed for signed char");
> +
> +	char c = 100;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(c, 50), 150,
> +		"RTE_PTR_ADD failed for char");
> +

Maybe define a new set of macros for small sized ints? Or else just use 100
and 50 generally, rather than 0x1064? The test should be just as good,
right?

> +	_Bool b = 1;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(b, 99), 100,
> +		"RTE_PTR_ADD failed for _Bool");
> +
> +	bool b2 = true;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(b2, 99), 100,
> +		"RTE_PTR_ADD failed for bool");
> +
> +	return 0;
> +}
> +
> +/* Test pointer types including const correctness */
> +static int
> +test_ptr_add_sub_pointer_types(void)
> +{
> +	char buffer[256];
> +	void *result;
> +
> +	/* Test void* and const void* */
> +	void *vp = buffer;
> +	result = RTE_PTR_ADD(vp, 100);
> +	TEST_ASSERT_EQUAL(result, (void *)(buffer + 100),
> +		"RTE_PTR_ADD failed for void*");
> +	result = RTE_PTR_SUB(vp, 50);
> +	TEST_ASSERT_EQUAL(result, (void *)(buffer - 50),
> +		"RTE_PTR_SUB failed for void*");
> +
> +	const void *cvp = buffer;
> +	result = RTE_PTR_ADD(cvp, 100);
> +	TEST_ASSERT_EQUAL(result, (void *)(buffer + 100),
> +		"RTE_PTR_ADD failed for const void*");
> +	result = RTE_PTR_SUB(cvp, 50);
> +	TEST_ASSERT_EQUAL(result, (void *)(buffer - 50),
> +		"RTE_PTR_SUB failed for const void*");
> +
> +	/* Test char* and const char* */
> +	char *cp = buffer;
> +	result = RTE_PTR_ADD(cp, 100);
> +	TEST_ASSERT_EQUAL(result, (void *)(buffer + 100),
> +		"RTE_PTR_ADD failed for char*");
> +	result = RTE_PTR_SUB(cp, 50);
> +	TEST_ASSERT_EQUAL(result, (void *)(buffer - 50),
> +		"RTE_PTR_SUB failed for char*");
> +
> +	const char *ccp = buffer;
> +	result = RTE_PTR_ADD(ccp, 100);
> +	TEST_ASSERT_EQUAL(result, (void *)(buffer + 100),
> +		"RTE_PTR_ADD failed for const char*");
> +	result = RTE_PTR_SUB(ccp, 50);
> +	TEST_ASSERT_EQUAL(result, (void *)(buffer - 50),
> +		"RTE_PTR_SUB failed for const char*");
> +
> +	/* Test uint32_t* and const uint32_t* */
> +	uint32_t *u32p = (uint32_t *)buffer;
> +	result = RTE_PTR_ADD(u32p, 100);
> +	TEST_ASSERT_EQUAL(result, (void *)(buffer + 100),
> +		"RTE_PTR_ADD failed for uint32_t*");
> +	result = RTE_PTR_SUB(u32p, 50);
> +	TEST_ASSERT_EQUAL(result, (void *)(buffer - 50),
> +		"RTE_PTR_SUB failed for uint32_t*");
> +
> +	const uint32_t *cu32p = (const uint32_t *)buffer;
> +	result = RTE_PTR_ADD(cu32p, 100);
> +	TEST_ASSERT_EQUAL(result, (void *)(buffer + 100),
> +		"RTE_PTR_ADD failed for const uint32_t*");
> +	result = RTE_PTR_SUB(cu32p, 50);
> +	TEST_ASSERT_EQUAL(result, (void *)(buffer - 50),
> +		"RTE_PTR_SUB failed for const uint32_t*");
> +
> +	/* Verify assigning to const pointer works (adding const is safe) */
> +	const void *result_const = RTE_PTR_ADD(cvp, 100);
> +	TEST_ASSERT_EQUAL(result_const, (const void *)(buffer + 100),
> +		"RTE_PTR_ADD failed when assigning to const void*");
> +
> +	return 0;
> +}
> +
> +/* Test that typedefs resolve to native types correctly */
> +static int
> +test_ptr_add_sub_typedefs(void)
> +{
> +	uint64_t u64 = 0x1000;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(u64, 100), 0x1064,
> +		"RTE_PTR_ADD failed for uint64_t");
> +
> +	uint32_t u32 = 0x1000;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(u32, 100), 0x1064,
> +		"RTE_PTR_ADD failed for uint32_t");
> +
> +	uint16_t u16 = 0x1000;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(u16, 100), 0x1064,
> +		"RTE_PTR_ADD failed for uint16_t");
> +
> +	uint8_t u8 = 100;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(u8, 50), 150,
> +		"RTE_PTR_ADD failed for uint8_t");
> +
> +	uintptr_t uptr = 0x1000;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(uptr, 100), 0x1064,
> +		"RTE_PTR_ADD failed for uintptr_t");
> +
> +	size_t sz = 0x1000;
> +	TEST_ASSERT_EQUAL((uintptr_t)RTE_PTR_ADD(sz, 100), 0x1064,
> +		"RTE_PTR_ADD failed for size_t");
> +
> +	return 0;
> +}
> +
> +/* Main test function that runs all subtests */
> +static int
> +test_ptr_add_sub(void)
> +{
> +	int ret;
> +
> +	ret = test_ptr_add_sub_integer_types();
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = test_ptr_add_sub_pointer_types();
> +	if (ret != 0)
> +		return ret;
> +
> +	ret = test_ptr_add_sub_typedefs();
> +	if (ret != 0)
> +		return ret;
> +
> +	return 0;
> +}

Very comprehensive set of tests, thanks.

> +
> +REGISTER_FAST_TEST(ptr_add_sub_autotest, true, true, test_ptr_add_sub);
> diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
> index 9e7d84f929..54289871d2 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -551,12 +551,12 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
>  /**
>   * add a byte-value offset to a pointer
>   */
> -#define RTE_PTR_ADD(ptr, x) ((void*)((uintptr_t)(ptr) + (x)))
> +#define RTE_PTR_ADD(ptr, x) ((void *)((char *)(uintptr_t)(ptr) + (x)))
>  
>  /**
>   * subtract a byte-value offset from a pointer
>   */
> -#define RTE_PTR_SUB(ptr, x) ((void *)((uintptr_t)(ptr) - (x)))
> +#define RTE_PTR_SUB(ptr, x) ((void *)((char *)(uintptr_t)(ptr) - (x)))
>
  
