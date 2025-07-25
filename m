Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC47C87FCE
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 15:22:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FA19402A8;
	Fri, 25 Jul 2025 17:22:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8FE0B40144
 for <dev@dpdk.org>; Fri, 25 Jul 2025 17:22:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753456940; x=1784992940;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Rmi381v5rV6FRUq1fOln9TUivZ0cKDllDSwVAPKUHq0=;
 b=YpG4LvfPj+2QjuBzvx679fjJ1Y7xqnuzqRtTLTRYrsEMVcwf4ndhyvOd
 ABBpXZxxjk0l4bL1rvXRpOOyK6usJrxDgqRuZF5eG1zmcrnouKqn1BznU
 D+K/7pq320FkzA69LX8h8Oov1r6jp+XXuGB2zDjxUryykyx/q0RJrbS/7
 Oa/blLMLdStNZIRmIi3AhmkfVaKGe+MusGCu4sSNt26PEgrQHBBBhyO86
 3mrv8V9oXDoSPBzoZSNenVc+6346zj27bE/EyobDLWic/X47qECzl2yJ4
 KxOXJBWOIbJonF/T+9hKOlvuLoG7B6En6tCHS0Y7bn/ToO7Y0Lt4i8lma Q==;
X-CSE-ConnectionGUID: r/hdHj7VQfm+10Rlg1elkA==
X-CSE-MsgGUID: +T4b4W8bRNmZvUQrthPdcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55006105"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="55006105"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 08:22:19 -0700
X-CSE-ConnectionGUID: 3enOGl7ASqi/Uk4vXmI3kQ==
X-CSE-MsgGUID: GHGiM65fSNaxkj5E+n7mHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="160709675"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 08:22:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 08:22:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 08:22:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 08:22:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5dkr4kX9oShutXegpuJul0S8rDDSAfqP6QW09mJwk5r/JAdCCPQY0OtlpP0iHfbTK264QARNFs6rxnm+qemF/XLW7Khwhai/ocZawvew9SOoJex6k+3DvWGpkP8OUp7M6eXgKTgIcEwVue7MpHnx4q3fMRgY/eyrDuV2EkBpJxebgVq03T+drFx/Lj2r9Y4R4Bl/z/85W2hwfts2+kcfNC8/DzI2C1wQMy+G4yQ3pd9GWmDuh3LxvqXE1d8FQv/zaPn7FWQCB1ecqVdO99ktWxjqp5FKx8f0WM0ITDRopkSPBAzCdS5hJzvWxy+pzO0wut4hBH36BgIxKCcc8TD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIW1DlBBM57kCXx0oWj7geIpMNTqrUKB8TW6Y552SSY=;
 b=VPwe9Odb5qo9AfLRF8WSyIDqNqTWyZqifqVCp6o4ltfVXa2hMwDXUyfxaRX17daEl81Xu5P6hP7dRZZh92MWMTqmBSsDvfX/+ks0E5dLbGe/ZLjSXj8Qv6Zl4dTR1K3OShW063+KOaGfiq9dyAZkw+wIVotyUL48FniK5i5QnpEiCVHUgamvmQQHvMZUDB/bzOjZtHkP6j+RwAThG/4EkKE57kc9tldm10npyCIuwDfKyBr7cVxDUvMEGoxTzSTbNE34M30ecKEiCOg8Ei6aBdjFcBYGGbgDGQlq2lKIB0PTsf3VBcoocJVbO6BmWxmvIztrB33lriydSH676HZOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 15:22:02 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 15:22:02 +0000
Date: Fri, 25 Jul 2025 16:21:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 10/14] net/intel: introduce infrastructure for Rx
 path selection
Message-ID: <aIOhFIwIpdo1nghY@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250725124919.3564890-11-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250725124919.3564890-11-ciara.loftus@intel.com>
X-ClientProxiedBy: DB6PR0301CA0077.eurprd03.prod.outlook.com
 (2603:10a6:6:30::24) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|IA0PR11MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b515b14-dfa7-4298-e30b-08ddcb8f01a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o6pYGso3Vkgpw0WrXp/NHkyn0QgZudqy6Q7+eZIDrW66tPx+Mjt7+x7GCSVh?=
 =?us-ascii?Q?esPHgR5oQGegfqs2A+vj0Wxf0oH3UOjUHRCbAvnM+rX2VPSxjtGzMxpWILx9?=
 =?us-ascii?Q?AT7m84SODm8NStMRB5Y8FHHE/+MofH6BgX+3C8YAvqBhTk+AIfSOVBttvg1H?=
 =?us-ascii?Q?2nP4SesS3wQuZd9SYL4wh8qeNdW1JdDD/uS3wVnmJpQe6IujQRLEQ2IkXmTr?=
 =?us-ascii?Q?HG/NIfzSagS06aP/Q2ec7JeI0o4NFffl1ayNKWMq/z+pRUL86ovFn0/kifLS?=
 =?us-ascii?Q?mnmz3gkBzm9Jt2QCO5D8o5zcNdMZqk7tK3UYPbSJASF3aBzpwlZK0xehFDXY?=
 =?us-ascii?Q?7JNVJ+eoDTHNIHoBxfIrv1k2Uq9kWyWOADvQcd9BxX9frnDdeP0g+UoZMsBS?=
 =?us-ascii?Q?5wanwE9TqJ8ZFchMz0IeUkQ9GFQhoJRAMT0AbHKHKNjdHjH8GoLxvIWIGDt8?=
 =?us-ascii?Q?1neUx6WGIy4q0PAqoQ1rW9/YbnXT5EQeADbqDPCTL2FvTS5C8vHlG8shlWh5?=
 =?us-ascii?Q?oWjp7qP4HkdBRwqjNS+mrGPhRcmIyPY9eDhIMQ3XzC7P6LjLY49BoHRQRJVm?=
 =?us-ascii?Q?lS2o5A2V4vDTICbDma0uFgwtXaY/7BIGZ1kDZ508ASi13OPV1uyT8KKvucZg?=
 =?us-ascii?Q?ICfe0Jqt80vR6bdu3S8CBkIiYG+ncf5su1Rw/O/v487ssJP7FKd1x0Xy/H6h?=
 =?us-ascii?Q?N2u6Q6xVP36Aml8e79TXeDoNSZ0NFqVHikdRRdxLlWH1ODcB3mCKBVpsF6Sw?=
 =?us-ascii?Q?ob/jmj9fSHirXgILrBPwDG/UV2wbcTSpdImHuSfq0NKwOIsmPiMrMGLhyncu?=
 =?us-ascii?Q?Fl0qL0vjCX+ABdytsqzY8kMIE9kGIEc93VIzqMCAbdTlWkfSAuWWTYZqD2om?=
 =?us-ascii?Q?8yu4t59d1o1es3gcePoPfOJmUyILlSySsJkkjSRfV3HbxuBAwb35EPy6hRuc?=
 =?us-ascii?Q?jKwuJ0/OHZg+U1YWtzUsHAnsiQfsfitb2lzfckyJ6y1Dj4y9oVRmQwwIN4VG?=
 =?us-ascii?Q?pLOR998VTkONf/BGmVtaP0IiVPnnGeWR/r0GIZR0oYJZ3X+O0yZPMHVBgzX3?=
 =?us-ascii?Q?nH9BVkm9/p7PnJMvQ4BdcenWC0Gb39hA6vKk47CoSv91zMfwB9CHcatg5DQW?=
 =?us-ascii?Q?ENrhaHa7rCErY2R81gyXexIZWS29zOVYJSSqFS0+aQcO1L/m2meD7ZYvNCQp?=
 =?us-ascii?Q?5XeZwE9WYidhybi0NMTlCNWEwD2I3GCoIS9Sw+4cIW7WRcPVvC/TVAKN3Z0r?=
 =?us-ascii?Q?Bh8Hn9QL53jIDesWo0Q9Nx/t1oxjBjRe7mY0hFbNcY9JDtU5YGG5jGWevkhA?=
 =?us-ascii?Q?9h77gYIP+mlApbVBOf9pWJTCORufQmCuGU91AD2f0Z7Q9D7xvPq8/mFnO0AB?=
 =?us-ascii?Q?70EzizWesQCebBbkKe7ZoTAd3TJBpSjpJajB0Ck9KeLVwrlhnAkw1AEPgDZA?=
 =?us-ascii?Q?4yADqaSfhZI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sdXq9vk6+bj/gFFNVj6rANbkb6G9vacOsL/jOo4lA3Dxj3nQjy0SZyFbvOhX?=
 =?us-ascii?Q?Oe7zeulPCmO6U/PxkcMpfY7ErMLkFmhxfficixeMB5RMVHL7fckRA4VNOyr1?=
 =?us-ascii?Q?QVHeTWQmPtN1+eeFAcQ/DwbFaE0zlF4NjRNIl7+p7DMkdAIi8l4PXumWuLts?=
 =?us-ascii?Q?ce/WE6KXKYtjjkf9qFljZC7QCO55yfUMKyfRPemgdxX5GWTYxHBIi3xozKPm?=
 =?us-ascii?Q?zXovl31a57cckmtO8E8RnTg4SW3DfYrjdld2K2jCQpVEH4xBlcSoI45CMWua?=
 =?us-ascii?Q?qjyZ8z8Kgv54zqdYEHGra3ndJAMyNxxOiE8rp1FxSzE6Xka55wDCfhlLHgfg?=
 =?us-ascii?Q?VDC3XdtZWFhHzqy85fZsh36lOxXLteAMUyO2ljfEZLGJrvH12Cbl5yjpR+U5?=
 =?us-ascii?Q?L1fei2QBvM2PndaY8CkJQ1v3SE7LUZKpUpM9hn4yF96R8MaRdvk54E2yi17G?=
 =?us-ascii?Q?cYF0nu0MAGT0eRiTJwraHFxrW+q4JnO1XLGf3Yhc7DnnZNvTN/mYhKYR9obb?=
 =?us-ascii?Q?AMTK68oSQpH72tjlqq0Gs8K4rEKCheJlnSnOYc0LG6TFg9lzJqS4BgcdNUgG?=
 =?us-ascii?Q?MjIDIApZL9h9WY8ke9ZDwfeHMUC5UakD/mM37TOQN/usK/ZSx2Gd07Tvxe8c?=
 =?us-ascii?Q?GaMR5P892DrSJKIfoCzzDhxYR7owtc/c2zBl2zzp/kcUKtuWhf2KefugWyE5?=
 =?us-ascii?Q?TiKqxj6Ml88Gx00oTqkAvILk6PCMo5owPBKvgQLc7YB8kR5PiiYHa11wLQ0k?=
 =?us-ascii?Q?f0m/+6sD7o2JwVByiY2oUnoUWRebykox6Hf05iZpnqfoMYfgGJ9fWokDsC7N?=
 =?us-ascii?Q?9kCLjzvWX2agOr6jDx2JatUTQz7JQ36Vs2rNX9+gOplCARtuvoiIxqT2mNRr?=
 =?us-ascii?Q?8UKfJLlemUBqwSa600v0s5vV9Yff70CCMqT87qQx5XbUbDEzx8XAx7PQOuWp?=
 =?us-ascii?Q?uvenEqVcCobaE9fZWGmsyEIuKQs8EbpKPYQL/W0IBRHTaT6PMqkzW/E9u498?=
 =?us-ascii?Q?83ILNwqEaHhOmn1zZGO7r9r70D7lc/PgES68xXyM95OaYkGJN1TcWEv8jk/k?=
 =?us-ascii?Q?27Y53Se5YuLLg4OboXB5xih0Y2AgQoT2tyzvg79nKVGBCpVCr0pSSafIU4oZ?=
 =?us-ascii?Q?CxFFioWn9GCiCh8EguGP7MbmSAK9cNJuxHqUB1LlN/kehBH5AohYCa5KuDt/?=
 =?us-ascii?Q?DWDSxWPJK3MF6Y5qbutgrk8zKU2vAa+ALMTKR7DQXYMoaPRfeKwCKdQxAjTy?=
 =?us-ascii?Q?fr1deUD7aTILjU/kJqlYZWVfWillN4LQBPMeljSs2yrm31KDaFaUZ/5g7m+6?=
 =?us-ascii?Q?Pp6we9NOKntx/vHDeLt/CooBuWYsBIN8ZMYHotzGYtMikeC3ifQfG56Z3x+q?=
 =?us-ascii?Q?5fuqHWI2VRQ2jhqZWqN2G9YgEN4jMT2sOKsL7CAIg/7juKKy2qDg7t7Mk2fx?=
 =?us-ascii?Q?qhl0owvQ0P/nq3Ty6q4BpDLgU+j3HjxHHtipjpO4WtwwVJ7HBECn5Xx8QasS?=
 =?us-ascii?Q?gPyGxUZTo314G1jCtNYIlzfzoIrQUQF9+/Y3Oi7CnEglqSOnDXjtqb7UZB/N?=
 =?us-ascii?Q?H0nDdVYn0xGhvEvblYt8jdVYOrrrJ9VvtztfmJW3WW1veCXeFX6+Q59Lvx0n?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b515b14-dfa7-4298-e30b-08ddcb8f01a1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 15:22:02.6986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9d1xF2GyM4RvVMSrkZoBZ90+gy5AqWQQvvu/EUnHUzFK45uQEg/B10PtwpfMneRqFA7ShCgbMnh0l4PaJvyepgk3gU6F0+WPEHqTtXiCzwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7185
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

On Fri, Jul 25, 2025 at 12:49:15PM +0000, Ciara Loftus wrote:
> The code for determining which Rx path to select during initialisation
> has become complicated in many intel drivers due to the amount of
> different paths and features available within each path. This commit
> aims to simplify and genericize the path selection logic.
> 
> The following information about each Rx burst function is stored and
> used by the new common function to select the appropriate Rx path:
> - Rx Offloads
> - SIMD bitwidth
> - Flexible RXD usage
> - Bulk alloc function
> - Scattered function
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

This is a good idea to simplify things. Some comments inline below.

/Bruce

>  drivers/net/intel/common/rx.h | 110 ++++++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
> 
> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> index 70b597e8dc..6e9d81fecf 100644
> --- a/drivers/net/intel/common/rx.h
> +++ b/drivers/net/intel/common/rx.h
> @@ -10,6 +10,7 @@
>  #include <unistd.h>
>  #include <rte_mbuf.h>
>  #include <rte_ethdev.h>
> +#include <rte_vect.h>
>  
>  #include "desc.h"
>  
> @@ -20,6 +21,12 @@
>  #define CI_VPMD_DESCS_PER_LOOP_WIDE 8
>  #define CI_VPMD_RX_REARM_THRESH     64
>  
> +#define CI_RX_BURST_NO_FEATURES		0
> +#define CI_RX_BURST_FEATURE_SCATTERED	RTE_BIT32(0)
> +#define CI_RX_BURST_FEATURE_FLEX	RTE_BIT32(1)
> +#define CI_RX_BURST_FEATURE_BULK_ALLOC	RTE_BIT32(2)
> +#define CI_RX_BURST_FEATURE_IS_DISABLED	RTE_BIT32(3)
> +
>  struct ci_rx_queue;
>  
>  struct ci_rx_entry {
> @@ -125,6 +132,19 @@ struct ci_rx_queue {
>  	};
>  };
>  
> +
> +struct ci_rx_burst_features {
> +	uint32_t rx_offloads;
> +	enum rte_vect_max_simd simd_width;
> +	uint32_t other_features_mask;

Rather than using a bitmask here and having to do bit ops, how about just
using individual boolean variables for each setting. Given that we only
have 4 settings right now (disabled, scattered, flex, and bulk-alloc), the
actual struct size here will be the same, but the code will be simpler.
Since this is not a datapath function, I'm not worried if the overall
struct size grows a bit over time.

I'd also note that in the structure below, we need an extra 4-bytes of
padding anyway, since the pointers require it to be 8-byte aligned, so we
can have up to 8 flags in the rx_burst_features struct without affecting
the size of the burst_info struct.

> +};
> +
> +struct ci_rx_burst_info {
> +	eth_rx_burst_t pkt_burst;
> +	const char *info;
> +	struct ci_rx_burst_features features;
> +};
> +

Just on struct naming - would it be better to use the word "path" instead
of "burst" in the struct names, as in:
 ci_rx_burst_features -> ci_rx_path_features
 ci_rx_burst_info     -> ci_rx_path_info

Given that the mode_select function below takes as parameter "num_paths", I
think this would make the names more consistent and meaningful.

>  static inline uint16_t
>  ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs, uint16_t nb_bufs, uint8_t *split_flags,
>  		struct rte_mbuf **pkt_first_seg, struct rte_mbuf **pkt_last_seg,
> @@ -222,4 +242,94 @@ ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh, uint64_t offloads)
>  	return true;
>  }
>  
> +/**
> + * Select the best matching Rx burst mode function based on features
> + *
> + * @param req_features
> + *   The requested features for the Rx burst mode
> + *
> + * @return
> + *   The packet burst function index that best matches the requested features
> + */

Missing doxygen documentation for some of the parameters.

> +static inline int
> +ci_rx_burst_mode_select(const struct ci_rx_burst_info *infos,
> +			struct ci_rx_burst_features req_features,

I would swap the order of these first two parameters, so that the request
comes first. As well as (at least to me) making more sense having the
request first, it also means that the "num_paths" parameter immediately
follows the array to which it refers.

> +			int num_paths,
> +			int default_path)
> +{
> +	int i, idx = -1;
> +	const struct ci_rx_burst_features *info_features;

This can be defined inside the loop.

> +	bool req_flex = req_features.other_features_mask & CI_RX_BURST_FEATURE_FLEX;
> +	bool req_scattered = req_features.other_features_mask & CI_RX_BURST_FEATURE_SCATTERED;
> +	bool req_bulk_alloc = req_features.other_features_mask & CI_RX_BURST_FEATURE_BULK_ALLOC;
> +	bool info_flex, info_scattered, info_bulk_alloc;
> +
> +	for (i = 0; i < num_paths; i++) {
> +		info_features =  &infos[i].features;
> +
"path_features" is probably a better name for this, since it refers to the
current path we are examining.

> +		/* Do not select a disabled rx burst function. */
> +		if (info_features->other_features_mask & CI_RX_BURST_FEATURE_IS_DISABLED)
> +			continue;
> +
> +		/* If requested, ensure the function uses the flexible descriptor. */
> +		info_flex = info_features->other_features_mask & CI_RX_BURST_FEATURE_FLEX;
> +		if (info_flex != req_flex)
> +			continue;
> +
> +		/* If requested, ensure the function supports scattered RX. */
> +		info_scattered = info_features->other_features_mask & CI_RX_BURST_FEATURE_SCATTERED;
> +		if (info_scattered != req_scattered)
> +			continue;
> +
> +		/* Do not use a bulk alloc function if not requested. However if it is the only
> +		 * feature requested, ensure it is supported in the selected function.
> +		 */
What the is benefit or reason for ths second part of this - checking if
it's the only feature requested, vs being requested with other features?
Can you please explain a bit?

> +		info_bulk_alloc =
> +			info_features->other_features_mask & CI_RX_BURST_FEATURE_BULK_ALLOC;
> +		if ((info_bulk_alloc && !req_bulk_alloc) ||
> +				(req_features.other_features_mask ==
> +						CI_RX_BURST_FEATURE_BULK_ALLOC &&
> +						!info_bulk_alloc))
> +			continue;
> +
> +		/* Ensure the function supports the requested RX offloads. */
> +		if ((info_features->rx_offloads & req_features.rx_offloads) !=
> +				req_features.rx_offloads)
> +			continue;
> +
> +		/* Ensure the function's SIMD width is compatible with the requested width. */
> +		if (info_features->simd_width > req_features.simd_width)
> +			continue;
> +
> +		/* If this is the first valid path found, select it. */
> +		if (idx == -1) {
> +			idx = i;
> +			continue;
> +		}
> +
> +		/* At this point, at least one path has already been found that has met the
> +		 * requested criteria. Analyse the current path and select it if it is
> +		 * better than the previously selected one. i.e. if it has a larger SIMD width or
> +		 * if it has the same SIMD width but fewer offloads enabled.
> +		 */
> +
> +		if (info_features->simd_width > infos[idx].features.simd_width) {
> +			idx = i;
> +			continue;
> +		}
> +
> +		/* Use the path with the least offloads that satisfies the requested offloads. */
> +		if (info_features->simd_width == infos[idx].features.simd_width &&

I'd probably make this an "else if", since we don't want to bother with
this if we have just updated idx based on the simd_width.

> +				(rte_popcount32(info_features->rx_offloads) <
> +					rte_popcount32(infos[idx].features.rx_offloads)))
> +			idx = i;
> +	}
> +
> +	/* No path was found so use the default. */
> +	if (idx == -1)
> +		return default_path;
> +
> +	return idx;
> +}
> +
>  #endif /* _COMMON_INTEL_RX_H_ */
> -- 
> 2.34.1
> 
