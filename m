Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29759CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:33:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55A1B402DF;
	Thu, 15 Oct 2026 16:33:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5C185402DF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:33:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792074823; x=1823610823;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6CvsXZqFZFQM3gR3727Z09dUmpWn/JvtShRhezjUIhM=;
 b=I01W6G82pJ8j00suX0CjlVLVTNfg7h8XMkdpoZMuYOaxDupXb4yAHYgC
 DhEd9uAyfxdvEdeWF4R+an6pfdGGSqNZhgtoN8qGgOxpYw7EuruG5KUKz
 mJFNHGkmyty/8oAV80XI3X6kz/rdlgGnA0RxOMZekIZvKBsogsDmcLHeF
 W09cUoU5O0vi1ptt/O1fH73UpSk/o+z2UdaBenxMTJ7TobJ0iBkv/Q5h6
 lA3y3PRrqfZeKbhPDU/sqL5L0o7GK7TG6XjgyfLCPIudh7jHW3xZ6d97M
 mMj0uXn2QOnuPjXjFSuB8ky5Q74SJPnc9axfwehZkxZyTj7VDmTsYhi+z A==;
X-CSE-ConnectionGUID: rjOTFQmnSGaOOQWJV/DS3w==
X-CSE-MsgGUID: G8Gz596KQ++l0ALmztht/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="950454"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="950454"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:33:41 -0700
X-CSE-ConnectionGUID: DQmFriK9S6SdHe5k1xnjIw==
X-CSE-MsgGUID: IBiFQ2frQaeCjrqGSapFlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1724765"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:33:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:33:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:33:40 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:33:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyIb9A1aoOp2AT7tCnf/rRwY83KqMXtUJ8n9H109g45WHBxJXuozTUlxMqr0MAYq3bY6dxAQbMPTLmhoQyn9IH4h2IsCeO/ElvAHYKrc+iJ+EJ1y0jndRY0OGhUjVOLeXa+KNbKfy/iV/smoEJWY2dWZ73fLlenykDcmX1Cb/3tniZOfWSboEZTiWNnW5BDFWnOJxW08vZKqnwEdqJCvmFQh3Dq0qcLYO1cPN3bvqDu/TxH0eIkYg/FmlwlrnoWvbZO+OeynOtHu7bq+5W67tbE34Rut2xlZnZ+61Nz1GDI2fdApnZR408bMZTzeVjQ/C2/1T0ka2xDUYyFoB1mAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvrrF/Zvr43C2cV1rYX/WvCZv61kIHngD7IPeK/nGZU=;
 b=fm4+PFtMi9bb+be09gCI6GITGhv9quzLiKk2rtkLRYG/CDy8IgyMHiJpUYN1X0iwKtR2UqG/zg2oqYOxzrkjS4ZzAXsKawG9EmUKxQbS+P4/7AZ79CyUNB0nHQ1NRP6xE51E1DHTRl2DOrJZJzg+7/xWrf0whK5lIBjvy6Rg3gvJuB2oZU4T14du+CI9w/qb5TrN65oeyCErYQZVIrC/jSg2wx2ckJ1tqgIDSrZdVHG76NI9Lk1zwr1+8wyNPgSu+20TZSbPKlS5S7kK3es8EfsGssZ9NGX3e6nVYs72laOBZTgEvmXG7jwqgxve7Kgkhh2ab0ho8bYLoGHT5q1LRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ0PR11MB5022.namprd11.prod.outlook.com (2603:10b6:a03:2d7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Thu, 15 Oct
 2026 14:33:38 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:33:38 +0000
Date: Thu, 15 Oct 2026 15:33:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Ciara
 Loftus" <ciara.loftus@intel.com>
Subject: Re: [PATCH v2 2/3] net/iavf: do not include private headers in testpmd
Message-ID: <atDkPRQ8fZ1FhhXe@bricha3-mobl1.ger.corp.intel.com>
References: <35d9aed797cb433296b1c0d53fbda4b45c38e833.1792074055.git.anatoly.burakov@intel.com>
 <1e05a203951906eb042fcf1010d2b120c85bb4d2.1792074055.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1e05a203951906eb042fcf1010d2b120c85bb4d2.1792074055.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ0PR11MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: 523a4143-7c55-4147-f584-08df2ac94ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|261009223027099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: QO/r2tG5hahpmNrF9U1FQLujPrXQJRlSFpIyW/zQdJuMxrW/AkbSjjWe6oYrNo7eaVKQt3VUasRp1ihDsCU9Htv6e0az0nT2dECNrGLtogOleVpuAkTcVmGby691qNwfJpLFGB+cmX/jYEpdTMN1MsmtJ343yLnwmwQ2R3a3L+N8qvLNqJhR7sRbmIekrX82oo3GP8qpDYpMHHFJMR2PTZfsYPheUfArO56EKK+PlZB1P/QmAHIZsvhCBhWN05kL+fdu9Kietk/d21nVf+Yc426Vf5jJbLRoy3uh+iUQ4O3qRhkAkcBpXOLdrVYobQbvnhBLerDespmTUO3bgkb96LU64OJmR3Q8tRcd4wcxRqaqr63DKZLAGwHi6pk18ekCZbJdrwxr/A88YkE6vlJNI9R94fGg5MSy/Gj4vQ23sD41xXyXWtYl+OFpt7+fjncU15K7nUnYoIoUZQbhkRNN4RQji1GxI5GugWE99c9DoxBocb5dMQROduiYWqfTNXvhdi4bASwUhj0O2wcyGqEEg591By7W2MSHnm2NKt+2kSMatK8cBFQflDuU8CTZ94pNWvuW/6+VrH/+Hsf27UfDyMJJfLtzTyVayzUNWTt4Gfg1hQ3fJlv91y+KsJl7mKOUnFQyV3nVM9ZVa14rn/bMkYGAQtoMXnMB9H3pQ8qkdeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mpv4QPJODxxabjOlq2cJE+0GcCWyk4W5rXUliiHnL40D+abg1kDakPwySL4H?=
 =?us-ascii?Q?+dZZb9LLPjr/T+z30rSVi7fn+E0U35KzUOlQvffNoISO9Di8LakUuJQKUAO+?=
 =?us-ascii?Q?QfU3bHERKFdN450Yma5mnyOX8+l0+WPVYdAbm4CW/XVjK4trtLg1+sciyS5V?=
 =?us-ascii?Q?DiCzY0fjGFEZHDicUnZzikJ9DmWvb+iFf9ci906Q5dFEO6gU0C0OH+sv96uT?=
 =?us-ascii?Q?8vjJar88mlWiTfUskPtkjn6rl4xiGgPL/VDTHOSwekb93DYRIMBdEqSOXWmY?=
 =?us-ascii?Q?ULtnxPk+XShT/8f5Ju4jKnhl6akZwENM82A6TRikwlK7agDJSYZpv7H9xOqQ?=
 =?us-ascii?Q?60ASSsHPDsKr/Ft4zLmHXNwcV2b56L9iLmL/xRaQYtdwPV60641APqjM3IqJ?=
 =?us-ascii?Q?sOMTbWf8mZqp+YyHr1avXDOl2Ls+LF0XqBTIvG1P+oxqc4ULpOmXqyTs1891?=
 =?us-ascii?Q?C9TEp9UlELT9SIic6LWbfRmvmzvJbe511mMkybNt6hGebv1u+Y4r/Xr9mlcf?=
 =?us-ascii?Q?pnp30IGVPLmozKeEabqjDl06w8ZE/zJVIeWqsPIuiMsAFY0Zx4eydwzC/Zzn?=
 =?us-ascii?Q?NEbVC13qVGzH9CeDbii19ENgPT8B7ktMmofZ32pOsqEJSYRanW4Cz0+unChV?=
 =?us-ascii?Q?f+BVmpMATMRiWOk3ebjWt7N7txzaEBILpUWO6/rv+HNkcguNRX0ThwLIrxpr?=
 =?us-ascii?Q?rUHjFvyu1/GYOAByaxMgj2zQKScBz5iRtQNZrWMa9/KiVIWthtWAF9/hLFuJ?=
 =?us-ascii?Q?RGRjSMkgQ9YhZt5mMLZ+6zbL6eNDrZZsx1+k0PpxlRZ3+ZVBhSs3a9uzMbTX?=
 =?us-ascii?Q?MW+9zmtREkUSS7FoTC7CnHvJZau0/zFdCL9ToAZVmlODafQhGn3lt2lAOTey?=
 =?us-ascii?Q?PN1Lpqn+Toq2Kg6l7d0Op7M9XMVFm13aE+hL2K2tVWRha8rwJKfDatPj3Fuz?=
 =?us-ascii?Q?yF2JmpK7Z2Mg1000Xs2W0sPcu+y9wCKshHyRgPvO7MJKVGnhCgTM/kLmgTsn?=
 =?us-ascii?Q?HeUYDQ3grh5jurDGECg8Uj4OpH++NAGwN4i4myOdz2T+1FdlGjXyF3XTFtSS?=
 =?us-ascii?Q?+8txvzxrafmPQMfOosTHx9agm8AOFlqSVzMLGrSaOSTr7aOb8JFlig5Hu64G?=
 =?us-ascii?Q?wzbEkyIoBpUOuDrQnRWjwZU03xqcTnLtgzZ0vuInqiIhs/2Qno0vqVzY7kxP?=
 =?us-ascii?Q?1xk2OMygLJxsCoNtcmiefrEw3jL3NVPaF0BDBo5kfIyHD6PSW5ndL9l5tTMF?=
 =?us-ascii?Q?yDieAmbnuRTs4JMDaUzQABMLBU/2SXRXp8vGXAbgeP1aVnDNNOEMyKLV06TU?=
 =?us-ascii?Q?KO/NbMppu0MTTrsdU8esLh5eR1UuHsyB9N+VVy0rtfVf4kYFn49P+JIbrHpg?=
 =?us-ascii?Q?M+RngU1k3hBTjq+pK8IChFXplUcqAvqVt0OYlQ5EXiWvOmaeaKy57w6kmg4X?=
 =?us-ascii?Q?wqyoklmlvvycJGqbyTIXeXpzcRQK22nZAJW/Jbkl6keS6yflDcFxi/cWYWlp?=
 =?us-ascii?Q?NJuqQh6kUUwHss/Iy51YqAR2YaGDngggYET7PsgTQFphUMSGR42hIdwaw5mT?=
 =?us-ascii?Q?fD1d8f9oZffcg1F7DfKDLLRAX8AHU/p/Lff+N8gl2aBye05ue84i76iGjgA1?=
 =?us-ascii?Q?jaqQcX/b4dzQ3uOM3B71/iSGJdr0e9Y7sy4kTSjdVGa6E06gAZ3+v1NMp/nJ?=
 =?us-ascii?Q?OV1RV8t3C4sc83qnGzPg20a9uZGF7JGWvmq3ngZkaVGmuCg4c9I3apDQHacj?=
 =?us-ascii?Q?fWUeTD5QDW6PFBk1tTJ9y6Ivr4e1xqM=3D?=
X-Exchange-RoutingPolicyChecked: nOj0QOOFmKAQq0EyqckAlvJofgNNCaIf1b5ILBsftr3akujprBxTDRtg1dDwselRDbeiD2HbZq2FYYDu8ODf1k4X4NKFC7cF37o/cEb1JRFxrNak7py+y9hbIUlJ2v7W0HeiC4cl+UkJEgvRvMPPDZc/nNnpS0wQ44SjTr41L/MNz39+ftNtHPzy5UsZnKdyILX/dgU0W2Pc7/y6gdj0oGYkiUGnQlV4aEJtmGpJ2g7BBSl4X5fxyYQ7+v2R6HY2dGWCvJeT1hb09uN5SQQ5XQTwsP1cB+r9uUWh6Grn3JNk8xSNnnYvXErkF2Duksyuu2txni2gsp9aUL2sm8BjnA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 523a4143-7c55-4147-f584-08df2ac94ce8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:33:37.9016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLYVY7hd9LUC6xufw+i0rBMFN0abb+b9pC2EnZs+Yyo+s9p6nZZM7T5E0cN5lMs+0DCcu0r1NRQoNd61PZN6c4eTI0Bp+TVtlVxt3ZTDEKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5022
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

On Thu, Oct 15, 2026 at 03:21:03PM +0100, Anatoly Burakov wrote:
> Currently, the `iavf_testpmd.c` file includes headers that are only
> available to driver itself, but should not be available to applications,
> including testpmd.
> 
> Fix the testpmd file to not include private headers (they are unused).
> 
> Fixes: c702044ed909 ("net/iavf: remove Tx LLDP dynfield method")
> Cc: ciara.loftus@intel.com
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>  drivers/net/intel/iavf/iavf_testpmd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_testpmd.c b/drivers/net/intel/iavf/iavf_testpmd.c
> index f3b932da04..1146f534e3 100644
> --- a/drivers/net/intel/iavf/iavf_testpmd.c
> +++ b/drivers/net/intel/iavf/iavf_testpmd.c
> @@ -9,9 +9,7 @@
>  #include <cmdline_parse_num.h>
>  #include <cmdline_parse_string.h>
>  
> -#include "iavf.h"
>  #include "testpmd.h"
> -#include "iavf_rxtx.h"
>  
>  struct cmd_reinit_result {
>  	cmdline_fixed_string_t port;
> -- 
> 2.52.0
> 
