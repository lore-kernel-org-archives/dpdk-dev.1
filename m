Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4F3D5E146
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 12:43:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BC34402AC;
	Tue, 16 Dec 2025 13:43:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 935084026D
 for <dev@dpdk.org>; Tue, 16 Dec 2025 13:43:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765889010; x=1797425010;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QL/usMykO5b/tEl8G3YOqdd94XLDIgEqhE9o2DSRbrg=;
 b=RNbTdSASlW/Ka7uYQ2ynurZm5OcVWCvWyd7gGLV9OvsFsverK76oLatS
 FWMGX5QK95WATHeKV9SCt4bT6CqJk6+BEyVM/7atCtAu/c9gA9saMI2D3
 SttHspo2tIKvAawsGOWlbYm3G2roudIFqImX0DTe3Y4fdnX29dhjpvlnC
 2sFlMmSH0NqoM7Mqg8B6jkN3hNays+wc8Sc2bKOfiJ9uH/WLUv1ILmz/f
 uAekgq3mJki0k7IUTUzjsrgBn1kVWxKr9uU+ULUeewbkAwyDfZOvV9vc4
 JXVc29Tzv33kSDOtnffBtkJ2FtC6ZgSgInIqxmM6MZb32sT9xMIKyB2SF Q==;
X-CSE-ConnectionGUID: iTelnwonSfCmyCa13cUA6w==
X-CSE-MsgGUID: OJNPNIjpRK2pxhCJkWDgKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="78111781"
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; d="scan'208";a="78111781"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 04:43:28 -0800
X-CSE-ConnectionGUID: QSfDl+3xROKmb5drAPv2JA==
X-CSE-MsgGUID: pNxKBtecRLW5Ss2cgJO7vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; d="scan'208";a="197903859"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 04:43:28 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 04:43:27 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 16 Dec 2025 04:43:27 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 04:43:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPMJ0/7PjyIve2H1rW7oNPKc8Ixs5UEmQISN3oOnFjLGD0/bc8dq+MaYRN/Hhc1FJEcN1kiBlL1mkIk4MY/iDRZiIMy5gYRAk+0sWV1G28oB5dDnjVYSdYb1C7XTfVNQKTs5vPM+NoR43Xf3FJbWUgtLm6Scyd6RwxY3UPInmEIdWu6CLBtxVcptq9p0/h5EgjQy0q1Zwz9GJoU/Emn2VDQt3M/WupAg2o6TKzonSrtjtsx7zgsGfL8RqyEh2YVfyMafjtrhf7odJ6wp3eZipxlwvimYUvXzyAMdiqa3wGju+GCRDLsbvJYt+s5kXy2IuAYYF/oLONPjYF3iDrXqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81HUgSpv8C2ZXiLhcF6Yoiog52Y9AY+ZiC8rbmDpgog=;
 b=MRfh3z4JJKYvLZzASMextVddrPVkV+7625zgZ7qtkCehRwKF58qBLrtcElFhST1NhZR+IGBd5ugd8ThkuqflqYr3JVCKD+3+JPw6ecTGvDH852yYeuo3oogiDe1zAuDlqmKaFSIfdzXGZxJbQf8GE7a3eAEEaFhAFq4Hke8dG0efW+bjtlTEru7Mx6Vv0gQm6WjbFvAqgNmpSwYjYIUCan7D9dBrpmqdH+J2kdDHSi67Ip9faL61jnVWTCoCpXXXaVALHnBvglfSiJtvM7jYtOUXsSO0iCStRFKJo5OQJkv5nvxetXtjZr3J1b018fDKLlv7ebK953gBJkSSbloxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 12:43:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 12:43:17 +0000
Date: Tue, 16 Dec 2025 12:43:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <rajesh3.kumar@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v3 3/4] net/intel: add support for Precision Time Protocol
Message-ID: <aUFT4BwL-wYqSof_@bricha3-mobl1.ger.corp.intel.com>
References: <20251028060758.233929-1-soumyadeep.hore@intel.com>
 <20251103160646.140084-1-soumyadeep.hore@intel.com>
 <20251103160646.140084-4-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251103160646.140084-4-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DU2PR04CA0181.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN6PR11MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: ff77f4df-b9e8-4b88-537d-08de3ca0aff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?utjjplryeP5mWeleeG1dFj+ZvCFcDeOUhaV6hp/1sbIHOEMF56z//CYmDGFE?=
 =?us-ascii?Q?bJvVeZKBH4l29/iNaSg/BTVDTtbskb0z7qN9qoZnzPM2rUS4Gzmc05m9CjSx?=
 =?us-ascii?Q?4DD72R5GEDjeLQq1fqyCnZ/xVl8jX0tjdM5AmpatCHRP/zX1Riqb3A2mTiCW?=
 =?us-ascii?Q?S6IbdTfh1yg/iBxqucAdGnpzKTEuh2oAbNUvjKn8VsfHdjC1x3bUath6myrT?=
 =?us-ascii?Q?MIXFQRCQossC/pGgTCVEtOpIHLXm6LljZaEZhI3Phj2NXoMFst6JPbX8eTFg?=
 =?us-ascii?Q?15pRI3I/BrB4bvF75Q4RRjX3I6RebeBt+BG2zKPYv6EqZK+aCEIGswit1RQX?=
 =?us-ascii?Q?K/BZKiIgFvoqnlSLMgkxLhlADydtQzXZhf7+QHhCT7jC5ts4yosmcnc5jzQh?=
 =?us-ascii?Q?0CvHBYIS59RD2FZxl1gy0wSWC5I1sSGw6gJPKJjWrmKZjVIgcb1Lab00EFKP?=
 =?us-ascii?Q?TBigfiASv3EeAq/2GdP2tSpXVJL0bLMnHmM+l/TW9F8lUT/yqc8irrdgrR0H?=
 =?us-ascii?Q?fs7W66cTsnGIVKuwazyO88xvjaeP/6Ugna1sT0G9r7eR7gDVbEC8PRVYx4Wx?=
 =?us-ascii?Q?XipLD51yjup+03trItKJ1eOF/IOf+y483eI3SK0Jomahl7HVH6cPh/Gtqpg/?=
 =?us-ascii?Q?7o+VU/3OoJmT7JbwHEU8LVgcUGmErzJOjSusah6PAKLmqvENdY70GRH8PJiW?=
 =?us-ascii?Q?4WJ1Bn77S1u7Icf9P3lpevI8Vm0OEecOHIcVJZLUfcS0DJOv01jqiuwaL+PE?=
 =?us-ascii?Q?lim70T1dGFTxfuTQWdaHGGQ26cXuVB0GKNa6ic4JSpp5XeMLGZTLKRRaTL6x?=
 =?us-ascii?Q?5WdIJmomIdGxVvb2QC/kk5l3IRJUAAKbrS5Bz9JdT9WyDL5Bb+oOU4Ce3zyM?=
 =?us-ascii?Q?Pgg2NR1heDwZ9GRoXPLxmDdtqEk9dmHI7ldWDu2s3/PSvbMsMoUKuRspdCh6?=
 =?us-ascii?Q?ASyzMKzHC1pl1p/e3TXlzu5bWq6meDlZYCEa+4f3SwNmATLGVpcgf61G8nXG?=
 =?us-ascii?Q?k5ONMOvpga/OP9NuS7Rr/faqEVuGuubXU4OB4NduL1tSp/6CcoKQ4SSMFig2?=
 =?us-ascii?Q?x/L8NR0A7nOrdytHzFgwaM/rPWIpisNLzHyC0IrluzAtHyOJm243EoicIJI+?=
 =?us-ascii?Q?tpPlDScCTYcw3FoVprcB9crJ9/hKg5jPrIDMzX6IdTgftCKj3MdkofO0ZjaP?=
 =?us-ascii?Q?wiL8HSrFuz3KTJd0C5BCTp4rhrxoahfrOPJqUglqBj9hTPkK3NKMckRh+68f?=
 =?us-ascii?Q?A61tKQut0J3Z3HqyzXjhWyZ9uof2p47e/bfWeUldR/6FZsi5ctDwGrDN9BMr?=
 =?us-ascii?Q?HOXzO7u1cPmBlyZ5hrj8+PFRL4Xu1GOszhd4BhfcTG3zghANDvDelKuHxprw?=
 =?us-ascii?Q?gba1mwGPy7QONRq7+W239IwUz87l7CW0u3Kd7T0kpqJ2ZfTUBEqbYJYZfNFm?=
 =?us-ascii?Q?hn7BcPHaH8NzM0rtFEdckq6Jqiu9L48O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZdJcrimtq1Cbl2OWQN9ELYoDTuMsr5cVEE1WS2RjMOrndq68n4OWqDn6zQZ6?=
 =?us-ascii?Q?qxOuDDwd3QeVae/Hkflf767ObYj82eWSbBRMbZIvCwWyKLOShabAsCfxUqL5?=
 =?us-ascii?Q?JRw19ZNtdrxArTQeGtWQtBjRU1gYbCswyUKYGuNUsmuXmep2JkcSF91QKC8Q?=
 =?us-ascii?Q?sUY+NGUS61c9u0RFmHJ5PEvBETa16SbxlTTKccIaOBCv6myvx3vzX7WsVz9I?=
 =?us-ascii?Q?d1hHuWbKMYhYKp0vXW+fYdODck46K7Nv2UUqCdmkVC1WL3zD7aZvW5/w2i9H?=
 =?us-ascii?Q?OMjlzkCgDhhlx6i0qKMq2WfCXD4suAI9459wgzC5xS9WVDb1VMfzBaDCA56o?=
 =?us-ascii?Q?vz5RJk7uBPKJqKRpeNQDEdalU5++12V+vKfyDBTnhz99G8G24UFUiSen5yuC?=
 =?us-ascii?Q?VN/cOMqg9AyXlBKO/rGRW12x43DR6puG7RoPuoA8uRCZN8NLwUGfeXcwiNTT?=
 =?us-ascii?Q?tXt1jNx7Ajfn3FprX9cdFeyF4SuhfhPIkeIvqmfWqsb6k7QMs7d/YuQeNmGX?=
 =?us-ascii?Q?BZAQK6ARQ9jTMOBuS+TYdnAoes8SvPtnmRoa2ZzmfYQz3h+odhhhZGLUYkOm?=
 =?us-ascii?Q?Kyfx+T3hKt536NKd4cjVeYuaPCBvba/HtwpleEZ3gywcKcpi/BWnVKFuUBC2?=
 =?us-ascii?Q?BH0xpgOEDqguAfIxWqaeSwcYY9Rh361UI6pmPX9uAIiPLOyXwPlo183Djyu9?=
 =?us-ascii?Q?7cnWfpH5JAGmxsZ8LfuERplcatQDsSm/P4s8F5fq+BRfk09kcgnl0NA4bC1H?=
 =?us-ascii?Q?FuJNvBa6LlJ+aBTJuSJyxkKnTNv5aGqJ7a/Cu1kysvAE+TVg49EjIS34evb2?=
 =?us-ascii?Q?6d4HD9QitNyIphd0GyvUqwj6J62queKYOsl+JCTgucPHE50KHjEG977F7JTj?=
 =?us-ascii?Q?h7nf353F8GRirNCL5Wg9g2b9S0JcTbZVI7j89KFwZq/K6ehNovBFwjR4KR/l?=
 =?us-ascii?Q?k5i+sqdCX1WNNOipTSpqoAdQCf3ucIgTg9mplC6W2rErcG/6VPunvY0tmF7+?=
 =?us-ascii?Q?utbWBtgTh4CKvoPp3bfsOYVKv16yF8f7Kd81OD5npYwC6zSB2pht8sl5lsId?=
 =?us-ascii?Q?5GePzEcQNijm6ByJbF1L7t5uF/tnzGsNfkxbVfQfoWtg7SVK3QtfXQZ4NjnC?=
 =?us-ascii?Q?FqouJHW6o0wu9Qg6QTzkrIchjwkgc0pwZamgd3ncDPnRtHWLaJGQHx/xhELu?=
 =?us-ascii?Q?0pE6HIttcpzyhP9bTn1I9uRonviSAh5nxUagnD3DDRBnH6c/ta13pWf8nRvC?=
 =?us-ascii?Q?WDVipawca0OARCVEHwNS4bxyvbzuESE+ztBqCEQbxFS/6VBx5yIyxbsEpvR/?=
 =?us-ascii?Q?9256SkwOkgtOCaJHmJ418EY74adEWxoaqDuDJIIc7jg5fKFCnKF6GWO2V5u7?=
 =?us-ascii?Q?iwrMzskkgeJGYAztnknOJSG7yLbL4+JNAgyD/tIv9iIvV+h5j5V0lbLFtVk/?=
 =?us-ascii?Q?abyL6pI9iiX5Fx5hhMXCUiYGqQds6fYi0RfL2fjO4EBQ1oQZjUoXVWMcasaI?=
 =?us-ascii?Q?tBixvufnePRjkaEPT+oKSmQrl/rFCtZoRQ15rKEdGRGqMiWem1HBP1E2SGCt?=
 =?us-ascii?Q?Vu3Tf3GHIqwS1FOS2ssUB4+dRC+nY3EUwIsfU2+5Co8CeLIRw7OMVY8TNYsf?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff77f4df-b9e8-4b88-537d-08de3ca0aff4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 12:43:17.8830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AIBYIfvgOauCkVN49lgzlRy1/fcpzdrq4alV7UazK/OwtRpZiOuz7VJ9ZfLfIYJpX6lNSO0C+TQNkJ2D/UjIAvRHQq67WUREXuXZbJqDaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8102
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

On Mon, Nov 03, 2025 at 11:06:44AM -0500, Soumyadeep Hore wrote:
> Add support for PTP that contains negotiation with CP to receive a
> set of supported functionalities through capabilities,
> get/set/adjust the time of the main timer and Tx timestamping
> through secondary mailbox dedicated to PTP.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/common/tx.h             |   1 +
>  drivers/net/intel/idpf/idpf_common_rxtx.c | 186 +++++++++------
>  drivers/net/intel/idpf/idpf_common_rxtx.h |  10 +
>  drivers/net/intel/idpf/idpf_ethdev.c      | 275 ++++++++++++++++++++++
>  4 files changed, 401 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index 5af64a4cfe..fe175f7d65 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -113,6 +113,7 @@ struct ci_tx_queue {
>  				uint16_t sw_tail;
>  				uint16_t rs_compl_count;
>  				uint8_t expected_gen_id;
> +				uint32_t latch_idx; /* Tx timestamp latch index */

This creates padding in the structure. Unless there is a good reason why
not, generally structure variables should be kept in order of size, from
biggest to smallest to avoid padding.

/Bruce
