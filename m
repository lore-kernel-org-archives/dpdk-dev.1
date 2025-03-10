Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332B3C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 17:00:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B3AC40270;
	Mon, 10 Mar 2025 18:00:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1A291400D7;
 Mon, 10 Mar 2025 18:00:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741626048; x=1773162048;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VNL+erxyiyi7Aixd6He6tsnp0JriM/9si/SgGv0Gqq0=;
 b=eW9SgmLAPBPVawnQ6LilIi3bI70LrZ5rHsHUhknt7qWOe1ImH4id0QQ9
 GUu7giHJCJLKgezi4gnnyxkoExfBv/NplWQ91Bh5Z0DCX29apfMf7o9wK
 BUk8ohMD0IWlIVVTHnMAvNuLMBhcnVQYb3HEb/f2veBkKmEEATV7qeKbV
 1MleHuIQRWXCjaIMhf14i5CrtScp8DhlQM5eUH1Q/VRZrYhnMtFHJMe1c
 WjClnPIRV+V8FTbIWkXRafcttwTfodJ7FoooPKz6WHwMdaCZoTvZmOZWX
 e5RoVra/klyLI8/Px4N/M1SljcHXAC2puUXsIhxX3FAYS3xyVKz8fgX+5 Q==;
X-CSE-ConnectionGUID: BzC+r9vzTDG9KqyKF9Hwtw==
X-CSE-MsgGUID: VENC7wHQRFyplsMbowgRNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42765131"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="42765131"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 10:00:47 -0700
X-CSE-ConnectionGUID: OhPLPThGTp2rbbYEgSIKjA==
X-CSE-MsgGUID: sbZwiToATKOACkIgNzjM5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="119882403"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 10:00:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 10:00:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 10:00:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 10:00:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikxs8ZyuRCt2Ltzop9lPIkTbRvQ3ZxDILsvS8k9k4KQYtq0+Wbx8ji3QdLFWC5/gCYV5xdhtRS66oITUZYsWXqniIw1Orp670FZqByT9O6u/x2lqWPYZ6OEx44NyeOQgWJpmwDmB0bcU0G4V4c43Iflu0EoyB85BRSqvspgRDdLjKVMvpKx66H0caDP+KN3xZ/tjPtwjIi0qTRiYLjJJplTCqnjOL0IfQ1jTop+javRAfGkvm6HjM+75ROvooa1uKcIw9xP2fViqfiOsJfFjDk3Si0+80x8AFaubpCCzaaFA5y7G/56h3jPhGv82mZqlS8EwH5mno+fnHim0BmoUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJ0314I35ZrL8QrxwvAt8SYmQh1WTSlYtoxqOjhzkWM=;
 b=RTIMppvoq1Qtp1ufWFzkLamyNU6g8wWUklZtDrALj9Uen4puPtHD9f7owh3f2KWhorp8KDZZVztrwzFViJo/XawZyno5iS8TY+svnrISWX3ZLqsR+Nh9Xs2ZE8RTsDz7bbQt3bKBHaLtn0Gt2qxBfj98Jhx75IC5enelbK4kTROdn9RYFDiFPbuH4DoZ/ls68p4SX7YQloGmNzWz9YpskmU76S+waRWsBAVsvR4o3e/N38LH07z3cZSbYJN3fyPsxdNhDI6Bg4EJGiZy4AOKfdcShYVaSZqQmUElwJcNdEf/7tVI9gkWFfeQulV272LtrFdG2k5Y+c3lP9MELLjuEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB7143.namprd11.prod.outlook.com (2603:10b6:510:22d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 17:00:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 17:00:39 +0000
Date: Mon, 10 Mar 2025 17:00:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Yang Ming <ming.1.yang@nokia-sbell.com>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Ian Stokes
 <ian.stokes@intel.com>, Qi Zhang <qi.z.zhang@intel.com>, Ke Zhang
 <ke1x.zhang@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/iavf: fix mbuf release bug for ARM Architecture
Message-ID: <Z88asW0oCAYnooci@bricha3-mobl1.ger.corp.intel.com>
References: <20250307054023.911-1-ming.1.yang@nokia-sbell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250307054023.911-1-ming.1.yang@nokia-sbell.com>
X-ClientProxiedBy: DUZP191CA0031.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf2c05b-4b04-4cfc-5c7a-08dd5ff515e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dgcoVjPQ+SBGG88tJgoUBKnIwkFEe0lH0tyoy/FWapn7XnenSjHcWEgNBQgu?=
 =?us-ascii?Q?DMbnwVF3JSsWHOc0oUDTWwdpZ+P0fbMDzW+eCau4XuBi6tpFpCchGwIjy6eI?=
 =?us-ascii?Q?RzC3T8g0FMuctGaMInNxB/lG7a/U6c7jBhSPcyNdDIqm7dD1k0b3xEBIVI74?=
 =?us-ascii?Q?z4mf/MxT9FA11xgMQbaU3VMUP8jlv5kiovizMJzKEOpCmM+lGA4x2HlJYzIN?=
 =?us-ascii?Q?ekaidyp3B/u29kYJwbcUXslI3ONlSGn4t0DKfIc6druhDEHD9BHIFDOHEODo?=
 =?us-ascii?Q?FNwFB9Urz9jDWFa4lJ6IquqPGpKpmmbTMdV+6ay3QAvR7P31N3+h9ru2ifIL?=
 =?us-ascii?Q?IDEA6rs3xHSQue/d/fgz/2uH+snY5MOTdOEbc4IfRE1dsTr8TTtGagW1wF4n?=
 =?us-ascii?Q?dhHJCh7p1JAypOcY7e0ukJdb3vYfZDkpwrnmmoAOgPL5Q2w0kOHZc2TEsiuh?=
 =?us-ascii?Q?ILHxHT/96ZIAjLQ0QsJREsY9pG58QIUZr0xtdxQHfnJfYqsH7rdZvV474tbU?=
 =?us-ascii?Q?4gJ5R3cKsMAhiMLkvva6T1BqWwbo3p+Apyvh+gtaggYKl7LgHErGOLxhubmv?=
 =?us-ascii?Q?CYwhrLGExuZVTtFomrqbq/2xajUPgQwGkL/Pz0BnM/iVJ9LjrT12SsQQxFOq?=
 =?us-ascii?Q?ZS2SpON0LAtIOEFUsv//mxG97l/3GMvi2wM8iVyyHd8hlvRKbLOBptUBzzmg?=
 =?us-ascii?Q?YI8qlK82mpEuTFOdEX1rPezUTGZOBaUrAaEEPdmMJhd+XgDbn3l6fE/DAaBd?=
 =?us-ascii?Q?Ie7vX6kqOHqpbVbJrMJD0rjyYShLUAQ7d6pK7Ti2riRaoK/4TFpr9ewEp8It?=
 =?us-ascii?Q?vde2cU0Yy8pO/2B64uqBarZnKPCaQYuC1JLWhgOi0CkLQ+mDTomUoqnHK1X8?=
 =?us-ascii?Q?9r1CQgKRcF8FgDgahe8+87w7dZchWLi3CSD4r/O6AYfS/SEuz8WUIhqhXQ0F?=
 =?us-ascii?Q?7XtusV7C1KcOEYkTe5d2HLb6vrofj/D4cmzUXtCOt9kkJ6U7APfcXWEUhr35?=
 =?us-ascii?Q?NaZvAtVOjpTnCviQmsEDdQkQpWUTMnh2M5fHDoAgcHCS0kRl5aa1NoBlmthF?=
 =?us-ascii?Q?oqFS2U/jm6VJpQFzSMBZQIsyaETM1vMBYhJLIkPQPyCNeXCVp36tivqlrqa/?=
 =?us-ascii?Q?w9P3Ti7uupbEn92Tf1/f/Pqa+EkNKNOd3NcRuty4ha57wdraRQWKHCUWuOm+?=
 =?us-ascii?Q?pHkzuNsTWy2k4qwfBMMjmYhMlBlc+luDFZlb4WYLC1EtQgKdz46a3N1+6O64?=
 =?us-ascii?Q?euHQyvXEjFQG0IbCnppnFpoX71LATkkOJuoNIniM9RuRP0R9HK0tnapONnMu?=
 =?us-ascii?Q?yY+QnjspJPE5/HxJmjnMcZaeDKir2liB+4MbbCGKofWBu2qea+G7Bg5juCpM?=
 =?us-ascii?Q?W6KtLvp55yq/emJRj7GmzGopvWbL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GS92K24/24LGQAF6hoaTFbi9s3T8cPSdw8jLliVrtIuysZ1xezo4D67lT6vI?=
 =?us-ascii?Q?lTQIWWu4UHIHxGSsAFT98yYf2+iBZqFZA8N3RzXMYLegXesft5vIVZDJSGWy?=
 =?us-ascii?Q?PraRott84slTt9giEHXut59ameAOYYgQV2OFmNhu7ey9ppUgvkyR3uBUoir/?=
 =?us-ascii?Q?ZgLlDK2oAefSdTvdfE5cOPq8PL34+hIxE1H5fSZAw83Unyp2VSEA8FE0TfRs?=
 =?us-ascii?Q?aT2yAff8fDF9z1klQ75TIGFVHVwqFMm0u/3Yft6yKW5pIT+BbNHDFvqkMevL?=
 =?us-ascii?Q?ygEBJYfe12ZoxYCpTbdvJ7/1KnRB85bdDs5lvAEt1v6WqFPaf37oaiw6M1Rd?=
 =?us-ascii?Q?+HNvMZcunTIZTIRTGi/wz5qKydSfL/9CrD/NgrvJ3+g5DdTvHXsOSmylbadZ?=
 =?us-ascii?Q?RPG1QAkY7FDmNplbLdCN+b6yegLXu0ihcBaHJ1mIvrwezWWDao2IF4D5GI+L?=
 =?us-ascii?Q?bLZ1t7T3Z1rS7UVr23FpZT7H7Hd5BfG97BUBCB2pXrx2D3eHEilSOpoo3NHt?=
 =?us-ascii?Q?uvnY0g2LY8Bav6kw6NItfyB4Q4S0+8t2qH8ginPgLN7eA+RK608igXv5phZ6?=
 =?us-ascii?Q?O8r9jANDzMbLsWQ2+NJ/D0nEKsKUd6BYlJQ9FSxTZUV6ersTusEg07ExZPN0?=
 =?us-ascii?Q?wCojXu9xzyUKlkz02o9bJ8mCT/COfPW0Q7E8Nq8wLjPrLx0N1mepDGD8uKZc?=
 =?us-ascii?Q?OCoJq/YfTJ0LgWINts4DdUdl/5csSKZzSfJ1Yd/Ci3oNnYpxiXDX5Es6f9Qn?=
 =?us-ascii?Q?8IWzGuD2dbtm4NCcfyjU+Xj9BwMZndY3gDuIaROO+adrAmyMt2SCYeG5SuDm?=
 =?us-ascii?Q?WPjWp0Ev8ZCaGG+0R0RKBgmnpJiPuCfR3AIRWC5mwbs3LRZAusuEMwMGZ8ik?=
 =?us-ascii?Q?nChCQOk1fCUXBgJdW6/RUBUHKer3BFGlo5Vo0Q3zWdwe5qmiDG/pL3foVj3J?=
 =?us-ascii?Q?U88hBPnLc9aekrXh7Z49TCmTwl34/EG0QtRSTrW674CCKsPZPL9ygMmpajfX?=
 =?us-ascii?Q?4KFVUE+pqo0OPr1YX8/p6CIDFtDJGCRtx9iJkeIrkQu4S5xerJkyPs2BhT8v?=
 =?us-ascii?Q?Ltj+Jx4kos1HT65kogGOBN5Md4DLOYxhPxuxgOQj8Ba57BG9Zi8YsRioSAmC?=
 =?us-ascii?Q?usrQ3e1t0MVl0m86I7UTj3jKe3W4Wtkymup3BgK331KiVNoBc8KnPooC9TrI?=
 =?us-ascii?Q?QuU6fq7yWcwAuO7zJ0YPMHCDTgfyqq3m66FwSpUb+nTvzhlEH6hrkkC0K+aE?=
 =?us-ascii?Q?8P/qffIpImy1qZYiFhSZ4RfTpN7wicDd3H8LE8W3bp0mr8Id8BnuSeK3LNCI?=
 =?us-ascii?Q?aA3qTFaJBJ+GOTMz2IwpfEkuWtT0dBPLKv8zo0/2WMIo9vpFiU/Cy1FiBg2Q?=
 =?us-ascii?Q?ornjMSdZLr1jYKeNV3bRl0f9ldOzrlzeFrUCmoRxpRPlZcrStTs4sV/MtM3k?=
 =?us-ascii?Q?4BfyXBvWuANwtU4caWA4+/wzoU6QKA6KyXtmLh0+3ETTno7SwBJgIKj+Lu10?=
 =?us-ascii?Q?4iOE3bIjSRojUw2fWCRSvdwztgS5kPYPY+0iEeatUbJohx04N+tE6ENHtr2G?=
 =?us-ascii?Q?HU7R7MkPWx+OByc1wSSxzK73igrn2Q7GrRgE9wwnjt6Q5no7fMsDgp6ryrD7?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf2c05b-4b04-4cfc-5c7a-08dd5ff515e6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 17:00:39.7835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQ+lcSE3PH/fGO+zjOi4WaQandT8AbIFB6S0iC63okiLI1VSwDR0cMH9nWPUhJ1rky7/7AnRewrLyZOZqVqPqFLykq59vDSatXHm1j1YSaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7143
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

On Fri, Mar 07, 2025 at 01:40:22PM +0800, Yang Ming wrote:
> This patch addresses a bug related to mbuf release in the ARM
> architecture. The previous patch resolved the mbuf release issue
> in a multi-process environment but was only applicable to the
> x86 architecture, leaving ARM unaddressed.
> This patch extends the fix to include the ARM architecture,
> ensuring consistent behavior across both x86 and ARM platforms.
> 
> Fixes: fced83c1229e ("net/iavf: fix mbuf release in multi-process")
> Cc: ke1x.zhang@intel.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx.c          | 3 +++
>  drivers/net/intel/iavf/iavf_rxtx.h          | 2 ++
>  drivers/net/intel/iavf/iavf_rxtx_vec_neon.c | 8 ++------
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
