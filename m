Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A310C44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 12:57:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E20040290;
	Mon, 20 Jul 2026 14:57:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 2B9BE4028E
 for <dev@dpdk.org>; Mon, 20 Jul 2026 14:57:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784552271; x=1816088271;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=q6luiXPAkw3iEZmXlhbmySTYQ8b27AW8DeNlOLhGV6A=;
 b=k2Jg+ipyvO4p5ijsxsj0SWJ4GkdldrG7GjFUAiLvTe92vp5IKSLdmDzQ
 HBBlfUqCkN+MLhSBrjNlpnb6CGnoCax2IPiD8zR9ZSjIZmNnAFYjz9WU+
 lANVgLmCgYjHt+kfFu5qvYzB5AelSnigZRHLL4/2HWfZToCXooWRePjta
 N1z7a0D4uQ8kyjpLako3Kh3emfk8+AVcLFNIu3XAydl1q3HpjyQpivTI8
 hYYHXNGrkTiLi2HSm+pwbX4dfdl1LyZ3GfmXopaLIXLYAoy+nQFHKz9pc
 HJTMQlldcu3OLlvsDEbDzDVuIfZcgjurEi/wKRht5pAnXjQ0ljvvNOUfK A==;
X-CSE-ConnectionGUID: erJ49dSTTD6L51lfOtVVnA==
X-CSE-MsgGUID: F7FQK/82SauFFqQ/NRKpHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84897549"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="84897549"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 05:57:50 -0700
X-CSE-ConnectionGUID: 3OUNbtESSeiCkIh24WmYtQ==
X-CSE-MsgGUID: Ocr31Wj9THuSrwLv6LJadg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="261247729"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 05:57:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 05:57:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 05:57:48 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 05:57:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eI2Tm+5+CxSpIiP6/Dvc2v/PVF/kuDT8Nk1A1iFJXDif+S9PKkqDTMoVF6XcVZeXhcGebpBjIlLu6xF27Jz8Oj4R7LMMa24VLisZIdjapWkuFaR6SWjoIZ8NqrjbEZNBxjL5OP45T2WYiD8qy7tH+U6imXrYCHSAXULiE0fV6HuXIOA76z9tx9K/N74h/aHez14B/v2uuTGdV5AAmmQqck8Keti4+qDujG+km5f9H031U0lqDaZoYQ4NkjdnoEp2C+Sk78qSAe5QEZwzy/JPcgGTI1E5SW4LF7Qwh+yw+Ma9tsynnHfbgeqLMjuHOvKXQL/F+hekdb3AARmeu47vwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTDGXVfJJxtByvDYN0n/HlXArxABng48MLgfeXsI1Xk=;
 b=rD08s2KoZ60T36sgR/HlnKrqAV1IoU6RNi6N3rtIsQga1EwX70RpeHHlPmWLQnsCUaInmQDf0Ff1X7rLfrRmkhD/aXkjdaYmK5yj4TYCVnA6tK9uoQbyNUinV5r8A2FzZ5RPoiWo+YoD7Q1LdHY3hafh/kItPdxCfocgrKNuXzuuSk7v80Wn7pzmtAxTksFAbWdSa8aU6OS25Lzd1CdoztE8uW1DI5iH+eHFuzHEvakIfHs9CU2ucIMG3WRlX6Ml+tPK/2ku+TPPBrdsOy4tAX3SoMM1D4141/6CssEd6GQXGwWwQEsLJ3Nb+5PT1f9HIJ1qU9wEbr/c0pUdXvzoSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA1PR11MB8098.namprd11.prod.outlook.com (2603:10b6:208:44b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 12:57:45 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 12:57:45 +0000
Date: Mon, 20 Jul 2026 13:57:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Maxime Leroy <maxime@leroys.fr>, <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>, Thomas Monjalon <thomas@monjalon.net>, "David
 Marchand" <david.marchand@redhat.com>
Subject: Re: [PATCH] doc: drop recommendation against bool in structures
Message-ID: <al4bRFcOPwqXGPhM@bricha3-mobl1.ger.corp.intel.com>
References: <20260720114602.787429-1-maxime@leroys.fr>
 <al4Q3f3Lfbv8i8V-@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65980@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65980@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0218.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::13) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA1PR11MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 5431cd2f-0c81-4103-21a0-08dee65e7e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: SVsXD8xmTwmqDTom9hulluepEb+9EktUlvjXLQ4ZikoEQJ10hMk9FFvnh4DVsrEuCeJgT2YZabb/yU5IR7qsr0K72v2uddFst3efDUL4upm5lyq+9XE8YL7OeZbI6pcP5ayameLWBVWhmabtKQsCf4sOzfQppDaJVuWPgER0Q6GdFyz4F9HX2TEcHBXlccbyGSEZGsqgsulKfZk8XpW6IHmwcLJ+NXYEpXU1CEDuTeN9wlIDFGfXH8XND4IO7tE/0Kz3RiH3qN++OUMsOHzVLqw1Y3+Ywbm8OHr3/naiT2YI+/8bHdHEAVFF29gTEQ6gVUzL7rqqoaWqupbaHCt18XPE6tk2YeKmQjdQqIYYCgKFxQ/7g5u4P9LPnn7Sq/0MYPM+AtHJbHzNzbTCYWusSWzgZkVCr6/Jf24NoWF+nNLcaBBJqfl4Xo3j11DO+LU2tTpV1IEnltVoQZ1Q1C41WrjjeuTgFJ0FbG08FiOAaPHj6Wye06x1R6ZiD0R9osSSHHr+N4aIy7MFiMMAGx3CiyNAfkIHoTisERYPmUjaCVlPpr4NNC1df61LHN9gLSRWfnXKnFmyydrjcZb9AKHupnwiMwT5UCPHJWr0m99n8GWrbr4NpL4yEFTfXLk/HbOK58brzNyls5oe3OOYmmBdDzLTmm7W3oroVyBpAgaQOG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YKM2alVzVAHgLGYuAHewHID8WmLKx4GDfQwpHYL463SyYNu0b2TiQwY/d6?=
 =?iso-8859-1?Q?E3ptJ0j5Umjwctw+U684ANPme5TWS8U3nWjqkWyOuOr2qNUWmFxHTKMZfS?=
 =?iso-8859-1?Q?PQJmR/v5fJOjiYHY8MDjvO5bmDhnsJZryPpXxBJPUms31fYduBwF/vLVUM?=
 =?iso-8859-1?Q?ni9K21D1zq8pS0OnX3O6J6UT2qNQfAbLz6FmMeqrjBm9VfWOqY99OKvBC/?=
 =?iso-8859-1?Q?GrR6MTn9tti/O5iosf8wGZYICMpkXP7LTkmll5HWJzEOlzY7qbCY5L/I/n?=
 =?iso-8859-1?Q?iTOOgZolVpQf6qbsvVKusWT90qCxZ5MF0Nc7otn1l7kkZTHQP0Bz17ogBt?=
 =?iso-8859-1?Q?JNlDi+s2qGr501FVPMjC9YUDoDiC4uygnke7Hn88IDWpZ6Eam6Rl/S8N7Q?=
 =?iso-8859-1?Q?wyF58CRaeREXFOFOqBRwzvkFbUE60caPsTwGG8iNq2Ssfv4gSQAJLo4ERi?=
 =?iso-8859-1?Q?d9TN85hzftMYJP1RFCE5BNYhr76ocBxlvgFAdhlfpBQe9K3zm2Vlte43Gw?=
 =?iso-8859-1?Q?3Bc3eoQUaKNGL653hqudn3y944F3GEwIsstCV5yOg6AL4TUFF4WG9HYC+B?=
 =?iso-8859-1?Q?QABUFHVG5FQ7p554GRzI1ECp7M8GFsO01u4Y4LM7j3t1FWqNN0ZynJdZJh?=
 =?iso-8859-1?Q?y9NVEtNrAGai3dQ3Q1pR7z+wAgPsRDLgOrdEjdxw7eZYTMGbDxWOWRTQG3?=
 =?iso-8859-1?Q?/hEC7FM7DQ1CAk9sk1dyq1oKTxDDaHdkN1W9RnO9MYyuMRdKQ1kujXdbKg?=
 =?iso-8859-1?Q?TmUKQ753QgIVTtd+cpliGohshm1OCmNO3S+dTNykZRpv12ng9VkGk19gIO?=
 =?iso-8859-1?Q?NA+Qfe7XSiusqMPPUWFqJSuov8NpwSuN5fk1WNatpRm4pjD+y2lFPbbh0A?=
 =?iso-8859-1?Q?FC18WJ+7sU1n5SH4yvwQG9nXxH1kWdixTrteqtJps4O/T6AKcuLHz0UJH7?=
 =?iso-8859-1?Q?iOcVIP8I5a7k3rViMIziFLTdauhQ1UrqisvCiilS01SNh/NFRIG4PX4eSf?=
 =?iso-8859-1?Q?6sJA+OgYwUKUw5ccAbV41Q27zWlB2aCG4KM2/ORNBsSy8rZ2QRD0JZcZCL?=
 =?iso-8859-1?Q?DF2vBEWkVcK95VC2abyd+beAArfSq45p60+z5rHoKac8k9A1ECM+5XhFJE?=
 =?iso-8859-1?Q?0d016XD1YxQni2RPjjgtdjocxYDJE/+5icB5zoMtue3pOUl3iRFvauHq1D?=
 =?iso-8859-1?Q?54ABzHXYiDcbL9mjw49VsqCUiYDhPXjhTlnsEHJTJmNjaL1ar+LZe6Bxlc?=
 =?iso-8859-1?Q?uZLPRy1uQpfKlRJdHkjwINB15Ntd6wVBFv3nzIpbOVJJIoLTwTkxOMXqMF?=
 =?iso-8859-1?Q?JZ1Ti2rMMTn7IVPhytB9PSNQSu+xC+37HwdiVZUW7wj29G/+p7clbTGSKF?=
 =?iso-8859-1?Q?yy1ZzhKTOye98LnkvAODNS8kTRxBSETYqKH4uFRKeRLlrmTpy5f71PdXm1?=
 =?iso-8859-1?Q?scXflhopDXxHZog++e3IrtGpVSr7GUB1ZBiyEsFuL+D5+zwx6v99m+ev78?=
 =?iso-8859-1?Q?cHfMI+F8S2uR5fvxv3T4uGIXw162UVonN3/iy7rMNOJ2E4skMG5L43sGzm?=
 =?iso-8859-1?Q?RJqBb2bbcmKJTSP2tHFx/SlObZsNJuqBap4/Q5Fj/JBnmGptLqMn8yQYMa?=
 =?iso-8859-1?Q?z6fRU3yyMYjRq22iY+yaNjSfJKOdDTcJzplFyzHUa5VHhQKbYR/cZ63mBP?=
 =?iso-8859-1?Q?WXMR2a3HgbtU7ApYdN25c1VdpWht6vyDkIO6iyKSs9yDzeZNlWLJI5gCFz?=
 =?iso-8859-1?Q?alFPb6Aksv1FGnB1upiO1zcReINvB+JR4ofGnK+hZeX6hMEAWkfoKcAXUU?=
 =?iso-8859-1?Q?UotCcpYnB0KzVxqJlyrUowvBIwljpnw=3D?=
X-Exchange-RoutingPolicyChecked: rc9VZlOVHkpv2XSeL75gmZbYxtSej0OysMzd9RMrvQlgChpHn50nlQvSgLg5Bgq59srNTgbpcFqscRaDpiqaGbbBjtI/AfJuTvJxHVEz6NvHtp+pIKU19f7URGVS0mFhHHTARJJ6jvcT5nLLNmEvnquhOA1syxxbBuqpFOiDCfLTUv5+1YJwo/WdrlIfzkrw15Qdm8EcL6WG9tt7e399XCtD8YIdvB4PAwtOK7ll4AqFkuQcUGhR37HMNHvJtw2Dahujc+aCnD8oY4rvTx/l61PiLZwES5+6HQLU5OvPpvJ/Eh9888lEtTxzWbi70vhzgUOu40I/gdlYswv3HFEzaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5431cd2f-0c81-4103-21a0-08dee65e7e36
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 12:57:45.4383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBxiitOb+M+qC5vSYfPz6QyaCaykZbJ6xrA7cRPS61q4zX86ivXthQTXRZP/P4ajOE85edPjGauRlH93Nbe+SXFSYIwCzgdlhMP45DX00ZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8098
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

On Mon, Jul 20, 2026 at 02:51:09PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 20 July 2026 14.13
> > 
> > On Mon, Jul 20, 2026 at 01:46:02PM +0200, Maxime Leroy wrote:
> > > The coding style advised against bool in structures, citing space and
> > > type-size concerns inherited from the Linux kernel. That does not
> > match
> > > DPDK practice: bool is already used in over 1400 structure fields
> > across
> > > the tree, including core APIs such as rte_flow. Drop the note so the
> > > style guide reflects actual usage.
> 
> The note is still valid, although massively violated.
> Could we paraphrase the note as an advice/recommendation, instead of completely removing it?
> The intention is to make developers consider alternatives when adding a Boolean field to a structure.
> Maybe it could be expanded with a few example alternatives:
> uint8_t value, or
> uintN_t value:1 (bitfield).
> 
I don't think we want those alternative approaches. If something is a
boolean value, then let's just store it as a bool and be done with it. If
we store it as an int type then we need comments documenting that it's
actually a flag. If it's a bit type, then the field becomes just that
little bit more awkward to manage - though still a good choice if the
struct is size-sensitive.

Because of this, I'd be in favour of just removing the text and then
letting the developer choose the best field type for the job. If bool is a
bad choice for a given situation, that should be caught in review.

/Bruce
