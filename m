Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DACC2BA1B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 15:52:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E448740612;
	Tue, 11 Mar 2025 16:52:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id CD8BE40263
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:52:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741708323; x=1773244323;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mwLWrBOAE6lzVDIR6WzeC3Cv8/2w3N8G+g80vh6BRT4=;
 b=ZPYnqoxN55L/oOTY8ME8KrOXM0u1+Zi2fzS5xviAyKsabnraEB0+DIZj
 A8FknfzknyYXk288U9MKHwCcdB0J3CzA5UVS5I9C4aLiq9jBJot9skP+E
 9FKu4HBbKNQp5sUICGt+QMYZ6KrAmc+1dVy5NLdx7byD0E65pXInsV2nf
 YxYYHIgchLV+223lqoKrFF9+BncBynbHDYuUVs2oZhgarWMaaaqylc2Ry
 1mWx/9DVORS1yngzCv5C9me04SYZdlJKq3QkD0yrvGwxYOwMaQlsDPudl
 nYOAkc/VH9BCvsJhjFgHwaBhflFUWRWXcQms6oOCAGec+8dhsnlD5isQp A==;
X-CSE-ConnectionGUID: Gd86FX/SSV6Yjv9OUDtkKw==
X-CSE-MsgGUID: K1K2UsJmQgeL8ZocIC9syw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="30329064"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; d="scan'208";a="30329064"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2025 08:52:02 -0700
X-CSE-ConnectionGUID: KUBSTcGTSc6hRkclo7KxIQ==
X-CSE-MsgGUID: Ilpb5xv9TVqR5c3CyzlQKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; d="scan'208";a="125398638"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Mar 2025 08:52:01 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Mar 2025 08:52:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Mar 2025 08:52:01 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 08:51:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8IZ9weeypHg74/mh4NqBFJSgtjgzlA+gYFCN2NaPl992CFJHjQcb4KAj6nfxz5azWO4k74dPEegpKzEQ4n9zY0qVbcMPVQXykyfPccG0MA5g84V9d7jY4vOGAtyPv9AwcfLbp8SX98Vves3JqO6hjpodT0D9JTOqd38Hz03RBl7mekDroZVXajd6z1MqTJvG7rVcBxl/HddrAq41bCzGU8SZQt0ryZQ3SGhMbfHTGU//9rbp7MD+TxvcQx3LAbYaJn+NWsRS07Jgk1aQsECG+q9jcm4vvm/LgJ9e++ZDY3Yr5EhM9OCJKpwibXBqo0UIh84UzkxOGrZXSmbxEf7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/XyYMNPoXkB8GxxP5xmCSJxWA63Kcd0d8NEKzAxVl4=;
 b=mY2QtgUM8pDinNB4dI9h8dPrZydOGB092VENtjvBh4cdvPAqq3GvD6OXS3nR5I21D3Z05MuuJFp2oM5KE0epKmjTAmtNExhFuNhxw9JwGhZH+JspapHzPZfDt9aSsIgrzKXxeM+mflKoyr9hpa6Qgh5vhAnVZQy4/FIJvuygKiXW2vSSdgXCyw0DYEpC3h3vpTugiUmoNXa/2MMCRwBvIq5oFsuhCYBF14Dchfo1SrfrDcT+u327kfOiyL8lQhQND85smwFww0vQpqu0XB7yzxAhm6uE7a+RuNCDFy1AiE31Xpx9FytrDFNFZEmbkSg7GSKZy1RwHd7Sl6xCEtk2OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6845.namprd11.prod.outlook.com (2603:10b6:806:29f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Tue, 11 Mar
 2025 15:51:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 15:51:41 +0000
Date: Tue, 11 Mar 2025 15:51:36 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Andre Muezerie <andremue@linux.microsoft.com>, <dev@dpdk.org>,
 <sameh.gobriel@intel.com>, <vladimir.medvedkin@intel.com>,
 <yipeng1.wang@intel.com>
Subject: Re: [PATCH v2 1/3] eal: add function rte_size_to_str
Message-ID: <Z9BcCOoa1MvwrUhJ@bricha3-mobl1.ger.corp.intel.com>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <1741707195-26880-1-git-send-email-andremue@linux.microsoft.com>
 <20250311084905.478375c1@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311084905.478375c1@hermes.local>
X-ClientProxiedBy: DUZP191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4547b8-a787-47fa-2ae1-08dd60b49dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8cTDW4YXolECP0Yq5uufMQToQ2CapXLSXepNfGyBcflHmuw5Bb57z7vwn/3s?=
 =?us-ascii?Q?skbG1g5gFZTiy5buwMt8Ox0W2w/5DMREyx23/NaJsKOjTQ6c4U1fs0fbQZWq?=
 =?us-ascii?Q?O3qA8zF6yOmnt5W0evjE7mjbbHU44WekVJwjmfuH5HXkved973LO3wdkzQm/?=
 =?us-ascii?Q?iR5y4LkdbRZY+/PV90boctoCrzTzTyMokvNXNGrC3dhr3KtISBJ1p5x7trfO?=
 =?us-ascii?Q?xxXwG5FwlBcKWVRUwTDGjwZLQmOE5VUylgrG7N5uiEaxkbERFO54l6qvWfii?=
 =?us-ascii?Q?2MrztYaDnlm/xpgCapyrcodzHhdtKwihJ7uBGPCochfQ8sN6cGEx4f7Qvxqy?=
 =?us-ascii?Q?hhPfjfJbKo0susp1lxhhKdbDw9q5l4RvDPFVOHQi9xQBmeVFV0m4J5dbzoch?=
 =?us-ascii?Q?qb7ba5PGag4yaHx9W0MEnA+Ocg64X9PACRv/bNwTiNrpIulPX3vvAb6r0mtY?=
 =?us-ascii?Q?Vd5hVE3nF3j6aYXWaPRHTqjCXmSzIF3cOPYXA4Sh777QjknATaYBvqzG6wsb?=
 =?us-ascii?Q?gbMXnpt2t0CWg+tkezLJ2Fcity2cX3gTPilOLOJdDcpf4hDPJdhK21FsZQX3?=
 =?us-ascii?Q?8cZhdQ3wRUsK/63Y6I9XdLCAKb0pMJeTEjUcxQdp+L2Szum+ur4mtgzFxd1K?=
 =?us-ascii?Q?YiPcUccCv22vCFc8zA7A6d6F1CTXSdt3BskX42TEBTflh/BUd7fNIQ9EStMK?=
 =?us-ascii?Q?NdinxHnuZZqiW1SIl89n8M1O/frQYXas3cm9FBM3udM19xnHkf3IZZybj1f4?=
 =?us-ascii?Q?3WCrziRDl2V2jLTvsSGsJf7BYbn2B1Fz8VPH/VNCtrLUWogoowg669zp7fM+?=
 =?us-ascii?Q?UXMRqT8MepWow2I/kBf53KIdHRXTB2ijKXH3yBbmtXx4/3SagSFbLYYnsR4m?=
 =?us-ascii?Q?HPijaG/ajemA0fMa6WeJfJ/4IGLw0xuo4MX9IHbUmrDZtMhSqfiPmC8Cla7t?=
 =?us-ascii?Q?dXgnzkHGE8S/pP7BjOfNdfLUtsdM0t0L7qp2SFWKCeqdCySBNYUYzFlPNBDQ?=
 =?us-ascii?Q?I9FcbpqtH7IODb0NTCHoHT357+DePLRR/p84ztEPgwDbLBe1TA+ZmwReEHjw?=
 =?us-ascii?Q?SuoTY9gd5LPeMl6sOGmkpqUvX7gJwCNCOewjFRYUFiC8wVEymlGxIIxhcNCh?=
 =?us-ascii?Q?x3seq3y3pY/IFMJnm3oJ+tX1/M6TIQ9EzyHyY2nvdhwLXdo2D1Qen4Dld5pY?=
 =?us-ascii?Q?hD5Ip+zWy8PrXX0CCc5lMOPj4LcPDYoT0Ir/aafoW1W50BIpQ9Fk9qZJXYJM?=
 =?us-ascii?Q?Va30CG4ve6w5mxeQvJgh2eG+0hunXGsXXxsk7dBrJyLB+LHb/XFLLrcyipkn?=
 =?us-ascii?Q?GmKzlyMAeNUcFlRqTV/iUNCMaKpP1qOZ9EQJxWEDFo8upg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O85MNXXMMKe6BqIu2Ea3FyFFEI2cpIbhg+c+5MeFf+08/2ove5BuRj1iOx+q?=
 =?us-ascii?Q?y40M5Amkkcppo2CfB+rR21vYAn3GSZ2BSLRagSvHCeoj/gthmKKh196MAK0h?=
 =?us-ascii?Q?/bMMv6yuWnCsrShtVEmfYcsLShObiY3xH0E4xlGjwoeq1lQ/6Zxqgv4ZDqiF?=
 =?us-ascii?Q?E/iuHQCPqALlWXfFr6etxSGMo4P5no854+6DjKJh4GAL46PwVu4d2EK34bVw?=
 =?us-ascii?Q?rES9fFVZksCUrrbLhIFrWucHyp02xvYwnt/S748hgYs54nsvfEi5lMCLNIAJ?=
 =?us-ascii?Q?tv+eMeTjOnUe+CsbuciTwKrKZSI/ivpRG2N47vjqL3mFq52vf2EqveCbkRG/?=
 =?us-ascii?Q?NTpZ+CtoNfDdb4F+1e7AGOHuC7IW2DgUDunj5JhFQWdxKbIR44LiSy8t9w0F?=
 =?us-ascii?Q?SEWI6rnGtS6JJQ5myQtkjNnfn3MA0ya2+i7oaU4xIPCPIHfL8Ghjm33Ipqtj?=
 =?us-ascii?Q?ovPuCaes6I6UamyKi+XpGA0NoCrbhqfZgX6M/pfWEAgOM7Ijx4u6qIgR062I?=
 =?us-ascii?Q?569UAUFJ0JT4bhWNdt/rWOLk3Mzz9HWx09Zulzs4ZndjEVt5B6ahaEng3eeq?=
 =?us-ascii?Q?82rgP2pLDlqKjeCDH7NvGj5/tou8s7UlK+zLR1R0J3KokmTG+j+jb+Bsg6FY?=
 =?us-ascii?Q?v0llWNvarc4rYBOpgnKyBa5fM9pA6Owhp3urZuRZ6hTgG64eXE5M1fO6tCe8?=
 =?us-ascii?Q?nlgRSfYVsw195iQwt/hPVCtvyXYNEkoRbcAfAskzoqI8T/mou/nthR5K7QCo?=
 =?us-ascii?Q?eIfmS+FfdSXYm/K8AiYFOXnoVI7aASUg37Xn8n3cN1dw6Psle3M0uLhojevH?=
 =?us-ascii?Q?S+kgHpNi5Kfv061DwsvD3vlNSBTAJy6+Z8/oIxlbh8U2EpdpC/w6jeLotIcv?=
 =?us-ascii?Q?PVmfCPt5gZOQKayfxEOHiofzj+vHfWEiCRxoJHVH2vONP7N/8hKMbyLqdmof?=
 =?us-ascii?Q?UxZ/W+eq1DVrYCLTBoJkYh0+b8DcRzsJ5YilJRV/EPNDL/t0KP/D0TLr7otV?=
 =?us-ascii?Q?iTfcy3E10K+sxE1NlXm3VsHkB+n9yo5VZuZtDcDy7uwQk1sGnvZCgv8H1JO/?=
 =?us-ascii?Q?hTH4cw1DFFn5PjRbcVZfE9xjM4q+L4qqzfzwDPwRbkizIjjSBTKIyyP7dRZ+?=
 =?us-ascii?Q?UeONPgY6m1VEW+4u4HpvjlVsF9aoPuYxzEk2PPGH/oxJ30WyTugJT1q59C1V?=
 =?us-ascii?Q?9mQGuJGMFUQ0s4mJoo2ryW7orOuOfjhltMPBFdZjU0JtPld9zZZJU5TjHKwi?=
 =?us-ascii?Q?jqOAH9pfOLcy8/hpIqYpCgpunc6fmNx9X7AETnUR0n4NsTtf9bCIJQT6r/hR?=
 =?us-ascii?Q?8+A2h7RUAcrVNP8gjGypeXjUc4OpzHp5dV/xTHpHueZPu3jR4WfwksDoEYQx?=
 =?us-ascii?Q?1NE/coTFazcMu8yG7GgMEqVS7NpOitkVvgpwbERAtG4Q4gWUg8CvfHkYlC7J?=
 =?us-ascii?Q?e1tKz7UX5hqwekVa6C0fouOQXxwKNIeStHJf/ZL4FK4KCItam034gUkdCvHI?=
 =?us-ascii?Q?CltkHqUoCO8i89vO68F+80TpSOPLS8Mc9hvYfg60e2kz5jnEUsoYtXMSasS0?=
 =?us-ascii?Q?4ynoArYqpZRmZOlgXEzpHOcUTO9EYL3m5ptJIwtY0yRg8EBWWPY7vjUBz3nZ?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4547b8-a787-47fa-2ae1-08dd60b49dde
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 15:51:41.7992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sgnb/jjZaiAkKJejpOz2TsMeBSE+mtKdPSclq5t2JQBw3fUKf3kOpULD2fPlNxdj9t2yazFPJyRJcUYHNdHXUpMUfNjuA5yRyubyogQVhDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6845
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

On Tue, Mar 11, 2025 at 08:49:05AM -0700, Stephen Hemminger wrote:
> On Tue, 11 Mar 2025 08:33:13 -0700
> Andre Muezerie <andremue@linux.microsoft.com> wrote:
> 
> > It's common to use %' in the printf format specifier to make large numbers
> > more easily readable by having the thousands grouped. However, this
> > grouping does not work on Windows. Therefore, a function is needed to make
> > uint64_t numbers more easily readable. There are at least two tests that
> > can benefit from this new function.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  lib/eal/common/eal_common_string_fns.c | 44 ++++++++++++++++++++++++++
> >  lib/eal/include/rte_common.h           | 21 ++++++++++++
> >  2 files changed, 65 insertions(+)
> > 
> > diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
> > index 9ca2045b18..b658d68eac 100644
> > --- a/lib/eal/common/eal_common_string_fns.c
> > +++ b/lib/eal/common/eal_common_string_fns.c
> > @@ -4,6 +4,7 @@
> >  
> >  #include <ctype.h>
> >  #include <errno.h>
> > +#include <inttypes.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  
> > @@ -87,6 +88,12 @@ rte_str_to_size(const char *str)
> >  		endptr++; /* allow 1 space gap */
> >  
> >  	switch (*endptr) {
> > +	case 'E': case 'e':
> > +		size *= 1024; /* fall-through */
> > +	case 'P': case 'p':
> > +		size *= 1024; /* fall-through */
> > +	case 'T': case 't':
> > +		size *= 1024; /* fall-through */
> >  	case 'G': case 'g':
> >  		size *= 1024; /* fall-through */
> >  	case 'M': case 'm':
> > @@ -98,3 +105,40 @@ rte_str_to_size(const char *str)
> >  	}
> >  	return size;
> >  }
> > +
> 
> Is this right? Looks like existing code is not using correct multiple
>  
> The standard for communication is K = 1000 and the standard for storage is K = 1024.
> That is why iproute2 has the use_iec flag.
> 
> https://en.wikipedia.org/wiki/Data-rate_units
>

Ideally, we should have that flag, but I believe this current function is
for things like memory sizes, which means that using 1024 is correct.

/Bruce 
