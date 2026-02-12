Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2A1EE3698
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 17:15:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E4104025F;
	Thu, 12 Feb 2026 18:15:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id E355D40041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 18:15:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770916553; x=1802452553;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=O6sPGqKaeaSv0WS7tNREoRH1HbDFhGy50TSIlAdeFWI=;
 b=Hfell9PuINhaz0kH1SeFow3KaVh5UlSf0hfhPNHfyKKEylzNI5VXVge4
 NOPTr5fPuYscS6MzzlJJ1F5C1v5bvNvWDvpTPh8F7g4dt7tXlbdrdkkNn
 GIN3EIglYm7wG1dNBY6pcfw/svOY47C4hRx7cMng/cSLg7SIaP2u5xR1H
 UgU+LZBZApAC4awqvIY1wLEShjq07PIUS5CfejNmhMVc0BxV1wVC/Z6q9
 Yp6BKW72De+rFnEQnRGX+THdztPhrieNJjZfzp0o5tHoAYdnHsl1r/Fgs
 SWcK0r3MQSOI5m1ZQ9FQ51tqdASNSVMNbj0M8Cq0PiUqe11DYfIUCfPN9 g==;
X-CSE-ConnectionGUID: nsKsF7NSTpqLmS3jb/FVDw==
X-CSE-MsgGUID: SfspsX3UTq+F5sRpKaPvhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72083560"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="72083560"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:15:52 -0800
X-CSE-ConnectionGUID: eIFconZsTrS+04Q2AV0lkg==
X-CSE-MsgGUID: NtUK5M9kTRaZlx4D43XsqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="242214079"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:15:52 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:15:47 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 09:15:47 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:15:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVplyBn+LubmOMlDEiruUGtYNJofLY6224J4FInxnoxq5IN6joPKPni6mAxoY6uKKJ/PtLfLTFpdtZRGS8k4WdIEAjmB4FPSeON6S9jwyops0GZ6Zs1PJofIpQBYCv12zJZVanQ4tUfGCeVAj/7M9+fH5UXFiyPinPEEEnLGQ88fi6yROru9uTRwUzbZzhwz/YVlowvne2jKTnqAvTQZz/m8a1LMbHoQqSbNCfSjLiR4p6VBnTlaC0KZDNEjBN/dZaLg+Z+dAuP4pIruRxeQwLxEkUgb3yrG3uuuhx+ky12rB/jL8CTaNPU7nryobr/2gw1hwPtF1TDzCCkukoyvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrcKFjMyUxUSCiK4zEO0Pp14IbvbTcaVnXSwFQdxhkM=;
 b=QN8MdYkYrSlSZxZkpXY08kvBhPY62lb6Y8YoM+M4J1KdUJMhptpESO2dJJDmZ/VSxyO/IEv/LcmrOlP2nSDzvJD2MQD2gNE0PU9T0ddGXaljCst05rn143i0sciZHN5eyc2ptR8QcqioO9GYEdn3ET9p+evmrz20nHpsyVS4v6psNBMFvnQpyTih9PV1JsTokWqEwxIFRtweQsjg11pvz47eWEm1YQpVdHmuo4D8nMBJmHIcq1iXyZQ1WYpJR80NJru14uX4CfJcMCrlK46umFrjEO0rHjhvBhvQA5cA935b6TH43xpdWkLP5PdJDD04tLc6DnqFVWD48RAGc9GIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 17:15:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 17:15:45 +0000
Date: Thu, 12 Feb 2026 17:15:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Radu
 Nicolau" <radu.nicolau@intel.com>, Declan Doherty <declan.doherty@intel.com>
Subject: Re: [PATCH v5 04/12] net/ixgbe: fix potential null dereference in
 IPsec
Message-ID: <aY4KvHDF6dmWobwP@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770900757.git.anatoly.burakov@intel.com>
 <cover.1770900757.git.anatoly.burakov@intel.com>
 <c90dd3517961437012e26f9f1abc5e7fa2d8d935.1770900758.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c90dd3517961437012e26f9f1abc5e7fa2d8d935.1770900758.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0085.eurprd04.prod.outlook.com
 (2603:10a6:10:232::30) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: bbcc59eb-e7dc-4b48-3065-08de6a5a5bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q5BCir6ASe1FUseNGJxonzjZ16iywNhJawkogMaETVvur5JGeGEjnJWsqj76?=
 =?us-ascii?Q?OT7J21EBxUQR984HJizfScjr2ZaBY5XBruYhU7+1vV4XQ45mAV4R84S2E231?=
 =?us-ascii?Q?JV58YLFr2uro24TOtOZBI7GXYAffIIZc1tMcYkrRlhv6Iia6jgEZwUaWxuQG?=
 =?us-ascii?Q?JWHwBCZ+d6X72SlDgMXK0HYbpKbqwe9kY/SHj/xz4N6NBRytJ9SANMF6BW/1?=
 =?us-ascii?Q?QxxwXqgIsf17DNvYMBocL6nx9iA9Ee0g0tYHCGJqAAQu/Qd743xslZrdDY+S?=
 =?us-ascii?Q?YZoHyCjkGI0JTwFQ2bW8Xn4sh84/5U2YqoZOLr9DdllVgiuPKn6XJdJe6TgM?=
 =?us-ascii?Q?f8ogIRlauoTYcxslDWFvjodTxUr8P6p0GtRsdGLo9Caaz+fSAfQbhyrgcSJk?=
 =?us-ascii?Q?rIZDYt4beEuQgN2JBK45xDzo2bX6aQXbg20zhJzsSAeyueaKqo/tLTip/0dm?=
 =?us-ascii?Q?DTiUrdm8mtj6Cr2Jr5pLFGUpBQYMxkHzGLeS1lltP+lwt62lGXLlWACQ9Eme?=
 =?us-ascii?Q?bhsae3iY79sx0XsA21dAPalGgJ7P5udFbgdQHWBjGEdt66hUKCbGdwF2Syic?=
 =?us-ascii?Q?gfbRDm9h+LaBGJK3pnoKZmzIIZvHPcyXEtzLMBJ6VO9lKeiE2uBgB1mvkIxI?=
 =?us-ascii?Q?X22RG8PbOuX+UbXsUoU5yyzBM+6pufCe9O1ZcHJNxqlBEZ9nSCYGLW3NNdfn?=
 =?us-ascii?Q?i6biALHNaM397/9iAhL9RZtyb8iPyWXoK6JaORENJQsq9gTZjn+rhAjtT2In?=
 =?us-ascii?Q?hbkuQViMsLYaLwgI0vyNG1P/GyIYEYGzAiNEtwkeLtishz2ZBcpdPzT+nXev?=
 =?us-ascii?Q?qqDRGymta8nTP6PlMvEL3kqmGyGKaV+Pe2INmt/YS5BeIA4E1cM/k/JqE5/X?=
 =?us-ascii?Q?h+awQnn2JYppso7TnHaq2OQCCw0fI2qXNbu69tgqgpr3D5R5PFPr82qhxGMP?=
 =?us-ascii?Q?oqUrgl7atKPMTuIK/AGmxQBHTX2tqrxUrd3M/cpYvvEWJWORCQdN9qKVrn2r?=
 =?us-ascii?Q?yHFq5YzBIP06GUdWX5spS9yurxjjUUbbjUVO2JukLWvsq3EmlRcchhdBnr9y?=
 =?us-ascii?Q?G/ihX89WuYhh1AcjxBkWG32jxkvBXaLD+Hv9JdffAn/ZtrtJ5UnRQRF6KdzS?=
 =?us-ascii?Q?nChpn26x++lwnB38dNtQAF9Qg4Xghut7ap7Fef67edoh6qvreBnChl9f05p7?=
 =?us-ascii?Q?v5tA7NLPusFQXb3iKa3uyaAhArmBxBraNbvoO63a4gc8EEigZCuLfQD4Ac0P?=
 =?us-ascii?Q?Uv8eIaIVo/fbW7OVYwsPN2vGs7D0MqKIsOQiny8H0wm4k1hPl5gEDRzZg00Z?=
 =?us-ascii?Q?TBD2+2eHwrPOu+ZOO42YWXHC+Uebz1l2KbK9FWURreVn1+CcKBcVDq12C2Wu?=
 =?us-ascii?Q?006JUmXtb/XFbZOLvAiz9BF9G4IygADgFXIOcBVBCh0mu91jGrIJB/UWGpBr?=
 =?us-ascii?Q?308KtASIaP7kwp4Am/WSrnS5h5GcLC+ISM9fi10VgL/vcN1bYAAKZ5eEaC6H?=
 =?us-ascii?Q?mnDcGsgbhKGCzsIy6+S38ImSxGfMbuHX5gVGIAHRNiQ+jheP4APvSFUbkXxN?=
 =?us-ascii?Q?8YRRU1waKfgBw+Wu5HU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HVl5J4hcPkyaWs2PttGmtLxu2vCOjqXc8u71TtCdBv8nO3UmljqKRMZ1AroL?=
 =?us-ascii?Q?B6iL8aDg5WFZO1q9s7qM2EvyEaY1GyTGSNzErh0Jbi1c7PlMOJ/cWSTPrhtL?=
 =?us-ascii?Q?Ya7jS9XTyY3yBSzvqUoMTDp/QRw1yAyghLUb0BddjDws/d+fhajIBPw4ds/t?=
 =?us-ascii?Q?Q0V43PpmMzFHiNRaIUWBi0j7KKGuhzyA8lEqcXHvwawHcR52707mtMl/PKWA?=
 =?us-ascii?Q?GoVJrW8Kxsp1hCsYsbBzXdaenGfvsun+PhH/oU0H2QWzvEyiFsN8rlvtKFhm?=
 =?us-ascii?Q?EX35EN7v1qPrhtavrBoo3W26gmnz+liamSUztm3FNKeI0a7MONXJh+gnPOYE?=
 =?us-ascii?Q?jJ98mf0Z/eFi5Ak8uumUuRXtaZaGoxgIsJ7+opRH1XsdJk/kD5mP1MPfEnRy?=
 =?us-ascii?Q?kLPVheZsqYTnq3gVK4UZeZh4MWZztGoJk6jK0/8ZY1uCodTIpccD9Dr/4jwH?=
 =?us-ascii?Q?v4YIUqBrvxCtO9fwFNS7s4cAAA9HDByNgn2j8KP/isHFstun9/dNur0MtnBL?=
 =?us-ascii?Q?refORauH/Xz0BPD8KIK0DuN+OQY8epZHMH3YSMgQluIleVotySzznaAtuail?=
 =?us-ascii?Q?RCcTgSoJjeJcT0V5IBHiBlTp+vdB4AR3nv/kjNa4LwUPq/Pt0EEeoeZnIekB?=
 =?us-ascii?Q?vntK4MbWKMQ0JR/9x8DUoljSuSWmGDSRB174/AAImmZvlpjQ07F03FvO4AYt?=
 =?us-ascii?Q?Qw1vNsNEvY40C0Nm0nprykf2fspRWKlQhH/82CKuHudxGcGQlCkBLsL9eXr6?=
 =?us-ascii?Q?M96WlM0nUNgzaZ95srbxzW07UkbSY4Ab09y/fsWwY0BzgQlrjTkef9Y5dwdg?=
 =?us-ascii?Q?JW6jRMrtgs3BAoHor1leBVvj1ahPBmdsTO0uvi313XgPUngHwuwyRuM6RzjF?=
 =?us-ascii?Q?DlCgfmqUg+euqHZjYvXVjW3lz0zpR5J4pD0gZHM4yYSlozD9ccH1Yy+BcKLU?=
 =?us-ascii?Q?HbQevLHYR9596wMhMeCue8MyYf2Yo5P+Z6yJOOflyFGVaQwYsr94KLOVw5lv?=
 =?us-ascii?Q?FJltGrRZLYjoHqzOyOybA2AAISsZ3WRrNSvQuHqo1YoORR/BwLn8v/D/CLEu?=
 =?us-ascii?Q?W5Y13NFRsCrztJI6O2E2KYEnQ85uxMUcGwI1SgatO6VqC65P/BN1ZyQ47kSG?=
 =?us-ascii?Q?UOqmkCsxf8qrdeF3lx0LAQdkaCPv6Y9R81a7oJAo8OSPn+NqqTZqlneD4TEG?=
 =?us-ascii?Q?MPj/iU0DHTywEtsDx4q3rcbC0aFeVcmT/GFHRyMQbntMXVueS3N17FPyavVP?=
 =?us-ascii?Q?8rERAwEJ+Gsfs720HiRfKkjhwdXAuDZfyo0fkH7EOXtkQbeKQ/uhl4ZwM+6E?=
 =?us-ascii?Q?TU6UzIH/7JMV3XT9pLTxNH8XNAq+3VPX9+ETNInvkfTMUK01DikGvT7hc5b9?=
 =?us-ascii?Q?XhXHjZzGsdulTm3L2o+CMONuFrTR4Tuj4Gz0EAQ5bNKWXlDqoyR0ZohsPmLc?=
 =?us-ascii?Q?63mi7rbnvNzxX/BLwywMi4xklEiv8xu/4RD+pkrR71kaTnmXsWDQJYS1doB5?=
 =?us-ascii?Q?eCeT8rnmOteJFic/2/jLCrpduiFo9irYPfAu6roeKNNpYfx69+8zrXnwRJSl?=
 =?us-ascii?Q?Ic993R6MiaBCmfzX/adZPYIiVCjNNDEDW8ZFmHi06Tlm91luSvL4o2arivdp?=
 =?us-ascii?Q?wobRNI2H2/SgHdgQELMQbUmat7u5ipApzIku2fuXXjd38zNO0qwnoB524TeR?=
 =?us-ascii?Q?aiN5Fo4ux7siIAGfhiuaR9Wzz39b2Z55AXiYe23oS2SfT9moMvYXxCo5LVXQ?=
 =?us-ascii?Q?/EOFZGO6C4yMeb6py0aPxQIjZ/rB2HI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcc59eb-e7dc-4b48-3065-08de6a5a5bd2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:15:45.5654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9Xgq5yZ83zqIXVuIHs9ZJhFzsyTUpfuxDpPZRonrqTZ1tdnIWJmXteNi3bcFid82uSRtA6rltQukUPtKUHPaQellKypQ427k9cdvBi/d1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
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

On Thu, Feb 12, 2026 at 12:53:27PM +0000, Anatoly Burakov wrote:
> Currently, IPsec flow parser will look for IPv4 flow item in the pattern,
> and then pass it to IPsec SA flow function. However, we do not check if the
> spec pointer is actually valid. Fix by adding the check.
> 
> Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  drivers/net/intel/ixgbe/ixgbe_flow.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
> index 81b983ce69..90a24806d2 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> @@ -251,6 +251,12 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
>  			}
>  			item = next_no_void_pattern(pattern, item);
>  		}
> +		if (item->spec == NULL) {
> +			rte_flow_error_set(error, EINVAL,
> +					RTE_FLOW_ERROR_TYPE_ITEM_SPEC, item,
> +					"NULL IP pattern.");
> +			return -rte_errno;
> +		}
>  
>  		filter->proto = IPPROTO_ESP;
>  		return ixgbe_crypto_add_ingress_sa_from_flow(conf, item->spec,
> -- 
> 2.47.3
> 
