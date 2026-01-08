Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A90CF6A86
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 09:20:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F47E4028C;
	Thu,  8 Jan 2026 10:20:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id A3C9B40261
 for <dev@dpdk.org>; Thu,  8 Jan 2026 10:20:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767864030; x=1799400030;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=O84Xb8aeqmEWaf+CbNJ6/eL49tpg3FTd63fy67vB/Ws=;
 b=H67MvzSg+JtW/SLiATYIXhRHYVd1Yp7ac9C3Ubf0cwzA/oBt/taGItJh
 7AhONVoTdIf8ZAMZvZI2BsPc7XcypNFV4IgvgeBMUwqtslmgL2ZXgD7E6
 KTJQXmpcu3Oj+AfZBHOfJM94agOjsQOvKo6np8H0zxeWVIxOxpmQ/+ZMt
 gydeVlGqVp8RALC9sNtjzhfcpgA9PkvaEi01LXxRQSCVQF6zqoJLNNynf
 VF+amHOFNr1QxUaPyRNo5rbKNwP1Am5ysGunq195FPz6CONR1P8SMJtbN
 CadFDW0cmZZ7N+im4gxuDKmebXgDgH7w1FKUjD2iZWbTMA5266dJF+6h7 w==;
X-CSE-ConnectionGUID: M0IoyWU9QEionVJBY8ZBDA==
X-CSE-MsgGUID: ST/PomAFT566Xw4FlgGfNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="79538755"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; d="scan'208";a="79538755"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2026 01:20:29 -0800
X-CSE-ConnectionGUID: RiwDY05JRxK3Fc1WghiE5Q==
X-CSE-MsgGUID: SiotYNR3Slin2PGdlsQEBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; d="scan'208";a="203215269"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2026 01:20:29 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 01:20:28 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 8 Jan 2026 01:20:28 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 01:20:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7RSwKbuIqmv4KxCvUb2/jBcAxCWP0OYVV3b//VvigwCYLg0pPDpmG5ZMUSSuNayAPpbFieD989cSadXWXEfJ/KO4DatW+RBX6Nh0Kw5TckVgTojKtuQxiwzdei+ailDS0o9EqKcci/CHaw7Om9Np1KdtAnwTFGUNKziwRPcluwWSiLdUqL5q1pXIpsAs56yUGzSgJxl7CZYCWfrLB0jKio1iNRoFDHr8W7Fp71hmWWu69deP7n843NZoWRx4hkdqIknqggIO5hSeDJBaBkzm8UiRZXr8aqys18C15aWvxsqlpLMUYss8Vw+tUKUwoQl1h6G441Qz034No3kxjk9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZXDcSiKg4Aq5LPfcNkI+JWJtQDGBi7mFpk0YFghexo=;
 b=EWBs36S7yq+srZJG5x9DuQvgTZOpdzYwnwvQkwR+JKdC+gY71Cd78c2MiCJlh54e5c6iVfojXI6CkDd3fwAbfWNqzqoqrWSWxXhZXxVxH8nKK5ZUs1NaU5lJ9yPHePcCAJ5Q/vgUvduboqLs5Z2zOw3790+0NrFwHg1PyrfRnCC/Ky2beeo1YU3TM/4BZn3r36Q/JbLE8JeIb5Yog43EIPvk7kyQZqWeqEmf8Zaw7RFE2aXMeG5bABPvtnkIjs101p8ZThIMPdokEcT/YjBUG0p+iKeRx3ReszhIQ6h98Ljb7+73KHk4lPwfQY35jIe9fR8jzAfWTFjq/DLjxDeGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:20:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:20:26 +0000
Date: Thu, 8 Jan 2026 09:20:21 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>, Ciara Power <ciara.power@intel.com>
Subject: Re: [PATCH dpdk] telemetry: fix adding dicts in container arrays
Message-ID: <aV921VEaX5uQW1yH@bricha3-mobl1.ger.corp.intel.com>
References: <20260107215129.1329960-2-rjarry@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260107215129.1329960-2-rjarry@redhat.com>
X-ClientProxiedBy: DUZPR01CA0335.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: efcf4998-ef80-4fe3-56d8-08de4e972875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+MVCNil4k/mSiA5ZWQ+dMTft1tm+vHr2DO7BZRRQ7lnNAwfz1HPNUpmotVX8?=
 =?us-ascii?Q?GGXMT8ZoGap0g+/VJHMzPKevxmEN3DknQjFz+f31ilJWA0OTgqZoM5du2Hb9?=
 =?us-ascii?Q?2zOLXmrtj2Q+3C96xZAIl6Ks+OcKdhpv0Ufo03Hl8wn8wok1n8BO0dZqmMp0?=
 =?us-ascii?Q?Tutt4vGQiQnELp/S9nZylnkvEUgajiEjGAilJIykCbM1i5iPKo37eMKAAPoi?=
 =?us-ascii?Q?mDwrm7UX3jP3ZA7Id9jtuZ1Z+EKsVhBtEx4l3HFrfFyGoHahHuebCuyg/oMk?=
 =?us-ascii?Q?S/gEJ8uriqLoo7EmvEIFPS4dQtT2yYUFJ7SBh6QMvyR4bLD4tt36xh3JdQBY?=
 =?us-ascii?Q?+j9qm3KepgVqmq1mqEd37FChLTLn9vtaLiaA7dCqTqQLjXPG1r227lpsXWfl?=
 =?us-ascii?Q?XLZXUE3fDZn2z8XYDUswDKW1j8VHz4vJMmfXsxvFrwrSMcVJZlAedvg5YyNr?=
 =?us-ascii?Q?UmJ58Moe2cCngFSiqGB1SRekjGTG3acgnHzd2S4LYqipGP3pBDHU4gFpekKh?=
 =?us-ascii?Q?lxHMdKCpfKKNvT/UlT5IscC6Wtat2J1m8FsnItsryqD4thIEPGBZMorqlgFe?=
 =?us-ascii?Q?TDcrJ8mkzz5qEX5YxWjlXvkKEP/IDlaSMqH9bc9DoJ1F4y6MZgkH+OZr7923?=
 =?us-ascii?Q?GiRZkzkIe7zahfRf4b9n3YTK7TCrdUSK/bwPBl9M+RvAHS3lLzAZS4y9VMFF?=
 =?us-ascii?Q?4V/qqg73QKVy8KFzmJ9tYHyD3F56OMBWZgezopnHExbFKRFCyQDXnzCpiMEd?=
 =?us-ascii?Q?dB7TTm3/NewT4jj0fJ16gmBKuaO+eqIbdkZ0cv8mxuN0rXxI9ZklzBsG3rSk?=
 =?us-ascii?Q?QQPeYsmtwENO4zIr+aai6kvW7K/FLIOsq8rguDx1FJ5VWU+MNBUaIzukqn4R?=
 =?us-ascii?Q?Bnxh8SMSQ27u6yjLOq4+w1SujBoGfhotASuvnER8oNLD77q4yjZ4cPs+ps9m?=
 =?us-ascii?Q?A8eR3ICF4eQmjjGMveDnBhVdsDy37NWgDbCuaMTxOwc78+pJmFYv1E9G7Hhn?=
 =?us-ascii?Q?OYOSH1ScDTMyEsH0MVTV/zqwYDhkyzeGt34ZnS9jn+Rle0A7qFEVZdJYECUA?=
 =?us-ascii?Q?RPEMOcHfHzlj4qCMkZyhRwdI4x1gEyHkHWJFGXxd1ERRdDnFEMOR1aqHJ4eY?=
 =?us-ascii?Q?WeOwZxeRWa2K/BQ6pKitg7U/DuxeyPyysJgWdt3gSAJdreaoXB6MKNBjggY1?=
 =?us-ascii?Q?i3O2+UfCEB1lGxBseIkRH0GIdkmy8hMD4UzxrRJxjQDdZ7ykw1qhDkg0QbYV?=
 =?us-ascii?Q?VHSrnoOr53jiNH/4XN6MjicSSEj/lxeeKU/XQTcntefaS6RQPe+neODxVirA?=
 =?us-ascii?Q?RQ/hcF/sJgCoLZSn2dXXOLzqEXp70C9puTAlxEozNWU1vwh5JJMFvhYmtyEL?=
 =?us-ascii?Q?m5FNLjsD1juUhqDsQFknZbogTeRsi0caEpfPd6i50wxc7qQyBBIqqxSgnAos?=
 =?us-ascii?Q?ftrMPAFFCcw90mJemb0N1kQJTJb/OWPj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zDdhHsegYfDYAJE6Z8w8UEoIAN8hA2zNvkXSzkH07Y2tt0hJ+OapRiKzkqd7?=
 =?us-ascii?Q?3uL3qC8etnano8BD/Q7OjIQrRaqxDxJp1u5vzcmFESF7Sh/N4jZDMnyrDs5R?=
 =?us-ascii?Q?oZRjAW/or4FATRWTLlZsufUfBzDI6FPzXGh+nm/7nlg4Uh3JeWRXNvuPNRzd?=
 =?us-ascii?Q?+E6oLQv/CZkrjUBmLWdB2CGt+uTmoLQtacd4qQ87+XxOMTUH4sTBd+6gZnDN?=
 =?us-ascii?Q?zIszjk/5Z1QK8Jc2TFAH+dxKdqCLI2lz2iJ0uXfis5UnaqrrV4kwoB9sTt3V?=
 =?us-ascii?Q?HmXZ4lEDBgekY4WXYxgs0gtZfHlV8ctiEmxXQMHz8OYGD8GxCPqTAtDZ+a5T?=
 =?us-ascii?Q?FVBSxGJpPwfDJVji1rddcBZavrUgWkLjG4I1VYOROGAG62ehXjjUMLWKSKQB?=
 =?us-ascii?Q?eiFkRs47+l5wlUHwk/JCxAEWB+zm2661Q0rKtTUe+M5sWYCrWOIErFB37iPP?=
 =?us-ascii?Q?NZigMNnJ44jY5nEvGfUEz73XmTu2RvdYD0gHDA6Z9egCfaUKylhMHlL4OoFt?=
 =?us-ascii?Q?c043ipy9vQJXJj+UQtowCXUKqd9zRtCz0NE9sn4JIZXeqRQTQjSQZc3SC5We?=
 =?us-ascii?Q?23UsHWvJBOvqjTK+asbxw7vTtTwl2ENs8KxOLt3PIMp+jMKD/fAYxcZiLkRZ?=
 =?us-ascii?Q?OSZGyhAeRmcFVgrLbA0We6F1VMDRdrZLvtmQIeodvblcRkw2GMvjIddu9UYa?=
 =?us-ascii?Q?T79LskY8OzmmAwTVofErFnPr2RRfTeixIWRDXS+vZ0Vsgm5vLjip6KVbAUqg?=
 =?us-ascii?Q?trfw2xkJIAiTjxJbHjQ43y5brzDvx5Jyp/krrtzM9TIW8wdmT4ZqbeCVxNuc?=
 =?us-ascii?Q?bNJghpMdSDYZNSWwWIBJE85Bn6hMawZmPjt07gj22+tLEzZ7JhJbTGZz1/+i?=
 =?us-ascii?Q?GgSie4um4T6DOSO03CQbdu7rmhhGH1pqhzmGuPWSzCPppfHXExlEugkMNHQm?=
 =?us-ascii?Q?eAOhQfSkuLwJuEbK2+kXWN04Ji/FZAx4oHwx8dt3XfNh8/xsGKKgbnu37CyD?=
 =?us-ascii?Q?rHYeV1O59OP3KndaBsDQatwOGifLhGwC3+DH1PyO9pZ71Fs72bGkC0ToP//H?=
 =?us-ascii?Q?+ka9HbQ/vlUzlgdWvgb9hiei4OGsTQqCpkqo4onmhRppbDA/CMXc7TE+rUuo?=
 =?us-ascii?Q?t76K7sW5ZHC9PV1sIbg5OIHeZlSrygxoNPuicYUAFH1nDQAzniLqBslr/FY6?=
 =?us-ascii?Q?uKBy4JXWYRZMQAcgKUZL+KDqaotas1pXXZB9B2UHM+OSvzKdhfA4vhJfvoC8?=
 =?us-ascii?Q?VpNn6nrbn+feLkV8JoeWirdaQC2FBPGGaXs6ZgvNZLWUaiJJZZd0sMUCBhON?=
 =?us-ascii?Q?+i5Ln5oxAOBqbTZq8A6fesJC8RbQ7vuG3TxhY3cgWrIkkuf0MyTcQQ1o6Rj/?=
 =?us-ascii?Q?VAL0iM/zpswGTLDt/5MjCGuZe10EJ7t6H1gvW1HgOoI0vl65TJq8LszAczoh?=
 =?us-ascii?Q?btoqESpb7x+kaoK1MGm5k7XIBBl8wg2fab4tav4ZjxXuhRxCme5BAINILXwS?=
 =?us-ascii?Q?eaPjggNNLsL2Z7Fhg3SUv7+orCpONdhyBBeFRyl/ZjEnAOQKBrw8OTLMeW69?=
 =?us-ascii?Q?73XbqPzmcgZAUz1E8PUEK0IpysgNi6cAkwQQlS2/TqXFWLiAoE2dBPsZoI3s?=
 =?us-ascii?Q?StrUJv8J4mmaJGexN7Stbjh/wuiEjrgwivA6Eg578VFZ/epsrzKJ8Trn+lrm?=
 =?us-ascii?Q?3kVMCUkE/QCiboo1/mMoEaf1gAkiphncVKzMDK9cYdDH3i5j7Vp1a85r0PQ+?=
 =?us-ascii?Q?Z5AkMoJUBfzJD2+ObJGF+c5/1k7rJyk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efcf4998-ef80-4fe3-56d8-08de4e972875
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:20:26.1583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D158JnushwQHwA+C4bWYqoZyaI9w2wGYCFPG3qingAyYfLHxJOhx72vJQj6vFOBvrTGkU/nm7YJnMrniW+o7m3slb4RyxmIyystcScBi7kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5912
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

On Wed, Jan 07, 2026 at 10:51:30PM +0100, Robin Jarry wrote:
> Currently, adding TEL_DICT containers in TEL_ARRAY_CONTAINER containers
> is not supported by rte_tel_data_add_array_container. It wrongfully
> returns -EINVAL where it should allow it.
> 
> This is supported by the JSON formatter.
> 
> Allow the same value types than rte_tel_data_add_dict_container().
> 
> Fixes: c933bb5177ca ("telemetry: support array values in data object")
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  lib/telemetry/telemetry_data.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/telemetry/telemetry_data.c b/lib/telemetry/telemetry_data.c
> index 0354a0654804..0a006559ab42 100644
> --- a/lib/telemetry/telemetry_data.c
> +++ b/lib/telemetry/telemetry_data.c
> @@ -96,10 +96,10 @@ int
>  rte_tel_data_add_array_container(struct rte_tel_data *d,
>  		struct rte_tel_data *val, int keep)
>  {
> -	if (d->type != TEL_ARRAY_CONTAINER ||
> -			(val->type != TEL_ARRAY_UINT
> +	if (d->type != TEL_ARRAY_CONTAINER || (val->type != TEL_ARRAY_UINT
>  			&& val->type != TEL_ARRAY_INT
> -			&& val->type != TEL_ARRAY_STRING))
> +			&& val->type != TEL_ARRAY_STRING
> +			&& val->type != TEL_DICT))
>  		return -EINVAL;
>  	if (d->data_len >= RTE_TEL_MAX_ARRAY_ENTRIES)
>  		return -ENOSPC;
> -- 

No objection to this, but previous implementation limited the options to
what was needed and tested by telemetry rather than trying to cover every
eventuality. If we now support dicts in arrays, please add some unit
testing around it to verify we haven't any issues with it.

Thanks,
/Bruce
