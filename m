Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98C9CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 09:35:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AF30427A8;
	Mon, 17 Nov 2025 10:35:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id E6EC14026F;
 Mon, 17 Nov 2025 10:35:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763372115; x=1794908115;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=p6mLZjl1BqviDtF5ivYZkfiFR6jH8MFbxfmeKoialQA=;
 b=g6b+7FEP8e8oiiSOiVy1hLAIsBVJikMWf0hvJ3gRaVTYk0AHFV/R5Ops
 mGtUs8aWeGk/yNX170QNcU7Rh2yE1BVg7IdEo4qvwBrmAlngd+nEh5sTZ
 xe4BlvfXCyJHIkXlDT+NocmBhhA2UPYvWItr1x44rmiR5VoudHZI3RCr1
 B8zRefq4d+oop3Eh7TyKYzqI15+koqAY3T7X23/mFWxMGsdAmdWM/ffaY
 Z/Yvx8ulOzyZJhV90qR81pp6bYvRp206Du6dl54Mnp7vRllTirhEr+/1s
 PzyLrRdRxRM2DZdcWlzunAm5k6T7H2K9YQM6c7QCIQORn9ePnRjGi6Be0 Q==;
X-CSE-ConnectionGUID: q1YgsSJMQIGOuwg7Fur6XA==
X-CSE-MsgGUID: xwoQJd0mR0OLkIC6x9uRVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="65399375"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="65399375"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:35:14 -0800
X-CSE-ConnectionGUID: 3YEthGh3QEuatG+axOM99w==
X-CSE-MsgGUID: phQHJy8JRRuhLVkyZBxTIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="191188934"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:35:14 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 01:35:13 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 01:35:13 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 01:35:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrHPIgS1iGA+pHROoH+y/bIKWMc0i38pHFrKzCzYz+3EW3XFfQx4PqTmz+5Y3paVuvmn8Trk9yPUrJDNTVS/7CzmivLxNlCHjVQmZeJcwll2sTICI7rG/YvZtb0Q1+UdAhHtEkmWSFgXWsW+LDYG3U7Rkw4n7Aa9pr0F6Xgu7LvBInHA2CBp1ZZUGWAP5bAJ1t0uCV4deuY4RHip5IpDEcPU2X2Daoski2Rn3H7RcyjuNuBvgf8nxnvu7zw5upo9qC3ncrVQVixCQYowEPbPrMoPPofeX04ULb15SlMmiosZS05C7ffcHA52pdd078gJGuMeaIq476O0eHXnCrj0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DlX+AMqDBJ6Q3MUs0tX8ogptExDPA021RjO/9E+6sU=;
 b=L/HYDIziSDXvT/N1uyCkoFcDVRxR0CohbZGPOOJjErQNhTUCB+/PAnfEcyriaE6LmIgF/lPWYycVOg0Jy7Q1R12HVMdE998419zhgvS2a5YqkMypqs8pMLSJujPjlSMVr7jcYD4sDtLUc+7A+Q2o14Y7DDp5y9FAyf1iSsk0hVHlvvw6OBzHdmx6V89t8ms8aWWKbApZWGcjEVPAJWKliBVyqG2z00dMdr1nbfEaisZ2kHCZF5psxjv/8Kfyp/3DZxjZY0j0JNStWjOM+4lWQHA7FPTiNz+cM6Nl65bm808A34zkRbGqSfXFINFjmMOQUl2xjHrhIkJAw0HOuNerdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7520.namprd11.prod.outlook.com (2603:10b6:a03:4c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 09:35:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 09:35:08 +0000
Date: Mon, 17 Nov 2025 09:35:03 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Shetty, Praveen" <praveen.shetty@intel.com>
CC: "Loftus, Ciara" <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/idpf: fix missing offload from conversion function
Message-ID: <aRrsRwRnqgumg37T@bricha3-mobl1.ger.corp.intel.com>
References: <20251113145021.3793930-1-ciara.loftus@intel.com>
 <DM3PPF291EF9BF16AE2EB6DB4623D607D049DC9A@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF291EF9BF16AE2EB6DB4623D607D049DC9A@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0315.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb8cccf-95fe-4648-cef6-08de25bc9897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f545DqgMinwsZQWY71a/33vmvkOCLE+bo5o+DHe43xmN0aKMfe0YoILtQY+w?=
 =?us-ascii?Q?BLtKXH1N+U73qsfEdJ7c7g1+ubEvZ3vMjU60Prcp5bM2YBw908u2YLDzJ/i0?=
 =?us-ascii?Q?wfUjTDMzve9VhwzBvZhrmFfYZspXHJ43QKQrvhZ+/gEgwb+TLHuYSFUYdWBP?=
 =?us-ascii?Q?ZbM+MmoFDQy1BZr1boA62r6odAddhpDHFhVjlMFZkRJmuZctzKuUTJ6xOgyI?=
 =?us-ascii?Q?UBvJSesIsAya+U3HFaeCwqRGK4ehfGeCVDxhJTddSMzqsC8ndRCYyHql2TxT?=
 =?us-ascii?Q?PT71CeE6zsCUKse26jcnGDqgx8Gg6aG9ohHOylE+7l2ta1ti+ejkm62MmdpY?=
 =?us-ascii?Q?8XaWBPNckN0sDYYqbX314uS3sVaG2uVlcdbDhhbZ8EkR9txTn8IGAmqVDka8?=
 =?us-ascii?Q?kC0sSydztMNetJufjRXYf6jNgyzZkXcIb7NNy0qb2+zASYIFhA2CC+kpZ8yA?=
 =?us-ascii?Q?/QdD9GgfkJ6Qcee4zeFizvfi3Q706gX15eBHF2b3IXKmGVuliCh2ZUcipu3s?=
 =?us-ascii?Q?tq6E8ylLiY1Vmcx+iFgGreyxUCH9FwGUTJ8dGNrahkoHoq4NMvQKaDvW/vy6?=
 =?us-ascii?Q?cgrcIDyH9aQOkFMnLpA+rMVR+atpuTlmQtGvLRhS+ZWrPgb6+nUur0G8fIs/?=
 =?us-ascii?Q?AuK84MJMRZMh2v1B7Ko5Dd2zwxjFENshZeMGGLWWK1ypOKJ37cSKXyy1hkcC?=
 =?us-ascii?Q?EvlgBB7OeijjgKIodIw9fe2AoKQxEDTseJj3tD1YO5PDYE8zA0UL2iU3C20o?=
 =?us-ascii?Q?J/+HY95gep/lu/3TC1mU4O+NYGJs8HUc1GV+9ceNq8IcayYV8OorsDRUzDMY?=
 =?us-ascii?Q?WTAzCVGK6Rxh9FmJCKD5jEYtFcL9leq08I4kKAVkKxYsr2q2KXTLbryc/yrx?=
 =?us-ascii?Q?0DZ1eQYLz7e8K7t3cpAgI9GderYLKCMckRiAnaSeQgqNtfLLbiLxdiSrDeLK?=
 =?us-ascii?Q?9LK42yXLZQCPgLHNH9UC5QqSf0yCJF0xqf8c5WmmiWhJE48MBzRLhuvwMu2u?=
 =?us-ascii?Q?InCUwJcbISz9me3pEt3iNC5gbP88P/Bux94SsDXQGBNJOXsWUOmZEOK1MiDT?=
 =?us-ascii?Q?eK8GqUwMMkWtEkP/kXgOgD4OPbtJZvcvN2qFYAlXpQfJZjcXf3YQBgILwjUj?=
 =?us-ascii?Q?0T1tz3R8JdZHbPuVeDWttoD+X4qiWHFi61zTahvlL5Dk+pxP/NuQbKdx81Hb?=
 =?us-ascii?Q?9qS8FIp1d8jrFhEyXDXOwapKgtIOXjGZ32FlNumyHbTVMWrJ0DriwBZo7G2w?=
 =?us-ascii?Q?Xnhp8Dbt71M26a3/cVtDN/7v5aEKEOutBo1xVJFUl++4ml00ZmyY4iu6lwOZ?=
 =?us-ascii?Q?WUkiOIYzYtN0h28D0oA22nraPMgd5lS+kfReM6dSakhgiRgT2X5zIJM2oEpQ?=
 =?us-ascii?Q?29j/JtGjmTt/4/mau9CDEXzTEpKFwWDC3yFgu4X3EuM8qG+yCPhDkZnRRrdk?=
 =?us-ascii?Q?gIyXTRgJJNeH+AG602Zv1bKvM9xflbSw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sSSAWQhnkpk9/WsnItWYYhCruM0P5q33SlA7UlumjlIrl7Tlnn2hEinsE38P?=
 =?us-ascii?Q?X9j75rI3ze2ZA6AZYm0Tf2IHOdCjoUNFINi7UKljMelQ8GCYMhWiyK9Ri30l?=
 =?us-ascii?Q?Hw5Il4HcHUO2SM8fX8a08Qw8L155/JBCTEI5VzxgL9TgXYXHEFqaE3qMPleg?=
 =?us-ascii?Q?OFMD0wZTkGtPvQQ4UlkygFNT2fIXUeKn+k1UWEbdnBA2/ZuY1VC8F/DGDT6z?=
 =?us-ascii?Q?sa5ONmAzRM5KGYnpz1xcdappLPTT4E+wuVfuDm0hfKpLqqasxJnhYil8e1R9?=
 =?us-ascii?Q?gO0kfVusENhbzQVRI2/INN/pxvCQXAGXW9wjSHNerZ/HsMzAPWchls3+lO2G?=
 =?us-ascii?Q?fcOVfCjfHXRoMfUI8+6sn6jEeEHppncUfUXkiQFPks3MG48eexIFc0NxJjgr?=
 =?us-ascii?Q?8QaS9+6h7iLA+O7DkkfBYrJg9BQx6QVT9JbILhZZuyPC/JIqwjZG8KZy5O8e?=
 =?us-ascii?Q?9EO0JspcpcbiC1fo4nOsNMyaJdl17t2e7aKBUhuxYVHtUW2BfpUwcsTG5H7B?=
 =?us-ascii?Q?MzgShb4+n2WJJU/J7a/mYRc9KeRF//sjJ7ZGiPgdN+/CmpKEFmZneUQl/0nY?=
 =?us-ascii?Q?aEN9P1nwOXQcjKDBEK72jm88P5XIsS/uG6tolp9pirSgMslH/MpuvS9hnpOD?=
 =?us-ascii?Q?YqFolSBMUoMEQQ1xKPsMxPCtHba/f3U8/gzrvUHwsefSl3LpOHhPRgwyltxA?=
 =?us-ascii?Q?M0J9/rRT6IpGV3kbfRl+sHWDp6NQrRHDO+08duuFDgnLK79e8+KaQ5rne/F1?=
 =?us-ascii?Q?cZH64Tvun1bjPNlz+EyLtMR89fpgh8ZgJJopCUldKjFxR/FxxZ7b3f+P+PYQ?=
 =?us-ascii?Q?smi7UG6yYopq3qIFYCOhXvLchjil8zaqMnFNEpRgJUP23u1uvT4UD+7dQ7Qa?=
 =?us-ascii?Q?veVhP/fASzEFI56nnOa9/n1zkPRu5j6C+ncgi0TCFMRB5PhC9SAc1wrU/z03?=
 =?us-ascii?Q?FAnqXAyAtf9uyOt2swn4s2xA+7s0LHZuR+GTEUECS2YTSDB7vAK/ohEtnk2R?=
 =?us-ascii?Q?5DfuanXa+C08eW8+Tqy0xyyJjlL5/hIPqqRlAtdRX3i/UEgSyMPHBOci6m8B?=
 =?us-ascii?Q?u7xsvERQDN5aLF+K5vysmIpsoNhidksv7Rs0tt06ZkjGVFEfl3UiOCar9qmp?=
 =?us-ascii?Q?gO68Js+9xn/W0q5ChBKOg10ynXLRvDgIkaZikvq6AooowAbR8pyb2ssyX5yO?=
 =?us-ascii?Q?go6UfMpU7Ik9DmfMPJ4jJXqZeYH1xnvW27iPI1coDjbMrYQaXWtdarIMWwAG?=
 =?us-ascii?Q?odee1bbf4MXKM+P1KaYgGOs7sBoWrElGQpjyUyIzvKHnWpBcCraDseXUVcIP?=
 =?us-ascii?Q?6hU+CVdRKA/q3xvo2P6uf1TBXWVs/z4yc8PIMWizDCc0xPE40rJkSgCDWJu8?=
 =?us-ascii?Q?O1udVVLwWOXzL5/CXHlWqOzBxy6HieX76ABILhUoO4s7TMs3A4DK5bloh3Rl?=
 =?us-ascii?Q?iKyj81DJe6hRI8FbSMo95HTFkwy1DQ3FMufbt1EjzgboQA2Gd/1ICCq0beX1?=
 =?us-ascii?Q?jh01DawCso9+UfwonKskngstyxUHHWEMRCgH1Bj9lgc0BBNXz10P4n+RS3X+?=
 =?us-ascii?Q?jvqBMQ9K/9MoXoL5v++fGNi8sCRhXVILw8jEgNfRTzMCm1KNGGnsYYZFSA18?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb8cccf-95fe-4648-cef6-08de25bc9897
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:35:07.9937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/I45e+xPNuhkBc7tAfWFtiK2ZeJg8uLIMX/LKHP+X1/SgHLeyyPq2uhGHUsz9iXh1cjUFkeH31VjXTgfY45Fgfe67uWUgD8ONqa44a7u7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7520
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

On Mon, Nov 17, 2025 at 06:46:44AM +0000, Shetty, Praveen wrote:
> The TCP_TSO tx offload was missing from the conversion function. This was
> effectively taking the request for that offload out of consideration when
> selecting the tx function. As a result a vector path which does not
> support TSO could be chosen when that offload was requested, when instead
> the scalar path should be chosen which does support that offload. Fix
> this by adding the TSO offload to the conversion function.
> 
> Fixes: c008a5e740bd ("common/idpf: add queue setup/release") Cc:
> stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com> ---
> drivers/net/intel/idpf/idpf_rxtx.c | 2 ++ 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/intel/idpf/idpf_rxtx.c
> b/drivers/net/intel/idpf/idpf_rxtx.c index 1c725065df..4796d8b862 100644
> --- a/drivers/net/intel/idpf/idpf_rxtx.c +++
> b/drivers/net/intel/idpf/idpf_rxtx.c @@ -42,6 +42,8 @@
> idpf_tx_offload_convert(uint64_t offload) ol |=
> IDPF_TX_OFFLOAD_TCP_CKSUM; if ((offload & RTE_ETH_TX_OFFLOAD_SCTP_CKSUM)
> != 0) ol |= IDPF_TX_OFFLOAD_SCTP_CKSUM; +	if ((offload &
> RTE_ETH_TX_OFFLOAD_TCP_TSO) != 0) +		ol |=
> IDPF_TX_OFFLOAD_TCP_TSO; if ((offload & RTE_ETH_TX_OFFLOAD_MULTI_SEGS) !=
> 0) ol |= IDPF_TX_OFFLOAD_MULTI_SEGS; if ((offload &
> RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) != 0) --
> 
> Looks good to me, Acked-by: Praveen Shetty <praveen.shetty@intel.com>
>

Applied to dpdk-next-net-intel

/Bruce 
