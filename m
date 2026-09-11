Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C4C88E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:53:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9EFE40269;
	Fri, 11 Sep 2026 11:53:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 779DF40264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789120399; x=1820656399;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=h4TLR4YX7uJDvOAee7Z/O9tKhiNuNzcfHx2CcTyO0qM=;
 b=Ha1Pfqup+vvGJlR3RqwZY98LMJq+gPEP0evUoXR51Uy2fSDC2mIIBFPP
 xW2IZi8u7BOcXhu5yXQoL1J26KHfZ7uZtapnZH7JvZBP3VEFe+hsRDk22
 5+y+5ZYfbWMLIuuM4AD+BkOj3d9aCSzskVoFibXeVzshXS/JoPCAbYQ10
 cY6JJNfaXiBhOlr2Zzr2KOGqV9mzDccYrblvwQR7zk2OW0RuOc3ESPVZK
 wyi7FmXgZubhSWm7ky6h87LZa19P4EZ14yvUCH0X5MylWEkwZIWNE9KGA
 3MAsseWHp07n4fKr232zipAOv4/vlACXarONU4JHsvgn1DkLBb6ne3Xmk A==;
X-CSE-ConnectionGUID: reLxkqnZQUWIydC69kjJxg==
X-CSE-MsgGUID: KHVfqO2ERI6CZq3Mp9YACg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="99912239"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="99912239"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:53:17 -0700
X-CSE-ConnectionGUID: MxAdo2P3Q5i42k5YNP6P+w==
X-CSE-MsgGUID: x2kU5ManSnKKZ3Z1YfTAmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="168223"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:53:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:53:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 02:53:12 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:53:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqijO167z0zllQA5I9KfaKH9qa9MgqEBk+wqTExgQVImJW2/G3bgk/dvOWKwjXYj5YgI4n1adU8JuSChzBMKWwGcdQzLNe1mdNqJygujln13/OsEZE1tRf+3MIu2DdDbb2VHSGI6G2ON6Ks5z+1fXrI9Mz0NxNbp0+ncPekPt80uLm0EkSViEFy6Ylu/bcplHgyL4OV+AGDqo8kYpsv0dIWI5E51dJ7gYfLHp/h97gfznYqT2PynfWFnH4RTv2jHpVO/E1NnsmxYrCF9fNMRMODUM7m+2LfrkNorZF1enZ7EMCmwQJmnxyoL12JNnyYvJuHbFKlUUEVYHSd/wrmk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzVz1cpltIL8lZ8jpZnqnI/kk0Z3gchXZLqOXyHKSj4=;
 b=F5n0G0L/4O/vdik3pLHhL8mKQRwVdD6UATqc9SXE1ZmIEQV1r8MCb2lbRfYf1mXbeiy4Dy46hAahJbwcGGnyAJv0apoPoBxRcgMYgX4+cwRKgeri0t1atyZng8qJLsexQxKNUv21XVfKjOi8pcYvnF2pAIjFRbdAS+riEWWpdplhMC/OD4YXzdCNZaeuTMVAnVD2d+Wn57lFTu/8S0Ew9/D+SRMwQgzR0rEbNpVVsY3ANfh9sSyaTH8Ag2D6PKmDG7vM9hrI565s/TYbmU/1mqx7vpnue8RcxBeQp2PhMAFSwxAfqngzAbk2hexynsp07kvNHvUOJ8sDFkcbzx/6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB7118.namprd11.prod.outlook.com (2603:10b6:510:216::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:53:10 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 09:53:10 +0000
Date: Fri, 11 Sep 2026 10:53:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 62/68] hash: replace use of rte_memcpy
Message-ID: <aqPPgM1mVdQZ3MUw@bricha3-mobl1.ger.corp.intel.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-63-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-63-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0348.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::7) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c058fa4-6efa-46a0-36dc-08df0fea7cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ALpzEIfWtF4HkBkoNNzRd7aF5UgeWmptSlDLd7cx5x9qEKohKSpB1RGn5lsitL8RqeQlvoEWx/wXGBrSvOUnvyOlIPS5mFOBOdEVZmJ5eDAf4tR7Dc3tZlHwpgKhJyVkCeSvWIe91lfm7WvU1AI+B2KU+FVHgZXSZtGAPSKW3T5+wJCb7n2qmkPwn7R+3GFvG4w5RsEHeIT8s416XdZ+UdAMC0SqHRg6/lYkDgC4M2dAX6bCx6n3EvfDaUXrg9Df7uBk8HVUKYfcHQErRjZ4WABH1bQR3vIzDCiLmdxWAkHhrhJM0W3Vacso10omMTz3iGF1+Tk45TDTfhQuz6ikUimiSxWrFKNlRdpvjcB2H9rjjdlygOiQ1v0nLdDwk6t2fySpxvsQlUZ/KDESEnfgYkLx6/eZungzF8eCj+XDJE3G+oM6o+8SH6iYjFhYhh1Er1cIAxyZCwvci/2DnkVZs7Blwmh0amKSZgguh7ax16MRNCOBtHavUuHQX43GTL+jUqZfUrzBmtgH0EkDZi2y7tCzt09pouQEVw5fzA9eELpjDGMlZAUB7EqMTdqnvbgdkIyMz+0XHPnicq4fOBR2GePVbnCkfiviA6rPlJvfUhDnU+IfqYZdECGYAqOAYMRLzzpub9OFrzgk9FKUxDwJ7dLTQwnYnxCsu1++Rgy3Ujc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3GMv0yDO5a+ncjtH+F2XUqp9HfNUUFqOIsRagbl/9Mdmk1zxG3iPjAJcGBw9?=
 =?us-ascii?Q?tg7s9zKE9ri0CwBM1VHXPGpEP605KYGqb2s3uZWsi5d2Bb2DKErqueAUE9XM?=
 =?us-ascii?Q?vuLSITZ6TttL1hdh4bxLxpfw6lZRKNZjNj4Vf4imoeOs6DjU9XHyqcb8lxKG?=
 =?us-ascii?Q?BoT7P6YthGtbSyrPK+NVDzfikJtUyXDwhx4CIN595ZbQfcNjQKsyZodRWa9b?=
 =?us-ascii?Q?uHN0tdYb1lg6fjXkdVzXwWLic5bTTS+07SaqqhzJU66yR6MuMP5OKSk4vlxd?=
 =?us-ascii?Q?M3dBPae7M1w1y0JsX+hYZ6HhFrNpVUwAzvZ20pNUFbR9IPsFv2HyEbnp8aBo?=
 =?us-ascii?Q?rtrZS9UvLJoVSieUGe0JVtHcV+ATXSKBrtykHR/YQGzXb5N4HNbPZdmmGKAP?=
 =?us-ascii?Q?ayOrXe65+NhIFcqIEmqUR5LZKzx2VEEiPW4fYafuYzeWgSnxiOzpAYQzU2Dx?=
 =?us-ascii?Q?9jxS+s0k397+S3xkjTXKQ2Mwv/aJ9SAK4vYuoB5m7oghpE5db85MIJss52br?=
 =?us-ascii?Q?X/DrUrtlea2bYWDmD4x+rPc3bmNI5O72RkcbzF/ytSIBi3OS8aZygOx78tec?=
 =?us-ascii?Q?D1Rh+skugzJdikt8kLW1eyizVuI/LYMFiOV1c/83UhooUb940Ou82iQiSVnk?=
 =?us-ascii?Q?bxW/NbG3q+PYNeqbRxckcOlPlx5XdJmAXocA6pdZH2xKkVcgYkoxE9o8vOeE?=
 =?us-ascii?Q?jpYDgrqiRln4HyELREiT3AdQFXHQspccFLUzAYctPt7g8kINnIKXS3+Qd5Dh?=
 =?us-ascii?Q?tzfBImNfs1mXe95wUC3TjqXdehroTMANkcxRN60TIwTOeYWO2BgXId0thKzy?=
 =?us-ascii?Q?52R32+XyMX/vM7T3kyJihIm9afLhVoCAXP4ye/vlBXZG6gvxQVbbsHZUYY9o?=
 =?us-ascii?Q?daSuO17xPNa9Z3OgMnJx5+e8/aGfLqSonoAz5RY5rCFg1WZueasFcIvQV41R?=
 =?us-ascii?Q?Fbog4S7bDaJJVfJlnKyVzfQtStoy0QZy0cWLG2l3B+F890acE8mdvM4F4kM3?=
 =?us-ascii?Q?7t9KePr2bZfQHyHXh4I3JyN8tTb3aKJsvGNdXTP6v2hy+OsRa+dfCxuQeGk7?=
 =?us-ascii?Q?4AhQker9v34O13ZUpvrYmOc4D3KXjNzgdPu4SBHOgZnJTz9wUnQezY0uDC65?=
 =?us-ascii?Q?0Rawjusrq2MLLWy5W2qyQP3vrOZGP2eQHHCtToYVPKk6u815uwLqX9oj2jkJ?=
 =?us-ascii?Q?5ZGYem8jAhbAcjb5K8fSh/hUL9gjVQMiNPF5AoAcymZFWpIaMF4xAtoHMRAV?=
 =?us-ascii?Q?30/B5zE0tlSwQkccIQNRTIcSHlTOXBlKbydd4C1sDAC6PmTY+KbETN+lN84l?=
 =?us-ascii?Q?nAZf69BxCE6NpaqtAd0h0gkqXiwE6bT+YWbyYTUs+TnN/vYVk8oeRjUUzypE?=
 =?us-ascii?Q?qg6qGcWCfKOP/TqMmoI/65ueHBSSldk1S1P+Li20UqGON+XO1KvRfy8w2Xpd?=
 =?us-ascii?Q?59unfdSRNz5AR9Y8tx8OrzIZhncyhTKFLjgiQPzOUoiqni4xAKxIwWvPjXbf?=
 =?us-ascii?Q?MXWvgZhMOjs35cN/7j5TE2ed/FVjLdEI5/hS5c311xxcCQeBkIiz3p6gghEt?=
 =?us-ascii?Q?ydrASuWkpb/72szgjiiYUpCIVAXt6JmkEkHY6qpk0bDhfJlW3OZovw+sjbxl?=
 =?us-ascii?Q?a+JYCjF9jLED4yb23uQtMJBIhaKBeUQXsyyQPGmjritUyNXh+xYifd6l4POr?=
 =?us-ascii?Q?3SSpSIwBNJqMjOG5LeYrx8JbehJvHRwIjCt6r/7hfNSIPljxXRuHlVwcYjEj?=
 =?us-ascii?Q?OYMSxQ+zYsARBYohfDXHIxe/BRcguo8=3D?=
X-Exchange-RoutingPolicyChecked: zi4kyATtdGNjMfhayx04CMMCDURnAmgzLA1vEmi0G6bXyB86YCrJfKmKXU693dr+Xp9i1GRqF6htoHYaAFzaWtab5Bj+sC5c+oMA4PqkXr8wDth7fWm4YYAyKonsCGRpvR/Y761BIzhVhSVUXvf6+actXr98Wcz/zTMFYtx1QNUL7KNkqConUef0Fb3ZmiMr79/sY7YwsND2B3g9Sm8gIIvSdekIEfzoS4FN7DGRUAU/oJXS2MDibQA5fS9zR5Ppn8uFpNOcTV3AEdfeWqyj4OVxDS60Cgq2Smc88ulfnbjN9dn6IDTn3i2UPcOPY2n2G5rtKxHdpWxuNtiUqmF3Eg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c058fa4-6efa-46a0-36dc-08df0fea7cdb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:53:10.4849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6CZY5+dAQen2DfHE/qBy3HVvMt9bYj16gy/csbgHmfEskWpIxuvN9lCtnS2BBdHGJNRlrH0uSgYLAcmQsjiEkiC1dYY/T8+tfKfCrGZIX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7118
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

On Fri, Aug 21, 2026 at 12:24:57PM -0700, Stephen Hemminger wrote:
> Don't need to use rte_memcpy to copy small key value here.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/hash/rte_thash.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
