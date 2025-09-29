Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3695BCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 12:18:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28AB240669;
	Mon, 29 Sep 2025 14:18:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 161F640668
 for <dev@dpdk.org>; Mon, 29 Sep 2025 14:18:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759148333; x=1790684333;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WunchXWBnw85KZ9MCa+ay3otySAElEvE973+mDxM16o=;
 b=mW68Nn8/ER9BzLe4wBBRzTXml573bLhagg/INT9k6f8+XQVm1Zr/VOJb
 QgY643jNBlnpph1cCQ+biL5JWJEckdPzUS6mqxat3Gs8XYvHV65UBSDS8
 44LjFZ+wiRZWUAu5PT6s6pQqUnJDv+gQRTlUXZnHZhtoa9fNAV49Ejz0J
 numzmss9hBI9+9DsMUkY44C4/+8zhAYJk/PIEUjiNXe2U91cIU4gsQF32
 RQCY08s0qrpax7J/vInCeEkJ6g1H0vz2q7O2spYnjfctOjwqPiGwlruli
 YIjsaZQHP7z6VbcGVzK0cQz7JV/lMX4JI5NPgqg68irewr8TCJ325ueU0 g==;
X-CSE-ConnectionGUID: iviGTn0MSyyLuNbUWSEsxA==
X-CSE-MsgGUID: t8xbsP+pQ227TCaqkE2Wlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="61433578"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="61433578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 05:18:52 -0700
X-CSE-ConnectionGUID: AkQqxlI8S5GA3U1NOKnDSQ==
X-CSE-MsgGUID: kg17EVlERUOiOifAG3tRig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="178042247"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 05:18:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 05:18:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 05:18:50 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 05:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zct2OPdt5PE3pNAudVxWjgWwUA+VffjlNVmUFBvYNttS0vSsO9Di1DP2Ze8qRfqfKhbmOHYuYzE1awLQEsi8E/bWxBREZSMmcAMpjOO3D13MLEiwEJVP9yvNGQJuCEMLz1ismbPXcv7XVW8WrBiTVgmkKlwoAG6PYiaTMMUbsW01QiSJcYY1Z0sMUKVzizuF1OS8TrrYp/WAM8wnNsKDM00wI+PnQ8RjzhVuih7g0+KhhN2tcylNCx0w6EF/R/IdTFuaGjAwucbbD+2/GjHJCJ17PaCgGfIWdUo6yI3mZnVaymnIhoNR2JJ62aFjT8mhIaQKsD8dSG7Q9bGTpE1zEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DA0j49/24WtY2le90O0nLCJcLEOAZTjmnzRh03RPoxk=;
 b=nnI4Q5M5nMDctjV7G2qkJCMxPq+t7qpM3dIFWCpTvUC95EjyBpvwghVXyZCLEGPcsh8UYiF9hrvFqWZAhi0xqI1//fcDjiXoRgm3xK8R9l35M22+MW6JoC6Ev6idEyTkCsW/jB7L7eMgdJGpQOfhhpY6BnXOeBGtoEGd3uyKWNVmyVED/IQ2TDjHzVmyDEu48y1pvSlq8En/AaGTLgUY/YKqWqbSEFBDIf5tpxpXOlJzpYuxr5W+LtN2udQUvk/7deaGiT01QGEdShH0aC+Vh6+858eZfeiRkjvL7KbbnJFzLoaXKS3yCXcCDNflpEFPoX6Pi7SfdbaJ7fLO2zBu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 12:18:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 12:18:41 +0000
Date: Mon, 29 Sep 2025 13:18:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Shetty, Praveen" <praveen.shetty@intel.com>
CC: <aman.deep.singh@intel.com>, <dev@dpdk.org>, Atul Patel
 <atul.patel@intel.com>, Dhananjay Shukla <dhananjay.shukla@intel.com>
Subject: Re: [PATCH v3 1/4] net/intel: add vCPF PMD support
Message-ID: <aNp5HMy-CqXfr6fX@bricha3-mobl1.ger.corp.intel.com>
References: <20250922141058.1390212-2-praveen.shetty@intel.com>
 <20250923125455.1484992-1-praveen.shetty@intel.com>
 <20250923125455.1484992-2-praveen.shetty@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250923125455.1484992-2-praveen.shetty@intel.com>
X-ClientProxiedBy: DB9PR02CA0014.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL1PR11MB5271:EE_
X-MS-Office365-Filtering-Correlation-Id: 312a5c13-f79d-4d73-4ebe-08ddff52537f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KOhCjR/nApbMvzv0K3nihg9b63SR3QjO1HLrb0eSOpS9gdGS2A1LIaFVmJWC?=
 =?us-ascii?Q?o+r0vohHk3NZd42boCrmdIZxvt3B2S82jFarzLwK5xPZJHJedPyRAAKoviLB?=
 =?us-ascii?Q?Y9OaMJEJWcrRIs0hHs/Z0NqVkHhFjj3R3li+hIXs97TqiMosM6z30Gy0VkmC?=
 =?us-ascii?Q?0/j4bodzwET4DhzmIkaNFMNgl+Ga2q/u+NV7xDvXNK5zj+UOWG1t/lI78U/z?=
 =?us-ascii?Q?gxvPyTdp+CIDUEX0UzJXxHsVu13bMfLQ8KLzBbSDacnvzesQ8YGhk2G9ab3L?=
 =?us-ascii?Q?ww3OzPcKJJr2llZhxu+EzsnSxUCc9pmt8DBOkEpf6NFy47OzNYN+uaV0/JUp?=
 =?us-ascii?Q?/aJLoIkf8/d3oEcWu6feVApXnEbJphTCAkuYKuPz38DjbBUFpU6s/jeZ/f9/?=
 =?us-ascii?Q?b7unO2Tv3MSu+V5Eu4DgtcK5u0+20XjERIwSIROy9fw/npz3e4/ORNEJHG6P?=
 =?us-ascii?Q?NIaGFtFxdG5mMTAdIis6+RfNAhmxNq7/yB8mykfY2GgmZyNMWQ0s7++WZASv?=
 =?us-ascii?Q?gnrNK+yJEN7bd9GVlsAkZmwz+y2M/8HbGTFmua3aTyCWLl3ekEjWkOg3CBn6?=
 =?us-ascii?Q?fRMlddafeOwpG/6yBtoisgD3p/3/tvL9ghmUEUOMcrhX2BCiWq/P2DktfKMd?=
 =?us-ascii?Q?2iWbroJzyuhhgK15Yn3Sf7kLUAq6OVY4IQMKVg9KKlhtjbiNzDd414OpRRnv?=
 =?us-ascii?Q?Q8Ud07HQ7KBeNPx8ti6ufV3GR1E4UJcLVMCkadCdijAB+Dkxz2pyZRZTx5v6?=
 =?us-ascii?Q?qEbeAA5tn/0G9Yq1lmzq8gsW+ibVjDYP4GIXVL7YXKEOmdmUnvytbEqIGd15?=
 =?us-ascii?Q?eXO/CQiIqBMKgcefX0YGjgjDkgvwUUdO2ZtCuidS1cNCx2QlQj2ferlPywV2?=
 =?us-ascii?Q?wJ2NqfJDBgUaXixQBcFTQhWaI+sv+lANdLT/wvZnytS5Tp6wa3sAPBqTAbz4?=
 =?us-ascii?Q?AKTRCZinRGFEbsbSCsOAas2gzL2YoVr50sxg6TC/g3mxkxZv0Gu8IsnSwz2+?=
 =?us-ascii?Q?lKeokeC0ZCAjPHqUPogZkLybzFtO2+BIYySIlKn5+8aX1Tey29qpo7Aas5z7?=
 =?us-ascii?Q?wKUK4ynxcHAM1+P3NDnsjjeofqtENg9qLBUfjr1iIaA9B+DwoFPmrF9jFXcb?=
 =?us-ascii?Q?ZsJYa5pJHJr9nh9W2wTslcg9v9WnFaZK04c2syAkVxCjsmknUPXnKK9dxHlI?=
 =?us-ascii?Q?Kz9yKTvGQN6BwxT9MX771C4gEQuZlLD6T4Dk0KaMBGcCisdNIQtDVjk8nSny?=
 =?us-ascii?Q?pnJ2XwC8wdbMQZ4VRcwhtsThCZ273hTAlyoOVbGyqwVAVTuMNXVqpFJqJf60?=
 =?us-ascii?Q?ubvtxbRNja8hkh8zRekMbLjdp+vNazn+VzK4ui/+ipouT7GFIqFFf5rApzkT?=
 =?us-ascii?Q?CombhL4mSKYy8wERI1v3e+MwTc0PDz1o1AqGa0uEjZimFnZP4gwX2UzNTa9D?=
 =?us-ascii?Q?anf/sBJ8++GVu8ruHw+tQ0ZWukMnmhhN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HIn2j3WMl0FArFdSfvqrRICKmW3c2wG0uVjFU+vjnFTHs8DZzyVV4+5TSsaj?=
 =?us-ascii?Q?aFv6Cr7xAxrYJo+BmgJIcw+9QfAeusJ0gov1p8MngFx/8AqtBCy4I5+u9UvL?=
 =?us-ascii?Q?CyIVgdBLWX2Ohch4lQYhi47yBCJo0GiE8achxBDiBaN8RroWpa9A80zNnUEE?=
 =?us-ascii?Q?MV7ZL1hjZSkxP8/jaJJYDqTlWaP1luh3bwQFX1VrV7u0X0beSzKE6iMwwLQm?=
 =?us-ascii?Q?tK+hQYYK8cjmfK85YPOin0qyzWSoNZoax72vnbHLtCw0DgoXNzX7vevVSkVo?=
 =?us-ascii?Q?9eDhNgtnUX5+YQz/USpSHc9svkiM0BDewLiKvbBBC2XD0nYJg4KV1/ETcnPe?=
 =?us-ascii?Q?JuoCm5AC6Pt/82GXGzJR4psN1Xj8B50QeyutfqooE1VgVqG2jDkFNGfqf7Eh?=
 =?us-ascii?Q?l9G5wzoVeYQjDc+TyA7CkUeMxFgLlyEtFVoiB2NEwWy0UWWoaO0DqKN7Kbsq?=
 =?us-ascii?Q?9zGVbU+9SBZZsded9Z+SC91XRv9CfNmY7OUbIW/gPtMI7l405f8tgEyUjU0E?=
 =?us-ascii?Q?J5PssZ2/ZJ+hAcXX51ct84Cz8yetkKNYHXNdIIEqLdvcPIAm9zH8sfXf3l5H?=
 =?us-ascii?Q?dHlmNa89Rd9gbKlcK9HhWBj5pf8aPBBkc+850I38DPPNNrrhVa7XhEKgkrKT?=
 =?us-ascii?Q?XxjIBCU9tg4PMNXiwmJPh2psfoW1p6HdweijqZxFU+Q3COgaIRUZ8Y8guYAE?=
 =?us-ascii?Q?IwCo6m2o8/kVQVNKn4uj/Ox3xugRvEHhcs2Lv2mhB5jKz6R6st86/GwQKqRb?=
 =?us-ascii?Q?gnY8LSWVV+s85p+/bCCCeZm/8pNSGxo7xkyI+vaGoQm64jwPaYKiLSF3vsBa?=
 =?us-ascii?Q?YtWf27qeiyiqIEnOCMaMxt8+ecLUpyx2Q/FcRo55bop3WjFfsU2Bua1DU0gv?=
 =?us-ascii?Q?CG6W8RvKpeOxok4gsxNBRnMR1+ccabTxzjzeIrt+0r0xcqC8ZunbwNVKoVnt?=
 =?us-ascii?Q?vcA/WRBxfNFCfHDddsR46T0NtoRW8D9NI9GgKbH2S8iL6jkfLczQwpImOkrU?=
 =?us-ascii?Q?kpguePvH3Uo6a2Wy4s8JStCGm5LUYP4oM4qFlpaArtVTMMF/ElVGM4lTPfcf?=
 =?us-ascii?Q?+I9dYoBNJ5jEQAGyazV3jiw6PminSBUHWjHVy+g980evGde34w2gVzh4aXFH?=
 =?us-ascii?Q?5b++e/ujOIPxx635NWy5NDHX1X6nZHIFelb0hUu6VbGtCczYAIMLWw0mv5ZH?=
 =?us-ascii?Q?BlYHWd4550nG6bgjFZE53Oc51qgFN/JleyB/GdcYAzeBPbAkKF3NyLy067eg?=
 =?us-ascii?Q?2srWlw5nrw6Z5SF/EaZz6A9PT2a1fOSPC9uJYoL9nGuSG3xrGtL4suP4/fTe?=
 =?us-ascii?Q?OJn5hLF8QOL1gAKo2b0FrPyM99qH2ZjuhPQFJwLzo4EpJawI6CXyyHp0npLP?=
 =?us-ascii?Q?rmVTVmitW7vzin0AazFvfEv2Vqf2SEHzHg3Sa7Xs7qbyHUfrlwiylJxh0M5B?=
 =?us-ascii?Q?cBQMDBfYUXHIh1QZ+S30GdqTeUP+35oEfXUontrLfqbGRMFiij1Rk7ACg/ds?=
 =?us-ascii?Q?7TIjNPhIO/D8Z9FMsMKqnz0FGp2aUtuPuZPgbM7k2hRwDoNk+oeaALra6Odp?=
 =?us-ascii?Q?xWPH8WqyK084r5mmqs8cJ75EdgUA8wbXqKNuNSrvJqbpYbeKDoJI/DOnMMDo?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 312a5c13-f79d-4d73-4ebe-08ddff52537f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 12:18:41.2234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dk0oF9hgM1tqZKzo6kefzXSj+F0BnOtq2iigFU5AfKaBrCid8QBQBdQeiBFFcKM8sDzZLCwdtkuyKif8vBnpgouAj8pCcvLIp0BKmSD/tRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5271
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

On Tue, Sep 23, 2025 at 02:54:52PM +0200, Shetty, Praveen wrote:
> From: Praveen Shetty <praveen.shetty@intel.com>
> 
> This patch adds the registration support for a new vCPF PMD.
> vCPF PMD is responsible for enabling control and data path
> functionality for the CPF VF devices.
> 
> Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> Tested-by: Atul Patel  <atul.patel@intel.com>
> Tested-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
> ---

A few minor comments inline below.

/Bruce

>  drivers/net/intel/cpfl/cpfl_ethdev.c        | 17 +++++++++++++++++
>  drivers/net/intel/cpfl/cpfl_ethdev.h        |  1 +
>  drivers/net/intel/idpf/idpf_common_device.c |  4 ++--
>  drivers/net/intel/idpf/idpf_common_device.h |  1 +
>  4 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
> index 6d7b23ad7a..d6227c99b5 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.c
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
> @@ -1854,6 +1854,7 @@ cpfl_handle_virtchnl_msg(struct cpfl_adapter_ext *adapter)
>  
>  		switch (mbx_op) {
>  		case idpf_mbq_opc_send_msg_to_peer_pf:
> +		case idpf_mbq_opc_send_msg_to_peer_drv:
>  			if (vc_op == VIRTCHNL2_OP_EVENT) {
>  				cpfl_handle_vchnl_event_msg(adapter, adapter->base.mbx_resp,
>  							    ctlq_msg.data_len);
> @@ -2610,6 +2611,11 @@ static const struct rte_pci_id pci_id_cpfl_map[] = {
>  	{ .vendor_id = 0, /* sentinel */ },
>  };
>  
> +static const struct rte_pci_id pci_id_vcpf_map[] = {
> +	{ RTE_PCI_DEVICE(IDPF_INTEL_VENDOR_ID, IXD_DEV_ID_VCPF) },
> +	{ .vendor_id = 0, /* sentinel */ },
> +};
> +
>  static struct cpfl_adapter_ext *
>  cpfl_find_adapter_ext(struct rte_pci_device *pci_dev)
>  {
> @@ -2866,6 +2872,14 @@ static struct rte_pci_driver rte_cpfl_pmd = {
>  	.remove		= cpfl_pci_remove,
>  };
>  
> +static struct rte_pci_driver rte_vcpf_pmd = {
> +	.id_table	= pci_id_vcpf_map,
> +	.drv_flags	= RTE_PCI_DRV_NEED_MAPPING |
> +			  RTE_PCI_DRV_PROBE_AGAIN,
> +	.probe		= cpfl_pci_probe,
> +	.remove		= cpfl_pci_remove,
> +};
> +
>  /**
>   * Driver initialization routine.
>   * Invoked once at EAL init time.
> @@ -2874,6 +2888,9 @@ static struct rte_pci_driver rte_cpfl_pmd = {
>  RTE_PMD_REGISTER_PCI(net_cpfl, rte_cpfl_pmd);
>  RTE_PMD_REGISTER_PCI_TABLE(net_cpfl, pci_id_cpfl_map);
>  RTE_PMD_REGISTER_KMOD_DEP(net_cpfl, "* igb_uio | vfio-pci");
> +RTE_PMD_REGISTER_PCI(net_vcpf, rte_vcpf_pmd);
> +RTE_PMD_REGISTER_PCI_TABLE(net_vcpf, pci_id_vcpf_map);
> +RTE_PMD_REGISTER_KMOD_DEP(net_vcpf, "* igb_uio | vfio-pci");

Minor question - do you know if this works with uio_pci_generic, or has it
been tested? With igb_uio largely unmaintained right now, the in-tree uio
would be good to be able to recommend if vfio is not an option.

>  RTE_PMD_REGISTER_PARAM_STRING(net_cpfl,
>  	CPFL_TX_SINGLE_Q "=<0|1> "
>  	CPFL_RX_SINGLE_Q "=<0|1> "
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
> index d4e1176ab1..2cfcdd6206 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.h
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
> @@ -60,6 +60,7 @@
>  
>  /* Device IDs */
>  #define IDPF_DEV_ID_CPF			0x1453
> +#define IXD_DEV_ID_VCPF			0x1203
>  #define VIRTCHNL2_QUEUE_GROUP_P2P	0x100
>  

I see the same device id added twice, once in cpfl and once in idpf
drivers. Can the cpfl driver re-use the definition from idpf_common_device
and save duplication?

>  #define CPFL_HOST_ID_NUM	2
> diff --git a/drivers/net/intel/idpf/idpf_common_device.c b/drivers/net/intel/idpf/idpf_common_device.c
> index ff1fbcd2b4..8c637a2fb6 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.c
> +++ b/drivers/net/intel/idpf/idpf_common_device.c
> @@ -130,7 +130,7 @@ idpf_init_mbx(struct idpf_hw *hw)
>  	struct idpf_ctlq_info *ctlq;
>  	int ret = 0;
>  
> -	if (hw->device_id == IDPF_DEV_ID_SRIOV)
> +	if (hw->device_id == IDPF_DEV_ID_SRIOV || hw->device_id == IXD_DEV_ID_VCPF)
>  		ret = idpf_ctlq_init(hw, IDPF_CTLQ_NUM, vf_ctlq_info);
>  	else
>  		ret = idpf_ctlq_init(hw, IDPF_CTLQ_NUM, pf_ctlq_info);
> @@ -389,7 +389,7 @@ idpf_adapter_init(struct idpf_adapter *adapter)
>  	struct idpf_hw *hw = &adapter->hw;
>  	int ret;
>  
> -	if (hw->device_id == IDPF_DEV_ID_SRIOV) {
> +	if (hw->device_id == IDPF_DEV_ID_SRIOV || hw->device_id == IXD_DEV_ID_VCPF) {
>  		ret = idpf_check_vf_reset_done(hw);
>  	} else {
>  		idpf_reset_pf(hw);
> diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
> index 5f3e4a4fcf..d536ce7e15 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -11,6 +11,7 @@
>  #include "idpf_common_logs.h"
>  
>  #define IDPF_DEV_ID_SRIOV	0x145C
> +#define IXD_DEV_ID_VCPF         0x1203
>  
>  #define IDPF_RSS_KEY_LEN	52
>  
> -- 
> 2.37.3
> 
