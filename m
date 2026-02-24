Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29041F357AD
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 14:27:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52E4640270;
	Tue, 24 Feb 2026 15:27:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 9E14D400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 15:27:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771943253; x=1803479253;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nyKFQrbSUBJEONZ8tTY5cQNxgCd19axtCUt9dl5h2Iw=;
 b=g0g1LETQ2nP8mhJsYR8HOiLh3zOt11WUjgaxGl2cXs+9I5uodNG5UDZF
 ROrNBS+yukg8gibXmWJRd9EQ99n4y14jJoBeX7nbOxmN19hD2E4xR+Z/8
 VENYwBEdneyTFWmRQLaFpKu5Fw+elYSkG3MUs8qTJ3ts1YJBkBEYzc7I0
 JrVExEvuC9C5MM+LpdsDQ4qR3cwG789qzq0+1lmtCtt3mYBVZ/69/NTzT
 xulv7BA6rADqSyBmeYmxNzNGyFuEp/xcxoQTRC3vw7D/LxUnmfFwUfHIT
 JAXYVZ9ZEaj58IToA9/EIEgiavq+mkLd5xfzNSplLbfNvO5oJHkne7l0k g==;
X-CSE-ConnectionGUID: Nnt4RYxuSvKNZzfTEgxveA==
X-CSE-MsgGUID: pRSO80c5Tqa/9ePIR8HDUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="98419239"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="98419239"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 06:27:32 -0800
X-CSE-ConnectionGUID: NQctuTsKQKu/0bAUpb08xw==
X-CSE-MsgGUID: E8U1qC7BTrm3liztb44nhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="219389574"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 06:27:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 06:27:30 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 06:27:30 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 06:27:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvI/z0RF3tUUnGSI6kKRqDfThfTDcCU0XwR7aKMZZnL6WJKMRtQsHk9YORxF+t5TnzHlBlTXg+np5BcQFoABhzn1U7IeEBS7llnyA1dBLyh8TjcjFaDtl98cJqFF6kkq4DgUM+6g7FiK3R0+L7uSTK5r/YTEh9zkc+TVxyXTcLtzO69rDzr0QL1Rj/v6UslF1QTtSBtVZeQnt+SuDGWMZ432yClRKWEdOt2pldlpsIh2btLBCf9KxS6JJt4mbPtJPsCkD5ACx23HJeVH6QLG1HY/wXLGK4vS+Eb9gZLC0vHL7hVQJSiC4eMdYC5eBSFkcgZMrzNi4YVrufeBipfSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcU7al58Lgt9mPufKNt0SCnPtKFJe53FtLUJP2z5k/E=;
 b=sCg1J0GoGOpikq/WRIZFfKrqkjJYVR/Pri/W9z+rNHQ3ee2/qjpTSXp6G7CZ1OO3ipVi+EJ607S9s/5oSK8BRMW27DNFjsIs/tK2rEF9mhVbR0VKX8jcOur0GiVbhwYtDkGhOyGoLfkiCkryDd7qfr47HFsdWs1VhBOpYD0q02nXK5IpqhWWT0zddpXCDNFxTGchW86BHsuQ/sanLgG5B/jX9CrdaEg62KM0+Go5uLLzfbSo8aTpqVLr23GJIt+LRiH/HRaAjJRq0ceD6ysWv+BEJelQ6KaAHAS/z0WNyNYQsEHK0p4TNqTipbgbehpRyPJg0m+o09joBuZwCHNbpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB8469.namprd11.prod.outlook.com (2603:10b6:a03:57b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 14:27:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 14:27:20 +0000
Date: Tue, 24 Feb 2026 14:27:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v12 1/3] net/idpf: enable AVX2 for split queue Rx
Message-ID: <aZ21Q803oDWU5BxP@bricha3-mobl1.ger.corp.intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20260224074726.2392669-1-shaiq.wani@intel.com>
 <20260224074726.2392669-2-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260224074726.2392669-2-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e61b758-8f36-4790-6282-08de73b0d1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q2hPfciSrFpi4b6KK9yTl/cixflsLh3veN1Fh7M7PnjkIKTdYDqUau62uPXd?=
 =?us-ascii?Q?lts6K/EuSdAwdtigpaksKIdJ/ASJ969lsd3HDcUlus8SjTKgcMe/2RN0kK4o?=
 =?us-ascii?Q?yzVKotWm0jXbP+OjbCPMPPqPZziA3+LdGKOnbsthFvXboMecpJMRfkaEAeFY?=
 =?us-ascii?Q?ax1gz9CHY1PbjfjqilQ8SZ8LaemodtawOT8v5msURhouWWIydcMA0FCaauFX?=
 =?us-ascii?Q?9EpP574/K1bctN+9oLueqLbaFavL+IHXQn0XtvPtz2RjPoEmHCqoyd2jO/Wg?=
 =?us-ascii?Q?AHWfLFJoI7hIRSq17GPwwOMmdfFP+ym1mzikl6hU+/EhgtS6YRb3zPVCmtmc?=
 =?us-ascii?Q?7Svuu785SWdE4y5i9QXBvILtd+MoiQ9/bXNwmr2Ecx6o0x61e4/U4WT9z5Ws?=
 =?us-ascii?Q?//nC7hrfIs96L/KUTnKJobcJ1RK0LP/Sz4F2B8Q0J4b4YVmwsK+P04wc//hp?=
 =?us-ascii?Q?aVz8AMiBRyPQ4iXkJLxE0DW+7seOvapEmhgQWnjP2ut1LwYDyvvjwcBWRGVk?=
 =?us-ascii?Q?1uDTkuwTsWN1Cb7wBnJk9KOadBbmZv/3avB81W7wtdvGYxrxX72osQmRx1MW?=
 =?us-ascii?Q?QLktih5fAZRX5gCg3WNZkFnzs5s38rYvPe2b1yw+SNGUZUdwCTCMos+g7QUt?=
 =?us-ascii?Q?vLPPWYY6yzgKOWxXHGKNkfMQJpNwc0KIjq3tip2nTHfnYeEts8IDOz19apEX?=
 =?us-ascii?Q?rkAISzDLao+HWohq3+0rpw+4JJ3Arq5Igmmo3CvvHeFWYfOGw/sMMJmrQ3QA?=
 =?us-ascii?Q?iFso/3hx2bcNZGXDL10Re94qTStSvX1KrOZ6x2T7/cVPc2PNFpBSSr42vwon?=
 =?us-ascii?Q?Qa0H8mCWnJloot5/vX9X5zv8vBFRS0DZzinjZZiweuQy1F6SQvvSgXJv4OCN?=
 =?us-ascii?Q?gpx7OKW9wwRS+F/1mpEXKjocUcfSS8ZXy1epCrJ9pgSVk/APfu7Xyz2Gzn8T?=
 =?us-ascii?Q?B/FqhwhYW9JX/E4I0Yl93lsrk3cDaocEcZUiQ0i4kMyXNqOMlpNiQwgcleWF?=
 =?us-ascii?Q?EepAPnjSLXPTPabzrAWjCIQ+J6mAckBU8sPiojBbkWokrvZnVGBTmprO1LZn?=
 =?us-ascii?Q?sehMZ0Dd7z07yaaubiQKSu7CphdeUF/8Jnx1ZFsVX807M2pjUJslnuE5pqxk?=
 =?us-ascii?Q?OmE722+NOyj8ooCnK1Z3OgePB9T+uJ5SUMba22gha8XvIqWjKaEMDrDzft+z?=
 =?us-ascii?Q?XllElZhDwkjDUpaqu/c52nY/J+yeVA6IdPEaEw+Ewa2lE6lRxjhHun1kWZAw?=
 =?us-ascii?Q?LOibKQYE1PbphLUFFL9A5mLJljL2BNoi9kwX8FCO4DxgfofaqSvXJvtC5rXj?=
 =?us-ascii?Q?wamJn+54WwDPBVgjyb5CF/VWH9QWnYJQzEZozuzSHR+R0W8vcXE90Yd3nfjG?=
 =?us-ascii?Q?9CnSje2VaK2q4VcnB7aOHfp7LJC+iD1pVatcD8kQ3YpYaau0/eQs4gjTz7q4?=
 =?us-ascii?Q?3g9ozEUnoBPdNF7r8tj7v/OVYY9OhNK1MpAP07tSqs0ltyusw/Vkw+Z7l1iS?=
 =?us-ascii?Q?cr8fICU5RuZNCphV5P3vtRoaS7vMHdhqVc8TVxco4HwTA26MRjQqn2mvtHbj?=
 =?us-ascii?Q?Rq9SGz4QCNlsGx55vI0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lte1i1SHEkiV3TppF6967g3CAsWSMA147wqCMar9ges+rrJXWdfYeK5nuvqJ?=
 =?us-ascii?Q?UnzL6J1Vc5UPPoadVXt3ToCkYwYzIGgXA/C2atj5x5JxzDfrejdRxuqLK63c?=
 =?us-ascii?Q?aOcHZmyTwLrWbBqz3SyQvl3bSqpgailXMcJftrFlSBSu+e0cNQSNlp/3bYxf?=
 =?us-ascii?Q?16vmoq17Cwnv8uyyKOTwggAXCEnCQlXzoUxsJXV2/By34QwMy0KyVPx6jJnJ?=
 =?us-ascii?Q?+vjVuFyGmnkWkZJl1flpwEHKJHbPBUh3/TsetI2eAS/aGffr+tyAp2Y56Cbw?=
 =?us-ascii?Q?mlDc9A/3iOHRGu/EtZkJKilkDq6t+RkBJUinxiUrTP7J8rL3IlyycYmLLtPv?=
 =?us-ascii?Q?bS1TRsdOutBc0dEVf6wtSqVYo71XbqyeXG2bs0QJHQUe8eAVolBr0lyTTGlH?=
 =?us-ascii?Q?BXa2j/XQ4ae2vu0YcEk1eosupxS51Fm7Psvds8t/jjaiA8S2o6GE2l9AuqwC?=
 =?us-ascii?Q?MZju8WbxoSG3Byo2p4gSsLG2vOvUwGMnl7eYFQoZc5Safd6BN06DX50HRGUJ?=
 =?us-ascii?Q?1swKGQjhC58JXzOtaYediwkSlPnVtApcKJgqjrEkoL9SHiSoMxuseMqtey+6?=
 =?us-ascii?Q?8eftDHwCG4UaEJXWymqxhDEs/5QO/T9IAbWrNQuYc9vtnUsppeLUduWxUvjB?=
 =?us-ascii?Q?M8Plabg5H/7eN+4sdxMOYQgd5kpwl9FlyPP4lXJBW7/jcMDgQ0XcYhXPFoDc?=
 =?us-ascii?Q?bW1og0sVoEVaIhv3YkHr9RFn+xAdyDFeCXSzxLdCW01rc1bpKoKp3rtpWlLr?=
 =?us-ascii?Q?NOxpCTqCbWHTfflb9I5xji+KQmgSzt1qbCLkCA7oKy7XjQort1KT3+dq3dGS?=
 =?us-ascii?Q?yVBsW5xO3mS0BFx/L/4LuRiTbLf1RwDe4OixNCh3D/OC8bPaIjkJW/4G0f6B?=
 =?us-ascii?Q?2sPPSpe/s2rzbp8KSIwOnVXmTKX311UlcuO6C/RrsI4Rf7KjQJdOApROcmKD?=
 =?us-ascii?Q?fPXtE29Ct2PGsIg6baAsMynO9J7k8y0lxYqFdcJn18IGz2xVz51YcoC0R+mc?=
 =?us-ascii?Q?YwWWKwd4iO9wPxFASdsIRD+HG5mbiQoqRuDqZi39xU0iXd/8y3crLHwWetJE?=
 =?us-ascii?Q?qzy3kNvz7zRug6Y+pGwxJ+PxcxUVI2k+LWyFipVPTIiXeJi7s5NFBaX6Cy1O?=
 =?us-ascii?Q?YDN6q8AEzJb2f/sSHCn7epz+b7GCYuI69ZL2Fokk+eolTHeMaoeOh2+ORpEn?=
 =?us-ascii?Q?59Ks7Tfku2duV2LgCHv9+WeMI3HJbNl0h3eUuRhJ4pDNZMUfE14I0Atp8IEj?=
 =?us-ascii?Q?Cbe0SSLj1LrQVt4isEZTa+6eOinwzRh2dHuPOb0aagLjXAwODdXmKGgCwwTC?=
 =?us-ascii?Q?u4vHkj+BCLp09l8KvWgHm9bdAlMWaOulW7/+24OkFU4t/p+G5KiZ6PvSRMq3?=
 =?us-ascii?Q?Rf7pwwaqR+oQsCvRtdFte8kd/DTkpOQfmd9I39QXx4zjD0t3rnIEDcPC2YVC?=
 =?us-ascii?Q?Pt5Y4d7FYk1EllPhqLrUHIln0fJjRBvo4emQG1BdUmo00XIjldbOI84VEXSr?=
 =?us-ascii?Q?jDi7t2tZ0rJUOE4wE/FE+46BpZAN3Et0abvoboeajcA5EEg8KboSlvfVtkVh?=
 =?us-ascii?Q?J8faQYEkJttH55RSdQeNitsjIBy+RR7/zvzvxsTj47iyp01c81zUUh3PFjYc?=
 =?us-ascii?Q?DNFzyiG7LlCR8bjrWtJeH6iCYttVB4lu7FG5gYAET4nykNPcy8cHpHQgJa/d?=
 =?us-ascii?Q?ENEuNt4WLSOKOfIqSiA381eoDCDFiFh6kEmsRJiBLsd7aeALe2t40njptNUf?=
 =?us-ascii?Q?pnV9Fsv09QU6/JgMBsOk3ys3yOFG73c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e61b758-8f36-4790-6282-08de73b0d1c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 14:27:20.6801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEomzF7XTphXlxyt3B4E00JLZ5gnmajuZjWHzRBrP5afQDiTlfGJtDXJ/CZneT7Suhx984L3nk9UCQ+d6eTtQyTMA2G8gX18stALSWlpF/A=
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

On Tue, Feb 24, 2026 at 01:17:24PM +0530, Shaiq Wani wrote:
> Add AVX2 vectorized split queue Rx path.
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/idpf/idpf_common_device.h   |   1 +
>  drivers/net/intel/idpf/idpf_common_rxtx.c     |  59 ++++++++
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |   5 +
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 138 ++++++++++++++++++
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 -------
>  5 files changed, 203 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
> index bbc969c734..1424046a16 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -70,6 +70,7 @@ enum idpf_rx_func_type {
>  	IDPF_RX_SINGLEQ,
>  	IDPF_RX_SINGLEQ_SCATTERED,
>  	IDPF_RX_SINGLEQ_AVX2,
> +	IDPF_RX_AVX2,
>  	IDPF_RX_AVX512,
>  	IDPF_RX_SINGLEQ_AVX512,
>  	IDPF_RX_MAX
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index b8f6418d4a..ead31fd0f8 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -253,6 +253,58 @@ idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq)
>  	cq->expected_gen_id = 1;
>  }
>  
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_splitq_rearm_common)
> +void
> +idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq)
> +{
> +	struct rte_mbuf **rxp = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
> +	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
> +	uint16_t rx_id;
> +	int i;
> +
> +	rxdp += rx_bufq->rxrearm_start;
> +
> +	/* Pull 'n' more MBUFs into the software ring */
> +	if (rte_mbuf_raw_alloc_bulk(rx_bufq->mp,
> +			(void *)rxp, IDPF_RXQ_REARM_THRESH) < 0) {
> +		if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
> +				rx_bufq->nb_rx_desc) {
> +			for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
> +				rxp[i] = &rx_bufq->fake_mbuf;
> +				rxdp[i] = (union virtchnl2_rx_buf_desc){0};
> +			}
> +		}
> +		rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
> +			IDPF_RXQ_REARM_THRESH, rte_memory_order_relaxed);
> +		return;
> +	}
> +
> +	/* Initialize the mbufs in vector, process 8 mbufs in one loop */
> +	for (i = 0; i < IDPF_RXQ_REARM_THRESH;
> +			i += 8, rxp += 8, rxdp += 8) {
> +		rxdp[0].split_rd.pkt_addr = rxp[0]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[1].split_rd.pkt_addr = rxp[1]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[2].split_rd.pkt_addr = rxp[2]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[3].split_rd.pkt_addr = rxp[3]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[4].split_rd.pkt_addr = rxp[4]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[5].split_rd.pkt_addr = rxp[5]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[6].split_rd.pkt_addr = rxp[6]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +		rxdp[7].split_rd.pkt_addr = rxp[7]->buf_iova + RTE_PKTMBUF_HEADROOM;
> +	}
> +
> +	rx_bufq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
> +	if (rx_bufq->rxrearm_start >= rx_bufq->nb_rx_desc)
> +		rx_bufq->rxrearm_start = 0;
> +
> +	rx_bufq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
> +
> +	rx_id = (uint16_t)((rx_bufq->rxrearm_start == 0) ?
> +			     (rx_bufq->nb_rx_desc - 1) : (rx_bufq->rxrearm_start - 1));
> +
> +	/* Update the tail pointer on the NIC */
> +	IDPF_PCI_REG_WRITE(rx_bufq->qrx_tail, rx_id);
> +}
> +
>  RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_single_tx_queue_reset)
>  void
>  idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
> @@ -1506,6 +1558,13 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
>  			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
>  			.simd_width = RTE_VECT_SIMD_256,
>  			.single_queue = true}},
> +	[IDPF_RX_AVX2] = {
> +		.pkt_burst = idpf_dp_splitq_recv_pkts_avx2,
> +		.info = "Split AVX2 Vector",
> +		.features = {
> +			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
> +			.simd_width = RTE_VECT_SIMD_256,
> +			}},
>  #ifdef CC_AVX512_SUPPORT
>  	[IDPF_RX_AVX512] = {
>  		.pkt_burst = idpf_dp_splitq_recv_pkts_avx512,
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
> index 914cab0f25..256e9ff54c 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.h
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
> @@ -197,6 +197,8 @@ void idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq);
>  __rte_internal
>  void idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq);
>  __rte_internal
> +void idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq);
> +__rte_internal
>  void idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq);
>  __rte_internal
>  void idpf_qc_rx_queue_release(void *rxq);
> @@ -249,6 +251,9 @@ __rte_internal
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
> index e228b72fa5..c2f41db9f6 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -482,6 +482,144 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
>  	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
>  }
>  
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts_avx2)
> +uint16_t
> +idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
> +{
> +	struct idpf_rx_queue *queue = (struct idpf_rx_queue *)rxq;
> +	const uint32_t *ptype_tbl = queue->adapter->ptype_tbl;
> +	struct rte_mbuf **sw_ring = &queue->bufq2->sw_ring[queue->rx_tail];
> +	volatile union virtchnl2_rx_desc *rxdp =
> +		(volatile union virtchnl2_rx_desc *)queue->rx_ring + queue->rx_tail;
> +	const __m256i mbuf_init = _mm256_set_epi64x(0, 0, 0, queue->mbuf_initializer);
> +	uint64_t head_gen;
> +	uint16_t received = 0;
> +	int i;
> +
> +	/* Shuffle mask: picks fields from each 16-byte descriptor pair into the
> +	 * layout that will be merged into mbuf->rearm_data candidates.
> +	 */
> +	const __m256i shuf = _mm256_set_epi8(
> +		/* high 128 bits (desc 3 then desc 2 lanes) */
> +		0xFF, 0xFF, 0xFF, 0xFF, 11, 10, 5, 4,
> +		0xFF, 0xFF, 5, 4, 0xFF, 0xFF, 0xFF, 0xFF,
> +		/* low 128 bits (desc 1 then desc 0 lanes) */
> +		0xFF, 0xFF, 0xFF, 0xFF, 11, 10, 5, 4,
> +		0xFF, 0xFF, 5, 4, 0xFF, 0xFF, 0xFF, 0xFF
> +	);
> +
> +	/* mask that clears bits 14 and 15 of the packet length word  */
> +	const __m256i len_mask = _mm256_set_epi32(
> +		0xffffffff, 0xffffffff, 0xffff3fff, 0xffffffff,
> +		0xffffffff, 0xffffffff, 0xffff3fff, 0xffffffff
> +	);
> +
> +	const __m256i ptype_mask = _mm256_set1_epi16(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M);
> +
> +	rte_prefetch0(rxdp);
> +	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, 4); /* 4 desc per AVX2 iteration */
> +
> +	if (queue->bufq2->rxrearm_nb > IDPF_RXQ_REARM_THRESH)
> +		idpf_splitq_rearm_common(queue->bufq2);
> +
> +	/* head gen check */
> +	head_gen = rxdp->flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +	if (((head_gen >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +		 VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) != queue->expected_gen_id)
> +		return 0;
> +
> +	for (i = nb_pkts; i >= IDPF_VPMD_DESCS_PER_LOOP; i -= IDPF_VPMD_DESCS_PER_LOOP) {
> +		rxdp -= IDPF_VPMD_DESCS_PER_LOOP;
> +
> +		uint64_t g3 = rxdp[3].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +		uint64_t g2 = rxdp[2].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +		uint64_t g1 = rxdp[1].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +		uint64_t g0 = rxdp[0].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
> +
> +		/* Extract DD bits */
> +		bool dd3 = (g3 & 1ULL) != 0ULL;
> +		bool dd2 = (g2 & 1ULL) != 0ULL;
> +		bool dd1 = (g1 & 1ULL) != 0ULL;
> +		bool dd0 = (g0 & 1ULL) != 0ULL;
> +
> +		/* Extract generation bits */
> +		uint64_t gen3 = (g3 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +							VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +		uint64_t gen2 = (g2 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +							VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +		uint64_t gen1 = (g1 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +							VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +		uint64_t gen0 = (g0 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
> +							VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
> +
> +		/* Validate descriptors */
> +		bool valid3 = dd3 && (gen3 == queue->expected_gen_id);
> +		bool valid2 = dd2 && (gen2 == queue->expected_gen_id);
> +		bool valid1 = dd1 && (gen1 == queue->expected_gen_id);
> +		bool valid0 = dd0 && (gen0 == queue->expected_gen_id);
> +
> +		if (!(valid0 && valid1 && valid2 && valid3))
> +			break;
> +
This looks wrong. It means that if one packet is received by the NIC and
then the link goes down, for example, that one packet will never actually
be received by software.


Driver datapaths must always be able to receive single packets or whatever
number is available. However - based on past precedent - they are allowed
to request that the input buffer is a multiple of 4 or 8, but they cannot
require that packets are received in bursts of a given multiple. This will
never pass any RFC2544 test, unless, by a co-incidence, the number of sent
packets is a multiple of 4.

/Bruce
