Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA07C61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 11:01:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA46140616;
	Mon, 31 Aug 2026 13:01:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 913CF4025A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 13:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788174089; x=1819710089;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hc/vKSKa9lFCvz0u/wWnQJqMlMM4+auSet0c5PxI8cQ=;
 b=aYqR0rjqsAwip/QmVQ7ekBWsqMbYSXI1W5n2fmamvFjoVUf9boXRvQKk
 h6Bibco+QCB8lmROTl5hSknT52GcBTIHUhrIFHo47Ffa6uyNusqCy6s1z
 TOjT9vhz6DhG4RAXFRBnkAoK7wOgEOHqCraiHUBNdRIOma1jePh/zqiMf
 fUD8pX89gM10CvC8hdmwj2O5Hvhh9e46KuvgmyaXZVOx7BLqbAk3OCH4e
 LWKCQ2pCeP5cTNRUtu/2GOPV86JLt1Be07RCfoK2rgJWG2GI5oWXLDcI4
 brRSr9i0AbcYdi6jFJkDVlrwetnZOdGkBFWqEHDaxGUITYDa/kNbpv3aY w==;
X-CSE-ConnectionGUID: oa3Pfn3DQcOcsD+01UEm/A==
X-CSE-MsgGUID: bsmrgkEfTYeVH2qsTjibNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88628557"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88628557"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 04:01:28 -0700
X-CSE-ConnectionGUID: qzkolVX2S9yScwsT3KFIKA==
X-CSE-MsgGUID: WDa/pdQ6TiKWYKoizmqGFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="272956432"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 04:01:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 04:01:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 04:01:27 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.65) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 04:01:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtqxvew/lF0GetqB93MTSvCiHqWHaFurSFndUJw13YjOI3xdWbKS2cy2pXqbNR+S2whAtWYnG9krhcz7TRcnQO9px1gjn31OY3bV0cxRM/fzj7506nR8YKyPAyOQ4ifjX2iOt4R/P8aKp5M7Jx5P/rYPvIGf1Gn18I5j2yTk56U21JLcrEynS41qD4si5M16rGncLwtS3FSPK8vAIAMCGWmJKoCl0uk8V5MYFaIAKdTxxdekW0OKe1NqcSOjrrJm0VIhYVvZvQkfyRyH7rnKrIYNemYQtb7o4pQvFHn53xraB4COXNyjB6JHEM46BLiNJQgBnRFvxqeB6AGCfds+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkR01xAGGB6TJYCjxR29bh6fFK3pS5xoVeTzb9B41PA=;
 b=b0nN8ynG5upLA101Y/Sa9UQbOYlwcfa+B2WQ4h87BT7GpJqtDc6iNscJ7QyaM6CkgstbV1bNvHyIZG4cCdaiB1G90AbdV3XKtIiM2EmOkDmbY/+Gc0v9KQiYJjriechNYyD4Xx85XeowpJqQwZb2LUp68eV26huFB+K6qYP+KwDFfRNhp+Ku1HuIHyx7A09QS1LJaBulAW8mo3RqOaO+06qoeaTYK0GOx20en39O9F343FyxFoxIdjutXd0F1wP2CJy9dcEcWu9wPq6etj1BKohyfbmD/AT7Mcn1uWzLFnvirGtDWydIMKPyRofYyAZAeZOQR7o+Gh/XHLr3Tjtk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA3PR11MB487683.namprd11.prod.outlook.com (2603:10b6:806:533::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:01:24 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:01:24 +0000
Date: Mon, 31 Aug 2026 12:01:19 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH 7/7] net/iavf: remove undocumented conditional macros
Message-ID: <apVe_xW0_BoJnEs6@bricha3-mobl1.ger.corp.intel.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260831102621.495759-8-bruce.richardson@intel.com>
 <CAJFAV8zUKSvBfV-tCgeNCrcoCTUw4uVbvs9MYrsbfk-=Mm=yxQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8zUKSvBfV-tCgeNCrcoCTUw4uVbvs9MYrsbfk-=Mm=yxQ@mail.gmail.com>
X-ClientProxiedBy: DB8P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::29) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA3PR11MB487683:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df28780-4b7f-45df-91d1-08df074f3241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: uyBO+dV5FUryINAI3HQMz2Alkm/+v0swBbl+Pajo/ZnLuB9HO5BPATxwf5o7u67EfDvdWjmxSRHkqtSf/0ZaX3xY0EfJrBLT3V6hgYPlvOuyPm8lGz6GhRlLM9e9Y1KpagtHZKxzTjUmiu3Y7P18SnTGvZEg/+6a2UKw99+Q3PrGFuHVnKztG+4M+Q2wfPh0aEZqxW87A6Q5KPtMQx8fAEo1iypZLojDOuoTmVBAdLJidGvaTnrQceN5aNc1oMOgBHjP9/of9Pafok1AvP/HsG1vAoeI32YtFfzeou0bItLbc7qg2gxaQ/yR94b2ejv/3T2w7ZgsxdZac9R3NzpoSzzDlERXCxYzMxPSgglH4S8BbWM+QdnLTE6mvoxhzNldXmvgqvjWgwj8bR7+v4QYtIIBE7+lm1UkGD+DQr2q2D6k7KVj/23ZdJ89MxA1r376ydcjgfgHyfLalpRU8ZBJBKBKmW0LwU+ZnqGaz2A2Y2+ZmnPPqv16K2CpqryXfdJorbVEYrqVyyRsu7McPREYcOp5DXoWQlREAphOdma7xbmWU4JdjoJvk12mG2wLXYzF5TJsmVkMkEbfwA/fy5bZzdpogWsZkVcrczgMWT7ezxl6ASBe+hftN1NF5inVU/7HngQMDwmRvM3Wtdjo0iw7zAMtlMNuf7++pebXH+bQ/4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9kswuac+5rJx9o0DvawkmgmsEpN/WLLwAzjBZnkNQVyNMt4uSRTNhg3CcsXu?=
 =?us-ascii?Q?q4hslmifpsIswKtc1kEq+eUIT1Tjp1Ncr/e9qvjPkyGWio9bQspKTCvQ19U1?=
 =?us-ascii?Q?DqHS2etNNd12nvNoOX3Hr5CNsjxLaCUEPouUlKuef0L74/J40XO5HWs0SaNl?=
 =?us-ascii?Q?FcXHsoRMddrye8Zm2J29mjLBulSjdV/JW14pIVC3xGwQ454iKI9MjN4tN89p?=
 =?us-ascii?Q?WVQ5GpT18eW7W9dXCj16K2Js0RlXva8+K95W6jXV0qxWLBzL6K7RuVnx+uuk?=
 =?us-ascii?Q?LH8L77Gl6C667v48VUQ1IbGiBnmPATrnuyzLZMZ0QKWnW9xPly4A0Kd408pK?=
 =?us-ascii?Q?vyu2hKu3Yorb8unJX+UqwYDvZMP5Vcqs8JnpKy3pHicY0gZ0VHocoidmhDm1?=
 =?us-ascii?Q?pRMiH3oFQ4+UnBMeisKLjJQYGlqTWJ+JsXYaOOvj2K30TJOGd1piyIvt2J5O?=
 =?us-ascii?Q?D7QsVPKX3cGMhktcWeWChpclH/OYKBWpxiGTz/fbbb3U/QtORIuDXAg24iih?=
 =?us-ascii?Q?T1SUFI3r7h1SOY6eCSkTfR0ELvii/BZiTuV6RpGfUma7Oc++tuJ2rHPcqSrP?=
 =?us-ascii?Q?zlvaY6ymjVtvyDButIuowrn8pZvRMCjfZb7/hhUvsloqs9PuMg5chaz38WYf?=
 =?us-ascii?Q?MBdQVEU0ncAISZcYYDUlxzJtb8Mnlderf4jXjQNnn036iTQ3x18cwBKh70nQ?=
 =?us-ascii?Q?1x+g4Dod0HxD/pV6WzwkTL9yjCbJ5cs7pNEMORTUtOO2lcbDpe8tj8m2dLgX?=
 =?us-ascii?Q?4SqmyY3OKvWpEGJAVLXyQhxnI+nRGV9oqPr/z+C1gVPOZDtFeinqpan7P+iC?=
 =?us-ascii?Q?jUvIXcDMhEGxrWNv6/3WnBmS1vLFPQbGAJVwtsFc8xSNaapgere7ugI5mP3Q?=
 =?us-ascii?Q?lcv/6MiAXPheGNxHdIp0Dc4MdF019KFvJe4+wwRVcx/IF7Y7qf3QKTDRKFRC?=
 =?us-ascii?Q?03fWXEYkwnxpH1dhjCPLFcLIN/yuZSmu+FrrvW8LU2GH6DpbXcJ5SkTRKQ4I?=
 =?us-ascii?Q?cm2/X0oaXMa35DVg9D+7s61lo256d0AtmAhT83P/J+oLABaCcXe/lRS9b37B?=
 =?us-ascii?Q?R/lcWGk2DR4IlM8OX84Cx56VFEfS7JLtZSVfHK91iWTS/MrLfP/njBjleTba?=
 =?us-ascii?Q?gTVC+3JpCQWfjGCyeux7gzo79X8VjLDexcQIm0jGjuMSfD5NFiI1dw2yaqHZ?=
 =?us-ascii?Q?jDe0+9QVsuEPCZ7Y6tis426UrkmQTT9KNMbUzkKw0mSh4IjxgsQQ1wOp2/4z?=
 =?us-ascii?Q?2M7nzi6uQ/6zdCOwgHeF7cQqkLd2FvG0WeG5m050DlDfj2y6UfplzlSgl/3Y?=
 =?us-ascii?Q?Rl+9aPj6Lc9V7AwP0QrUpZsl2d+aYqMo0R9k/w3DfOZ3Xy6qNaDLIae2w3s3?=
 =?us-ascii?Q?Ehy+J85FPjMrFPNDYoeJ9GlGka3houBxhbWEZ71HUX1Vbo9LodbSGB3GDYNY?=
 =?us-ascii?Q?Ol/azDLKxsyroYoYLIiYyujlHxlCdfJX3Owk2A1rKKJAbMWUIoHJ+9dU64/W?=
 =?us-ascii?Q?FwZz2l04MycgRg3+6QKODPtaIkr9A04RI9arRCiPfzichKI8Rqf3CPRVAXvk?=
 =?us-ascii?Q?SdRXA/qGnFLlDSg3UQN5YvmuYxmhspVFGpoQqDFisWazlcL8gZ3maEjlFKQ0?=
 =?us-ascii?Q?I0eoX5CFoKdguhARiG4JdV/Blm0WQlIYqSW5eQLgJv7ShZUd7tRAHoMJQVST?=
 =?us-ascii?Q?sx/zZ0mPUXbZtMsU1nTrCrFZu8uAPwkfVYRoTml7oo2pOYr1CCO+g/y8pYie?=
 =?us-ascii?Q?sE9EBr8ls38ISF6UXFtVEY7Zo7RLK4g=3D?=
X-Exchange-RoutingPolicyChecked: 1fOmwcVySx9vyTYB6bdXu4wx3MWHWWrC/5EZ8uzztJB8YVpn6JdnjeU9HDlungBu90ystG2dl169HGV51QGvuUFtQ00XS/MPLppTghHK0inQ4l238PdF+jcNPN8YPKrcb7AfoThXXX2r8jbbGWXch4HsEZE5LLKZWdfePt8Pu2dbh70OojbIlUEhzQe4x23hgflpnwQw7tiCpCPgSDPZIskzOa8P7T2brpNm8OX9R7192Kdqk7W4noGxVwKM8deg3eg3KZlFDExnWfIzg69fBBjSVsusUf4zgxeaTHXA/Jfzz/vUE2KQW+wDujgRHwmrM+Gmo5MsC4trwIII6SZokA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df28780-4b7f-45df-91d1-08df074f3241
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:01:23.9135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkJ/Cebx/g6Kg19IPmgvyfJg8SpaegWYv5SZplauvojhgRRWxwq1YdgVEBAh5vKYD7IrAEbaLcnzZx1FFNjxzOY7nrHk3CtYl4chF3kzpvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB487683
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

On Mon, Aug 31, 2026 at 12:58:32PM +0200, David Marchand wrote:
> On Mon, 31 Aug 2026 at 12:27, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The iavf driver included two #defines which enabled the QinQ and
> > checksum offload in the code. The intent as documented in code comments
> > was that any user not taking advantage of these features could remove
> > the #defines to cut out some code. However, this was never actually
> > publicly documented, and the use of these defines was never tested in
> > any builds, making them fragile - if not already broken. Therefore, just
> > remove these build time macros.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Though unrelated to current series, were the AVX512 knobs tested?
> 
> #define IAVF_RX_CSUM_OFFLOAD
> #define IAVF_RX_VLAN_OFFLOAD
> #define IAVF_RX_RSS_OFFLOAD
> #define IAVF_RX_PTYPE_OFFLOAD
> #define IAVF_RX_FDIR_OFFLOAD
> #define IAVF_RX_TS_OFFLOAD
> 
I don't know, I didn't look at those. I came across the other two when
looking at the Tx side (mainly AVX2)

/Bruce
