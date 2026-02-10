Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FED8EB26F7
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 17:54:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5428E4042F;
	Tue, 10 Feb 2026 18:54:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 65EC8402E4
 for <dev@dpdk.org>; Tue, 10 Feb 2026 18:54:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770746052; x=1802282052;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BHyHjy1dF6YISwmNjtslkCbAORIPmIfEdXkoPgwJp6c=;
 b=lL4N+htaps4QLa/cIoM6CrEcNIvpBeTHRcL6BX/8GXRNvDyS1HVs8CCB
 /DXuBgQD1MjqthuhNdt1mwo/3cIYctIrr835+OOhqfg+VzUCNdZ77yDO4
 wFskiOSIg1I/vR/WdJz7V1AjoianFx4dYphLWEI+EA9eChqT3F8dG0NVX
 lS0OTw2kPlXt3099g/dbnR+MG8hvseKToMVj2jEoYGeYq7lbWd48ReBdg
 Mprt1XxKW0fmJrfRIHan3gpQ3qkUPlZOZNoWkInaXGWOFL26MiZpDRGO5
 xxT5D+2rDsms06g42Hmx2IZBkGLfb92pwdwKpQk1Ao0RTIAGJDMuaiuco w==;
X-CSE-ConnectionGUID: mPK/GSfTS/eIwmRoceH6sg==
X-CSE-MsgGUID: zpQ3t+8tS86IZwwEE+P6wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59447700"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="59447700"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 09:54:10 -0800
X-CSE-ConnectionGUID: WbpjEtXGSEilV9R9+jTeCQ==
X-CSE-MsgGUID: OFDM1J9vTMmF2HJx7VT7RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216949481"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 09:54:10 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 09:54:09 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 09:54:09 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 09:54:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmp0KntiQ4zRc3qa8Hx16gkv+5ydbccMRI72ezrh2+IC1EDnp9cb0QobqDeHAsuUDOBeOpdnFFC2qo7fzGgnAH5M6OGhAGJefvlHbYuO5P922voy8yWY7/FXiDW08aDkwS3IGcKmlBUVPnNS1ZS3zYMyt76Dlt9xO2DdjjNA/PmTqars+8lWxoiu/2HJo4FDjJrUvgoqxsM4CQtC0uATVm5IfyBq1C7gEFFiC5wrRobMe4Z/Z33lIegmtX1029Bs03poHqbgJn0ti5WQs4REJbtJoVWyjTWFKWeArv0xjPp5eT6z4Pz6XSYUPHwJpDH2aaT41Ah8CJP95+ODngEwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t50abtNxV5BCFXzHJwZSVm37lZLqeDLBpBGSgQTzkQ=;
 b=bTYWhxqoUXAZSSN76m9liRZWwD5HyR/OsZ37/K9x+8qzDOM6xTZX2xzXLfGW7CbYL4yZBkGBfc1bROcJRAwglOG/zSE0EaWEGDfO6DLSotPVUuSgPpkmQhcgYRdYz7zEnPhWBYnaiJrVlFToWGEVo7EI46AAUUqgAMByQK0o2DLEF/tPN6r3K07uOtNqUd/oZYBXHfBova86ZnaWTOY6f4BMwOfnQlFxv2L8gANJt1zbTT/4klOWVuxCaFfHLYjJ5Tv2gpWk6JlS+hqrjkxkHcxBC6uDaVP0U1VJsri4qM3/QUcK+CMOJNHQShyqois3RRMhJHZxcgc/z4THoyDW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPF085B02B26.namprd11.prod.outlook.com (2603:10b6:f:fc02::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 17:54:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 17:54:07 +0000
Date: Tue, 10 Feb 2026 17:54:02 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 07/35] net/i40e: refactor context descriptor handling
Message-ID: <aYtwuoRLGMISZkZk@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-8-bruce.richardson@intel.com>
 <abad013f-0a13-490e-9443-0441233684c0@intel.com>
 <aYs8WvDxV84HohAu@bricha3-mobl1.ger.corp.intel.com>
 <648f5f1b-a19b-43b6-963d-3add913e1f93@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <648f5f1b-a19b-43b6-963d-3add913e1f93@intel.com>
X-ClientProxiedBy: DU2PR04CA0311.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPF085B02B26:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d875e8d-37be-49a3-6a1a-08de68cd62d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/s5Ac6UTrMme+x0stEF7tnBjSAJeQaePlnLH/YYRnMHO5HzKW/FUtieC0xr+?=
 =?us-ascii?Q?W+P4l2tWCoC+WXaNv4tobEM7W+dJ5qqe/DdxLoSA2gtf2ejNz1Om0IOXDJpP?=
 =?us-ascii?Q?C4H3w3Xtfk+04MwiizPzR+k8lLw/l3WequFZ4Ch3apVMRsqpSNJ6tYtmBEv2?=
 =?us-ascii?Q?4oqHZGwLBI7ewOsZN8Kt++nSg73m+bJLriewlqnKjGfzdeJjhIMVOMsOnbNu?=
 =?us-ascii?Q?R4g5EjaWHZ8h1w2ulo6QPssJb7x7YKyHhDWO3RHHv651x0S7VYRtDAB8oeyG?=
 =?us-ascii?Q?d9Fkwy6lvogmTLPZLgu/hkfdiOfMjX7BHlRWC4WhF8abSnqt7oqaVZSyed8l?=
 =?us-ascii?Q?xynOWDC/2w2dyZXg2bznhv4cIhKJmIR5Cu+4SAzqQi+Fnqlr2t9ZnHaHUlNN?=
 =?us-ascii?Q?n7tU3KUwvJNUk98XxE2TJC9qBE21rX6ik+HIfyj1nIB5qLX2zCwpaEt0e3T0?=
 =?us-ascii?Q?ahifCIVqxjVVMM7dy5MUlQddwf50PDFXQXj5oKUMErLgmOwjflL3qNzVzMK2?=
 =?us-ascii?Q?67yg/HbzGaMKgaDWw6ksmEg+yPNfXRiIwpBplellixNDjEbzc+9TeszW6F/0?=
 =?us-ascii?Q?KCOjkU0Tfzi5FTrFMCL3dnsm/yz1tPV1Y6ehNN+wExWTyP64XR8tUKAP0Okt?=
 =?us-ascii?Q?nnUTWoj4fbqIW5mM+nCdsRFuh7NOsQjTY0zspRdyuDfjye5bFkSneOeQ+kJY?=
 =?us-ascii?Q?JrnJmu8OKdKTKp+LbiwCW6V3F4g3jLC9UjpnJJzFmdw4MkouOkIhrH6K02qU?=
 =?us-ascii?Q?n8HHmmIw3bBU6jeptKzY+YrE4NbK/LpOQoQvbpCc4f/y4hLqVCb/FM03cm3K?=
 =?us-ascii?Q?+Sp0kjjEQRzgBDWYEi+D8ezrj2wiMfUSt+pxQSEQmJrS96EobuDqOEwttFBE?=
 =?us-ascii?Q?d2DZMwbEuWjTI9oyYUOhOhMuaO0Yfk+lFrk54a/bCh+4U1swTbfB21Hjj3He?=
 =?us-ascii?Q?80igMoCwCnplCXJZ76p8E268Y1g8U8MB3VeRPfzIuZH8Gpg4J/KxyMsf4Y5u?=
 =?us-ascii?Q?9rR6Acoixh49lvWhkf1yxPR9jAyCfx9BfgpttUDAJQpgJSd54MMWjb0A+oC+?=
 =?us-ascii?Q?UOpXXFb2Hy3s8VQEAskFcYLEp/CBfMnEfXxOAEtmjVv2nGsdGr9bx1wkTdgY?=
 =?us-ascii?Q?0Kyh4T5M09fRggVyo6YCHgtfpr4KHcrqcvHr96TMz+F+zuDvPKyrg2hj858i?=
 =?us-ascii?Q?LLjTCoqO3SBfSALNO33MZ7fJQvubhj+fywWAA9D2a1bgIrhLjv52/shFVWFJ?=
 =?us-ascii?Q?KG61C4xLgBzQeJeT3BuZKclJ3KFYthihnlj0vfhdzi1EB5qPu/y6zZG7OMEX?=
 =?us-ascii?Q?o3Podr26UWvxnxgUBlYsgDt4zOEDSoltvXxIvFiRaQpR1TfJnH/kxHvb5101?=
 =?us-ascii?Q?1P07XFoRfuaxIqJ4puWx/0znhHPXGd82UMr7RhtCz2fJy5LJtaniC2hpYu4b?=
 =?us-ascii?Q?ay0CqM1ztmkfK/Mdofy66NyqefrG+kpm5GwkPrHtCoKdU3yJNpfZHz21W6YM?=
 =?us-ascii?Q?u2E8LvX+/pyrC0h7LgutvLAGhBr8KX9OF4NMQVMnDK+Va45SqZ7ogqm29k3c?=
 =?us-ascii?Q?MA1Y8IfZ4SwsTXa7zYQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1y8HHD6wYOASUXnTyZ2OwqVaE7+Scp/24wz/JJHvPoqG9g2zCyCJKeTHeok4?=
 =?us-ascii?Q?6qAX8R72X721mIxEZ6IMNHfIguxsUSiG8cC06e6nIg1A3kOCrdg0CYpJ2iRm?=
 =?us-ascii?Q?mWU97PSOrN6DxWC4iat54xcmemXCVc96E0fOMgZtQWHOncqWfYtlBZxWyP5q?=
 =?us-ascii?Q?i7pKXZwKDx6LwfArLER2lFgf9t20x1whN9UjcyPOoJ/mhlOMbo22PnXhOY3p?=
 =?us-ascii?Q?dgcWnyDyEMvj0jEZSh/bdtzh7xYO/tgUONLVzK7SHfplpnvWII1EoXHw7l0U?=
 =?us-ascii?Q?Prqq+JrLK6YWLdxrtd9+T9kqT2jvvz04RzBTSG3Qm3v4XTHpbnhKa73ZeIia?=
 =?us-ascii?Q?+ukXjsaSkCfCmP6X1VLiK0CvM82y75V47kXA12TwDhhpQshciR6XfvlY3Tyn?=
 =?us-ascii?Q?Lo8HhANNNukwx2tZ758Uq782dS9tobjO+KOmRKtELfvsUgPB0izzdiM+at9l?=
 =?us-ascii?Q?KSwtyTA7Yc5v5CEQ7d9do0Yp5dQiZasbjXgrlTKxd3xEavNeCJfMjLtsdOqw?=
 =?us-ascii?Q?sbB30GOsxzz6P3ruAdjZ6auH65IGZNUAbUjbd4uPNhwMWAD3GiGNQ0mSbq8r?=
 =?us-ascii?Q?lFaUYo8hutsAP3c/YmKQidV2aMa+RGb4F2YYhlKI4FHmQpgnbNgf838CuLXw?=
 =?us-ascii?Q?onc6nk0dtBdC4sCxKr87AEXuOI9vetEGv2JFqDi29SAsEACIYb6VkBRxhQL+?=
 =?us-ascii?Q?wUTkhhmt946cBCydHBhS9aZC7QdJM/MLQk2hB78XNgAHjizB8JvXPqsXqspH?=
 =?us-ascii?Q?L9K6laLQb+3r6p3jgnjlRIBEzKoizpAU2eEjKokRWZLy6hP3HSugkYGq3t/U?=
 =?us-ascii?Q?nTC6Cl6z2xLMLso4zueKvXl2G1cD2qIB3pEuNj0joV2snE4k092WKfpj3YMy?=
 =?us-ascii?Q?4iQnHLb0E7I8FuBmBNzshOsgnOdd1PpKGXijT8mWKzIUFMg7h08w/JA5HdEA?=
 =?us-ascii?Q?ruPob3gNeoafOSA2mMMinE84xptknbZBNWnzmQGXGpilXmpmCUN9osZ2+wkv?=
 =?us-ascii?Q?LgL6D+UruCucsZ2yPZ01asCYASNuvUXSdT5ye18I26HtoWR8gWUzIgO6wEOE?=
 =?us-ascii?Q?wGvFY3x8vYeDIdenf3huterGnsrn6wku4DVSkfPWRGupqsInn+xwIrVuQ0ft?=
 =?us-ascii?Q?jFblUF5IHbBo77y1s4YYI3HiZpYSE3789Ha5p90/IN+NplMOweiUIHfR6sFv?=
 =?us-ascii?Q?1Chu+9Wlf6emLLMvIKJypHWgBUHWQIuHMgNAaYbOJUGa3EJziNr8p0rU3fug?=
 =?us-ascii?Q?eVuYUl9Oqd1zLqXfS8HAUXJDK0vp5d3UfhNKRjdIad+dSkEEESIb0k77YlFi?=
 =?us-ascii?Q?9XpS6N4JMO7mIr7M77q9fYDP+T6mUrgL+Coe3EN+s7hE0f/WNjDx6RoBxZaK?=
 =?us-ascii?Q?BaWrSMpmdLn6yHSmdW/tfBR3YU+FLoQa5KZw28tn5O5OxU44loLrIA12TnNG?=
 =?us-ascii?Q?UQPvt3Mv8HzJiEf2KfP/XYftQ8X8qU/Zpjp/TMLFNkVlkzLZMBLYGR45AUlv?=
 =?us-ascii?Q?QhxBrp/kq5ly0qVSSjgIJEtu6hdtVHe1GZidHYIp51Q8byc2Qft+t9T2vUVy?=
 =?us-ascii?Q?8ZVnpCXtL1YIfPSUvAjn9v6oPpYF3Y3/sRVK+E88WtPY56KOD2lMGeTf/cgS?=
 =?us-ascii?Q?tRNnvNhoRMQYW/mB0frf6Ups5yyMnE5r663Rv607sl+wjJQbFH/Yjk9xEK1b?=
 =?us-ascii?Q?fqXMPphwqliDHzTpzKJ9dwzoysuWipWWAGV/Cw9bKUUyqeV08p+uS8Z9BelB?=
 =?us-ascii?Q?h98y7OnQSSRJEpL3EMbIAS286NhRgeA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d875e8d-37be-49a3-6a1a-08de68cd62d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 17:54:07.0566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvXb6kvIalZRcG2O72JNaPjRNXm38w3DFwo4tA9lSbLFPUiN6mymgEdPjp2u6LjF/HyCa3335jkNl7vYzxwZ1e+i0ewYmBQqgCt5bqjP8+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF085B02B26
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

On Tue, Feb 10, 2026 at 03:19:27PM +0100, Burakov, Anatoly wrote:
> On 2/10/2026 3:10 PM, Bruce Richardson wrote:
> > On Tue, Feb 10, 2026 at 01:48:20PM +0100, Burakov, Anatoly wrote:
> > > On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > > > Move all context descriptor handling to a single function, as with
> > > > the ice driver, and use the same function signature as that driver.
> > > > 
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com> ---
> > > 
> > > <snip>
> > > 
> > > > +static __rte_always_inline uint16_t +get_context_desc(uint64_t
> > > > ol_flags, const struct rte_mbuf *tx_pkt, +		 const
> > > > union ci_tx_offload *tx_offload, +		 const struct
> > > > ci_tx_queue *txq __rte_unused, +		 uint64_t *qw0,
> > > > uint64_t *qw1) +{ +	uint16_t cd_l2tag2 = 0; +	uint64_t
> > > > cd_type_cmd_tso_mss = I40E_TX_DESC_DTYPE_CONTEXT; +	uint32_t
> > > > cd_tunneling_params = 0; + +	if
> > > > (i40e_calc_context_desc(ol_flags) == 0) +		return 0; +
> > > > +	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) +
> > > > i40e_parse_tunneling_params(ol_flags, *tx_offload,
> > > > &cd_tunneling_params); + +	if (ol_flags &
> > > > RTE_MBUF_F_TX_TCP_SEG) { +		cd_type_cmd_tso_mss |=
> > > > i40e_set_tso_ctx(ol_flags, tx_pkt, *tx_offload); +	} else {
> > > > +#ifdef RTE_LIBRTE_IEEE1588 +		if (ol_flags &
> > > > RTE_MBUF_F_TX_IEEE1588_TMST) +			cd_type_cmd_tso_mss
> > > > |= +				((uint64_t)I40E_TX_CTX_DESC_TSYN <<
> > > > I40E_TXD_CTX_QW1_CMD_SHIFT); +#endif
> > > 
> > > I couldn't find any places where we define this, it appears to be
> > > some sort of legacy define, making this basically dead code?
> > > 
> > 
> > It is legacy, and does need to be fixed, but across all of DPDK I
> > think.  Testpmd, for example, has IEEE1588 ifdefs also.
> > 
> > However, for this patch, it's probably harmless enough to remove the
> > ifdef here and always allow this code path to execute.
> > 
> > /Bruce
> 
> Sure, but I would've preferred this to be a separate patch as it's
> semantically different from what you're doing here. Perhaps it can be
> fixed as one of the early patches in the series as "preparatory work" for
> this one.
> 

I don't think it belongs in this series at all, actually. The IEEE1588
define appears in multiple drivers, not just Intel ones, as well as testpmd
(as I previously said). However, if you think it's worth patching it out
just for i40e I can add the patch to do so to this set.

/Bruce
