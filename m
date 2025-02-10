Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE43C0219E
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 11:55:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4080540268;
	Mon, 10 Feb 2025 12:55:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id ED3EE40041
 for <dev@dpdk.org>; Mon, 10 Feb 2025 12:55:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739188541; x=1770724541;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=f6cFTCH3ke2J+tXL+dK8JuD2BUUduk1GaI4gD1fyk88=;
 b=FzOTxBUJu8St1eNOoaVpdqkTtorju8IMbWWNmHKnXGZH6rMQYNNyKbcA
 theelRaqtqRlq00gpiqMGAu/zDPSMvxblFLoV+q/NwT/mMSu7dJyxDK3L
 avCw+wGIHFMsZUbHiHgS6PGTMvCZDEaOh2H7bk0DiZ4uVAVuZALJaRP2N
 V8yiFbicRN5MXYBsLCWN6PWWzxuce1mkQW3yGa/41eMcH8bH2WiT/aWBT
 UOxRmuUHnrDgZ99x+JKaWM0QF/83TGTCEpT9JMgKBw2Y3g6FZjM82EN4X
 Dd/5KPEQqP4bfOgLAzKnbR5ZliI28aHADogoWPb0vQ9P2idzvon63PpFN Q==;
X-CSE-ConnectionGUID: Rcnx/DY4Souoy4iFYSxuJA==
X-CSE-MsgGUID: 4/tmYVGxTPSQB1E020/QnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="62240518"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="62240518"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 03:55:40 -0800
X-CSE-ConnectionGUID: wsHbrL8bRUme8MqbzHOGPw==
X-CSE-MsgGUID: 5OfeXTW2T3GfUXGn5+1uEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116763273"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Feb 2025 03:55:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 03:55:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 03:55:38 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 03:55:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuNzXWBgu5rMDeI+0pMPKwu8Ie0d2zPq+vGBf61c/Z0Kw7MsuGQqKyDey79bP1DLTeAxntsEMO09R6Xm71hxQbSz0sRF0AEYHrwmiwa8XeCm3bRnSHnlns50P47nnbsQj8YwFpw9RIDE7E/X8tAjznyjPV7ZCHnSs9olakEHc1brZYAyL8vX64JesJ/JqfiwyaFDKG99iMHuRmQU7ZQrLHTcTgUqIE3ol1Rus4SFBE/pd17+XDFgsgeJA+ZkSdR/00ht7B9LlCJjxGzr/peMkjX88GXqrQ/HU36MWNKy/k+0XIgGfoqk0xK4W1ZA1p3KVfPbJ6uaKrG4fkB0TlDv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4/+7eywtd7Hs2CFkpq6t94q1yg+T71G6YRepd6diJs=;
 b=Ptvlh+gFyEus1IsLIHNg/XWvfhXulyiFUAC54JS28TiU0d+fpTkxBmKJUpQ3dSMgRwqpDndIsMHROHyOtBTD/hMEvPuFnt40N00lGSK8g6e8HcOwky8egFVr6YJo8MfdE36EAWlMaX6WwOFpQKlRN4NgDSn+3PXwFpgTgt4XL4qh2IJbnWXaMz8aft8ZpcqoRFzYWukCOPk7LxM6fP3XizwxVp1mgJh7yj0zMA5pcE0gB2YnmbqUWr0WhOQJnE0BnHmzW1vuVJp+4PvduhlS16B8vkKKQ3saVrPlqQ8NHbPCJJMmErIAV4UycqaSip/zyJWtj6xvq+4dDmMzc7zGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB8302.namprd11.prod.outlook.com (2603:10b6:208:482::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Mon, 10 Feb
 2025 11:54:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 11:54:55 +0000
Date: Mon, 10 Feb 2025 11:54:50 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 2/2] common/idpf: enable AVX2 for single queue Tx
Message-ID: <Z6npCsFlnhgmUfTr@bricha3-mobl1.ger.corp.intel.com>
References: <20250203052430.1243485-2-shaiq.wani@intel.com>
 <20250203075508.1304702-1-shaiq.wani@intel.com>
 <20250203075508.1304702-3-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250203075508.1304702-3-shaiq.wani@intel.com>
X-ClientProxiedBy: DU7P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8f947f-d906-43fd-4a21-08dd49c9bc17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rD2/3gMBRCV3/NniZ3FfntOEeM+sKbGxhiVY/b9bKkXTHO6MUlB6VFcuKN0t?=
 =?us-ascii?Q?lBjH9oGGhicRW44sqifnhXDdlz9EGt8cQqfwT0Yvc9zz7D1bbShTkzXPitvb?=
 =?us-ascii?Q?ORAm6TXlN9tZ2E+W2Xu3iaYYYJTzdTNjpIasEGVIICbsuxGNlvgHOpBhJfoq?=
 =?us-ascii?Q?gcotGfe7y96E5z/ckLizN/IoHB0WbKVCsEC2hvo2DKTCMxGcQnWmhLEh4b4o?=
 =?us-ascii?Q?PhyMgzhUYvv7UO0eHJfKbqjeLEAWriQae+uhZLPmvUD2gLrOjuAJs2G6DGYG?=
 =?us-ascii?Q?WEU8DxXL9Lq7YzsXpPkG9OZOoaNE5jWUXGEEkGg0S5ZWQI2LdkwC4kuPYuP3?=
 =?us-ascii?Q?YRZbjyzPflkb8Ab7v4BGVux/jyZPgjfbXAeG9ampaYoSjtDq/Sj/Z+OpyYgy?=
 =?us-ascii?Q?UerR7aGQw3Lal9KCfh82jVwUZ3J8GBAlh3Hu1CNok/rMKAedwWSv3cOsAf/t?=
 =?us-ascii?Q?WFYWd0wFFNgnAIuu4SJSzzAOt4Hy+z25kibyiEysryNBd6M4hYWr3N5cVj/T?=
 =?us-ascii?Q?YDqeeT/Kcg/Kct698Qib1BI2ycri1Gd6WtumrSircdUPpPAXGQowUpWsFh7k?=
 =?us-ascii?Q?7D4cWdfyMdrD8Oj6uEl51ITLrc6kpC05J1nsVj13+5EsUceCsmAWAlhojZMc?=
 =?us-ascii?Q?eiAjoMGGf5dfTsgMr5CbKQCPEIb/rCtTjKtLsfWFYeki6P6uPUXOWajRyYVA?=
 =?us-ascii?Q?CzC/xKWYVowxhp+KOzX/H4MV0OzUFyejJxAwQrdygX7Z+L04pUXKtMEDmPeq?=
 =?us-ascii?Q?ytsJ9Bsef/bV7UsyIs9nvdCaqut60/Xr/aq6Oqe5hIzjcts8S8IpmkksT2E7?=
 =?us-ascii?Q?SeVJoOH8WlR8WktMlLf2d3qe22yTfyxyE0/x6vOScb2LNmQJnxrBFJdVN+W+?=
 =?us-ascii?Q?QLKvI/61IQCQpL2FtGs7mV6VSI2+hAcPGF5axN2rifj3JcmcfMUitSPlRui2?=
 =?us-ascii?Q?0QS9r3TgSKBP3kNA5CeKIfxxtipWXX/BOHgoOjVaUd5nhxCkaJJalzC6QEqZ?=
 =?us-ascii?Q?5Rs/0yMLrgSduNHwYbQYjmhHgUiPKnTnrYmAJZ8rb0QM9rqMYOhV7QfyeVGo?=
 =?us-ascii?Q?htqrbQgh2GeRN7YTiuI0bGOqfzlirTwGptdYp+J0T2deUFben7FLqj9m1tf8?=
 =?us-ascii?Q?jtR0KStl8u0H08Gmiv/vC1M34VbNHBd2Uku7b83fvjbdn9qMBOJkRMR2fJuc?=
 =?us-ascii?Q?kXneT+p4aHiDVAZlag7RvT4ZjD+0S3ElSkVXUF58lbh4njKMexlRxP7dM5no?=
 =?us-ascii?Q?TRDS+0hCUWZ6peMbJHJuQ0NSv9enEYlefOn4hB5Zx2Cz6W50od2IACEazbDt?=
 =?us-ascii?Q?nmhvjDbQUgQ1CUc3jdb4dr+Fqogp1tW7XjVOoj0oy+8178TukjIORtxW9TQh?=
 =?us-ascii?Q?j1VXBRuGn2elB33ZN+UFEApJx6LM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?viEj5iDiEWJmw9bQKgM3UsV/8Lk0MdcJ+IdBCblu94NNDFzrENgBpLdqsA3w?=
 =?us-ascii?Q?wOCGJqYBL+GQ/KAozyoQIcoAEI9K9F9J7EIHbqm5k/uam9Evn12VVmaaARQh?=
 =?us-ascii?Q?kPKEn+JpSCwxDkTV8CxD/WFmulmeIs3411NanVmgHwhGXiHfdSu0AnJ+b4Li?=
 =?us-ascii?Q?tWxwkVL/qh/uFjOJz4V+r5DZfCTZ6BIZzWQQ5lO/neCR4b8k5WGkBiF3MeZA?=
 =?us-ascii?Q?ORby1OIcmWUIx0BKB/3DvbmYwbPzMv8C8XymnStjNAmUWy2jOxRNwSRkrYDB?=
 =?us-ascii?Q?fy4I/hDT7Yv+ex6LbZ9ZVzjdoSyZJCnDd7fuKjHPz8zyA0Oq2qZvPHnafSem?=
 =?us-ascii?Q?NM6ZwqrRMpk6Ih8K+lvnG6Epr2YGyk/6y9y0QcUWrzhBjm7RG5sSKmQ2f6Tj?=
 =?us-ascii?Q?whgYxyvCHHhhsGxug8Das4JPDp1GPcl1woMM6Yq2Dwe80eypw0k9oE9/SPjO?=
 =?us-ascii?Q?iyO8HhRSrKuMJ56Y8DrF/JvjXZJ3Ra/BI46D0pqkGPRoc0OriDXNXNYF3w8I?=
 =?us-ascii?Q?jYlP5uepN3acaqejjL8RcmBjisy9jI0xhoVkvzcnIiUbgiLNKMRqoyFQh89Q?=
 =?us-ascii?Q?7szq9xGlhFNBGGhJOkH2vBK7w8Ps6OFLNJmAd3FKHGNeccmcK8VaJiSo5wmh?=
 =?us-ascii?Q?13GZFx7o7bjl/ecosNVa9j+Tc8+1tXNkvJlnstazpe4daeO+8r2/WZCERmcG?=
 =?us-ascii?Q?FZWIi/ABDJlx7l+Pm5TsFGPiRdlCBnj9ULKlP5AOCakhk6dYOWu9ruJXyXcB?=
 =?us-ascii?Q?RTBKA4CcuUGrv3tbYgSZ8hbal65tVMGHsBQcRfjAnfLBNHjCBdSYbpF+8ptE?=
 =?us-ascii?Q?SloFUPJYjQwinSGZNYkOrjwc2IeuhJ2RYx6jR0ij0YLjlhKCgk33DOIqdTdK?=
 =?us-ascii?Q?de4uliNXHX672mgeaGa9CmRS+i6J/bz7LnQlt/MoFZNDMc0ntCY3UBPILcZ8?=
 =?us-ascii?Q?jTXVQnxT6XpjrNpa7ZZO5kfDly/kBIJ3fC64KLU8g0XIwjadrJibNTM9FEQ4?=
 =?us-ascii?Q?p5IKBmUe38bty8ZN7OuK1uPKqpVA21JWoQeVdQGUenqvRYHMnAz2EcjsGwna?=
 =?us-ascii?Q?t/ysiAqKgEMT5OoroI/a2YALkBwZradubcsuBeuqUMEok+0oe3TShO27Z4W4?=
 =?us-ascii?Q?/etAsuHqdNjMq/gU/iwALR9W3DUTAtc76ocWEinKgXw5YzTwg+lFXFVkuOcW?=
 =?us-ascii?Q?ba789bxybM/sCYDnvJREPCdTH2LwrQ4Dqn7FY80TTx+HTguMAUFt6EDumVvs?=
 =?us-ascii?Q?mRKqbhv/HLjpD+CvHV/mVk06GWpUQporkQf1vyp8FMI/S9DebagjWS7gc4hl?=
 =?us-ascii?Q?11sEH5BvZsBFV1WwUGjSLHMU/Epy9gHbfNhCqVa/4mK0ATA5RsLkedfBEqSg?=
 =?us-ascii?Q?mpEJ0+PEhcj4HYD0KXDjfV5WBzX5Yx7HNOVqbCcci4vs7tovxdx2Ph2U3CjO?=
 =?us-ascii?Q?n3CVGz8qX6ZIkz0J9L+XTXk+7CCRfc/sdd7UNvwtwPtuAtfSBdLQqu3XwqNm?=
 =?us-ascii?Q?5Y0/Bt0k8ycPhw39skkJVnx9yLigW0FuXeTjy5f+DruuOYydQNt2Wto5bO9i?=
 =?us-ascii?Q?MNHwNMwMT2SMH3CWKmx4XYJKx1kDDwxbtDmZoKRUqASiXGpzX8JU1CB6WMr8?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8f947f-d906-43fd-4a21-08dd49c9bc17
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:54:55.1069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iya7Vdb3ajO2gCPYzxa2/gfdYP0CpXDw3KpXK2OZNzilozWZDbFTQlz9eScVAb49XjuemjLzuceoQH2VIiTqCmNe1n/d4EHyQZRZVexdY1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8302
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

On Mon, Feb 03, 2025 at 01:25:08PM +0530, Shaiq Wani wrote:
> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
> 
> The single queue model processes all packets in order while
> the split queue model separates packet data and metadata into
> different queues for parallel processing and improved performance.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  doc/guides/nics/idpf.rst                    |   8 +-
>  doc/guides/rel_notes/release_25_03.rst      |   7 +
>  drivers/common/idpf/idpf_common_device.h    |   1 +
>  drivers/common/idpf/idpf_common_rxtx.h      |   4 +
>  drivers/common/idpf/idpf_common_rxtx_avx2.c | 224 ++++++++++++++++++++
>  drivers/common/idpf/version.map             |   1 +
>  drivers/net/intel/idpf/idpf_rxtx.c          |  13 ++
>  7 files changed, 255 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
> index 0370989a07..90b651d193 100644
> --- a/doc/guides/nics/idpf.rst
> +++ b/doc/guides/nics/idpf.rst

<snip>

> +static __rte_always_inline int
> +idpf_singleq_tx_free_bufs_vec(struct idpf_tx_queue *txq)
> +{
> +	struct idpf_tx_entry *txep;
> +	uint32_t n;
> +	uint32_t i;
> +	int nb_free = 0;
> +	struct rte_mbuf *m, *free[txq->rs_thresh];
> +

Use of these variable-length arrays is no longer allowed in DPDK. The
AVX512 equivalent of this code uses alloca, so will update this on apply to
match that.

/Bruce

