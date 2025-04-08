Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FED8C369A4
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 16:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2026A40267;
	Tue,  8 Apr 2025 18:50:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 74A4940264
 for <dev@dpdk.org>; Tue,  8 Apr 2025 18:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744131020; x=1775667020;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uc/RxtQGJL7LdN+IT8QPMmsYEL1dIyFXcHezRQCudhI=;
 b=KHY8/62zxEepOz3tY/IkIUs96he1u1dVChTqIYc9BbQ1/wkLP92ak8bU
 XkjbWd8aZa55lTCUeOgnRNZElJGO+ZT1dB5CIrIocuTiK9nNjom6y2Dxu
 v0zbGfoK5HsgT4iUN8KfYbwF9nObGZbZt1NQIYKXpZZ1ZgQVTjUkK96Vk
 Ll0XZFDeXIS/7q9tEitpYkrO5oGOEuYYau2f26FyZN+j/hH8Oa+HJTy/O
 VjwLcO+N0kyO60vroRXSaVfhAu8wUkMtddnLP/sHajFjynMzzO44Y5H7d
 Ct/Xf6gxz0aApVqmbzjsZrY4cLbH9ulnBNqwnFTTtb3YeMLTqf0aFiZa2 w==;
X-CSE-ConnectionGUID: JgX1+s0YRnCUcoQDaqLpMA==
X-CSE-MsgGUID: H/lR7fueQzmsL5p59oft4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45463108"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="45463108"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 09:50:05 -0700
X-CSE-ConnectionGUID: dkfnJ6TWRvmPvUFubLSx7w==
X-CSE-MsgGUID: N0y/8V7cQLqRaGMFBKRvsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="128828976"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 09:50:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 09:50:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 09:50:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 09:50:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hl53EMCoyMRbKnOMLIUMMtVIJK7EPqd2O3BDQX9KCM1bC4FxoiqQmWUcFcNgbc9jajt4ZAU5j7C71NnjCPIvJ+dsrKRuH+3JYpoQ7q5T1im2brXxSDoBK4DEXeifDs4Fpm9vwd5LqorL8ZAzgdLCXsUsalymhAYjSwpanyWqXM21daGeQVlHBYuGekqyhyQKiLyhV0x4EUqKRSUIKb135s0tNmYsr5naZ5krC8g86rJ0pqfc9DbjA4LtJ0PA1xXCoIYj9nyaqF6abISrxfk2InsjSQsQtLQugoqKDWuJqkFdaCKG9cQr7TFBgExsY/e3PXCRiJpptK/+WVBXNg+TAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afLUxdimu2hvitBEVa2hfUOCpi7OnIh1wbzICcW5/aM=;
 b=GjSegKXrIN81QFJ8EEBoGQ/i3MBNGfPkUr3zPVQtXb8llzkAUTXVejb1cesQ2+bHuOEvyfEgHyz9jw99vEYINOJJRJikQn5rfw7ipX1Gm8PbwEF6E3Tp+ND6KjulIhQ3ZdatnpIkhxqV8CUMM5+CrikODjyV5ZqpW81Y9iPV6poWB84fzdwtbvO0V/ERQH9EChRlHU2tuxx+oc9RGjRWNfz4RYC5XH/aU/Ue3zUyLb2x0z4kWsfTcxEOW6cf/6aFEs70BvwHSRSAvTOH6NTtpegqlbxzwOMS2dlbS0ZRlPx6zB6T0GGgWOgS9ficFln/EeqWoct1soN0fozDA+TrnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB7014.namprd11.prod.outlook.com (2603:10b6:806:2b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 16:50:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 16:50:02 +0000
Date: Tue, 8 Apr 2025 17:49:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v6 3/4] net/intel: use common Tx queue structure
Message-ID: <Z_VTtGEwegdYoTYR@bricha3-mobl1.ger.corp.intel.com>
References: <20250312155351.409879-1-shaiq.wani@intel.com>
 <20250403112429.2741138-1-shaiq.wani@intel.com>
 <20250403112429.2741138-4-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250403112429.2741138-4-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0244.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 631e7c49-14fe-4ba8-cb87-08dd76bd67b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6AVn9eL/bZzHqYlNPWU87bBruKR7xhJDBnNwC56t/b5NoOH6v7ILpKBLxLGl?=
 =?us-ascii?Q?jA9zai2fP4wD8b6F5k70t6WwWmqn/tsITovjB3EMV2yN4xf6LxAykNazkwro?=
 =?us-ascii?Q?lXSFdVlM6aSZbHer1/YBCAj2QoJ7He15irhd0EpRUmhLA5vREp8CrOVsfja8?=
 =?us-ascii?Q?Y8NrehluW5ZryWu7wrfT3Q2G9ZP8/9U65E3dwGkAu+0MX37vxyuovVz/6rk8?=
 =?us-ascii?Q?tpp80gWFh1WPD2nMGWXGAfO1MNMa+yDcWA/Rw8SVa4ZezsCkADDt1GZHF6Ok?=
 =?us-ascii?Q?XepeSApWrfF1CkCXv4KampgDBsaHpRkSfQuLR/jZ0YmKlXe+EC6C3H3S14AS?=
 =?us-ascii?Q?X6vj1tl+Vnq1MQvjco2Xpe0I3fJnrwPwP3MUIvMmjQU7xARgvYv4SyeS1il2?=
 =?us-ascii?Q?eCL7SSZV9VlLE5TdNPtzXI0WztU/u0EcuIcAwY6pcp/lGU0ByOO6s89XREsN?=
 =?us-ascii?Q?lgl9RV0qAWMiinDs8CEssgndcFzwO1TTnWaf75+jQNHz6tuhYUNLZCAuWnSV?=
 =?us-ascii?Q?geKgYeT9J0W6ZYazYoAhEuk3G1X8kmjSX3j5kIIaewwNaQE3myJlxtuiQl8w?=
 =?us-ascii?Q?v5uKUQFX35A9gQzfBVSX+ejLS5byxt4IjzOsVAOe1DFCHKnPw8RbTx6QZs5G?=
 =?us-ascii?Q?4ndDPXMPofp2qJr3GhJsW3Qcdj9/wkn6QJ+JnNe6kNDns2HeaB1NTgAPVLbO?=
 =?us-ascii?Q?N7bQlSCJqkQPHoCHZQKsk3NfQKAACwrH3+RI3fiL16CWNd1fXVYVZzHSGFuo?=
 =?us-ascii?Q?FKb+tnU96MZT3AYTSib7BuHy+emg/k1rmzmOx7H1WINkCwu7525671n65/uY?=
 =?us-ascii?Q?LyeDoa7UrfhZN+VMptyfYF7IZWSn3x0BOOKUMb6/wcVEjjZt3L6ABidWqPt1?=
 =?us-ascii?Q?Z7fAKjOYI3RBEa3WSdWop/fMBdDPtHsbpgzGk4YV010Ck8V3R+r1xRd5ldU8?=
 =?us-ascii?Q?GBdjAsBtgnsxKV4qCdXVJCHfpCSQH9JfOXgCBqp6z+Vatv2Z9wpPWaBwzOAt?=
 =?us-ascii?Q?PZ6bWA8Br3PBzxcVzFK23zmgH5qA1IYB72TE3pE9r7+IGevIJ+NqsqDcNONe?=
 =?us-ascii?Q?h50DmT1s3GdOxZ1Dm8YEZ49W8vRde4UD8xqyUcI6/FQKJtFlnX2SgzLLq7Ce?=
 =?us-ascii?Q?lXcImyL8pCwfJuaPsX5fLM26QcCm3CXaMXPQOmu69+PFIPaWkvVbmZinSd+D?=
 =?us-ascii?Q?xnHclVmWaeIVDsl0TR1bOflr071Dy+EmSX0vDLJbR4r4GmP/UkoPxUstYNoL?=
 =?us-ascii?Q?LqwN3s3KBA3iA3nhPoAIHhW5DXPWXh9JGQu9ypTfOEXbHSnZfCBOF6uPJYYx?=
 =?us-ascii?Q?jjGB/wFzLt7BiWSc3AUPMguaNi+B+wNVVj66Nr9klF8Od3tRyyyt1FjFKT4s?=
 =?us-ascii?Q?XHuORO0vHhAPMJ9LWRnZJErBlVWt2SfiwbYa0zJDlC4xCDt9bskSEK2GX1Kp?=
 =?us-ascii?Q?tkLkLmtvUPo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IBuy5wKemssmzbgTHSwc+buf6zCd+cl/tXz7Dua1I8TVfURRP7n+qLU8jAWB?=
 =?us-ascii?Q?Tl0IHZmscuXrPtPyokPPKsmDadrcPv/1ZUHhXxMJVyVJAHqHlpwyKmXLQFDa?=
 =?us-ascii?Q?5rX6eQ6mVVgLtaLlilEpwV7nVGW4D/cWwEIsx/Gl+DeD6UBjptgiLLrZIPUr?=
 =?us-ascii?Q?RV82kFUDDpZZue2CocEE2Rzx4cKjB32myaQNisRzZ9Wv1tptrHzxuAf13Lk7?=
 =?us-ascii?Q?wLtREivPHIpty9I+wtEsbQ5iSzGKx9eRg6CjG2P9D6gBgIbjjORNRqZSEWSF?=
 =?us-ascii?Q?xCxuA5jlq0CqzAXSh/X5hN/u1ZkgG5+FCvmFypC/RACgqSCLV4iUe5qh4Ie+?=
 =?us-ascii?Q?KsHr7cfFMu7ZqXA2Buov0RFUESQeKSAws3jwL2vfhK14MZyvrxidHWUaT/aT?=
 =?us-ascii?Q?O6BU4b3kznCRhjKOVgBgUBplqYGf4KNROJH/108BQ5ukQO4AVZHu8Oy14zTZ?=
 =?us-ascii?Q?XgC263faG0PyjyqAHE2gKedeXBLaJoUtoCXiXlRMnSx53ii58KokGN1RMPra?=
 =?us-ascii?Q?qsl6mVeznfrcxOKsG6b/iSKJEeS3knYyyXVKbciKY6qzUcxNpQ0hTZcUwXH8?=
 =?us-ascii?Q?KiCxlUsjyQLzCWv99kh+ahbvHR6TNyqjlPe0XeZebqsV2L3HZv/Lkh2hkAHw?=
 =?us-ascii?Q?NJgIqP7M6S/WuHodX3yThHd5SSHGF3O+kYdCjerWqbvy0mZoDJLoRHVflls4?=
 =?us-ascii?Q?HQQZyG/RofUaGBlMawiMW0cf+yKcSIDCXvUFosXKwhmyGM1U3eA/qzUnFg6o?=
 =?us-ascii?Q?1EZhCEAtpP3Op9dC0NRHoDYMvzrrILvgtje9pDnD4HHWw6mFVeu15PCzv+mA?=
 =?us-ascii?Q?GNSQJDWij33DU+wdk6ve3KPHRUSWA0AiJWW214wrXJSwqLqabk677Ax8cAJ7?=
 =?us-ascii?Q?qQKjEKcT2mUJViF6IipzyqTxKPHpaeyxGvHXfB07sUVm9RfnGbAlh/xFNq4N?=
 =?us-ascii?Q?c35wRZGUVRpLy+F1X/pS+I3VMiSkyIFihXk5EYStuQGj3egYwvBd8hPoMvxW?=
 =?us-ascii?Q?V7oBxeTKVBwz70e3ag//3L7THeRlpwWvGFxDB6hpbz0yMsiG+E2Dc79U2hyV?=
 =?us-ascii?Q?EMplFAVvVwsP5dY5JQO8PCBND2WPKjlX3MYT7H69mawcysz2CBpA7P3ihZLX?=
 =?us-ascii?Q?H2y2LMIsDJtj1AP3NIi+Zy/6yy8bgjlWq+pPu/2Ki8jM16NR4ahqQXBcQK2H?=
 =?us-ascii?Q?0INxb8/EIyvxvu8/55VizQimqaXH6VXAObYr9sU2f8pyXpjyque1YoGRvtKc?=
 =?us-ascii?Q?LwG0qyPmWY4H8wNbNWEfE7Y/IeH8G4fuABBR4Kroyh90YI7EFGRyvFpLXyps?=
 =?us-ascii?Q?hfOYtKBN8yhvLtJ4wEURRQ8jtabsYNgfvzuj2f+EYgVmqq8nwcUjha7hIEWz?=
 =?us-ascii?Q?ifHSINTa8vjOVbwo8mDBFE0uIagNpakYX31E0gzw8TNUgEmqiEX22A6H6IjI?=
 =?us-ascii?Q?kv9JFD+YEIdedSwHdTEqT+7OQQLMt6czRdpMO9ViGaRitjktyZr/7OA/qiCP?=
 =?us-ascii?Q?kg906nvcy0CUVenN8dhETuGdHmIdfOqHVQDffAHS4KzK9Yi/wVGLxjhvKh1T?=
 =?us-ascii?Q?y093oyQd6yQBM0jxLHr3l43qwjJzSnYL8r2uMR3wtPgTjQB+ios0HuhPOjus?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 631e7c49-14fe-4ba8-cb87-08dd76bd67b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:50:02.0080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sL0VQMNP1SwyWJix9OEv9DD7RHqIBzJK9hJG7/MuWcdchErETOybUycgKoHrDpIO0W3wljU8eyBPowjq3E4zmsSiZBU9+fR5U2ZXD6NK5U0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7014
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

On Thu, Apr 03, 2025 at 04:54:28PM +0530, Shaiq Wani wrote:
> Merge in additional fields used by the idpf driver and then convert it
> over to using the common Tx queue structure
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/common/tx.h                 | 18 ++++++
>  drivers/net/intel/cpfl/cpfl_ethdev.c          |  3 +-
>  drivers/net/intel/cpfl/cpfl_ethdev.h          |  2 +-
>  drivers/net/intel/cpfl/cpfl_rxtx.c            | 24 ++++----
>  drivers/net/intel/cpfl/cpfl_rxtx.h            |  3 +-
>  drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  2 +-
>  drivers/net/intel/idpf/idpf_common_rxtx.c     | 20 +++----
>  drivers/net/intel/idpf/idpf_common_rxtx.h     | 57 +++----------------
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 10 ++--
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 20 +++----
>  drivers/net/intel/idpf/idpf_common_virtchnl.c |  2 +-
>  drivers/net/intel/idpf/idpf_common_virtchnl.h |  2 +-
>  drivers/net/intel/idpf/idpf_ethdev.c          |  2 +-
>  drivers/net/intel/idpf/idpf_rxtx.c            | 21 ++++---
>  drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  4 +-
>  15 files changed, 83 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index d9cf4474fc..9694b0fc06 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -35,6 +35,7 @@ struct ci_tx_queue {
>  		volatile struct i40e_tx_desc *i40e_tx_ring;
>  		volatile struct iavf_tx_desc *iavf_tx_ring;
>  		volatile struct ice_tx_desc *ice_tx_ring;
> +		volatile struct idpf_base_tx_desc *idpf_tx_ring;
>  		volatile union ixgbe_adv_tx_desc *ixgbe_tx_ring;
>  	};
>  	volatile uint8_t *qtx_tail;               /* register address of tail */
> @@ -98,6 +99,23 @@ struct ci_tx_queue {
>  			uint8_t wthresh;   /**< Write-back threshold reg. */
>  			uint8_t using_ipsec;  /**< indicates that IPsec TX feature is in use */
>  		};
> +		struct { /* idpf specific values */
> +			volatile union {
> +				struct idpf_flex_tx_sched_desc *desc_ring;
> +				struct idpf_splitq_tx_compl_desc *compl_ring;
> +			};
> +			const struct idpf_txq_ops *idpf_ops;
> +			struct ci_tx_queue *complq;
> +			void **txqs;   /*only valid for split queue mode*/
> +			bool q_started;   /* if tx queue has been started */
> +			/* only valid for split queue mode */
> +			uint32_t tx_start_qid;
> +			uint16_t sw_nb_desc;
> +			uint16_t sw_tail;
> +#define IDPF_TX_CTYPE_NUM	8
> +			uint16_t ctype[IDPF_TX_CTYPE_NUM];
> +			uint8_t expected_gen_id;
> +		};
>  	};
>  };

While I think we can do some work in terms of shrinking down this queue
structure, its not a massive problem I think right now. It can be solved
separate from this patch.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

