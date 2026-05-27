Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFFFCD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:28:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F2B740285;
	Wed, 27 May 2026 15:28:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id D7D224026C
 for <dev@dpdk.org>; Wed, 27 May 2026 15:28:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779888523; x=1811424523;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9URCbf9Eunrp0t73+RgVvzAmZoJeQzUnU+f5dt7ZFWc=;
 b=Noii9hGv0To/aEYWtMiF71JvuowcP1KJ4KQ6QSzHRATfljODIRjzr2q1
 mrLeUOXX5mMJvYi7txyOfh4xBoaYZ3QFt42dza+PVuVZaXp03R/Xtqfrf
 n+6dw44ooZdU9+65S0Oss+stScFLQtQI5V7h1Eus91sQASeUv+vdXbE4M
 pUzycQMb52CypQfW89H6OkYyL6k2A7FQVikYud6AJngZimcByHyZmBmYO
 DZS67mNXWGYNDL/UUPXAx6XVSM60TKa9X9t61JBEqV0aJ97Q3/StgC+5D
 Lp4Hgs2M9Y0Rr8XjiUZu7sX4qCBVLkzoQiftT0WgaTNqwTYZBhkEUaHkp g==;
X-CSE-ConnectionGUID: 5a/nlzVTRGCFTk/QHdjH/g==
X-CSE-MsgGUID: b167D8xITu2B0p7Ed4NQVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80567238"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="80567238"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 06:28:42 -0700
X-CSE-ConnectionGUID: fSIWs5l3RPqDP/QUX4gtgQ==
X-CSE-MsgGUID: yzCOm1BWTFK4HWRgr5FvZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="242079695"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 06:28:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 06:28:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 06:28:41 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 06:28:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSrkhoMFeBHKih5JFPoBxImuEbZI82fMv0oqZJBEk2VPckWRDuUcavtT7Df+EQjJ9Tou9YoZ1iO11zWt1YuOprl4w7K3KoP6G/e7gtxQXGTK+rjepUm6OyS7BMEJ2xpDo/aKq4qPtl34k0V91knzDgwsxreU/X1EaoTZ2FlyGh0XySSbf/YeP4yfNlI71Pkyqo5fQYF5ehJPZpjnRUpFvS9A4ENUcKlyaSN4vIkcxMn0sO8bzEbEI27GvB5oE9LRCSHYlWzBKxBt9UNzGgS+Hx24LkjXuE3VQQ2s6aQSKYX+vkI70ZJfw+35biHqzhKLzCbuShRzAPVywOSRFFM4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBQIbc1gb3/wgxO2Q4Rdg44dwRZrGa/axCeQpG9iSVg=;
 b=FzaXkIDkxVQCTgUMkMdIUEs95T33WYQ7YsWExQuNgd2nMq2+g4uUxGvqeFurFU89ytdoz9CKxYA3AqPuQ38ceCiCtLmixwdzxManJiSEVCuSS+fOk1XW4896carCBb7RnT1AaKZvkZybHtkgLGTOwNqhhfPekwvZDGIr0M6iduSf3mWcrnPOnHEAh4lKjPagienAzaxYf6J6bKd+dImJ0RFV5bT3eeJmofzNEuNn7Cg5Y5Hze6qyKdYm684Np02RFev6nPoe0CQprnmOKParHG3pnaGQ//S2g8sdOOl8deenon8T0dg8mz5AELwciU9+a9eKZfSY4vr0vFlYYbqxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 13:28:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 13:28:38 +0000
Date: Wed, 27 May 2026 14:28:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 04/27] net/intel/common: add common flow attr validation
Message-ID: <ahbxgjoGdAEm99kj@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1779717943.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
 <d75e9a02b40ccfe8fd2e00977ee99e9be95ca9ad.1779717944.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d75e9a02b40ccfe8fd2e00977ee99e9be95ca9ad.1779717944.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0260.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: c65abb6d-6d73-4deb-64a5-08debbf3dcac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099006|4143699003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: O4PjxTAHqPUJ+q6vU2HU2kP5dGlRWPyRnzVYnopu4gqg7+RsR13GebMue0zuQLFOSWmQVF99AWe3QtDovP7exTNdjWiRCnZ9JUcEzt87ycufSXWxgKkhrZeD7QKAV+CzIFWT3CfQRIYBe/G+Mzy5VoN8lOv8iXKkwNmuxYhUZC2wyBKxOItoLUnfKaSvxFNpwx1gpDyOuuvMBLQMQvXVsldE8jOAr4ScYmi+3EcUnlI+O45XdeTUGYeB8Z9ta1/qcZAA4kjN82WAvIXFxfYDc7t7dPEXVxHfMUukn+VfllSl/ckPhTUDPML3MQ9zRywGM6L4Ihpv8WtN/CFbdCnDJpeyZXZtdakzXATPLtwfb4pU1t/dfOmO0C6HchR/HfkC+oK8I5+1lZMt8Xp41FqMFU2IY2Dt0S6zp99efNtHjh8Yph8wXWaL1Ot4dQDitiRFatyUh9MwGO0MWfcDjy73WMCOYj3u7uPbIZXLteiVE9WNQY9XPGqODfjn7pGSl7hcKN+SxuVAmDJYtzjxO4QM/ol7NSsEKzm7eFg9IVlx1aMc+FSpGx3M/GXVGcMI98OYvZ+9ZVGdI/bKJMYBMa9hKLzAOrO7qq3bkRHFbt50s5FzNAuyexe9y+BnY+m9nshH7gVbXe4X3Niejd1Kai86jBpdMtqXq9dq7Bu74Xp+kMctZ86NHQ9hc6JZXklGt2cr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099006)(4143699003)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9/s2HoBBeEgrKQYkMpkDfEvvxvgrCTv70x9I3upB5iRXClkCYNN6dx+z0FpN?=
 =?us-ascii?Q?DRZtCvh5pUMO51gZNu7nEePvNK51tBd9/ZCN7PHUDdClvVJAHAcy/gipj11O?=
 =?us-ascii?Q?NpeAuSY325rYDNHYk6BghmTMQS9yGEePdPja9MltOPL8lgStrmt7Kt73ouhr?=
 =?us-ascii?Q?lMjaFO5HFMh2qbK1ixJI3qIWxbYlDvAvDo5BUo20fXg2hZ2DrZi1TNrjtBp9?=
 =?us-ascii?Q?zEMVy8ZnQLC8PImPwKr03FxdHtlPwrjg+1sBu4SvjIGuT7s54DL8v/ndaxk4?=
 =?us-ascii?Q?Z/4W+dJmyvbk11i8k68TjtXh1Q8L1ZhCyrE4bdgzk/BkbCjonY8A25CuM2XG?=
 =?us-ascii?Q?tCxmJqFYVt20sd0HPf8R4PDWW2S+BVAduSH+PANJ2nn/gitT9q2VPPmBqHs+?=
 =?us-ascii?Q?+lDdLjSEcjlqkKt0sHs4HboR/s1sy9ebBx3QQgIsSsIAG8i+imo2mDpdrLsV?=
 =?us-ascii?Q?/f8ix29oJYkbqzXwxa0FiGMnXaYdXMLtTlziwOwJoNrt6FE5dRsc++EnBU5s?=
 =?us-ascii?Q?1YTY4m7ZE9QAuc/SaEQUEsx1julCviEa0DkQ3zIHIso7tZlL2CHFThLKsJ4v?=
 =?us-ascii?Q?NlpBMPo5tEwPY67vS5tpbUb8TRmvU+j+nIGKF2OgbatC1+XSSEHTb9geWpNt?=
 =?us-ascii?Q?fcm86Rt/UToRinp7lnyJ50F8fs/RvCgpJCPy6a6pXOH6WRXHsjkzZEUcv3R0?=
 =?us-ascii?Q?MC1XydJV8PvaAp1CtruAT6jGj0xOhbuuZOuHmck5QoKjhOerezNaXnTCEpZM?=
 =?us-ascii?Q?9D+DdVC4pgAiG9JS4fgp/Msd9Rar8lgdEkirFTj23sR/mH0Z71ROelOtlK8o?=
 =?us-ascii?Q?bS98TsRAHWMVl9yPsh8dlb09AKt0pE0gDZR3nxQohqAi8RZAGbdJVeiFvjsS?=
 =?us-ascii?Q?cE+aeyI2DkOFrl/T/4uElXWy1X+luO35cglDrrLnRzBhOAM1RxmZcrTYTkL0?=
 =?us-ascii?Q?FF6aZLCU5qjP3/0v6F3poecDTRi0jhKOZADAtxL0bpIxVpounFea+IqgtX+l?=
 =?us-ascii?Q?jt135Ovg1HxPMRyXKhN3w/yabuu69fFT4tojj6g4Rf41gya2u5TmcjeCygvl?=
 =?us-ascii?Q?E9/lKGfB1E23NuJr64QlxKjNhqxqGSN1gCJGMI7pncMz3TbWswwCYp7f7xuL?=
 =?us-ascii?Q?TKvEmvIcp2GI5rr26Cs+NXmRfisPmJEEuI5/b2669MKRzqhySb/5prbTpCUp?=
 =?us-ascii?Q?GYPhc7024GxgTCcFL01Mnf4bfl5oYak7LEqnrMHZTjhPJDlp1sUwZKp1cYZ5?=
 =?us-ascii?Q?T6N6GQCNbK54k/wfe6gaATavl3YlMxlOvNTftC2zZKVxr4PEB8TRMLav1WKT?=
 =?us-ascii?Q?xfadx7Y08EK56kvKis22NluhxtCbLfGIiW3hb3h6vFe4eHszTigEtGxQELXb?=
 =?us-ascii?Q?e8fhXp9i2/0UcKYp6464QIc4IBOg64kRB39OhqOiYIhIKKrWNfyqES2GFXLS?=
 =?us-ascii?Q?qfrXzKhyq+6+yXHC5qJG9rr4hJ932Raj1BweULmdPGkwbal8UYevXMxRmwi6?=
 =?us-ascii?Q?C+NXRUKPpXmDOCWiF8xXMp9XWU0Y+wMIBPCnlf5LHil4BRur5pU/1uqW35I+?=
 =?us-ascii?Q?ad1T3gCTAXtuV8+pA028siB3Ts/U6edeQCx5ADmG7iMPapAMYasB3Z96U0ZD?=
 =?us-ascii?Q?CPGIO4iyoMnY4q/XxOMqTsy7rRsSIigf7YgyUPQNwsIAPcrsbk4FXeQJUg4+?=
 =?us-ascii?Q?faO4tq5VHFXICiL6uCMMfHbO//O1BV9VBVP6ziRge3gEcEUOP61myWmHdbEM?=
 =?us-ascii?Q?t58WFdW+gTK2g15rINYQxN1hB2JpbTQ=3D?=
X-Exchange-RoutingPolicyChecked: I05OlqnpnXhULcGjzcJhbFbMfNWUWWglUG33tluRaCNQ3dXAL0E8s4Ea7sYnxLUCxYETEWApm9HAavK5LLXn8+O8Pz8BsVIF5qlqQmrirvyblzJ50ezxj+w/Fadcoa6M4+seEh/ASuzjhiO1ffZfbq5+JVUscQGiB6zr7pH7LUOeoeJI0iQo7Zjiu+szitgtzKJ4jMGkk8Q7eXbpPSNdRIyoo6hsdq4RPQVwppIrhO5EILgIn01sIlPer+Rs6C1TcM6DAJHWIpWwbAVAG5fsyLlfuTdHoPqpT/nIcV0k8uabXWDG/DGf94pR9kOKUXXyPbv/LLRS75rbadVDlCRoZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c65abb6d-6d73-4deb-64a5-08debbf3dcac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:28:38.8719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dj4eehkMNsMLNUprrkvtQQrfCJ1bWgKKHlglYD6j4aUFilyt+t1w3KQyobCWnMoY3f6dWl7YD+sE7AdX1znaKWR1Qhx9z+xMQiZ3ADSjjlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4904
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

On Mon, May 25, 2026 at 03:06:23PM +0100, Anatoly Burakov wrote:
> There are a lot of commonalities between what kinds of flow attr each Intel
> driver supports. Add a helper function that will validate attr based on
> common requirements and (optional) parameter checks.
> 
> Things we check for:
> - Rejecting NULL attr (obviously)
> - Default to ingress flows
> - Transfer, group, priority, and egress are not allowed unless requested
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/common/flow_check.h | 69 +++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/net/intel/common/flow_check.h b/drivers/net/intel/common/flow_check.h
> index 74fb28ae3d..0572028664 100644
> --- a/drivers/net/intel/common/flow_check.h
> +++ b/drivers/net/intel/common/flow_check.h
> @@ -54,6 +54,7 @@ ci_flow_action_type_in_list(const enum rte_flow_action_type type,
>  /* Forward declarations */
>  struct ci_flow_actions;
>  struct ci_flow_actions_check_param;
> +struct ci_flow_attr_check_param;
>  
>  static inline const char *
>  ci_flow_action_type_to_str(enum rte_flow_action_type type)
> @@ -271,6 +272,74 @@ ci_flow_check_actions(const struct rte_flow_action *actions,
>  	return parsed_actions->count == 0 ? -EINVAL : 0;
>  }
>  
> +/**
> + * Parameter structure for attr check.
> + */
> +struct ci_flow_attr_check_param {
> +	bool allow_priority; /**< True if priority attribute is allowed. */
> +	bool allow_transfer; /**< True if transfer attribute is allowed. */
> +	bool allow_group;    /**< True if group attribute is allowed. */
> +	bool expect_egress;  /**< True if egress attribute is expected. */
> +};
> +
> +/**
> + * Validate rte_flow_attr structure against specified constraints.
> + *
> + * @param attr Pointer to rte_flow_attr structure to validate.
> + * @param attr_param Pointer to ci_flow_attr_check_param structure specifying constraints.
> + * @param error Pointer to rte_flow_error structure for error reporting.
> + *
> + * @return 0 on success, negative errno on failure.
> + */
> +static inline int
> +ci_flow_check_attr(const struct rte_flow_attr *attr,
> +		const struct ci_flow_attr_check_param *attr_param,
> +		struct rte_flow_error *error)
> +{
> +	if (attr == NULL) {
> +		return rte_flow_error_set(error, EINVAL,
> +					  RTE_FLOW_ERROR_TYPE_ATTR, attr,
> +					  "NULL attribute");
> +	}
> +
> +	/* Direction must be either ingress or egress */
> +	if (attr->ingress == attr->egress) {
> +		return rte_flow_error_set(error, EINVAL,
> +					  RTE_FLOW_ERROR_TYPE_ATTR, attr,
> +					  "Either ingress or egress must be set");
> +	}
> +
> +	/* Expect ingress by default */
> +	if (attr->egress && (attr_param == NULL || !attr_param->expect_egress)) {
> +		return rte_flow_error_set(error, EINVAL,
> +					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, attr,
> +					  "Egress not supported");
> +	}

I think "allow_egress" is possibly a better name here. "expect_egress"
implies that egress must be present, but the logic here seems to be only
allowing egress if the flag is provided.

> +
> +	/* May not be supported */
> +	if (attr->transfer && (attr_param == NULL || !attr_param->allow_transfer)) {
> +		return rte_flow_error_set(error, EINVAL,
> +					  RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER, attr,
> +					  "Transfer not supported");
> +	}
> +
> +	/* May not be supported */
> +	if (attr->group && (attr_param == NULL || !attr_param->allow_group)) {
> +		return rte_flow_error_set(error, EINVAL,
> +					  RTE_FLOW_ERROR_TYPE_ATTR_GROUP, attr,
> +					  "Group not supported");
> +	}
> +
> +	/* May not be supported */
> +	if (attr->priority && (attr_param == NULL || !attr_param->allow_priority)) {
> +		return rte_flow_error_set(error, EINVAL,
> +					  RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY, attr,
> +					  "Priority not supported");
> +	}
> +
> +	return 0;
> +}
> +
>  #ifdef __cplusplus
>  }
>  #endif
> -- 
> 2.47.3
> 
