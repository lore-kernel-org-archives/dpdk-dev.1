Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A27CC36011
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 17:56:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9E044028B;
	Fri, 28 Mar 2025 18:56:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8577D4021E
 for <dev@dpdk.org>; Fri, 28 Mar 2025 18:56:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743184588; x=1774720588;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ShjoTmN4ZOcI38/sXDG9kSIyQyPwMQGtIK4SkKDdw1s=;
 b=HIAMMJ+Oh8xlvKa30A888k7ZgkFgFAHSMjLTlSSMu6y9PaTCvzfISXWF
 wu83mCFVECPzT8c1MMbdyclRqz/Gl2yOglW5+WvAq07ijq05N7nHIGejW
 LuWf5Dznkt1qNJvr54SYsXj7Id2nqWjAlCQyC0/yT64VJD6/rbsyWen2u
 cpm2P9xY3yzFONZnZA5B75WaugC10qtLhn77oEGLJtXdJrLIPiaF0HKJV
 imoe6e4UGBfRQ6lqqJlXn+wxcgOI+M91GYK+FhmYl530Ef3+cH035EM2U
 ZNn2JJ49SkKNPdOL4GohUEHFIiQLqFQpRFYhj2FOEzoaIH7ZpTQEL/6t9 g==;
X-CSE-ConnectionGUID: 4SuJeVSuREGzKm8DDjGg6w==
X-CSE-MsgGUID: cwVHq1HWQFiOKSGho+Kb+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="44449341"
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; d="scan'208";a="44449341"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 10:56:26 -0700
X-CSE-ConnectionGUID: Ii+ATwL3SviuHSuCg/ly/w==
X-CSE-MsgGUID: yUB8bYMJSmWigGEdSv5RDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; d="scan'208";a="125273188"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Mar 2025 10:56:26 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Mar 2025 10:56:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 28 Mar 2025 10:56:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 10:56:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S83xQ7yAYMhDbhFsZG2vy0jc6unycO1fweRkgGEJIgUN3i7dKqBYNkhp7ddQuY0GZkTaQPH0LcyO9A++uuktcbck7dKqVJlRu0nQb7zY05g717GZye0vTVXOds2c7JlzOP1luFebyJrQSyWbJ+DFJVkvQEN99JYmJi5YQxlil8RFLC9CAUvLts404n5l1P1XH90ffpDCkWFGyuy0KQAX6HgkcPwt3kO9G3zXjqWjt9digMjsjpcszsFvZHfUogfEq42m6U+OZ0m58Q3Rp4JHI2k6JzOJJLgYquWKQdIGtqMDP4G0EMokq31RSL1vF88aq0k7+HEUsuzgIaU2HkU8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUHKKVS790ov5li7osQRC3KFP+le0klbJ8ophVY+cBs=;
 b=G7QGH7O4fE8lnLxj/AevCkZZA/SR3ZGekopyWknp7FV5IBCEwsEBtfDxTm1qjp8VaC0ruG3FcYsVt8OrKeZ4K03JMmCSGy6XR7EG9bRNsN6KnlGqTq6M3iQXYFhkEmcRypzVUjPiMgkJnFYgAJjZjROewTIb+CkrlbKjDcDLiIllzJhVziUnfTIgERMxIilgfakIPLmbZeYeuKsEKNEcPnFi+lPxmkOroP1j2Qe8cnnYWgS53CoTZfdunYriMk3htm8PAPGfKZs1nMkU94KFB+Vp+Tm9tYlNM4aQNb2/zdBLKvUermpWfCRKqTubKOYLdCsOTWSsMdJdzsnbwRVWZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 17:55:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 17:55:42 +0000
Date: Fri, 28 Mar 2025 17:55:38 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 2/4] net/intel: use common Tx queue structure
Message-ID: <Z-bimvWROM4gy8qj@bricha3-mobl1.ger.corp.intel.com>
References: <20250327104502.2107300-2-shaiq.wani@intel.com>
 <20250327160437.2296127-1-shaiq.wani@intel.com>
 <20250327160437.2296127-3-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250327160437.2296127-3-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a00706-1adc-4a7d-ef92-08dd6e21c209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BrbY2G2X8rxqnJGkpfwJpF/rSB5i9pkf7itV1b06SNldCm+7AGFdb31rEmcd?=
 =?us-ascii?Q?99RFLZ2hUdYcO9jEzUFZMWsLiYF9PLxHTdO/Jqk6pKT2LTisG40Pq/v5J2vd?=
 =?us-ascii?Q?g0vnOQ/yy/pmj+Uvf06HRCXuMM2B87qBh09C5E4zSEIMdK9js8s11pti6JkJ?=
 =?us-ascii?Q?bv2fxB/GPWL+v9gQ7I8SzFRLPGEYe6xA8TlQ/WCapqHX48JcGeRPdSHxYzoD?=
 =?us-ascii?Q?tepkFVv1Ehhp9f6IE7i7h7HbSJj27dV9COtGr3jGQ6i4YacO+SKH/qlbncdE?=
 =?us-ascii?Q?3pV9cZL96lsAhLRFBDwfqnA2LT0QEzT+lXgjpu2bnIAJ0iaW3fWBLvlBzTvL?=
 =?us-ascii?Q?nEPmoWXN0riBcsDsFgAci7JPcpK+DPnD1HcclcA08RWB/LJ1Wb7mRH7xhU8D?=
 =?us-ascii?Q?ZF4/hPyUNJv9NN5b5U8w3lejQV3jffp4lDPU6StOAarE4TDFMIJ230F6xpmp?=
 =?us-ascii?Q?hAzkv+FwM587bVL2IvvXbJGXJzDA7L/8f/mmzFyKgaDsCBXUwWrLLKTHdOXM?=
 =?us-ascii?Q?+71ZnuYyqZDhe3u2JW5ETeH+1Sh38yT6XpfTkhfmwBS1F/Y+8WlYd6hR7YnL?=
 =?us-ascii?Q?btX2qi3xvtjFlI140Qztjx9FaJiJfNz4YbW92T/p7Qv+PaWNVH4l15h5puXd?=
 =?us-ascii?Q?f9vWWN+UJ5913wbRYoSbwObN8hf8RFo50zvJCeCgmb0zUlWxlCiE19EJue2N?=
 =?us-ascii?Q?zT8G9trAD+1UE4kMTZlhapuNW88tCCimJ96u/7QSiC/vMb7tPQNxy8ztevF4?=
 =?us-ascii?Q?3LpxSm+AxodZGe48hCCqCXWAt3uITDrpIbXMUWCqeoJgTgBMZXZIB3DyqnYf?=
 =?us-ascii?Q?M6JVBZGrQ+DUyYMjCegtdXLTMDbdzi8Z3i4pH+GV4XDwfn1KJteqKbk3mDzx?=
 =?us-ascii?Q?DNnrBJO0c/+Yl8tPtnkDpF4eHhmaMbfEoFRUy3DpHwDKXF+onJJEdFQS7o6j?=
 =?us-ascii?Q?TZMG9Q/wzF+dDvoqzgMCCm+74ENCdY57YzylpqI0c6HN+MK4GrrMaXydeluw?=
 =?us-ascii?Q?CLoLgBEIm6z9cmzBqXrvam/3Yarn9btVRj+SCMaE6UD9t0s+tVq7ou6VfUJ7?=
 =?us-ascii?Q?MYxt4TkO4i2iejNgSNJHE6iOTJIbDJ/XQDBqW5+kZ0rVLST+j06QwaPb3Jbj?=
 =?us-ascii?Q?El09NPgXZBb+X8HK6QHkKYJr3mD/kd0XZiCL3f1U9VWsGoGTaw2pZCOb10vo?=
 =?us-ascii?Q?iUHILlbmvKtj61SHAGotVAqcIRCjeoCu/Z6DYZGUH59Y38X1S7zuIMn+HDzG?=
 =?us-ascii?Q?io0VzKPtUc5oSXHDLGNA3FmwVY3ZWzYvSyCtSb8U3qLIIOOYMF1TlboZzXrN?=
 =?us-ascii?Q?+ykSO2UIxZYAXqKukG406edAhKYN45FWrlqxHGCf8kRdsSyK7f9TAyE3OMLR?=
 =?us-ascii?Q?P34g+VPp8Pkh9Tp3OpXg/UobViOU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zHDe0ZSr5BPL50LJx1voi9/ZRFrPOOGb9fQpkUhFMskydhDUvGyccC18jr63?=
 =?us-ascii?Q?gbVyRUwKQEbX70kvHQJ+WoN2Md6R0aq2EtifLbpnlBMCC4YCEJdEWwN17ZX2?=
 =?us-ascii?Q?mbtmA4FtJ937VqQu/VKjPCYUumVIKjiYYb3M6/KNaHnnMkatqx6YXIbKDyzN?=
 =?us-ascii?Q?S7d6mD/IrHOPKB3d/SQczZtJ5kPxB2UMsaIjxyECGe/oJHuMQS4F6X513mA+?=
 =?us-ascii?Q?b1AsnKAeZx405f8tBIGFuId1e2g849JHYdMmxQ2srBLzA/pp7oS6MIwUyaUF?=
 =?us-ascii?Q?y0A4eBT12pBoM2E7dgESr9xIeT0B3TqwHevVu60v5TrPiazFvvuZEu0yIiST?=
 =?us-ascii?Q?oyiYs1Lc7va5AIY7ECtdnAYXhVUzWmlftep/0JT91rBFxEA7JqW1obLP9d8T?=
 =?us-ascii?Q?MDmN04GkT9flgGp2uiL917C0snycaBbypQvaYSef/8AWQOFbUvl0Pr0zRGob?=
 =?us-ascii?Q?K6pl9G/q1A6BmVys7lY6XEGZTbtglcct3d/zVP7BoO3g9sXB1qJP59TkW87s?=
 =?us-ascii?Q?YBNkVyTFKOhJXYUc/iKbFhWSylpJjrttQRQeuWUt6hzQPU2TJDBQp9kD6JBq?=
 =?us-ascii?Q?4MNGQEN6Fv9z2i/64jrjbh1VefyyPckgnpQ1qy/vKhsqum5lAiKzkEZwHKyJ?=
 =?us-ascii?Q?+X08bIqfc+RWUDbiHla0fQgPZkyQBKpPH9FLoO6C72Csb82uDn8Jmn49pFtZ?=
 =?us-ascii?Q?FOj3tvrxwE9GH2haAYurL6yGbAtZgoylqaK+smNwZtXXRguv6Hpu9wolaocY?=
 =?us-ascii?Q?x4KMTeUcy9P5Y8ltQ+2HrtyPuP3sJuFBgMdl/7jQ5Z/LzNrv66lQF6cxS9HY?=
 =?us-ascii?Q?LKwyxW/bAZFdXxkyQqCuGWX+5X2r8FASKkJ2Pni7wxlFJA2c2Bm0smQHdvZ/?=
 =?us-ascii?Q?D8JVmM7YqR5Dgc65iCJwTWmAZAnb7Ly0Zxc8DiRxWzk1u5dijH4hmIZg8OaV?=
 =?us-ascii?Q?E/crPfn4x9PsyUq1Nb0ZaCRkKvzKKbESq8BaOOSOqXCUwlMOU4POVZ1R2mXu?=
 =?us-ascii?Q?s9Vn+aSfJuOmSXkcbMKbh0xaSbedNkzHsJPb0YjirGAHZ02HE8xxw0UO5Cr+?=
 =?us-ascii?Q?ydBr5/B5GqVE5tOS4sMnGpy5vQyLrpKDZQxc9hAC46E9Rx/RI2iGDH1HlYI0?=
 =?us-ascii?Q?oauMb4rizHgB52aAKmnfNgU5PZc1/YteiNZEwwCqSC3lj6effy1gjf0G4Diz?=
 =?us-ascii?Q?hVTwTc8ZSX6qxRDrOBYTYMWcoNVs1QtKiB82ECso7+qV3LVMtjyudaND6X5B?=
 =?us-ascii?Q?5SrIpclCCIvUh/xsU9CJ8f2sdbgzeqWv6/2SZfRFQYkIGk3/QaK6uKpVGQ97?=
 =?us-ascii?Q?oSKPRVQ4ZDYNA0Tfdq34+XRNLAvrzEPnMqwbV5IAp+FFvQoQGtU3ovU7V6G7?=
 =?us-ascii?Q?/kmK1/Q8O5xpPT4lKCRq3xlGfaBakWrdugW5oaiSClhLEw0TDb8qlfBcT3sA?=
 =?us-ascii?Q?khPuLHx3l/bnqJNZwX5glIQ9kgqmvSJryZPk3rWdspYbsv9nTsKeAX9EFdni?=
 =?us-ascii?Q?+/BWgyqfkzYjRqpVbjMCOtpWKrM6J2m366+L6tAWT6G8aq7l598RvE9gCcML?=
 =?us-ascii?Q?TuViiKTPuInw+0ENJErxysugnJV5K4k+CSvwby+mxS1e/tA8tdKzfpsylM4Z?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a00706-1adc-4a7d-ef92-08dd6e21c209
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 17:55:42.7445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmvLy+HU3Sa5fOaympRC71OxkF1DcKDGejgY5xfzlDOXrOQI7Nzws4V4mWVgSV9zLSWzSI7oVNeTTbHQWgSXuccyQI2QH1zfgVFvKNGwVpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
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

On Thu, Mar 27, 2025 at 09:34:35PM +0530, Shaiq Wani wrote:
> Merge in additional fields used by the idpf driver and then convert it
> over to using the common Tx queue structure
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/common/tx.h                 | 20 +++++++
>  drivers/net/intel/cpfl/cpfl_ethdev.c          |  3 +-
>  drivers/net/intel/cpfl/cpfl_ethdev.h          |  2 +-
>  drivers/net/intel/cpfl/cpfl_rxtx.c            | 26 ++++-----
>  drivers/net/intel/cpfl/cpfl_rxtx.h            |  3 +-
>  drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  3 +-
>  drivers/net/intel/idpf/idpf_common_rxtx.c     | 36 ++++++------
>  drivers/net/intel/idpf/idpf_common_rxtx.h     | 58 +++----------------
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 12 ++--
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 21 +++----
>  drivers/net/intel/idpf/idpf_common_virtchnl.c |  2 +-
>  drivers/net/intel/idpf/idpf_common_virtchnl.h |  2 +-
>  drivers/net/intel/idpf/idpf_ethdev.c          |  3 +-
>  drivers/net/intel/idpf/idpf_rxtx.c            | 21 ++++---
>  drivers/net/intel/idpf/idpf_rxtx.h            |  1 +
>  drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  5 +-
>  16 files changed, 101 insertions(+), 117 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index d9cf4474fc..af32f4deda 100644
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
> @@ -98,6 +99,25 @@ struct ci_tx_queue {
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
> +
> +			/* only valid for split queue mode */
> +			uint32_t tx_start_qid;
> +			uint16_t sw_nb_desc;
> +			uint16_t sw_tail;
> +#define IDPF_TX_CTYPE_NUM	8
> +			uint16_t ctype[IDPF_TX_CTYPE_NUM];
> +			uint8_t expected_gen_id;
> +

Though not a blocker for merge, I'd still like to get this idpf structure
down in size a bit - it causes a 50% increase in the size of the overall
queue structure, from 128 bytes to 192 bytes in size.

There are a couple of ways I think we could cut this down a little:
* bool values only use 1 bytes in size, so we are wasting 3 bytes after the
  q_started flag. Two thoughts here:
  1. is the queue started state not already tracked somewhere in the ethdev
     data or queue data?
  2. Move this field down to the end, beside the expected_gen_id flag, to
     free up 4 bytes
* If we change the ctype array from an array to a pointer, we can save 8
  bytes. However, looking at the code, I'm also wondering how this is used:
  - in scalar code we don't use the ctype array, but check instead for just
    types 2 and 4
  - in the avx512 code, we do use the ctypes array, incrementing values
    that we get. However, from what I see, we only ever look at value 2 of
    the array in that code. Am I missing something here? Do we really need
    the array at all?
* The ops structure only contains a single function pointer for the release
  structure, which either contains the default release function or the
  AVX512 release function. However, with this patchset, the AVX2 code now
  seems to be using the same descriptor format at the AVX512 code, so I
  suspect that the release function may be wrong in those cases. Therefore,
  I believe that the idpf_ops structure should be removed, and the existing
  txq->vector_tx flag used instead to choose the release function. That would
  save another 8 bytes, and correct the AVX2 path.

Regards,
/Bruce
