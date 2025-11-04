Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB96CCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 17:21:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A45E40653;
	Tue,  4 Nov 2025 18:21:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 42E204064F
 for <dev@dpdk.org>; Tue,  4 Nov 2025 18:21:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762276880; x=1793812880;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1GTv2hFuxO5X/MdOV/6Tlui5e/Pa1U7cos3VkXomliM=;
 b=O75FEZltPMXTB9Boni7d5SJq2/9JBfCgWebEvFXc5waq0cLcA8cV8DYT
 XpIQpergcp4z0iGNFhUrR7fj8hoqfKX5vkvNOw5AgJdpWt+Xg2ouRHmiX
 hod4i0Cz3G4dKSfMtkuEqN9+4LVcnXDYXJRrF+YAwPGy/Ka9jQpLy0iOx
 QElsrqbWKcWYgD5zIHLaesa5/e7QOmc685dAcH4MA4TVPTqaTMMKqRhyo
 VmAbsHN2xxTIRCtRPm9gBO6+I0B0d38cpqYCJQYBnGd4PsV0rpNgkZfXI
 ixkJQRNrjvNhz7T7c8oJKolAD6NU1oSeHjZesGc1SQg6OiuN0ywNuK90i w==;
X-CSE-ConnectionGUID: sC2t/CyKT22RnbAj5Qh7+A==
X-CSE-MsgGUID: fw6JZvsqSaSkB48OZaMMTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="81785672"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="81785672"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 09:21:19 -0800
X-CSE-ConnectionGUID: m4L+ADGsSq2Aqdbxdi+qSw==
X-CSE-MsgGUID: YjXfLMQSTGqxZTi4RthCCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="187516846"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 09:21:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 09:21:17 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 09:21:17 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 09:21:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t45rZdIJ9moIQ3uw1EJcY1c1D7078tM8+3fENwhsMtZ690EZkSnEYLpk5eDTzJcXB5yGuW9Vrxf2PrjoC/QkBkBoL9rhTIvUe7fQxuHr1Is+t2vuLgFBL5nmQ77NKiBtvx2ga91LH6ThCisEpN2Mn/cGvmk5053v0mb2ix2QD1Ztm/PGwUBL2C6h9v9UQod3TFOwiiWGK4MfCje5ZtDLOwzYlV4FLUaFiV52B/KJVHhOn7BZH++Wg2crC/z5BBYMPlS/DFkEsVTiMy3FB/WcYpasw9lSOFztgjxlIQCBt0er54XGfj6Xd+w7bzEhKAMy34Iqu71ZdMqMiY/UpDx4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/7+Cn8nSNosK0lPF/ld94pHr7Gf8JwVo7mHdPJZ9yY=;
 b=Md/M4BC5i0Uj7mMMx7WsLTZRP2wOK1EK3QoghxjU4CiOnhOKEdH6yquTr5pxuGPisGTqzH06uip+gkrUDy3aTgsePsQv+epBDqxCpubL72oVdsC4hhMlHtqDmNFvFc1pzyzGxgk8PYQAdUEnEqIz8w6tFJ8IQ+um6x65ZNhU5DOMuArNgnyp92D6R5buuRAxw9A6WqORrD0TsUxgZHdqtaX1n72qe2XW/J1q6GLku95ypNSuqmIkI1rv7MOMS8iJ1AFHYMbunOSakjJRgGoFdVk9oOhm/QLW5mW1bP4qagpnT7Ph6s9IBD0oU4VFE8veMx8Jj8lN0o6dHq+mBRTImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB5777.namprd11.prod.outlook.com (2603:10b6:806:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 17:21:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 17:21:15 +0000
Date: Tue, 4 Nov 2025 17:21:10 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 2/2] net/iavf: fix single VLAN insertion positioning
Message-ID: <aQo2BiGru17VyD_j@bricha3-mobl1.ger.corp.intel.com>
References: <20251031152250.2441980-1-ciara.loftus@intel.com>
 <20251031152250.2441980-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031152250.2441980-3-ciara.loftus@intel.com>
X-ClientProxiedBy: LO2P265CA0421.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dbf79d3-5e05-40eb-4fe2-08de1bc68eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wZb3/+d7smL2J/2VS8gKQA0WBA0OOdHn0rxZIL+IP4oSt5oASnzgQ1Cw2HA/?=
 =?us-ascii?Q?go75M3gAeA6h9nixVKHfChnpHORQFXGCCBtBd7cR++ppxmv8yiB2IT8R0Vj9?=
 =?us-ascii?Q?ug+JHNYh4HmWltmKQrpkZmJNksFZ1kU+E2Mt6jOeNDQNoacWebBo5R3enPhC?=
 =?us-ascii?Q?udJqhP/XlE1gfFCdnyT3AKqQqQuVLeRwsb0SRhuaZAFgt/WlFvQ0zvw7Pdxl?=
 =?us-ascii?Q?/TbAIbBRjyjjGxZG0Ged3VzanHhQHv8rHUwdpTiPl3IF9kyx2gYUHB7ynZvM?=
 =?us-ascii?Q?PgwxSK6udf25FzZoVWZSuYWPLaWqm9uREHSzidofFTexE6rSjeZN/tzSV06O?=
 =?us-ascii?Q?VPLSDNKZSIQSNGfYDNlfajhrflgARCxidoEosf+YKoPgAnMT5aVkauKnmPCZ?=
 =?us-ascii?Q?+dioVXEg97qSB2c2xMRSegYyVEUFvXS45+bCfPe4jrdV9IqaxEH2+QyNYO2a?=
 =?us-ascii?Q?CkCH3+BW1nRnTV1ulsIVnaFgUaTzTq4UWfhkopTBqh3OzN07QiBaXfbijGa9?=
 =?us-ascii?Q?mvquSotahj9ZhJzpxSXx32BQeMPoaUp9gKpzoSLDb4xYLI+XBA2hBLtksVLN?=
 =?us-ascii?Q?+62yJXstJV/kJ2bOm9JrrAz2ZmO8gpRe5vz2dPG0AdtCs9LrULocS9gQWuwZ?=
 =?us-ascii?Q?7vWbsXApz28iF692j4KuLvmXwMgzuLUQfigZFIHp7OdCeeI4ifvPWyJpACBv?=
 =?us-ascii?Q?LrOrIbw1pT4xdmDgGtlJdHasnCBN1e9nKCu1oxfVWjXE3Xk+DGvuagDIfJoV?=
 =?us-ascii?Q?+cIS285nK+G8vBGQwbl77kyf9QKKQ3y5zR7W3ZmzWLfsuX7DyL6O6SLCeRhu?=
 =?us-ascii?Q?38a6FGu3m8xQFGBTjQBFEXcMuumQ7eDcxsAaHIv01frv3i8MUbfyKIgI0CqT?=
 =?us-ascii?Q?m6rvXl9SLejORjOuV/MNWCKl3VhMO/r7uYTu4e2yE0rRuejiZdQwbtdQI387?=
 =?us-ascii?Q?Sfi9OQmwjq0RpSSvkU8ACcJZNegI+r3wJYO5G4l3hkc9VmvbX1rSWDhQJMDo?=
 =?us-ascii?Q?cpdDe0cIe3jg+0p9qrNSkBNTjyipTgQerr2h8S04V5ZekhTodkKuy58xlqT9?=
 =?us-ascii?Q?Z8pjjx459FApeUuox5jZAY2sD/7a+OeEwTI4Yfx8uFb+VdOQMmAOrmlzz0yA?=
 =?us-ascii?Q?7YDiHGrSmRCdeKkXEyKlasP2SdqTpJo1G61yS/XUXRbHKImo1CqLsCLww0H4?=
 =?us-ascii?Q?plCFG0XqwxOq/W5xj/6d6wxGefO/QVY0ZB09gW5gDvzJkvo2A5LGGry9RjCY?=
 =?us-ascii?Q?U5WuUEzuOrTIF1bvzIiPVjjikgk098VFhSQhkMMWZ6kBoOGPzIsaBgyUs4lZ?=
 =?us-ascii?Q?Ph+tVj5H0nma5hMR8hI3ThCRvnO/17CjL6DdaklnXLS+8mhDwthQN+rFVJBR?=
 =?us-ascii?Q?uJ3qahR8qVUs5MfQHpF3SSJwN5w8BmQJZYfuhN2r0hMiHHM0zMk6KtUdlF9Z?=
 =?us-ascii?Q?jZbI7r+TfltOijKGDSE45nI6vs2nk8An?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lGOl7AGcfIgw4nD/AAAve92eBO9T9649Wi59CxO5sFce/IU2BObV4upb4gCd?=
 =?us-ascii?Q?RshTHT9LK8jVmgIG1HvxNcunxkiJvkjyQy/VqJSBj8vLsqrgnN99t/C/6gve?=
 =?us-ascii?Q?dHon6mDN/Tjjmng7dC/INQzE9b4yFP8LvXXdV79PYGP8WKtMzVcUVl4aJ4JS?=
 =?us-ascii?Q?ZLnRL5iM7AUkNxeYL16sybVy1MTSB+8u1+GctabOqVmgbxWDYLqEpLx42nMe?=
 =?us-ascii?Q?Z4RxZ9bwqdnrzecKXrZms1s44mxucW9lKvnndqmD26nA4Cf0rGRY+8Urm9qf?=
 =?us-ascii?Q?fB5KPoZ1PFfUXaxpIrI4uiw8jnz7WM1qOHe9695Yxs4zHI4Hy7yF8HGGQkSH?=
 =?us-ascii?Q?8WIEcX7Khiy9UANAj82MfkOazrp3nyhIVIob+ZKFa9t32NVTIE8AY58pn8X2?=
 =?us-ascii?Q?+grH2SXyfzVC7CpbVIHvpqwh18Nbo4ohrD4a9MGPxWsiiRVO1Goj4rYqvdkg?=
 =?us-ascii?Q?uIzhvTVjaFDxMNBXfY4CNTwZ0e9iIJBWVBA3MqvgejjtseSW03fjv4nZ8ox/?=
 =?us-ascii?Q?AoA4kLU8A/gRvLzFPhgUpBZTDnujuaF4rqcqgdM3y0sVoreSU867pJIsIjBg?=
 =?us-ascii?Q?rJW0VYi+/NzCXLUHRjstpZENUglkchnJ27e0Ag27pGZ7+9dx4+2a0y9pFXfC?=
 =?us-ascii?Q?0inbvAbMA9yauvCSvxQF8Du2ONCMMs86n35Lc+huQWBz+UiBI3f564ctORyx?=
 =?us-ascii?Q?HGmqz1ejpxZzIjE62Uf3koupvt7DSkWizlSMh/0LlCYslo2qS0jIyhKtdkVE?=
 =?us-ascii?Q?wtsgdXx2VzFwMuyvhoCOqRv8IRWfwPFqNMNX7jK7Qr0V8xaVSYzq2ngE4VGB?=
 =?us-ascii?Q?u/+mB1Af0nZm75oWs7WTLIaap/gAaguJU/qmsYdd8Wf5ccuyn1NaX9ND87QI?=
 =?us-ascii?Q?hgLNxrb44Ousyz04YNWraoySBuAkkGCCtLA3oBzru11VLZafCg4ekVmDukpK?=
 =?us-ascii?Q?QA46JIlP4Y2KQb+WiUSjY1TTPq4xwBaVYIhNjS701dpDThZWv5RZMJON8CTc?=
 =?us-ascii?Q?wzqysF5H4Nf4rFp1HHZZIun4nwruej5I9WyA9D8aLTyHJpUaMExZuLsJ8Xst?=
 =?us-ascii?Q?7x/ASYVYMb4UAoYPROKvWVBusAVDYIxN2CJGnUtI0iITUCOIl1ae8hmhaLUT?=
 =?us-ascii?Q?rgff7jpr1GkxVd2YxmB+9c+Wn04pgQb5ZhsNjKuzhiqxxAycI7WGtRPgitSm?=
 =?us-ascii?Q?LWsy/wswNR4iGNxWleRTl/Vimalvu5rVCjEgw0rtDnXG/ATZHBeNdGX4yPMZ?=
 =?us-ascii?Q?nRCqs3w8GNxN57J89FVODKRgdo6PSy+KtJuDxGCkvspZEBzbpjHzd8/rRO7D?=
 =?us-ascii?Q?YE8PBjaTeTXr7az8erypoyIIqdXMWucfxy1Gz1G8jquFX74x95OK+eK8Pn6D?=
 =?us-ascii?Q?/H+ueX+Arp0jyw+igCp0h62jccwddtYHa2fU9KEHnAV5X/MHx1PDrIxsz2gn?=
 =?us-ascii?Q?EmCBTzZLgNlOwk8EMNuiwG23oGVqf3VtmKOmVHlujNkk88xK8KoeZolmi84z?=
 =?us-ascii?Q?fxyJQw+oOrHjJx94AbGUzWDEfgaa5n+z8lkxrKf4hxyaT0+Ht2XMjp/c2WdD?=
 =?us-ascii?Q?pot0INue9TbfNtNTUTpT2Gn5oRvM6oVJ/9yDbwqBft8yeisJY11SsXARphIO?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbf79d3-5e05-40eb-4fe2-08de1bc68eea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:21:15.0365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +C4pISlguiNtJQoRtB7cat/0cdR2Y+4fwRy6EnqbuSNVDLOJDl0pOcdOB8nkWuFNE6bB39wlP9Vr+Yxh1P7qBKBldlCm7yKWbUFZRNJ8nPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5777
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

On Fri, Oct 31, 2025 at 03:22:50PM +0000, Ciara Loftus wrote:
> Commit fdc37964c2bf ("net/iavf: support QinQ insertion offload in scalar
> Tx") broke single VLAN insertion offload in cases where the v2 offload
> capability and both inner and outer insertion were supported because it
> caused inner VLAN tags to be inserted instead of outer.
> 
> When an iavf tx queue is being set up, if v2 offload capability is
> supported, the driver queries the insertion capabilities and takes note
> of where VLAN tags should be placed in the transmit and/or context
> descriptors for insertion offload. In the offending commit, when both
> inner and outer insertion was reported as supported, the flag
> "vlan_flag" was changed to hold the location for inner VLAN tags.
> However this caused inner VLAN tags to be inserted in the case of single
> VLAN offload which is incorrect behaviour for this use case.
> 
> To fix this, revert the "vlan_flag" back to holding the location for
> outer VLAN tags and update the datapath code accordingly.
> 
> Fixes: fdc37964c2bf ("net/iavf: support QinQ insertion offload in scalar Tx")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

One suggestion inline below.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> ---
>  drivers/net/intel/iavf/iavf_rxtx.c            | 50 +++++++------------
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 24 ++++-----
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  5 +-
>  3 files changed, 32 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> index a3ef13c791..66f718424a 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -799,32 +799,17 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
>  			&adapter->vf.vlan_v2_caps.offloads.insertion_support;
>  		uint32_t insertion_cap;
>  
> -		if (insertion_support->outer == VIRTCHNL_VLAN_UNSUPPORTED ||
> -				insertion_support->inner == VIRTCHNL_VLAN_UNSUPPORTED) {
> -			/* Only one insertion is supported. */
> -			if (insertion_support->outer)
> -				insertion_cap = insertion_support->outer;
> -			else
> -				insertion_cap = insertion_support->inner;
> -
> -			if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
> -				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> -				PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG1");
> -			} else if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2) {
> -				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
> -				PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG2");
> -			}
> -		} else {
> -			 /* Both outer and inner insertion supported. */
> -			if (insertion_support->inner & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
> -				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> -				PMD_INIT_LOG(DEBUG, "Inner VLAN insertion_cap: L2TAG1");
> -				PMD_INIT_LOG(DEBUG, "Outer VLAN insertion_cap: L2TAG2");
> -			} else {
> -				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
> -				PMD_INIT_LOG(DEBUG, "Inner VLAN insertion_cap: L2TAG2");
> -				PMD_INIT_LOG(DEBUG, "Outer VLAN insertion_cap: L2TAG1");
> -			}
> +		if (insertion_support->outer)
> +			insertion_cap = insertion_support->outer;
> +		else
> +			insertion_cap = insertion_support->inner;
> +
> +		if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
> +			txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> +			PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG1");
> +		} else if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2) {
> +			txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
> +			PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG2");
>  		}
>  	} else {
>  		txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> @@ -2600,12 +2585,11 @@ iavf_fill_context_desc(volatile struct iavf_tx_context_desc *desc,
>  	desc_qws->qw0 = rte_cpu_to_le_64(desc_qws->qw0);
>  	desc_qws->qw1 = rte_cpu_to_le_64(desc_qws->qw1);
>  
> +	/* vlan_flag specifies VLAN tag location for VLAN, and outer tag location for QinQ. */
>  	if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
> +		desc->l2tag2 = m->ol_flags & RTE_MBUF_F_TX_QINQ ? m->vlan_tci_outer : m->vlan_tci;
> +	else if (m->ol_flags & RTE_MBUF_F_TX_QINQ)
>  		desc->l2tag2 = m->vlan_tci;

Minor issue, but the expression of the logic here is different to how its
worked in the previous patch code. There we check the QINQ or VLAN tag
first, and then have a condition based on the L2TAG* flag. Here we check
the L2TAG? first then switch on the QINQ flag. Can you maybe rework to have
all conditional checks for this consistent?

> -
> -	if (m->ol_flags & RTE_MBUF_F_TX_QINQ)
> -		desc->l2tag2 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ? m->vlan_tci :
> -										m->vlan_tci_outer;
>  }
>  
>  
> @@ -2660,11 +2644,11 @@ iavf_build_data_desc_cmd_offset_fields(volatile uint64_t *qw1,
>  		l2tag1 |= m->vlan_tci;
>  	}
>  
> -	/* Descriptor based QinQ insertion */
> +	/* Descriptor based QinQ insertion. vlan_flag specifies outer tag location. */
>  	if (m->ol_flags & RTE_MBUF_F_TX_QINQ) {
>  		command |= (uint64_t)IAVF_TX_DESC_CMD_IL2TAG1;
> -		l2tag1 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1 ? m->vlan_tci :
> -									m->vlan_tci_outer;
> +		l2tag1 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1 ? m->vlan_tci_outer :
> +									m->vlan_tci;
>  	}
>  
>  	if ((m->ol_flags &
> diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> index c800ae29e1..6f150cb1c1 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> @@ -2136,17 +2136,17 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
>  		if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
>  			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
>  			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> -				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
> -				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
> -							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> -				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci_outer <<
> -							IAVF_TXD_QW1_L2TAG1_SHIFT;
> -			} else {
>  				/* Outer tag at L2TAG2, inner tag at L2TAG1. */
>  				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci_outer <<
>  							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
>  				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
>  							IAVF_TXD_QW1_L2TAG1_SHIFT;
> +			} else {
> +				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
> +				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
> +							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> +				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci_outer <<
> +							IAVF_TXD_QW1_L2TAG1_SHIFT;
>  			}
>  		} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN) {
>  			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> @@ -2166,17 +2166,17 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
>  		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
>  			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
>  			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> -				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
> -				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
> -							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> -				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci_outer <<
> -							IAVF_TXD_QW1_L2TAG1_SHIFT;
> -			} else {
>  				/* Outer tag at L2TAG2, inner tag at L2TAG1. */
>  				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci_outer <<
>  							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
>  				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
>  							IAVF_TXD_QW1_L2TAG1_SHIFT;
> +			} else {
> +				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
> +				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
> +							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> +				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci_outer <<
> +							IAVF_TXD_QW1_L2TAG1_SHIFT;
>  			}
>  		} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN) {
>  			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> index bf8faf3632..86523a7d2b 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> @@ -227,11 +227,12 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
>  #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
>  	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
>  		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
> +		/* vlan_flag specifies outer tag location for QinQ. */
>  		if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1)
> -			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
> +			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer <<
>  					IAVF_TXD_QW1_L2TAG1_SHIFT);
>  		else
> -			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer <<
> +			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
>  					IAVF_TXD_QW1_L2TAG1_SHIFT);
>  	} else if (ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) {
>  		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
> -- 
> 2.34.1
> 
