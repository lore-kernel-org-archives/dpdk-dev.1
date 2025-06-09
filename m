Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E592C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 12:53:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAA9D40ED1;
	Mon,  9 Jun 2025 14:53:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3C48F4060F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 14:53:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749473592; x=1781009592;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Gl8t2p+aoDIVdToB7Cif1iPCzyYHIxv7Lc0JQeY0wHA=;
 b=mbD7v+W33QwqAcj/qIGDSykUQCel12vALzfJt3ua7CAYyC5n/yPX4sem
 mKgZDyQsI1IZOL2yL9QgGTmUbjHdG48FG8ca4Myoxa4j4YESeMt5ROdl9
 3635rhXYsOqDAzHwnRigXkJ7AiMlxDeN+nBY+bc6UJVl6J9G6IjVU/nyA
 CHmAQFU2WOytV1zBmlRpYonGgjf94sLqNOPJWPZERAxVJyM18rOwSuNV8
 qsjJMuKhednjdQhpIwaQPc0G6VdMOwOkhYAvFZM+2dvyWdFhoXx97pESY
 YSt8lPbfDFgui381UK0d+9OgeiIV9hiPocjAKIINkwwXYTiJMhtw3o88t A==;
X-CSE-ConnectionGUID: CP4UiFldRE6l5EepXXj1NA==
X-CSE-MsgGUID: FTz9ZIOAR5qhVIqb4B6rPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62903594"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="62903594"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 05:53:11 -0700
X-CSE-ConnectionGUID: Qzvo4URTT7KT92uEiul29g==
X-CSE-MsgGUID: mzVWw8K4RCuq6V3TpLxMeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151660787"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 05:53:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 05:53:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 05:53:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.62)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 05:53:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPFvkzrCCRSt2zJVTlTIUOcVgD5LgdtUq4w8pHqVSAYYd0Bf+OLW91k08oDAcosLzvF+OJXM452K0fxkpnw/psH1JcRh2w1hQyVs7kBJOdv6MfWL/UGU0J2scBc5Zwy5vfMvGyuEVjAt1hOG0Y7oEjwQfEbLIoeJWMYnYuXyyldUL5nX5LoY7vuD+sX88ZcNMUAnhPOQzvvDKuEzFxHsakLyV/RNbRaKzwiU+tTWZJ0tSxozLUCK5CuujkryOGO8P1WbENCLdHpOzChF0e2FmbukvGyhaGmd9i6INqhJ+KVS53YDuv0phElk4ux3EW/zatFyriXOwG1lIFGXhKGy7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E+HuitkWbgte3h5cLtrmtj3Ysf5bBzFpNkr9S2GWks=;
 b=Og7zsoaTYK5R0exVWRvBbONnuWOnLGtLLwxijZgQZitRsWp/V50S17OLh6yS4bGB+aHVx2EcwtBjQt3c1Iz3ZRKTbhgaDfIlyhKN8V5eFyhXcDDN+wBe4IST9HB1lsnClWUiTX+Vlj6bZrarlSnVpBMu6jjgMpoSANEAZZ4VqdAgwSkVc8WCHUIWSpcFqTfSc8NR9YtzBNf56CPgoL6g1Taaj5pVdYehzeHNlwcDoW/9mXOrIhX737WwHnqYcKtpKGw9vn5B1xJseXUlW2ayjZxs6DGCqEy5Yx02ZM9q5R9gkV9U2/RNVSxYhS/uCElttZrniIcFjrmmFzycYmwLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4560.namprd11.prod.outlook.com (2603:10b6:806:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 9 Jun
 2025 12:52:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 12:52:53 +0000
Date: Mon, 9 Jun 2025 13:52:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v3 3/6] net/intel: add TxPP Support for E830
Message-ID: <aEbZIKK0CuMMrOCY@bricha3-mobl1.ger.corp.intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250608113223.487043-1-soumyadeep.hore@intel.com>
 <20250608113223.487043-4-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250608113223.487043-4-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DU7P251CA0030.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: 465bb1c2-1a5b-42fe-889c-08dda7548c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vasacF0ZJFRurdoJpiifMYJoBz0SR5VpxNQ9TPiAS5PgBeqeMsmMvIOvQT+m?=
 =?us-ascii?Q?6XtUZkDN1OMJgeikm1Ph/KzPOPpjab2PuD4JgOocUpzuaMAHBxKEp4uf9g4Z?=
 =?us-ascii?Q?p8viZ4K2/kLFZXjzPRbjpDE5dpbxLm8At+Y2kZv3RxrOk4pRdxprtOBYoCYG?=
 =?us-ascii?Q?NEnqBbUUfeLlzdVYYjRE0GQ8Xn1o4uJSE7wtGsNkGBNtY1E01m9DN12BOvFZ?=
 =?us-ascii?Q?l8ftV6QEpJJh8nfZM5mnZ4ZO+QjnSDkDfJADkCJhnqShg//H5SruOhwhjpoK?=
 =?us-ascii?Q?Jd6yUsG21dyMuWtQ8bUVycRZu84sbi9pPm9gaTztnBNydMOC3k7VGUVSYsKb?=
 =?us-ascii?Q?xHxn+T4EUxJRdtqs7K/BjqjvLyE5so8OWb2ipN3sOfN5bhRsjEaBBBaU60hz?=
 =?us-ascii?Q?eF+tlaCK1qx8IHoxGDd0j1pqmRF/x9vYJvDdAiG+9b2TDYgOomtF85x9l0h4?=
 =?us-ascii?Q?nkOaBBWh8ZHKWEh0MgJQUyl4EGJxLW7lwUHHdkICuQpD1EHOAmyix7QAvgOi?=
 =?us-ascii?Q?dnOMJ9jaq6y8VrVXmaNSaZ1Dnx+uZf/7XMSyLlmL4ZiWb3IIsvKH/jdxjtlm?=
 =?us-ascii?Q?AOXFKH9HJS5gN15DTf77BxUyE/RuLyqFJbASCYjGmXlDAAxE58bf04YCChSs?=
 =?us-ascii?Q?XJaW7ma7/1nqFigN/eVS8hpC8JVeBDKl1ve1TE0ktKcVnc3dIHS25trYsm0q?=
 =?us-ascii?Q?I/xZ8W7g4iJsOfPt54QwDU2rPF+9eKTO9tz6f3gtQONbQtTMuYBsqDEbOrDx?=
 =?us-ascii?Q?Ag3DoQkIzKxxfj1oXFg1OhGIF1JPApOwckcEXT1/7jP0UhTXcr+pBneesIHx?=
 =?us-ascii?Q?WfcDx1a45DcNwbsEKmBzYWjrZBzTpYCirpm493JBZeQNz+iDmxEuhnmygl+O?=
 =?us-ascii?Q?JUw/xtmlGu/oGYVJpiYuwAnMZzJN/kdnykgWTmtpL6VTPhQizVUWkVdavVs+?=
 =?us-ascii?Q?u4Xmxc3xjXCJOMgZzexB3Cm7HLnGJNIgPoAfti9k2r8T4l7UltG2SxCLpPfG?=
 =?us-ascii?Q?tZCMHFZ3yCuBwyUqgz78jDG92kp3Hwiw+/zn6EP9mTBvyYDE20aRY55F9rcK?=
 =?us-ascii?Q?OEdCZZZrRgIS3QhF+ElxxqCm6YKr18ZYH8VB5MuXNfQn6cnuk/hB7UShZ2G9?=
 =?us-ascii?Q?yReNMWVkmHixC1hN+Ebc4l44mtEWEl+PSAGUAc12CdkU/eCsWCqajsHjyJZr?=
 =?us-ascii?Q?eADUxVveV4cd8/Y1nfsqVr9QQvlr9B0hHY2ltq5S2Zu6uV8WxXvUW5YrosoW?=
 =?us-ascii?Q?Ybp0GPftXLLZlafiNXOAmhva2f7sJH3c7Ewdski8MTL2VloYa4Vu8BC3GKao?=
 =?us-ascii?Q?vC2NzaajJUFBvwypCjw26lOE/+MqpRJSuZIhnk/7hPqiNciv48KXb//tukzs?=
 =?us-ascii?Q?KiSCsAqT2uVe458YdMTFqz0rnrGU/Zs/2NWtBbeLfTfsBEhARi1afYauWTzl?=
 =?us-ascii?Q?UcYiOK1A+pg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4fKOAE6fAjhHdATq0R+wTQBrikc8L5owhadyZVXQpdjLLfPBFndvz++or8vs?=
 =?us-ascii?Q?t8WPzPgPXWGI1gl3iZnHQlk7YILAwl4txrvktFKgUxpRXlZeCNXYEVKzn0Gk?=
 =?us-ascii?Q?/boFOM39a6xCQtDRo69LviSzoDRXFFOW2q/3lOURMSqPjmirv6oLh5lPJVVV?=
 =?us-ascii?Q?h7R3shPQ3IarUvEhRrfG3cc66QrTCrSPcmD6BiTGEaTQIAPBQB8Qifx/B/qk?=
 =?us-ascii?Q?GrKtIe3Z1GsVtH8ZbgOpuZzQGnGIZL2mykPG+PMkJ7S48CullkyvWXU+spT9?=
 =?us-ascii?Q?HHD9rPaxILT4VeL+57U2M85sbQNDOgN4HjNYdeOI9AcoMI/UINTnGcbaWKqu?=
 =?us-ascii?Q?31TKuEeL+If1LaMMD433MkJhVY+pHRqXJi289SQLn1+u4q4hEOAytDz6Ezx+?=
 =?us-ascii?Q?XulA40kO9exJsD1EwcSaPVR9xMaG6o8j/qhVbanDVFMnUx2x1CQsQy7zq0xS?=
 =?us-ascii?Q?G3mDt3aaNWE69lovZZAT0JaIvnzzvZ5YyoC7j3i5x7Kl8Yrshv+ptWua0zXb?=
 =?us-ascii?Q?Oh/YHle7x3PNA+Y1Kj11aelfzPeWQB6XtaTHdIJNeEAH4LKDcJH8ESS1ULw+?=
 =?us-ascii?Q?onWCzhabF6csTUZj5i8AGybM/JHYmF5zzUUojU5Gms9YMnC43aRRaLjRKcp+?=
 =?us-ascii?Q?elOivf2uHrxTxZjVPjQ93+iTsdpBhdKSA8fFbSXI9t/yd/gp82PMrvSFnscX?=
 =?us-ascii?Q?lTDtKUxWX5OtmcxFee+L1memk03vpFVB5FKyUAVckOjYOicZleSDeUnu0SP6?=
 =?us-ascii?Q?IZ3+YSkG7wIe5o4cHKDaWHNSZNmQ7DbUJSV0TSC0s7yHBPuV9K5PvWftOHh7?=
 =?us-ascii?Q?F3J3a9QryPe13VoaeLvcyr8IqYcBj6LFR/b2ksnUjmoG+JrSfpLcS/1cetwT?=
 =?us-ascii?Q?MI/8KhEzWONT7BHwHUsWdErp7MqNnZTVhZ+5MFrPpaBk90pJ93TcnY4DL3IG?=
 =?us-ascii?Q?mhJ+Fnsu0XrWDo5/z9vOJGp1HDDAGZyaBbSb/vs++u2Mxd65zrJIm7AIVgiD?=
 =?us-ascii?Q?fZU+ugg/CR8tNWoHEjfBy0gxt4ft5g0k1Xg2FAalwni+FCqY7FGGx1LXaD/o?=
 =?us-ascii?Q?EmZ0li+rHXR+775YiiHvzizfGbKEFj7qfTV9msswlaG5RdJZxI1bCKYiJVXf?=
 =?us-ascii?Q?kKTjpfuavbQbWjdbtxEIX8tBZojzeRuNPwDL4oWEyjcZspAUv3bBtKk9Dq7p?=
 =?us-ascii?Q?/Gc9yXHbkSEHDPExQWmRZMCNy5i2/SRHDhSAZTadlsc99iT0qUMEumvgsVpU?=
 =?us-ascii?Q?6bdoWOcPeUwpIsIeB9Oy4hUY1nfFfLy5nvxlbN0qlGZ7CD81yucSJGrizEGo?=
 =?us-ascii?Q?hXIY0EJ2apjRRWm8MbqIK4qe8W6IkE6ZOhuOuQ7oORv9dJx6AKGr81FKTzWX?=
 =?us-ascii?Q?ZWgqnxxGkZpL/OolxqWh7DmVFmony61M8+2sLQk13OvoPIoeIXOlNHCO8z4b?=
 =?us-ascii?Q?Au9u9022feEeDNMdh972DmLryGeKsrvtv6ipDq06tDVth4JX9wwDEu9LfMaa?=
 =?us-ascii?Q?dHIn3Eqi5f87NCChE4s9TguTu/VKukCDhGZbXOg/whhrYGXmcwFIbJcoRFBZ?=
 =?us-ascii?Q?cAdmml7G7or1Bzhr7PAcRA2vDJLSlbdIemOEV1LvqQkIl6V4XcB5RqFlQqXR?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 465bb1c2-1a5b-42fe-889c-08dda7548c8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 12:52:53.6210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a20dO47VhRbnk2F0LuC/TLyXh59xk6YtO6MPZoE1lSPtBTohFYKt/rr3WsRtsPYccOVvSu/hSYUrO0ZjtVvuBw0LHB0LrzM+Ond0zIkbRU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4560
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

On Sun, Jun 08, 2025 at 11:32:20AM +0000, Soumyadeep Hore wrote:
> Add support for Tx Time based queues. This is used to schedule
> packets based on Tx timestamp.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>

Some initial review comments inline below.

/Bruce

> ---
>  drivers/net/intel/common/tx.h              |  14 ++
>  drivers/net/intel/ice/base/ice_lan_tx_rx.h |   4 +
>  drivers/net/intel/ice/ice_ethdev.c         |   3 +-
>  drivers/net/intel/ice/ice_ethdev.h         |  12 ++
>  drivers/net/intel/ice/ice_rxtx.c           | 232 ++++++++++++++++++++-
>  drivers/net/intel/ice/ice_rxtx.h           |   9 +
>  6 files changed, 265 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index b0a68bae44..8b958bf8e5 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -30,6 +30,19 @@ struct ci_tx_entry_vec {
>  
>  typedef void (*ice_tx_release_mbufs_t)(struct ci_tx_queue *txq);
>  
> +/**
> + * Structure associated with Tx Time based queue
> + */
> +struct ice_txtime {
> +	volatile struct ice_ts_desc	*ice_ts_ring;  /* Tx time ring virtual address */
> +	uint16_t nb_ts_desc;	/* number of Tx Time descriptors */
> +	uint16_t ts_tail;  /* current value of tail register */
> +	rte_iova_t ts_ring_dma;	/* TX time ring DMA address */
> +	const struct rte_memzone *ts_mz;
> +	int ts_offset;	/* dynamic mbuf Tx timestamp field offset */
> +	uint64_t ts_flag;	/* dynamic mbuf Tx timestamp flag */
> +};

This structure has extra padding in it, making it larger than it should be.
If you sort the elements by size, then we should be able to save some
bytes, e.g. putting ts_offset, nb_ts_desc and ts_tail all within a single
8-byte block.

> +
>  struct ci_tx_queue {
>  	union { /* TX ring virtual address */
>  		volatile struct i40e_tx_desc *i40e_tx_ring;
> @@ -77,6 +90,7 @@ struct ci_tx_queue {
>  	union {
>  		struct { /* ICE driver specific values */
>  			uint32_t q_teid; /* TX schedule node id. */
> +			struct ice_txtime tsq; /* Tx Time based queue */

If you change this to a pointer to the struct, then we can move the struct
definition - which is ice-specific - out of the common header file and into
an ice-specific one. It will also reduce the space used by the ice specific
part of the union.

>  		};
>  		struct { /* I40E driver specific values */
>  			uint8_t dcb_tc;
> diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> index f92382346f..8b6c1a07a3 100644
> --- a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> +++ b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> @@ -1278,6 +1278,8 @@ struct ice_ts_desc {
>  #define ICE_TXTIME_MAX_QUEUE		2047
>  #define ICE_SET_TXTIME_MAX_Q_AMOUNT	127
>  #define ICE_OP_TXTIME_MAX_Q_AMOUNT	2047
> +#define ICE_TXTIME_FETCH_TS_DESC_DFLT	8
> +#define ICE_TXTIME_FETCH_PROFILE_CNT	16
>  /* Tx Time queue context data
>   *
>   * The sizes of the variables may be larger than needed due to crossing byte
> @@ -1303,8 +1305,10 @@ struct ice_txtime_ctx {
>  	u8 drbell_mode_32;
>  #define ICE_TXTIME_CTX_DRBELL_MODE_32	1
>  	u8 ts_res;
> +#define ICE_TXTIME_CTX_RESOLUTION_128NS 7
>  	u8 ts_round_type;
>  	u8 ts_pacing_slot;
> +#define ICE_TXTIME_CTX_FETCH_PROF_ID_0 0

This looks to be on the wrong line. The other two defines above follow the
field they apply to, this one should be two lines further down to follow
that pattern.

>  	u8 merging_ena;
>  	u8 ts_fetch_prof_id;
>  	u8 ts_fetch_cache_line_aln_thld;
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 9478ba92df..3af9f6ba38 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -4139,7 +4139,8 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
>  			RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
>  			RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
>  			RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
> -			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
> +			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |
> +			RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP;
>  		dev_info->flow_type_rss_offloads |= ICE_RSS_OFFLOAD_ALL;
>  	}
>  
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index bfe093afca..dd86bd030c 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -17,6 +17,18 @@
>  #include "base/ice_flow.h"
>  #include "base/ice_sched.h"
>  
> +#define __bf_shf(x) rte_bsf32(x)
> +#define FIELD_GET(_mask, _reg) \
> +	(__extension__ ({ \
> +		typeof(_mask) _x = (_mask); \
> +		(typeof(_x))(((_reg) & (_x)) >> __bf_shf(_x)); \
> +	}))
> +#define FIELD_PREP(_mask, _val) \
> +	(__extension__ ({ \
> +		typeof(_mask) _x = (_mask); \
> +		((typeof(_x))(_val) << __bf_shf(_x)) & (_x); \
> +	}))
> +
>  #define ICE_ADMINQ_LEN               32
>  #define ICE_SBIOQ_LEN                32
>  #define ICE_MAILBOXQ_LEN             32
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index ba1435b9de..0c5844e067 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -740,6 +740,53 @@ ice_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
>  	return 0;
>  }
>  
> +/**
> + * ice_setup_txtime_ctx - setup a struct ice_txtime_ctx instance
> + * @txq: The queue on which tstamp ring to configure
> + * @txtime_ctx: Pointer to the Tx time queue context structure to be initialized
> + * @txtime_ena: Tx time enable flag, set to true if Tx time should be enabled
> + */
> +static int
> +ice_setup_txtime_ctx(struct ci_tx_queue *txq,
> +		     struct ice_txtime_ctx *txtime_ctx, bool txtime_ena)
> +{
> +	struct ice_vsi *vsi = txq->ice_vsi;
> +	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
> +
> +	txtime_ctx->base = txq->tsq.ts_ring_dma >> ICE_TX_CMPLTNQ_CTX_BASE_S;
> +
> +	/* Tx time Queue Length */
> +	txtime_ctx->qlen = txq->tsq.nb_ts_desc;
> +
> +	if (txtime_ena)
> +		txtime_ctx->txtime_ena_q = 1;
> +
> +	/* PF number */
> +	txtime_ctx->pf_num = hw->pf_id;
> +
> +	switch (vsi->type) {
> +	case ICE_VSI_LB:
> +	case ICE_VSI_CTRL:
> +	case ICE_VSI_ADI:
> +	case ICE_VSI_PF:
> +		txtime_ctx->vmvf_type = ICE_TLAN_CTX_VMVF_TYPE_PF;
> +		break;

These cases are all the possible enum values for the vsi->type. Does having
a TxTime context actually make sense on all of them?

> +	default:
> +		PMD_DRV_LOG(ERR, "Unable to set VMVF type for VSI type %d",
> +				vsi->type);
> +		return -EINVAL;
> +	}
> +
> +	/* make sure the context is associated with the right VSI */
> +	txtime_ctx->src_vsi = vsi->vsi_id;
> +
> +	txtime_ctx->ts_res = ICE_TXTIME_CTX_RESOLUTION_128NS;
> +	txtime_ctx->drbell_mode_32 = ICE_TXTIME_CTX_DRBELL_MODE_32;
> +	txtime_ctx->ts_fetch_prof_id = ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +
> +	return 0;
> +}
> +
>  int
>  ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  {
> @@ -799,11 +846,6 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  	ice_set_ctx(hw, (uint8_t *)&tx_ctx, txq_elem->txqs[0].txq_ctx,
>  		    ice_tlan_ctx_info);
>  
> -	txq->qtx_tail = hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
> -
> -	/* Init the Tx tail register*/
> -	ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> -
>  	/* Fix me, we assume TC always 0 here */
>  	err = ice_ena_vsi_txq(hw->port_info, vsi->idx, 0, tx_queue_id, 1,
>  			txq_elem, buf_len, NULL);
> @@ -826,6 +868,40 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  	/* record what kind of descriptor cleanup we need on teardown */
>  	txq->vector_tx = ad->tx_vec_allowed;
>  
> +	if (txq->tsq.ts_flag > 0) {
> +		struct ice_aqc_set_txtime_qgrp *ts_elem;
> +		u8 ts_buf_len = ice_struct_size(ts_elem, txtimeqs, 1);
> +		struct ice_txtime_ctx txtime_ctx = { 0 };
> +
> +		ts_elem = ice_malloc(hw, ts_buf_len);
> +		ice_setup_txtime_ctx(txq, &txtime_ctx,
> +						true);
> +		ice_set_ctx(hw, (u8 *)&txtime_ctx,
> +				ts_elem->txtimeqs[0].txtime_ctx,
> +				ice_txtime_ctx_info);
> +
> +		txq->qtx_tail = hw->hw_addr +
> +					E830_GLQTX_TXTIME_DBELL_LSB(txq->reg_idx);

Nit, too many tabs here. Indenting by two extra tabs is enough, no need for
3 extra.

> +
> +		/* Init the Tx time tail register*/
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> +
> +		err = ice_aq_set_txtimeq(hw, txq->reg_idx, 1, ts_elem,
> +								ts_buf_len, NULL);
> +		if (err) {
> +			PMD_DRV_LOG(ERR, "Failed to set Tx Time queue context, error: %d", err);
> +			rte_free(txq_elem);
> +			rte_free(ts_elem);
> +			return err;
> +		}
> +		rte_free(ts_elem);
> +	} else {
> +		txq->qtx_tail = hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
> +
> +		/* Init the Tx tail register*/
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
> +	}
> +
>  	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
>  
>  	rte_free(txq_elem);
> @@ -1046,6 +1122,20 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
>  
>  	txq->last_desc_cleaned = (uint16_t)(txq->nb_tx_desc - 1);
>  	txq->nb_tx_free = (uint16_t)(txq->nb_tx_desc - 1);
> +
> +	if (txq->tsq.ts_flag > 0) {
> +		size = sizeof(struct ice_ts_desc) * txq->tsq.nb_ts_desc;
> +		for (i = 0; i < size; i++)
> +			((volatile char *)txq->tsq.ice_ts_ring)[i] = 0;
> +
> +		for (i = 0; i < txq->tsq.nb_ts_desc; i++) {
> +			volatile struct ice_ts_desc *tsd =
> +							&txq->tsq.ice_ts_ring[i];
> +			tsd->tx_desc_idx_tstamp = 0;
> +		}
> +
> +		txq->tsq.ts_tail = 0;
> +	}
>  }
>  
>  int
> @@ -1080,6 +1170,19 @@ ice_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  	q_ids[0] = txq->reg_idx;
>  	q_teids[0] = txq->q_teid;
>  
> +	if (txq->tsq.ts_flag > 0) {
> +		struct ice_aqc_ena_dis_txtime_qgrp txtime_pg;
> +		status = ice_aq_ena_dis_txtimeq(hw, q_ids[0], 1, 0,
> +					     &txtime_pg, NULL);
> +		if (status != ICE_SUCCESS) {
> +			PMD_DRV_LOG(DEBUG, "Failed to disable Tx time queue");
> +			return -EINVAL;
> +		}
> +		txq->tsq.ts_flag = 0;
> +		txq->tsq.ts_offset = -1;
> +		dev->dev_ops->timesync_disable(dev);

Question: should the timesync disable call come first or last? I would have
expected it to come first before we start clearing down other things.

> +	}
> +
>  	/* Fix me, we assume TC always 0 here */
>  	status = ice_dis_vsi_txq(hw->port_info, vsi->idx, 0, 1, &q_handle,
>  				q_ids, q_teids, ICE_NO_RESET, 0, NULL);
> @@ -1166,6 +1269,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
>  		   struct rte_mempool *mp)
>  {
>  	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	struct ice_adapter *ad =
>  		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	struct ice_vsi *vsi = pf->main_vsi;
> @@ -1249,7 +1353,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
>  	rxq->xtr_field_offs = ad->devargs.xtr_field_offs;
>  
>  	/* Allocate the maximum number of RX ring hardware descriptor. */
> -	len = ICE_MAX_RING_DESC;
> +	len = ICE_MAX_NUM_DESC_BY_MAC(hw);

Is this change relevant for the time pacing feature? Should it be in it's
own patch?

>  
>  	/**
>  	 * Allocating a little more memory because vectorized/bulk_alloc Rx
> @@ -1337,6 +1441,36 @@ ice_rx_queue_release(void *rxq)
>  	rte_free(q);
>  }
>  
> +/**
> + * ice_calc_ts_ring_count - Calculate the number of timestamp descriptors
> + * @hw: pointer to the hardware structure
> + * @tx_desc_count: number of Tx descriptors in the ring
> + *
> + * Return: the number of timestamp descriptors
> + */
> +static uint16_t ice_calc_ts_ring_count(struct ice_hw *hw, u16 tx_desc_count)
> +{
> +	u16 prof = ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +	u16 max_fetch_desc = 0;
> +	u16 fetch;
> +	u32 reg;
> +	u16 i;
> +
> +	for (i = 0; i < ICE_TXTIME_FETCH_PROFILE_CNT; i++) {
> +		reg = rd32(hw, E830_GLTXTIME_FETCH_PROFILE(prof, 0));
> +		fetch = FIELD_GET(E830_GLTXTIME_FETCH_PROFILE_FETCH_TS_DESC_M,
> +				  reg);
> +		max_fetch_desc = max(fetch, max_fetch_desc);
> +	}
> +
> +	if (!max_fetch_desc)
> +		max_fetch_desc = ICE_TXTIME_FETCH_TS_DESC_DFLT;
> +
> +	max_fetch_desc = RTE_ALIGN(max_fetch_desc, ICE_REQ_DESC_MULTIPLE);
> +
> +	return tx_desc_count + max_fetch_desc;
> +}
> +
>  int
>  ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		   uint16_t queue_idx,
> @@ -1345,6 +1479,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		   const struct rte_eth_txconf *tx_conf)
>  {
>  	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	struct ice_vsi *vsi = pf->main_vsi;
>  	struct ci_tx_queue *txq;
>  	const struct rte_memzone *tz;
> @@ -1469,7 +1604,8 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  	}
>  
>  	/* Allocate TX hardware ring descriptors. */
> -	ring_size = sizeof(struct ice_tx_desc) * ICE_MAX_RING_DESC;
> +	ring_size = sizeof(struct ice_tx_desc) *
> +				ICE_MAX_NUM_DESC_BY_MAC(hw);
>  	ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
>  	tz = rte_eth_dma_zone_reserve(dev, "ice_tx_ring", queue_idx,
>  				      ring_size, ICE_RING_BASE_ALIGN,
> @@ -1507,6 +1643,42 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		return -ENOMEM;
>  	}
>  
> +	if (vsi->type == ICE_VSI_PF &&

IF we only use a timestampt ring on PF, maybe the case statement above
setting the context type, should similarly only work for the PF VSI type?

> +		(offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP) &&
> +		txq->tsq.ts_offset == 0 && hw->phy_model == ICE_PHY_E830) {

Indent of the follow-up lines here needs improving. They line up with the
body of the if-statement, so either double-indent the continuation, or
align them with the opening brace - whichever style is used in this file.

> +		int ret =
> +			rte_mbuf_dyn_tx_timestamp_register(&txq->tsq.ts_offset,
> +							 &txq->tsq.ts_flag);
> +		if (ret) {
> +			PMD_INIT_LOG(ERR, "Cannot register Tx mbuf field/flag "
> +							"for timestamp");
> +			return -EINVAL;
> +		}
> +		dev->dev_ops->timesync_enable(dev);
> +
> +		ring_size = sizeof(struct ice_ts_desc) *
> +					ICE_MAX_NUM_DESC_BY_MAC(hw);
> +		ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
> +		const struct rte_memzone *ts_z =
> +					rte_eth_dma_zone_reserve(dev, "ice_tstamp_ring",
> +					queue_idx, ring_size, ICE_RING_BASE_ALIGN,
> +				    socket_id);
> +		if (!ts_z) {
> +			ice_tx_queue_release(txq);
> +			PMD_INIT_LOG(ERR, "Failed to reserve DMA memory "
> +							"for TX timestamp");
> +			return -ENOMEM;
> +		}
> +		txq->tsq.ts_mz = ts_z;
> +		txq->tsq.ice_ts_ring = ts_z->addr;
> +		txq->tsq.ts_ring_dma = ts_z->iova;
> +		txq->tsq.nb_ts_desc =
> +				ice_calc_ts_ring_count(ICE_VSI_TO_HW(vsi),
> +							txq->nb_tx_desc);
> +	} else {
> +		txq->tsq.ice_ts_ring = NULL;
> +	}
> +
>  	ice_reset_tx_queue(txq);
>  	txq->q_set = true;
>  	dev->data->tx_queues[queue_idx] = txq;
> @@ -1539,6 +1711,8 @@ ice_tx_queue_release(void *txq)
>  
>  	ci_txq_release_all_mbufs(q, false);
>  	rte_free(q->sw_ring);
> +	if (q->tsq.ts_mz)
> +		rte_memzone_free(q->tsq.ts_mz);
>  	rte_memzone_free(q->mz);
>  	rte_free(q);
>  }
> @@ -2961,6 +3135,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  	struct rte_mbuf *m_seg;
>  	uint32_t cd_tunneling_params;
>  	uint16_t tx_id;
> +	uint16_t ts_id = -1;
>  	uint16_t nb_tx;
>  	uint16_t nb_used;
>  	uint16_t nb_ctx;
> @@ -2979,6 +3154,9 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  	tx_id = txq->tx_tail;
>  	txe = &sw_ring[tx_id];
>  
> +	if (txq->tsq.ts_flag > 0)
> +		ts_id = txq->tsq.ts_tail;
> +
>  	/* Check if the descriptor ring needs to be cleaned. */
>  	if (txq->nb_tx_free < txq->tx_free_thresh)
>  		(void)ice_xmit_cleanup(txq);
> @@ -3166,10 +3344,48 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  		txd->cmd_type_offset_bsz |=
>  			rte_cpu_to_le_64(((uint64_t)td_cmd) <<
>  					 ICE_TXD_QW1_CMD_S);
> +
> +		if (txq->tsq.ts_flag > 0) {
> +			uint64_t txtime = *RTE_MBUF_DYNFIELD(tx_pkt,
> +					txq->tsq.ts_offset, uint64_t *);
> +			uint32_t tstamp = (uint32_t)(txtime % NS_PER_S) >>
> +						ICE_TXTIME_CTX_RESOLUTION_128NS;
> +			if (tx_id == 0)
> +				txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> +				rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +				txq->nb_tx_desc) | FIELD_PREP(ICE_TXTIME_STAMP_M,
> +				tstamp));
> +			else
> +				txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> +				rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +				tx_id) | FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
> +			ts_id++;
> +			/* Handling MDD issue causing Tx Hang */
> +			if (ts_id == txq->tsq.nb_ts_desc) {
> +				uint16_t fetch = txq->tsq.nb_ts_desc - txq->nb_tx_desc;
> +				ts_id = 0;
> +				for (; ts_id < fetch; ts_id++) {
> +					if (tx_id == 0)
> +						txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> +						rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +						txq->nb_tx_desc) | FIELD_PREP(ICE_TXTIME_STAMP_M,
> +						tstamp));
> +					else
> +						txq->tsq.ice_ts_ring[ts_id].tx_desc_idx_tstamp =
> +						rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
> +						tx_id) | FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
> +				}
> +			}
> +		}
>  	}
>  end_of_tx:
>  	/* update Tail register */
> -	ICE_PCI_REG_WRITE(txq->qtx_tail, tx_id);
> +	if (txq->tsq.ts_flag > 0) {
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, ts_id);
> +		txq->tsq.ts_tail = ts_id;
> +	} else {
> +		ICE_PCI_REG_WRITE(txq->qtx_tail, tx_id);
> +	}
>  	txq->tx_tail = tx_id;
>  
>  	return nb_tx;
> diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
> index 500d630679..a9e8b5c5e9 100644
> --- a/drivers/net/intel/ice/ice_rxtx.h
> +++ b/drivers/net/intel/ice/ice_rxtx.h
> @@ -11,9 +11,18 @@
>  #define ICE_ALIGN_RING_DESC  32
>  #define ICE_MIN_RING_DESC    64
>  #define ICE_MAX_RING_DESC    (8192 - 32)
> +#define ICE_MAX_RING_DESC_E830	  8096
> +#define ICE_MAX_NUM_DESC_BY_MAC(hw) ((hw)->phy_model == \
> +					ICE_PHY_E830 ? \
> +				    ICE_MAX_RING_DESC_E830 : \
> +				    ICE_MAX_RING_DESC)
>  #define ICE_DMA_MEM_ALIGN    4096
>  #define ICE_RING_BASE_ALIGN  128
>  
> +#define ICE_TXTIME_TX_DESC_IDX_M	RTE_GENMASK32(12, 0)
> +#define ICE_TXTIME_STAMP_M		RTE_GENMASK32(31, 13)
> +#define ICE_REQ_DESC_MULTIPLE	32
> +
>  #define ICE_RX_MAX_BURST 32
>  #define ICE_TX_MAX_BURST 32
>  
> -- 
> 2.43.0
> 
