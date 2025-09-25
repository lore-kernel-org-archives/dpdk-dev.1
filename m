Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD63CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 16:38:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECDC940663;
	Thu, 25 Sep 2025 18:38:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 34D104065E
 for <dev@dpdk.org>; Thu, 25 Sep 2025 18:38:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758818310; x=1790354310;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BckjuKFtNNuOdTgu92uxHhA2hRd0vlrjFLm/eAaMKrk=;
 b=HZHZumUX47RMZq9tXOiNBMdKN1F+robu1KuK4PA1Vvj+S7oMldTuJVKD
 JLU8cAQ6Awc1HQTCTyuLUqmi0fwmrtsXwYlwFTxHKxud0BY15I7x6Hr6y
 LH6MhaExZagEgjhICoOc5DAZgqwukj96EtIj19m0JWliZ9ksuy2Dx4+Mm
 Eq2hq6GPF1zi7hAfs1kgYFVifASetS0CEmZ46SeSlnsM1DGwP1576t2DX
 n80dikaiwsX8adCSGA9ulSuWvwRTkpp1vw7ai6zOgo0bv0Dfc5/nyu2mv
 GdhEU+pFN+9rsQ9pywpWt+KIWFjEkLc1XRtRIHOhXocSEqDhT39iUVT3u Q==;
X-CSE-ConnectionGUID: ph47KYTRQJSH7Pq91PLWIA==
X-CSE-MsgGUID: wvBFnL60RNKSkWR0jBTUvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="72574585"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="72574585"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 09:38:28 -0700
X-CSE-ConnectionGUID: j82tgAIHTJGTmHEYvD4GxQ==
X-CSE-MsgGUID: p2grv2WXQGiWbP7bbQIteg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="178134231"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 09:38:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 09:38:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 09:38:26 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 09:38:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LthPQs4xklGZ03gzttgKVF5i0HNx2pk5QBl1EUQnCYWEUnRB4aSEAapMz8J8XvN8r/ABNy4Rtrc4oe1HqAC1Yv0RfWKVrKEy7dEWxeWEs3AOFlGwTnyTjYpz9UfB+ScO8PErweQNTUkx/aURl7FhsWrF62Bgumj0ttnhGQL338pvDEIz26SI/Dt2vexYqGXxVN45Vs7M5RuePR+gXNmXmUG2vhg+Qrmc0zTGtN4V2nVOXO5esCFg/Jg7bjniDBEIWShfst+CBWkQzHf5XPTRgMEw6D21gisrcjs2rdBQFkEsH5wWQLQHI42gRwLBLLZphM95TWGME/dOg5ShMN6fCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXevVqnbtXhdwO/EO+D6Gmme1dl/g7DyF14kJKGU7/w=;
 b=OJUzRaAK5WfWHlkSNivkfGAftk8jAU33DN0X1srpyItbShTVsr48yZ/e4bd2pQx80zoLIY5Vqa9xWXaMgdtxqFUjeAYy3v27woOcmgN2BDXzz8ShCSB4osoTmAnjiKclnhu5q9RjzY5s5r6l4RCpxuvVULZ6kp38QWaZAYqxh4Od8k2pAbBNkimeFsod0wG4A+sQdArQC8DspRKAFeaaj2PUcrLO+FPzeKdMl3zdqoz5XiV1cM71Y75KSynl6fdg/aaIMqtI6FVKyi8pwT67Nera5CNoXvF+ukG+HXtbtm334bDqFOU6JzObGd8kES606kFVXhsm4mQg9f/K9MddaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by MN6PR11MB8217.namprd11.prod.outlook.com (2603:10b6:208:47d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 16:38:19 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 16:38:19 +0000
Date: Thu, 25 Sep 2025 17:38:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v2 1/2] net/idpf: enable AVX2 for split queue Rx
Message-ID: <aNVv9vIu9JMKNidj@bricha3-mobl1.ger.corp.intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com/>
 <20250925092020.1640175-1-shaiq.wani@intel.com>
 <20250925092020.1640175-2-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250925092020.1640175-2-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2PR04CA0181.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::6) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|MN6PR11MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: a7396778-7643-487c-0666-08ddfc51eef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TB6AbfPUM4DUzbxmUcd5AIKGVPRsssN0doMuTAAakF5f/bPB7P51XE23lPrY?=
 =?us-ascii?Q?GAVdmd12iL/v1SPGhN/VwA7eY06rqOQhTJbt1CeF7L/AJODFQRy5oswfJ4+E?=
 =?us-ascii?Q?0de5OBsuhHbbSGy3cNBCT75lW8n4H2hLzJ8QZX5EtgJeOjIHZHGKleIhaAvb?=
 =?us-ascii?Q?drU8tq8TFEV7Ml1wlbB7O6u6pEkBFuMdBo2rdb7vWfzu0XEtzJuYgmupuAAy?=
 =?us-ascii?Q?KdpgAR5nHMWNddRYsR8lPgTDTC3ZLYOpSp5NVCjOHeZptRG/wua8i+cq4MUc?=
 =?us-ascii?Q?0B+x7RJtjKQMw+eyZGDSmddU/clbW9z/jzuCUkSi+pHHHvm38egzE6AFHrgS?=
 =?us-ascii?Q?Ad0Zu0f1Wuqoii8eKhpQhSLtCE5xpf3ySVmV4haKPgS4RIT7RXmyVTwnQ0+F?=
 =?us-ascii?Q?OcoUhK9YkqyBRC0vfLHhNUl0CA0xkMcnxXHmc8rSLt1/V284G7KVLfzwiOve?=
 =?us-ascii?Q?mk0R6rLAVd0L/W/EgyGKz4LdAH5vh39AwkIVjmSvnb1ohuAfqphehsjsbA07?=
 =?us-ascii?Q?wY5B6DH/iXzaiee4Aj75bEhvE89mTi9W8ORDWNE1jdt0Iryh+HfGjEeRhGWq?=
 =?us-ascii?Q?kLa9YYTRHfLz3dJtYJncB+pCB77oM8aCDta/RAyoPJ8ljtQBOAdA2r2MK5Ax?=
 =?us-ascii?Q?PfVjwh/Vj98uqSAsGzb7psPpI5E50JtttdwCIV1qXfbQBKpMnPWEDnIEWIXA?=
 =?us-ascii?Q?oeB6HaRhgn6Fzilxar3rg0ifq3WYnGXFUIdgYfSUCtk8A7MTcY8TgotFwtG4?=
 =?us-ascii?Q?OrN0JptAFIRCMP5aWcK+4iUcS770X9RWcFnyaP7yJLmELPlWSkQc6ZlF/vO4?=
 =?us-ascii?Q?S2OGKxpqgpvvmiV7CaLHfS92dM/8ePQyqa8qRD9kdWUOKe3LOlu85Jb1Txqv?=
 =?us-ascii?Q?/gjMbv/ufOJ59eovZrcvugvrtfM4jEGV+STYIEuQ6hRsWvN74wxt8rfRVXX8?=
 =?us-ascii?Q?bS82R75hugL5YdwFgiJTx00QbjSqZEQKMYqcvsu3UsYSL3nnFHWJdPFOKXNp?=
 =?us-ascii?Q?jvjCqVNDGDBT0NS6sM4I3cAtBrXWF7lRn/lU74L1uBPRkq1nABqE+qsXIf35?=
 =?us-ascii?Q?QwliDeUPUrbT8ZnYRh+RA9FNrr5qcILFKxXwLAOcw9y63votmbCGe5sVuVaU?=
 =?us-ascii?Q?pv0BjhFjGPuqnriQv7PVDrTP7UhIPfi8u1W8fmlwaeRC1gOUZ32XIYMlzcok?=
 =?us-ascii?Q?iSBvGB/2tLvtsBAUXsDY/3IsneTikl392Jv2rDmTLfJLyTlDc14dwavguEzO?=
 =?us-ascii?Q?QOmgSoQDlx1mmxKVTHxGgb7MzNkQrnzayzdLFsyDW+E+AQWGul+lYStUPybT?=
 =?us-ascii?Q?1br2P/aN32YITMQLA9kXGScb9o1kVswAk0fC7gSIH5GYySUFmYx6zEhWMQ57?=
 =?us-ascii?Q?RVGlCtW5boClcn7ztRRCYuiuWaex+EDEWQDWa78yVU1LeAAyGnjbzEFF1ThG?=
 =?us-ascii?Q?XVOl6SvoGaA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CdcXYHUo5gPmtSVb+cCWo6M1iAzhe221u/73+KFO34nCW8sBy3IwhFzBAOr3?=
 =?us-ascii?Q?f707V/4HuFHNhg6a4Auln+qzqPp+TpmyNcEv+FIN0/kd11oPbaSVg4/OOLzR?=
 =?us-ascii?Q?aEm1LIogNOYz23eXI3Cbky+TU4YDJua0QKUBlM2ImRY/8qkuJ4FTh5SdvQ5b?=
 =?us-ascii?Q?kx4PVM3mBrKhnjrJfD8JSDK9H2azPlOKPQBFZPO/qv91hnQDBBgHHit7Gpz/?=
 =?us-ascii?Q?ALpj15VcDWzNmzT7z6gbi1SKqAAMvIgtZNbDpAKxyQvWVEIOHgRGl9LxCo57?=
 =?us-ascii?Q?JcPBGO0s5c0uP7oKZ8dE5dcdjUk9NoAZdAhyyASKFX+z/uLtJCG5wCuw9FEV?=
 =?us-ascii?Q?1WvpXkzjRjxxCQqlX0bWxuaK8Z/OKgbJWm50DnFK1tbu2YzBfDOiCtF6nO/S?=
 =?us-ascii?Q?HKHZcugKpOC77K2C1K6rA8TbunwnbcUXKlJRSvBbQ7I2oX0nVAxkbQwzorJu?=
 =?us-ascii?Q?igrZwR9CbMSoPxhiJVTisemAL30w0nbEInIGmLzTUtysBOnQjXpM+G6VJoB0?=
 =?us-ascii?Q?BOvhCU3n6zyBDemL54PAcA+heVICaVMjuufcTBWAYrdRNaT1fn54NAuJc3kA?=
 =?us-ascii?Q?pUXE2jZ/d2OFTZ/vUiPueGPloX1xKOhEJXr9mubydbRL9xGh5BUIGQMPgs5f?=
 =?us-ascii?Q?X4s42I3En1e+eq+fVfLXw+h3yRbOpWu0cmYDe9yUK8+jTAr9tpbZNidUnk1F?=
 =?us-ascii?Q?IfS9u/8VQ2wGMTts2L9iSNhvJY6nmkJ4I/WPL/wZEd4P360I1atXVJpNxoiM?=
 =?us-ascii?Q?kN1he0XYewNgT2uslWYa5ZTh/Ncueouo/iCJ+PdLfIENZ00h8zkYhOR0vqee?=
 =?us-ascii?Q?dYoLOxb5hNDFui3Oi6A4SqBldTldmbVomm3y1s2P6yXU9ZLTsutiXVwIGy40?=
 =?us-ascii?Q?RTrwODRjerEftT3A744Ae6cB3X7KTVohPcfY+JyYP+oitOly5khFX9+jUM+m?=
 =?us-ascii?Q?4bM0KQgZ85ewbprFb/C1XujxmtKCTrSCucgkhG2dZff0d94qbLFO4dD+IgSJ?=
 =?us-ascii?Q?2XLWbi0fZ+CVXYZUgdobpzcsbGKddvKOLUwmvimuGdZ/CMk0zJx6MsZLzHWS?=
 =?us-ascii?Q?xxSHAvtExOr1/XVyS2rlHRYQ0M4GO8KrszzX7rIi/cCW3qBA7ibZh32JSzC9?=
 =?us-ascii?Q?xgqejFstnSBR//imlHEL/YQkktR/uvYdpuipu8twE8IeHZMxxd1vi6fvmnnI?=
 =?us-ascii?Q?+Ez4UhPAtFiGkxYVdpsa9IpYW9xMxlzQzWvUnTEDfxd5jen/k6/seHm82X10?=
 =?us-ascii?Q?Hc27WALDFtaN2fc1Czje8GtWcsftksfD+nV6BOQFmvbf6cl0RZ7f01RWzokh?=
 =?us-ascii?Q?P5yl6dM9YcKnAzg5XA5MQF2O1pVngZrd9pKdlgJPz5OQ9BZROyqM5sL6LDCz?=
 =?us-ascii?Q?HsXvBGpTUTLDRnoUaTyuK8orxVa9iTZqJmQkzkX6evfFhDKwRxpDfjSjTcrK?=
 =?us-ascii?Q?anlqdlS8ocDL8MV8gZ8SS5DLQo+1IeOZRdtDRn32UpNvyrqTQJV9nyG89XvQ?=
 =?us-ascii?Q?//o0p9RTXXNX7VIh0Ei67cmAaPtOLerli3hDxPI7vJQDD2puRSWvyajmc+lh?=
 =?us-ascii?Q?FlOSqVh309zixkBUPXOhZM61kIL6O2ugQjPzt+LoR3f53buvCh7heDgAVR9x?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7396778-7643-487c-0666-08ddfc51eef7
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:38:18.9952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbgWz4Kf3ZijG4QjGrNdnxnS56taNGPnXfcyLzJyDPAxsob5A93IPi7wufBMj0Ag9PZbE6NF0mWvNGa2/vMMuDC6FwsjN5Cr50oIPCl5kM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8217
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

On Thu, Sep 25, 2025 at 02:50:19PM +0530, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> In the single queue model, the same descriptor queue is used by SW
> to post descriptors to the device and used by device to report completed
> descriptors to SW. While as the split queue model separates them into
> different queues for parallel processing and improved performance.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Hi,

a few small comments inline below.

Thanks,
/Bruce

>  drivers/net/intel/idpf/idpf_common_device.h   |   1 +
>  drivers/net/intel/idpf/idpf_common_rxtx.c     |   7 +
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |   3 +
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 249 ++++++++++++++++++
>  4 files changed, 260 insertions(+)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
> index 3b95d519c6..f9c60ba229 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -49,6 +49,7 @@ enum idpf_rx_func_type {
>  	IDPF_RX_SINGLEQ,
>  	IDPF_RX_SINGLEQ_SCATTERED,
>  	IDPF_RX_SINGLEQ_AVX2,
> +	IDPF_RX_SPLITQ_AVX2,

The scalar splitq receive is listed here just as IDPF_RX_DEFAULT, and the
avx-512 splitq as IDPF_RX_AVX512, so following that scheme this should just
be IDPF_RX_AVX2. Alternatively, for consistency you could also rename those
others to be IDPF_RX_SPLITQ and IDPF_RX_SPLITQ_AVX512. Either way naming
consistency should be achievable I think.

>  	IDPF_RX_AVX512,
>  	IDPF_RX_SINGLQ_AVX512,
>  	IDPF_RX_MAX
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index a2b8c372d6..ecb12cfd0a 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -1656,6 +1656,13 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
>  			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
>  			.simd_width = RTE_VECT_SIMD_256,
>  			.extra.single_queue = true}},
> +	[IDPF_RX_SPLITQ_AVX2] = {
> +		.pkt_burst = idpf_dp_splitq_recv_pkts_avx2,
> +		.info = "Split AVX2 Vector",
> +		.features = {
> +			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
> +			.simd_width = RTE_VECT_SIMD_256,
> +		}},
>  #ifdef CC_AVX512_SUPPORT
>  	[IDPF_RX_AVX512] = {
>  		.pkt_burst = idpf_dp_splitq_recv_pkts_avx512,
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
> index 3bc3323af4..3a9af06c86 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.h
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
> @@ -252,6 +252,9 @@ __rte_internal
>  uint16_t idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
>  					 uint16_t nb_pkts);
>  __rte_internal
> +uint16_t idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts,
> +				     uint16_t nb_pkts);
> +__rte_internal
>  uint16_t idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  			  uint16_t nb_pkts);
>  __rte_internal
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index 21c8f79254..b24653f195 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -482,6 +482,255 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
>  	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
>  }
>  
> +static __rte_always_inline void
> +idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq)
> +{
> +	int i;
> +	uint16_t rx_id;
> +	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
> +	struct rte_mbuf **rxep = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
> +
> +	rxdp += rx_bufq->rxrearm_start;
> +
> +	/* Try to bulk allocate mbufs from mempool */
> +	if (rte_mempool_get_bulk(rx_bufq->mp,
> +				(void **)rxep,
> +				IDPF_RXQ_REARM_THRESH) < 0) {

Use rte_mbuf_raw_alloc_bulk() instead of rte_mempool_get_bulk(), it has
some extra sanity checks for debug builds and ensures that we don't bypass
too many library layers.

> +		if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >= rx_bufq->nb_rx_desc) {
> +			__m128i zero_dma = _mm_setzero_si128();
> +
> +			for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
> +				rxep[i] = &rx_bufq->fake_mbuf;
> +				_mm_storeu_si128((__m128i *)(uintptr_t)&rxdp[i], zero_dma);
> +			}
> +		}
> +			rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
> +							IDPF_RXQ_REARM_THRESH,
> +							rte_memory_order_relaxed);
> +		return;
> +	}
> +
> +	__m128i headroom = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM, RTE_PKTMBUF_HEADROOM);
> +
> +	for (i = 0; i < IDPF_RXQ_REARM_THRESH; i += 2, rxep += 2, rxdp += 2) {
> +		struct rte_mbuf *mb0 = rxep[0];
> +		struct rte_mbuf *mb1 = rxep[1];
> +
> +		__m128i buf_addr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
> +		__m128i buf_addr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
> +
> +		__m128i dma_addr0 = _mm_unpackhi_epi64(buf_addr0, buf_addr0);
> +		__m128i dma_addr1 = _mm_unpackhi_epi64(buf_addr1, buf_addr1);
> +
> +		dma_addr0 = _mm_add_epi64(dma_addr0, headroom);
> +		dma_addr1 = _mm_add_epi64(dma_addr1, headroom);
> +
> +		rxdp[0].split_rd.pkt_addr = _mm_cvtsi128_si64(dma_addr0);
> +		rxdp[1].split_rd.pkt_addr = _mm_cvtsi128_si64(dma_addr1);
> +	}
> +
> +	rx_bufq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
> +	if (rx_bufq->rxrearm_start >= rx_bufq->nb_rx_desc)
> +		rx_bufq->rxrearm_start = 0;
> +
> +	rx_bufq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
> +
> +	rx_id = (uint16_t)((rx_bufq->rxrearm_start == 0) ?
> +			(rx_bufq->nb_rx_desc - 1) : (rx_bufq->rxrearm_start - 1));
> +
> +	IDPF_PCI_REG_WRITE(rx_bufq->qrx_tail, rx_id);
> +}
> +
> +static __rte_always_inline void
> +idpf_splitq_rearm_avx2(struct idpf_rx_queue *rx_bufq)
> +{
> +	int i;
> +	uint16_t rx_id;
> +	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
> +	struct rte_mempool_cache *cache =
> +		rte_mempool_default_cache(rx_bufq->mp, rte_lcore_id());
> +	struct rte_mbuf **rxp = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
> +
> +	rxdp += rx_bufq->rxrearm_start;
> +
> +	if (unlikely(!cache)) {
> +		idpf_splitq_rearm_common(rx_bufq);
> +		return;
> +	}
> +
> +	if (cache->len < IDPF_RXQ_REARM_THRESH) {
> +		uint32_t req = IDPF_RXQ_REARM_THRESH + (cache->size - cache->len);
> +		int ret = rte_mempool_ops_dequeue_bulk(rx_bufq->mp,
> +						&cache->objs[cache->len], req);
> +		if (ret == 0) {
> +			cache->len += req;
> +		} else {
> +			if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
> +				rx_bufq->nb_rx_desc) {
> +				__m128i dma_addr0 = _mm_setzero_si128();
> +				for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
> +					rxp[i] = &rx_bufq->fake_mbuf;
> +					_mm_storeu_si128(RTE_CAST_PTR(__m128i *, &rxdp[i]),
> +					dma_addr0);
> +				}
> +			}
> +			rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
> +				IDPF_RXQ_REARM_THRESH, rte_memory_order_relaxed);
> +			return;
> +		}
> +	}
> +	__m128i headroom = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM, RTE_PKTMBUF_HEADROOM);
> +	const int step = 2;
> +
> +	for (i = 0; i < IDPF_RXQ_REARM_THRESH; i += step, rxp += step, rxdp += step) {
> +		struct rte_mbuf *mb0 = (struct rte_mbuf *)cache->objs[--cache->len];
> +		struct rte_mbuf *mb1 = (struct rte_mbuf *)cache->objs[--cache->len];
> +		rxp[0] = mb0;
> +		rxp[1] = mb1;
> +
> +		__m128i buf_addr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
> +		__m128i buf_addr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
> +
> +		__m128i dma_addr0 = _mm_unpackhi_epi64(buf_addr0, buf_addr0);
> +		__m128i dma_addr1 = _mm_unpackhi_epi64(buf_addr1, buf_addr1);
> +
> +		dma_addr0 = _mm_add_epi64(dma_addr0, headroom);
> +		dma_addr1 = _mm_add_epi64(dma_addr1, headroom);
> +
> +		rxdp[0].split_rd.pkt_addr = _mm_cvtsi128_si64(dma_addr0);
> +		rxdp[1].split_rd.pkt_addr = _mm_cvtsi128_si64(dma_addr1);
> +	}
> +
> +	rx_bufq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
> +	if (rx_bufq->rxrearm_start >= rx_bufq->nb_rx_desc)
> +		rx_bufq->rxrearm_start = 0;
> +
> +	rx_bufq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
> +
> +	rx_id = (uint16_t)((rx_bufq->rxrearm_start == 0) ?
> +				(rx_bufq->nb_rx_desc - 1) : (rx_bufq->rxrearm_start - 1));
> +
> +	IDPF_PCI_REG_WRITE(rx_bufq->qrx_tail, rx_id);
> +}
> +static __rte_always_inline uint16_t
> +_idpf_splitq_recv_raw_pkts_vec_avx2(struct idpf_rx_queue *rxq,
> +					struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
> +{
> +	const uint32_t *ptype_tbl = rxq->adapter->ptype_tbl;
> +	struct rte_mbuf **sw_ring = &rxq->bufq2->sw_ring[rxq->rx_tail];
> +	volatile union virtchnl2_rx_desc *rxdp =
> +		(volatile union virtchnl2_rx_desc *)rxq->rx_ring + rxq->rx_tail;
> +
> +	rte_prefetch0(rxdp);
> +	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, 4); /* 4 desc per AVX2 iteration */
> +
> +	if (rxq->bufq2->rxrearm_nb > IDPF_RXQ_REARM_THRESH)
> +		idpf_splitq_rearm_avx2(rxq->bufq2);
> +
> +	uint64_t head_gen = rxdp->flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +	if (((head_gen >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +		 VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) != rxq->expected_gen_id)
> +		return 0;
> +
> +	const __m128i gen_mask =
> +		_mm_set1_epi64x(((uint64_t)rxq->expected_gen_id) << 46);
> +
> +	uint16_t received = 0;
> +	for (uint16_t i = 0; i < nb_pkts; i += 4, rxdp += 4) {
> +		/* Step 1: pull mbufs */
> +		__m128i ptrs = _mm_loadu_si128((__m128i *)&sw_ring[i]);
> +		_mm_storeu_si128((__m128i *)&rx_pkts[i], ptrs);
> +
> +		/* Step 2: load descriptors */
> +		__m128i d0 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[0]));
> +		rte_compiler_barrier();
> +		__m128i d1 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[1]));
> +		rte_compiler_barrier();
> +		__m128i d2 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[2]));
> +		rte_compiler_barrier();
> +		__m128i d3 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[3]));
> +
> +		/* Step 3: shuffle out pkt_len, data_len, vlan, rss */
> +		const __m256i shuf = _mm256_set_epi8(
> +			/* descriptor 3 */
> +			0xFF, 0xFF, 0xFF, 0xFF, 11, 10, 5, 4,
> +			0xFF, 0xFF, 5, 4, 0xFF, 0xFF, 0xFF, 0xFF,
> +			/* descriptor 2 */
> +			0xFF, 0xFF, 0xFF, 0xFF, 11, 10, 5, 4,
> +			0xFF, 0xFF, 5, 4, 0xFF, 0xFF, 0xFF, 0xFF
> +		);
> +		__m128i d01_lo = d0, d01_hi = d1;
> +		__m128i d23_lo = d2, d23_hi = d3;
> +
> +		__m256i m23 = _mm256_shuffle_epi8(_mm256_set_m128i(d23_hi, d23_lo), shuf);
> +		__m256i m01 = _mm256_shuffle_epi8(_mm256_set_m128i(d01_hi, d01_lo), shuf);
> +
> +		/* Step 4: extract ptypes */
> +		const __m256i ptype_mask = _mm256_set1_epi16(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M);
> +		__m256i pt23 = _mm256_and_si256(_mm256_set_m128i(d23_hi, d23_lo), ptype_mask);
> +		__m256i pt01 = _mm256_and_si256(_mm256_set_m128i(d01_hi, d01_lo), ptype_mask);
> +
> +		uint16_t ptype2 = _mm256_extract_epi16(pt23, 1);
> +		uint16_t ptype3 = _mm256_extract_epi16(pt23, 9);
> +		uint16_t ptype0 = _mm256_extract_epi16(pt01, 1);
> +		uint16_t ptype1 = _mm256_extract_epi16(pt01, 9);
> +
> +		m23 = _mm256_insert_epi32(m23, ptype_tbl[ptype3], 2);
> +		m23 = _mm256_insert_epi32(m23, ptype_tbl[ptype2], 0);
> +		m01 = _mm256_insert_epi32(m01, ptype_tbl[ptype1], 2);
> +		m01 = _mm256_insert_epi32(m01, ptype_tbl[ptype0], 0);
> +
> +		/* Step 5: extract gen bits */
> +		__m128i sts0 = _mm_srli_epi64(d0, 46);
> +		__m128i sts1 = _mm_srli_epi64(d1, 46);
> +		__m128i sts2 = _mm_srli_epi64(d2, 46);
> +		__m128i sts3 = _mm_srli_epi64(d3, 46);
> +
> +		__m128i merged_lo = _mm_unpacklo_epi64(sts0, sts2);
> +		__m128i merged_hi = _mm_unpacklo_epi64(sts1, sts3);
> +		__m128i valid = _mm_and_si128(_mm_and_si128(merged_lo, merged_hi),
> +						  _mm_unpacklo_epi64(gen_mask, gen_mask));
> +		__m128i cmp = _mm_cmpeq_epi64(valid, _mm_unpacklo_epi64(gen_mask, gen_mask));
> +		int burst = _mm_movemask_pd(_mm_castsi128_pd(cmp));
> +
> +		/* Step 6: write rearm_data safely */
> +		__m128i m01_lo = _mm256_castsi256_si128(m01);
> +		__m128i m23_lo = _mm256_castsi256_si128(m23);
> +
> +		uint64_t tmp01[2], tmp23[2];
> +		_mm_storeu_si128((__m128i *)tmp01, m01_lo);
> +		_mm_storeu_si128((__m128i *)tmp23, m23_lo);
> +		*(uint64_t *)&rx_pkts[i]->rearm_data = tmp01[0];
> +		*(uint64_t *)&rx_pkts[i + 1]->rearm_data = tmp01[1];
> +		*(uint64_t *)&rx_pkts[i + 2]->rearm_data = tmp23[0];
> +		*(uint64_t *)&rx_pkts[i + 3]->rearm_data = tmp23[1];
> +
> +		received += burst;
> +		if (burst != 4)
> +			break;
> +	}
> +
> +	rxq->rx_tail += received;
> +	if (received & 1) {
> +		rxq->rx_tail &= ~(uint16_t)1;
> +		received--;
> +	}
> +	rxq->rx_tail &= (rxq->nb_rx_desc - 1);
> +	rxq->expected_gen_id ^= ((rxq->rx_tail & rxq->nb_rx_desc) != 0);
> +	rxq->bufq2->rxrearm_nb += received;
> +
> +	return received;
> +}
> +
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts_avx2)
> +uint16_t
> +idpf_dp_splitq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
> +				 uint16_t nb_pkts)
> +{
> +	return _idpf_splitq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
> +}
> +

Why the extra level of functions here? In other drivers this is to separate
out common code for a single-buffer, and scattered packet version. Are
there plans to handle multi-mbuf packets here? If not, might as well
collapse the two functions down to one.

> +
>  static inline void
>  idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
>  		  struct rte_mbuf *pkt, uint64_t flags)
> -- 
> 2.34.1
> 
