Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1B3D0E6E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 13:12:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 275084065F;
	Tue, 25 Nov 2025 14:12:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 1197B402E1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 14:12:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764076332; x=1795612332;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NkuNp3fV7htZktBJakeFGxsyuoZcHIOpcv8hE3KtsY4=;
 b=Ftg0SRFomzxn010WXoigMtrB8DJFnJL8V5BKh2oxKBzETbwFzQO+xRuV
 37w9jdRwe3O+i8CpYk/lfjtjkggCHAVNBux9wRGrF6MlR9WXnX+VBzm8M
 el/RVdjTUgY1WducbjthcubJfksOqGl4vY6MQQci0VQxm5QeSDMwaiPnD
 dk4vh/eHze+fbSThkTyFZGond4rzIGi23RmpPfY8T/A7fU/wu0Q5OpUeX
 9bEhgB8G2wWTkJj+NsKX6Jib6Ot/s6jybIHKOMe3SF0D8jlMjcqlf4FrE
 b2KdoudTjFSs+y038i8TVGKtdV72LMNnx05akNXm1cezwMX/9U625H9zH A==;
X-CSE-ConnectionGUID: LQ2YEp8uRDersP0i288Oig==
X-CSE-MsgGUID: JOjRW54HQZG7bcmVvD0jbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="69950585"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; d="scan'208";a="69950585"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 05:12:11 -0800
X-CSE-ConnectionGUID: LeijcsmXTxChegvXG0i7Qg==
X-CSE-MsgGUID: 45ifLSp5QOOQVctNGAhhWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; d="scan'208";a="196795712"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 05:12:11 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 05:12:10 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 05:12:10 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 05:12:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNKcKzUIEggGvkkJawGatFF8VlXwhG3MOSHO6BmaH/xlH7TUAQ7AldTYy11tFr+reXEjJewiCtr6o4/cDgirLt0sPN08nVN0EMjb/oSQpmJHuhIjoBafdOvDVSQPqpSHisA1OuWwJ5P3YU6pEdh/8IyVHu3c09mUW9hg0pCEGFK2LI/RC83WYDqCk75XxrY/nqG7jE/1dTjmDUA1ntf7n9elpR4JbfctavfNTe4ZFzRX+i96q/t00bPXUSNyaVfYT9JD/ZEXpSLPqIFpHpwHRYVrkUgiylV5yT5UjOb7PdALTBt/MKC9HPs4DCap0ZTmbH909ikymi69xy19rlBfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icgfeN6VK0oo7ErYNpW4AFDodNJylW//cdz5lZQ8Q/g=;
 b=E/8em+zf+pnz8OitEK0aI74TYSendaDSuuxXdS/42iHsnrFnDABdRBKBRi3QGu6jHvvhOtKQ0vXJc+Xzj7xKFMXLLr2HbRPe0VlBa2GB49X/+o6quQ/R8s1wLoCmZjHAvLCnv4MUY7VjDQwF0Ckf8jA/RPjWySqm521/+d06ragJXRkp9ONdR0NpCuEzWfwNWB/KoqKmrzibdThuchFNKpnJ8osoKvR91HTc+QSjxz2t4uTQnWmAHSAWmIs5KUoSOsanLoRLXJ09HdEVYrg9mvTnHWWC70DPC27Is20S/u+Btoa8xUACpCdoPkEHachVFAx4nudkMEdqtkdYF+7h6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB6518.namprd11.prod.outlook.com (2603:10b6:8:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 13:12:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 13:12:08 +0000
Date: Tue, 25 Nov 2025 13:12:02 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Greenwalt, Paul" <paul.greenwalt@intel.com>, "Medvedkin,
 Vladimir" <vladimir.medvedkin@intel.com>, "Jiale, SongX"
 <songx.jiale@intel.com>
Subject: Re: [PATCH] net/iavf: check PTP capabilities during init
Message-ID: <aSWrIkJwhbsf7YvI@bricha3-mobl1.ger.corp.intel.com>
References: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
 <CY8PR11MB774717DEAC152077562DB837F9D1A@CY8PR11MB7747.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CY8PR11MB774717DEAC152077562DB837F9D1A@CY8PR11MB7747.namprd11.prod.outlook.com>
X-ClientProxiedBy: LO2P265CA0511.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: a29ffe96-67b3-40ea-461b-08de2c243c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n2BPEQPVi21Aajn5oVwhNTYIcqT29PEFFReQsj3yW/AyhK0dVvztmIYgE7Nb?=
 =?us-ascii?Q?P5ldEKBkFwVrz0Y/CUpa3GDvGw8BmswJJwpEXSuOqCUhCGxQ25TnMt9eOO7i?=
 =?us-ascii?Q?/Pj59wP1tZZ4erZ2DlME5GFjYbkjbbA/sKrA1CD42n0RXEL4+nE6kkGTT0cW?=
 =?us-ascii?Q?qRmZ2ScEYkXdEYCBtYxYyQeLNTzXooy42ujwa4UkaCxzQFSbN1Q47Yzc1y0X?=
 =?us-ascii?Q?N2PH1AIzBGTOasaJPLfiL/n9vZAK2lui1XTZos6nIShGRYtRDieak4Zu2Fzm?=
 =?us-ascii?Q?JWh2xJT05922gU+1WtRZjWB2djupMG3/hNaNsOE+Su/SpXF0Orf2OiSlKD1T?=
 =?us-ascii?Q?PLoEwvyC0DZn0ednLUjmzjZg2GSxOilrBpI0OHYC9QIoJvEuSD53zLm037lU?=
 =?us-ascii?Q?7/Q+HAK6EqB5OlcN9fPv60FmXIfkwRm+HOmreY39h4Qypu5O7B32Su8bW0xu?=
 =?us-ascii?Q?rsb13mb6xLtHkUfXhRT0GnOI8edAdx/nlazDjAqQmri4f00IS799+yyYx6N7?=
 =?us-ascii?Q?892vUUKzdwtMYWQuqJYf0L6OVV0lkXhon9d8GmvmYbfeKqtiTN1f/ERqfr5d?=
 =?us-ascii?Q?hSuUI2Cqtz+r74TfSyOjjN3TG0xVGCaPpPoDeygDzI5xSr1RrCuxSTKRtmQ7?=
 =?us-ascii?Q?wtqtjgf/8WI+Gqb8SP3Is1o1+eHoVRXN+pqZf80bggSj7oCGmkQFQRUwxGUt?=
 =?us-ascii?Q?8WUwOGUq5JIJkJP0OfUVr7Wh99JP56jjIAuKC5rN/wqBqpjhSQM0MQM7qgGE?=
 =?us-ascii?Q?zGlJ+QlpGGse1+6Ki40fZPDNG/Nq66HaKEeMJJTnOLrmxfMAK/967tcDfolu?=
 =?us-ascii?Q?FN8b/gmWFGAbBy33gZXDwCGpgMt/6kLZm/VjV8n0Ausue7WYfmO9yEQl23GD?=
 =?us-ascii?Q?LtDX26zt+0cGjWbXEfmcfIdHX1/Dpuxf/X/+c2IrthD7scoF3PsjpSizkVoe?=
 =?us-ascii?Q?tqSNaswEHMfozJJmL3ivjvadkeqCahh4R55+UCJZejiA0veFyju6yOgNMVuX?=
 =?us-ascii?Q?F/LOKlUvLT6J2JOc4WKnssnw4EOKh13TZhM8XxB951i/4q/6vgaaTGBOaanE?=
 =?us-ascii?Q?FGXLbc0MWJNICYaumfAFBGpl/qdTtAZJWtp4M0dU006qaI4Kmjf9X3L1SRzN?=
 =?us-ascii?Q?9kuW/aZlOB2TfW1wepkZAjB8IHFHxc9S9Qub8eko1grbUxZMLOszsigXeJvq?=
 =?us-ascii?Q?lb/i70PWW+7Up8tAqHXwlg89pyanQivoWe0bG2DnLWzVTdisiPeImGHYULzN?=
 =?us-ascii?Q?ZmUEekEG6oL76iLglheanLCzTgl2G2BCiosnnqMA6qAl06UZaBb9HsVnGE8c?=
 =?us-ascii?Q?q+UA6wDEsPU8/6dpcAXjAU8vO9YDz6gm9/Owgntti7FfR9KxPmUXu4X4xE1N?=
 =?us-ascii?Q?Ky/akMeU01QnwO4cXUuQBWiO8yctSkpgzacO84+J9DxKw6KcXqzMvGVQ4leO?=
 =?us-ascii?Q?L/TJQw0W9mVdBvOlD3SfxQzsJwoSCljT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6HqbsEyoFVH38BdMX6PFAh9sfSjU2d+i6E3XnjbK8jtI4CAT8A0nlINnfh6L?=
 =?us-ascii?Q?9WGKdxZ2hrbaDoUS7gM7kfoRPONxrtBy1NANpV9tIQOlsiMj9KLYKmBPdi/9?=
 =?us-ascii?Q?PkXkk9YtrRBfZPs5jzrCU7fP5ye3lC0Enzw6zLn656LmoAr73mIyNFzdXUZP?=
 =?us-ascii?Q?ZcWoJs2aBbg2vf8k93Ju33yizQWjOnAAL9dnyj6nLkcXA+xkxxqMbuBhghXA?=
 =?us-ascii?Q?XEKbrU5X0AEGfnszI+g/dZKr5fgmHLR33zKVoFcfA1EXGWHWZi9VDTCc7fGr?=
 =?us-ascii?Q?YFuInEqq15/Cd0MeAfplfX+vnFqZFHhqXv47E19XPNqcL2JO68QofJMHCCvu?=
 =?us-ascii?Q?LxL/yHri55VDxIDn23tKuZldGGIXEESh//g8cPpc5V+naNlEujMCFWfanklK?=
 =?us-ascii?Q?TcPqATEG94fYVkOr6rbBSttUQI4mZcVqeOvUzwUr/kH3dgom+l9IQcvnQifG?=
 =?us-ascii?Q?4aqOk+huzO6aMAngmmWHbJd90y4ho4QBwsysMIsXXgkYRprkUGqVmBQ2sVIr?=
 =?us-ascii?Q?3Q/a4nFbCw6R3X0XSx2a7eWh4PgyXEIg3oZyjiIxVNUsfWSr6ziNMbPRsBXL?=
 =?us-ascii?Q?XeaAUfDHcCiJN45pAtpp8/P2MWpboLUCd8GnbY65Ta9iFSa7X4I8DAqK39o9?=
 =?us-ascii?Q?bygPNhlDCFgAX1HmN6+i53IjTWmNOfA4yydhFeAflD1j7Xl2BjDnkkw7WWQ9?=
 =?us-ascii?Q?//NNSdTZYjUp/Bz7xpY8v6g2+UdUHdLRpxSX1/7mHcsmD6/wzjN8sU08TeAw?=
 =?us-ascii?Q?5XePAaXFPkuT53OhEeeX4SU7OhZHBK6lmKJjHKkGlC+E6QILhPVdfU/CINVP?=
 =?us-ascii?Q?VC9VNupAOW645P3IVaEpn2itfmasSYXbTpEqQ/iL73GTJj2B9re7WFyfDVU6?=
 =?us-ascii?Q?mhE/6dvnFs+MX0PwQsZTeDpB4A6+RZesrlsYHpfzEA3iGzsFUb8cMBrFlHXb?=
 =?us-ascii?Q?kvgQ5Bp/JwX61ICpK/mHxQimv9cjF+d4tjPvPy0h7VsLEuQ2E7NUiJxQY2cP?=
 =?us-ascii?Q?49r81Ze1ZStzZgA8X7Nx340pk1t+wNjwD2ptDkp55s9VlvHd4GGYFl+x7vg9?=
 =?us-ascii?Q?AFglqjsDeXfcWBS58lYSL7PVgWMM3LM28vQy2KIKEl/iQ1Ytg0joCDHza5RR?=
 =?us-ascii?Q?HGx+wjlMut6OJInd+h63o+vnH+r89C8ykPiPH8+YNNIBGBzCnZ7bVpAdO7Vi?=
 =?us-ascii?Q?2l1SZRbT8rlHcJTQ0UJoaUQ9alxm6oLjT9ShuDBok6qv+NHyzhsPea1pSPew?=
 =?us-ascii?Q?lPaOn9wE8lEoq8FMZ/lmI1OQRMCFgUivcW29bq47SswoSFtvDe0aYwFmasLw?=
 =?us-ascii?Q?KHhJzITjC6bsvWw3hkn52jmD/NcQreDwE5T0wn5xv7dTEvW+rvcmZHD1TDKu?=
 =?us-ascii?Q?EsDHVvJgnaMK6rw0fPLsh8z9c1Idqw/9UfojL7wtceOT6GKKTgiqxpWD21yU?=
 =?us-ascii?Q?bmBJVVQrdjAPiZhjMYt/hj+Wx0yRmTv/+fnbcRKFwC4QX+tUlWy/UGGIEuy8?=
 =?us-ascii?Q?9MXYOMltKQm1DZFb2u45/8oEd4+9K2f2/tYC+sQ6uUkm5ju6VnitrOfXDECt?=
 =?us-ascii?Q?Ew8E7/lDDO4N80F2krfijBwlyvf03rqsU9ZApXrm0CgvwkfRyZOMoDcweO+p?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a29ffe96-67b3-40ea-461b-08de2c243c77
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 13:12:08.2486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJ4uO50i9G7NR9HkJlmQYT8j/BDCPV+WTq36te7iaKrbq5UrwPPty5KRfCK3EIt54K6/ZlhNVgAJ4U4T08bPhtypHc2B61TyRnskxqMrs6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6518
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

On Tue, Nov 25, 2025 at 10:30:37AM +0000, Hore, Soumyadeep wrote:
> Commit d21c2fe6e5a1 ("net/iavf: fix check for PF Rx timestamp support") added a check against whether the PF has actually enabled Rx timestamping in iavf_dev_info_get(). Unfortunately, this function may be called prior to the PTP capabilities being exchanged, which results in Rx timestamping not being supported.
> 
> Fix this by checking the PF PTP capabilities near the end of iavf_dev_init(). This ensures the VF knows the capabilities at the point where the iavf_dev_info_get() function can be called. Doing the check at init is better than inside the info callback, as the info callback is called many times.
> 
> The capability exchange in iavf_dev_start() is kept to ensure that capabilities are updated after resets.
> 
> Fixes: d21c2fe6e5a1 ("net/iavf: fix check for PF Rx timestamp support")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> My recent fix to prevent enabling Rx timestamping on PFs which do support PTP capability but do not report Rx timestamping accidentally broke PFs which *do* support Rx timestamping. This is because the driver did not exchange capability before reporting its device info. Fix this by checking PF capabilities during iavf_dev_init().
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 3ef766de4704..9b07b11a6b51 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -2887,6 +2887,14 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
>  		}
>  	}
>  
> +	/* Get PTP caps early to verify device capabilities */
> +	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP) {
> +		if (iavf_get_ptp_cap(adapter)) {
> +			PMD_INIT_LOG(ERR, "Failed to get ptp capability");
> +			goto security_init_err;
> +		}
> +	}
> +
>  	iavf_default_rss_disable(adapter);
>  
>  	iavf_dev_stats_reset(eth_dev);
> 
> ---
> base-commit: ef98b88455bf4a7c8b7aa3106a761c9e9270d6a3
> change-id: 20251121-jk-dpdk-iavf-rx-timestamping-fix-abdcb42f0197
> 
> Best regards,
> --
> Jacob Keller <jacob.e.keller@intel.com>
> 
> Hi Jacob,
> 
> Currently PTP features are not enabled in DPDK. We only have the Rx timestamp API in place. Typically the change that you want needs to be implemented in ethdev_ops.timesync_enable(), which is not implemented.
> 
At this stage we are post final RC for 25.11, so taking this patch would be
risky anyway. Let's target 26.03 for this, and then look to  backport to
25.11.1

Thanks,
/Bruce
