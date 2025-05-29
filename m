Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A59C54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 10:02:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E6D340F35;
	Thu, 29 May 2025 12:02:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id A11A54067D
 for <dev@dpdk.org>; Thu, 29 May 2025 12:02:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748512923; x=1780048923;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cVKxiHo3/BVcU6xHT5W4U9DyVz3ZKX0LBTk4POgFDGM=;
 b=C5i+XfXPHSb3Z5/MNOxlWTd/Y6TrYZBFhF0JOc7zM5nQpQG/bpzJq1ON
 JaAS7XWhMiy77yd87bYCRFlikpwTb2O6z+Evx5vbvjxy/oMRlPD39Lnru
 gXAQKAm+h8lX3fgl4TpKDWbHxEhj9aN3ks1b23AHHYO47oiGu0+V90NGI
 5dco0UxP7SXdDic99lupgIEUyXJo+oo2RyiN+il7Umjb57Wnt0V4/J0C1
 eWnuN31fVzWOWMlFvlUbuQIf8QCqxUPL38LfsOG/yeGdCAVmok8e+Wc8F
 Sf4Li8bUTbt9CFPlLr/8EVGbCpHJx5qvBF4R3e/fQaqq2PoSRKT6GouqH A==;
X-CSE-ConnectionGUID: 1w6SK6DbQkCmJir374vnEg==
X-CSE-MsgGUID: LX1Q/PeISKOPBdc9A1eWHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50568391"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; d="scan'208";a="50568391"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 03:01:57 -0700
X-CSE-ConnectionGUID: IepEiUn5TBukQURkMUAIXw==
X-CSE-MsgGUID: of2zQ/8AQEmveVmFSlLpTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; d="scan'208";a="174388974"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 03:01:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 03:01:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 03:01:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.76) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 03:01:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5SSKz0f966pRd05twLp+HN37r+c1CINvWHhMyWR00v3QsECd6taahRWiCjENrZHFj8XIDR8o/yClZ0yXMpNg4+I7psDnN7gWNOeD0wswa9TerlL92CnLRblWBgFeroIAL9bxwqiDj3Zjt6ZElKm3NGLbLVs0Z0iyVtcflvxMOd7v4n26vtrg5pOE8Z5DNwIVmcYC3YoFh2WtC2zbDQfhp9EbUnfGbYnu9Csd1cif94Lg+eogmqQwV1ZlqvGfa0OPDoi9mIuH2BZflHh/RYe0sIKsSJ96rF5glI5hXygaaHbICJnURFofCWO5E8HyHzq9SjoyDnNTjmYng85jW9eRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYNahLg7JzEYB8jclUCo418pe0LQ6KrDvKsrJdXeCXk=;
 b=C0CWsMPVpBRbdkklUAHxOHL9GTmFeCKI4g5vmHXg6Xrtv1GnooBMn5+fQWs8/vShTsGNcBuz5ugOpGFX24CczW101rffB2dML9YnrREY0zLeoSncAQv7N8DLHeE9Q7K494bKEkrZG63M/aCLWCuhq/LlHROjG0CjvizimUesDFFuqv28OgMyNz4Ls2Ho9iwcCGLq3l8A2N+HN1zeiyQPgR+pEu054f5ZwsnZGNx5djGDNad4RLhMM/VC2xIsF3jzch6tMVXbrooX25SrMiuJ25neG9+fDuVsntqpZUEw+X9TROdf0fwGzzoIBD8vHW0I/pfqXDvhuesXNWAd++PY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DS0PR11MB7766.namprd11.prod.outlook.com (2603:10b6:8:138::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 29 May
 2025 10:01:11 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 10:01:11 +0000
Date: Thu, 29 May 2025 11:01:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <Vipin.Varghese@amd.com>
Subject: Re: [PATCH v2] build: reduce use of AVX compiler flags
Message-ID: <aDgwYl7JErROA3Dy@bricha3-mobl1.ger.corp.intel.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250527162716.319713-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250527162716.319713-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2P250CA0013.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::18) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DS0PR11MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c55220-b714-4301-f6be-08dd9e97bd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T6tprbIrgqZchNDmMlP4p1G7egblGdWD/fel6Td8v8s1p91zIFzzEySRqi/G?=
 =?us-ascii?Q?nj0LyJkFof9R/9SHahvHlV1OMQGLaB23hCZowjty0qwgNnrNLciDmdIoHRrI?=
 =?us-ascii?Q?IpHeLM0phzRUm2s5N0a48pg200P2Ul+uMBLeW7oEXtoq2qmoZXg70Yxw3eV7?=
 =?us-ascii?Q?9TKeEsEVl1vSAeiovmTl6qksjobT1EhOH3hE3JqSraTFjaz7JxdqrIu4cYaU?=
 =?us-ascii?Q?V2oltpa/S1z/jPvsFcjKi+H2nZQ09mFk5SJfLT4VIkbNIPihezAuhqSqI1v1?=
 =?us-ascii?Q?Rzf1WdkCNTKMSOS09jetc9OzN41WIqYNEIeOjFaxmfmb5SvELmbGv0rXlTSl?=
 =?us-ascii?Q?hqpYQAocggItEgFh6bLJ44xWsRgdBd5rKBxK8jbOJCjY7Iv6vR4PZLX8MyUc?=
 =?us-ascii?Q?dd75HRGS6vIZ/V+bfbJgh/KZnv4leyRx/qqKXnYCD5q+spiRtVR1NppQ6hfa?=
 =?us-ascii?Q?qA6A+Ye7sDdYbaQSte3a3Dk9tGKVGUy8rhtpjOkMTRYU5ABP9fmCpTkYM7Nc?=
 =?us-ascii?Q?PPxbrnyTm9FK3bZgX0Lg/xUyprmS4udl+SG7oJmEkIfXTPzdyL0oSpklwS1E?=
 =?us-ascii?Q?vH0xgsH7CpWwHNC1EwHjVF7T/6wL4CLszcf5Gfbat3AqJaw/yqTAQPzWb3kE?=
 =?us-ascii?Q?+5cimr7u+Z1AprpJjC6n/oL9zd7JgaKduDsypVIS053O9HA/IUcOgNdt4cp1?=
 =?us-ascii?Q?oOVL/czq3NYzJzmLT+6cROSEGTDVbAKf+2tjtsRI6td7luk8w/BkLhoXvdAx?=
 =?us-ascii?Q?1nkmWVsuwZMAcN0HpeG2Aq2roccMt0ud1Oz0eODfdA4xMYLlStJFRUG3w40L?=
 =?us-ascii?Q?wfBxSBI+kg73LEte/eJm9SHOFEG0ujPaGgtarkYeMxz88QNsaxZgi0rhX0km?=
 =?us-ascii?Q?g+xp57naNR7L/oiFhoZPDO1mNdvPqk4GH8mmeHgX3fCPSV8hArxBXVOwRSVh?=
 =?us-ascii?Q?pisspF+riYAAKoGjx815a4bM3L5CWvUo+eKxUbitD3AGA1D57k9DTaeCsnlC?=
 =?us-ascii?Q?Vo9ULUOlx67/eHXVpPA5o7/zuOiNHPTfF6EkTitNVakvFrfkYY/uhceGIXQX?=
 =?us-ascii?Q?KRHM9rCuDqsQHQ1zNzinvum8hJkstSk3RtMFc7rB+/5V1bkBkXBPETK7ydLq?=
 =?us-ascii?Q?b1S3vkRxhHrISXPZbw57QA2quvU1GYZ0mIeae1j4fdsuAG0mfo1Hxa4/R2PG?=
 =?us-ascii?Q?+BD+uVcqeIDU1m7xDzioHxqsk1vBD1u7IBkL50hupouWpZ5UqFBwhikR5piy?=
 =?us-ascii?Q?vmpJAxlDRWsAfuSey5U+u5YzKG+EbyIxmMb7jT41Hlr5TcnLZVs0FUdeF5vA?=
 =?us-ascii?Q?KdCkxcLAv5uJ9qJNl9L3ASj3HN3KERGaXPA/z6b3gBNfZtj9Y8WqnfnYhvEh?=
 =?us-ascii?Q?/l5PDY2s+ZzB8cpOhO6JhBnsYeP2j7mh6tNMiMJ5qn5FQrKn+KBXkYEs0y5n?=
 =?us-ascii?Q?OMxXZTiGYmE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?07mMjdpn5LcmEUcGrs5UoXBGxSXIfOa5v7y31WK1Iv9aVVQNht+lG+RZg8M4?=
 =?us-ascii?Q?aBH2Duq+IcKUtMLdGpxMBzmA5xODWSfQX0fTwHJ1DlC+UDnmZiq6tM0xNlP/?=
 =?us-ascii?Q?4Ut5r7yTggB1SZgzqlFhCha1JiYFof+N/ZM1Nyd+x5ziN0q4l8b4vlhIxZZC?=
 =?us-ascii?Q?bkVYa5+dZ+uD7CIDQwLFSNISQLpxsebVsrGtOUGcdnZRRK9ORkey2x2lbAVO?=
 =?us-ascii?Q?gNUp22TuNvjhzGU3nMttJQok01h19YslVwbBqOFeQho3jgJR7q/onIRwDVLq?=
 =?us-ascii?Q?LZl/+ykdnIgQENBmH+OFQj+2l2njkj5N9swHwi4fij8yDw++8AKpl9WGpJH2?=
 =?us-ascii?Q?UUOTqdrA5JKvw83nPAKKSxSKlng033SCxTsF7+BZdpQgk/3oya0THaIKSrlb?=
 =?us-ascii?Q?G7Qf9MO+Gy8tq08wDFzyZZl/GxuKJkjw4u3dZgP086+lAIEcHF3PyfEaHB3P?=
 =?us-ascii?Q?PoZz4v6y3KG0YftftY6fUGUJvsFpCrglOMff2RdaQ2uYFk5TzBPM+LI6GgoA?=
 =?us-ascii?Q?TY893MkpmplmedP/5xScZiXH4ZpYx7EvSie0E2Cb+qVqYa6BZ+wk5vmrocI6?=
 =?us-ascii?Q?e7VuRvpuEQBzhSkTGzBv/Q+1bpfUQckebWahwiyDH8o/fYug6LWa7w5ZhMKp?=
 =?us-ascii?Q?JT8nPPII3/Jt3YgHl6/7jWbkpexkbr1NSTYXIJF166PURk0yVhFLPbPoe2tx?=
 =?us-ascii?Q?ep6F1InLKNhK4g/8A9jO+PfcfxKm7WxkZf5V+LmB7JIXNnHxKWtI6sp8taPL?=
 =?us-ascii?Q?6QqThblZt111cLElo4ce7kbWoiGODPVkCYmtBQgyOqueH439c6xjBOblhSZx?=
 =?us-ascii?Q?jfxpPHYPpC0CpK7U4ZJT+H0rEiEjugpGT/JMS7bw9UlNwTuWBqF2mBWxNytD?=
 =?us-ascii?Q?FQE2JXQbGpeIDiRRSBpQy1Xbtt3muIx6ovPmb9qtu+eA0VZQtLTSAASy0USg?=
 =?us-ascii?Q?ggH3WDPEGlCw3l1KTfoav35wCUWEjJ6CPUzKv+tdL4VOyWKPE5//LwZKA6lV?=
 =?us-ascii?Q?EDtdWrbLwmr+xYVzeZdNq8P7HypoqV6yBM0DrsKZrGNk+IvAoRrc8tkkdrV5?=
 =?us-ascii?Q?JM0uwb4uzHaR73TzH1Wmpvd/LO+Kv7BUwncxLsSfCj0ErrxuykALT0gnoDN3?=
 =?us-ascii?Q?9jm7qw2VoMmvGmm5unV+NaTA5SekyzdI7IrxUXqICmErC/cnZFH8zCKxtJ9B?=
 =?us-ascii?Q?/W96xGCGgRh46NYr086uu3eL4HFDAX34o5ICj2UKHFm33Nm+iYOTUXF1KjPZ?=
 =?us-ascii?Q?cwLPwdFgcRSYpJGHPzMonUaXLyDEsTFv3pE09c69aNqXoKz+YD70cP9OeosN?=
 =?us-ascii?Q?UasDN+6T1qWlmu44ODAFFuUWY/kuAptV38ErVjjh54+RjE8g8bfagvSnn5wZ?=
 =?us-ascii?Q?0UcUfP9jaDzOVhcH6BHdumIhg4VWeurpiG4v6KHbN5b2xdSmD2NmM71N4g34?=
 =?us-ascii?Q?W7UoKnsXt5PXfS71QG6ZoYx4EEujwfoLyON8PG2m3nq3faIwuR4dn0IwTKLz?=
 =?us-ascii?Q?pOOrC5ty7cs5U3GocYasHA2nQZAreAZQg8pXgc2NNSDYXuZ90T2622oApYcR?=
 =?us-ascii?Q?WAm/R8xT1910W/YWBEgPLctlK5poE2R07tgrdtfLQpslrSRESwT6rrsvWl6c?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c55220-b714-4301-f6be-08dd9e97bd7c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 10:01:11.6189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cw8bmL/RonTLYbYqb/Mj1bfsnu0Z6UNdxdocOFW/v0qNVek/m8GEu3C8HYAzNsiL5o0zSEQutE02PJmGtp3f6/9O28H/sgNYlIaCdlfsNMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7766
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

On Tue, May 27, 2025 at 05:24:56PM +0100, Bruce Richardson wrote:
> When doing a build for a target that already has the instruction sets
> for AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or the
> skylake-avx512 '-march' flags, as they are unnecessary. Instead, when
> the default flags produce the desired output, just use them unmodified,
> and don't bother adding in extra enabling flags for AVX2 or AVX-512.
> 
> Depends-on: series-35006 ("doc/linux_gsg: update recommended compiler versions")
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> 
> V2: dropped the doc update for the minimum meson version. Based on
>     discussion, that version bump is larger than proposed in RFC and
>     is now a separate patch/series [series 35006 referenced above]
> 
> ---
>  config/x86/meson.build | 31 ++++++++++++++++++++-----------
>  drivers/meson.build    |  9 +--------
>  lib/meson.build        |  9 +--------
>  3 files changed, 22 insertions(+), 27 deletions(-)
> 

Just to note that the failures reported with Intel CI on this patch are due
to a bug in meson 0.60 release (fixed in 0.60.2[1]) which causes it to give an
error on printing a list value.

/Bruce

[1] https://github.com/mesonbuild/meson/commit/168f9ea312b98c4a079602f40448d15d3cb28cfa
