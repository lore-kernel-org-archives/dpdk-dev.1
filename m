Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC63C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 08:04:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CCD940275;
	Mon, 17 Aug 2026 10:04:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1EB5B4021F
 for <dev@dpdk.org>; Mon, 17 Aug 2026 10:03:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786953838; x=1818489838;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IE6fwVkktd6NRJjyIUUmbFNQwQfMTFqeTSdTqdroVvY=;
 b=TI1HnU3g0OX7Ly/ZJWUSBZKf9N1JzJBbHxFk1VxeYssjvI8y+zoiCncL
 +VEcfPXH3k8TLGedX77R6/KQi2yIDc1RAc4cjTzmUWkMVND6jKXEqPzlm
 WJIa2/0IbLINUjOIKJBzJpoTsT+cnzx7NGqMk4VFJKuYf4NbgP9HnPFJT
 uhghWAOL8WQqEO/8bfGXul3Hjk+KpMGymPr+cS+1zI0Seqx3jaUxj9dW9
 Ed39tpyBrQKqT4XAKFKhyjf1hd0aMyDsvGYNIoRisaBwGD0lQHpzWW6p5
 uWPm6OwqjyIqHYhr87fEtvfE/wo/Hi4R9MjCMTacI2EzXjJXEwtjYobOJ A==;
X-CSE-ConnectionGUID: Q9ZARLn0Q5K0KQMviCJibg==
X-CSE-MsgGUID: /4m4kb9jTXuuQIenGUgKiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98938915"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="98938915"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 01:01:33 -0700
X-CSE-ConnectionGUID: GX8HyX53RRGihdXtvoOJag==
X-CSE-MsgGUID: stU5RIILQ4ydtCiWBb0XXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="263078025"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 01:01:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 01:01:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 01:01:32 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.35)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 01:01:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3xdP3lUhV8nxnoK3rTSQD6/zmxi2ppeRqCTxaEeakd3CPVF7yIiiGQ8ojap0IqEhpV598pqdVh0a9BrkD5fnMxDFFASiD+FgqF7qqg/7otgOQ1qRI/6TRkcznmPnkeaoyyCxwO8S9Nh3Vm1q07uRiu903PBlmi9lb5DxQoV8S/Nl/UDdRumedUUMVEhEkvDeniw+sDlsCX1CG2T6y+diyRxGK7QNUi6D44b96BqY3o4JJkvXrNTIK32InymiLedC6/0dk22SOR1dpAALz0R0tegQZUr/9jZAdEwLwtPVzjVVRR44X2Ox71mcsPUUGcYUEs+qVdb9ZOHMXdCytP7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp/GEAscXwAlmIx2YFvcT46Hd9Wt+9tekiYlgddzRf8=;
 b=UQ6so3Z93tExrle6PEHjVAG4OWtbznUvABovTCSEDAJ4YaluHh/iTBiVSH27VxVIJCcjnFbIa6veWfSqUs7Hmw4yO/2pOu3TVX5Clge/DOv62JPCFyYQ1v+f7gJSu05Qi/j6DIdFFtK1yi5WbAMrLLHtaeBifW87C6PCJmGyJ7Xg34g+BZlj0KKaQC8cgyxbG56tnPFX+geIJT3IHDzNg4oyj9acJEzR2MkVj92La+bw9SmYMnyZXfEF+kkSIku1K6T/81nMuTyO2lDt6+gDbCqX1Ptfcr8/SUkytMqeRW0aYHoo8qUoGrz/SWGk3T9IoP8biMqL6tugauvbwBofGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CO1PR11MB4913.namprd11.prod.outlook.com (2603:10b6:303:9f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 08:01:29 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 08:01:29 +0000
Date: Mon, 17 Aug 2026 09:01:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 07/16] net/ixgbe: remove queue stats mapping
Message-ID: <aoK_1dEiDDIoHR5i@bricha3-mobl1.ger.corp.intel.com>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260814194757.329424-1-stephen@networkplumber.org>
 <20260814194757.329424-8-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260814194757.329424-8-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0089.eurprd04.prod.outlook.com
 (2603:10a6:10:232::34) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CO1PR11MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: f736d1ba-fac9-4b6d-e80b-08defc35be9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: l0Mpp+cWIZEtKGgrylpIZaJH667ARdLpG8svN2TBhabjgvfq8SGRMgaI98odyzc2ia7P75L5PpDU4ybuwYM/hRcqzZnX/13nTTjeNMr5f14f5OlGXPQLdWTMSAoODPDfv9pqOiqPeMJZT86EDY48juJNQ+NKBjmZqMFg6gdhQzYEMOCRzcoGpyuOqDfTocR8n/pEE8NZHeDJ4z4ch6BoYtcPOpjLSuL61O2Mt7IvEDNBQz2tOZRcGIl5P8UeJGZ5By7yrQSacKlsfXw12DqAaqjWBB96QPI85XQmOD5zjO7T9aMZw8Y9vXpDYFLNOL80dJ4WwsGyZ9kJliy4aAiYcVCF7eoaT+m/z7mEoDTLNTIEn/D8TQKunk/aveVe4/Otp4ES//qC5cClKaW5/MWSRGWsUGKNg3s7n2bjWDHYk+dEMgViS/IpA8ERFMcPmWpcmjlPUi87hPwMIZY3KiOp2y9D0N0cXRtsW1oVLzm8eUIzru2RXOK02TGO8ZK7i7ZdbTR4f3CWeKGlZBh/hkcy4KkKC7yBzlqiN3vHb7RK7S5CMXgUSuf/2ZG+X2u365/qpCTpZBJkL1BTYI4CdipSD7bgd/dwyGzTRqDsJ22OW2DXAyv3l5c4mve2thTcLTgk3DzO+K7r0XfeIacGa/a72iZllG+lXXdBTRxukGMLUFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qw0KjIkyAzmm3CQNlF32L44M1VOLM9PP+94rRL4s5+lsd8/blKq7kskc1FKU?=
 =?us-ascii?Q?+I3/BDqdFZNfwCtmJw5MlnwvxjvcWp3V4Vi+Kw3HMHd8mAJy8A7UyEXSWbDy?=
 =?us-ascii?Q?rFVLHq4+BiKj5CZ2JwP540IyD/xK1CTYodQR8SP2ZLiaasp3CA4+sSjh6KKV?=
 =?us-ascii?Q?8cF+ZMeIueIXS8ChhbLkDTsf4CXGezURQH8iujGC3QMlqooyZSrI/HloctTA?=
 =?us-ascii?Q?wAUL3cXNl0I/NRsFyHxkE4JVNyvp+QdiqFDhhKG3otSURdbfYUCvo2saCYgM?=
 =?us-ascii?Q?diyKFIRGG04IKUpT2AgPeWOe/HJm05smeJtSBuJ4r6EBZf8C+y2TsUsgsw8q?=
 =?us-ascii?Q?xfsDQYt1pJ5A4iJ6I+Io1dkOXMAeYncncWqRxPrLA6PXW8uu4+erD7jaGxWd?=
 =?us-ascii?Q?8M87OHBWijG47Zdopg2cGiZqQPkgXpFpQ236E9yxi0K7tACopaU1imjEh39U?=
 =?us-ascii?Q?9MMfHLVgQ/qpagWiyOXWxDFxZd2eF9lpYL1Cq0oK7T2p3t7fuEMa6ACqkc66?=
 =?us-ascii?Q?hCS96F20MVakP21EIBk00SqpUABlG0D7u+ja07LF5wx05kOh66IBEqllei7y?=
 =?us-ascii?Q?eTC6NcsV4S1nHYv+heWSaCdrlKOpLZ7Km3UNvDKSiDLAKH3pUT3XFRO/nClc?=
 =?us-ascii?Q?bL9QkGhg57yHPrsxUyeq6SC3GQY2U5zc8CJMwEoNW/RmO4YUYI3D/QAUR3P5?=
 =?us-ascii?Q?fbkkqIaK9nMfsNzN2Qdu9q6kQxjcu+rBUwjm9tWqB6Ssby3EYV1I64T6lA/J?=
 =?us-ascii?Q?O3L1BEF2FmX6+TGIkDfWyWBmwsp+5YRG+VN/QELfhFys99wIBmcM6o6vTTkd?=
 =?us-ascii?Q?aHYLBmzn+uN2jBaQ96lbaOfxSlnABnR/z6VGuvXIjr816/HYCGiyOiIXOYim?=
 =?us-ascii?Q?s9Dt2itkRL0EUzmtQNqmOKIVipO3nBp+R/VqdBKsfs/Dz5X8s2Uy8GOYfadz?=
 =?us-ascii?Q?u8soeOLYI4FSj+LaoYI31BMWd8CA4XC52iz9PcDfogVfDorlvnX1OyMSpknw?=
 =?us-ascii?Q?G5ymCz2HYzOunOjW5UvxGj3Nhtlhh/l9PP3V+9oy2GH1LuzVK1Yg13qb1+xu?=
 =?us-ascii?Q?pTAOSa9GVXE3IwK83GlbH0MvVdC60cT/BoMdYyXDTla4tC9276Drcm5ebVPO?=
 =?us-ascii?Q?HBjoSKWfNK2sbPWcu//E5RzhbzFMXMl5Cxph5yPGHKhlQWYkFDlfK/1pUVE7?=
 =?us-ascii?Q?Xydob2SUK4XqXzlbPjt5icP/pmAsFGl3imdVPUF6AEaMnGnt6dkjPIPMOntH?=
 =?us-ascii?Q?m1UGaUmy+oN1aPvgq0gWXLm1B63jwXQ/tc/VvvUJuw3VI4Kd3AzmKHY/NL9f?=
 =?us-ascii?Q?GTKA1Pu72ysFwAbXtlsPxlQ6V8zHe5h1WDtYTSfSoSJVotcebSrHbf2AmroJ?=
 =?us-ascii?Q?ME2aV5DpLJge76tMTwIn8xUDQy6av6hLRguH6fXCfwAFcL3Ik83oYEvC0BGP?=
 =?us-ascii?Q?GsLrsR+272ffY9zgcdLVm2f+tnAOEzizrE1q/lQKAslcqe1ME6HyDGq+dyqg?=
 =?us-ascii?Q?HaG8mUSZVC2gC9fNNWiysq1q6g3doSKq+eKxLLBWJ9y+E2C8fXY3zB7HUe4I?=
 =?us-ascii?Q?4M2KuZNeAstq5LUwJI+0eMMTpnZOZhs6yQYjPQDQk/hSTCKqHbvRG5DjpmMQ?=
 =?us-ascii?Q?Jz4MPDyVzBrCPmfm3dPIZVUWHDpIeE5cZQKqMb1GGIWF/QergYgmZtl4Hq/7?=
 =?us-ascii?Q?oHoKxPNi+nLQiBT4l3AEWuJ/U3J1LssOG3crNG1EXn3bbXFpzkyLFfbSGWVO?=
 =?us-ascii?Q?ezwExMwWzwt8tB7AxmKBP97Ah9PtQCU=3D?=
X-Exchange-RoutingPolicyChecked: nrhtaNuD2fOLHjbtpgd/Roxo6AlqpXoE7jDJjum7nXF/Th1bHSBXLXIKbXJrzvzTFi7tcBNdH/2vpuumT/sTnswG+2mWZ9f0EdQxfDzS6uPbKVn66mPuxleedl3HrKeoE/bwsfz6+d46hcQTRki4n4Vz9M9UEk5uMjeexkXvixWUN4qhZETOq2dM8gum/BUv9luck/Vu8sSLR/sAZLcPgUbsuZUrtJsrqeA7PL/fQ1ZA6OCRIotCo56GhFVKyuDg38TqX/kI0owPAz/2sMHgZQH56YL0WliFOFoHxqcu0jMxPUkl0LEWEn0dPM3asH9VW8wet5kDW9NKV+1LYqIeYA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f736d1ba-fac9-4b6d-e80b-08defc35be9e
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 08:01:29.5519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXvYZKuTi693VqV/l8fQ8DHCVgEo/pZD2PdiHptJpjF9ndXzRqu/M962+VZo6Naesu4EzXMYkfkY/wkH4mcj5Y7ucHW17aDKBvfNJPogrL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4913
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

On Fri, Aug 14, 2026 at 12:46:03PM -0700, Stephen Hemminger wrote:
> The support for queue_stats_map has been deprecated since 25.11.
> Remove support for queue mapping in ixgbe driver.
> 
> Keep the existing queue stats mapping that happens on device
> initialization.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 98 +-------------------------
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h |  9 ---
>  2 files changed, 2 insertions(+), 105 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
