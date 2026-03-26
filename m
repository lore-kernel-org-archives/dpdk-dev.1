Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D47F10A62FF
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 14:55:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F5E240297;
	Thu, 26 Mar 2026 15:55:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id A5C0240274
 for <dev@dpdk.org>; Thu, 26 Mar 2026 15:55:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774536912; x=1806072912;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+x5fAK8yAFrn1q9JnEvQqLFiVqJxsTSfQjvfGdQAdUQ=;
 b=GeZ/8JmdZi/j0mAZ0c7NgFRmfd79bnrPmazMHbryyPR8bSlz1CSj12Ph
 6FZfgbw97ZpqE75dIPBkhHP5HoHHWNC1bKHg3w6YV4WjDgPeAYe5WhqyG
 vGdnfkFAZLKedKnQPen7IYIxnFbHLQId62znbMvwXo0cARQ8iPUZFB7Aw
 q6FLd8lHPf6vvkS7taNo35kF1+yWHcYok57c/nuO6qk/rZ3IRG53/nnvI
 osINNlo9yIZfwEIIQtbmTgVQMJp8pHaPF7P1ZkBFKu2UDo1d2XB2mBVrz
 HNrv+tGpPG24hrb8Qyvi51aKc/KJIWR5BymTMwHcaTm+VgVGFRfUiOBk1 g==;
X-CSE-ConnectionGUID: rHJUaoDYQZG2EzGmNVj98Q==
X-CSE-MsgGUID: KQ8zrPErQvykBcnYo9wDyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="92981979"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; d="scan'208";a="92981979"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 07:54:59 -0700
X-CSE-ConnectionGUID: nLfb3031S+SegmDerN3wzw==
X-CSE-MsgGUID: 0rCRFkpDTDSiAn+ixrLJkw==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 07:54:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 07:54:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 07:54:57 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.40)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 07:54:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbEy2ANL/NDCi4W/PCeNjPSJWkQd16h/PsXexc7orp2KJAGBS9DbIGvNa3brkvoHz4THNfH2GPxsIsqCG8RiZ3DPZXFmBFpaboCk0EHySwx+PWkbJB32QM3KBUGcqc3FsYZTaudR40EC8Q8hlE300d2oPTWL3Ao6NtgO8JQHE6DgvQsIeK5PTwojLQ0b5UrARqtZwTmwkjP359dHi5KyrqQpnZub5OG2DvzV7CuA0B9yNl5FvkqRLDgeJof3hkVazGtTUDUAdfbMmndUvKgfMKqlUCw3K1RELkFcP/phJmiWw78WukMRg22Veku24K2hO+E8SsHVTVy7H/ztQ+nNMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K551YOP2Rv/CDuNL81mHzvqtMPJTh96u46ZrLSqtRG4=;
 b=E+dQT3zjj/iO2xJvY7FMxreJ0Q23ph47ezWrB5MXBKGkn4yNUAZkOa8++TpOIpv8bmQjmGFG9S57N6uV9rV5aeYMQNnk+8XxeQO35V1fq0hfPOg3JrabBgC/Ils/es0sHJEyLsDABzmrwyjXH9uAq2JaOGLwWg6sx8bGCgJiFa0x1Wkd1N8MHjTeBhY+8KxIv7d2E2G6Rg+2fuliIHxW1/i4h+YWv+2XbY/p7kIb/USc5DUStQOtX6z3JjK47vLWm9TwNkiOSLWiQ1hNhNzsOBBqwABA9Xmf9ga6+TfawWL3bHVf/rG/T+QuwyDRKgUoYfK/CwcENcclkNcFspLkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW6PR11MB8340.namprd11.prod.outlook.com (2603:10b6:303:23e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 14:54:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 14:54:46 +0000
Date: Thu, 26 Mar 2026 14:54:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: hailinxx <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <john.mcnamara@intel.com>
Subject: Re: [PATCH v1 2/3] net/i40e: updated i40e latest recommended
 matching list
Message-ID: <acVIssIyrsGgNtrY@bricha3-mobl1.ger.corp.intel.com>
References: <20260326005407.623302-1-hailinx.xu@intel.com>
 <20260326005407.623302-3-hailinx.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326005407.623302-3-hailinx.xu@intel.com>
X-ClientProxiedBy: DUZPR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW6PR11MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: ef699a82-79b5-41b7-8362-08de8b479f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 6Ly98WVWtFAwhhzlDx9Eru/SRa8pNSOBxgpyGLbzuyPbWhoQhulh3KrT3ufFkDrY25iFhfkBcS5UGzVuE6yFXRdYmb7KfoiNkLXHoKZVknMx9kM65/kJJ2Dx9V4rZvn6vWXcKtf/EWySh1z8oeKpBpQ4KDFZ6ra3cXicy3qhpOgg4jIwBdSxvrIEewPNhkUDvvJAHjLIgP2IuaWdoI7uW5dRw7hXnmZSk2lQVaR/qTP3AfT0Q6Eb+rrGuOm5hys8kNYP3BRyGiBbyAeEt0qJUURYgQS4vOgpe+AB8dIskKEKj4kp+n4sF9Pu8mwCwDBWzIWIh1wG6EMIXHIoIfLYR2mxumFtOX4oV4dwxdfFvJHZ1z9RX7nO29jcFoZg7itnMfGAxKSV1Tf9odIwxRpEbK9WcJpqRZSAU2Z2hSB12RiF/wc+HO67N6KwRQeIeZ7UM6kdTB9pLNYMjUmjdZuJyZPHPANFOwAN1oYEK8NnS86L1srUDoqmHr4rAxm41TBwkyPFN358v9S/yQHOxXAFNMTCfUdlj2dRI3Lxrz595igH5mvc9gM+LS0z+d5mGiOL8i0zQnmM9zG/1XWxpURs8aKiDYl5v72hGi54+EepJhyBOkCTXXQl9jlugp1h4HyFaFHm6e9iU8FMLld+k7sqR9xZeelQ1uJjc5uQdw8RMO0rOpHZWLs45R5DpuLbc6/BvPdWBxcjj5hh7xCZmc5DzCk+kEln/1WDV8SKAR1Nf4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+M3s68Fwif5DvpFgPt48YrJVV5+0LuboX2HFThUjvM3jBPp5RPlwEH6Hjj3m?=
 =?us-ascii?Q?3TwKYZ3nDlK64XCbFCGn1ro2jmhXnHUlvbNRQuocywK2eeB8gQnnlh1s4gww?=
 =?us-ascii?Q?DmAS8nS7yE15HMxjCvRfSD1t4VTH6XSsGpIT53X/hIUYxVXTuZGR0ggYKiLH?=
 =?us-ascii?Q?2XhtU5FvPYiIwTX3wIt82izJTqktDA/0RJtMp30CrNWpnuUoy+Hyr6KqoZfB?=
 =?us-ascii?Q?9d3T7lebDkDb1gNXff/JsoI+ZiiP0qZnMiOaSSh5IgOdTHwsyh2GkZf5ByTD?=
 =?us-ascii?Q?+68kpsxehJpTvBOp6LMevJ/nxeSdH7/yH4pbxrTZ4TMYAmEmgtII1XmUTEVf?=
 =?us-ascii?Q?H8xnTJjn1YEfGE7n44BtCtyT8U7aD918UCmKycOHE8l4JqPqCnYJLVXJlUs6?=
 =?us-ascii?Q?8d4H8fHE7u8WyCH7AA1B9+tjBt8T/ugVMLX33hrg45QLDwsu3BJ46nuQ5XEz?=
 =?us-ascii?Q?yIK7VQ408x8ZXOGpx4kZuQ5V3YZpulMQXU1Pv+k0oZI/W7JZvkeIp7zJyDSP?=
 =?us-ascii?Q?QYKyhE6z2IX57547ZPcUEe8QHe2aofjLN3H3IgpJfxdZZmt+Yy27GyQUTtlY?=
 =?us-ascii?Q?ve0qCzof59rRF2X88mJviwYiErcfmr2a7atMhdWuRRWDyZ7Ccbgy4nvTPNoO?=
 =?us-ascii?Q?n4eIlKPjE03SnJvfGZW4yOT04BlV+Sd1PS+j1dl2XneqL74gUvfI8O0Ilj0O?=
 =?us-ascii?Q?V2in+kTRmcaR9H16rTf3ko+JpljqxEzvNNlg5LMuWpi0lfNIpuitoILt0KAr?=
 =?us-ascii?Q?AbrcTmMAIFmnhUpxniXp9KqAqvcsbrdjcdv2pRUXBjgX86vBap3APfGyfQQN?=
 =?us-ascii?Q?6maK6E8tED4p3Tsov1IMpfsEwRQ7AGpi5tFLIUHiBK0a0kCia0uLWi2xPlng?=
 =?us-ascii?Q?f7LBvbmkXcbPf/5UrWC6/Nym/0d5RtFwYfBuHSIdG/IMCLaP0YuSWdYkp13L?=
 =?us-ascii?Q?KfUfF+Up5P8eewuCq+aZKvFfDsNaGgeuOjLKTvQlOQ2y4Wa5ZsDsgNtvZ1Hx?=
 =?us-ascii?Q?BFNwsoKqsYihYdSPZ8dDOtodkThMTZQPKMNq746irp2eDq66PpE+JeGu9/v1?=
 =?us-ascii?Q?aK9YuhshJ2YA91HOzvmidTiB0LeugYrlgsTmsak+VP/0qfjVI9DopID9Zl1c?=
 =?us-ascii?Q?6rLnHzyFbXqxadVWMpHToo2QR3C3AAxqtqAoWi2CFb4Cc/tRnqbGMPn1/qJ0?=
 =?us-ascii?Q?3ws8MeVIWhwCgvcaprimwjKxH+RhA5oWHG7YHzpoUdFuDhSGgsaIniNEz94o?=
 =?us-ascii?Q?wK5cMHHo/5kCD325O4hTaoDFTTpf2kkUzkhJRb38eX05rdyQ+m4wd+YTxHYi?=
 =?us-ascii?Q?HCs7frJuwMCRhRL1FKcK6sDysuS7/PdB88xoy/Id6gy1sOrCk6oyp/yl7etz?=
 =?us-ascii?Q?Emtv9wEkhAb16Af0/wUfbKxCxrCCSdgEf355geDLA/QdWm0Fb8so7bEob0Sq?=
 =?us-ascii?Q?C2nB1jgNJ+HNG5SQMqgQPpVWm0xzNExLxOGDD9K4acc+feGJXSrOlAWiTcY4?=
 =?us-ascii?Q?Sij+3I83x+UGnLfgVLVSf2ofpJuYOC6GU8fLnddW8j/45DKCeTgSCmXaRNk+?=
 =?us-ascii?Q?abBXXKiemx3n31Ohcb25wzobeU+uR2HSRhMkM77ioLNs/daS7r11manWQVrR?=
 =?us-ascii?Q?cBiGqRDh2Ujafr+5GiGziPSueeg3LQ1LeKhWwo7ThE1rGD7TpcjcL03Nn564?=
 =?us-ascii?Q?YsO6FbjcA/QAYnT3qEYPP+nrW+CAWFerDODt6ASFmcPdJQ1tCmL4T48pPHfA?=
 =?us-ascii?Q?B6HFmcEOANnq4BmtUP9x0u4phFLE3hg=3D?=
X-Exchange-RoutingPolicyChecked: jYdJ3YA6yhJcCyOqE0mWu6EAuTDWh/lqZp0aDzd5AUp0rFTBRGT6UJUefzoNOd65cvil4R4dqCTl9T0c4+EKEYRP+z40kw92glmK17Q6QDwuKdXy0ob/69SYBSDdlc0jevfHzjbiddrRsuAUiqz38/ZeUozeuVI9tdowvuFXW1ykSJJ12CJhtP9nNoTXb4kxy+mKTT8VRpQ/UKs4iCNq9L0u4bOwlMuEb6XDGqtfdSPNC+9l/ADppPGlGBHdnSnVhHeV6kqd6fbHr82QTD3cD4Z+CsAk1sNMGPVHNcDF9nMI895XT/DTU3ZLJqsCHlVTDO9/3aTr7oS+s0aNvQ5VlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ef699a82-79b5-41b7-8362-08de8b479f78
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 14:54:46.9494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /x4dzQ1+2mIPZJWr/i0wjYrVtX50a08W/9T8PCk9gns0NCELZ/PItfEZY0ebj37VsU4xlttFfLOjPigy4Yhy2bL1+W8YSHLjA93Rx6rg+lE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8340
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

On Thu, Mar 26, 2026 at 12:54:06AM +0000, hailinxx wrote:
> 1. Reorder recommended table
> 2. add 26.03 recommended version
> 
> Signed-off-by: hailinxx <hailinx.xu@intel.com>
> ---
>  doc/guides/nics/i40e.rst | 52 +++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
> index 0c52807f26..a057db865c 100644
> --- a/doc/guides/nics/i40e.rst
> +++ b/doc/guides/nics/i40e.rst
> @@ -104,31 +104,33 @@ For X710/XL710/XXV710,
>     +--------------+-----------------------+------------------+
>     | DPDK version | Kernel driver version | Firmware version |
>     +==============+=======================+==================+
> -   |    25.11     |         2.28.13       |       9.55       |
> +   |    21.11     |         2.17.4        |       8.30       |
>     +--------------+-----------------------+------------------+
> -   |    25.07     |         2.28.7        |       9.54       |
> +   |    22.03     |         2.17.15       |       8.30       |
>     +--------------+-----------------------+------------------+
> -   |    25.03     |         2.27.8        |       9.53       |
> +   |    22.07     |         2.19.3        |       8.70       |
>     +--------------+-----------------------+------------------+
> -   |    24.11     |         2.26.8        |       9.52       |
> +   |    22.11     |         2.20.12       |       9.01       |
>     +--------------+-----------------------+------------------+
> -   |    24.07     |         2.25.9        |       9.50       |
> +   |    23.03     |         2.22.18       |       9.20       |
>     +--------------+-----------------------+------------------+
> -   |    24.03     |         2.24.6        |       9.40       |
> +   |    23.07     |         2.22.20       |       9.20       |
>     +--------------+-----------------------+------------------+
>     |    23.11     |         2.23.17       |       9.30       |
>     +--------------+-----------------------+------------------+
> -   |    23.07     |         2.22.20       |       9.20       |
> +   |    24.03     |         2.24.6        |       9.40       |
>     +--------------+-----------------------+------------------+
> -   |    23.03     |         2.22.18       |       9.20       |
> +   |    24.07     |         2.25.9        |       9.50       |
>     +--------------+-----------------------+------------------+
> -   |    22.11     |         2.20.12       |       9.01       |
> +   |    24.11     |         2.26.8        |       9.52       |
>     +--------------+-----------------------+------------------+
> -   |    22.07     |         2.19.3        |       8.70       |
> +   |    25.03     |         2.27.8        |       9.53       |
>     +--------------+-----------------------+------------------+
> -   |    22.03     |         2.17.15       |       8.30       |
> +   |    25.07     |         2.28.7        |       9.54       |
>     +--------------+-----------------------+------------------+
> -   |    21.11     |         2.17.4        |       8.30       |
> +   |    25.11     |         2.28.13       |       9.55       |
> +   +--------------+-----------------------+------------------+
> +   |    26.03     |         2.28.16       |       9.56       |
>     +--------------+-----------------------+------------------+
>  
>  
> @@ -137,31 +139,33 @@ For X722,
>     +--------------+-----------------------+------------------+
>     | DPDK version | Kernel driver version | Firmware version |
>     +==============+=======================+==================+
> -   |    25.11     |         2.28.13       |       6.51       |
> +   |    21.11     |         2.17.4        |       5.30       |
>     +--------------+-----------------------+------------------+
> -   |    25.07     |         2.28.7        |       6.50       |
> +   |    22.03     |         2.17.15       |       5.50       |
>     +--------------+-----------------------+------------------+
> -   |    25.03     |         2.27.8        |       6.50       |
> +   |    22.07     |         2.19.3        |       5.60       |
>     +--------------+-----------------------+------------------+
> -   |    24.11     |         2.26.8        |       6.50       |
> +   |    22.11     |         2.20.12       |       6.00       |
>     +--------------+-----------------------+------------------+
> -   |    24.07     |         2.25.9        |       6.50       |
> +   |    23.03     |         2.22.18       |       6.20       |
>     +--------------+-----------------------+------------------+
> -   |    24.03     |         2.24.6        |       6.20       |
> +   |    23.07     |         2.22.20       |       6.20       |
>     +--------------+-----------------------+------------------+
>     |    23.11     |         2.23.17       |       6.20       |
>     +--------------+-----------------------+------------------+
> -   |    23.07     |         2.22.20       |       6.20       |
> +   |    24.03     |         2.24.6        |       6.20       |
>     +--------------+-----------------------+------------------+
> -   |    23.03     |         2.22.18       |       6.20       |
> +   |    24.07     |         2.25.9        |       6.50       |
>     +--------------+-----------------------+------------------+
> -   |    22.11     |         2.20.12       |       6.00       |
> +   |    24.11     |         2.26.8        |       6.50       |
>     +--------------+-----------------------+------------------+
> -   |    22.07     |         2.19.3        |       5.60       |
> +   |    25.03     |         2.27.8        |       6.50       |
>     +--------------+-----------------------+------------------+
> -   |    22.03     |         2.17.15       |       5.50       |
> +   |    25.07     |         2.28.7        |       6.50       |
>     +--------------+-----------------------+------------------+
> -   |    21.11     |         2.17.4        |       5.30       |
> +   |    25.11     |         2.28.13       |       6.51       |
> +   +--------------+-----------------------+------------------+
> +   |    26.03     |         2.28.16       |       6.51       |
>     +--------------+-----------------------+------------------+
>  

A couple of requests for this update, please:
1. Split the rework of the table into a separate patch first, then have a
   second patch to add the 26.03 line item.
2. When updating the tables in the first patch, drop all non-LTS releases
   before the last LTS one. So the only non-LTS displayed should be 26.03
   IMHO. This will make the tables far smaller. [For 26.07 you can add that
   as new row too, but when 26.11 comes out, I'd suggest removing the other
   26.xx entries as they will be unsupported]
3. Final, biggest change - merge the two tables, as they are identical
   other than the last column. Therefore, rather than having 2x 3-column
   tables, just have one 4-column table, with, for example:

 +--------------+-----------------------+----------------+---------------+
 | DPDK version | Kernel driver version | Firmware X*710 | Firmware X722 | 
 +==============+=======================+================+===============+

/Bruce
