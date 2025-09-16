Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83988CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 15:43:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCFA7402E3;
	Tue, 16 Sep 2025 17:43:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id B4D4440288
 for <dev@dpdk.org>; Tue, 16 Sep 2025 17:42:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758037380; x=1789573380;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jU5Dbj9Wen2+zI4d9agRcVWavWmrPY/ch0uNp+luALo=;
 b=G7cyv0qjVouIFS6pIj5j80jz87aGlFe/Rg84gtyfnBEfvMNYBOJVgS9J
 TjJKgPMbClkoRl1JzVps6ld8BlQThKEwIjCQeOBS8jeZfsuCE5iaPkdkH
 9XdYLj1T1zm4/mJzyVQ+b2YuBv7o+AP/W88soIIgL35AGOG2U+9256Ypc
 bCuMJpuh4ahRcJ2J+NdmCTbapVizVWUs7KrQAToMO/pafX6V9Qs9a1mjR
 7+3siw81walB6sWOkacMcFg1699WMUO+3KunMHRqWFQ4LzkSs/NdPj3P/
 Dk0tNN7Zf6K1rSoSMI1ZgKXyeQYt1fIXFJ4knNBF18+CJvd19ccMSZXCS Q==;
X-CSE-ConnectionGUID: yDlGBFl8Q42rXI0J6DW8IQ==
X-CSE-MsgGUID: TqD+3JiASmG0mEMlXh/Qbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="70945689"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="70945689"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 08:42:59 -0700
X-CSE-ConnectionGUID: hgEsrHTAQYGRKqUxxnAWPg==
X-CSE-MsgGUID: HsFb5L0iQqmHNF9e7Fyd2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="175388398"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 08:42:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 08:42:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 08:42:58 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 08:42:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ai53Bvob8ySaICE+RAeq2VDZkOP5YR1U409vnQubAj2Zjncxpf4iocOVA6vr+3RBvOra7L974AZApfWwwPndE1gvHq63Lx3+dagts1qETGf6SUEDdz+VVLaQmda7/XhevKRFq0dJImiZKQ+o2OhQjWDzMC3yfYXRqVQY/GeaBNJxigaxxXkVcTzpe/IloZXch82/87YVrxWzF+5jSw7rutiRi6zkb/IHiSLhjwEXJJEoalthNpBp1BvA714icdGBZXcp+kbmKVmO0LUHP7QmIPtxUqUuTxihF4pX7idBBoppbTaWg4P8dKbhm1afjy2giT/QcAMPiqq+y5mg+sNW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/FOntcSd+xv9emqOpBGZHQ875xGMhQJnHnjiM5UCUw=;
 b=iO7TTmZYPhGU78onAqg7dFK8B4SHqHcIbzwtbVQkb8IGRNHscelgzhWnjF+u4+eXO6apWIk/AM0WTrcnpsXiR/n4C1hx0lR3LUmTKdWK0O1EhrV+4HCC/nSUmGHJJY+xVFaVXTWBvhf4GOM3JvYYbbbL9kLUjzsQG2GfERZDCtj6TxQodhWpLe1ygch+PJCD6f5eiDRuF3ExO/Fwx2n+ZIajmU7Zb3SUfy0H92OxwFycyHxMahwdidmeBoB2PbGavmit6AG1F6IquKw3EGhQrRjWfRkiEiY6WkvltTujpdIvnkkSEArGq56Iqa33GsUDcYeabi1z6+slzVU1jg5xYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPFAC6BA7F25.namprd11.prod.outlook.com (2603:10b6:518:1::d42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 15:42:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 15:42:55 +0000
Date: Tue, 16 Sep 2025 16:42:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
CC: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, <dev@dpdk.org>, Ola Liljedahl
 <ola.liljedahl@arm.com>, Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: Re: [PATCH 1/1] ring: safe partial ordering for head/tail update
Message-ID: <aMmFeXsHI9VRn3GY@bricha3-mobl1.ger.corp.intel.com>
References: <20250915185451.533039-1-wathsala.vithanage@arm.com>
 <20250915185451.533039-2-wathsala.vithanage@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250915185451.533039-2-wathsala.vithanage@arm.com>
X-ClientProxiedBy: DU7P251CA0017.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPFAC6BA7F25:EE_
X-MS-Office365-Filtering-Correlation-Id: 378970ca-91a1-4341-ab77-08ddf537b42e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4vojAFJYYWEKPrRlCVvA8Bfzop6Q7rjk120AT6yVDYQC8LCmGi0HGt+grgAE?=
 =?us-ascii?Q?stGctIANLVytB7XUoPinP7HVB0mzKJHkcWozXkh2R2T0UF1KqFqgy+C35vGR?=
 =?us-ascii?Q?G38k/IeqjKly+mpuk0vTvLVsnW3e+M9jBXKTGqzpJYtiiimVPLzMoS3ww/74?=
 =?us-ascii?Q?fw+d8s10JdkaA1crTLsFbReybzWd5qpxfiYvvfre7LAw7ZlnjuDJdsAfe1ya?=
 =?us-ascii?Q?YgIWlOzNOT14UnyaqKL02oqLLatHExkS+FWgb4VSkawjr1B+nAaRqxW4YBd5?=
 =?us-ascii?Q?J3aToI/PAbq5kb37ARhZT+fPMz3EUrZaq5dE88o2x25RADuJulLEJQipa+5Q?=
 =?us-ascii?Q?sPi43dlpZ2D5FlBPR/s1SLjRWFFUmG2QuHFUaU8niSFtB34SFkhgx4hEPfas?=
 =?us-ascii?Q?n/jeo5owdQKvcSIEkFkFfhIyrCBDIAJ8YbpsrsFEIZV99jxjz1txzNFyzxNQ?=
 =?us-ascii?Q?HJT4E2p8N5zhqMX2dL2kUvShRa7GMWhfINQvY9Nl5LzxMeCthfi4UiSJ/SmG?=
 =?us-ascii?Q?uxMjeMLBIIWg8azqcZDzL4ow8HVq0haS0yu3efFL+UenMwR4xM8FvGU1beGj?=
 =?us-ascii?Q?13Qo/OPkUn3xbfQn63yZbA9EJ4s7yZzALx4KEWfoQl2wCmJn/u2QevfKzVe3?=
 =?us-ascii?Q?p+sKQmSxZ2DPujS0wmI2US/WbHYtuHxwJ2jXJZDJ9gnlxrWZl1sXyBFTs0CA?=
 =?us-ascii?Q?UdQDpUzkZSPxRQ+1xThzjRgX1thf8QJ3Pq63OWGv9fH6c0IKgbADnwEFLVJP?=
 =?us-ascii?Q?xxo3g61l+43Jpg4XxR8p5z/402SEOEXd/cNGcwzmSfY6D4zcxbPxgdgCtlKI?=
 =?us-ascii?Q?Ca3YCGaVq0EFQ+exvctZQhXY8FPbC2MJu+/2fQJWG/XJ/kTkUrwKdnWenpI7?=
 =?us-ascii?Q?cqxOu2rMZbXShZS0/l5pb9ouYUgvV2rWmFqXXnZi2C0z/XpKPL1Z15eoenOO?=
 =?us-ascii?Q?4In3/N2qA6DzcR+OsiTIYHbBmoWHIuMsjsg73gdXBgz811keEMY0HWZXyL+s?=
 =?us-ascii?Q?wYKNjVdpehJXFrXJ/uq9wMLo7Wa6KPOt9IpbOQlInW2UoWtkgfDSiFW2yoJx?=
 =?us-ascii?Q?vEs7osZ541XyH6zr8PL1LZU44AetMqbvEQflMd5STo+uMS9yjbsAMWFC7i72?=
 =?us-ascii?Q?hYrgkSptLokEvi0SNOSlIN1yaD0pyBYnvxxWMHraeODNeLLBUtt+KvcCN4yR?=
 =?us-ascii?Q?TlvT61Tnc+Yf1K1EVrPZBoMXF/N2j0ZMpc3N3cX622NRWz//LFLMIpqPxUP1?=
 =?us-ascii?Q?lvpmApiEz0g1l+Fa79a5eVEBJAamUIYFhQcQpn9GYh9jRBM/rpDQOSiY8iL+?=
 =?us-ascii?Q?44gfdeuf1vJD2t0m6iWBuXAoxRTmCj55SxR3S9M/1Zx1/VRTtevP02pvY2G8?=
 =?us-ascii?Q?Yhf0nneVg3XfZoeTqpTfTzYVEwVbRJ7f/g701uFkWRjUIT+pGkz+GNDxlnAZ?=
 =?us-ascii?Q?pY5dFGsm1Dk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YTwv5dyhbMBH/otQS0f2tHYKT4GE4DIiO1evVsV7bjkkjrPuOlKqVyzEqwmo?=
 =?us-ascii?Q?y+0RTHQcZujTlouOeFJ2wJ0y2VrrEmanW06nNzJnnbIhMn6+66h8t8TH8fA5?=
 =?us-ascii?Q?GmD2RlwgZL5SporGF+kDeao6mI3frlqRauZdrKcbSinF52vhUqGjeppDpOX4?=
 =?us-ascii?Q?+N4K5hPYbuftmdAgPftOQyChc/JpcBc/O6PMP38/6touOgJvCgSxTVtxnlpc?=
 =?us-ascii?Q?QaszdgTDFCBfHmSzaEOjv8c97HtN80lOrbAyhc/Co0lQf9ZCzwgt313Pn+OJ?=
 =?us-ascii?Q?9gG/75DlyVMByw9ySpeL0LWFRJ+cHI6f4Eserk7I6sTcuGqSGxCvjLSFOHGX?=
 =?us-ascii?Q?IV7Ul+jaHKuvE7/z1ZRhkug+heJrqpQOWmCOxc5Gqt8oAFi4lmHZJPEEqWNW?=
 =?us-ascii?Q?mcoi9F9DmK3wkpnUAexUz/syiaXqEO1xi/3pL3MCR270/bxFbn85el6NCvUs?=
 =?us-ascii?Q?fkNztvMADq0oH7Rad64ZoHZdK4OFfv7JsRVOHaqtH+9Z+iGZw1EMs1gCvxw3?=
 =?us-ascii?Q?sGCdgQvWpSwhPNHwLQ4B12NOjrbYWqkPC5EuXwBRH1jGxQ7A18rJnumgbtlb?=
 =?us-ascii?Q?sn6urSBLWlLLja8D+B2IVunkFgDuiV+WPUtQuy3h2UO9m4HIXVTwHVHLDEye?=
 =?us-ascii?Q?Hq4zn0HtvSP7Xj9JQElgyY46NadXYgi9C26CvR7wH1XMzbhzIsuVjkVSpXIA?=
 =?us-ascii?Q?qbS3RK13kf/a7TwbWVJKLTE9eWQJd77Nw9wE4Btv5qVmYahqOgXv5T4ElxHb?=
 =?us-ascii?Q?7LhQ4Vh64nwFycY1wt7kzS/bqAMpJrCMa5rf4RE7ynNAvVWWi3uuW7NLFVNg?=
 =?us-ascii?Q?iVaKoE62juWQm189OUB7sospamchz1h+ZEl/34xwrHB1DpYjX+YcpybX9zqZ?=
 =?us-ascii?Q?vV5NxEKzE5ubC5Fmv2XB+3v51NPo/2t9M2U4BCG1UsKU4/V8xVqUZC8ObiIX?=
 =?us-ascii?Q?Fyeo84YzwLf75UjyjPeMajEW672Z5FkuwgL+rcYp0mJbRO5qrL5KtOnnTwRL?=
 =?us-ascii?Q?1O8Tp6+mzVOt3IAMBU1yUvcY2ylR+cBmoqMf16FFtOw4MlXwDhMiVyhT0yOU?=
 =?us-ascii?Q?6sz+ECYL9cMwLFffAz7ekCzVmmfSaM1FFeZu5RflbpldG3HwOUrjnwa/80Wm?=
 =?us-ascii?Q?NXpINu1c09zXSHVquaWpDIxtpSTD6pBwdqNy/11O8IuaRXOkr+jl8HoiedjZ?=
 =?us-ascii?Q?1JMvHc9YomzUiAwOeQYEtW/9hlvKaFsyXxAc3qfeiejieJESDRBwDwj1UyKZ?=
 =?us-ascii?Q?Zisn14jQd0vaMVMv/PtYrmWSNz2MwTRBYtLxTrPUf4Njkbz9pkDCwz/vOcBu?=
 =?us-ascii?Q?woxIvhm2Ju6GBF0cIvmrNz0B2u5onal7JrO9zux8Ye/qmXFRacfFRsKnWFlx?=
 =?us-ascii?Q?rnr162J86JI/w1oWlUZ50GuDnbj7VJtiTYeaYeFDzOiauGofv5nW+i52SSo6?=
 =?us-ascii?Q?3qToik8+MJcKM1yfGu1pWgyX/Kw83ZkxyM/GA1WmMfEsOi5NIhJTTg5vNPzv?=
 =?us-ascii?Q?hTNRt9e1ffuTPZbQ+eeu5pIpU949W7URM+VVhz3jtD53u3biwjJTRKVJzMki?=
 =?us-ascii?Q?3tZi6sGEquDncZNnNaJKe1S/iMLmOb271GdzzkPyqUUko8A2L55SyQKzyMul?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 378970ca-91a1-4341-ab77-08ddf537b42e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:42:55.4078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8ioAUh9fuvlDGOMyaHOz8bZPiqqicj8/C3ONjAQNy9eYJIgW1Duo+JXioVIdf9DLSI08P/jcnGNRQwMPf8kxX1FCqPz8Ph+sDpJOslQCr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAC6BA7F25
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

On Mon, Sep 15, 2025 at 06:54:50PM +0000, Wathsala Vithanage wrote:
> The function __rte_ring_headtail_move_head() assumes that the barrier
> (fence) between the load of the head and the load-acquire of the
> opposing tail guarantees the following: if a first thread reads tail
> and then writes head and a second thread reads the new value of head
> and then reads tail, then it should observe the same (or a later)
> value of tail.
> 
> This assumption is incorrect under the C11 memory model. If the barrier
> (fence) is intended to establish a total ordering of ring operations,
> it fails to do so. Instead, the current implementation only enforces a
> partial ordering, which can lead to unsafe interleavings. In particular,
> some partial orders can cause underflows in free slot or available
> element computations, potentially resulting in data corruption.
> 
> The issue manifests when a CPU first acts as a producer and later as a
> consumer. In this scenario, the barrier assumption may fail when another
> core takes the consumer role. A Herd7 litmus test in C11 can demonstrate
> this violation. The problem has not been widely observed so far because:
>   (a) on strong memory models (e.g., x86-64) the assumption holds, and
>   (b) on relaxed models with RCsc semantics the ordering is still strong
>       enough to prevent hazards.
> The problem becomes visible only on weaker models, when load-acquire is
> implemented with RCpc semantics (e.g. some AArch64 CPUs which support
> the LDAPR and LDAPUR instructions).
> 
> Three possible solutions exist:
>   1. Strengthen ordering by upgrading release/acquire semantics to
>      sequential consistency. This requires using seq-cst for stores,
>      loads, and CAS operations. However, this approach introduces a
>      significant performance penalty on relaxed-memory architectures.
> 
>   2. Establish a safe partial order by enforcing a pair-wise
>      happens-before relationship between thread of same role by changing
>      the CAS and the preceding load of the head by converting them to
>      release and acquire respectively. This approach makes the original
>      barrier assumption unnecessary and allows its removal.
> 
>   3. Retain partial ordering but ensure only safe partial orders are
>      committed. This can be done by detecting underflow conditions
>      (producer < consumer) and quashing the update in such cases.
>      This approach makes the original barrier assumption unnecessary
>      and allows its removal.
> 
> This patch implements solution (3) for performance reasons.
> 
> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Signed-off-by: Ola Liljedahl <ola.liljedahl@arm.com>
> Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
> Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
> ---
>  lib/ring/rte_ring_c11_pvt.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
Thank you for the very comprehensive write-up in the article about this.
It was very educational.

On the patch, are we sure that option #3 is safe to take as an approach? It
seems wrong to me to deliberately leave ordering issues in the code and
just try and fix them up later. Would there be a noticable performance
difference for real-world apps if we took option #2, and actually used
correct ordering semantics? I realise the perf data in the blog post about
this shows it being slower, but for enqueues and dequeues of bursts, of
e.g. 8, rather than just 1, is there a very big delta?

Regards,
/Bruce
