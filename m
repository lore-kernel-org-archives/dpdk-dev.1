Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21CEFF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 07:56:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E27E740285;
	Thu, 30 Apr 2026 09:56:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3F83E40280;
 Thu, 30 Apr 2026 09:56:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777535774; x=1809071774;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HwFxZNKLfCZIBwGVH6KO9pcHz7qhFmA6Se4GK+HASuM=;
 b=Q9eEbu9tiTT8U0+RKLJ2Z3FjK1+VyPnC/XdZ7RikFrtHCveh9lGkkM5z
 EGJM/TIapGxTLkW4HLlPAd1E4pKE+/+RFpfgmlfkjXHedrAWfLQmIJnb7
 xwnvqoYuA9efnFvZiAZRiJNmqrJwvBfsl4APgOQPPv6OIisp3TMEyUNqh
 LIW0hlM/krBkep3ipswY41najd18v9TLq6+MEqHZRkDg8ohyHEots3oN5
 7+ZyPMUiAtCOy3M4BbqD1gsWCiGAiI8C0N8N2hcit49R40PqQTUHWMTc6
 P9xbPpXaej84RQfu+E+Hg2Kv2mec54EaMGg2VEkZ7kM/N0X2nKWn0oAuW Q==;
X-CSE-ConnectionGUID: ziZl7NAUS9KCN7NtHaMszA==
X-CSE-MsgGUID: se68fD9nQf+gijQ8+KeFqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78467167"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="78467167"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:56:12 -0700
X-CSE-ConnectionGUID: AILY4ms8TtyDVd2lY+DNTQ==
X-CSE-MsgGUID: zsc8kMlFSuiSxePM/zFAkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="231865673"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:56:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 00:56:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 00:56:11 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 00:56:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNTcwrvt39B903bhIvKzncEyHQgwgVeC9VvERXlFaj0GZW5YORhyNoExQpTVGDgJCM4bUOLg8jr4AAVngPoyNpdmXyUCgXZFQLkLfkkaus6xYdLMM9cJzUmiTxcFi1owa7VmWYsNsOBq+fNvkn0JnOC+5gldHU45lfZ8PYibhE/QViIAiMyxzWoCnTkV4U9D9bD8FmBT4OlVZd3gIXCxZgSAp/tU6p3F6NvUUMT+mUD+EXqYtwj0eeAu70Vs1S0MoMR4GqjaBLJpG7L8W2v6dQ9THXFXEtVuwakgHPmJuNHXVE72z9M1oHde0/w0XwUmyFRrbNRcPSQ27mPu3iAgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/eonYLcPXH/X7ij0e3suZXzIxYw/jdKnXFrfWS9skE=;
 b=jwokywy5i6GbcFCoawSVKkuRwNMKaQqweSxCav8ErWbEszAj8gikiYFsVHaJjh5/nNv6lMo3X/m1TRfFgJtITh1qmRvWxY7OfbX6ysDBI3IiJHbbl0W1zSBAiqUQDFB3pxuA0hhrdUaoiqE6dOcRQgmWeISIWHW22jmZ5z+VJwLsHpl7mG8OPYlcK41fzahN0UyxwbMBjzmkgqFKkC+E8Bb/6PcyOGb/x2UCfh8d9IhY/Y8K6ZUkNmhjBlMkBkKfmFWylb6+Y+kZLlxjoLGkd8XbhQs3pE57qBk8+WjDqXmVJq7I6wKpfgH8Ul7jE216ncQwz03NX/BBrgBPQqb8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8232.namprd11.prod.outlook.com (2603:10b6:8:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 07:56:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 07:56:08 +0000
Date: Thu, 30 Apr 2026 08:56:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <techboard@dpdk.org>
Subject: Re: [RFC PATCH 01/44] eal: define new functionally distinct config
 structs
Message-ID: <afMLFLpBEJ50piaw@bricha3-mobl1.ger.corp.intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260429165845.2136843-2-bruce.richardson@intel.com>
 <20260429120348.38d59538@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260429120348.38d59538@phoenix.local>
X-ClientProxiedBy: DU2PR04CA0257.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 3163e0e4-ccf1-4fb2-f2f9-08dea68df046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 28jRVLSmNJcnl7ycByIQxYCESvr1LdOqpdOCJA9r2in4NafG3y9/KSpjyyWVZ7OqiZ9yqmTGHNbntS8kt9sf09MQaNfSJ2D88Vavq2f+vuSqW1u3J4Jjvlqq7QkRjR/R7gKoENdZkdMfdS4WdNy7VDqZcV1N4fnMz5uO7V6p8Q1oYF9ZEpxREeBi1+6FaW0yVeSugE9y4wKTMb6qYeXpbeTdlrpxP3j6qByQUHCAbXPRG62b7b+rmtR2uuIBvLITfIIj2SkzZrI99fjj8qyonYrfnUhALPdghxEousY8lDE6F5KzzJMl5FoL7JoaaZu9Moc2bNH0gITtOH95zNliiWrfaNlZ0HHEcTB8+wk0Xs7/XufSDFILLSvt87+qgiLLx8Olyu0QAM6ekBKkGKVt74eUmxkKwj3iZbOI7rdl5LfADxMjNROw4XKg2Wf9fnOpghZZMbR6o/Q+r3KpAsZ+OS3vaBuxmqpdvzo1kfKDqL7j43XCf+5dT6E7SX1XsPxjV0F5Md5LQcd6zxwr4+HxkAC+GCmdLZlkfjpi33tsGnRzZ3dcNZpL9smSBuMm88I95R4Iol4iWHotkkT5f2RT4uzdsg+VZ0JqdFzktR3n3LzCNNRGJEWdCwcYCsfTKEBHp/8HzPTq4Kn/X9iekjZJnU8FULbvcZSW/MsJAS5OWEhDI+Au6M2dmCK/gCZhSNylGd6VPCO2/BkHi9qnWZtYGrL0CCyhrXq/Mp2a+aE5pow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bTfH6e1emZsKPJ8Rh/64Jlg02ipSxYBkqmCl4k52ILGED29astBdWlvaFysv?=
 =?us-ascii?Q?fFo7TGosi1QY1fa0GOAwWvg8z8z4Gumlf9RRL3ZMazuYJa+IqG9+o4BkAaba?=
 =?us-ascii?Q?tk4HvSBK85j4qhVPOvh9cvcZcHOvnqPEhkSwj8jBO8VJiCd/uOmYp29aPVQv?=
 =?us-ascii?Q?PvgAhkxiz+WpLNUXtQNKnMCUc1XXdejDaHWyjzsbZmgPtNCsT73wVTGbIxuF?=
 =?us-ascii?Q?jaAr0rBWZ6Sl3uv0OnZXVFf9DjUAV6PIR1mMaq52hDYszpXusSspz+RKapEW?=
 =?us-ascii?Q?2svfSUrI7JgEW+0IPfkFU0JJ7nsWHcaDQ2ZJvObjt2iU29G3p+k2d4MOhghQ?=
 =?us-ascii?Q?FBRw/59wgWSKLjelWwAIzJ0vxyHRHQZrIzEmmYDKKroprQ+gA+0j51hyJuRL?=
 =?us-ascii?Q?zkc3lP1sUr3cniHJDSuL90w5XoTkBJrC4hJTkNK/nHqS8YOuUAaPMuBmhRpg?=
 =?us-ascii?Q?RrasTyK2n3AjNneXw28gWiVLyMgqigFLuR/ARyitOEKkIfzoEg0U1AixT5Tl?=
 =?us-ascii?Q?BcSYVAg7PaPbPQwMVcOWTgFtuFIKJvxJODCUZPS0uv0+dHyC9xyUkiiryO/2?=
 =?us-ascii?Q?Cg8F/41J1QW2lz6HBC9YfMMLURJOX9RhqwEVBSbevpBvLsAhj8AdEi41vtxJ?=
 =?us-ascii?Q?VdcqyxldMjStl5AP07nrQh+ZSM3azMv6i3LDHpn8pA8fhi2AFkF7C9evtID4?=
 =?us-ascii?Q?oafdPajEBpef7eCWIVkgMkuAWgOpW9UMdJ1H2Q01NuyE9UeA4mRRd3t0Ukz8?=
 =?us-ascii?Q?rwALME6tmvgWxzYeu8IOA/kuKVn9n356bxa9TZGxQeoku3Vs/S0qcF0cP2SS?=
 =?us-ascii?Q?WIOrmLKJhI1wr4mxUPZoDiMkgPPlO5nAgOfjuO+Edbo1ouEj0PGgEPGIzrA7?=
 =?us-ascii?Q?qwbRz4BwPmTWkZapF7TYUUw/qWglvm0TQ18djY5a0bYudHxO4+8Ehnzrka0F?=
 =?us-ascii?Q?9dXmfGV3omK3hcuIbbIRdFnFfnYB6t+RmQWK+W5l7E7IHWQewJrMnQU6mWPC?=
 =?us-ascii?Q?KmWUXQ1CHv2ntNJJzeT20aenTeYc4D+lvzV1UUzb+f96OTdTGARyrmIMlhlF?=
 =?us-ascii?Q?Xku31q+TWsGdF79ReL5ZZ9ImBUayxpcsGKRJA0nTBhrAq43l95GS58zAlMnI?=
 =?us-ascii?Q?64FxVES+t855YDAJ5/mV+CzMQSaS4bLnyxADevuLq9N6QLrqKbashUx7e2L8?=
 =?us-ascii?Q?Y9EBELQIU18UaKmqDWej56U3+Kv78cX1Amnc13IVyOlPRf5zTx/epHhL8QfE?=
 =?us-ascii?Q?Y6uI15BRBcd+aVZzEB4YWmnaItaVTVJzjgoa+ypkAQpBCPSn6yiMEaQLgWd4?=
 =?us-ascii?Q?qjM5cye5tOihBKjezLYamA8DborkWLjx9z9j4YTrwEqlII6mYG3pqYe6jPQU?=
 =?us-ascii?Q?MCDHuGu1FDTOipsIDgZMGabZ2SSpb5S36fLhIDcPt0rSnWVUi+UDl7qJynhP?=
 =?us-ascii?Q?5+UJDk7nnbmGGCqeg6dElF0Jv2vMofR45elm9pwosDuk0VJ0df+0oUWPPXV3?=
 =?us-ascii?Q?SFfuggLSUrwlRZLbwwU0QX7YsFrD5P9G5e6KYZYuPD8TXY7pq4Dx7kXXx+MQ?=
 =?us-ascii?Q?GCs7EKLEL6bDGtJY8vHAEQceI+bvo+0l7zWpwaBTheOXlSwRGMW+h1/47+SD?=
 =?us-ascii?Q?w5aOMBmLPEYFoz0E9yItpbosWu5O41td6rObCHdEGJYvXVclwYtV8yxy1o/l?=
 =?us-ascii?Q?auP4PAOJ6M1WPddQ5Q5NV4UmBJ2AD0A7AYJJJrpUXhuMcfPkGRAoc0OWfiHa?=
 =?us-ascii?Q?oYOpPC5U6xAMLI1qsC4bcuX2nSPKPSU=3D?=
X-Exchange-RoutingPolicyChecked: l9+3V7pBrDj7PEPakp8kZbF6wtFJB1HWAvFbROwNsHSTyXyngfsrav2gwz1YmRsksf/6ceE8243S4OCAgpmjHJaKYTsPeW5Ar7BB3HhSLbmSKeFp7N5E7DoubOJHHIA3WD7YeW+X5dgxhzgy/W+M2Vit+Y39EV0PlwkPSoU94hwXdVvEOySGGjjB6Z27HrAEidDSDBjgNfxT86oftAZ2lRIgO8tusWFMtV0Wsz6GLrSWfLHeSuGihGeqQPejsDILP5ABuGxrFNKIEX1kIACKM6TRWAN31uwnir8W3X3YN5cpsR/r1PzL3G1+etfcwmVRHQ13FG2CjtKnareVsGVUbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3163e0e4-ccf1-4fb2-f2f9-08dea68df046
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 07:56:08.6930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFQi0G4m9ISAVaoKDbXisaRqCkchT63crmzWQ+A8wNX/UfaR3H5R3czSmQ4luTTl4JTmp+aIVYpYnU24xeR4hcYAfkWjdmpLxBoH/zO5lmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8232
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

On Wed, Apr 29, 2026 at 12:03:48PM -0700, Stephen Hemminger wrote:
> On Wed, 29 Apr 2026 17:57:53 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > +/**
> > + * User-provided EAL initialization configuration.
> > + * Immutable after initialization, so no need for atomic types or locks.
> > + */
> > +struct eal_user_cfg {
> > +	uint8_t reserved;
> > +};
> > +
> 
> I assume reserved is only placeholder to be clobbered in later patches.
> Internal structures should not have reserved fields

Yep. As soon as I start moving in actual fields the reserved ones
disappear. I think some compilers complained about the empty structs so I
had to stick something in!

The other alternative was just to introduce the structs as they are
starting being populated. However, I feel the intent is far clearer to add
all three initially.

/Bruce
