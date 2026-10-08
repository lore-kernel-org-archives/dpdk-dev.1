Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0836CA600E
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 09:56:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6686140274;
	Thu,  8 Oct 2026 11:56:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0F2704026D;
 Thu,  8 Oct 2026 11:56:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791453371; x=1822989371;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YVZLgCvHk3qljh7QInXoZHRFhFKHJfYELQcOABPTTTc=;
 b=g/nTAc9kHdKalTi5tlFHqukRA774SjV37KctqdsFjjGM1USPhdtg6Ja+
 JAS+lVZ4YIXbk5g+HbzZCoXyCiqvSDoPoovFTix98/i48IicjsbrQiDPg
 tIBbvvD98R6k6nu/PWSYU1hTioJoaYX97mNx+5yNIrk+JXrpEvEzjVilD
 P9t7M7QNdMgOSmdDOTGElsNQI97aLEnh8hVdIBneht+Q6rNdPH0HYxVEQ
 Ofrd4cTxLKCTHv7STT6vB0GXiDXjoyU0v5ant1kBy+PAqkmeeLMsK8x7X
 bavidUUwOlMBTIaJKtOACOo8izjdcW4gIhzUBbrkq/kra7JtaDMul/kYO w==;
X-CSE-ConnectionGUID: ZfZmMG16QdeX1Gx5ouB0Sg==
X-CSE-MsgGUID: llTaVJgVQ72AKF0r7MTtMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="133453"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="133453"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 02:56:09 -0700
X-CSE-ConnectionGUID: Un18yR7jRpyY1MR2M5Rxjg==
X-CSE-MsgGUID: 54GlZyRHSHyNsj+/oS280A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="104878"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 02:56:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 02:56:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 02:56:08 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 02:56:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmwZrUJTdH6QGYR+ziM5C4ArAu/7YKbwXjiMX1Rty3rABpcg7pBKwaVC9Hf/ncAO/p19K0RKP8Wf5A8Xr/HMjMPra6Ne+vSRFmRm/4bPcWXeB8BJVioG5nDPPRq9pPYtB2xk0xXOcdOsAgvNoPBWufd+txZmqJhUYxsD+DqXMdBfuf2eewDPreb1VZ/jlDxGiaY/YHisPlcVE1TuuQjC7PDyGYQPontjIRBo6IsX0Dur+u0qEyvBYoM5JhlYgfvmioES2xrIE1o3V9O88YJV3appcnLuufQ65VtuE4kMBoGksXwM5QV6o22KWMR+jAV6sWAFGGrcPls+/18q6ja5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONHfPbEXkn3QoMm83lt8y8TGAZ+XNG585Zw3K/gt3tI=;
 b=K1FQrqUZPSzREfSrjkbPMhLVLFzs6Oihq6IoD0EgXm/rQixyCfBpam0stBeJpJ4BXzLOUvDVeYuFGreqfn8u2zZbTBJuKKVQYEFyQoi8fQ161Czci1GqtGZIR0YqaUZ2Zr6ANRU4oI7N9S5fF/5+cF2WbNgzyqky6aEAxl43QXalb5b82nuOGtklnGSef0dbxpG0nkOzT6KReczDk6Kz9RqOY3ZIMIXjYFQfmcAVHIWyGDCQ4scs1cVFRKH+lzFnUw3oznZzsHvnZQvALUFJ0DfJIjsDaFv50ftToEHLdD9QeR/BYzUc2ZZRKju9r+RRd8urz/v6d0h7q5XvAw8EwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH3PPF1BAF94C4A.namprd11.prod.outlook.com (2603:10b6:518:1::d0d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 09:56:07 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 09:56:07 +0000
Date: Thu, 8 Oct 2026 10:56:01 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Dmitry Kozlyuk
 <dmitry.kozliuk@gmail.com>
Subject: Re: [PATCH 01/20] eal: add missing export for rte_basename
Message-ID: <asdosWp2NOAN6Otn@bricha3-mobl1.ger.corp.intel.com>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
 <20261007214115.3092715-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007214115.3092715-2-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0167.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::8) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH3PPF1BAF94C4A:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e7a3dc-44b3-4905-4059-08df25225f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: xcXEysq+7hCO9MCjhLG4srBP6cm2pjCGxLKxkmPNYj1QLFzqLoNQ9+U0+wrqcd2nMfI4rJ4Xt8HhGMtaBfUJVciV4ExqK4e91z/ipBH0eizb9mxAwt8Wv79ElXh8FE/5CM7qxx1QOAVJBqMtKPPvvtFaMHPRy3EKIo5azZUa43vJ9wPJ8VXTCZyZJV6W/bDrPdoyvrSly1U2MYucA6iErhq4rP18WW8p6/ClpRY3ZeZahcD5cFhzrgiAJ3s5wbL7uPOA18dSrAfn1axCG23pXAVcRcLpHvoUfZHZkbmXe+MiSc6V0mwbNrkfgf8Bl2gaK3wiJiArTVM/MA68HJAuykZOMvoW91ej0zoYavyd0Q9xmV/Tu8zX7LWs5/8cjVSV2LzHL1yeV6SFn830ifQjz1WLRMQm2kFJDYfnXkSUJmoHS6lJb7XL1jQth4UtQLq/urPUBIfonH+OWJ7d7XMpN23jAvrjMcKOlJ5aQSiXOZ4oEA47/SQRfeVBqWa5gNEX7uE9jUPPAle+XDC39zXPbtrVLdKLUkRaqjdoKoWSVKnkgBSjDA+uBpPKNp3piPvELXQmqLReBk8e4N4DXVNR4aKQmvgdxOIT6aEyWbSpkpR+So4I6mY35S2ifZXoWtbRvR/iKGTd+wAUM/8JPqKlSBo7qTf0EqDbpcQ0tAArNNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d5X1NAyxCzJW/7ZoXj5uQV5x3i1avWuLW6TShpXmDtzar7ZN2Mq1f02zVCcu?=
 =?us-ascii?Q?Jj0aoYd+rRPBbW1n2e76O1gUNDSVhPrNCB1JGTV0ZFOjOJVcm+hgKo04ahJD?=
 =?us-ascii?Q?Wj4aAk2v/7FDjLaVZvFEKWQRD91Og/ocbm+rdAd6xWbG+TOahTzfEonvAkGr?=
 =?us-ascii?Q?H3zhU5vz/ITVXCacvM5CxnLRLqVwXEfzUSjBMrQqsGsOJf+H1LsVf+MzzhVM?=
 =?us-ascii?Q?UieiRXDjFlVybkYp7YkWJisAGQogcvjUvTARcvlIMa57sad3BVfWy+sliYfm?=
 =?us-ascii?Q?lBwL7TmLRLukQ+m2qJWE1xU6AJrM+TiMfx5J3OLvmotftr6TWvicIcyfOoM6?=
 =?us-ascii?Q?m/7LXpbs+qF0p0LQxmnMnkhDFgPSqi6i6YMW4BU2zFbQsKqSyyamWhFtJvrN?=
 =?us-ascii?Q?JiiyERGtL9qlui+JViZVHaDJxBk8dlnHRoX2zN48yRJXUhvb2MF8pqI6OeUL?=
 =?us-ascii?Q?OXjU/LDJGwpskpmm7aed2xJRO3JlwlKttj2aA6sxUd32PYRwhrjmycAURjIf?=
 =?us-ascii?Q?RRqsXKUksLDzj6AqYbapteatAdA2r7pSijlnI81gcrybZgLo29WR57kzMhm8?=
 =?us-ascii?Q?ADCBzYizxMWO8k7h1F/N27/euPskqal22SBdd+i1ERyFkhR/BvBpqvXGbFKD?=
 =?us-ascii?Q?+ZtcdpAAiqKmtNY8yeAWsjT39O+NLg4Vqb4FeMgLgjnuaTuxkJKW/cgSvdQS?=
 =?us-ascii?Q?hDI4OR3hwYrgDnIcdDyYNtm2A1jUmpmEhA8imf/feJJ7SrpJR7YgdUSEPrcw?=
 =?us-ascii?Q?G7ifnl2xNu+ur0duQ4DQNeFH2Bq3URgAzXc4kxzPD9devS2SzAwclp0qzA9m?=
 =?us-ascii?Q?uBVIJXKPhjWuINfbhrJwTArS8LHbmw3KA03zmEr9mOAo5/i+UwWsuILudPve?=
 =?us-ascii?Q?Yd9/FB9ydfg7DS/Civ+EeCtJitzEwHSuKkQxguTyaacRcrm34eaWBsq0t1i0?=
 =?us-ascii?Q?Z7ntjKxbQ1FD54PCaIltiMxzK2J1P0ELH9blxVACp5UTvfawR/UzIwGV6epD?=
 =?us-ascii?Q?seqRgaLGtwV3ctJHgD6GKfzNwv5mTAwQHjSlrk5rp/7IDpw6fhN4EpH16vTe?=
 =?us-ascii?Q?+G8RYefXkGLJO0q5yoGwsa+9Dp4NN2qgrhP3+ra7MnWhOPr+nNlBO4wEdlZF?=
 =?us-ascii?Q?FtwmEEV+Yhpa6qc51NkBsK/84JgviqDiaBgv8Y0cnqv8DdioRoMeODu2ztxm?=
 =?us-ascii?Q?lUvyrdDd1LTkSnM2mx7kXUHLMABjq770bsx///QeSL3VmiEduJuhqAxfVbt+?=
 =?us-ascii?Q?5/CPfk3SLyMiFfxfpi3BkZNUdIIzCyzd3JtfJLbLCJ72KE+6+lk+vYMwBd8d?=
 =?us-ascii?Q?DRWWhvisNd3hreXz39NQMYCv2Sgft8iVtjkw5zKmHWz0I4YUhK95Kp9qK/3N?=
 =?us-ascii?Q?B4Lvw7ykAf5XkhdfMTP9ZyzjEHFVGmoIDnLec86LBoK5mojIi/iem96gcTJW?=
 =?us-ascii?Q?WQXZ214J7/AEwksWBtHn80KPYmyDFw3/Fre5yKIz5iO9c15csJxqYsnKbox7?=
 =?us-ascii?Q?wDZyp0ZjTR/LnNJ3FzOanUTmzU6hj1dGn8BVxSaW5u7B9JXSkbPplUdWMUBH?=
 =?us-ascii?Q?n9RJA48kSH32xsfCKrePqhZR4gQqRgVks8tEBDC/vG9EI7EbtH0MlhnawsO+?=
 =?us-ascii?Q?Izaey5T6N4VKADEVcW2EktGN6rCTpLbL/6yeoigO1yQvRmrN+2CuT3ZvrQLB?=
 =?us-ascii?Q?817S866dSyJiVY20H/zjx39/78boGFCmqcP+89BEFuJyo3suvsp53xqFf/5W?=
 =?us-ascii?Q?4MO0LvupdXRkNbZMhxqFiLyyfRkdJas=3D?=
X-Exchange-RoutingPolicyChecked: kWL8xJYjuxQMF4K1qUFvQyNo6Qe5qP5KgDapssiK3vbCFLT0j2zfN0eT+WZFKQ8V/uB7dae2WzH8zaon5j1ZUGwfuEPq1+pFR5kRC+iLGNRnH+mPHNpRQd+qQt660ZUNjZFnIMPDgn5nwi/6FtEf4t622Zn1eXDH2AjIstETX1zGft+wc73nksyORvUethuXBvs6PHnRDVqnkT5DYOiojWEJQG+lSPySJcZ63nx5aqB/s36VRGyYMA1kXBQd9odQkWHEQ0fJAePL0ynmSBs5NxNFv0lJPxgN0P73ZW3f7nyt27QwI08rWG39D42eOA45cqBJw15tx4Sobzm0IWprmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e7a3dc-44b3-4905-4059-08df25225f58
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:56:06.9930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unfT1Z28ZoiCNapgcnrdt79vuitvHXyEmeNxxeWkky2PSuKbzyR10+S+O3QNlXySEsJh1UuRD69ZrZF8UELSe005adHVgeiyv/E2jSeJo6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1BAF94C4A
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

On Wed, Oct 07, 2026 at 02:39:31PM -0700, Stephen Hemminger wrote:
> The export for rte_basename was missed on the Windows version.
> If it is a public API it needs to be on all OS's supported.
> 
> Fixes: b8a75ece45fe ("eal: add basename function for common path manipulation")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>  lib/eal/windows/rte_basename.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/eal/windows/rte_basename.c b/lib/eal/windows/rte_basename.c
> index f4dfc08a0a..ede913e6c1 100644
> --- a/lib/eal/windows/rte_basename.c
> +++ b/lib/eal/windows/rte_basename.c
> @@ -4,8 +4,10 @@
>  
>  #include <string.h>
>  #include <stdlib.h>
> +#include <eal_export.h>
>  #include <rte_string_fns.h>
>  
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_basename, 25.11)
>  size_t
>  rte_basename(const char *path, char *buf, size_t buflen)
>  {
> -- 
> 2.53.0
> 
