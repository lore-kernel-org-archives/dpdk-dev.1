Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA4BF4198C
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 10:07:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52D3540611;
	Wed, 15 Apr 2026 12:07:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 367624042F
 for <dev@dpdk.org>; Wed, 15 Apr 2026 12:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776247645; x=1807783645;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UCsLBlRgFdVtappkv85UepULe84rbZbAC910cYgG1IM=;
 b=nP8IeidyrFtWquPAf9lUX36XRoWHc0DP3pLiv6pgw5neq+XLPPpOqIdY
 x7K97dORvkPPVq1YzR5EExbpXqgJILmrjkXXxZw9uBm1gAs6ZInIQjINm
 O6wV2wHk3UPj0qhb/TqMvjG3f7JNaIP4jCQu2qj54jhHglHTctTEtPxT0
 nrbjzU3deNuFelQ5+bKKTvGyGclCckNrqh1b6SG+7TMLeOjpzyGSMv15E
 V+qtlavZSZQs5efonl40nqqOlhxTAE2iKdncMVsCszdT6URYPAV2QNDZG
 mWwsJierPu+uBdr2d1Yt96oa9nPupU+ntKLmXu/k30ECq1ot7cAa63Nws w==;
X-CSE-ConnectionGUID: qOxMlm2nRUS8wZpmjEDxNA==
X-CSE-MsgGUID: qX+YbHKgT3GY945vnoAOKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88600296"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="88600296"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 03:07:24 -0700
X-CSE-ConnectionGUID: glLmnxyfRKCGmNDEvJDjDA==
X-CSE-MsgGUID: vL3XnavlTAe6kTL8Ocj9pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="226066340"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 03:07:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 03:07:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 15 Apr 2026 03:07:23 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 15 Apr 2026 03:07:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdK2mSK0Q4cXi30BcARMeOT2T3S8g8l47Sj1EF/eEBVjWqAJtlf7fwFUCw6elDDJZbM/KTXJ55OjJA49+cclV/KgXFkwo281zpOa6UpmZX9jizRRfHUbW0L4zbGxnap133bm19Sfhbi09KD/4SgzRu3CjqOLUzMDwFVkvBAWxMCqNLaUhwq0HbnOrV6j49N9Fy+mNqtcCATp/LjztN5AJaiaaOAvERV8nZCBmEuBm0RyoStkijgMWdeUVVHQUEkrjdjWPKB3e/O25TdLbXQRvp2NwqN6jNCqG96lkUpZCub5+/TxT3Eml6L1qLTf/zSwJoNzHGtz2n/Gq+3EGWLkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeJJ/qba6Pa4P2YwfuUytwZ/WLHpVwmwd1V2sdkHFcU=;
 b=fyV02qIsKbxR2xdMm8DVtFEG808gMykAP7qK9Nm5IU6ZJdZ9gnRN9kDzdeHti4A0HrdUBe591d3uQyAIhiM4v6W3oNd0q1F33GwP8wCSuWBMz4A/ZpaPo9bAzZ8OvXBilG4nbtiCQ1TfoZIGIbc41nhWDiodf79khOWaboUBKTkXPN9eYy8if6kYeVzt2KRLOE966AHEsd56hW0ADw8mCBZd3DcZ0qB9Dv6tZ8ztBNtC9n9TUeH+xkCC3WHNMMRBhs5QC9qJ5OT6p8yX1vjQOcVG5JiSMjoPaKTcSQy2rCMTNXiT1LAM7i7tkLL/hEXZJSL5w3GOYoRsg1c+/8dxLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB7376.namprd11.prod.outlook.com (2603:10b6:8:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 10:07:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 10:07:16 +0000
Date: Wed, 15 Apr 2026 11:07:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Lukas Sismis <sismis@dyna-nic.com>
CC: <orika@nvidia.com>, <dev@dpdk.org>, <stephen@networkplumber.org>,
 <thomas@monjalon.net>
Subject: Re: [PATCH v11 1/6] cmdline: include stddef.h for MSVC compatibility
Message-ID: <ad9jT-WdyIJOGRns@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1775850858.git.sismis@dyna-nic.com>
 <e6b37bf0359f847e14b84eeca3718e98cb6aaecd.1775850858.git.sismis@dyna-nic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e6b37bf0359f847e14b84eeca3718e98cb6aaecd.1775850858.git.sismis@dyna-nic.com>
X-ClientProxiedBy: DB8PR06CA0041.eurprd06.prod.outlook.com
 (2603:10a6:10:120::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 72bc3bb6-7c54-4a0c-a6df-08de9ad6c589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Uuchl+6C1MIug+JEq7BGR5ML0ARMCCPBavogG5+8+ta8CDFN2WqBkuiNKqMW9+k439LA3kPowOfZwsF7FHbRzNj7FDWUmLeiP0NTDoW+4fqK+za4k0P8vQMaWQ1LKKG+KWZ1XFsMc7eRkWZcglpg7oNSrBFFCPzY1DyIdrfrUp/hRwhzGOCtJ1PbLjvbN8Gj6JLlgWJdf6HB14Y6bn6ScomIKLgzi/YRcrzmRVXEeaLthMixt2jDPThJ+abJeHjCjS4gmtpMZHdJCMNOvqfUachOoYKLSyYlxDM6bPDwsS1HjL8xi+EE3nIIRxrgEDkw8MHgmg8cELRT5gjkZ8Rlmwk5PYnMsQ4g3/NMpx+nXqF+aTjaCn6OoDMUDwFsOubtZpIj11xLAzbkP92E+qKcooRVyMslfFf+a4qcic3KtIBUAv/jah5dH19QzXLwOgr+yx4S6Oqa63XlJZtWDO2Gpc7+cfFWZK2vJgPqI0A+ZdfG5WUzej1LDbwWErRPiFDQJjxuLOhOjFzn+iu0yKHFpzP7c3KhnoxK66Kb8QV6G6yo9JUzlP9A3vxYXMWtP8w0un6dCjLsWD/B7GMp161KYQ5fnad8A6j0eonOiz31PyjAYERteMsF56EUKNogs4p1aiKX3C1Q3FZdtU33hBhR42s0YkasJctZCmGdikLNk1WACehqaNx1LtJDRacvoocbVcqokPsMeY09CB24L2b7NRJjZwajdz6lRPRSfUqUuHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z3QZMY6BjfNAt9qmF2S7a7lZuqg54cx+LeH5YsS6gE3P5BGx9IR65914CGOT?=
 =?us-ascii?Q?EydjGuRpZE78do8lOylNVMlWQTpv7a9X1Y0oZdicYzCwu+duybeiGUCwhde0?=
 =?us-ascii?Q?XYK74xwTnIvs75R7nNdqGVKgNnnVCt1upAS67zGjtIcDWH0st8tgYxarXWPg?=
 =?us-ascii?Q?mEDzd33Wvz6EubFdt9BtkRySJO/hLpSwrj9Fk1MXuSiwqHprznrnpwpY+zv1?=
 =?us-ascii?Q?lCbfkdUAus5uhagStrcRIBayutZqCmp695gieloTqljxCISxpPmLWb0VHFgT?=
 =?us-ascii?Q?ILGchAOralmVStO0rrjy8WGH1x2JF06tHl0hSvveePYjPGMPbGXkMmQTl7b7?=
 =?us-ascii?Q?Qo4AW3gPM8wmgJQe3Z2PpkGxWSNGTC25PUtyRgS8qTj0zrhf182ZnHsN0e5P?=
 =?us-ascii?Q?GI1/xYZZu24EFjURVdhLl0TrmhKI6NS1Wto1ymavPbjAOxpMd0YDyLtQTOoL?=
 =?us-ascii?Q?RS8udm3IMGfpgL2vyn3UB04x7BCKo4J8DPKQ5+2zavZGi8jn9rJ27nrb0Wom?=
 =?us-ascii?Q?o4kWhA6E25VnwPFwmA4h1tVh71CAjCbraW9uQ/u6XLJYThetuDS/L9bZlYKT?=
 =?us-ascii?Q?UoGuzbBRYQEjDRnRTgTTzLte9mZgs6SnEEXm1htJ7j2o3Ay3Ndy/8gUGMrWX?=
 =?us-ascii?Q?/NSnPK/eQqq6MIlgRGD/sTO1vkcsYxKmHqSIhSpz+EdZrtLJqoUePX9CCbYX?=
 =?us-ascii?Q?nlWNafUqHhR9SKlu87HWw6H+ASAmBWdou5uiAhMxVyVMzIewUMEbRB8XAZwR?=
 =?us-ascii?Q?bcYA8r6tYox220FFWXe0nGU5kvXZNx0+/Xfa/g85nrBeJIu/dcgClFqqWoY4?=
 =?us-ascii?Q?Ar83XXAqwbkbi/mjY4EeIDy8+F+0ENi9hziZjpvNGndMObHTbT+Kr00HDu1L?=
 =?us-ascii?Q?OtyK7tL2E7CZ9aBZueoA9zw2RhMWpBLI/VSHZXkeUonCJ42AEz/0BFz1ASPg?=
 =?us-ascii?Q?T6EdWd110VyynXYgDhMg8h7OdOwvNKseROnufD468w+h44W/syyXcatqsXjx?=
 =?us-ascii?Q?LynFMK26NNkBFBURrQlJskxd/Y61I80D353U894Vb5hVkzfSn/tPU3Nhfo+g?=
 =?us-ascii?Q?f7MVneZcp1ScMvliEvX4SXUCRbmVOKrgYSjnofGUYkXZUKC908OgiViXxxOv?=
 =?us-ascii?Q?O1HKmzzjbmb5mfmFUN72hC2bu/7INbG1ALq1boAwkJHJEViDOJ2fu+u42rJH?=
 =?us-ascii?Q?YvI4NHR2J0jQfunY8/9tdH6GQ1y0DgHrxGNs5vkMrOBcpjwBVqOZKJcyCXCE?=
 =?us-ascii?Q?oJZmCXTyLAW/Ft17BGazKn6CioYaEe+ikv19LvZTmGPAqcHJd9cM5ItD08Eu?=
 =?us-ascii?Q?mAnHqgUkrS+IKVtrSgVByLtAUTCXeAwcuCMZnimsseiDMFhq2DDbghZ+w63Q?=
 =?us-ascii?Q?4pv5nk/A9Bti+mxSQ0WzmZ4IRNY2c+KFnQdYXdvxAA06YgByCw6AWxj8TCfN?=
 =?us-ascii?Q?Wr61s1VVBDCqEjWlvo05TD28I4OFjnedIR5As62ZROedZZuZbfnKEFF0/gk6?=
 =?us-ascii?Q?q0kad798jXvcNqFvWR+AiukNyD6VX34ZfjgH3kPyI9qHKYiRyy3jdJCImSKv?=
 =?us-ascii?Q?dIrjdfBpOoJIwEj56nnEnSC8fY5eEiOf3vgq1nermRrcitsFhB/1WcCK3sSQ?=
 =?us-ascii?Q?VfW6f27N5TO/yYddZnPSAWXdZYNu/1j5XughBBJoSWf3YN2t0aWZEsFJ6T28?=
 =?us-ascii?Q?QxYUaIhJXp9NkeixRq+3mk1resydomokxsGjQNVVDOgKvMm2sOp5HCyr2AWS?=
 =?us-ascii?Q?2yxerSPtLM7r5qR89ifQ3qFwrbWp6ac=3D?=
X-Exchange-RoutingPolicyChecked: g2BQvci+KUvYZxTLl3Pej+EQnrhgi3xltbx+1h2/WlcStPunK+FD0IDFj6YwyS1WW87SZi/TCdXwQm/fBjm4oTcgVLZXDDX3ER1+PghJrGHHZNCqpFR3m3a4LwkgvFpcupqan27sdp0twhsrWqCmXi//4m0NLwpUVIJlBotcSVd0Q/b3DnoUDuen9Y7fFvE5jyrhrHzxgXvLqaQnbuhO02hOBX/pMjxXGcaXR5YQfCoBICAOWZHP4Fjox0Az6fP+M8eOoyZ0iYuuyywjtOdOqO4nS5auERxSPb9s6w+34u5C9kXxAg5tTGLzHx9fGYYmjMCZqm/8OMIrzLwr+XDNZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bc3bb6-7c54-4a0c-a6df-08de9ad6c589
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:07:16.2512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4nrO+aX0vCwZ8ozjdK7EBn33A09EoD3X9OUa7MVz6eFo5CRQasuebHYShM3e/a26zh5+rzNy9SIQmZFqd5AG8H77KD1ZZQ1JuGYvqK3YZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7376
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

On Fri, Apr 10, 2026 at 10:15:39PM +0200, Lukas Sismis wrote:
> Include <stddef.h> at the top of cmdline_parse.h before the
> fallback offsetof macro definition. This improves MSVC build
> compatibility by ensuring the standard offsetof is available
> before the fallback definition, avoiding macro redefinition
> warnings when building with /WX (warnings as errors).
> 
> The standard header provides offsetof on all platforms, and
> including it first ensures the fallback is only used when truly
> needed.
> 
> Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
