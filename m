Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AD6C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 15:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 512EB402AD;
	Fri, 25 Sep 2026 17:02:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 5A5E440294
 for <dev@dpdk.org>; Fri, 25 Sep 2026 17:02:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790348558; x=1821884558;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yJykbXzbC/LlUfErJJ1tOwtVMnV340aM1IWeVr43pVA=;
 b=Yq7V5vxMZjqjLheSE9swWtywVeZ4hMNBQWtYLocSxWgzqRWcZFxT/tiv
 40CPfFragNGqiwgPKZEl7B2UjYTKPvrtve9JMV3AdQywPpNBcAVBno1Fp
 ThA7AezVkxrP/SKmBgH8+uoqcVIuEW6xvoLTAiKkI4oQgLu+eZ0X1LaGz
 uKAR41aibUyjobJGeiqrRvGd71bSllX+68S8Xu6rFQRMw4+GzpFFbnVFw
 uhk7wGrGKLQZSRnJOz2by9CkmdZNefIJtofzVhVNazRC261moLGz/AbPo
 hsG9MnHwl5i9MwZufUl7AMgwYYwUf1NZ7+WS97Y42HH0Z9oHw5OasmGp0 Q==;
X-CSE-ConnectionGUID: TnYyMq8sT0GaRn7tyO+lFg==
X-CSE-MsgGUID: lC0TRdtpSEKgucFy3zs7xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="112920389"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="112920389"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 08:02:37 -0700
X-CSE-ConnectionGUID: c9TMcJVJR6SmT1TEnQXhEA==
X-CSE-MsgGUID: pYBN6JH9RIeuV9luWrc9vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="272163092"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 08:02:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 08:02:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 08:02:36 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 08:02:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoGGCK9hdtyXpdb4zYol/3HzTrmfzej52bw2WGgU/0ViLzrmE1VCr750P7EazG9JAZo4/jFxdyh4+jxNBlVU6mCZBng0AwwWA7pn1hw2w+Ti9yNz+CeE79kXa9HmIolsSNSHXgkGAnPT/Tq78T0CMPgAo+zfopPELcg4eC9uMwPIXcU0iJQ8x8A7U085ocVgFJKzI2WMZTrfgA4k60fQHgUt4kyyVe9gwt0yKuXNjINZJ3SNH69ekxO50ccknFhvKntz6j7BjIML+Yg5fdcBpuSi/RuFpxM+Do8wDdcQ+NWk42abCSVWH91sk2pRog5QgX3wg0dyQhU0bgARMs5xGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agmyVo+kl6wQDILd64q+YKDnJN5XKlw+4AB+K4ytYAU=;
 b=hPN995n/uWB7lF4fPYxXKkcig9Sw62zZpUskAILtQXGrS1SrZzr2ltJmepfv/pKRMkJss6KPfcIqm7bSeGMFpt4vesdR5Y2q9y3B1q+9MsqvivvZ9COXTcssSD/JhSm4xyGEIvHqpjJqJEPGWlnLQj6xq3rq7FXBImuzDUxEml84d4UGU5FgPFzMY+6gbvKLI2r6ZigZIMyJuvxjvrmKoMo7VUpfOZW7ZFwGHJNkcHUq52kOE+xFxzaxPi8GTFIvLXVsh+NJ6fDZm5uKJ5zSoulBGp/80ss7GJ/xoYy4ySn8xiB+9I1WOiXqD1R5Z+eBPhdBLgI+QnnYrN0LYL2iBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 15:02:28 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.018; Fri, 25 Sep 2026
 15:02:28 +0000
Date: Fri, 25 Sep 2026 16:02:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v3] net/ice: support link flow control
Message-ID: <araM_ipV6MgpPqH8@bricha3-mobl1.ger.corp.intel.com>
References: <20260910112524.1547156-1-vladimir.medvedkin@intel.com>
 <20260922182333.2288005-1-vladimir.medvedkin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260922182333.2288005-1-vladimir.medvedkin@intel.com>
X-ClientProxiedBy: DU2PR04CA0048.eurprd04.prod.outlook.com
 (2603:10a6:10:234::23) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1c5420-22c0-47f0-1f96-08df1b1603e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|5023799004|10067099003|4143699003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: goUWhaFO+wnu8n/ulRo10h/MxHy82oqhvodOmnX20bZTwq6XtCauR1FYjF95uioLzTnaRYpvD+1IliJjzc1XJTHDVnxdNsMRe6HFbyDDlIwhhUqXX4+CpX3nuTgLj+OhKWXyjjx8D+OuIBQ14v4NjgSTBJOgdgh/8+pJ8nNrbuWr/niN9tpvGSDY3ij/iL2KtrgzHqMcdI/V0IWAY4oYKxw9LPFB9/kDJufin+nrTlSsMYGkN8VVgMHCMcIKXa8abLwPrKTQISxZk7oqAKdoZoOaDfzhvEIKuNXihZsMBOUIIXDq178QHMLuiXg6akbN5Q0gSfgI58YgtSnHK07lXiJhcwYMgxHJfV4h35pzclb4BQi4BqdxMHryfkzpWRbDwIgIsOOd3eU8H3rwYsMs3KzV/3H0MfdKFKHQGCIBtJccrC3+hwaZ/HOqKv72cdAaUVZAjwH2DvJjBCxuUb4Fc0FvPnRYiy4NcNB6hmu8KMxQKZT/Yr6zGURaqZvA8Bv3/Ck+72Tf4ENVREpvwgMYw5tnI2tUHj1PnJlksOUGaTkbr2a+5sjwr3K25WzlTmoBWu2aJSSlTLhoZSMMbIsX4AvBZ4vtweROGFvVUjf9m0jd7+Q5U5DSdrY2WnU/r3qRff/jlzVg4YkGoIe86VcNP3r9Lg+IOpcjjc3FrE8xwqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(5023799004)(10067099003)(4143699003)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SBS3udJD3yV8yQpjZSr+qwd6HMBf2+rYOfRmB9hrhFw1tOFXKwGGr4dL22J5?=
 =?us-ascii?Q?N2H60lARu45Nwo+gqR9kdQdELCUu9qqronsgJHmg+tXNPKAhXIoP3dHanNUN?=
 =?us-ascii?Q?jFVn+Twr+WszLsMOlaEbUHmJUGIbGuACK/iPwL6wIYSaqtjuMwV00crabFI4?=
 =?us-ascii?Q?FSTWYEFtpx30/4F++2XX+uNdCgFAFKVOyH1fWlwRIHZ6qmSo8xp/J0EDRVpV?=
 =?us-ascii?Q?NAzoBdKmVzVG8it8vG0Bv/VxomW5lepkWabefxSE/bf/v+sf2fsHnl7Rn8KY?=
 =?us-ascii?Q?lXhmAmh5ODPzOvwUkif6OKJ05LPW8SsqdYwAmnR3oZt6HWV+bV4WYIFA8wlN?=
 =?us-ascii?Q?vRLRo2xz246Vf7QiSPHb4JIsIg/vS5ZoUUTiicBK5EDuMIwG0iehHg0FL+Ro?=
 =?us-ascii?Q?9kdh6Qs0HWJ3TKQ47iauVXg7BIT6MH0Izk2Rn8GqVIXJNygwaZc9UyWUhNft?=
 =?us-ascii?Q?TfVZu4G5Abaa90tke0u9zZdsjh19NxDM2W379qbud5zYxeXWwbo4wdqnXh8g?=
 =?us-ascii?Q?SfwnoWlBri/0FHmfTmbq2wG1jJflqRcngWXBAg0yRdeg5m+k0bBj9XIx8sbf?=
 =?us-ascii?Q?IDFrIVaAubUNviUgOXUm859JQD4ybSiUN7ZLBMwiwXey+GnOHzYKepsD59BE?=
 =?us-ascii?Q?6NYlVt6gKkpSrfbIfRp6AUHp5l4BHsslfJtMEdGLISWqyTIvony8NakqfAKy?=
 =?us-ascii?Q?lK+Re3gz1UPLd5IU1feeAhyRNB46V8dJ2MfKijqktxP51AxwGck1kgcDhcAD?=
 =?us-ascii?Q?98/sKPfxElTu6bSCNEilZ7rY6bjhzX7yFqXVh48HaW5/NQSF9gonhdM73tqh?=
 =?us-ascii?Q?Q4NN7+GSAotoNtOXYSweX+PW3/58cTYwXkuYmx9jrowNC8u0+UXJpuMLUV65?=
 =?us-ascii?Q?MDQyN5bkbX8c9jRaMtTo3V+skkrUxJe9xB/LiG/KB84HzGInqJ+AQpDobidj?=
 =?us-ascii?Q?dcN39ZysvSv7S+GLLC7BcOPlJv1q29ZlYIuJNKlR9Umsn0r35AN/ymoNle0k?=
 =?us-ascii?Q?XQ1HRRXlBgIYerZTXEfxuETXwWd+H0JIQ7+hf7gb95oRmnIwhLsGZ9pDOUat?=
 =?us-ascii?Q?P0Y4dvgnDjEsLO+tCLR9pl31HMtJyzk8Bd3PwrYTYugitDP6BkjU0t5i87UL?=
 =?us-ascii?Q?yFGIu9a3u8h/VdCGbTVSDe5yYsqdNdyQ5Knyz2LZ2lEwm3GRNcXD4HL61UeN?=
 =?us-ascii?Q?hFoQQyhoeex7h3govawddp+eQ5Nn+bYCnDnrOmREYMA/ykebekugWlT8uTJU?=
 =?us-ascii?Q?/cYmD2r7gr9zkQctsUWXW7ESLRcpsUAEAjbDC7YmuUYaihuSJdmAvXJeM60X?=
 =?us-ascii?Q?pbZ8awnxwWEiXTg/d81lZs74DDs9mtD7LrW8hNrvRJ/vGbeCSHV0z5o8Cgo6?=
 =?us-ascii?Q?akkoOFqFOtscGbxKXmRQGPw6vUtiZ5i5CcsAqWR/5or3B7pFj9Q81V2YaGEG?=
 =?us-ascii?Q?q1AUH6TbDArhklkWXGVbLchheKBz+ODKtV2/sR0KMlqiGoMNdC7u5pEnTSgn?=
 =?us-ascii?Q?8QyiMUX+neGqVxeAddkXxR+GwZME0pw32FDfUAyo2/z0zwK0oLn1JVnjv/TN?=
 =?us-ascii?Q?/lrjMpH80d1vruv14CUxg4sECY4mX1od4kArYgxLPQFtdfdUEhdNJIm9KMP8?=
 =?us-ascii?Q?72m8nqx9HcyHpmr6UkbElULr9Iu0MXWJRuJ8ApyFOq15xpxffV+9NOY8MADD?=
 =?us-ascii?Q?fVw5syAXmrAOVoJnzH0RFne+elPC5qzCNKQfa9uZwkTjoKcWRwrkkjidUPmS?=
 =?us-ascii?Q?CBYyuPZ1yPQ+lkLyX0N7xSiG9hTIa9Y=3D?=
X-Exchange-RoutingPolicyChecked: RvCArSVPYmvKm6BOGNhSdV0O+n2FsmirU2xENlut6g/pzx6T77WP3lCeSNZu+Q7cxPa/a06WDwEYCN+DzOBSKIULvO7XNQSRPfz0fh7oG3lGU+zjFnQp96hUjdvIIXQbA5JERodMN8UQFFl2IU7Lj9KxkHssgx/T2a8DXHuxAY+Ak/UOgvbAOPWKOvE+jixZqUVpcvOfFVqluHsHGvS7ilEsIr9XLzizfQ0qm1qCQLk62oKVp+UzO1sxyNEvR4ZAxsig6sfR3pHA5OqXxcM+BzcIYxkQO94UxADzMcJbfTlcDTCwO045msqi9IynO4cBY9j3LQhpYLeon82xF1Zz+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1c5420-22c0-47f0-1f96-08df1b1603e4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 15:02:28.1444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBWrmfNdW2mTn2vtAoQ3izRdaOuvjuIdWURTEtAOXXbgRxJYMUDa6VwOQmskA7tWZiGAtTdKRlPwzB7H1CSpWD9rBLocwIl09WC80kY2fdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7989
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

On Tue, Sep 22, 2026 at 06:23:33PM +0000, Vladimir Medvedkin wrote:
> Add get and set operations for IEEE 802.3x link flow control.
> Link pause is advertised only when requested, retained across port
> stop/start and re-armed on link-up. The watermark and pause quanta
> programming is shared with priority flow control.
> 
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
> v3:
> - Address Bruce's comments.
> - Add documentation.
> - Retain LFC configuration across port stop/start.
> - Fix various issues.
> 
>  doc/guides/nics/features/ice.ini       |   1 +
>  doc/guides/nics/ice.rst                |  50 +++++
>  doc/guides/rel_notes/release_26_11.rst |   4 +
>  drivers/net/intel/ice/ice_ethdev.c     | 296 +++++++++++++++++++++----
>  drivers/net/intel/ice/ice_ethdev.h     |   1 +
>  5 files changed, 310 insertions(+), 42 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

One comment inline below. I can fix on apply if you agree with it.

> diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
> index 893d09e9ec..309f691f32 100644
> --- a/doc/guides/nics/features/ice.ini
> +++ b/doc/guides/nics/features/ice.ini
> @@ -30,6 +30,7 @@ RSS hash             = Y
>  RSS key update       = Y
>  RSS reta update      = Y
>  VLAN filter          = Y
> +Flow control         = Y
>  Traffic manager      = Y
>  CRC offload          = Y
>  VLAN offload         = Y
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index b671422ad7..065038a0d1 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -516,6 +516,56 @@ Example PFC configuration using DPDK API:
>     ret = rte_eth_dev_priority_flow_ctrl_set(port_id, &pfc_conf);
>  
>  

<snip>

> +/*
> + * Program the Rx buffer watermarks, pause quanta and MAC control frame
> + * forwarding shared by link flow control and priority flow control.
> + * A tc_bitmap of 0 selects link flow control; a single bit selects a PFC
> + * traffic class. Watermark or quanta values of 0 leave the current setting.
> + * The only step that can fail is issued first so that on error nothing
> + * has been changed.
> + */
> +static int
> +ice_cfg_fc_params(struct rte_eth_dev *dev, uint8_t tc_bitmap,
> +		  struct rte_eth_fc_conf *fc_conf)
> +{
> +	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw = ICE_PF_TO_HW(pf);
> +	struct ice_port_info *port_info = hw->port_info;
> +	uint8_t tc = tc_bitmap == 0 ? 0 : rte_ctz32(tc_bitmap);
> +	uint32_t high_water = fc_conf->high_water;
> +	uint32_t low_water = fc_conf->low_water;
> +	uint16_t max_frame_size;
> +	int cgd_idx;
> +	int ret;
> +
> +	if (high_water > ICE_MAC_TC_MAX_WATERMARK)
> +		high_water = ICE_MAC_TC_MAX_WATERMARK;
> +	if (low_water > ICE_MAC_TC_MAX_WATERMARK)
> +		low_water = ICE_MAC_TC_MAX_WATERMARK;
> +
> +	fc_conf->high_water = high_water;
> +	fc_conf->low_water = low_water;
> +
> +	cgd_idx = ice_get_cgd_idx(hw, tc);
> +	if (high_water)
> +		wr32(hw, GLRPB_TCHW(cgd_idx), high_water);
> +	if (low_water)
> +		wr32(hw, GLRPB_TCLW(cgd_idx), low_water);
> +
> +	/* Update forwarding of the non FC MAC control frames settings */
> +	if (hw->mac_type == ICE_MAC_E830) {
> +#define E830_MAC_COMMAND_CONFIG(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
> +		E830_PRTMAC_200G_COMMAND_CONFIG : E830_PRTMAC_COMMAND_CONFIG)
> +

I don't like this definition right in the middle of the function. I think
it should either be defined right before the function or else, at latest,
just inside the function opening brace at the top.
If you are ok with it, I'll move it on apply of the patch.

> +		u32 mac_config = rd32(hw, E830_MAC_COMMAND_CONFIG(port_info));
> +
> +		if (fc_conf->mac_ctrl_frame_fwd)
> +			mac_config |= E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
> +		else
> +			mac_config &= ~E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
> +
> +		wr32(hw, E830_MAC_COMMAND_CONFIG(port_info), mac_config);
> +	} else {
> +		fc_conf->mac_ctrl_frame_fwd = false;
> +	}
> +
> +	/* Update pause quanta and refresh threshold */
> +	max_frame_size = pf->dev_data->mtu ?
> +		pf->dev_data->mtu + ICE_ETH_OVERHEAD :
> +		ICE_FRAME_SIZE_MAX;
> +	ret = ice_aq_set_mac_pfc_cfg(hw, max_frame_size, tc_bitmap,
> +			fc_conf->pause_time, ((u32)fc_conf->pause_time + 1) / 2,
> +			false, NULL);
> +	if (ret)
> +		PMD_DRV_LOG(ERR, "Can not update MAC configuration");
> +
> +	return ret;
> +}

<snip>
