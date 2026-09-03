Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C45EC61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 09:20:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAF94402D8;
	Thu,  3 Sep 2026 11:20:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 776604028D
 for <dev@dpdk.org>; Thu,  3 Sep 2026 11:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788427248; x=1819963248;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3ks5lwL7oZyh+WT849B1TG2Q5LV/mw/zYpX7fKgqpOs=;
 b=mSnA2ZXKjfV2G/AwhhwkZtjMjrDEpje+Cjce9yorPLfja/kQzJDroXSr
 hEY/vMvtIkCFo8Gi2wf+ctBJ8d1F9lRoB6+3K7ugFp2+EIDcyqSueAkox
 OwSU6j12t66ioasfjAf9XBCS7kYR9eOq/fbHNG+hWmxhvh/6zk7IJHEx7
 ait5zt5qdZyYSpYaUUZZFp5YbI24EEFOBcRcxkLg1WKclcXmyOWsQtpTd
 NrAHGJoEPYplaqe1Sm1+F+cDtuUhjfiFu6fgL6a+bjB4mYOKoG3MRS3XB
 Cgf6uNkvltG6PACuY1qOfH/I8064mgxT5Vb2hM8nbFvLzsMOK5B3pUb4B g==;
X-CSE-ConnectionGUID: YN9+971uTlOSsInER58W7A==
X-CSE-MsgGUID: mf/ylFdIRs2jibvDGNH4dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="114448643"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="114448643"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 02:20:45 -0700
X-CSE-ConnectionGUID: k5jueYQ7TKG6GqFuoofOjQ==
X-CSE-MsgGUID: Q7aqT0IAQCmmgyIBwQI6Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="266426700"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 02:20:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 02:20:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 02:20:45 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.27)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 02:20:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1om0Xw3W8OH37AIMhMlCMFRL/2UCHDFrhbB7/l0R5tdS4oVfNIBLSQmDXS6XYMgS3CmD0Bg0Rb5kjsDNfaE+tQ0/iZO5bRHt5wefSeKLllnyshgeflj5E+k+0PpNJvX12ciu3DRwCzHOLN+hHBUInQ5FCbJRCDqRcZ2l0LoAma2jJUOZGEmvQuU0aPVHryTmnwwUJ24RWpBAz4AmxtwM40ylIWJU7JV0ybj3PK/HRmVcqC6jnPti2leScIE/Gow8xNuiCBqleIrw1SsqFHjlqSTvwPEMm2PkqlNkBT5lRP+KDpDd0Z1o3YsYQggoTsUjtxvODwKNkagfzZJor5MSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epoAZhYNwjeLxjJ61V47jSN3s7vIxN0u4jncyY/6uZA=;
 b=mTBsok5MzT+FBa79vzaeQbFIaPmuC/sv3TJvRhrGwn07opJnPkYpOFcUw5iUIOPSlcUlXjDyWRMEaVIHpWgvns3sN7Ter/C0Ja7C7nuAH/i3VABqZN2BTjf872LbtOzvEIToGYkzeQglZRYwIS6j4eoS//Mv+EdwZLsgDVQqkEplB8Cu8dM1s5P7jz1rZB9KFh3JHjHeDcKHyv2SNnoMQKo4+hWfwStZNPxS38sJhOdipPiSXJGbHeKXp3BTjjW1VHnNY7MveBbiPeSl2nKdMSVEKIe/TeEA+XWqrvOg5BrGBtiCTOgaULACrOyMU8Wx+ueEqi7rfwrTxH4Vh7L6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 09:20:35 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 09:20:35 +0000
Date: Thu, 3 Sep 2026 10:20:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v4 02/23] ethdev: use DPDK byte order conversion
Message-ID: <apk732FF5TwghkqP@bricha3-mobl1.ger.corp.intel.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
 <20260806051004.166778-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806051004.166778-3-stephen@networkplumber.org>
X-ClientProxiedBy: DU6P191CA0071.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::28) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SJ0PR11MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e7f8dd-bb42-4035-b199-08df099c9c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|10067099003|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cVMDA8pRbloYLY30t+ZZbsl9z0ecnPHva4n7FMNUgiHrR54/tUWz6x/ojpXc6Xj6XHc2URxQE6kokDKryLu3eFiOjdkhyorH/a6KXar/h2pJYabXMpsrcbw/zjuSOsBojoDqjOCcMCrL79I25FZCuylYH+Sr69hynDXf5nwbZNS9MLc+81zBWBA8tsuq2535X3pZJ49aZ2U96WQ/H+ZZ0RfdFbO3jFT/3UEN2S8RX50cCuJtJe5nBuX0GnSd2HJvSwcmGlwLHNuiYzKc0m0Zv90ItRXnnGLsnuk83/TTwKU6DpwAz2FrtJrYnzrDG1dmlVnCHWvZavFc9ugZUA93KsHqyMhzCpRsFEVgRphbQzZHa+PZbQv3VsDoeZzJZmFtYBHUHsJ6CzeAGOJdLbOu9E+iK4VIjHGgGtlAr4O+zg+um3JdssmXM0oCYkjGbrDn6W0mik9w/R9O5QT/NmewM/OSIUMxYQLZcg1yvtrZTzA2sIytk21GgAe6bJAoJ77ld+uBL6u/2sbdVSkxktc8Sk3U3tipGgl3xeUj/Yi/f9cPR4dDrp09V8GxM7n1rwmMc7c/noPqZc2sJpDaoPIdU8FYiuQnuwC6y7IgjaGCOrcrYbqZitZo8ylgjWRtDplln9noiBNUK91nst1Wg/gIP6vP6b0IPtnPeIZBXsqeHQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+KQtDLDbrKKjvQ1M9LOBlzEH9+GhQWwIEU4YiOrDiZjlmGFlknIL4eSb+avS?=
 =?us-ascii?Q?jYPtJnFB2aRDYMriQ+yCzMRiSuZvbkZNBK1D25BjgbG86VWEIbuoyLOK5w7i?=
 =?us-ascii?Q?8kFQIEr50TfwpI3dnZELUY+JUNbQl5Q3dsvpt2GDozxJeTkCLXtdXpS6Rl5A?=
 =?us-ascii?Q?/PfRpqes13eVPeJ3VBtHefbtxyNQvU50jQV7s5CjwO2GyvSTGNQma21uQHtu?=
 =?us-ascii?Q?r6+NsJeXusi/MZq2jH7wybr31ftFSUyVPfW11QQvrCK5H24iTNm6SkpeA2EL?=
 =?us-ascii?Q?cJppbo7oe5yX2pb8046F/ViMACLTHcNmgGTLFI2/t5OHmfQ8LYJ0D9azw37/?=
 =?us-ascii?Q?jqzVLcdzd3V1yTf6Dq0euqcrqf9Ph7vsIQHaSGPZXAxExqa54JUwk6/00f+w?=
 =?us-ascii?Q?lGyQ+UyLDKccCWkN2NDFgdGFkiMjytu9MRmECGTXoOzi3pPJZw0XgDhBsml2?=
 =?us-ascii?Q?SlqAohkxMFptvg52r5+0jOJEIirBJqiXmDntlbdzPzB8qAUOFFHk8HGRsX7O?=
 =?us-ascii?Q?iS7tPYbXZAbQ1i7i3LGN5xA0hAAxgS3MmQbkp5bSU2XzSnXaHuARK6UKCheP?=
 =?us-ascii?Q?8oPkd9qRu1DqTfuYF3q//4OIVeYGavoSuuPiTgcsYgVpG3yda5IwztLZIRXo?=
 =?us-ascii?Q?0Teh8vNTcVoFbAfb0zOw0qjmNFfz9DTpDv2WJaRq0O44BJ0NNzHEx81h/E5K?=
 =?us-ascii?Q?AD203mtbrzwyvUOuoOnNV4wKCSJzMfFHf0gM3pJZ1t+TTCaKqymH+adkQ9Hv?=
 =?us-ascii?Q?czHDR6GYaCpG/hmKlB1j6jj87seDaT69N91QMoPFTiFz4NGkPK/OZGLFyzph?=
 =?us-ascii?Q?SzPArCACCddoCq3KudN1QZ7sOudH+P1THxH0a7JmPyhnK9X+XbvTCm9uz1v9?=
 =?us-ascii?Q?02qG0Be7BhiSkh4UX3tHa5qkN9G5F8bcJYpdToPm9cb4xjdzPdrx2A//T5Ix?=
 =?us-ascii?Q?q1IwP7VkiwDEU6LNLLpW3aJRgUz3gKmLbPtTYoUlXCeCjKUK6HCIi3Q9J4vO?=
 =?us-ascii?Q?HtkomGqeTHOkRUtpulHjFOKw02nN9hzY0UVZbueX7bIZA27xAiCuRUA4vfDh?=
 =?us-ascii?Q?z8U9bJqRwXX54yEmBv5jSITylbuwx8V6/2CLM5Oodnm9wSF6ThjRWII4r8Je?=
 =?us-ascii?Q?oznmKhXx6kcWMWlV+64V0VNE+vPEThVMLVKoNEdrAIArDhdeS8Bg8l7aFgUu?=
 =?us-ascii?Q?pzRliMia/Jcbs0u/D9E9iRdWsLNIkISXlNrewBXpUjfQrKmnB1nEVVBzSlvn?=
 =?us-ascii?Q?dY7d0buvUM85OsmxVfK2xKgqNhniFR/LwcfSNgc2CynzOWKjOnifQuEu1y88?=
 =?us-ascii?Q?A6j78cG0RN4DDhc+LyYQVmqRllWoUVkJYrySrn3Uk6ksBQ8KUsx+9Rh5G5pB?=
 =?us-ascii?Q?SNrceaY1XOmovhiM/T05A6AaFrKYn3Q14Q1PX53CmS5iksPS8UEnHV2qa1BD?=
 =?us-ascii?Q?HTuyEllOipjHSYwySzpgRZDGtpO4rgrmBcH6zCFgu7uIW2XC6MI7hGMwjpJF?=
 =?us-ascii?Q?qiIFUpsU6NqCVTaR/C4SqE7HP3PVWZnjL8LiYnbiSfPuD/KTLMavQQyM7RWZ?=
 =?us-ascii?Q?RHfprp/dBcVBN0urSx9REjbLAsmgsp4xh6C5sE9qa8SUGKD/tCFF+g/gPJcU?=
 =?us-ascii?Q?YUdBoA4C31qoc0oTC8QlZ3+gi7GzTCAE5ASwQQ4zktldefeNYxt+fAbKv3ax?=
 =?us-ascii?Q?5h1VSGbL7FmJah8W2pauz4gGgfP8Uqtp/jAIr7k2GBDjehVwtwMVyjC1grbg?=
 =?us-ascii?Q?U2E60g91Ep2FnKMfbYqnK0iXq39ML7Q=3D?=
X-Exchange-RoutingPolicyChecked: R5tQd/O7BUQ4iCzG8TS4X/DyPGJ+H8oJtKZLy7M4Je2FUw0PLfFKvJxs8DvCIm8OVqXA5p8Tmv6qKAoRnWdUAnW7VAketNQ3Ujqux7jGbb0L5gVrLnxX76v59bre8ieDmHG17+ttiHXmKXem4/F3f/2oW36fpUOWZutPzncuHwrDlUa/OK08k6xEVuryZGn9kEP18t+0VeaEWQGJXoU+cq+ISeXRRURSmXfjN2F6QyXDrNg1J+C8Zt+X2BiL9zuAjWP9iTemt1zAJolm7E98gSQbrKDFxWLyGEkZUvnUznEAHRL/f9ErtMX81ucaGteZeOuTDBpGF5hUYWIsXySJtw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e7f8dd-bb42-4035-b199-08df099c9c8d
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:20:35.7471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +O4YplPu5qH9KPqBVGOog8OKYgjoX3tYrxLBLODkJn9QgUj23b8MXr9x4/EESjo0ygqjc/Q5bHIrXF5wtiLGBcoMvMmRP+KpgvWpzYMAIRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5816
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

On Wed, Aug 05, 2026 at 10:08:56PM -0700, Stephen Hemminger wrote:
> DPDK has its own byte order macros which are preferred
> over the POSIX/libc ones in arpa/inet.h
> This resolves issue where this code was inheriting the
> inclusion of arpa/inet.h from rte_ethdev.h -> rte_eth_ctrl.h.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ethdev/sff_8472.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Ok fix, though I would note that this fix is nothing to do with the removal
of flow director material.

> diff --git a/lib/ethdev/sff_8472.c b/lib/ethdev/sff_8472.c
> index 97f231854c..e29711eb74 100644
> --- a/lib/ethdev/sff_8472.c
> +++ b/lib/ethdev/sff_8472.c
> @@ -5,6 +5,8 @@
>  
>  #include <stdio.h>
>  
> +#include <rte_byteorder.h>
> +
>  #include "sff_common.h"
>  
>  /* Offsets in decimal, for direct comparison with the SFF specs */
> @@ -176,7 +178,7 @@ static float befloattoh(const uint32_t *source)
>  		float dst;
>  	} converter;
>  
> -	converter.src = ntohl(*source);
> +	converter.src = rte_be_to_cpu_32(*source);
>  	return converter.dst;
>  }
>  
