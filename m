Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119AD41D64
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 15:57:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1DFD406FF;
	Thu, 11 Dec 2025 16:57:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id F081540151;
 Thu, 11 Dec 2025 16:57:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765468644; x=1797004644;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uof8YCEolZjW6mzOh295tnvdSSwgyFNcFwJZHjPSmZk=;
 b=fcUzvcGf8Ivs7Yy1O48Bx0oeK1gRqWLxVtf8324/O8+W+nCIUjt3vY05
 Y0rDqLbhK9xbl1o35qnEb0OTM+4O+X6WLd0iAfSlEc0cU64JqaRH3pcAk
 p7DTd0zJpaCDNKiKD4LcVr8GOxjnjD/neGDzJk3NKwM5Y0kWs3urUmh0N
 ycYOE2lNCDgQj/RCAX+pQAWevQ7KPHb5Jx80Ee9cBCJQ3Uvhfop/Vv5FF
 zg3TnTzRpUfe2o3BG6GWmrf/LPfUtBJlgBWCB52+UX5k/YqVJBTxBA/rK
 Uye4YB85INKS1GStHJHD9K7LVAVs9MlGTTDlHYZyYDR4sdDtOqTXQAJn8 g==;
X-CSE-ConnectionGUID: URmece3iSKmLcD9ooB5zQg==
X-CSE-MsgGUID: oW0e/xLRSz+JrvMB58eaEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="78916904"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="78916904"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 07:57:19 -0800
X-CSE-ConnectionGUID: CLa+Cx5vRYGVuux6cImMAg==
X-CSE-MsgGUID: n0PYXVm0Qy+XcrvvLI3nnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="201301278"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 07:57:19 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 07:57:17 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 07:57:17 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 07:57:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xz/YSP64W3zpJaWpZh/rQqHS6mwxyZMqgK/+dZ7DSI6aKyTMf680Ce35NNOo7wwcawsi/SrlCDO4DQ9KxmuWRw+M04MkbqotGkyYC54GgBM9l20zBmomqrhPa4SNTZjM4R6oxxpBb/VTzKoo2pPf9X8uw8bHYK9c/sFa77F78QAv0Y9gwsJSode63aIYxFXm2Fvvu+POOq8piuW3+gQmebODpJN0VSNAPE1uWjUw/xM06VIAIgtWg0E+uismdgGF305UYVQDwsWneW6B+lFZ0jrFKn02kdUF0XfMh+hj6v9ZvJ7SumMK7P67tLMI4i4Sw6FSIMQg2KNJcizhegaUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2u7OWRhJi7BUGSTLJpN0JxjKPWp7dKghYsEcMoEfswA=;
 b=u7sAtMYqSVUHKMTLo405m4xNUsEk8FY85Jk8oFQeRw8CJtqRlSJMEOPuuZW0dEHQEupRT8jcCOHbHH3dvUFNgz2KuFHJ3GS7F6Yuofph8LxJkkcie7PlSPB3/Ky094GbMUyyDEJ0vwdY51JSfWfHCYx/d6F3YANCra6bx57oCmwnnpjJaGOXsYZBADAUquZbUZ9IUovDi4OML/4UzoJ/Zx+vJnE8bmdI31qnhFraW2xJXnObyJaxuuBk/fWaRYPByxnTMq2XLByom9t0WnO8Bb30ZOufKSJxlxUxirFjo6nxoUuLixPWCDUKVaGJJG9Vv3KJ7z4POBTGlwCsB1SSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6324.namprd11.prod.outlook.com (2603:10b6:208:388::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 15:57:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 15:57:13 +0000
Date: Thu, 11 Dec 2025 15:57:08 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
CC: David Zage <david.zage@intel.com>, Soumyadeep Hore
 <soumyadeep.hore@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v1 1/1] net/e1000: fix igc launch time calculation
Message-ID: <aTrp1PXZ5ZSD-fWL@bricha3-mobl1.ger.corp.intel.com>
References: <20251204020947.867012-1-yoong.siang.song@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204020947.867012-1-yoong.siang.song@intel.com>
X-ClientProxiedBy: DB3PR08CA0009.eurprd08.prod.outlook.com (2603:10a6:8::22)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: efbb8087-261d-4f2c-8b96-08de38cdf330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lXRDsuv2qNzhlvJE97RgLnmZfSm7/3W1VS8YcFb2IZQt/zjNm5haUWwAdzfh?=
 =?us-ascii?Q?FSL9U+RUKtKx5xTf3gESiruZjF+g0A8BObvfHFP/MtobKKh47w3xapFmyM5r?=
 =?us-ascii?Q?IdJ0ZEu/PjBZPl0ZE7P3n/w66zO8Wn96kc+Q+UrEvgwJxOYrn8DN8r+aYnv/?=
 =?us-ascii?Q?jg95eDeZIqB1fRhW3xSxq8l5+jBc17mtDdncV3j7969Go/N8CMtjNuBBa2Kj?=
 =?us-ascii?Q?iebMnKkQY/YZZ15kfrisOeqFpOvp0r5sYrsWbvvBYSbvmtFX/qUxTzY31SI5?=
 =?us-ascii?Q?c41YVbQ8z5achozWrHMTpzWrMI3SyeamT5AGiwBFSTiOaoRbvZ7qHT/QzNe/?=
 =?us-ascii?Q?ZA/CjpULjtvRNNqCkrZNzRWC/R9PY1QRBX7ICr4RXajpWK2UdbFV1JvoVLGf?=
 =?us-ascii?Q?q6kzXyJdk4AIdGzrQib9ybCedzY+uIjjWy8YoLo8WjxoheeuFp2ro8Iw07MP?=
 =?us-ascii?Q?4WUiJF+g1Irgt0nyB7ULszwAAtyqo6axxTvs3ryjWTu0tsLGNW2vpS5Sy0ID?=
 =?us-ascii?Q?IjzsJ4PVcwFC+I9nzXr9VQtKrg+eFGqAge6yS1u16fcvskkBR98IO0Sx9WJW?=
 =?us-ascii?Q?bXKzJ7DfVMYJso1dJRmXilrVMNNTDleCAwlQWSlAC232aLsfV8NpN2KdyQcw?=
 =?us-ascii?Q?8ARJWEqzmegwURjGe0NZMhYhj2Zrs9G18SIjtLzfeHUgzn4vv093fLFTLj3q?=
 =?us-ascii?Q?6xMrIGr1wuLYx0V1VhnghKZZwpVxqR/9wWduBBrW00JLKWjopzVhs5N/YXr6?=
 =?us-ascii?Q?CWWfvO1a5HhveLukdDKmRy7YwWjOSTD91UqhnQXsw0lrob+LTMU0pD6mBa9u?=
 =?us-ascii?Q?X1Rc/tSrCeKoPuiAGj9sXfoZ0e1z0scRrM6rrtdgbZCsqkCqvzGFMtNor5ip?=
 =?us-ascii?Q?y4226XrnPzGz1Gu67IBVd88bn6j5q/bh36P0RcKotxmuHj+Mo2iyIgjgaon6?=
 =?us-ascii?Q?T9IjRnVq8fpjNj+polVLBgCaMS4WKKAZwFGTpSe3I8S9+KBimkNd5x9xB0iJ?=
 =?us-ascii?Q?KAZB+fgFOk9Mr0X5i+Fn4cl5WfHFpS3XTyehlpAdlBoTcIGQ7SFP57c5xbx3?=
 =?us-ascii?Q?H1eYuxhSY2eIVCwRzoaBH+55kOCD1wqLUTxpD38clfcznpkgVjea7Y4IYXaU?=
 =?us-ascii?Q?+zrwe1GlWPgyZvC5BOtP7JDZYgqc5xkh0kjty9fxuuVqOtttZTBxuVXLlOVA?=
 =?us-ascii?Q?YDIgmvshOQZaurFU2zlHoKZ5yddRAcMx3phGJuLRpoPABlhFt6evouCkB0Jz?=
 =?us-ascii?Q?VDAWOH397RFXhvYRPSI2Nh2adnbqf6RMfN+N5LA+o9uyWl3c+XlNhxLAcjsB?=
 =?us-ascii?Q?NyUjGurXc15lFY4txO5GJdI6yEbd5P0wFfYvH6UEcUiHDyme8wG04W4fp9+1?=
 =?us-ascii?Q?ShwbpTkf+mb3DMWauCG8WXE4CJ12YBNsUTqTr685gB/M5odNxyhMmGRu8B22?=
 =?us-ascii?Q?fhfB8+6UQk2z9K/PB6+lRVBYBCyl53vA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UX1ymX2lZqqhLEVD31Dcr5lGtQxkrPkZ8Opm8IWq1/Ug7kkI4M0TyR2KdeF5?=
 =?us-ascii?Q?TZkiFUkxesgFUik8EDvaC/FDPlZHsWzH0ueuGQwIU1FbsWGTJqdXJXCH+IqR?=
 =?us-ascii?Q?iNrBmsr7rL+dTV3UMG0nTAfWOUxFa/yGtkEtg+DfuDl0WZmMpfh7Mb6sb7HD?=
 =?us-ascii?Q?l6+2O+7dUbHmGltwNJjiHttvOB5bJo54LQTCRi2vquZDyeaY+N2LbrEDb+Nm?=
 =?us-ascii?Q?ctwJ+peNoyC5i8ItQ9KZxhZCp6GbtqClK1NGTCj6iFmxMd5UXe5KsZC5COWo?=
 =?us-ascii?Q?sWdS7op5JuqM77raG4Xv57Uw1LYnZpbYdKlOuaHcVeoZFtHzhKY19LyGA0o2?=
 =?us-ascii?Q?wEySVIducU5pPwy46Z+zmPS6KWk7+Q7rOIAZWEWCsVJyt9Ein69U/PATKPx5?=
 =?us-ascii?Q?HTy0rloxJLPWEeMuupqpYTErKBJSHk59Q8b+cUUMuzJV4QyWO2EA+voVfqLQ?=
 =?us-ascii?Q?v6/mqhr+tffqe6KpSgJSbmqsqKpEics/mxlpaa9ITihu+HFjUBWvrat6qN3M?=
 =?us-ascii?Q?jxaMZ9WPancRLi73iysyQGCfRGzLgf56jyFlY/vHLr6VIElUH4LQObI3LyEL?=
 =?us-ascii?Q?Afn7sXZ16IWoWmOAX1EJZLD9g8fWWPq/6QQ4i+Ys7Ql7TB8ntj8dqzpiZ9gr?=
 =?us-ascii?Q?zEnTNb+uyE7M9PvyfSNd7lKiwEZVa3+bNiXpMuAMCbN+mD8CCDYapMdWnaGc?=
 =?us-ascii?Q?W4yGAy13vnL6Qr2jAZurhA8zt9Ho5Rl3len/Px7+r++oD7TXscmRa1tgSlWE?=
 =?us-ascii?Q?E6CqHGUtMjSBSmkvdNZnbp/oTXvKJXB0bKhOwH/MW+PKzsZzbl8mAozKY5Pe?=
 =?us-ascii?Q?tJ/Ll0BmosFFdKRvvJMNQnC2R7S+T+4fJLCSymHmioJDYlNVeRiyOA9NBaJ6?=
 =?us-ascii?Q?+b4cxMdLK8DqpPfdOcS8pCKQJkwf1U2pc/diXNKRKu2G6XuuEeEDkA1XjKai?=
 =?us-ascii?Q?9hqx+IEU02n8v4kbqAYd9LWR1m6MIIuxJurtucriwCY1d4HVYde9QgrVMLdy?=
 =?us-ascii?Q?rJ2kbhY8686QiqcHrFSpbEbhR8YXmD3uqy0UTdYZdaAjVs0q21mDVImCTIiM?=
 =?us-ascii?Q?EmhUJrZEdhqo8xqQ29atfG9ihZ2rd2cuFyO0LBul7cxdFwB78WgslE+2Lsly?=
 =?us-ascii?Q?ret1Z5xJpuJpWPuoIQ5AUvTNfKdNgBlXc8/Q/icPUSQTscBTCrE7rR25Faje?=
 =?us-ascii?Q?AzNKFGLR2H+vB4cX9nxGBCE5hLtRz5rQs0acDmqAWxIFf+oFIcqTQhhf9WD6?=
 =?us-ascii?Q?PhAyZ14OqnnEDgkomI2K/NAMssbr3PIE9e1ALQX/zryibE7/eG4v4ZmzQ/Z+?=
 =?us-ascii?Q?oRjHHJ8bX8dq1D2Hfhhq/AnarzuQUVmqNpVISSwkFAWFUetruC3R/HHQGG4N?=
 =?us-ascii?Q?MsZr556RxrZqYW1jw8/6INlhFuz/3CPxRqDQotKpB4WtbTQUkCJl+6dnp4Z/?=
 =?us-ascii?Q?aO1Cuikf/rYmKnhz/sKAlwewhkpZRQ8ozhG4jyZKmfOHcI4mFIypN2mEzyRI?=
 =?us-ascii?Q?0k6urpi0iBUj9loMVd/zJ970xD1mJeG7OtShMHQCrRHXur+pGXTpFrzilhdk?=
 =?us-ascii?Q?13eqiwHG/fn7jMp2UWtscORch8lYhUT+bz9Ss8Dmt/2qhFpq+8Iu4Yh/4W1w?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efbb8087-261d-4f2c-8b96-08de38cdf330
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 15:57:13.6359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7CgCOnzi9VZ+KFBISvXlXk+x+xUGB1Qoy9tU8gdr765WEqWQWQgwXcIMNWsIcG4Gu0/u9Hl7DYdv7gAGGBY2lubFsUhNQXUjd7usFgisYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6324
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

On Thu, Dec 04, 2025 at 10:09:47AM +0800, Song Yoong Siang wrote:
> Improve the launch time calculation logic to handle different scenarios:
>  - Set launch time to 0 if txtime has expired.
>  - Set launch time to 0 if txtime exceeds the horizon (beyond the end of
>    the next Qbv cycle).
>  - Mark the first flag in the context descriptor when the packet is the
>    first one scheduled in the next Qbv cycle.
>  - Create a dummy packet to dirty the current cycle before sending
>    packets intended for the next Qbv cycle.
> 
> Testing was performed on two Intel ADL-S platforms with i226 NICs
> connected back-to-back. A DPDK sample application is created to send 10
> UDP packets with 20,000 nanosecond intervals and their txtime is set to
> the time of the next Qbv cycle. Meanwhile, the tcpdump command below is
> used on the link partner to capture the delta of Rx hardware timestamp
> of the 10 packets:
> 
> tcpdump -ttt -ni enp1s0 --time-stamp-precision=nano -j adapter_unsynced
> 
> Without this patch, packets are transmitted immediately as the hardware
> interprets their launch time as expired, resulting in 8,384 nanosecond
> intervals (wire speed for 1024-byte packets at 1Gbps), as shown in
> tcpdump log below:
> 
>   00:00:00.000000000 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> 
> With this patch, packets are properly held until the next Qbv cycle and
> transmitted at the intended 20,000 nanosecond intervals, demonstrating
> correct launch time behavior, as shown in tcpdump log below:
> 
>   00:00:00.000000000  [|llc]
>   00:00:00.000862592 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000019993 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000020000 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000020010 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000019997 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000020000 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000020003 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000019990 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000020000 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000020000 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> 
> Fixes: 9630f7c71ecd ("net/igc: enable launch time offloading")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Zage <david.zage@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce

