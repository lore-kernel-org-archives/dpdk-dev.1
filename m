Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D520AC8303F
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 07:37:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88B4540292;
	Wed, 27 Aug 2025 09:37:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id B122B4028E
 for <dev@dpdk.org>; Wed, 27 Aug 2025 09:36:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756280219; x=1787816219;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xBGx8/nO/lehEvM00lvSQX6woaouR9iuw5EXl9IioYg=;
 b=QIVCmMo/Ey3R2aDhxOjHSjI7y8nEDPzFNoxEDrSNGqBGwo9s7w9kAn4M
 rpaRaX1s9HN+nvp+ty3T4HRvijDGZPn061rXilbWMpluH75V0Ltbik4hM
 cqd6kLwBBCdbjHRlLu7K/K+yfola58WjzVZLS95kCS6nbEFfVGDOym/X2
 oAJGwWgmDXvKYo/iKULDduMHRsIHRDwNoUtZv6gJ4vzfM52trtSI8YjXC
 +mJk+h89IP+z4wI5jJ6VPnRQeKMlD2G6VoMjfBaX9DHPl5WCqGY7qe7XK
 ToHqxqE171DoUb4ikBtuXgWbBWxTln5LoAQjm0G49UqmNl8YcIaDd3n/Q Q==;
X-CSE-ConnectionGUID: I5mgbSe4SHuMKmGi1qWShg==
X-CSE-MsgGUID: eI4iCTPaRz6KcI9Y7OCMlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="61163429"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="61163429"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 00:36:55 -0700
X-CSE-ConnectionGUID: V3+PcR2UR7+qPKe5MGSdZw==
X-CSE-MsgGUID: ZZjPBBRgTlqihcHJC+WoCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="174110242"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 00:36:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 00:36:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 00:36:54 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.43)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 00:36:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Frou0u39sMu5e6UZdUrAS0jhx7COX1//4JJt6QyCYCIe28019EU187DKz8EtA1dxkZE2/QZLDkZzYn4g+B5ii6pJhBsCSxOGOw/8RQYUcdEv3eGmKPC7QoSSSlEBp0UA4yd/EcP9F3MU/oabjinQHqW8bX9XgezOkMS22jwQUzUfdOIY+8Lc5yvn/FHAqGZRtXJfafas9Y9sVMx8pAc8YUURYIA576HyZV2/cRLAjVRmwASAF1HE0+0bkxQjXLEuBLGe3D0pt1VP6OYUmnZwjbr8TUyKopJO3eWtjVY+Gg8gBotpNMW6hrhBUPDFDgecWpAZME1HSUsRlhhg8xoMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLMhcN+iI9ZyF0uWPDEIxMiQNTMOmjrUcsPWoMPlbQM=;
 b=VBmSBwDoyIFudyMOCWYn6x3Z6pOs3ABzTyT3851pX9JMPVXNVVoCalkCIgYvnq1vCf/Djkytue9tWYtex1mijbsqFzjODfRq85i0xmzM+CPWBazMv4V76Uf80Y57091AsShylJw3oZvjJPG2PBGKrBq/pRwRppjkc5SHb3lSJyO4rAaqCaz8Au1TbDF9c3JohF2DTE/2QO5t944Lyf/AkelHK2VLr2Ilk/rkt5d6Lr2jQKft/FlrWpG6zN6gm2JuTiJQl3a80VRKHlQahHO+wZzk7U+epR7Ify+Wp6/U+ku/mMeYteTaFIhcwC6Gqjuu6P910bOSVkiAxVpTz6+13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7576.namprd11.prod.outlook.com (2603:10b6:a03:4c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 07:36:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 07:36:50 +0000
Date: Wed, 27 Aug 2025 08:36:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Chengwen Feng <fengchengwen@huawei.com>
CC: <thomas@monjalon.net>, <dev@dpdk.org>, <kevin.laatz@intel.com>
Subject: Re: [PATCH 2/2] test/dma: support auto adapt ringsize
Message-ID: <aK61jTGN5yihl5I2@bricha3-mobl1.ger.corp.intel.com>
References: <20250827012829.40752-1-fengchengwen@huawei.com>
 <20250827012829.40752-3-fengchengwen@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250827012829.40752-3-fengchengwen@huawei.com>
X-ClientProxiedBy: DUZPR01CA0163.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 487969fe-cf5c-4a4c-f125-08dde53c7c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2AVG5Puo3Tpydd7+aWTmNFujc/BEDt1NCRhTH5654huEjI5zmSM1XF/iRo54?=
 =?us-ascii?Q?piI3pQrihAg74Up3SzsTaDVl09SEDbTS+zxT8BPd+6CyxAdCoNe6YcBofmxL?=
 =?us-ascii?Q?m8Uh50Wne+j3AuedOYPk7HjV/HJn0SxLU0QFYeoEJJMZAtU7dsgSvWH/g0RE?=
 =?us-ascii?Q?ZijnxfC6b5XA0O6sspOqJoA/1nuho6VmroewUSapxZntjpMtPKaVnzrdTJRf?=
 =?us-ascii?Q?dQhncw2ROIiovmjRMEOI1Ng+DFWuEAnmm34cfTdRZ5sPBYNjQt9LiX0+vwiT?=
 =?us-ascii?Q?ZX3Vwyo4b2999azOmVnw0eIEFkpXEqpvqGqrpm84+4Q2FGCQc8Y2jh2pgkwn?=
 =?us-ascii?Q?mEBxQDvTKrUIHAmolqprtroXqW4Xi6SAu0VceQKjDJbTLZIzs/QuSo6IJyBh?=
 =?us-ascii?Q?4j1lSLdBkuVTQ2sqBAoH/SaqzpktBw4V6hlaOao4DyLK0KaRxf29D41vYA4p?=
 =?us-ascii?Q?/3QeJSHnChNtm6cSdXgAI07nNxIh/eXqW3aHvZzwcD8RmHPwO03aJLBKWEVk?=
 =?us-ascii?Q?f0VsyWtQyNAc86K2naRmdgW4xuAue6XPuRUHtDGjdC+OxXoqej1gCBeTX5B5?=
 =?us-ascii?Q?tc5vQotZWW4Kay/2rnXMQNFWiU9HPfdi9JymUWFUv8DTyTni/NKY8r7Iu7H3?=
 =?us-ascii?Q?9dhHGoJeynIuqcdhov65ZrOC/E8muaWvhB95a1qVE8AvbUexBE9uS9t+jwsM?=
 =?us-ascii?Q?dAjYGD6Vzd4FBDRGnpAe2+2KoP1beLXdvtNIZmZA6wGb1ctWHvjSuZvomxvZ?=
 =?us-ascii?Q?Ld7h8E7/A2CdeZE9YG+Bg5gs2ch8gkPtrMsvjmdT4WIOgxVNF1yJkhjtCV3K?=
 =?us-ascii?Q?SRXII4heRRn+UekuyjAwlQwYkdyEYASKaH0ZthFyOxmY2HdU2vNA9RUdOhqJ?=
 =?us-ascii?Q?rT+3VQBkCY9VCjQTRVNpGKs71a4V1nVzHVK3CYGX6kUaKUcG6VGOeYLrDVeV?=
 =?us-ascii?Q?GKz1vnqxM6ZqSw+fFoJsxT1xhOCjNtnmAVo/sUcQatoK5hW0HHkPOYKa/x+q?=
 =?us-ascii?Q?QaB47iR86kN0yhmVkFm5f3apJX7aXXeoi6aGSxmrZ0IZSYw030wu/zzjTbxi?=
 =?us-ascii?Q?e2vDaUzZKsz/RdCjl45TJMDfHl6YRW9vm5D3THyD4RligBXrhU6apAdyL7Gk?=
 =?us-ascii?Q?Kz11jc5sckI+GtPefQwxp2Nep6WbgGv/vokWW2RwDvk29MlDeEHVrYFwxS9s?=
 =?us-ascii?Q?gryFg8ykBFvbtdhGBety15FzKiEPh5mM4QNSTXtHNGUsyOhpy+ipV/pY2Fou?=
 =?us-ascii?Q?/r/0mVJ8/w+pwZNzl4s9rLBy2Mma6zw8n7/eAdb8e1CnZH3vnNLgm448e4fQ?=
 =?us-ascii?Q?BGWk68nVXiVN6qcfS3bOsyd7bRyeVaFAttfb8VbLnsxx5U+nsNZviaRbQJWm?=
 =?us-ascii?Q?4hAvl3PM374B0sp6APta3VeYWGYEw+YzHpK3wSgl1CUI62mEJYvS9S55m+RM?=
 =?us-ascii?Q?LwKy8gPrpQc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?28YcxCzhhg0X07rDhjUaVxYAisj8GLJWZE8Icz1/yRCYgWqIzMJavO/QNbg8?=
 =?us-ascii?Q?LaJ5KJMSWUUbuAHViThmamgcIyQYtXUFd6XC8cDAhoCNtLFsPh4DXZHCny1P?=
 =?us-ascii?Q?6mstr25XhHbBRwkJ2rH9vkNCXy/fD232vjaHzD8ZEztc6347xiBp5AixvsZV?=
 =?us-ascii?Q?q4E4zqVS8Gid8ToZjlVXFUk52G4J18E7DQxMdQy+B0k1twg4dkipUmijxiku?=
 =?us-ascii?Q?lyfm0yfu7l0PVEzN5wAJgu/KA5uPuRCf7Cmub0+XbA+6dBERRzbLPCeVF5WZ?=
 =?us-ascii?Q?xZ9hTNLLVdc8nRZnoOe4Te9VGkNaEZEhCfafmXNGwgNYQXRuCXn8Fmbcknqa?=
 =?us-ascii?Q?FvQQM4IvZ0wZOIwk4P14xC0Jukauc3Ge4M07yo0EAAtOy1QE6iaAN49st2l4?=
 =?us-ascii?Q?dPFx2/VaaksQjQnLfgJzngwV7Fqr1x84woGX6T6ApnjbCMPnDMzP862aH9c4?=
 =?us-ascii?Q?nIJgK3/bXiy330yv47XAGO1+N7WDoYiz2FA1jK939cshe89jK3BaRHNgPSuX?=
 =?us-ascii?Q?g81maaz8e9FU0fJG9FeVM1ELT4frdHCSbp18RElwHVw1+nqlVpCUvyvuehLU?=
 =?us-ascii?Q?BZGPW6dy03Am7zeG/sse1JvrxzEtbTeapr3yDcYSZn3rWO4Pym9VXhWarv5n?=
 =?us-ascii?Q?014QvlTQpJOdcoGzz97aQBKife5I98D+u+B2lQmAbbi1s5nmOGQBqVBO6mSv?=
 =?us-ascii?Q?eaFEbMgSlTg6WiyhYH70552VwwiYST7XrovC3J+0dPDi2wSSaj8pxGLSeKLv?=
 =?us-ascii?Q?2Qs0wadPIAq97uar3tm36Yj919W2j/8CPDW6+/ESV6Ffiayhw6RpI41TmBVy?=
 =?us-ascii?Q?3l5iLXWimU4D7wHJ0sQ44ObenLZ3WCjWMEipeNe09jBDpaWWc+G870H2p3EJ?=
 =?us-ascii?Q?bUnw6pBUPuO3Aoh6W7vQyJ3kOKFg4SKK++CmET4eIZyfhXKwFCt0NAwpVKv2?=
 =?us-ascii?Q?wqjnYL/hITuyGEHz2k34rbZQI/3anAl5NELeBHYNG7iiFCuyRDYydMofLVOU?=
 =?us-ascii?Q?8cEj3ypyf3kYJF1i5kuby6KaLI+5Tp294VFlC3BSPazaEXfLcSR0w9iawj06?=
 =?us-ascii?Q?JbRFTNhnIh/fVMdBj7pIZyjTNQhiSSAr/M0NbpM4ZSpmw3DxZISkOhQeji4X?=
 =?us-ascii?Q?IHfpDlTVOUVCQyduVk88zFPP+kXzAD9fRHncB+6FfJgZmX7L+JwXRZfrFKzr?=
 =?us-ascii?Q?MnUvsjs57QYs7SWbT4SP1k6732Vbzjh2V1I7TbQjCYGISE+DY9jGhYHucPYh?=
 =?us-ascii?Q?Rp9QX7lk5RHGPSRbu7MELosSLdjv77j0vuj4CZ3aURC7yk1hJ4lryqH4adA5?=
 =?us-ascii?Q?7MzugCJIb3ZB+b1RMb7WX8/nZRq9mzfTwhj/9a0F9JgzXdHWAZ8UWs1r5zzo?=
 =?us-ascii?Q?TMjQG+9AdjNC/32n+LzaFVapsnMtoLuXZ/54iwGbUfHxx+IxmPyyrFBW100r?=
 =?us-ascii?Q?24ueRfFFDkt6IV5zh0u7KHRJ2U3+bqxVQ/Gje5kbZxDiH49juZYuy6zEJ+OC?=
 =?us-ascii?Q?G9PhOIr7Ke1Sw9aRWqYxIzfIis6pB+oBEalkqg/aR2FZd8vAX2JJx+JINHqX?=
 =?us-ascii?Q?9xvsZV9hCZ7Aq+wRDGpgD6SjDDyrE7n7Ydqpe3okxZ7NcOl8qcDqRGb9YrR2?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 487969fe-cf5c-4a4c-f125-08dde53c7c61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:36:50.6351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ilPE3rmvkLiNSNzEZsMbWeonQfsSxPrr3aWhyNL+X32INorofCNQ7L4Tmm8PuAoE2LU6xWA/ZZN2PNBQACvVUFIqM0jgExE/boVtcNdLEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7576
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

On Wed, Aug 27, 2025 at 09:28:29AM +0800, Chengwen Feng wrote:
> The default ringsize is 512, some DMA devices may not support, this
> commit support auto adapt ringsize.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---

Seems reasonable.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  app/test/test_dmadev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
> index 482d564f7a..e1a919cd81 100644
> --- a/app/test/test_dmadev.c
> +++ b/app/test/test_dmadev.c
> @@ -1135,7 +1135,7 @@ test_dmadev_setup(void)
>  	int16_t dev_id = test_dev_id;
>  	struct rte_dma_stats stats;
>  	const struct rte_dma_conf conf = { .nb_vchans = 1};
> -	const struct rte_dma_vchan_conf qconf = {
> +	struct rte_dma_vchan_conf qconf = {
>  			.direction = RTE_DMA_DIR_MEM_TO_MEM,
>  			.nb_desc = TEST_RINGSIZE,
>  	};
> @@ -1151,6 +1151,10 @@ test_dmadev_setup(void)
>  	if (rte_dma_configure(dev_id, &conf) != 0)
>  		ERR_RETURN("Error with rte_dma_configure()\n");
>  
> +	if (qconf.nb_desc < info.min_desc)
> +		qconf.nb_desc = info.min_desc;
> +	if (qconf.nb_desc > info.max_desc)
> +		qconf.nb_desc = info.max_desc;
>  	if (rte_dma_vchan_setup(dev_id, vchan, &qconf) < 0)
>  		ERR_RETURN("Error with queue configuration\n");
>  
> -- 
> 2.17.1
> 
