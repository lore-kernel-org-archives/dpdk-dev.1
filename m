Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41327C982C1
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 16:38:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E44F642F7D;
	Wed, 16 Sep 2026 18:38:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8C1B94028B
 for <dev@dpdk.org>; Wed, 16 Sep 2026 18:38:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789576725; x=1821112725;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Bqd0nOeBNK2rZWzeGi7DteAmSw+HQNRZ5A34P2njV7s=;
 b=FfaPVecD2QrbgjzPeSmZSDCVqZty+bh+Om8IiM8HTzGQJWWGwIesImPf
 uEK4bEVsRU6ftfM0aJvZhdMSIy0lbcKrWxf11b8UnciYcwpMjb6FnIGlQ
 d1JG3FsJm/AHXTiOAT1F+dQlif21IqAX8pp9DOhae1T46iuYvzBo1/nSz
 sQfA1SAzo9u3PNA8l+oU94V2r6U+5uHRrrOlFhbej4wObvsJDqdnjWMCd
 YahdyEUBETO+Bcfm7NDVDB3GbNAp/cLcdsdyoUM8Z74v7xL4O2vr2Z+fc
 FwqPgNgwzQHzqCnafnahFT79bamy6V/5K+OFYzQVTpjdRpR+xKPGTtgWW A==;
X-CSE-ConnectionGUID: kMIiVhl2SM6eM6BdPqo7hA==
X-CSE-MsgGUID: yV3UxGRVTOGlakSjTvreNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93833538"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="93833538"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 09:38:44 -0700
X-CSE-ConnectionGUID: Vow5fQfuTeCa8QYUAdJB1w==
X-CSE-MsgGUID: Am8XkR+2QwerGHuwTuY4Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272916327"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 09:38:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 09:38:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 09:38:44 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 09:38:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnUlJYLvxE3+U69e6kOGNaHYi2IR7PoabvfeaVB0boc5S0LRygfxN/rd1jFnHkyJiYn7dgPOVMJjIN9u2p/DjJf8mZSSG59GKQobpEimrHFQWW83t/A/n8JCr4G+zaJ/FS1PTCJ1Hg/J5QwqcISh0/xkBKv02K7KBKlXlDYKbSCHbP6BZ3PufM6ZCP7hOfN50vxhfyUcU03vrr555lsnZHiWE7hcFT6SM7GbANmygm/AQwy5qKJaGwYFezLibWzK+i48RM6Mv2jVhP/Yl4SXw+jaXf4gwA/I/Q5z5E4qge7qHCM2kxf+bjAx43Uq0i0M/GeTQ8UaBewlc/48fcz+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNUQUqyIA5c+m3/WwzL3gutb+CNLm0Ronjpkm81ABBQ=;
 b=LTXw5q13sX6wmYRAc5gHZVWlW8OM/+PKIqw22UgjPyQH2N0RZYheS7W3Ne7v2d0Bp3kEQ0Fa5LJoAC/Lpb/dceV5Vws1AKxtFIAnHOrT0sT/nWrehzH8AMd7EKwn97+pMLVjEDMWxBzdUACLkXfrFYI9BpKMi0k946NFmjAzWeeRjifCqnG2w17M8SgmCj+009/oGvHmM26jdTPqZGoPkS5cU0RNCR+R4AIPfrggk/oMzUkUjh9+20Hy6GfnmxhpBIJS5d2k2xTBOmZbOD/VcGIm7YOu1+F9/qBQEps3tbVSbO7stx8cHxSgqXw3KAPEkfQOD6A/F9D2AEwCoXEtOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CY8PR11MB7746.namprd11.prod.outlook.com (2603:10b6:930:86::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 16:38:23 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 16:38:23 +0000
Date: Wed, 16 Sep 2026 17:38:17 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2] net/ice: support link flow control
Message-ID: <aqrF-QLwNCA_91NU@bricha3-mobl1.ger.corp.intel.com>
References: <20260901151233.1110607-1-vladimir.medvedkin@intel.com>
 <20260910112524.1547156-1-vladimir.medvedkin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260910112524.1547156-1-vladimir.medvedkin@intel.com>
X-ClientProxiedBy: DU2P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CY8PR11MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f745a52-6d1a-43a7-ff8e-08df1410ec33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|4143699003|11063799006|10067099003|18002099003|18092099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: nXWNkNFDF7c5g7qNj/zTws6Odjx5dFsb90XEPGc2oMzm+pA9UTHUMTsivOXE8kBXyAJRkdY8SDFECsbt3YSp9L89v41ru+rcOfDRN0W9JEMUYe+eWSFB5NsNqH7T35T30nUVCa24EGMwh00NLjm6+oQp/AqdiHxQ8DxFmqp636ZoBBIYbOGW1AVGzw/1JwYg4rFsGjlKIjaywgQWtTVCUYURmzwJ8Rb0jFzHKg5rAm+Mm+FIzpjOaM8mn2aILTovBsO8MA7bKdOnlyOxDgTuZoFQsEbwbJ7Yhu7rmAaQEaCEtSK2tmOsbBeqYgKX42nmar+8ElMu7Rt1JKN0TNnfIDzTSomtZP5V93V/Og+bpP0yIYww650QwYwTMixbW6jGXtijT7+iV7o1jJQI6GK1gOAvOn3qDVzDXA+gBiHbjPnBjwilv/PsIdfXCmbAulkT5wlMdczPN0RIH0NV9qOEworaTZxUCcIDFk0HmT1xrgC0+duLXicGoHU8aPh8kb1/w1TzSj4L443DwZO52TgtGs6/zfeyRFJ7fO2TsaRMDKRlInE44FT/Ki8+21qK+KsR+no/N2YbQQqBkZcLOWQlwXigZcMqBuOX08Im9HIha3qas0kXcZmQvh/GKW7rIOCspIVtz6LtAVaQjuRScAu982ORNLaclAM+Laad/pkUqeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(18092099006)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Vu7uTd6q75wmV4Rm0Av6fU8P7OVhH7g7SNrYzOfICG696QnnutpgKCMBjQb?=
 =?us-ascii?Q?Y15tm9hXQGRxoe3O8A2ycJZUOMzcPRh7GJxedobLErXx924J0NnN/aIk/vXa?=
 =?us-ascii?Q?uvbx7gyWNLmUPX2S63Ni2s32rhqIa2FV5ysjeYwrJ/FFHn7nAIwjNy8pcAMR?=
 =?us-ascii?Q?yD0w2GPrEN1nFxPMFmI0O7EjxcXvWcCXynBnQuXPKOWITG4cU3Mhwc5cDcTE?=
 =?us-ascii?Q?nuvRtUopKSf84cgyIw8oWHQw7Lj1iB7HfarQQU4yLSOa1Oi605Z8GlPlVrey?=
 =?us-ascii?Q?N6plDFGeTqT125x1pIkhNxj8ZSzgqN62fWy7dnEVcCseSTsOnvjf6gyug3xW?=
 =?us-ascii?Q?1YkXdHvQEVi6ZyLniWHVkV0eYQDq952LOx8PmaSMqJZIM/emv/yEGyegrT66?=
 =?us-ascii?Q?p0T210uIdk7sbzs2+ehYo/C5oOqyp514Y/4KGa9jTdHxuAdXm02CCOeHBSWl?=
 =?us-ascii?Q?sGyaKkgDe2QxEi13wZdMgX4+3Tr3Fa5ywgkHg3MLg1xPpYgJnmgNggKW7kCe?=
 =?us-ascii?Q?KWk9/EeDGWHDZDlWC+a1pKtZ5/U5cWpPIGvexk0pP/LbJ5sicIv3ld2Kos2E?=
 =?us-ascii?Q?PozVWfsjnGvQuyWuQ5EsXgCT4GDvjUEVL/KrExmr7X6IxaIizuQCUj4lLAfg?=
 =?us-ascii?Q?WRJ5n8MXav+FrBxKX6Rpr97Yz0oZy2yO6Nem9P3OhtIIe9iKLXLPJXB5bPk/?=
 =?us-ascii?Q?feRq3Cs5sQCI0dIZ4o+/OjzDKiGaA2aMdrwoXbgoozUogA/uq6MWr2wdXxxG?=
 =?us-ascii?Q?EfbOWOB/RdWypLQKsLKt77kjKKxRcMhh+bwojeIAqxz31SNd1Rnor8MtKI2m?=
 =?us-ascii?Q?7r1lvpBfzBCKLCHkLdzgjcv5955iLATgFjEHOdkTEiDREqv5b/32Ng94ggkm?=
 =?us-ascii?Q?LUVRMCsdHRgyRi6xIakWYDPugVxthXHjlZZxZUgVPqE8gEsgvNZXQ2V/KeV6?=
 =?us-ascii?Q?n9wg2jbj5ezWQ6+iJK6BNkUYEG4fy4GaKnEDegtCjUhGK0yKJ8ltJSVHYCBR?=
 =?us-ascii?Q?kIhbOvaE9qazEtvjTDkv8Zjnzml8eSrQPlKW5+OIfWyvLZLpI4JuQEb9pnPD?=
 =?us-ascii?Q?CQKLkW+VIgEFMpLGIGh0pd0m2RoLbDvlS1g+7REjTIcFEWbv7gE86mD7ADg1?=
 =?us-ascii?Q?sXV7u031eZUUYbPIIFjM35y4cIOzwLhe4nG8qySq+a/bOYaHQh/ItdB+FWZQ?=
 =?us-ascii?Q?YnWSRnRyRwJNY0IbKYeBNHTNyYQHip4lHNoikcn6VjSk6KnF8DKh82tmKR+y?=
 =?us-ascii?Q?uduBratvhHGgIMY7UVFo54+43qxPBdzh1aRE2TMDaQ0ZvnrHCSn0Rt7u2NfJ?=
 =?us-ascii?Q?nX/hjtzCd5ouE5xcf+SJoWmw/8JPu6AI0hpkRZH8G/IFMlHw/nB6/zMsX6ok?=
 =?us-ascii?Q?bUua8j/OFLydqNjcAgwxTZr14ci1N1iam8eeyw3ibA69BARVW6UaREes9seH?=
 =?us-ascii?Q?lCoZDBaAdk5HceeR75LEhhgbuy4YnXNS0d2KIlHgX8Gl52VofxoRXEhOr+mp?=
 =?us-ascii?Q?rq3J6U997/xIWjnjHLPvcc7kXiHRL/2NOD92KX2LXQbDUJ2adUa7xZ35gjTe?=
 =?us-ascii?Q?M/I29geZotVj/6axTAOFCr7dVzjr/2QbvgxY3hEgDCUEdGSe++Je3B0rGplD?=
 =?us-ascii?Q?9KicaRf9DZsTUP1v5jhH1InikgFJcZEyrJHWlRdwy+QT/5WYIjE1Njd8J0Iy?=
 =?us-ascii?Q?4lzy98VjsL1RtiSh1oiHaKv/X7/iawADB/J0P2Tu7MyLoqP74BE4VVHuMRTU?=
 =?us-ascii?Q?HdQDmFfwSt6hbq1AnY10jzTOEMUKokY=3D?=
X-Exchange-RoutingPolicyChecked: ntb+pgBzVKCkEL6L+W4RdKD+RLkK895HDktSGSVD6B7ODmB3hSLMMqBZzqsT12OSY/BDxwDJd/Y9RzLXFeVLVgl5z7YV05RyB953pyqUA0xxnFPTWFpDN5sRYEex+J6ldLrr2l1e3Ceyfsby5+zDZbRmpZEmmO0yI7daMd4VZmf06eCo4220UOCiJtjwKeq0k716h8uNMmoLGYBePX1q3HrnnWqA4otoi2ZStwjZCNkoytiIHqM+Su2QgMNTrOHD4qJ63JSzIbYLI+iovusOp963/1ZQbXM4Hd98uhzxuK/ubR8mnpAbOTC8HR8ezVLBGhMmMpJPWjJ4+jCbDXgx3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f745a52-6d1a-43a7-ff8e-08df1410ec33
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 16:38:22.8373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jNVf2fEQVIZLR8oo3//WCsWgY2yD1SbeqJ4pSTXi5KVo7HmV7oiFf13yJ9ghhAOghNYfCGOFU6iiir5tfMGq1/ykjbZ8xNGtJ3Io/0+s4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7746
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

On Thu, Sep 10, 2026 at 11:25:24AM +0000, Vladimir Medvedkin wrote:
> Add get and set functions for link flow control (802.3x).
> 
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---

A few minor comments inline below.

/Bruce

>  doc/guides/nics/features/ice.ini       |   1 +
>  doc/guides/rel_notes/release_26_11.rst |   4 +
>  drivers/net/intel/ice/ice_ethdev.c     | 271 +++++++++++++++++++------
>  drivers/net/intel/ice/ice_ethdev.h     |   1 +
>  4 files changed, 217 insertions(+), 60 deletions(-)
> 
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
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index c8cc86295d..5c4cd8a6df 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -55,6 +55,10 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>  
> +* **Updated Intel ice driver.**
> +
> +  * Added support for getting and setting link (802.3x) flow control.
> +
>  
>  Removed Items
>  -------------
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 76b8ff0a72..909b3ef963 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -211,7 +211,12 @@ static int ice_fec_set(struct rte_eth_dev *dev, uint32_t fec_capa);
>  static const uint32_t *ice_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev,
>  						size_t *no_of_elements);
>  static int ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info);
> +static void ice_set_dflt_mib(struct rte_eth_dev *dev);
> +static int ice_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf);
> +static int ice_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf);
>  static int ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc_conf);
> +static int ice_cfg_fc_params(struct rte_eth_dev *dev, uint8_t tc, uint8_t tc_bitmap,
> +			     const struct rte_eth_fc_conf *fc_conf);
>  
>  static const struct rte_pci_id pci_id_ice_map[] = {
>  	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E823L_BACKPLANE) },
> @@ -352,6 +357,8 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
>  	.fec_set                      = ice_fec_set,
>  	.buffer_split_supported_hdr_ptypes_get = ice_buffer_split_supported_hdr_ptypes_get,
>  	.get_dcb_info                 =	ice_get_dcb_info,
> +	.flow_ctrl_get                = ice_flow_ctrl_get,
> +	.flow_ctrl_set                = ice_flow_ctrl_set,
>  	.priority_flow_ctrl_set       = ice_priority_flow_ctrl_set,
>  };
>  
> @@ -1468,9 +1475,16 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
>  		switch (opcode) {
>  		case ice_aqc_opc_get_link_status:
>  			ret = ice_link_update(dev, 0);
> -			if (!ret)
> +			if (!ret) {
> +				/* On link-up, reapply the default single-TC configuration. */
> +				if ((hw->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
> +						!(dev->data->dev_conf.rxmode.mq_mode &
> +							RTE_ETH_MQ_RX_DCB_FLAG))
> +					ice_set_dflt_mib(dev);
> +
>  				rte_eth_dev_callback_process
>  					(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
> +			}
>  			break;
>  		default:
>  			PMD_DRV_LOG(DEBUG, "Request %u is not supported yet",
> @@ -4073,6 +4087,22 @@ ice_dev_configure(struct rte_eth_dev *dev)
>  	return 0;
>  }
>  
> +static int
> +ice_get_link_info_safe(struct ice_pf *pf, bool ena_lse,
> +		       struct ice_link_status *link)
> +{
> +	struct ice_hw *hw = ICE_PF_TO_HW(pf);
> +	int ret;
> +
> +	rte_spinlock_lock(&pf->link_lock);
> +
> +	ret = ice_aq_get_link_info(hw->port_info, ena_lse, link, NULL);
> +
> +	rte_spinlock_unlock(&pf->link_lock);
> +
> +	return ret;
> +}
> +

Rather than moving this function up, why not just put a prototype
declaration for it at the top of the file with all the other static
functions? It would make the diff smaller.

>  static int
>  ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
>  {
> @@ -4105,6 +4135,182 @@ ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
>  	return 0;
>  }
>  
> +/*
> + * Program a default single-TC local LLDP MIB configuration. All user priorities
> + * map to TC0 at 100% bandwidth.
> + */
> +static void
> +ice_set_dflt_mib(struct rte_eth_dev *dev)
> +{
> +	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
> +	struct ice_dcbx_cfg dcbcfg = { 0 };
> +	uint8_t lldpmib[ICE_LLDPDU_SIZE] = { 0 };
> +	uint16_t miblen;
> +
> +	dcbcfg.etscfg.willing = 1;
> +	dcbcfg.etscfg.maxtcs = hw->func_caps.common_cap.maxtc;
> +	dcbcfg.etscfg.tcbwtable[0] = 100;
> +	dcbcfg.etscfg.tsatable[0] = ICE_IEEE_TSA_ETS;
> +	dcbcfg.etsrec = dcbcfg.etscfg;
> +	dcbcfg.etsrec.willing = 0;
> +	dcbcfg.pfc.willing = 1;
> +	dcbcfg.pfc.pfccap = hw->func_caps.common_cap.maxtc;
> +
> +	ice_dcb_cfg_to_lldp(lldpmib, &miblen, &dcbcfg, ICE_SET_PFC_SYM);
> +
> +	if (ice_aq_set_lldp_mib(hw, SET_LOCAL_MIB_TYPE_LOCAL_MIB, lldpmib, miblen, NULL))
> +		PMD_DRV_LOG(ERR, "Failed to set default LLDP MIB");
> +}
> +
> +static int
> +ice_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
> +{
> +	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw = ICE_PF_TO_HW(pf);
> +	struct ice_port_info *pi = hw->port_info;
> +	bool enable_lse = dev->data->dev_conf.intr_conf.lsc ? true : false;
> +	struct ice_link_status link_status;
> +	int ret;
> +
> +	/* Refresh the negotiated flow control mode from the link status */
> +	ret = ice_get_link_info_safe(pf, enable_lse, &link_status);
> +	if (ret != ICE_SUCCESS) {
> +		PMD_DRV_LOG(ERR, "Failed to get link info");
> +		return -EIO;
> +	}
> +
> +	*fc_conf = pf->fc_conf;
> +
> +	/* report the link flow control mode currently in effect */
> +	switch (pi->fc.current_mode) {
> +	case ICE_FC_FULL:
> +		fc_conf->mode = RTE_ETH_FC_FULL;
> +		break;
> +	case ICE_FC_TX_PAUSE:
> +		fc_conf->mode = RTE_ETH_FC_TX_PAUSE;
> +		break;
> +	case ICE_FC_RX_PAUSE:
> +		fc_conf->mode = RTE_ETH_FC_RX_PAUSE;
> +		break;
> +	default:
> +		fc_conf->mode = RTE_ETH_FC_NONE;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Program the Rx buffer watermarks, pause quanta and MAC control frame
> + * forwarding shared by link flow control and priority flow control.
> + * A tc_bitmap of 0 selects link flow control; a single bit selects a PFC
> + * traffic class. Watermark or quanta values of 0 leave the current setting.
> + */
> +static int
> +ice_cfg_fc_params(struct rte_eth_dev *dev, uint8_t tc, uint8_t tc_bitmap,
> +		  const struct rte_eth_fc_conf *fc_conf)

Minor nit:
Looking at how this is used, I don't think you need both a tc_bitmap and a
tc parameter, since tc_bitmap is passed either as 0, or 1 << tc, so
therefore the tc is computable from the bitmap.

	tc = tc_bitmap == 0 ? 0 : rte_ctz32(tc_bitmap);

> +{
> +	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw = ICE_PF_TO_HW(pf);
> +	struct ice_port_info *port_info = hw->port_info;
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
> +	cgd_idx = ice_get_cgd_idx(hw, tc);
> +	if (high_water)
> +		wr32(hw, GLRPB_TCHW(cgd_idx), high_water);
> +	if (low_water)
> +		wr32(hw, GLRPB_TCLW(cgd_idx), low_water);
> +
> +	/* Update pause quanta and refresh threshold */
> +	max_frame_size = pf->dev_data->mtu ?
> +		pf->dev_data->mtu + ICE_ETH_OVERHEAD :
> +		ICE_FRAME_SIZE_MAX;
> +	ret = ice_aq_set_mac_pfc_cfg(hw, max_frame_size, tc_bitmap,
> +			fc_conf->pause_time, ((u32)fc_conf->pause_time + 1) / 2,
> +			false, NULL);
> +	if (ret) {
> +		PMD_DRV_LOG(ERR, "Can not update MAC configuration");
> +		return ret;
> +	}
> +
> +	/* Update forwarding of the non FC MAC control frames settings */
> +	if (hw->mac_type == ICE_MAC_E830) {
> +#define E830_MAC_COMMAND_CONFIG(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
> +		E830_PRTMAC_200G_COMMAND_CONFIG : E830_PRTMAC_COMMAND_CONFIG)
> +
> +		u32 mac_config = rd32(hw, E830_MAC_COMMAND_CONFIG(port_info));
> +
> +		if (fc_conf->mac_ctrl_frame_fwd)
> +			mac_config |= E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
> +		else
> +			mac_config &= ~E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
> +
> +		wr32(hw, E830_MAC_COMMAND_CONFIG(port_info), mac_config);
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +ice_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
> +{
> +	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_hw *hw = ICE_PF_TO_HW(pf);
> +	struct ice_port_info *pi = hw->port_info;
> +	bool link_up;
> +	u8 aq_failures;
> +	int ret;
> +
> +	/* Link flow control and priority flow control are mutually exclusive */
> +	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
> +		PMD_DRV_LOG(ERR, "Priority flow control is enabled, cannot set link flow control");
> +		return -ENOTSUP;
> +	}
> +
> +	switch (fc_conf->mode) {
> +	case RTE_ETH_FC_FULL:
> +		pi->fc.req_mode = ICE_FC_FULL;
> +		break;
> +	case RTE_ETH_FC_TX_PAUSE:
> +		pi->fc.req_mode = ICE_FC_TX_PAUSE;
> +		break;
> +	case RTE_ETH_FC_RX_PAUSE:
> +		pi->fc.req_mode = ICE_FC_RX_PAUSE;
> +		break;
> +	default:
> +		pi->fc.req_mode = ICE_FC_NONE;
> +	}
> +
> +	/* ice_set_fc() reprograms the PHY pause config and, if auto link update
> +	 * is enabled, restarts the link so the new mode is renegotiated. The
> +	 * default MIB that arms the MAC for LFC is reapplied from the link-up
> +	 * event handler.
> +	 */
> +	link_up = pi->phy.link_info.link_info & ICE_AQ_LINK_UP;

Is it safe to read this outside the lock? For safety should this be a call
to ice_get_link_info_safe? AI flags that all other instances in this file
use the function.

> +
> +	ret = ice_set_fc(pi, &aq_failures, link_up);
> +	if (ret != 0 && aq_failures != ICE_SET_FC_AQ_FAIL_UPDATE) {
> +		PMD_DRV_LOG(ERR, "Failed to set flow control mode, ret %d aq_failures 0x%x",
> +			    ret, aq_failures);
> +		return -EIO;
> +	}
> +
> +	pf->fc_conf = *fc_conf;
> +
> +	/* Apply the Rx buffer watermarks and pause quanta for the link flow
> +	 * control traffic class (LFC rides user priority 0).
> +	 */
> +	return ice_cfg_fc_params(dev, 0, 0, fc_conf);
> +}

AI review flags a potential issue here. What happens to pf->fc_conf if the
application fails? The applied values will not match the stored ones.

> +
>  static int
>  ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc_conf)
>  {
> @@ -4160,49 +4366,10 @@ ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc
>  		return ret;
>  	}
>  
> -	/* Update high and low watermarks */
> -	u32 high_watermark = pfc_conf->fc.high_water;
> -	if (high_watermark > ICE_MAC_TC_MAX_WATERMARK)
> -		high_watermark = ICE_MAC_TC_MAX_WATERMARK;
> -
> -	u32 low_watermark = pfc_conf->fc.low_water;
> -	if (low_watermark > ICE_MAC_TC_MAX_WATERMARK)
> -		low_watermark = ICE_MAC_TC_MAX_WATERMARK;
> -
> -	int cgd_idx = ice_get_cgd_idx(hw, tc);
> -
> -	if (high_watermark)
> -		wr32(hw, GLRPB_TCHW(cgd_idx), high_watermark);
> -	if (low_watermark)
> -		wr32(hw, GLRPB_TCLW(cgd_idx), low_watermark);
> -
> -	/* Update pause quanta */
> -	uint16_t max_frame_size = pf->dev_data->mtu ?
> -		pf->dev_data->mtu + ICE_ETH_OVERHEAD :
> -		ICE_FRAME_SIZE_MAX;
> -	ret = ice_aq_set_mac_pfc_cfg(hw, max_frame_size, 1 << tc, pfc_conf->fc.pause_time,
> -			((u32)pfc_conf->fc.pause_time + 1) / 2, false, NULL);
> -	if (ret) {
> -		PMD_DRV_LOG(ERR, "Can not update MAC configuration");
> -		return ret;
> -	}
> -
> -	/* Update forwarding of the non FC MAC control frames settings */
> -	if ((hw)->mac_type == ICE_MAC_E830) {
> -#define E830_MAC_COMMAND_CONFIG(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
> -		E830_PRTMAC_200G_COMMAND_CONFIG : E830_PRTMAC_COMMAND_CONFIG)
> -
> -		u32 mac_config = rd32(hw, E830_MAC_COMMAND_CONFIG(port_info));
> -
> -		if (pfc_conf->fc.mac_ctrl_frame_fwd)
> -			mac_config |= E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
> -		else
> -			mac_config &= ~E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
> -
> -		wr32(hw, E830_MAC_COMMAND_CONFIG(port_info), mac_config);
> -	}
> -
> -	return 0;
> +	/* Apply the Rx buffer watermarks and pause quanta for the PFC
> +	 * traffic class selected by the user priority.
> +	 */
> +	return ice_cfg_fc_params(dev, tc, 1 << tc, &pfc_conf->fc);
>  }
>  
>  static void
> @@ -4373,22 +4540,6 @@ ice_rxq_intr_setup(struct rte_eth_dev *dev)
>  	return 0;
>  }
>  
> -static int
> -ice_get_link_info_safe(struct ice_pf *pf, bool ena_lse,
> -		       struct ice_link_status *link)
> -{
> -	struct ice_hw *hw = ICE_PF_TO_HW(pf);
> -	int ret;
> -
> -	rte_spinlock_lock(&pf->link_lock);
> -
> -	ret = ice_aq_get_link_info(hw->port_info, ena_lse, link, NULL);
> -
> -	rte_spinlock_unlock(&pf->link_lock);
> -
> -	return ret;
> -}
> -
>  static void
>  ice_get_init_link_status(struct rte_eth_dev *dev)
>  {
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 7ee3ea8a70..3143aca74a 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -613,6 +613,7 @@ struct ice_pf {
>  	 * and link status update during dev_start.
>  	 */
>  	rte_spinlock_t link_lock;
> +	struct rte_eth_fc_conf fc_conf; /* cached link flow control config */
>  };
>  
>  #define ICE_MAX_QUEUE_NUM  2048
> -- 
> 2.43.0
> 
