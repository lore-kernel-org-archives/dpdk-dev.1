Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2622CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 08:59:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBBA8402C8;
	Mon, 10 Nov 2025 09:59:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 85E53400D6
 for <dev@dpdk.org>; Mon, 10 Nov 2025 09:59:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762765156; x=1794301156;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ygIq334YX1bcv5fvyN7FUslnii82zjXHqUAvQZU4s0s=;
 b=Ax0k1wzywSRTQ2BFjLmXVPPDbMaygOQqLi3+DFYZg7C20OwG+4ZTDYjX
 LrdE3CytsX039YiIOjZ1HdLXYxWxwlGdoE3fGYchgzzyzIQw0BTSndkNq
 0g81FIpMloY30b9dJZvTPhKd+uWCLTRF0Iy3CD6skpcmNoKaeNMoknrAO
 kSzcwcMiCnJvqsY5uptdyx4/KkhdHs/TUt2+ErGB0vONwqt5952qeL2Ss
 pFhTKRYt533zV0tprz3KdL5GFnhnMes4z5R+wKw/7MYt+kH6ZiqdT4H/u
 RYwYjF45l5N31nvXTOkLCkQxw/k6uJ3ZG+LyAxukAfoOJHaJQ7BZto+6i Q==;
X-CSE-ConnectionGUID: bCWmh/5JRNCUopt1boCQTg==
X-CSE-MsgGUID: 11tQFGYdTmqnhEF5I3Uxow==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="82208628"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; d="scan'208";a="82208628"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2025 00:59:15 -0800
X-CSE-ConnectionGUID: 8NC7GQmYTlu66Kr/NOuftg==
X-CSE-MsgGUID: pIxoOjY3RVGVFm9OrFj10A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; d="scan'208";a="187873432"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2025 00:59:15 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 00:59:14 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 00:59:14 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 00:59:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Shz5lYT/czMHSVKWeo3ZxxQKal1j8vjbJCrB6E8qfwuujmZjg4CLTZMgs9FhP05I90/QM9bSpR22I95MmrxdipVAvOD4lmNC2Fb32Tflv9TiUbcjf+AiVF9sD+ylOc3s/L9RLKHVd1aUAZ0rn2+kVZ/z8YcYA6xaFJW4SIPginDT1B9QqvGI48nHnfYp6rzN35o19AO7e91ViDJZDmZILKWgwfLbMEd3fMMTP3MvDr3UCnZkzdXQTnKhQRLp2Z0d6z5noT1e90aVWK5kGPRzLE1UbOWBGIZtd6Kf8RCD4DQEOrsjEGB3TaWBWc/jEceBSHqssYlCwe3YGq9VY5S3ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kit0nRF+MhFgD4HJJxGwPYzPIuG9UjSC5OUw6YFMJBY=;
 b=B9RdcLjW0MDMAqzkwm0uj1ldqUm2eie/twPAtv0OwBAKJZz2eEL0Hn8o3oIc1/QP5MpylA/zALySwQ1rdQ5VKVgK+kR7RidHt4q28lwX1m/XRsrn31RlTAX1L1+YAMG4F2Ckw2VRYo40mcb5c3v70Bb+qsAjqfQc797RP9Hd7CUTDW51WCwlfxTLu945QXb5hx1N1vrcmFxK6yVFWY3ezOGTSFFuzsW0dCxRZlSHQYOLt3EamVqPTs09bXIrwG/Mc95d2W5J1kpWLwjojhKsxfw/Oe+tH302woiU9/7bGgy2bXHRsxD3P3BeQ6DpuCDwR7kpk1/wEIbVKaTfWL2cKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7631.namprd11.prod.outlook.com (2603:10b6:8:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 08:58:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 08:58:54 +0000
Date: Mon, 10 Nov 2025 08:58:50 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: fengchengwen <fengchengwen@huawei.com>, <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [RFC PATCH v2 01/33] eal: add more min/max helpers
Message-ID: <aRGpSsZ5bEvL1rfJ@bricha3-mobl1.ger.corp.intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
 <20251107155034.436809-2-bruce.richardson@intel.com>
 <b03c5c49-c1a7-4003-a350-587e0e6b8341@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65545@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65545@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2a2356-183a-459a-0a81-08de20376069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?NUzgVsVq/sy6jav8AsnEdGYfmXK92jFx7VKlCVqfsbvtMPMnKxO7o1My1h?=
 =?iso-8859-1?Q?ZJWRJmxeMDOVTPQRNmR28vpRIOrhaWgSyWvrus8GaNeWVNe+onMM4sWbpD?=
 =?iso-8859-1?Q?EKvJT/DL31Xh+7h3XiWKOu0GRzLCvlc2ShlJvKvbFXJARPm18zNa7mmcam?=
 =?iso-8859-1?Q?bvonsymHzOXpbCzarmZNiIkcXG/+97R//XQ4s8lP6IujNFPKclOh80eJXu?=
 =?iso-8859-1?Q?/MrwEltN+s19llC4YoT5cT2B5bgjtu53eXdKuOH6k3y461K1R2ONFoJa+x?=
 =?iso-8859-1?Q?5XKy+y4c9ujuqqdOWMu2KQ8AW6kDHTdoY1VFYnQk6682KrErYL4ImrM3S3?=
 =?iso-8859-1?Q?jHrleYlR5sCS3BOJwKUIkpk0OGQBAo5eyDoeyaEdVQqCyT6kfOXdbRQkbi?=
 =?iso-8859-1?Q?uhihS2jOsSANr+r7ALn33MMzRzEMs1tFSMiB/VxYwtrk2cA7qH7+r0iXi/?=
 =?iso-8859-1?Q?OXwV9RZ1kIH91KfajOYG+6B01APxZ+P85iRSQfJ9rq3Ij5ECk4k3EDNQYt?=
 =?iso-8859-1?Q?PMDXAxtf1Vor9njELJ/+ld2lSnl11gnn58Sh+snsnvJ737d9/b6c/FOJzr?=
 =?iso-8859-1?Q?v8zGWt8rfsbCc8GdVzpXX3G0ycBUK+NYYZ7+NbravDX9EjMzcCKSxszpo8?=
 =?iso-8859-1?Q?s3BWrHz+4BBtBEk2GbOXMBrHjKvVHWbcKeaYWqYvZI0fDCeDduxbJv+8C9?=
 =?iso-8859-1?Q?9IDi+JVPdDFl3KVuCrGrZELnG9wme0tgB4VCiEabN7/gIrHmCOm6DsFW3+?=
 =?iso-8859-1?Q?dVTZe3GBhdeR4vPD98XvFuLv8z86UkJg0oKuBKsQ4Ozh8o4bELBWxgjNmZ?=
 =?iso-8859-1?Q?o5ZmfdaLB2RMq/y7LNHlQ9sYpaVr7GUNoflOG9r6H8XjafL9ltOnV+mzUv?=
 =?iso-8859-1?Q?YA9hU2A8pBANF7o8N7u8JJF+WndXY/lIs1ntOj1Bf8V/DjPRd1nkG3AkHq?=
 =?iso-8859-1?Q?9gRH5KR5Kfs4/j3oVaaSBsACcYfcSI2cV34/q+LCK9o7uzJHUVqf1FgNT1?=
 =?iso-8859-1?Q?bI2zzy6N85wgJs3rXei79FbF5SYnjFkGNH1fwB+Pqzt1RUmLLCk/sO5VN4?=
 =?iso-8859-1?Q?ja97+xgbEpl0WWGgINPMtvUvBVElMjfucL87gk8zh5I4KPD95cZX93Le9u?=
 =?iso-8859-1?Q?VFMlUcUFrJuPll1bixPLfG5pjoQJUmZgCIxoSXbJzAUnmeMbqNwgSU0tbQ?=
 =?iso-8859-1?Q?KusQNGj6s5HmZyARSw2z9CEs0/RV5DT4+492GU2to2LIOskbIF3qoypd2A?=
 =?iso-8859-1?Q?TW+2UrdtrWokyPie0LJ5L/jv+BDlwwBcaOy+rqj3Q/6BVMyq1JGqfJgVBF?=
 =?iso-8859-1?Q?U8kt8894aEnvWSdG57NpxntbottDMZNtHxz2C/S2yDcBRq+pAsG+hp3C2n?=
 =?iso-8859-1?Q?vRCYuTyLjjaPLGZ6N3Lb6qREYYkvHAyksCsP3GgjBjYY4V79JscyLe/LFk?=
 =?iso-8859-1?Q?5E2UY54ci0pefYmQTGQ50fSe6F99HMbqNc6K46W853yBsXiJHks29FbFDS?=
 =?iso-8859-1?Q?7pX2J2zn5ssbIJ2kfMPJWE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?H/6rOsFbddcDWzCBxTtQ4f+3lGCltz2u4z7ZgwxgvMynXE8vr2jVK5rT/2?=
 =?iso-8859-1?Q?Nu2zS1wBIRPesqV8O+TpvMIiM42HBluUoA8casvWp7zi0kyrkalDvUrBSv?=
 =?iso-8859-1?Q?ZmZb6JJ0GorxDVGMuaUxtvlez5oObmonjbvNIgN8Acvxu9WqRpptUSw72W?=
 =?iso-8859-1?Q?95jPTcXS9p3Edxt55zqLxO/brcK4kfK0pw7cFHeKFlz1co9SxpBgTmbOuD?=
 =?iso-8859-1?Q?Vi44ZCXvhqaokCiDBFtp9lC1poIVgFI7L+YW8jEPvCGr7lT/O+CP9FRLDG?=
 =?iso-8859-1?Q?msDaIqUB8ni8R7iuUWyWsFfJVkEbUHMS/SfFCY9tAMnS4QbYPsfkWP+az5?=
 =?iso-8859-1?Q?T8fo8vOYKfs8XSBZzAUwQjaATWmFmkC7Ixii10UVZuRpH1YG+ylOO5K0oQ?=
 =?iso-8859-1?Q?/kk/u80NmjVSOlAZphQykKFRCu1KUyPCsHQdOMOfKtPBDozXUZyYfj61+z?=
 =?iso-8859-1?Q?LIISjPGpTi80rEGzIvv13W4GAxiOumMxKRfAsrUQwwdJpqRejRgRKWmqBR?=
 =?iso-8859-1?Q?OW+BLgAZrquPpcot41bDnagnEbW5QtQQ4mj4pRvobUgaeSf/k/OFMmg6V2?=
 =?iso-8859-1?Q?vThrP6vFXmWYg9gIWoSPNNXm/tKgP+ylOoB5VGB7xffWfbnMPbRfxEnFgh?=
 =?iso-8859-1?Q?Fdb54M55QBPjsXbIU6CZZv1wGLN1PogORDJHO9poti0RcmQ7+rZlsfHghm?=
 =?iso-8859-1?Q?/q3D1svy786Q46HM4kg1Hcp4sqPlcRjCXz/0q8se8HNsm19z7ht+uS46Oo?=
 =?iso-8859-1?Q?7tbeDfTkrbyZRMhASffBd97eWMG4MraiqI4TX/p4okW6NYoc/XFfYXP0bk?=
 =?iso-8859-1?Q?X3aTB1LDuN39StD3EOx9knBY+f/h+PpNOQiAlbKqQb0lvGJBSnoNzMze4Z?=
 =?iso-8859-1?Q?pmFQx8EQPeQ1O3DzIClO8vL6yxiFU3vV2m3HKSUfPh4WDNPA2myTH0i6r8?=
 =?iso-8859-1?Q?4vEiv+byqpfB42VMMaI8nrhu9dy17J+Yr7IJIRMy72IFt0a22TDkC1Yqn0?=
 =?iso-8859-1?Q?aeTv6ddZbliIj6Ggojd60hby7RGYdiPJAM2mm94ZpbRQTNfp0WqQZEfl6+?=
 =?iso-8859-1?Q?6pDXjezBgTNaGSjOZOft3zKFyMxU1htzL6NAOa3ggibF71t31x/NY6TROo?=
 =?iso-8859-1?Q?7/cvH+W6mTIoMG4QUl/zs4O4DeWo2pxIv/mcpKytohds3oreJ141D/dWox?=
 =?iso-8859-1?Q?58CMQ5x8cP4UlFJJKo5qjDR0RjeFX4MV++yEgTV1NlwsmzQuFrepLXQ4jj?=
 =?iso-8859-1?Q?lMwJsGtRbUJd8wniYtPcpk7re6qACO5fyI07TOWqazDmnQUU61/f//9t2W?=
 =?iso-8859-1?Q?jmlr2A+YtuSJNuFHMJH//Wx6kONULedznUY5THfaazuwmrHuUVuy7lQSdH?=
 =?iso-8859-1?Q?ywkt4Lopn3M+nF6K3c6G+iVnrtB9Qc2CSQcovIjhuGXTdcbMbriB2d4lfm?=
 =?iso-8859-1?Q?hE7Gpp7TGwQsOrBiqpuxxkAcGv1+tSEjT91bbsjmLywBdj9BZWSIY/h/P8?=
 =?iso-8859-1?Q?GHcd+JLI/uSqcv995+6kKIMJPKTpSaSvi4G/kziXOixfWNJwAYdjS/qR3U?=
 =?iso-8859-1?Q?lYk2s8A+uuBumPIOvIbvsRGETpzE0QpuHkWsvSZg/IXS/8RakajyaUoUxI?=
 =?iso-8859-1?Q?IJdq4wCqS+CjVScqMFwBHMO1nBU7Yb0nv3J9PVDswTEevDcAZwYDWN9g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2a2356-183a-459a-0a81-08de20376069
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 08:58:54.8333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByFNtKeOBy9mEcU9v/ZPN979BHBrTI6sNdst22qNzLABMAtf4MLPx7LwAV8TwaYzMIZVzccHygMhE0bm5vpsnNlYC0Qfeb0aIOxQXhvyZmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7631
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

On Mon, Nov 10, 2025 at 09:53:22AM +0100, Morten Brørup wrote:
> > From: fengchengwen [mailto:fengchengwen@huawei.com]
> > 
> > Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> > 
> > On 11/7/2025 11:49 PM, Bruce Richardson wrote:
> > > From: Stephen Hemminger <stephen@networkplumber.org>
> > >
> > > Add RTE_MIN3() to handle case of RTE_MIN(RTE_MIN(...)), and similarly
> > > add RTE_MAX3().
> 
> Do we need RTE_MIN3_T()/RTE_MAX3_T() macros too?
> 
> > > Change name of local temporary variables in RTE_MAX()
> > > to allow for combinations of RTE_MIN(RTE_MAX(...)) without causing
> > > shadow declaration warnings.
> 
> Consider making the local temporary variables in RTE_MIN() more unique too, in case the macro is combined with some other macro also using _a and _b.
> 

Yes, that's possible. If I remember, I'll try and tweak this again if I do
a new version of the set.

> <feature creep>
> Maybe an RTE_MINMAX(min,max,val) would be useful?
> Same about RTE_MINMAX_T(min,max,val,type)?
> </feature creep>
> 

Not sure that is worth doing.

Also, the naming gets weird and confusing, is the "max" parameter the
parameter that would be passed to the MAX macro, i.e. the minimum value, or
the actual maximum value you want to clamp.  Therefore, if we were to have
such an API, I'd avoid min-max in macro name entirely, and call it
"RTE_BOUND" for example.

Again, though, I don't think it's a high priority addition and won't do in
a new version of this set.

> > >
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> With or without suggested additions,
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> 
