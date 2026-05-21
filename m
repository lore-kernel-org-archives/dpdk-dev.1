Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8CCCD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 15:44:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B052402A2;
	Thu, 21 May 2026 17:44:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id B3A2D402A2
 for <dev@dpdk.org>; Thu, 21 May 2026 17:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779378291; x=1810914291;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=UzNC5SkV6yrOrCDU4Uv3klx0ikfaFqeDTFGoFuqlUFc=;
 b=GpluodzsCsXEA9aSUsJdeQvJ3FvJxWhuqvLv8xce71k6IcsAGCnIy769
 fFFEjCSh3glcTvwDmYx2Remal1iNUuAaY8+wP2TMf4FBrT29MZCYsEihh
 8SYHbAPqtalGjzh8V3RYxCMbkGmR1I6vcbJemzTFq9qGXsMI4lL/WGiif
 R+9LkyG1I8TnvLLb8lCZs7K/TKEuH7vln/t4hAWEmjNjORh7uewMDqJoZ
 gtDtfP1uvkE8yQSV4Ej0q6qQB3GOzNtbByuQ9fEnVK9DmHmlXGPyJFfOQ
 V8b/FL/bE5WciQQ0MTjuNbgOnPXIodTipmtkkL7BMl1imelGjYyrgUEku g==;
X-CSE-ConnectionGUID: p8u1AXU2QfGZgSE80VFFew==
X-CSE-MsgGUID: Mgz1WAIKTO6RoEdZYO6Qnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="90990566"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="90990566"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 08:44:50 -0700
X-CSE-ConnectionGUID: YlqAyhSHSqu9xo2fWtYzEQ==
X-CSE-MsgGUID: PzLhbf6DTzOadqi+wD0s9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="245599383"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 08:44:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 08:44:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 08:44:48 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 08:44:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjoUPfXmwcpTdlJr4ZNO9SVzUozhfi/J05oIY/UTgABtnahL8/bUwAKM+8iBxHW24AJKzi8Ve7TC2nVVe7+DpwMFUpDa9kyQp6k43eGeI6KbChUb4Gyg1BRlo/JEdUgaXBZIoIwSADMvIopSCfWXHQlMPbeliX4VoUvEb/+oRkmckBazO+kppHBEobBidNm/r4KJcsqcEPfHDNRHeuAR+ZmdcR89mXWByYV64APHvBhxuErgcolqJ3sGJ0jVEcULMNNNYFxLtT+/0wkDBIor8aaZQA1PzHQSCyzHG0WKM+cyoe6L1goRDEBh/5ltjWaMXz6D8tIDhRIThQplRAW1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBTvemjMn3EmUEbprwoybjcAxaOd1LUhZv0c9gGKxXA=;
 b=jTyPKBCVXMJWf+x6763guGWrjtxZ+38OU2c1YG0khp/DK1jf4yQ0gf86iD06IDO6ZzwRMQJnasgvlBYMKrbn/wLDjF4BgsXafW58aqrbUaERbVYvMK0wl76NjUWzg0AwIeEeVKBqlJNCM1pMql80raqEX8RIXJQk3M6lfjizHqsHpbUWoop6LkFB6dYC+vETeH+70U+YyJSqqeINesUiLzk8iuZR12mBoB4Zr3Gneg440BBcddLQVpYfRi/BPq5FVacgk16pH/YACba2FD1McRt1EMlvJsjxuQbWW8tjwJ/ORo0xT0VWBrFk/mh/X4cp53gJsOHe6cIh836FypN0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 15:44:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 15:44:45 +0000
Date: Thu, 21 May 2026 16:44:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>, fengchengwen
 <fengchengwen@huawei.com>, <thomas@monjalon.net>, <dev@dpdk.org>,
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 2/2] ethdev: add telemetry endpoint for list names
Message-ID: <ag8oZodLjw0cp5Kf@bricha3-mobl1.ger.corp.intel.com>
References: <20260520035641.50555-1-fengchengwen@huawei.com>
 <20260520093804.29102-1-fengchengwen@huawei.com>
 <20260520093804.29102-3-fengchengwen@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65887@smartserver.smartshare.dk>
 <ag3ME5EBdDSAhaW8@bricha3-mobl1.ger.corp.intel.com>
 <cd4f1bcd-3d66-4ffe-91d7-7ac1fdfe8c2e@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6588F@smartserver.smartshare.dk>
 <20260521073716.3a788175@phoenix.local>
 <ag8jF4E2RnQcFrYu@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag8jF4E2RnQcFrYu@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB3PR06CA0022.eurprd06.prod.outlook.com (2603:10a6:8:1::35)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 8328ac9b-9f5b-4279-5b66-08deb74fe1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|4143699003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: iEq1RL29VWFX3INMIbOPq+rCmFCg+jkXDRAehrSkb12iekMX8BFKyIqZd0UX13CocZSfM2PjzvCYz+GuM9TBRySoM/0d3tr2fsKqZmC7STJGJ+Tc5dbe7yt1kPgHCz/qTV2JwYhSnaxpkjxDhlV2gKrtA+XlRfODEsx/z091a5Zm9PQb6HkHF+vDhgXwXYzkJXa/j2+54fnZ5HjnucgvTDZjs/9LusyqeicT+KpPA9q4Icec9TiL+tdljaqC5lOG+XJahgMH+8qApfX2VuJQKEJpsBF9LELPA06qAKuw05FKBvckZu4q9DxsKO2Wb0pt+sFesN9qFGhOo7na1bPoS1AF94PmrDJyfyMXOt5IkYBg1qOwHGnnnLo7CxLbNdvZi/W1dGuPW/L1GNPpeyaQzbVAEj1MsiQIk9fAiXTVuvfd6X8wG+8RX7lB9I4qoFvOhGf4lZi8CSlN4a9lXeR3aGHZzPog4lRPD9XgDtHFzoipbQukrtQopVieLO+nyxD0zXNaFJyfs1iqqDbJLlLBY22EJb37gQCWactPemUEhdkHNekItfZtMq+Ds4qlL1A9T0ztkpzXPRRZwYAFsfkOjDsxxbs7UxCkuzl9nFizhjxHftdyi6SMzQconI4uXF6KF+x5S4vJmpdodnIz/4ShTjm063P2dv7gzPRpTD4ZU3i9vvBpE7V7yeb0JpRlxvbOIb3GKPCEVt/vQhS+X1l8hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(4143699003)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mK4NUq1pcazrXSIKyjzrB2yJWsa8ODqRJ3nz0Es3SIy6xzxikbLDpsHVzT?=
 =?iso-8859-1?Q?ZWB9nz53hgrbCXlTTEAqa59PViIxg+CS87koTkFAZC6BxK7x4uIPonBfve?=
 =?iso-8859-1?Q?sIkDyaNak68uyrSRDd9cXX9zZLpCd8uw7LGkgClnZdfP2Tr41QV2azc74i?=
 =?iso-8859-1?Q?FAFcqHPMVNnoIHYz796bIKQsumUnhDUHAFOUUkrYW/FOL8R+t8R/sxI1U4?=
 =?iso-8859-1?Q?LiY/C+YQYVkf1yKPSyveOBwlwgAEp4tFqKGb73F4wlcvlRSDBBZDP3apvV?=
 =?iso-8859-1?Q?EzGFonft3p6zQP9KqFV+TFTpHd27a1lzHY3Z1IB3+6eNdyupolJclSCVB4?=
 =?iso-8859-1?Q?2Ghi291fZSPQkoS16P3FQjPT4ROkxP85nWkN1wAcMJMSCIJC0ASwP5JYT3?=
 =?iso-8859-1?Q?8yazXUvd8dvlk8mq/ij9yBMz8UCnu72ntnMa81l5UsGxLa8PHJf8vkuzLe?=
 =?iso-8859-1?Q?jvpUkzixNv/yUBPsnF60C1l7zUJSTQDv3NxOnPJc41xbWd7Ti9BPGarmx7?=
 =?iso-8859-1?Q?ZBa7tHadCc5CLxe+K86tFylHvy4w2CgbEXiuecK6BjQMW3yERDGU7+8I9U?=
 =?iso-8859-1?Q?CyV3dwPBf/osm0G5ng5LYnHYAaJOFVCniL1pu8+8J23AaDZ92O0S79xWrr?=
 =?iso-8859-1?Q?SghaWpd0Yp4wgyRyApLK+ujuas8813mJHauL8ZUMKnKlRVIJ1tUV8mXxW+?=
 =?iso-8859-1?Q?ToxpqHQ9aCkIdZXiDGBsTkRpNfFNQ45THk0x0mESlMNiGxsmm6ZerY2uHt?=
 =?iso-8859-1?Q?og32p3OzA5lxEABY/opKE2sBNtviEL1BBeQ34SKKFzcLK7ibm+3d6qdK0M?=
 =?iso-8859-1?Q?+WM0eoDjNdsq731nKjdGGz/bvdZhNf6AZy3IE6w+NJvDHKnEdJT828ojd1?=
 =?iso-8859-1?Q?DSlPOpoA+cxcWNquVCFhw2ktFH5wzr6uwsPLVMLp1wvd6MoaOaqTAJMsOn?=
 =?iso-8859-1?Q?e8r1n/CfP7mUuRWk+snvvf5wtweakPhIE+r+4lTlAnFpIElbvNqsqPa1op?=
 =?iso-8859-1?Q?Z8TzD8UQ/CBKDVDRNBrFsgrBlWuIEp9ZdNb8ledDNDEiuOaZ9F5QfwOKr6?=
 =?iso-8859-1?Q?MlCz/pLs8BcCueq/9b/u84vArJFKNz0nfiz282Qazb5p7pr4IkF8bqGrtx?=
 =?iso-8859-1?Q?B512/wQHTX6W0mh+QoSSo1tOwAlUeGtRQqw60KZli9Dx+STa3LCWBxXzYU?=
 =?iso-8859-1?Q?WunECl3kbdZuKeaF7hj9hZhBoBTd3sNyZBOLbYBYz6Q2urRhHdKOUJpLiu?=
 =?iso-8859-1?Q?3yWJ4KwBYkWJgjHpyRmTHcGqgkm6FO7Zc+4Bm3zj1DM+IcAO3NAEUfh2ay?=
 =?iso-8859-1?Q?Cjl8aSUVB8EDzZMPOUCDM08Kry4+UU2T5jWyNpstmz725VoMJPykCrwaUF?=
 =?iso-8859-1?Q?ZEs9dbSbFM2DCszBIwFapwPIOJdbt1awP2SXic8cS4nZN/xn+80M247X6o?=
 =?iso-8859-1?Q?6amd82Qvu822UBFjM6XrJrOgMSuUK3jjroTn9f5bq/MYhqk7zlwgVepqet?=
 =?iso-8859-1?Q?vu+/TsB0LktXKfsnQ5b+fW/tYeOl2l46aNjVjHYZXPBty8gNxHNF5durdH?=
 =?iso-8859-1?Q?xd4N4+8374ns2XIpanUa95LkBQPD6NDIFvE4eh/WYKe3fwOBAfJvtooRAr?=
 =?iso-8859-1?Q?vEUNBPj5biusD52c/f7Ra7HcgPYgaGkQfXu9dQ4+3vDpU7lRu9+elVsNQb?=
 =?iso-8859-1?Q?mlEe1YFSVlARhJmejC9bYNOW0YF7F+8ze71sK/hRkR09IjZsWpsKugBGVX?=
 =?iso-8859-1?Q?1tc6cHfhuIDGtxwP5s7fUXEKWsGYXkuhNrSIEg9OxRIpPFkmBweINaGMDw?=
 =?iso-8859-1?Q?uOHJ6T73wgVMyCdEfOMNFTliOAMn3/Q=3D?=
X-Exchange-RoutingPolicyChecked: fjQvx691GHY/ThlsoqreqlNT5BqUiY+UrLjdiaXQopVTFMvfNxVuQN7yv4nG8ofoOjwbDthoNwv2MqiaB6zQg30fFKnWNe7d28idrPaojorlIMiJWpty2ySXDbEmnjcJjujfCvXc//I5Z8BhR8xav/e98jintbKlTMT76Q+XDHAjSV+BEw8facFZ4BISxu7Kxw5eNG0v8UGwY8OIgPWTpnGYwyoDVkdzqLPJG/Zo/E2TNjZKZsbKDGeQVEpjI44cS7OG2jE40tMuEw4TOw3FjInNaHaLMqhFPb4imnsaST5RlmZgvsgnHbjglsWKTalt4C3WEFBpGAaDV3YMx/4O7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8328ac9b-9f5b-4279-5b66-08deb74fe1c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:44:45.3326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Axc2ZJs/7WdvoX7rH40P39/j/4jD6fLKcne04DwNSch8udbDdug5pEeEvD4iy3FjHS91Gzch/buonc0Y9ZRUJJd164aEmFciUvFfS12YCK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
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

On Thu, May 21, 2026 at 04:21:59PM +0100, Bruce Richardson wrote:
> On Thu, May 21, 2026 at 07:37:16AM -0700, Stephen Hemminger wrote:
> > On Thu, 21 May 2026 14:40:47 +0200 Morten Brørup
> > <mb@smartsharesystems.com> wrote:
> > 
> > > > From: fengchengwen [mailto:fengchengwen@huawei.com] Sent: Thursday,
> > > > 21 May 2026 14.25
> > > > 
> > > > Thanks for the feedback.
> > > > 
> > > > I intend to keep the current dict format. This concise ID-name
> > > > mapping is quite helpful and easy to read especially when there are
> > > > massive ports, which is exactly the main purpose why I submitted
> > > > this patch.
> > > > 
> > > > In my opinion, adopting OData-style query would require
> > > > architecture- level refactoring of telemetry framework, which is
> > > > way too heavy for this simple requirement.  
> > > 
> > > Agree.  Refactoring the telemetry framework is different task, not
> > > related to this patch.
> > > 
> > > > For complex query demands, we can implement them by extending the
> > > > upper-layer Python telemetry script instead.
> > > > 
> > > > So I suggest we keep this simple form here.  
> > > 
> > > If it is generally acceptable for DPDK telemetry that a request for a
> > > list does not return a list type, but returns an object type with
> > > "index": "value" fields instead, then Series-acked-by: Morten Brørup
> > > <mb@smartsharesystems.com>
> > 
> > It is necessary since port list may have holes due to hotplug or the
> > ownership API.  It would be good to have a more complete query function
> > that returns more about each ethdev.  I wouldn't worry about the size
> > of the response. This is JSON and it is meant to be read by scripts not
> > directly by humans.
> 
> That's where I think we have a difference - if the output is meant to be
> read by scripts, we should not need extra commands like this, since the
> information is already available via existing commands. The only
> compelling reason that I can see for adding a new command to return a set
> of ethdev names is for human interactive use.
> 
> Personally, I think the output should be just used by other scripts, but
> it does appear that this quick-and-dirty telemetry script is being used
> extensively for human interactive querying. Therefore, I'm working on
> extending the script to make it more useful for such cases. I'd prefer to
> add the extra smarts into the script rather than seeing a proliferation
> of endpoints providing the same data in different formats.
>
Here [1] is my proposed generalised solution, quickly prototyped with copilot,
composed of two parts: firstly, support for querying values across a range
of ports using a foreach command, and then secondly, support for aliases to
make the use of those foreach commands easier on the user. It's not
intended as a mergable set of patches as-is, but rather to demonstrate how
we might be able to come up with a more general solution (that keeps to the
DRY principle) entirely within the python script rather than extending the
C code.

/Bruce

[1] https://patches.dpdk.org/project/dpdk/list/?series=38197 
