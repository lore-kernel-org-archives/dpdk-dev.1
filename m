Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17624606A32D
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F5ZaxwOW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CDEE4026F;
	Tue, 27 Oct 2026 15:58:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTPS id E077A4025A
 for <dev@dpdk.org>; Tue, 27 Oct 2026 15:58:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793113097; x=1824649097;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cn9HQkK9p1tDOJ77LKOIHu//IhWsCckJwo9WeBbOR8s=;
 b=F5ZaxwOWNtZzxbqm2n2hLe5RoONI4FKc42UHVKhr3EbPqR7gL315cyf0
 deH1SEw2qYhThEQsWsngumBetwArix7hmKbLgMcdF3zYFm2yCnclJTau/
 TbHDy9Jal7/UpnTFdYxZctPA1L9d7aTKMAZkDEOiUdpotsNVKbrpqW6Eh
 r+VRT6z6pdkjZBS+SDaVOhapgkIBvCoTq8v4aWNbqSH5eXCsh82rlzXiz
 uxhyI/ynIT27xH5wjVRzS4uSNZkQaeQfDSrPeUDaPlt82w2BYhvRmAQXT
 YAKRCOij+ZGQf6C8PWA7U3YSTnT2leTW7UFC2qQuzHW1geTswuSsnPsJO g==;
X-CSE-ConnectionGUID: 5649BbJaRDeAOmaJaxgkUQ==
X-CSE-MsgGUID: dYU0Zw2pSXOtSXXwpa3ZhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1696604"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1696604"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 07:58:14 -0700
X-CSE-ConnectionGUID: SXWm385VSAyK/3N1UwQutQ==
X-CSE-MsgGUID: z98l/c13Ri2yoFw/kCS+nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6437701"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 07:58:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 07:58:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 07:58:13 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 07:58:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqFePAQYAChiadMmRX275nvqYmK+M1by6UQlsG0ZJ/+SH+mzfqYYp9hwaHtaDvXzL1TLqDXRLGWvbqBxlijH/f2gjFszFhUw48HUzK6+CPs2kWipY2j04XxVdDY3eLkd2LwKiiU+XEhYwmMg/GwzMBD38ME1jVbgArrKytjKZ2lpyuIfPY9KTT3xWR7ZEa8YPvNcuXtUX64gkedOSzIlYUgjKkfrARiIF+ebLArj0cIBesesZIbR7mny06XESzQDMUj5t+qZKZBZLLLbxcr4IgRbodPZzmRz/7VhrGNe+b0KMqoz61O+1ZzeRZzAehu9NhQ9yv9657VQ9gpQcZSUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Erjvr0ldmMjatS4J0Xl1Xu+cak8tRth/DjV6Klpj+g=;
 b=zA9+qgH83mRCzP+Gu+apgiAa7kJHy3AfmWT/r9Ck+1qjYdZCSRuXXiDirZlHfDj1DJL7KyS0Cop3xAkmuhRO/Fw5ljoFLwyq5bpq0icwcyq9jwQoGM2rktN6nH3m9PCk0VpYD/LPONoZGA+ZARWAnVRSy6411X65tL127e4rMPTEjT2yHmvlkblLSKZZSsa3axhGDOGdW+LyFXVNsV5dKjOCynFt2gGTg79xfWV6C0lZn3K65mWADjjvAmmDqy7xRVPMSsOuYpJkvrJ6+lFoOppj6Qn9Tf8pp8niMDY3bD56HTYCOTItxdFa+n6CqC7XWwckl7lWXg5MbO3o7X+viw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH0PR11MB4822.namprd11.prod.outlook.com (2603:10b6:510:39::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:58:09 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 14:58:09 +0000
Date: Tue, 27 Oct 2026 14:58:04 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 4/7] net/ice: fix main VSI leak on init failure
Message-ID: <auC7_MEWY9LrCyri@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
 <3202bac42d40ee1450967ab209625d1c3849b30a.1793097896.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3202bac42d40ee1450967ab209625d1c3849b30a.1793097896.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DU2PR04CA0216.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::11) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH0PR11MB4822:EE_
X-MS-Office365-Filtering-Correlation-Id: 426775ed-bc61-4a59-5fb8-08df343ab6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261026140227099003|4143699003|56012099006|11063799006|261022113327099003|261022105027099003|261009223027099003|261021121427099003|261021123027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qVJzkVbTBzH5krteSUSV7+1zo/g+peI9G+LhkZ3oWz+NMhYj0UlJdCzGDnMmnzUgSNvLHQ/Am7hkFYJfiazyR1HcErURbZToTRexfwL4WlFhyr/A0CZgjFODkq92K3CIRUXJW7PJupuPLVKVENFihy/3Zrv1RoMI7xCF18dQGKa5C+H1WQUQ0qM5j9VP524E1ysJhsU7zpfBXyBVAIcWaL+1Z6h2VlwpD3L/1aVm7RNJgxXqd3/cBiWo+Ff31RdTz+0ul6+GIhTOlzBJwBVsMSbYt11PF3oFjH5NWDf0iJP/dlqorrIwyjjhOd6HveMQ5G5C0HKSWjIAPv3M6DZlCRffoY8Ek80jjT1q8PoeBPAi9vcVtWaOvNgY4rxT/c7jtH5YoZKWEEVEEopSA+JSB1sP9X5IXTbTnWTL+KI6//gOzZXubY+F4RT3b2BXpv1HVovn0XaWApxr2LMMOG4RmurBRIJHYP5/jF3WW2PI9eIvijwoUz0easC7JcCuKxFMP04ltA67CwmN6dVaRwPMB8rI2tPxChzgO9fbHPfF1/pnH7PPPI65hPFdLlnOa2g1fYww3P/XFkFWqHXOQspf0lv8S981y/DNoHqtllJuhT6oQU0glqTcQcs6O4TVB/0XL0HHASa1i5bX96GsJeoPwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261026140227099003)(4143699003)(56012099006)(11063799006)(261022113327099003)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BMb9zZRnu1Mx3AoQzVYfRRtVrpiqtEkfOhav+X++AZZipRWg0Rvr7ZXAuXHC?=
 =?us-ascii?Q?eRgKxfGrNTrGzOJQg7y9Gqxe0sn7uex5LAavXnsHkVbPzraT/z5lygZUi4XD?=
 =?us-ascii?Q?NSx0ZQkS7HLH2Oikqa/MT+3Q1532kh8e01uCYDqCgBLCNqskB06FZL4z0cgI?=
 =?us-ascii?Q?7VbC0YZltHymeoo6kH3//617/hByda/JBWIIbA7iZQLWAEuHewyfL9NXAjpF?=
 =?us-ascii?Q?XjkCYrDZX6Ziq/ibm5gjnTcJiwA+QHppuqsfpm9TjmcIu41CuGBAKimmxvTw?=
 =?us-ascii?Q?xiFXT1xHs0mf8ejVctKKlAOLOeEu0Lzr6DbSdgLAeQPHxOc109XK8a6095P3?=
 =?us-ascii?Q?/XCpABt6C6gRX4a/YR2uZHDKCr7yXzUe3Vp7J0lLqRa16BBDpqNkgGN5BeO2?=
 =?us-ascii?Q?jFuK8CD0dazGsl+hluNW1xaUnWVGU+dEyh2gLO5YNt4NQTP7No0r2IYtCAxb?=
 =?us-ascii?Q?6eb4DSknroJgQ3gO0gakl920AhZiycB91M1/LYekjC3UEj67WHf5p1alfJx/?=
 =?us-ascii?Q?giIapWNHMtpqWmzr7ecG7JPb1MMct07+I5apxqkPAQCpqNUrBfa/U/a5zOCe?=
 =?us-ascii?Q?VK3CUe65XZ1hJB99ZeE7D3TbHTxL9U15QqaD/M1+ObaRyDmZ17B8uJPZ/nE/?=
 =?us-ascii?Q?nqr/A+V6Gf4eTUYSAeaGrCkuB2nZfG5lVlJs3C89avgRX89Q84NRCgB+vaSs?=
 =?us-ascii?Q?eUPGIMug0fNSbAiTUHxbazNDSY2WTr5yMci4Lpzea8Jrg2Pu6YRTTLKe3yUc?=
 =?us-ascii?Q?2K6Yjjfe84Yws2Ivyz6ay+Aw1QLqYEjGT5nTVx681o3kYW9wYSmswnARgJ/s?=
 =?us-ascii?Q?RUF3QYubvsPMIUHecT03vPl8iMrJMlS+yAQ3oWIo6QzvCQJBds9iBSwPObmg?=
 =?us-ascii?Q?ahzGlVgs1Cuc057u89gWxbehsrDSVk6zE9cX623AdS9soCai/Sa9gEj8KaQ2?=
 =?us-ascii?Q?wqO6X2x2YZrbVpw7K5213Aa+E9lDuOe/LpvtdcdnJNZ1YLMvz17e8AP+/30z?=
 =?us-ascii?Q?qClj5efFjUH5a2cKgElcvIcgnFd2HnnVIVhcnAAgJU00UXrFZKp5qczGBQ6E?=
 =?us-ascii?Q?ED/+biBJJuwTJ45dVeitlBE+lPl3BUtCTfHSlqUxy7YggdBCLOn/7w5pNofK?=
 =?us-ascii?Q?zRxc4iB/lTN/FS4Ru23kIiYIhyJXUMUV92brnZngPi6I6aDaZrLgcB7zbHTX?=
 =?us-ascii?Q?i8mOEs/tDUlSKDLxidbjajnKgmVWJUuWDb0qtNzVxCdqID4rkit6Ee3j5/Rs?=
 =?us-ascii?Q?a2NIGtmFy3EByRPS/5G8WwQMWhVKm7e8NR+4aoM/N1TfrbKLeujdDVT3HKYo?=
 =?us-ascii?Q?6PhloNMHBAzTW6BAxJ4tVXQPC5EmpefOwjfCubRgRzoVhY441XomjBvpWQiQ?=
 =?us-ascii?Q?7DpCGt8v41hLxmsr1hRFAtm5IrTvD3SZn0HjpJyTdHwXOBJzgF/CEsIRfzB2?=
 =?us-ascii?Q?q24rwkAwdqwUDol9wIuxq+it6/pFaLENYihjkybzuJPyQtSa9sDKAbIYwFqp?=
 =?us-ascii?Q?o3M6cvfaFrcFpNEaoXag880n5VH+9naDMkoRp+L8GoBLizZ/mkCS28UUUrkF?=
 =?us-ascii?Q?7OV9HnpisnGN6+vbL3gm2TsofOcAJIN2MWe/1k6bvTNztKrM1yTMlJ3QhQOq?=
 =?us-ascii?Q?OgGusTYfeSDCWlS10YdCT/rpGC1UuAQkZm+Q8jFnATBFuiu8iWbq8whPTJEE?=
 =?us-ascii?Q?oCFZ1hrviREMVzEU0XtBiyG3qRb/1HeOX2lc7Okmp2PHn/2gijbsIwE3J6Zw?=
 =?us-ascii?Q?K4T3Fu+6iiDI7dIYAvNCrNV31QnXilY=3D?=
X-Exchange-RoutingPolicyChecked: zLxa2gdNYbtj2U+jK9vcFAV9SFxmPoXgJpYDtdm+RhJlZPzF0zpgCgtpIskGzSjdLnWYco1knvtwuNxhp1G+7JR/bnSEzvPAnTeRbqY2c0Bc0YMrO/Xp2b6Pgq8zG25HY6Cn7VAfRqDSMjJshZVr1Ule7VJepweJ4dOxBuR6yimznL+rlDXyO1KlgDWQSfMxLHfok9Pg+ho9eHEhF0C/BieKrmF2sn2kMAwzkOT4KtvXPfrYHydr5qOwHyNaZLPs5MtgQH2bSB0xmNlZgtcXrjLUMjXn2A/SyVRkYwj20Oq5nG9uZVtpfLq8PAttLdqyncea80Hiok33Lk92wWMN0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 426775ed-bc61-4a59-5fb8-08df343ab6e8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:58:09.2790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNFTJ6LPdCCIVbo1+tFIJvgdqV/YYx/VNo8SEw2AEQrnzcKCVi9i9u7jpemVT4gjnYeu+uuc1Y5z2wXEnbBOCJeNoUs6auzMk+oxy7hsHvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4822
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 10:51:34AM +0000, Anurag Mandal wrote:
> When ice_send_driver_ver(), ice_flow_init() or ice_reset_fxp_resource()
> fails in ice_dev_init(), the error path skips releasing the main VSI
> created by ice_pf_setup(). This leaks the VSI structure, its MAC
> filters and the VSI in hardware.
> 
> Release the main VSI on these error paths.
> 
> Fixes: 9481b0902efe ("net/ice: send driver version to firmware")
> Fixes: 96b25c496aad ("net/ice: fix memzone leak after device init failure")
Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
