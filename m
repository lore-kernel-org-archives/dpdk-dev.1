Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D24C531CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 10:32:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B94F4028A;
	Thu, 23 Jul 2026 12:32:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 71EC84027C;
 Thu, 23 Jul 2026 12:32:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784802750; x=1816338750;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eeS9nfGt/fGtYLkwqfcK5I3ywFDQb4ch0zfsdeSjkY4=;
 b=PLIvDyi05x1mrQi6cYXvFnjuF8rTOr4jl6idw3TVC/lOGsGyj+4PLrGq
 cHaHDONAEp3Ph6mnXCLSoMYZOev4/c3iSyvBJWQL4RpwmbFZRhBMLzioC
 kFhyLD2MnXQrbTiTMzHFCr8Jj2pLI+3z8jKE3VwGJTnpqK1CnwZnhjnz6
 W9ud5UmmiRjJG7p76aQU1SMB+MIlUo0oUUabs1hR3OQ1vshyT5V94Wxkm
 rMYUyWf5JFnDtqULwoTD1PHlPj+0YKS9C/R4n1E7NtfNp7v6cihVjnEzO
 VfE4EujYmV37ldd/imQJ94rFdWlTRON5Zs+5uu5x7iafQAtfI+sQoBSAx w==;
X-CSE-ConnectionGUID: hIB2fUthTWmocFifVk2IXw==
X-CSE-MsgGUID: EHakwz8MR8qbUtgXhhUeBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84433363"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="84433363"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:32:29 -0700
X-CSE-ConnectionGUID: xO5m5spETg+GEtqj2i7gTg==
X-CSE-MsgGUID: bihcuoR1Qjuc49+lPmo9Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="262154418"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:32:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:32:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:32:29 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:32:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvfQOM+4pnW/42Sm8dTaWelYJlWgYDyeS3D+wZfeBqxZfDc2c8dNFed/nt+UNNy4ztExh/Zp3DqZzp55qSFBf/KI7R865u3nnEpRFphQpH3pOK3F4gRLVgJ6Ej42p4+sNxK3u95dYGzceLalzEDEVxOO+LFB1sQONXS3h1TdcEcGJq4WZsFResOxlkUtQnpPAtEQzBvq46GD25wmw/p1TQK4KupeDJPKh3PCCNRGYBMqhgvLAQVQC6AmMj7LqfBtCxzWWBYusdZg/lu6qui9tkjXXMqOgBCqEVk8PwT65R1vtlqoS3qju1reTpMl7/633PH59XHlt4oNTWXI/BkIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PsdhyoT1LT4Tba/3wvYGkhLPQ2mWOdadayExe+uSVU=;
 b=YiACrm+MYG6yeaJL9gD2a1IUBLF2J8isbOt5+mTUuBmHE0i8mMyo/eUI3tyU7CPNmRVDEYLDDUw2MqLRfJiFk07Dfol76t4WAp0WZsKe4WmzoWwF81FfQQuuSLdMaJxmeZlBpzrb/fTkltqWags85hCQ2fyvfZX1Mk8jOmWtQIATOHcRNaQlqWmTnq0jgqJzegD7BY7G/w5lN7an01ScS0IY1/iMXG1KBy+VWiDVp+F9JA7JkbfSM2JR+x4JGyabH0tuFewow21a2ODaz4kB6u/BBEVPtEW5CiWlIOdexPI9tPbL/Hmndt3lEHqrJnlm2GOlzZgWrtY2NNyvMQrz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM4PR11MB6261.namprd11.prod.outlook.com (2603:10b6:8:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:32:25 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 10:32:24 +0000
Date: Thu, 23 Jul 2026 11:32:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sid Ali Cherrati <scherrati1@gmail.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 1/2] net/i40e: fix return value of close operation
Message-ID: <amHttKyBfKqYqTXo@bricha3-mobl1.ger.corp.intel.com>
References: <20260710134639.108129-1-scherrati1@gmail.com>
 <20260715124816.19882-1-scherrati1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260715124816.19882-1-scherrati1@gmail.com>
X-ClientProxiedBy: DUZPR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::12) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM4PR11MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 7035593a-f036-4e4c-cd7b-08dee8a5af96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: pBkdtxjWdXhGx4AEYUARrFTi1U17jzAXt1WFKRDGkvUFSNiSja+yErEaDJ4EoAlnNvvsmnrkPCLl3mcAHi15CS/39deot9lNQF6mMmYAEPbtzhBBD3eRq1gqNT4PXAZ8AmgJ1K3MAPrOYW22Uv3lWXk4OPvCF9ljxOBqwR8XLkwSQdCc7byaG7h/iD2JWfsMEmaRPXAMPiTMjdfcKrRrEm0K+9LlTl3Z+xl/A8p3W9D6HZnsFNry1AiwIpUg4+/ME5ZfRtXwvaU3TgbMpgOhZvP/Cb8I1ozDl616DlGUPt3XcCR+6lPg4r7pIBoXoqzn7xnsA9jJrsF2CpxOT/01zC/H8chDzMUiGQnmvdjDg/gPhwAEsmR+E9g3oF/wsoRbjK8BlsDtIQoI3nIeTFepgo+mCdBwbrHzEYxjRjH2tgKrR+T1jLPgpG3sSQ2wEP4onHMqWEt8Ez/r3NFx9MlDNX1VKByAk1GF6FELnDDrRWm2K8mNGZyPQQ4rvk3hZW/nYUXUuyIiXuCbwHcA7wqAJvwwiDYUi0HlKEiLlfjyXCTvxrDtOY17bIf0IDxKNtq5hCxt1xv42HPQxW3uCEWszL/hAa7HlHTxULKykMlBoNrJRJK68H/oqUDq7UgOkxcMiFMrjtZyFJvaEQP3vV7sFoR+uyVBpxK+Aa232XAgM9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eEmvynWRzd8WiF7YDeTouPF2aIwKi5IBT2a52zY0bQbf4KC6b1eHbpSnMx5E?=
 =?us-ascii?Q?CNWYelh3RBslnNEkd+yvoTvy5n8qnt82jpjaup9fdFlQ8WIz7CE3QAJfosZ0?=
 =?us-ascii?Q?A4+Lacn8XzkA7hzFknkY8cFVXKo1dZQvHpWA+5KVK7uCU361bz5mW4hkOsgZ?=
 =?us-ascii?Q?kDbtFpeYYGDsh9a7XdqnsQeq1taAhs/t/f83otp9WQr8kgxnZuQOS6HMHBGw?=
 =?us-ascii?Q?Hfzg5lLV2zAVyMye9kKEg9r2Y0krGhPB5iqoZTR4Cg7wl8q7CNGw9FCsFu+j?=
 =?us-ascii?Q?WYxE7KchdvpiDy+fmAUF7m9jyhcL0QP+KhPRlrSJz6tKCzL94vDY6h6Bo1VB?=
 =?us-ascii?Q?jAiE+Feqgty3Kgnm4dr2QQR4A3ECDJTJ+kabkV1o9DiCoYY0VOXxnqCUrapv?=
 =?us-ascii?Q?Ok7pYovGyjtkQKQBfN39BfZ1MjiyUIEVgRjpjwaw4OusZNY/wdquOgZjbMfa?=
 =?us-ascii?Q?1nPliZGqtWELWueanMAemv7Q5dibxd9pGF95N5bQPF7uOCmXOiojmNh9QiLQ?=
 =?us-ascii?Q?kS+wM954QTNaQib7gvP7rGYiLSPEK2pYo/YTYlMQui1/ugA/TvxK2jRU/Tes?=
 =?us-ascii?Q?TKyabx1HiDBdt883lS/TTmwuJqvMgfLEQA2SYIsnYZBQTZvd2AJc5yhmERe0?=
 =?us-ascii?Q?k0CSxXrrUrLK6C39F6HKxTHgBk6uhY+YZrwDT6rYh2tv03KlgPjbF2vhK1by?=
 =?us-ascii?Q?+L4kivjNzRGKVWl2p85Q8Zuja1qmMQ9EIK+YbfNO6aqhPqWgeq2VDIt1HVvG?=
 =?us-ascii?Q?rF956AzmY4zPmFcJyA8H5VVXfPLwbXMQ86GKEX/0LphrOyFkyARygHInspqL?=
 =?us-ascii?Q?1lARduH12mUlEMd2fegQXUBwjV5XsNf2qrpsVFAaK0z7mPiRW7aYmwWsYLfo?=
 =?us-ascii?Q?Q5bkBRKzRGbi1lfNkXSURwTzc0lx04JzZXPcyQxcrDO5D8/Um0UhIZNNfTEK?=
 =?us-ascii?Q?y1a/rii9xCJLHSCsuYdUkGNP35kjTxrPiFLIIshCGflexDULzp2wPwW+R7Hq?=
 =?us-ascii?Q?xIIlm/YcF/BjApBaOcoSeDs1eqEKdztX957EmdyDnfo/Acts45bEo7rZsbwr?=
 =?us-ascii?Q?MTCdiEC91lpGnvFbDKStK7IlpeGTJF67HNur921VYda9w+B0bXPxeEfedUoO?=
 =?us-ascii?Q?7FlzCBfphJyHwQ91xPsRV+jtA3QdRgTtZQ5QeIa08t+WrXoaGxc/AcP6O6Kq?=
 =?us-ascii?Q?Zsd1DwR7ijXZfzxw0Hkg1CEfYyXwrMuFpSPI303Bg9eyGCLg0U/irrb0JW/Z?=
 =?us-ascii?Q?MGSB9daIZ+v463zgxKr8cQqNXwsfb/q5h91EV0Ucmx4gQT1FHDLDnM4vkAtI?=
 =?us-ascii?Q?BsCB+gB9069GLVyK1s/LOfQlAjtDUHMUwMKefxZYYNbdX5XkbpGbUnUBGh0R?=
 =?us-ascii?Q?+cMjtcjYUpXe4Varl4EuWcf5H5hnHmA8/k9rMVX7i7f4onbn56rwzZnn9lp6?=
 =?us-ascii?Q?J/dRLzHOeNHqz0gIJcy7F8yvORnTG5/7wgYKF7O3gKF7FElMrbMCJaoKXxPj?=
 =?us-ascii?Q?iRqkDjaj0j+PqUVMfqnFlBmckcOLA/TMt7ou0gcQMKFncNza8CMD49NzHL0o?=
 =?us-ascii?Q?Naf7A0OtAyosCJUHDfvEcNEDPp5K/+wzgAtOpZlYW3r0bQF/dvgggoSJGzFL?=
 =?us-ascii?Q?0tx19acFWKjgWGN+Tv2U1uTGiADe/T23fAxINrF7KkujZxtHSbFxXD0hPk7D?=
 =?us-ascii?Q?McN33oa4hLWx9ENc244EsGD9Zk5CUMtT0r5bGSj+WOlax4x16JY/JJYUl8sR?=
 =?us-ascii?Q?fdqz5FLXB7JiQ/iyFhGyjEOjw4/qSXY=3D?=
X-Exchange-RoutingPolicyChecked: akI/3Jv327Y2xq75lr6FICLDnvq9GffOyE86YpxM1hjj2DG46U/R6NV2ypRt3Q2+e9maKxPQ49DbJof8xazXUC4UQPVJUWcLqC1WIMeAIEMMfXTIJJShLWCj+J42lF65fGl6fWKLq51+wwPtkRiGyo7FZItXB5ycVUFi0KwbagEMf+TPvDXgjynZJwERh1XHk2ON9cfJ8892Fwb1LMo0BUtrUEYLlb9hSUcuq8maFHRUDxXQh4YFV6scuc8P5qjpYMlO4snqaytTQGgFnhONO8XY3lc0bXWln/gE1sEdAJV9KdFA+yW//ERLjyxLN82/iytQBpbzfEtA0QtJ7croAA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7035593a-f036-4e4c-cd7b-08dee8a5af96
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:32:24.8754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQq3qsJto2XcUzXrXzwrVoznQuJimYXfNUVj3yTaQMDpWy604uV2PZhx2LCCRc3dZpx59n8oPCFzkG40pqvg83lbcLG7WwTKv7G7Vw/aAUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6261
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

On Wed, Jul 15, 2026 at 02:48:15PM +0200, Sid Ali Cherrati wrote:
> rte_intr_callback_unregister() returns the number of unregistered
> callbacks on success. Since the close operation started returning
> the ret variable instead of 0, this positive value leaks as the
> return value of i40e_dev_close(), so applications checking
> rte_eth_dev_close() != 0 treat a successful close as a failure.
> 
> Use a separate cb_ret variable for the unregister return value so a
> successful unregister never clobbers an earlier error stored in ret,
> and stop retrying once unregister fails with anything other than
> -EAGAIN, since those errors are not transient.
> 
> Fixes: 62024eb82756 ("ethdev: change stop operation callback to return int")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sid Ali Cherrati <scherrati1@gmail.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v2: use a temporary cb_ret variable instead of unconditionally zeroing
>     ret, and stop retrying on a non-transient unregister error, so an
>     earlier error is not lost or masked by a successful/failed
>     unregister
> 
>  drivers/net/intel/i40e/i40e_ethdev.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> index b6b2d291ee..b5457bcf2e 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -2693,6 +2693,7 @@ i40e_dev_close(struct rte_eth_dev *dev)
>  	uint32_t reg;
>  	int i;
>  	int ret;
> +	int cb_ret;

Since this value is only used inside do { } while, I think it's best to
just declare it there. Will adjust on apply unless there are objections.

>  	uint8_t aq_fail = 0;
>  	int retries = 0;
>  
> @@ -2761,14 +2762,17 @@ i40e_dev_close(struct rte_eth_dev *dev)
>  	i40e_pf_host_uninit(dev);
>  
>  	do {
> -		ret = rte_intr_callback_unregister(intr_handle,
> +		cb_ret = rte_intr_callback_unregister(intr_handle,
>  				i40e_dev_interrupt_handler, dev);
> -		if (ret >= 0 || ret == -ENOENT) {
> +		if (cb_ret >= 0 || cb_ret == -ENOENT) {
>  			break;
> -		} else if (ret != -EAGAIN) {
> +		} else if (cb_ret != -EAGAIN) {
>  			PMD_INIT_LOG(ERR,
>  				 "intr callback unregister failed: %d",
> -				 ret);
> +				 cb_ret);
> +			if (ret == 0)
> +				ret = cb_ret;
> +			break;
>  		}
>  		i40e_msec_delay(500);
>  	} while (retries++ < 5);
> -- 
> 2.34.1
> 
