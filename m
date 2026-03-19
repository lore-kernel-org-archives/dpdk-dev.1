Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03D91075289
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 09:41:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDB144025D;
	Thu, 19 Mar 2026 10:41:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id EAD424013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 10:40:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773913261; x=1805449261;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=6cK+BiA9zpklO2mJ9LQo22ijhu62Mu62G7lcAbnCmB8=;
 b=N2qUVx81/k41HypL3hinEAYQbWdRBSRdmw08I9jll+kW3xWy5omtfGCZ
 gYg9oZ9wSMgal7Bwa4XdwN8cXqLMa+W7QJC8hUeX0QjsmgZ8BrDDq0YRb
 5rxxXx0qgh9HRgGITATWwIzZtKp0aI0mxoeA565veHc8Rzjp5SY53wmVj
 rRejulQ0EaNyHvdKy776pw0FW5sjSkAMRnH+l96aoMlrNcHD1RefemiW0
 PvHgXd9IHbXH8kCKx0tm/IFNMaB8NCw8/1QrVPN4mh8fr8UcZLtUBgKzP
 Qe27/wzpHUCJf0vrpxkTGs3sJEgENe6HZ0J01fd+/e4h+lDT5omHxBlVI w==;
X-CSE-ConnectionGUID: CQ2cBuiCTZ+RIoQoRqWl9w==
X-CSE-MsgGUID: x6nEXaO0TECNXJs0nFjFTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="86459369"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="86459369"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 02:40:59 -0700
X-CSE-ConnectionGUID: aweLGT8mSNCgmhBnK9PEwg==
X-CSE-MsgGUID: szsIWHr/TqW0EpFlBA7jaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="218392050"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 02:40:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 02:40:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 02:40:57 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 02:40:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naJANzOr3iDpISCUOlHdH2r4AHutYXCGNV8KQjEXgYQ013GFDY0Z4QvzniU2PULsiBr87qZDEDqxwPW00XhRj62bmdQrKo3LLZZeBSXeniZszG/92CiomleE28b61KQa4xI+AuVOSDMegUvmKrXksbA34WyMGh/KTv3Nu1/zQHvxP2kRaR+88Fja7AN7oDuuC/2mwT6j9/7cT1Hw78KvYTFbV5BCsxzn08CgEsNkPQM0DhezqyCu9wLfbHKP/5L9QJ0E3j+a0vfpUgv91Xj36gN1fU8AMHjaqr9xMyUltafw7qlVj+S7LFS112WFZGQbho16sEkTN34cqpbNdXIRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCC38zZk7isllu+ZMr/qQdAB9QlBHv1fys+DCN9fOUA=;
 b=MDZu+zClS6tqSh4UWkPNfcPlFBeoxQXb3VLhSu7feAICBvHSsFVNWeAGr1Rhw3hE/I0OQ87vo8tyjN/jjyshFpZHea8BEo0RjUxY5vYDqYYxabs0iLQkxXpSckY1i3NO9BeSxBcrNmsyblG4gkOhvdoAY6wKzA2sg0c3Ly/REX3TKgH2U9hGFvJqNEHSD3Iai9EdygXnDaIgoG+UxdcJ9pgsp6a72QVPiszOuO1Ips0yYtPduPru8WCJahqB46lQpryK0j3yA1SOjD1vSlQdFqxXsv1RASSK0Cir9wMGUKK+DpFpJUiCV8his5LH4ZCW+0YHQAsJM78ByRrK6QL43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 09:40:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 09:40:53 +0000
Date: Thu, 19 Mar 2026 09:40:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] doc: remove obsolete mempool creation advice
Message-ID: <abvEoELb6QIAHBnW@bricha3-mobl1.ger.corp.intel.com>
References: <20260319091300.652853-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319091300.652853-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DU6P191CA0039.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL1PR11MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: 761e1055-402d-4fb0-5a2a-08de859b9cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: bJl8d/X5CQmuZ2tBtRdSsMKBqIdldNbJXLm+fQyIT0Ij6NTlnImk8QMErYNpfvcmjlgZbDNNeMASuJP4UF770bCaARdJjRy31+DVs7Lij34WYBqta2doNT2iBj2rBld8uOwm/26HxHd2aTnqZ5QFMLKTlABLEvx5F+I5B0BNwIAd7W0TMAUh+6/jqImn/qjXGFUXrhi9zOtQMCp8RdRB7OaLasGkMCsj4DVVbsue0qm//JHE4lCjXaiSLhVBlL9JmhhnEzHlDIrA/r0XOahsbB/BFilF+cUuYzYMZbej3AI8LPHrKmuBKnl2XG6QliwGidXDVFJquDbdfWIDgDUdfEVrK0tFd7OIkDYirjj4BFvOTzxeGRlWYHifZ4U/vga4zIMwgwCV1yM4Z44Ul4GigZvEtVEN7a6wJvpV6+Rn5g5VCVfb9VLJi7werrXrHv2c4j2CNXizU3MiGeV3XOSS0+hhU6uoJLdl6sHfQESagPfGV2hvIUyWCDaIyNr6RCLm+/dnR3bTsWMiHtTD4gG6ruOU2+SwSlnuPEq2gzTf0xrDj5OK5B7WEo5BuUqvRdbfTf6CgsB/BG6HN8Cv55kCwBla7ZKTYx5BZFTB7kDQwIDXVF18M56pee8D5tssBeIdZ48E+O6nW2e5dm5tU019VtXhoAvy1N26bLL5aYQxPrqCFlJiEPTEDGg0fFDIP81snhRhLObizjNQivBMsMmSq3m8+lMaI8756Xz5/D/HbVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?R5yxTVmV+Ve0TRPggX6OraaYYwU6SbcLnnDVOwe6NSA2cFU1rI/9b/eIJ0?=
 =?iso-8859-1?Q?PaG0XJFHLTFHr5GBE8+0UWXRR9EmSrRCMDZXxQ0SjJn0lNsv0JCKicYKM1?=
 =?iso-8859-1?Q?Jy+q+ni7o8Hy4wsXweaHOIF3/KBW0pRLr3YrIQ756u5dRFGgQkKaQFmqzO?=
 =?iso-8859-1?Q?nvNoCR22Jq+4U3FSirqX6OAlp0vYWgpCb3Qsc+4KQREnwuc3GLDfQpi8uJ?=
 =?iso-8859-1?Q?Gkn9FTav/HEvjL0XYq+6uAKa7fS9Fw/SrX2ex6ruF+zqEumVPaT6+Vxfmc?=
 =?iso-8859-1?Q?er5t6IM8Ro/5KTgbgu8ky3c0GqhchtcxP7fnGQ+QWF97A1ezWSSGyrtAHi?=
 =?iso-8859-1?Q?O4bKcp2mSC8IiXOq5VLqugdw0G3hGWQVj0cB6B0fk7L+66SphgNsjwkILy?=
 =?iso-8859-1?Q?/WfXwgdmF1Kp/6B/0XZFFhkRpFvA/BRQZyT7yVH8nTNXckqIxy4wtk1C7/?=
 =?iso-8859-1?Q?4dzcrBVwiGrDobnkH7OwAtDlD9SVP1MgaZebo127qfifux0GyuIqHafbPY?=
 =?iso-8859-1?Q?by09+zDPG/P/9g4BAf1GQlOaGdZn2jDaqiFQSnPszWf9yu4x8N901JY7WT?=
 =?iso-8859-1?Q?zrSFF20O1ARK2WEZSeW0sjUI3o2ob2i5tNkYktcWRKSQCmvEyKnPKcTQ1h?=
 =?iso-8859-1?Q?C4ycKPMmICueJ/xwRpbbRed1fdFg0uNueKTEzcaMgIeg52UpZHvcIBRfkw?=
 =?iso-8859-1?Q?5StUGruZCg8RsSrPcu4EqZPQFCLh73NXoUphckvjLAWAdB9ahuYqyGEtK/?=
 =?iso-8859-1?Q?jprJR2Q0OMlOoRIb/nUazrYjSzqBIfxbzaTuWlnSGeDWcNRsBFBZhanx3y?=
 =?iso-8859-1?Q?bOl950XUUpQzXX22Eanr9ZQUrIsmwHHxm1uv/oEvBY9pPwj87ffiHAJqHH?=
 =?iso-8859-1?Q?Hc2XMT4LLJb8K8sqR+2vc8anHF6Xqe83mXNE8ZOOeyUCBYFC4WJGlTZQ7n?=
 =?iso-8859-1?Q?rB8S4NRMadPOy69UbX/jbE3hWuYf0YlzKNWjr1M/wT5XyKAPSghOAp07EG?=
 =?iso-8859-1?Q?c11ZKiSc/mSRjBDBoxR0pB+A0tdaaeWvXlFjplWLykl7vNZbt8JBSPRHrC?=
 =?iso-8859-1?Q?yVRpwRx6qKXslzS6EZkX2eiNFnzbgtJpHfFbv97pmceBfRzsvxJczOdzqi?=
 =?iso-8859-1?Q?d+N9CLrTezYK1WvKtA7jha3WzXH7Kyh3tMuz8y0AD8RAFBu+rZ2zN3haxk?=
 =?iso-8859-1?Q?v0zvx5gXV/wxfKv1NScr0vTBn6bTGe0cmYzcXAQgA2s6c1ASfD02n38ifL?=
 =?iso-8859-1?Q?kUh/jDrKWSE9/bKlETMJd0nS925UKCkFhK3tTFXPZUSzG5mMPET5s/rD2z?=
 =?iso-8859-1?Q?jvnPgH3pxBi7lgqt836iJH32QHnwPJXJWfhX4SwvlwNqSlSiI2DOlapzLD?=
 =?iso-8859-1?Q?US6dUB2yGQuFQYrC0/iSv6iRvxzswshYFuk7ZU3YYPwom2PaaR+JOBT/pX?=
 =?iso-8859-1?Q?0DHKOVdodOA11RNOOk2w15Ak201k3gqpBplRvWK4katQ6yXiltM4u+77Vm?=
 =?iso-8859-1?Q?q/q6OVpSUINRfXdgGOhMWXBgOwB4/rGM/eDpI2u4LHnjcYm95S4OVPMgyS?=
 =?iso-8859-1?Q?Mz8BNYWkMs064iFLSQoa+YFA5Wdq6Nn3sQvPd9LdF9iA2Vy1nzIo+y90ga?=
 =?iso-8859-1?Q?FtDQBB48lSI3DVAWeykxn4UrRLh1Z6YV3+nZEyPRehCgZLZ15fLs1kjYfM?=
 =?iso-8859-1?Q?FAU8U+guxcj5UWIvDOoB6JUOV+wRDts0+8avxl1E9fu9VynlpL2gC++6S3?=
 =?iso-8859-1?Q?fqOUSGqHn5NK8E5X26OZckdfACvEjgD3A2BVK7foZyjVKJbLvY5ZYrZIAE?=
 =?iso-8859-1?Q?vokdtL24xUm93EuPfbR08P4qe1FpRGA=3D?=
X-Exchange-RoutingPolicyChecked: oAQO+xsmFN0GUp3Ufyoc2eQGTKmdPP8Gg7ngV0ynCtgOujfttOhmt2Ksix4b72PuGwqFROY3iBzDMiWDjIikbrMutgxVW86wbTcxd3Y1rsYFExVmF1vHSSNPtt5pjce9kE8fMyful+uwYrTWkKAjc+dIx8o+Ej04mM+3OCaHnOVkMKjmS3uMNApHboz36pq9kRRZx25tl/RBUiFp0lxvoMmbNi+1cwm6/kPM3xocNwPkOpX14lH3Uca/TOyen9MH4FT+ypbRMmBmcYDd9tGiOhV9yQCeuu+dJBcJ7IC+3ltowGf0apW9c6KU87CbWiltYooN4dkLQOfC2KcU0Nr6+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 761e1055-402d-4fb0-5a2a-08de859b9cbe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 09:40:53.1354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nj9RpI1i1XKTd6Oxx4p7E9fIEa7EDCGyzwmUefXwRjAbQXm4XKnY6hlVp7MX7rkF3OdErUDnqQdiuTzGu08H65aBQOTJmh0Vn+uF/89LW3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
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

On Thu, Mar 19, 2026 at 09:13:00AM +0000, Morten Brørup wrote:
> The descriptions for the mempool creation functions contained advice for
> choosing the optimum (in terms of memory usage) number of elements and
> cache size.
> The advice was based on implementation details, which was changed long
> ago, making the advice completely irrelevant.
> 

The comment is still correct in most cases, since the default backing
storage remains an rte_ring. If passing a power-of-2 size to mempool create
one will get a backing rte_ring store which is twice as large as requested,
leading to lots of ring slots being wasted. For example, for a pool with
16k elements, the actual ring size allocated will be 32k, leading to
wasting 128k of RAM, and also potentially cache too. The latter will occur
because of the nature of the ring to iterate through all mempool/ring
entries, meaning that even if only 16k of the 32k slots will ever be used,
all 32k slots will be passed through the cpu cache if it works on the
mempool directly and not just from the per-core cache.

On the other hand, I'd be in favour of removing this text if we switched
the default mempool in DPDK to being stack-based. While the stack may not
be lock-free like the ring, with per-lcore caches the number of accesses to
the stack should be small, and it gives much better cache utilization
overall - especially in cases where buffers are allocated on one core and
freed on a different one! Even in cases where we are not transferring
between cores, in a single-core case we still will get better reuse of
"hot" buffers than in an rte_ring-backed case.

/Bruce

