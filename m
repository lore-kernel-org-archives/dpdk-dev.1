Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9087DE98FD2
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 09:48:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BADBA402D3;
	Thu,  9 Apr 2026 11:48:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id C93F74028F
 for <dev@dpdk.org>; Thu,  9 Apr 2026 11:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775728097; x=1807264097;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zRhNGbxL4VF8zH5gdTGk98UvkV+iwoMh4xR156fczXE=;
 b=UR8dxwcMwQ3VZxJWSSEegh+hUZyFqQJeH/7ev4F0eF9zxPM6NEY7bDuj
 b5t+I5829qqSkgi04ALtrxx6whVpbyj90Fskii5lINr5uU7Q/+SM1X3Uj
 SP+tQvkW/iOy7vE1oWWfraacN/bkOqKv3dh/a0poewbKxpzU7Pwj1KoM3
 ERvWM2PUFFaSpKftHocwoBiumgZJRjN+FpXOlZ6QIVLLG1BYMFcWILtMa
 sJWrOHs7dqEu1ltXg2ly4V+K5/fTdGTDZOs4NCQZncxZ9C1KXlqTxuxjh
 zzAU+RvHunJbjvkBAGLphUNiBsXXFYd/9ZNiTx1UQGTSIkH7z3qJ1NNQG g==;
X-CSE-ConnectionGUID: 3MvIBkNFSgesSu0vk1FXuw==
X-CSE-MsgGUID: DB7N99wtT5aV5sqymoX+7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="94117884"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="94117884"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 02:48:14 -0700
X-CSE-ConnectionGUID: PDkUmdocR0ea1ZZNwo8fYg==
X-CSE-MsgGUID: UviS/wW+Q+qoAHc2lx/M3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="233619992"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 02:48:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 02:48:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 02:48:13 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 02:48:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoV2omTXEfVG52FYeKy84YQnlSvJEcLCJcQ8uwuDEoYDGh9hnF41ap3EnKaWtVcIn1ErB7k//1TvA5tUXT/tmxajXXhqXHmiKh3ZGv1IhR4CX00+R+G7Eem0R+752xTmIcTzSIOTZgIyCRQNkK/FQ89Riv90gvk9dtmjrgFNW7kderJgNhK6HMOIVKy2LBQi3XvKV4LsP1vK9O8qPOzjS9AVc0FcMeOWsFNW7pYkAuMcxMNF+mnM1FJOV2YkCTA/isM2EprAK5mh97pigl+8RTjgWNf/kr3S/9UAHLAoUTPwcAtM0X8R7kEjI8y0kCbLcoYYes7Ul1S7TQeAeKZ9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4kxC61TuEiF3NcnZF5j11dkDjvF8BuZo434OgSMzw8=;
 b=Nh16g3flVgx9WFKXac0Mrl4Wnr2eJsPaxm6IwdaYkxS45yB1dHh1JQvcku4gYgY8cDA66bQFNdJloK46FJIkRMZH5Dj1TuJVq8Uxb1H5BOZ9kXdfGgYZL818TSoUIOfiE9wPkonAKpRmeGToOgqLQmpHJd7pFiYO3tW41NCX9IONVMMwmZb9nn0V1VOx6RmJeyfFgNpbUBHkvU9v1h/MfTqbuHLr2fsrS9AVabYawZRB1xA4nVpPAdbyQKKGyVZ2QJyZO/8YO+CggmHWLq5CWCdTi5lPwtO7e749eZzjbXyGBoGLdoF4kTbHeWVY/dMN5meSXMHwZLUvyZZj03cakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN0PR11MB6159.namprd11.prod.outlook.com (2603:10b6:208:3c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 09:48:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 09:48:11 +0000
Date: Thu, 9 Apr 2026 10:48:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sushmita Hoskeri <sushmita.hoskeri@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <atul.patel@intel.com>
Subject: Re: [PATCH v2] net/cpfl: add LEM block support in CPFL PMD
Message-ID: <add11ket672X75wJ@bricha3-mobl1.ger.corp.intel.com>
References: <20260217012153.36545-1-sushmita.hoskeri@intel.com>
 <20260409015121.2841143-1-sushmita.hoskeri@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260409015121.2841143-1-sushmita.hoskeri@intel.com>
X-ClientProxiedBy: DUZPR01CA0226.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN0PR11MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 89afc115-b0f5-457d-4e30-08de961d1c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: RBghx3nkFyQ7ya156IA78J4bfKGXRMYpOVMX+pXL3weiwZSF4b+SpKmbW5JZRCsU63xK98uK2v3JCqfTX4mh7NVb7aMmaXnjRTuFB26SeB6x9oPb+df6iSlJlbWgqUe6DSo1iKvAIzbPvZ7WcfNdByGiOBf4zCRXpWh0tI+61ZoNbgTpVuCtzhtwODHug2bX7k9f+WCXChp+JHIAoWLDJik+K+N/3p74ZEwgCB7HiWCKEEw4j9aevFlFYqOfUx2vjGm46/85i9LB5QomBVzbgDRWhNid23mlgYsAmQE4YX7IwVY55WsyE1rnKVzLlDDiyoJMVxeqND0zmbF/JkRdTPH9JXRiZHTF4oix5aJlWwNfVWpogTywf8RPLtHo6f38xvx6s0WgLGmuUoo9ztduk6ohlK418GuWr1srEMHTUhssld19pImPQLMw1yUI1UfaNaeHR+gMwa6gTvLeG8cgv8MVpS+NZU/0V6waAUd07WlXGmuagkiw+FSIeqYsgLmAphwZP87WN0i6ACf0xVhxSqRnBbNk56Zw6bAKOnPoyCPVr8wUUzXasVympszIOoGPDJ+G0gPOd7rhn2lv8nrtIsUoqTyw2tDIWLIrE+ArIavNf4JK/U8hBJ+k5Pa0HjtoOp0Ow/b2QWntjbPqSgJW/q/sUUmcMrnhFrF2X8TziurGH8Ca/j1ejxHbVxvJf0K0212fyAMuwHqW2sxCAYGpmAauwDG/Qv6iqyM0Bf3tHK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fa9SPXe1AmoZzx49mJWvTUtgiZNb9kLmy57NWGOF6vP/pBFjwUeTO6uza1QK?=
 =?us-ascii?Q?sgnKqTt0JDIWGOf8irs3eFN5SA267GuFQSjLBjguEvm3E7to5LY35Vw8zqg+?=
 =?us-ascii?Q?GxkugKJveYExN8wmCW2NAll3UvQkVyhCwcnKMp5CFV+0HYR1D9s4eeoNkZxT?=
 =?us-ascii?Q?I+bVmASCMHmjSR+RyiMsMewut4ImG8h0dkNT0hnaiaH00fhvGtSGJcW+/C/m?=
 =?us-ascii?Q?PoRJavkdLWPoBYiYEg+h2yAzTRtgtQrbPnxiOv5ETDO9Y+38h5IFXpezbwB0?=
 =?us-ascii?Q?9SAzG4U0NpREqTlRdRm8GF43ZQ2VAjLOKqZiwa8SyJlcAp7lbXzsvt9/EtPu?=
 =?us-ascii?Q?W3700edxL3cTclKGnSSIo/VYgIKdtCvOAeC9+5Q32Roe4cOlYjx90XKoMG7Z?=
 =?us-ascii?Q?zk6bL7OPB3tWBbJZS4tpASFzB5G2TAoE4l0DptPkQOZ8H00mT8NzGRSRV3b1?=
 =?us-ascii?Q?vF5wE5mG7q1lGfs3ifwjOAEYVwu/LaZZwuUpZtdnEiq31XsyxRXezCs4F2aT?=
 =?us-ascii?Q?ZpQpZXzFhIYSEVacpxAQcnd8KW9TXdHSdolm9EpkNjwnTXH5BFQxB7cdHWfE?=
 =?us-ascii?Q?hx6w5rDZzPMqZxBzAgwWyEdD2cRf3qh3sy1WwXYE6WmlFBx9Ko9bsr5QsuJT?=
 =?us-ascii?Q?kdb8gBOknFHA8iQAukIBt3nXRG3Z0BKr7SF7RPX14ppv/zMYE3dzOZDVjei5?=
 =?us-ascii?Q?k52i+rsbWJa9p8SKtzqIwQ6WKp1QP54lg68S2/8846lx5M6jYECb+IPQlUMe?=
 =?us-ascii?Q?wQKy9wnixd1cVbOIqB1lqdGvmLVnmw53Upq8faGLaNX1wY9HaVvSH44N/qAq?=
 =?us-ascii?Q?CGRTpxoZiewCcVLZq1jG4NJGSYqUS6ezFYh26wDfCodHfXbhF5cQCN+LRyWJ?=
 =?us-ascii?Q?KH9wtv5yXknlgdaIuyjwbQzA58cm9MsNPyz1r0LAqNHrgA3E1HeYtBYyH9b5?=
 =?us-ascii?Q?bTpI0vhTxRWVMAOZf4rsLBH5a5s54VVLVGUEihc5ZSkIlJR8+4tm/cCIPA3r?=
 =?us-ascii?Q?CWNz7u7n9tKTZWVyhQ+TPkjU6EU6wFblhRS5e08nvvfZMmDWosUJhIzP6U7b?=
 =?us-ascii?Q?vIHrzlbRIvCyvdCBPWMf7zlG+UjKS8B3R/QadlP9r/xnuJEVfOhWaAhjNZZG?=
 =?us-ascii?Q?fn/mqrKWbxxj+QpGEfC1iSLvgcDh/8q2EdzDla1c6wHgTtApB3Wex3IoDScZ?=
 =?us-ascii?Q?b0QOmRTURMXsl+B4U6AheaB5v62SdBgTQUBcgk/vy/Zd7a6Bnpmd8/iX0ZGA?=
 =?us-ascii?Q?HitWv6lIrJE6I/auD3w2OmQQ/Iww3C38rRIiT4eMsEs7WIL/y57e613OAlrF?=
 =?us-ascii?Q?CThI4HOP+6Dye5MpnES3HcW74UUaMIXPB9MbAqjY8jXyFxU/tI8vorgSHdMY?=
 =?us-ascii?Q?/I+Ciwgn0p94gQc+TqyK8KfoMAy5Ag+xXC3yRDXLLGjOdUOpBpCLXRsvianu?=
 =?us-ascii?Q?0YsHE/bC7mEOoDRDtDLXJwbrjwehHas7PJeATP/OhltbgCOrQ2Km90RsR54R?=
 =?us-ascii?Q?E7yB3jHiDh+aJ6pQfZ1eA24fhkrVLbpjRyEet6Mu3qBBIM+x0c+g+tGp5IGF?=
 =?us-ascii?Q?eDhBedP4eXwPSHzIYYf/FTiV5CcagI94yxSLxKzO2nvo9VLuTf5cGA7mdwl5?=
 =?us-ascii?Q?h2cMilGOHNxVLTAuIQrSMDbNgw4R+xIIJ6vKrGdFNYz0w07nVUvQ4uxVNVxa?=
 =?us-ascii?Q?VmAOel9J4i3DzyzwH8rCJjo0lmkA0zcJ69wf0AkLGboel7Qdpmz7J35ZhNek?=
 =?us-ascii?Q?GSS+V0SZ5+Fl153TGS7H0tLOXyz2GSs=3D?=
X-Exchange-RoutingPolicyChecked: ZX51tI9bj9/kyWKz775CaW7imR+Uc+FFPPoHb7HVXmbtBR1PCUFSc+cZTTO/Gnt0VxXvEctmwOUzlAQRsERhcAqBgOS52sl0VIwNEG5JbfTQdGe6dRYD8ASnlW7NYxjre0Fy5NjuKcw5ObLkb+6+Jof+9wD7R7pTNIOWslgzthGndqkVgDtOA0Yn7O/oO2ME9pGeMW6WA+oOElOlexctyRJvGeLEdORR2NFJ7WKGOQbjlIRjltUENTLXAa9ANOOcYJipwkD1NX1QSsRtJ4QBViegeyNB8Gq+uFQxRdl1esqWFSFCdRENDu1vIEHOiqx9jM5meuDb0/jUML++iH0Ylg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 89afc115-b0f5-457d-4e30-08de961d1c87
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:48:11.0913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9ohLRmcdJMtMtnC7dFNP5Nl+PTubw/dCVm9XC+MFe9OMQmoxRfw1qtIdjn0ab1t8zKDzGmZHZmdIUeStCzBCz8Fz0vFsnWH6gKyb1tgD0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6159
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

On Thu, Apr 09, 2026 at 07:21:21AM +0530, Sushmita Hoskeri wrote:
> Added APIs to enable support for LEM (Large Exact Match) block
> in CPFL PMD
> 
> Signed-off-by: Sushmita Hoskeri <sushmita.hoskeri@intel.com>
> Signed-off-by: Atul Patel <atul.patel@intel.com>
> ---
> v2:
> - Expanded the LEM acronym in the commit message
> - Removed code that wasn't directly related to LEM block
> - Removed extra blank line
> 
>  drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c | 10 +++
>  drivers/net/intel/cpfl/cpfl_flow_parser.c     | 84 +++++++++++++++++++
>  drivers/net/intel/cpfl/cpfl_flow_parser.h     | 18 ++++
>  drivers/net/intel/cpfl/cpfl_fxp_rule.c        | 10 ++-
>  drivers/net/intel/cpfl/cpfl_fxp_rule.h        | 10 +++
>  drivers/net/intel/cpfl/cpfl_rules.c           | 36 ++++++++
>  drivers/net/intel/cpfl/cpfl_rules.h           | 46 +++++++++-
>  7 files changed, 212 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
