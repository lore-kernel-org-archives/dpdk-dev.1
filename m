Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B155BCE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 11:57:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5BAA40262;
	Mon, 17 Nov 2025 12:57:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 1C85C4025A
 for <dev@dpdk.org>; Mon, 17 Nov 2025 12:57:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763380643; x=1794916643;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=baVifir3a4nsHR4NVz+8Qzy0dTZ97mmdsXX8JM1ff+s=;
 b=FYkmcfA0WNl2nuz1UoYPsYSsxGy1+L54rJCqlFMENNvCqTIOX4Vl8hJj
 4nrNXkLs3ybPRd9y2ITnIZhahcekBFbEevHaT1i9ScJbx/Mf5S4O5guTm
 jLLBEiq2ETHLAjpnGTaGAzIKP1EIp8hWu5e05RbYSt8AMn9R7PoMhLIR0
 pXtn8LjUOM5NJC9s5HcW7HHX3z6wMstJKEk4hYHwFGqmMnCn7hXDhPdij
 Devpy9jI8dzslyagQGwIdfMqLziS7sf2KwgWaitdcAhYfJR7apyWCXZow
 4moGTTdu0nzZJZxKH9z/BLhESmcmMoR5Mx9KiUyGBCrrsfBfIn4pgbAUH g==;
X-CSE-ConnectionGUID: OU3HqGquTv23slSlIbyLfw==
X-CSE-MsgGUID: ndjTUp9pQ0OIad7GdhXvHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="83003440"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="83003440"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 03:57:22 -0800
X-CSE-ConnectionGUID: 5qZvCn4USG68SrLX9/c2gw==
X-CSE-MsgGUID: Dq09CywZSq6MOCP0h5RW/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="190229534"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 03:57:22 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 03:57:21 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 03:57:21 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 03:57:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isekyiSKwFjjcJ3CM5MnuzWgMngRcAKbX/1w0wjuumU3xyskCfrQkgDlquuX4TcOJInEvJ6QwsKIQmPsXmUi7rB9RHE5hNmJyupO3RELEYeRFdewjWGFJyrF1OWZVRqvSPr9Fkch9yJD9p6eVT1L+k1F61aoDGVbxS9oLzYLsg5UZEpfcN5Y3eXOC40vax85fqx+TW/7+pMwJk2ruHbUtbUdhLaVqKnw0Ue18iQuogkdp91jccCSk3neYz3RZJ6iv1f+1lufsIBlUlBpwLAJxV9uvIlJwSqXE/QPojoVgWn+MXw+TZbjjYUxlt7Mng4iLorDB2f3JS7fBDEhCcvlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2TKt0hOMu+6QNfCBsuquJ4MJGUhEFERRq1Zl0Oq6TM=;
 b=ijxaKTfGfnD9ZoquKFvJIITkG6z1IXv0ujDCst9Zkk+eD/GQX7Ned6dhpskMjcJqewm6U9fBIjS6UomNQPGf3eivwhEtV53J6DZsNYy374ZRp8daBCboA3D9naAg9ecZuQ1uwfLC2x5ORVfj2t93BHXvgw4AXrvAiqve/G5bZf7TlXz6yomF0/PC8hA2pXgRes07jmq4ET3fHRiLEbN4PFnnhA7MifaUkAgFDFoBbtYXDl2r/rsUz9wlxGum5ed5O4Pj892LvVJFCjVw+GDyUWvd196KirPVWxItVA7CKfKoOyzOfYz2KJ3kBqR1E7/gcC8ot4CftKWf1EimW1KW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6992.namprd11.prod.outlook.com (2603:10b6:806:2b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:57:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 11:57:19 +0000
Date: Mon, 17 Nov 2025 11:57:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Venkatesh Vemula <venkatesh.vemula@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@bricha3-mobl1.ger.corp.intel.com>,
 <shaiq.wani@intel.com>
Subject: Re: [PATCH v1] net/intel: changes to avoid comma operator misuse
 warnings
Message-ID: <aRsNm5xke5DD6JwM@bricha3-mobl1.ger.corp.intel.com>
References: <20251106082354.1534181-1-venkatesh.vemula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106082354.1534181-1-venkatesh.vemula@intel.com>
X-ClientProxiedBy: DUZPR01CA0270.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f531e1e-82a2-41fe-c547-08de25d0760e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e5CZj2I77qvT7QR/RQi5hvsFPyd/7JEoWONJSBdChGDPVIjUgBIAGiv6e3c/?=
 =?us-ascii?Q?Cd4FwB6GFa+ue1OwWYiktntlFaUbiHMrxot5cZm5FGGH3g+T9KqrqtzSA1E1?=
 =?us-ascii?Q?YYVitYhqYY8jhepesOMmpSbyemsIjovOOxFz6GGoTcD82tiiDQp0iz0SNrfH?=
 =?us-ascii?Q?oC0iraiA+H49M4+vnu3pV6PJ06ooT4FpkY2OoTumRClR3nGK8rCv2AcZzpai?=
 =?us-ascii?Q?WrpgXO7oxmcJ+gjUn+ZYa6koXmo2f+S+Ggj3DIZ/kX5W/4sTsG8z4osVxZxs?=
 =?us-ascii?Q?PPH7EaNRK23EqsVRQJKYi7hKEgmWqfOzbJE1MOijco5zp5fNccOobdsO5Usu?=
 =?us-ascii?Q?IJ8J9Umlvyj+0DfV50LmA65QfY3UxnzDWpK/NdgP0MaBC8xclkwm2Vb8/NxJ?=
 =?us-ascii?Q?yG44Upi1G0KqFBoN3su7vnIhtdQt2gWjjC5t9uIejwdi8ynN4TmD7IiSzg+t?=
 =?us-ascii?Q?tw+AqtI/SApMgZiVGGckc4n0bU0+2soNtPNn3eHSmfrASRq6TTusOlrNLap5?=
 =?us-ascii?Q?tqNjWpkQILXewLN5xSTyNrHG9lfl363IizijR0zJfc5DFCP9Hiq7VU7edxba?=
 =?us-ascii?Q?ZN+D+bSXpv+og4YlfRpmuCaDCbZ06WoYouqWnvZQneHIwYoULq3N7DbBNQ18?=
 =?us-ascii?Q?4MLB4swVVGLr4H0DLx/JoAvIYhBJ1jO2J40ltFv1SV9haPHGjSHcoYWtXdSI?=
 =?us-ascii?Q?e+XpIUfMpsBF1OmBiA/jcNKtHsOkmN80jWecn2c02n92lVSFZlUfkuwDgMsA?=
 =?us-ascii?Q?Aa02bAkY5Hw/xOYUYZlNHNsGf3MsO59ZIAUV6NLQk6ixfuwYPjGy5DoF8fvy?=
 =?us-ascii?Q?oJDK/olKf1LKJXOum8GT0EAdCj8P+DNI57hJJe4RF2mxDnp0SpPEVc2uS5df?=
 =?us-ascii?Q?chAUoFQ9QfpwmZUxB94DntWVBF6AILMMs25EQnQLViPX8Q5izlM0BEbQr2Jy?=
 =?us-ascii?Q?3g1LAIV2bHB1M1/mxouveD7S2/iPvYvtMvclME5cEKWNbyjXvXP9TFymSqwt?=
 =?us-ascii?Q?5YkiVGLQzvuJwq0L6qavvlSgZZEwesWQip8epBksdyCplDdzrleDkjbulpuL?=
 =?us-ascii?Q?xYAMUmCY8aVNtdB8573mP0+4GiLr23ATFeuSF/5PRYVwf0sIBnTjOpFXVyXH?=
 =?us-ascii?Q?eFn5soGopoz49/BjPw2OHqBDYj3yaWZx81AJJ55wwcpB/1Rr4KYRo94cql6t?=
 =?us-ascii?Q?/ip6nq6bRXPa3hY0fvvWm2H+QNggOlVcgnJ6Eo6w1AXYNWX6Mmmqt5aoYw2R?=
 =?us-ascii?Q?YmTpHgjfQr1zqum4v7mm66uChL32eW7vxZZWlwA4wtbW12o4vEg+e1jT3eil?=
 =?us-ascii?Q?GyXPJha8/8B3MQPXlkdjEQqZU4SwvqZjnxVoOMyiMG8fuVuGWcTsAwRZkkzd?=
 =?us-ascii?Q?5kOKr9XV/AgJNys0cJsiHWfv0qZ/cpkmcCd/pb/3b9pEnoZGTuOiLWXA6umd?=
 =?us-ascii?Q?rFM1qb4/W/8woFDzqrLZ2PzA3xHVnbri?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KOs9LwG+SSUXnxnYGKQXXC3Su/Urf7ar6fevjj8L6Fb5FNoRQ6n1bQDkntvP?=
 =?us-ascii?Q?mKDbB+yJ2DF0SE1Xkzj68NiJ+SAlAdNFbJ9uIjw/VCh00R1kuZaCcKMYg4UR?=
 =?us-ascii?Q?B3tgjRZVVzFKJ/LuCee+1vXtbnlySwHLxvxCdsbgvqfDRtmeTvO0zTX9l0LG?=
 =?us-ascii?Q?4rVhAhNIqVUlpkWeUA0T75cKMAyq6DEZUd/gEZHwdLQ0TtNI/4V/qNzbSLFF?=
 =?us-ascii?Q?YZxF78lCO0/yvwFb4pGCE3IBFJhNkIqnk2tW8WSWFtAeYmvsYqfCYMWDiest?=
 =?us-ascii?Q?Y3s7jQsR5Xkdnbkph6bYaH+XycBlYRFRKaNl1Qbo0qtMRrEobI7OLCskWwdx?=
 =?us-ascii?Q?UMvsbXqE5srRvPQ9X9+yPuvdzunSNERZ93ZFqoGJl1rzMf3br8c1/cTY+5Q7?=
 =?us-ascii?Q?fyca+ZQrrZTFXXLOu49Lmdx77RGjOOSeeH6UujV1nD/y18f5o4Yq4gzY+Wn8?=
 =?us-ascii?Q?hvKhXMvyK+ZbJGHmUiOtXqzANAaJoyk9/j52O1YI0+qJqDrVCB1T8jGZZDE9?=
 =?us-ascii?Q?U49D5/JxsoYklq2+VfmNfm5UGmxnEb+nPG/MjNA+6p1XtD2jlEEZdPsH03vj?=
 =?us-ascii?Q?0Et+vRIdnC17c43zNBOC4ZBa04BtVDL6mYaRdclqq7hfp0Uc/xqNC7sxZLj7?=
 =?us-ascii?Q?lq/QDRLfTmbVJZfZtDtcDmbYSnpRmr995qt2ZnXwEBT8tjhSfuC/1LmuEPUx?=
 =?us-ascii?Q?OSMljWqEojxM1OqcHwakH3rYzqVegcDNFrvtlFtVLEAPOvcUcIebwx5FmKfc?=
 =?us-ascii?Q?e8pHJel+0MvnbgEBj/cCCCRYtdvNUcigUIBbAdQkX0RzMgYGF+UoJI5VWkIz?=
 =?us-ascii?Q?JG7j95n0Wdel6uy+nn0yBP7avO9UhzMBj3X5QL5c6SPgCkGyb0roH6ah2wAk?=
 =?us-ascii?Q?HAUqQ9iK3AqNEo+TtZ1cN6te3SbJkI7F7YAdS2cX0VgPelW2hahMoImCdDp8?=
 =?us-ascii?Q?disNdNOzMi+1mjphbCPKxSBWRj1GdxzflSLGBvpdiZhc98w4a0fcruBLKIeK?=
 =?us-ascii?Q?5Sv9lzsu6ef9awb2/1d8hvuavpIX6iBFR8gB/TowC1qe6fAIWZNZX++8dWqu?=
 =?us-ascii?Q?6WDwUvJ+xqNSUi6NBPef5DgLD8lp6gYbOZYed3gDfT96Qb5y/hAC6UyxwstA?=
 =?us-ascii?Q?2Rzg2WUKykrL+DL9ecqYIZjkDgKQ2OpyQ6a+Cxo8VW8aFL8sEv+RmlAnYrRu?=
 =?us-ascii?Q?k19HxEmbKh5qOKWwiuYwaxMRsW4CQ3U3mJKK8Kf4eh/pNnkEgdC/SjjsNqf4?=
 =?us-ascii?Q?L2YNAFxW2jXQedt+HHcYvq9rYukJq7XzAY+NweqALy1Q04Iu19Cbk0/+udCP?=
 =?us-ascii?Q?oU4ZgXUtiH9NaMl7TeHbVykScTSJuEQuZ5aUaWJakuS+Z1eYPqSk/ts9uj+f?=
 =?us-ascii?Q?s9PiVb+xmzEhqGjn4HXf7vvnOynnk5AEKFv7G9Cp+xhDRqKpdmAFFJ05897c?=
 =?us-ascii?Q?cS4R2zw5UrBJ6Ohsv3TFc5yKsS3I4FWeeVHf/ayvlB1NvIuAV39WQ/+hCoFO?=
 =?us-ascii?Q?OgHVdhe7cEPNSqk/pcLoCn9it80f3U8p5rHICWDszuJp0HaQqL7P7ED/nzPw?=
 =?us-ascii?Q?GiREO8WkvkWlOMWvD4133ATQVnDPjsVU+YDuz0ZB0kNrQIjI240VZ7o9hPxH?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f531e1e-82a2-41fe-c547-08de25d0760e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:57:19.8604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQILpcF/zJ8JiCZCgCOx9J21jn3oeCMlvOiQaKFmHpYxlh8gG8ZMsqcrc//JLabOiSohy8jFWM2bmsKE3RlsYsE6+wPMvZjKFQW/cCbz9GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6992
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

On Thu, Nov 06, 2025 at 01:53:54PM +0530, Venkatesh Vemula wrote:
> fixed comma operator misuse warnings with clang compiler
> for intel PMDs when -Wcomma enabled.
> 
> Bugzilla ID: 1809("net/intel: possible misuse of comma operator")

Alongside a bugzilla id, we would also expect to see a "fixes" line - or in
this case, multiple fixes lines for each fix. We also would expect a Cc to
stable - though these are low priority fixes we should still flag them as
contenders for backporting.

/Bruce

