Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D32CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 18:17:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12FBA406FF;
	Wed,  5 Nov 2025 19:17:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id B54EA4021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 19:17:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762366649; x=1793902649;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4U6kN2zkSECuI9O5tLEmPuknrmfzX9JWA0fnW34rzBE=;
 b=l6IB7Z7XQPmGkpe+tYGbrrjZIILImRZ/Azo4s8CAuRsWc7LffrwN+tb/
 7Wo98NxEdt4GEel7sguazvWsqGFSZIzQgcAWndXjxhmg4z8iVEFKWrSD3
 qsMDN3w5mFX2ujxJ7ZIuEWryU201e1o2SqAKO+SnkgI0ERy3wHKHFyvfb
 SZfaCYAa4cYN/sIvb/MSBfWtV8TQwRfxxAsI1xtVw57lot3TJjQRuBDFk
 iVXo5HjbrW+3wgiLvCmd92NXRwSF0MaOJ1/aAqY22xV0neIyXVCePJx3M
 mDr6quaXqH8z4ty0lT5IaJWT9XKeSMhi7P2ziJrJrboJTbUORVTH7tO84 Q==;
X-CSE-ConnectionGUID: N1X7tB2qQMmehRCPfShvCA==
X-CSE-MsgGUID: xhJYShIOQU62HG59n2QNQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="81894409"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="81894409"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 10:17:28 -0800
X-CSE-ConnectionGUID: XxkgUqNITCS2hkM2tNxxVg==
X-CSE-MsgGUID: X7nbYu6eRha+8CBy0eiThw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="192591391"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 10:17:27 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 10:17:27 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 10:17:27 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 10:17:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kf9QkUwuMZCnvrX8addOgAYZynY+xmSEu7mICdAy+jd6muHC/vLkIFXdHl5yFqaIU1JxRMKfTorTWkkEYWMHz0JFgIPu1X9owu3DeAI1BM5nSzFWsPuCp83EuPZmzaOwxDnn7wEBMZTccp0ZyWej5mKRcL9nliPF9lz9NtflgpDAAWyX3DAEfRHow3FSk4mdid/xEh+ey5ydloMNDe4hoUIk1zk/tw4CsfYveZIVf7LLYMLktV7FcRj1YW1Gm0CJckXieYe4cUJ+RmJOFvCNm8alGQFSCIf3F5ja8QYCCBWVa3En25+fRF3ZB3Ed68DZGyUeEC1ssAB3J7EdpOIXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5Ym53oN8eoY03NxNxTP8OaDv64T3o+Azt5pVVj4ciw=;
 b=QNHWUQXgmObaS6uoj+JCVXEuo3SqDgncILEeUGRM3JZ6gau0Xngrzk/2ANuqsK5/jQ34TGEjUVpa6QJ8tsrwJN9PaxAOdC7qF4VJz8WDofLdvK3IVsJOIo1n8uBLksT+BUFeSO1CsFJHiND99sKt4tTDCNJ/ItZPkXMu6/AFYEyCneP/eTuIv0W5mSo2NIAK3OAxw1AK+I4ZGseOsjrLoljA6eAV8AE09/JP0OGVh4OL12q2AYQBMkf3G4ahGNlJWqmyXZbshsHY2MRUttybytpeDZVeBg8tGOtTmVTbXVgycipU++vhnFN3fa7P2duhqauJMequQWhpQtWJEMsygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 18:17:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 18:17:21 +0000
Date: Wed, 5 Nov 2025 18:17:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <rajesh3.kumar@intel.com>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v3 3/4] net/ice: enable PTP packet forward with TxPP
Message-ID: <aQuUq52wZhPM2jNF@bricha3-mobl1.ger.corp.intel.com>
References: <20251030173304.260209-3-soumyadeep.hore@intel.com>
 <20251106064638.23020-1-soumyadeep.hore@intel.com>
 <20251106064638.23020-4-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106064638.23020-4-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DB7PR05CA0027.eurprd05.prod.outlook.com
 (2603:10a6:10:36::40) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3ab37f-95b2-4cfc-5bd9-08de1c978fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iR55ne9hfpSoa7ChDw7VZszajBzYXV/ZP1dxV1lpXZZvx8ytAQ3y3arMMWPp?=
 =?us-ascii?Q?aVRoa6JiigtGDJx7sUbuwjm2Kp14ALGIbbAXe7GN98Gc9mgRGCFSAOzZV6To?=
 =?us-ascii?Q?lwTKbTyGEzdDWT74CcVH1n+H0kcuOVBSif5Waxh6VjRBdhP1hrcGFrDanO/A?=
 =?us-ascii?Q?fHFRJX+O/h0tJrh8qR62EBprnFWnWxOcbGxjcAxRcacrHA6/hw177iUPQJbf?=
 =?us-ascii?Q?JFaA5eEGvNyUYq7G3F2F1QQCT2a1xUNbZ8C+AdUvRpFJGQDqNReJ6nBcFDpV?=
 =?us-ascii?Q?nDz0e8OyJJh1gWqjLbGkV2LWSP+uNVT1wUOsnnLFgVOoPtqzAfu94WX8Wbfh?=
 =?us-ascii?Q?5j6mb7eGvu+lxYpAqHAmYRXCVtFktajxuyQjop2W3DaHrDSANEYX0exvwvQF?=
 =?us-ascii?Q?9v8YfYZpAeFxkhYh9uYG+iKVWvdi6YD2MNE3wQn1VaYL8yiHfTkrJvrXBnoz?=
 =?us-ascii?Q?oRDyEwAKfcPEZqoRdyoK0dXVBHodgyJS9qIoUcKuez4l7goJflnNPnZmD1SI?=
 =?us-ascii?Q?jb0PnNqMXcen7GkHSXk0Yut0UnxAr/ytteWB6KczUu1JQ9aOLp3Qu5K30m4e?=
 =?us-ascii?Q?LfzYQI14+XpsFaXfvwfcNRZVH1qp/zMXfOvcxQPssKyj/a1v69Bhx2ug17na?=
 =?us-ascii?Q?bxXXyzeu3tVktqYWG+lNnulkzkXOlvI3iV/Kt5x3slAhdVFf/nIYRRIVFMJU?=
 =?us-ascii?Q?sTeZ+n6X7sDeqQuKeZZcdbjPWBOtiD8b9FITMsvvtnpmZ2R7nvE/D9prUg44?=
 =?us-ascii?Q?legs0n8EHbrdwDZCFsq1DlA9daun81Tczt5XOpha/HDUQfSQr+gaG+bzt7h7?=
 =?us-ascii?Q?txouqDMxCs9QNvELkSgAEOKqPEBwzT73pJMwU4LKDNIXE0rmfJuLw7guZnPU?=
 =?us-ascii?Q?KFLYAz1v4kkLhJ7wNC9HCZo7HmJeV4hGJAnJKnJlo8hjIt1yiaooe4L6jES5?=
 =?us-ascii?Q?rDyZ4Qp4ha9B8Xu4eyme0ZFtTw1SFjmX5Yu0ma7d04ZdmLkU7/OphBGyR76A?=
 =?us-ascii?Q?uzkJddPMI9cF7JDIyLcIXUSyDFYe9raUpFiuQlvsk6jCp4JFYxg6+AtVCqMB?=
 =?us-ascii?Q?bWVaYcV1O9/1/UDXuUFmp2pgvMSPfY29xSldkube4TslhpEDIZTBtnIyYXnz?=
 =?us-ascii?Q?T9LlVtSaj5C1mlM2hYyFqCbdp7oqE+isw1EYLzhjInHiozxyIRxhudQPyDnE?=
 =?us-ascii?Q?rODk7F83dBZNxQYV9KJQgfff7u/pJBvbm9mAcylEuAidp28dsQIdnQP4Z6R/?=
 =?us-ascii?Q?2pjw+b2PpCZr941tY0ppQuZBsISt9lt4fmNs86RGgCBfgEA9e/6w+gALdjCu?=
 =?us-ascii?Q?97PG88P+H2Rc5bzIbGaMb4Fy3uGCZ5v1Kb06nC5EQHgyLMySFEvN4JxIVTHP?=
 =?us-ascii?Q?/1Ckj9Lt+gKYZpHBqQDKrRup7Ot59R6lqY9TtvdzgOP7ml+rt0SnYHToI0UY?=
 =?us-ascii?Q?gs+zKyiOIbfmCdGW67EvM2x6JtsFyMc3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+cWF2rWLRKCUIdhC8Wb8BnAPrHSYMWjxnnBdkYoyeEMpVoh6QIXbObrQMw4n?=
 =?us-ascii?Q?kgiFEnDcBHVP8X1DDdFVFtU5VwjMFpTp3sY11jGVRV4NLuJx7yi+GCzqIX9i?=
 =?us-ascii?Q?slIGwmCljpRcN+R4aX1A/ERt2GZB345x/3HCGcZzT5CBwQoLoNXwCKEH7gDB?=
 =?us-ascii?Q?lvfHZ1semjAbKHyul9ZsOnQzO1R74JawbUMFE/b/luyNOaWkAlgF0UY6upEq?=
 =?us-ascii?Q?XAXbut2QBnEkyXdrVRukiRdOQzOMPTuYOZkXtQ8mCvzdPUKgpptYth4wD9If?=
 =?us-ascii?Q?6Saw+GrookZX1hNxF4gJIQRRR8tiH8O0n/5cUpFIivAk6Sp+iaYFY4zS5rIk?=
 =?us-ascii?Q?ShG4l421LlhV1kp5QIRdBFpkXFop31BNXyg89PbByLI974HeXz7BSd2o8t6S?=
 =?us-ascii?Q?inFsZZmp6sPJEBiQPlli0gBxm7VFfziVsbfUcLXnU6ZnvAVPhzWIAN9Q+zzN?=
 =?us-ascii?Q?cyAXQCwS48W0rs/PRL97flUKkOOBbTFch96KJSwMxYH8zKFWrqqvoWFmRaVb?=
 =?us-ascii?Q?0O7eKYo+CMfyuk+BpHTQV6zKT8SwrUoHavSGS/CM9sGF3kD9Qk2ZoUt6RSq9?=
 =?us-ascii?Q?QQH2ZDx/IYxJFLrt7neqOziUGqX35cNxPA3OhwjqfgtVnR2jSVACznEhosGW?=
 =?us-ascii?Q?6HOG/Oi3iJcD3DM0QLV876tMO86JI5NLAM4YhJZTnl6wiO6dekU9dTYsemcf?=
 =?us-ascii?Q?q7i3L9uSplKvnGZ7Cm2fTDDwqeJJkSkRqJAmB3ZxvkaiaNxuJlPmawfTw1WC?=
 =?us-ascii?Q?klukzw7XK8bD655r3yUo+1coJ8DnDhiwD/x4nDAFXuh9qaI+Sbps24MCDRT9?=
 =?us-ascii?Q?sqImglewKixC6wxlJ5GIZ14g67NGlGDXc7q+343x7ZL93S4oRuapfn/KoQSz?=
 =?us-ascii?Q?rPACEMt7Z8yp4vg8folgY7dNReZcg1Gr2bTpKYYJg25iu3HQdVXeNSbzX52p?=
 =?us-ascii?Q?TrI0GlpqlWGjk8veiTN2HrsiklVMJH/BLapwYj6q61zquZUnY+6AoCPurPob?=
 =?us-ascii?Q?NT9YFPnxq6yre6PYELaTl6NaQ2RDZ/vfndKBzvdZDVVUAtyGLn0qzN7t72wA?=
 =?us-ascii?Q?JHFNGgVinagXmbGKMdg+aAqDnHwbpbG22BXk5ZKgv1pTeg30owc12kU1NbLS?=
 =?us-ascii?Q?YMesclunrZmTNpmrhJJfMk5SC+4hdX6WcTMgC4DxshvqC7Z7oqnUaPnGfKJN?=
 =?us-ascii?Q?wY/KVlNXjXbBkRKUgUUPDmWfe1A4WpyH41//7ZABahd+oL9dNlYwu2n9QG+I?=
 =?us-ascii?Q?SLzVc+5JXbr6kXXgtzF4b0gFVVwcpjh7T2s+NE6xcTcKd0U1kGxvkWdkEPdj?=
 =?us-ascii?Q?/2K64soVO6bzGX2xvmlV++1If1aUJ2vYDPxKjRAnWhPklUAJvxiB6MjLpofL?=
 =?us-ascii?Q?ddCISmDS11DaKUT8d3obuTwXMeVnNYu5BSpw+0aGgccAaLsUnoINeFvV/adz?=
 =?us-ascii?Q?uBrw9h7Bhzazy5JpNOJOXm4uLFmz/Y2XTMhAELgo9BQwwbbuk27O3iWYeSj9?=
 =?us-ascii?Q?4TXGCrZC64joKxFx2HyyJ6N/BZImm13x39GIoKFyv0j49uwBiHdj7Wyt7d0U?=
 =?us-ascii?Q?HuhwtnEa9QETMke79a1CxcynwQAKOpK0sIE6RxpOFcHxlP8hgmduQRKNYhO/?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3ab37f-95b2-4cfc-5bd9-08de1c978fd3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 18:17:21.3857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2Gu2WwX8ifD27kegLanana32t0Ke1H0a8d4IF2jupWQ2jFW1u4kJvRO5LNz8b/qGG1BySLkHYBmmwJvNEqtI7SXkmUdnHP+dzTHwb2c+tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7800
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

On Thu, Nov 06, 2025 at 01:46:36AM -0500, Soumyadeep Hore wrote:
> Previously TxPP cannot be run with ieee1588 fwd. This fwd
> if enabled after TxPP enablement, causes multiple calls to
> ice_timesync_enable() and ice_timesync_disable().
> 
> On introducing txpp_ena flag in adapter, the multiple calls
> is handled.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 16 ++++++++++++++--
>  drivers/net/intel/ice/ice_ethdev.h |  2 ++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 3eef4303e9..2ac63bf97f 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -2873,6 +2873,8 @@ ice_dev_stop(struct rte_eth_dev *dev)
>  {
>  	struct rte_eth_dev_data *data = dev->data;
>  	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
> +	struct ice_adapter *ad =
> +			ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	struct ice_vsi *main_vsi = pf->main_vsi;
>  	struct rte_pci_device *pci_dev = ICE_DEV_TO_PCI(dev);
>  	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
> @@ -2893,8 +2895,10 @@ ice_dev_stop(struct rte_eth_dev *dev)
>  	/* disable all queue interrupts */
>  	ice_vsi_disable_queues_intr(main_vsi);
>  
> -	if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
> +	if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP) {
> +		ad->txpp_ena = 0;
>  		ice_timesync_disable(dev);
> +	}
>  
>  	if (pf->adapter->devargs.link_state_on_close == ICE_LINK_UP ||
>  			(pf->adapter->devargs.link_state_on_close == ICE_LINK_INITIAL &&
> @@ -4436,8 +4440,10 @@ ice_dev_start(struct rte_eth_dev *dev)
>  		}
>  	}
>  
> -	if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
> +	if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP) {
>  		ice_timesync_enable(dev);
> +		ad->txpp_ena = 1;
> +	}
>  
>  	return 0;
>  
> @@ -7029,6 +7035,9 @@ ice_timesync_enable(struct rte_eth_dev *dev)
>  			ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	int ret;
>  
> +	if (ad->txpp_ena)
> +		return 0;
> +
>  	if (dev->data->dev_started && !(dev->data->dev_conf.rxmode.offloads &
>  	    RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
>  		PMD_DRV_LOG(ERR, "Rx timestamp offload not configured");
> @@ -7267,6 +7276,9 @@ ice_timesync_disable(struct rte_eth_dev *dev)
>  	uint64_t val;
>  	uint8_t lport;
>  
> +	if (ad->txpp_ena)
> +		return 0;
> +
>  	lport = hw->port_info->lport;
>  
>  	ice_clear_phy_tstamp(hw, lport, 0);
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 6478d6dfbd..d9f857b81b 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -668,6 +668,8 @@ struct ice_adapter {
>  	uint8_t ptp_tx_index;
>  	bool ptp_ena;
>  	uint64_t time_hw;
> +	/* For TxPP */
> +	bool txpp_ena;

this is leaving large gaps in the structure. Move variable to fill in
existing holes, rather than creating more, please.

/Bruce

>  	struct ice_fdir_prof_info fdir_prof_info[ICE_MAX_PTGS];
>  	struct ice_rss_prof_info rss_prof_info[ICE_MAX_PTGS];
>  	/* True if DCF state of the associated PF is on */
> -- 
> 2.47.1
> 
