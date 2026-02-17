Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB4DE6817F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:59:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D661040261;
	Tue, 17 Feb 2026 13:59:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 9DD74400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:59:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771333163; x=1802869163;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ksPUuel+3QsRSuR9oGGaGhx6xWwOP53X8170IiqrNRk=;
 b=NWNv5A2tuvrlvVJiPWgDNx10+dTulR0N78RqTTeEPvX1o58iUaTzqtMJ
 E8PBKaASRu1S6TW9hCEuH3r+MGpbrZNwBBhYkwJsW7xaSFqN6b+lqovZi
 meTv8oGa2zuODSH3C0aeD0CfxdRLEo6CkSv5+Y6MqYI4pdUBq7Feg+76U
 QSpDRoEJPHk0R6z7ZrpJHu3tE1eJq77jykf4xNAGuU8U2SbVNfd5hTnAh
 HZjWZzf4P4+dDy2sOFM66MurBZ9uMDLEQxqBzevv1kVb8nBLs+xr1XKFd
 M5bT36eYYn12iZxRsxFtMrq/mPV03iLcYMfmX4Yo+gFD4qZuM9RDqS//F Q==;
X-CSE-ConnectionGUID: HIcZYqeER8O/2opzB4GsIw==
X-CSE-MsgGUID: EF9Z7a/PTPST96PJD81ogQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72390671"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="72390671"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:59:22 -0800
X-CSE-ConnectionGUID: rBhe4hiqSqyidC1EFxx2QQ==
X-CSE-MsgGUID: WaFdhC0NSneJsotDoqjIrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218880189"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:59:22 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 04:59:21 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 04:59:21 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 04:59:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOLWO/RubsNxFt+KT+Tew3bUbMsHwWB72GRhU+L3hFjkGTqFxamrk+oYcu+9rCT/585TJnL0MCOuP8MqEv5PtLXKDw5TkrQSEuc48mzVdNI4HIN/VnufIO1Nr4cQNJ4JQLdVhk5NtQBik7ZKzSExJ7KQvUlVgbgAuqAlS7yZoRkplli6t3gXzucdcVVVcZx6tdTuZrCm9FexocS17cq1wrUTezqkxEVUhAPpC8EOS/YSpwWmSWT4UhJxvM8FwbR09M2LIU/P9qoYNdLc4VeZeGxZxuhMpHgL87MbbCS2Nix1mMZOxBawKmW8nzJsj540cs8Ezvz77K9S+l8uChJr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPs0jW/B/E2BijWO1MhSj6mHeoRyGVTMzyG3xn0hPRs=;
 b=kxhXiT1pRYCgDPWmKHpmDOK9EYYJ1SwwEQmkBJdk4bDteMwtdwNr7zQZe7RvCZlh81pClbkKE+lIXF2OQBAej0ckNUrlEj3fzxGnex0M/RYkXo/Q4rNZHgaE7ddYZBRIB/2cwu4EUqxyviWYBmhDogQFPY22bMiSzmx00BeYHCj8nqSYB2KqWXDP+ti1MuBoMPgMhYBYs7ZIt3di5ATOwtEy3IWjod9Nsqn9WwE4OlS3j8QJ16pfYKE5yuH2HNdrrYHgUVmgbo1gRsW8uWfqthYf0m5OfFPxvH1dRPWJdEyywd/qF05StS5z2jSYmObmYjkfMy39CB67WVf/LOXp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7167.namprd11.prod.outlook.com (2603:10b6:510:1e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 12:59:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 12:58:59 +0000
Date: Tue, 17 Feb 2026 12:58:53 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 01/27] net/ixgbe: remove MAC type check macros
Message-ID: <aZRmDeO1AUlXE63L@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <f0047b363fea648bf7b6815889c0b26b883f56c5.1770978324.git.anatoly.burakov@intel.com>
 <aZNMy_1oOKYn-AZ2@bricha3-mobl1.ger.corp.intel.com>
 <d4d45144-01ec-4c6f-86d1-1ce65930e06d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d4d45144-01ec-4c6f-86d1-1ce65930e06d@intel.com>
X-ClientProxiedBy: DB9PR06CA0009.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: db9779ca-a222-42a8-1131-08de6e2450b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IW7GsDt2uzrLnDwUC6x4xbaE5RDgXV+9gpnfznd7JU/cdxhLUuQaxF8BZ7ng?=
 =?us-ascii?Q?aQZZSigpBGG3O19E/0vWKNhFVF5B12qQwb9ZguJofeju4ilJfXblFlMNoL8C?=
 =?us-ascii?Q?lxeKtnngGnDpT2Dzk3HvF2k8DMor0bED7l64M2P7kv1DniAmoXTjFnxjdsJx?=
 =?us-ascii?Q?YO52w1ZCEr3KugGediw5sYmgEaZ4x+nAC9XGi56xNeFvmG1Iegnp097pcW0e?=
 =?us-ascii?Q?tHd524V5PvTASP0zPi75yOidTurB7i7aM4RTXn+btcuJFCBtLUHGuodc+1Z4?=
 =?us-ascii?Q?+cXhwF8H6k2GbuCrn5MirTvptcv3n4ulscqy9gy0NsiEyk5QL5qz5KopjabE?=
 =?us-ascii?Q?FSeFNQXnCtK9z/bo8g/bRt1s1OoMLC/hS2BMoWjFlIlZTx0jIOo1l0C713VO?=
 =?us-ascii?Q?/4g6P/F5OHc2k1/Gl5eOzOk3ix37nlwHREPyMVrAP9EupUW2TOzyDYNBkgym?=
 =?us-ascii?Q?q9wQCwmDHjEf9CKOkMh/c5RaJyfCvDPO5wpDuU3/ljKZXuuWbSI8T2rhIzcm?=
 =?us-ascii?Q?ts3NmXJ93zzqjiZeM9PD8tPsOwbgBNBHd6hGFUMM6Wx6j18jun0uyd74gKOR?=
 =?us-ascii?Q?X+Lg37WMgd70tBxFQpa1oG9cEao+vFsYD1mBb27TYrd4RfySbD+ZSdy9ufAn?=
 =?us-ascii?Q?Ao+uHqvNACsdF+R27zW7R+trLSPGljje2gIwjQxYcnWaI+cZicWZhbx8amft?=
 =?us-ascii?Q?N9u4Gip6NSYJqc7CeP5y0WV7Y/CsRwDgVfLkZbjUygdeEgFny/N1dZWQkitC?=
 =?us-ascii?Q?4RbHallu0CU1CaCmzwGVcu+tmaPCrFs2O7V1OIiwddZC1hVrdpDsv4XTyeCS?=
 =?us-ascii?Q?RjxAjlMPtJXkQJJDAJ29/KvbKNiwj9jR7Cmvn9453ZDVPh3kbz2cgnKyOBZl?=
 =?us-ascii?Q?G7zyQzrw+4Lb9TJsrndKZrfddyHorUQCYHf8LVbZutvKDh683SALVxJfNJa/?=
 =?us-ascii?Q?cDWLVu/A6vuFu9S8vGwq7wFnke4eZLzb4ak20EYV/EVp2Z32JGuQ//9V1GlZ?=
 =?us-ascii?Q?9WzRyhebYZhr06l5b8m6ARqa1aWVKKOiF31RELycP1XzOZx6eTv+TNxBOVRj?=
 =?us-ascii?Q?oR3p9LJ3cgbwrvaPTX3N2QMoHPAN9h8NEuvo41JPc7fL3LM3YCFh89VFOcW5?=
 =?us-ascii?Q?4NF9LeGrMd6w5x5vO3D2G7vTBYs5JIFirj8eXwxbVupnYapkaOotLTl7agyu?=
 =?us-ascii?Q?H4RkWAAVC6PC/1taBOcDxx8AyHL68P2FYu+y7NKeAJHO31IvnNtH/Ci13HU2?=
 =?us-ascii?Q?Bmt2kZL8TdXnUvwU4r8W/GesSdAlNDvyhR7xl9SfNBSPxnohYxPa59ItUHrN?=
 =?us-ascii?Q?8D/M7DXwko/mXc1Zd7NwyoV8p0tr43nUe5ZCgRM4clpAfZxuengdcTm69rqH?=
 =?us-ascii?Q?ct4Yh8RSG7jQGypOa6WtJS0N88wa7hD0gJJgnBtkbF63dxJzi8DZ5u6lQkPD?=
 =?us-ascii?Q?Zib7Op+tRgnmqyUSWlrIlL8bvlmRs21yj7YtQRHcGcfCtG+uqXYLBPnAdC7i?=
 =?us-ascii?Q?uTYv4QhHbYKVVO6YuA4UG8aDKzmTBxeKkCUKUKoXJSMSAabPPhKCYy+MgWpF?=
 =?us-ascii?Q?copd29u7BGFSpaIddKs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DIc72ohJSo5lfTZ/sH7IHZrj6masz0KUN534B0QleL08OFfpfKlaVT4dOGUM?=
 =?us-ascii?Q?ajXpynYHzVgqU8YwfJ5FjQHuuJidD0YZyYL/jhT2YA6RpHVTXYi45Zx2bW7g?=
 =?us-ascii?Q?uCYXarJJYLcLO/FkqZ05nS5WKM0H2q4/2KvH1I5vTBs5eNk3NS7/XEtaE8vu?=
 =?us-ascii?Q?cAjMTGfizcj5hEe+Nll1GXvTR2vuW43YfmGItTBqkfv/ZVumNR8j6NtiC1iF?=
 =?us-ascii?Q?i4HR/q0k7iVRQsAKygaW/FOZOGqKRHiCuUS5aLloNJ3nrsY3p+WVGoj5PmcN?=
 =?us-ascii?Q?p/sJt3GuXvRt2TetmcbIhtWJHYSECMHs77WFb4TTnOoGq5Ykx274rpaD3mQH?=
 =?us-ascii?Q?s/hLt7UK79uSoPH3CcoANsoPmlMjYDbCn2yvZOCPruYQ9b6dVgbSPt/3FNEx?=
 =?us-ascii?Q?9cGU7+IHlObLncB4FUvCFO+SFCBmPez7CsF+0XAz3jrsw20oM9lK/gd0Ql42?=
 =?us-ascii?Q?FxIU+TXbM3yOAdqXTX9N4ZMjCLpcT/errTDkpXppBSDDdBJ766v7bA1bwMCg?=
 =?us-ascii?Q?rli5I+j9rJDUoxEHfpwKev6MrlnBmPTOS4vTfoD7+cxW3ZeNtZgkppWPca/P?=
 =?us-ascii?Q?kbX2phsP3t5zPUWt52Lqe+jPw4ISNeEszev2aS99p/1kUL6L5ZnSG1KnPxIN?=
 =?us-ascii?Q?6P5lZcELi2tKgHKHLwgB/MgWUP+bwepJ8rFi3+oa4tUkPdlDypaI2orYUO7o?=
 =?us-ascii?Q?xreDOaBP8cme9kyiRGSIv+8Y889WT/ruTlo0EdPlxDSG+0g0qeyqbMeSBnI2?=
 =?us-ascii?Q?LDHG6TNbIgcs0/Owl4IWrHAZwSJ7cTKTDa7Gqun4vxIIkJe2K/+7vIX3QN05?=
 =?us-ascii?Q?OLc/CfxM7HQDqUBtvUyiHKwFwKJly+ssHhh7pResUNc5MIEK/Dc6ZhzgqCjo?=
 =?us-ascii?Q?9K+OJrg/qGjyJdeR97+JaPYYNlke6Nff1k1MUdlrnmYj0WE70oA55gnMzu03?=
 =?us-ascii?Q?8sMtGpJZ4zBQ6NGVqj1cLxQthWnGXPiwtbSnnyntpkvtmmknjVuQnkwPllv7?=
 =?us-ascii?Q?OTViQcXYoOy7K+Axah3YmXXqBFy+/aZsota5Svl6glF88ylHnuSBm+aTvWKz?=
 =?us-ascii?Q?2uWobVoiBOuzyF2nzHVg+fL7mgpdDFcN53u8m+35T2dJMdzrs4VikKr6ylU5?=
 =?us-ascii?Q?RMu8/rOQFvTewzQeOKE/XwX57G6ofUBDjePG/vKf8j9GUQ/GBIPu1njplD/Q?=
 =?us-ascii?Q?Pz5V5fuUw3jf1KfzjjvbXwDQN+tEnUpUEdtRDXRECaLW3aN0Dzfb3ZoeGu33?=
 =?us-ascii?Q?tjrbl1hzlTXzq5hdLaHF0DBWltDu4q3p7QQa/MX4HT1L+xNkZD4DlGssblL2?=
 =?us-ascii?Q?48vrvySYHEKM6QpHwYkvwhWu96JwP8tfudMXmOEtR8jgGIehRErq9vmzpm8O?=
 =?us-ascii?Q?XfNpnmdX+pXN8bLF77VUw6C/gnDfsCoVNI7AgmGA9VxQRWcjUzVUrKAiJM2Q?=
 =?us-ascii?Q?2nedcVUgDO99DJB6DoiB2zg0u5DCxW/oQx+AlloNqtK7G97phFRFzM0S+Iht?=
 =?us-ascii?Q?AOr+QrUekrG7G/YpR78hSqN36mn0esFl3uMS4dE1WovrmJCJwdHfhDMX3Hjh?=
 =?us-ascii?Q?hyLvg3zxA8joF/Sw93gyUt4w2XI17zKvTp2aPkIhXwuU6yRIbFCxi0o2Ogdg?=
 =?us-ascii?Q?DRJej1cE/IMpP2JHlTqaiy60oex0GXveiutLD+whe/O093wmpDrc8A8OgS/k?=
 =?us-ascii?Q?7DERoLVGXZcYjr4D7ac1m7mG8L1XrtS7Zvs2d9FHjBBa6l7IfH/eOkYlcu39?=
 =?us-ascii?Q?0YYv4GLL1ZgyxmqauDG6hE/0RPIP2a4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db9779ca-a222-42a8-1131-08de6e2450b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 12:58:59.5677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 251vexpd7XoijNALQILTnaBGRj+g0nGyCqh4tAIHDdneHy3AAcEy0WOdidE9mZoPMaBj0X29sUpq8iIRs5g66Ruk65gtAdyjIrlQxeJ/gkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7167
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

On Tue, Feb 17, 2026 at 01:50:36PM +0100, Burakov, Anatoly wrote:
> On 2/16/2026 5:58 PM, Bruce Richardson wrote:
> > On Fri, Feb 13, 2026 at 10:26:12AM +0000, Anatoly Burakov wrote:
> > > The macros used were not informative and did not add any value beyond code
> > > golf, so remove them and make MAC type checks explicit.
> > > 
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > ---
> > >   drivers/net/intel/ixgbe/ixgbe_ethdev.h | 12 ------------
> > >   drivers/net/intel/ixgbe/ixgbe_flow.c   | 20 +++++++++++++++++---
> > >   2 files changed, 17 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> > > index 5dbd659941..7dc02a472b 100644
> > > --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> > > +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> > > @@ -137,18 +137,6 @@
> > >   #define IXGBE_MAX_FDIR_FILTER_NUM       (1024 * 32)
> > >   #define IXGBE_MAX_L2_TN_FILTER_NUM      128
> > > -#define MAC_TYPE_FILTER_SUP_EXT(type)    do {\
> > > -	if ((type) != ixgbe_mac_82599EB && (type) != ixgbe_mac_X540)\
> > > -		return -ENOTSUP;\
> > > -} while (0)
> > > -
> > > -#define MAC_TYPE_FILTER_SUP(type)    do {\
> > > -	if ((type) != ixgbe_mac_82599EB && (type) != ixgbe_mac_X540 &&\
> > > -		(type) != ixgbe_mac_X550 && (type) != ixgbe_mac_X550EM_x &&\
> > > -		(type) != ixgbe_mac_X550EM_a && (type) != ixgbe_mac_E610)\
> > > -		return -ENOTSUP;\
> > > -} while (0)
> > > -
> > 
> > Ack for removing the former. For the latter, since the list is longer and
> > the code is used twice, I'd be tempted to convert to an inline function
> > taking in struct hw and returning type bool. WDYT?
> > 
> 
> I don't want to use a macro/inline function just to save on code, it has to
> have some semantic meaning. Do you have any suggestions on what it is that
> we'd be checking in these cases?
> 
From the title of the macro I assumed it was whether mac filters are
supported or not? However, if that's not really the case and this is an
arbitrary set of MAC types for some particular use case, then yes, agree
that it's best to remove the macro completely and inline.

/Bruce
