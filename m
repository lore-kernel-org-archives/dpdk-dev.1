Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1A2CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 16:21:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 524C64021E;
	Thu, 23 Oct 2025 18:21:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9DFAA40144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 18:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761236486; x=1792772486;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ExnlIOyNb8bLsZMX+e7YOVXUm84bBiIbiSkFgIUs13U=;
 b=YlyL8nlzsTg8VVjXqE7I0fyy6MlPWlyOKq3DgrBrTnIlKY5XhxiOIwq4
 a3bq7YBz3q4M+sWZRucS+03iuE4B8qw6TTxlZSKCScHVB+wGW6Exb5+4c
 Q97VjRNebmE7tRHCnjCIFftj6fxeCXD/Nxj1zDYAj9wdbNyw2X4lA+bA9
 jHXokur4cGGwSHiURlyG7YCu2CywahWw7+YowMmh9UeGkK52LuHB2sijf
 y8VyYwjSKbPAPz29yl8Iz7UIZpnhQ5qZ8icEnmZZ9ADQGefVkFCplLE/s
 c7tjLeTJvtH7Qn5oxNyRIKVjMnMLl2CA67XH0lQBZhgJ50CVELpvxdQvj Q==;
X-CSE-ConnectionGUID: 08FpjOyzRQydwOPzKEfDkQ==
X-CSE-MsgGUID: u7tC3ylsSGCvUSRON26KxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63560456"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; d="scan'208";a="63560456"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 09:21:25 -0700
X-CSE-ConnectionGUID: 9uFEA5RfSmqBdcLnCm+I6g==
X-CSE-MsgGUID: YZ5YMAnnQSmKnt5mBsVkRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; d="scan'208";a="184094676"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 09:21:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 09:21:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 09:21:25 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 09:21:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAeuQ56BJvEXgzuYN95SHZZBTa641JdfCNp/ny8Clidavxq/K3/efQv+q560gwxHphBcwS8aujG4b9yyLyE97ePwvLKIDQYI8u/gPc7Kzfy28lp66VaRXPhwL7DWMvpl8EXsRBxSDt4Tww8YUwEs1tw5oQhSbLibN56SHCZXQUCUe0//jNPDsef7Nup1PoPpyzHRdx0aT+5yZWHhNLVozmykxQSdnQzsB5GoYk1C7BjQvYaBtjRLs6OisEo+7+BOUUEHlHhEYenwzJ8ud/wzHS+Ci25Xh+MGoVr2sUv2vBdZVSrKQyyv5ZkFXfR1fYhZ2KyUV4tEICAWSpXm829dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQI/nrGt3igiX+tPoZDwvX+/B/ijaStwhmoocN8dR0o=;
 b=m5uhm8pD9N/vjYuIpwrQAp9JvaRE/pnA8Jcg/t7FDVLNWH0GHMoR3d1uaCBhLEBSCr4TWWbaQXM+qHc0UDiiVIsBWejOZf7QJ3uWOy+lsHeLZF2imlXdVkEtw+DZFOIHY3fcKKyudyWK6LfODXHsKLB6PCILFkdnb2UVmFor1kSsrMPED2hCTBFevyuaR1Jj/aI+65XEtX/Cq2vYgbSSQSFJCa02NdOw+BsKsJbD+MvdMW2zItoONWO2w/z+K9o87g0aJM/7l9Uzkliqa+PgnJYxrR9l6WSJ9ny44vDEuWksNVustdiC1eNsGxX/8ud+8S47oZY0pJwed3vNWezXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6138.namprd11.prod.outlook.com (2603:10b6:930:2a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:21:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 16:21:22 +0000
Date: Thu, 23 Oct 2025 17:21:17 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v4 5/8] pdump: handle pdump requests from primary
Message-ID: <aPpV_WfCjBC_Hu53@bricha3-mobl1.ger.corp.intel.com>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251023154748.38535-1-stephen@networkplumber.org>
 <20251023154748.38535-6-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251023154748.38535-6-stephen@networkplumber.org>
X-ClientProxiedBy: DU7PR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf536e4-20f5-41e1-3b7d-08de125034ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2hjIj/wGIrmTSaNCNFCPgHm0K/JNN3dRLTAD1BGraQjadGjbHL9lMIdAaNIy?=
 =?us-ascii?Q?NDwIt0z3w5ejbBULsXpjh3i2yc8tTb3FwazXh2wrX4tl7vB8Gsx5LqocAB47?=
 =?us-ascii?Q?IurMlntfBDSpgNyf27hJUJlunOQh1NsDkdylIz+U6wWlHFZDgP8EqtCqJvmn?=
 =?us-ascii?Q?8hEJ8yNuH3e9AViCWgin9pVYlx3WX2j/VuGDD+rHNoQwmGHysJc15OAJN3Tx?=
 =?us-ascii?Q?R6qURBMIUG1Nsej35yCEaEHwyra+RjfLW6rhVdg/9xPXk8dnl+ZYhJi3sb/6?=
 =?us-ascii?Q?K2ZTZBqCmggCljn3kJhaHERRWtuyLeT1qGaq8todvm/E3X7/9uX8IzblyOum?=
 =?us-ascii?Q?c0PdF9WYJYs7mmcy/DWJrcF5NUC3q+MgYNKebbB8eLe2U8sSOIGt2Z1oUi3X?=
 =?us-ascii?Q?DhYlBrgrE7FrjH+HTfS57jAFJ5toKHFBv9nb5NOvnNZsLYnq5hW18CvIAdOE?=
 =?us-ascii?Q?CEMdLhEWdb8lYS7k8lWhFgMgaNPbYl8aSLdygdW5Dj7UdWiAA5HCgnPbcv/V?=
 =?us-ascii?Q?3SKnv6tbJSLzv0oNTAJBL4kEHsxKBdOFFWiuJl6k3ulEV4LjNUTdQxeThsKI?=
 =?us-ascii?Q?6p9xTg9r6dBUTuF2KDdfVHm+QrUzI8vWA5yp5Ac7gujcBgW1mavxP44magyf?=
 =?us-ascii?Q?Uyq5UkSvrTySiZRvJn1nyhRCVv1sc8NbQTvG3Et9hEKFJEzyCuCPD4nl8CTR?=
 =?us-ascii?Q?H8YruXrkP/4KW0nTcAmr8LzoxWx/MCBhEt+YCsI+UQCeBqGFmctIQIjCuTXt?=
 =?us-ascii?Q?FrXjwMlKA5RxJkftnRJ2c8L9tUvTlgZhwsgzD26MvLWXoOaKtSCjOXX9Jdu4?=
 =?us-ascii?Q?33JkPS2tLJgxJR9z02BZbmakTcjpClUevWHepc+5zBppLJfey9g5xiFTueEy?=
 =?us-ascii?Q?9+2X4k6RcSTAbuPxdAb4NIvOteudzxJJ+TrQ1gik60IqTV2xOUFzz63tPZ22?=
 =?us-ascii?Q?KIVp89xGjujaWwr+ltwts1Qz/Qiov+0k+rL6KZkamRy8nupJnrVsT+eLEGte?=
 =?us-ascii?Q?uoSCBi6imwsTd8QbFGAi31n+zpJMcF/pV/GQdhJql1ZTrFQMApclzOruHG1r?=
 =?us-ascii?Q?8X0U9hGR8avxCbeR3Y5a7AY50acFqf8N1czACRi+zpCnvmqV2O0dW+Le/vny?=
 =?us-ascii?Q?06BgA//OLA0HJA2rSJAhgs4Czl/MNsMT2iYDCCDiox10ARc7Y8JQ1l+AZ4Hj?=
 =?us-ascii?Q?uKdkFj1oxKh8d9w2MP+bspjGeAukfqxWxP97XDHqjU9kmflRwkBmGqOqPVgb?=
 =?us-ascii?Q?/YbSBFkHYdSwwQUFlRs8gf+hj5Jd9jkm2HVH7uLPd9cdgNDsM60zT2cjtzY+?=
 =?us-ascii?Q?Lf3FTlYVxr0+oh9mQZYT7aYZghcGsabB1egirl5tArdkKqMfHTZ2cCJQuQJq?=
 =?us-ascii?Q?LDxE5vMC1cIzXN8YIVYXKe/kKszRgql3EKypJmEwpXOk8S+eDgTFwzOKfYrC?=
 =?us-ascii?Q?qSe7pt7pgWsH0ZagXm9924tEQ+FSsVEv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FW74+oTgPEESE/DoiA6eKBU70O43M6o7SDZU+nJBo+DT0rh/rI/Zu034GRGh?=
 =?us-ascii?Q?UO6Uh7lcqS69bJXfL8EAeH25q+FRXAhrKMgHF26MYM4F7tUslJrUysnSXaGe?=
 =?us-ascii?Q?FLuNdN58QwClf1bJoIzLoxJMH3xWjmDRHaZ/EV2wIiFPYd8/uRfraTDnnOg8?=
 =?us-ascii?Q?J1Ne4ktIq2W/jO7lI/U7MebzoDH8nrAdljzFYcpo6DsR1FRsk8DUchFdd1YK?=
 =?us-ascii?Q?C6adQ8DrpZFQoah1dAmF65lghQlNcNW3jilaGvqOEsPS2Z65YqnRCj1RsRIJ?=
 =?us-ascii?Q?6IE6VPtX2uwJ7zG3mbMiyCwNhUzJEcN+R9usEEXHZ7BjFnFd/TFRpNdSTPSp?=
 =?us-ascii?Q?MmCXlPqbfF1KlpqzWfBFeFhErQym0MIVQ4vaAQzY4u8SvB5YZgvVT7lXnA9c?=
 =?us-ascii?Q?4y1r5GfJsAxHENUem4MqAftSCVBFNnmm4CCFYolJVI57Fv6QCWw36V/rbhP0?=
 =?us-ascii?Q?uol3e1OISQmmGhShaaVIFrTUGCu6yylPGtMMPAMpNnxC5ulhcEHZxvIkMBw9?=
 =?us-ascii?Q?YGKygzT/lgTweheA1NrDO0PeETYIk7Frs9T6d3bJXnbYyZwrSl5FeFddTKFY?=
 =?us-ascii?Q?E9+N01XDdnBz1ydsYVe6oeTK9kxaYQUnM4yNPwcVy233/BWd5N9Em8SeLFlC?=
 =?us-ascii?Q?rmU4XnfLmS6ar03V8WWF2XlSovXzk+SGJLGMd8k1w9BijKC7miwYaROUUw+z?=
 =?us-ascii?Q?HXa4huxdlAvmF/1DKBKhl6NbZ0lDITD0V84Tc3pU3ssS+Tjb47IXvGLjMZz0?=
 =?us-ascii?Q?yslCuxve+fK0ukaOaIJOLicpaZQKzHyrVw0kaM3P5vT6WtcS/W4VDAmUkYJy?=
 =?us-ascii?Q?qk0Q/5sMgnNT0jAT/+aj8cJlTnmYO4Zfjb8a6OIlDJ2W6VmGZRVWIFy73S/F?=
 =?us-ascii?Q?Pyj+J/eCebWH6OWdvI0H6n3Q6GBabQQXA62obhccsrzgek1vr5xd+X4sBQIU?=
 =?us-ascii?Q?2TVndlEz8cDndJNpkUsy+SLct2cqLe6GX2y9q9J8a5sUY0MC0FSbMO90PRNP?=
 =?us-ascii?Q?kFsHqFUtzfo2/RNuL5S8r5cQ2Tz+OJIUmw2Og9pXfffHEsAF5H84ma2URJlr?=
 =?us-ascii?Q?Smpg7FRxTVrUMOyiAe2Q1ZtekZ1hoxjlTp31x+M+rUFA9PQ2/47AW0EkYMFZ?=
 =?us-ascii?Q?eD7ZE8SmU1ugN1Z9I1gl40SP0ScCMMVvIajHl1g4aEaR47Q0buCwkKJE8Ays?=
 =?us-ascii?Q?6WQQjxlYq4u6eZIR6TcpHRxsTGdqeGiMyL95LlS5U2Arocv5Ddpku1byMOKQ?=
 =?us-ascii?Q?0oHVUBhYI2VSDt0NOhXWE2czOnwfsqvGZuO4qo2eJ2VvZQM2jaNGsVhDkF+T?=
 =?us-ascii?Q?OHVi6RoQXzAR/7Jtur2WA5pYpXfmg/1Auzw++Ptkwup/zFTzrTdm61aIBcna?=
 =?us-ascii?Q?R80G+HWO9C78FrVHccVclGaHdcaXO4PmpyFgdH4WqSGXgpMNrdeXWWb9FRXY?=
 =?us-ascii?Q?AjSInbnnpK+QgE5cQqSP+9c58sTITJCd3T/Ra+12gVuc+DgjLO6iT7dmfmPh?=
 =?us-ascii?Q?TlnRIo3eH128hsHy39xtvCcYHX2thiZ8NSLAPreexa37IrjwY0eEVIwF+Zn3?=
 =?us-ascii?Q?7ZON3BuGpMWeP+LFTEfqMXIy3oygsrYNhZVCCEP5Ihfh3zBuS0VoSBPLd5ji?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf536e4-20f5-41e1-3b7d-08de125034ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:21:22.7786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LP/WoHhTRuiMtc0YuLqLkRZ45LtaveqfVle7UTl1eJCIfH6akFcMitH96os/CCdReAooHmavMSBQe5AjKBj5tGUbN9L9Mge9WAQ2hu1bCII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6138
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

On Thu, Oct 23, 2025 at 08:46:26AM -0700, Stephen Hemminger wrote:
> The primary process will start to notify all secondary processes
> about pdump changes. The pdump secondary process can just call
> rte_pdump_init() and it take care of that.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/pdump/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

It's weird that the pdump app doesn't call pdump_init, but grep of the
source shows indeed it doesn't!

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> diff --git a/app/pdump/main.c b/app/pdump/main.c
> index 1741d7e709..626ba0ce93 100644
> --- a/app/pdump/main.c
> +++ b/app/pdump/main.c
> @@ -552,6 +552,7 @@ cleanup_pdump_resources(void)
>  		}
>  
>  	}
> +	rte_pdump_uninit();
>  	cleanup_rings();
>  }
>  
> @@ -822,6 +823,9 @@ enable_pdump(void)
>  	struct pdump_tuples *pt;
>  	int ret = 0, ret1 = 0;
>  
> +	if (rte_pdump_init() < 0)
> +		rte_exit(EXIT_FAILURE, "pdump init failed\n");
> +
>  	for (i = 0; i < num_tuples; i++) {
>  		pt = &pdump_t[i];
>  		if (pt->dir == RTE_PDUMP_FLAG_RXTX) {
> -- 
> 2.51.0
> 
