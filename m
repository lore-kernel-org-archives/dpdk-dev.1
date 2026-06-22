Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4D4CDB46B
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 09:49:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F4099402B8;
	Mon, 22 Jun 2026 11:49:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id F296D4003C
 for <dev@dpdk.org>; Mon, 22 Jun 2026 11:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782121787; x=1813657787;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SstUvMb/bs0V5i5134tvifr0G+vJlkPgS9VcZnaz9uE=;
 b=Q25AyZR+qvDHbiUOinsRt0+Bngkn9XbBclPy4n1G7J7GfxSzdtwrfE1y
 0gxl+LQjScQqiWxKN7vxmIkGvvqcHucI7DqU2GybW1nf4kcdrREngWAWi
 YUYl1zt2eXbPeurzmm4W4/7vj1vBUQgw2WA8bnTc+VLKV8WF3UTkN1bwd
 +4tJKLBUbwMm63Xz1/Kp1c38H7O/9jl1LLXPJ7Kk0rqS/ETQZAqD/a+eQ
 8z+AX+EqZ6ooZ4kHejXyZKVwHRdRFrjTHnrH3YKz0cQxLyxdDnVmffp75
 Cux/uX/sk0i0sCCAt+DuZgW5OxN3WD2oDIZnPBNDgHxF8wGgrFXUIyM4E A==;
X-CSE-ConnectionGUID: 9wxF94v2QWGdWzYYLLtyLg==
X-CSE-MsgGUID: 7mDbQp3nThWd2zPOvAZIqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82715766"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="82715766"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 02:49:46 -0700
X-CSE-ConnectionGUID: OG2lrMywRS+zq/1Ya/06eQ==
X-CSE-MsgGUID: H4oJYD7hTZa9qCBVDC+VKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="249285741"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 02:49:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 02:49:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 02:49:45 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 02:49:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjWGdpNg7J0/OTd34ZC1MOUzme9EGm5bOqfP3be8IN7L+k1PaXUxBkJD0wWIOxCI8fBa2qVSe8JPNkT2Zljy6WFVq/2qMt9vBkf4rbeyVjWmXoQxSflBqaAQs1ASoMz6BgkLh+sVIPidcRzVjohCn1ifNLoBwwWefPfwAQK0KNJ2dNt3X0Piizex1SB4hB5ggrJNilDwh09NtLLWVZYdjeRmNcZQpe+NJyQ7hmfv0fsGIFciPfjXW2AL6hKeuGXOr9airLra7wKnvnzFizae6loXkrUjaTfoyjNsiyKP5UNFqLqEYJZD9uDMpkG66cHirR44QYU7XbflQiZtJO4E+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUgifQG5D2Pl69/NRgNuCl2ohMMgRku6mUsi4fMjCGY=;
 b=tEzh21Y+ZE4R9Nd4XbVSh0xIJ34n74OqyaqmkOflU2jAY6/u1bM2nCYBzTY3Uf5FoTn5UsMPLVjIcSFf9c831xrt/hegcCKj2uxs3j7ql0UqwF9iiKSNO5q9fhlLxMU9uMIa8yninm1JO99jYUxuf/f6pSMNvCfv6JDDrVBp7BY0JNFLS4mEWHJ7sZ/+9zzacqI74IQDu3rPIR9wBRoHFe8Ik3HAjNy0Mt2hNAFgZ4B6pjk13wxMb8OfAl7V9DLl3lfsKFiat7pyJqsom8GTfqfAlhEL0qwUh7gRtWIn+ffQIS2h0R0S6BupclhPCYbG9LlBNudWA86RSI4pBE/+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by LV8PR11MB8721.namprd11.prod.outlook.com (2603:10b6:408:203::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 09:49:41 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 09:49:41 +0000
Date: Mon, 22 Jun 2026 10:49:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <longli@microsoft.com>, <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v2 01/10] bus: fix reference to plug callback
Message-ID: <ajkFMb3g8TQIWfUK@bricha3-mobl1.ger.corp.intel.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260618152826.490569-1-david.marchand@redhat.com>
 <20260618152826.490569-2-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618152826.490569-2-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0211.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::24) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|LV8PR11MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f5e2f3-39e0-48bf-8acd-08ded0439520
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wE/OGcuMqeNaTFzRnDtb7h0Jo51pWZFTzNLNCwcGdztmyadgfok+fcPWHbAS/aCisEMvXqeJh9UVHyor+FzYaW1U+vs6emesE2sYLOOfHkLqnna6t+MEkXP87pX2C6Wy7VwG2pwAsllTblXpX7BYruHVJ8a07I+pm29Lz/bvOm00kwuh8MWw6LnXLsrZ3kQ5Qc4ngpBIrBtW1fWJxIqds+SOqT2vTk7ZhHNHTNofEDb5U+FHiErp3sSKP8MS4AxK39YvuqkMIwY6uCtFK75CgPQP/0/bHbRikVAxATDXoeJLbSbG+4eVh9LtsAm298gAYW3DWwO9582TL3ybzuMQuFLViMG0FHrAuiHoNsGDodCFjhAE3uhL9X1LSgsZr4Xgb/d7S7oBGOhZU+Km5seWuvaY9S0ZMRx+lb7con/b/sWAZJ5AkudOSwlChnk4QCKN53Vi0871EIoqN8phGrnMPXs6Wj1q1uN17nxWqUlLaA5ZQhvWwXXpcxKBMhcHOsbwg1YMEhrV4jYbBI8v41EL59iwa9irPCQ9EvOVWJRQCdI2p5mDrbhYWpwEE4sdrW7EgmUnkaPV+IIN2YTZoGtvmpWXb+Amx0tgpgQWv7QYS5saXxj00x5XyeXhGxc/TRgoY5hOWKYcwSlo7CVUrQZoiRuWGerj3l2RnxGsdoPMY9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RWb2g5wf50jRbgc45Nbg2Y4yqRPe6UYINL14F5RtsvBrrHGvnFH+BwzoByyK?=
 =?us-ascii?Q?1dkp3UROr3FR5LWftCvSITNwk0YP5VYwW759Lrp7pgqDUutxJo/17Szg2Dws?=
 =?us-ascii?Q?hUgrwFoPtLkNSxUsAQuDb7IEMspez/v3vCtzTFjga06/hWcdUavc8dfhPZw5?=
 =?us-ascii?Q?3ORji4xbbtkLEnJnAazuxBEVJkxJmT9p+j1KRIgx7i8mdgS3XWJcjAXndr0h?=
 =?us-ascii?Q?wSXs7lEGaHp8bBXdG8w7+bU9gfUuZd3IhybcdQFpQLBrsG/XJhP1HyWVwryC?=
 =?us-ascii?Q?a56wHQZ75UDB8Zqe8VkpDHRCCVmH3t23csJe8sGlzss45AgIgOdEAKplDD27?=
 =?us-ascii?Q?wr+vIMVNReUsXJIx8G6J7QhgBM+ys7XYy5UC10E3n9K39MkSzqdvph6b5hum?=
 =?us-ascii?Q?Ci4fPYNpxnHIHOAnpI9n2R4ZFjQ7e+PIHLnNmWfuH4ISLPNhmlOAGXPitDzq?=
 =?us-ascii?Q?i/oseQACCKRSzf2wbdY9m5SfAlDbHX5/km4U96KArneuk06eQTZdQbITM5QI?=
 =?us-ascii?Q?LpeS/x9FNk/t+lGY8Xt3KLzu7U4Z8RbEmHJWZcxntAGF8RncP7xuCfX6bzoV?=
 =?us-ascii?Q?SLzvdnrMYoue034FTBEm8hVhmy5yIEn0FE28dGzvdQC/h5twcL+QnsX+ORYI?=
 =?us-ascii?Q?RmT0xmXOIWwQdyh6YHWSyFQSAisVwh0rwen0oeGijS2LoanXt3YFBqcYtH7l?=
 =?us-ascii?Q?+HBv9hdV0oqlFq7TNB0bFy+5Rw1pTRa1MlBrPOuGKAqPgoG06RZYXajMs2lv?=
 =?us-ascii?Q?h+IszpvOQ9TdI0VogLtjBzFMQMe9rLs39FtxprILo3fOTc4slT5EgZD0dOfK?=
 =?us-ascii?Q?4feOgWvA6Ch3doQImHqV7whFfdX80+q9tKQs+tTVdwBjHv/QDgqeSfeIRayp?=
 =?us-ascii?Q?Fxsvlvsy+34SBz8IZbPs+c2JLgGyIQqJvsfTdPEXJfuEGDK8V9q24SsH7Qfg?=
 =?us-ascii?Q?STcFj5Nn3T+/PzhULktdq4WDlTHeiWyKCVIQV+eRaIXqDK3tA+WjnIAqeVQD?=
 =?us-ascii?Q?UO99H1pJYmqx4qwem+9wwa/tT+3A0/o2wqZVKXyqvXcoBLOlebAbwVfUYUN9?=
 =?us-ascii?Q?vQkSBqQ4tuu1reCTn8rrr15hicH6afTRrZJQIXKLIwI/tXGP2eaGQSnE/DYw?=
 =?us-ascii?Q?QC8vQndGLEM5bv+Px68eKiLD57f8ze/QLlcpZHHXxt8kXtFHcDvU0AGuP5rq?=
 =?us-ascii?Q?5e0VhgQhaloddkJjp4sXrGmAuAk+nP5PfsSqjmMmtVpAiZ14mc/A8gQT8xiN?=
 =?us-ascii?Q?fxJFP5pZyYe/wXeEHhFZwAK8+mXgOI5/NtTGHaCpxbyZstXDfc0wrEyVs8r0?=
 =?us-ascii?Q?QdDdRQGkBOKYGfI2ICaSZ1ARcS7+gNvH0N3ESwMF6HXX2jwBzdwyAEx0aHks?=
 =?us-ascii?Q?Zfk6banGi4ftSD4ppaaQM6QCV1Zbn9G8QMsito1dKSrhosvDd4im+tOL5LXG?=
 =?us-ascii?Q?UKE+T4CkfiTIVjYixmk241YiFvpYiTe+SJjmUcOkwH66RX8AE4+Wr2dPBhPx?=
 =?us-ascii?Q?Ev++9owNZVvJ35xeUtK6wc7SgtD9k1FnMxKSYG+gvidO6AExMEZ8ZTJr8ebO?=
 =?us-ascii?Q?CYrvcghFBncXzhokjnQYE59i+Nfrkyt242uDGJNFSHC9SsDRLMPa1uTVj5MN?=
 =?us-ascii?Q?EEw5YGXN6Lg9VMNcgU1WOgH5kBEDAB9clazh0kqI9P2OWJzI7GET7r8rqfd4?=
 =?us-ascii?Q?Iy3TK1fmiX/jv719r1hqDhsAEvxdZ1E8R+fd2Mtm+58nb7UdQ8a6ufrSNcrY?=
 =?us-ascii?Q?T4baBzBV7rZxRCZjG4n5ym0FZFkhV/w=3D?=
X-Exchange-RoutingPolicyChecked: DY/nb47u7ruxgztDKuNrWtV7JGPBuX0Fw0o1lqD97iqfR9ojaHAyGNpNnHP/M18KCmtb7cbYtiiW92urJ2bb58K5ukqC7NNMPkK8QeFBx3F41oI3Jir96uC3DzA9P7gzPlG9FSEhMyaJv/XuQsXbkf/7+9ik6BQgYDjXh2JZKqbkbb0npQ+orkVS2oP48WqcQ110AGQe8qUZC8+u2i6hvqzv8zXV3ot/+rbyR+rk7v32+zgiWqlu2N/8dtDudJ7Q5OBnPJjXX1s6rWopNCKh7HqU938i5ISssgrmkTfXlO//djHM/5nZZZAxWlLq5jBtHMQNRllZdngLh48ozzADeg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f5e2f3-39e0-48bf-8acd-08ded0439520
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 09:49:41.7786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbWwpzO5HQ1y+I9nnU5qap+qmxDAHpp++xzyvDnVw1uryxP0668sbgn6g01t/w+j7iKCJ0LlW+jejrwuusATrBHc1+ArtHqyxJgmq7sWuCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8721
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

On Thu, Jun 18, 2026 at 05:28:16PM +0200, David Marchand wrote:
> Remove now unused typedef, update documentation
> and some log following the callback rename.
> 
> Fixes: 76622feba9e6 ("bus: refactor device probe")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v1:
> - remove missed rte_bus_plug_t typedef,
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
