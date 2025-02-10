Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446CEC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 09:35:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4073540268;
	Mon, 10 Feb 2025 10:35:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 2FE0440150
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:35:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739180133; x=1770716133;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cU+dtpzWLuyWcmRjD/OpGuwXO68FZ1AV2F8jTPo8g/c=;
 b=WMzuu+4JcmG/o+zVaRvM9hy4HDRvzp3uypMZq8zbofv/P2SXor+pSect
 cNzQ1IROct/JPPHwJ7aNgyjBP6yXDYFDFjvU8tNUAQ+O0RIKXmspbmpp+
 7vHe6X4uefm99tJ0rImfr/tKlz8l43kQRde+d+95GXj0tTXOW7lusAfsg
 shJIdDkoJLvFOqknleiMDtVgySRXiBfSmbqW8pqaR0SkhdDCIyvVdmXZZ
 DOYQJhxqwAHys7JzUsdk0PypKiNJuZLmpRpmG1v2duMeMcDx+kY2EgdX2
 63qetiCqBFwFlw80oFsFEHrSkT/0deiHfDrnFH4JAsWHgwSCZ3BtCrHpI g==;
X-CSE-ConnectionGUID: 0OKk3EWZS3iQBwr04Mo0sQ==
X-CSE-MsgGUID: PO3oPzuMTzSGICbl6RLDew==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="62228398"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="62228398"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 01:35:32 -0800
X-CSE-ConnectionGUID: Ve1h9lXuQwiGYqdEVLrUGw==
X-CSE-MsgGUID: IyiLOJUMTUm+H/xOai9nLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="113020714"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Feb 2025 01:35:32 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 01:35:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 01:35:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 01:35:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNdp/9XKnkBgVObGl8igqWc11BYU2zbaC4TboKH5OT40llzFu577FEwyz5oIgg5i5izUhAlbjzi9YO96KtKM2I9tIELCgEEdyzoNlkruRJmRkmsg/IcH53wXCULnWUlyoAlLyqEVHv5HLY9kLNvM2Q+5pNxDfJgpZqSg9orabXIt4HOsiPdX609E5m2ppOdqF8rimWeyVigEgPAVqxkz4+dlGcEtpsnlo3VNnrtNZKEJ2GGXkXQoX+iapZHYICmPXEqMJwZjtm1sGVera/bqXsvFi4ZLr9FOfmo8QoHmPQToLVhLVL0cUeisEjVQLYye9amgi2re48eNqzXG2OGSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxVnjev+I4GIfrN2XIoZUV7Vow1v9wa/csBkN/3mlMY=;
 b=bppHnUIrwjP1wvKTONViPehiygwgEG0emCuQrYjorbPsxOAIz/A3pcB/D57TrhbItQafGijfW1g3KSGE9+6viXyu9LIS9WQTl3SAlRDsA0xZzLRqWxnBuJ9QnASLwBs2pwje5O/5LbUu7ydQr5LKBt180rf/SIsObiyz/CfRAi0FT23J+sUm575WfFK9jiN2M3zHUobFAlsx8M75dOrKk3lYchgA8gejjxWHv7gwR+VBPYmU5StDjmdI1cr2C6RWtAWTvMoJJgvf+SuPuKMEXMAcFToqoryy706FhbEAeXtWSwRTYo22xelbG0921J7vdc+zIfX2if4Jqhd5AgVeRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4742.namprd11.prod.outlook.com (2603:10b6:208:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 09:35:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 09:35:27 +0000
Date: Mon, 10 Feb 2025 09:35:22 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Andre Muezerie <andremue@linux.microsoft.com>,
 <anatoly.burakov@intel.com>, <dev@dpdk.org>, <ian.stokes@intel.com>,
 <jochen.behrens@broadcom.com>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v5 0/1] use 64-bit shift, avoid signed/unsigned mismatch
Message-ID: <Z6nIWuulEuQ1H3HH@bricha3-mobl1.ger.corp.intel.com>
References: <1735246770-731-1-git-send-email-andremue@linux.microsoft.com>
 <1738950069-21059-1-git-send-email-andremue@linux.microsoft.com>
 <20250207110157.1283d121@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207110157.1283d121@hermes.local>
X-ClientProxiedBy: DU7P194CA0022.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d61bce-f920-4c8a-a6c4-08dd49b64094
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VZMCaj81BZVn2UmlPtw32A5XhoRqj5UhxHrWNCmU3W9YFAjc/V9vcqwfpHni?=
 =?us-ascii?Q?I7owTJv8AwfRLzqheNj3/7rD0PpGY3vlntixInRS8r4w+NSVOnXXGzh4A/OR?=
 =?us-ascii?Q?kXTR8CEOA+MrCxaOMchEypNYcVQ/fV6k7POo8G6cpz/T9qtRIxuHm/hAzLBh?=
 =?us-ascii?Q?5/2MCI/trSt5FItbpZrw3QEOUx3JUL8bV0wL/dD2XDjCcn7eeAnHsOJBHAD5?=
 =?us-ascii?Q?1ylVmt8dqpg1l2n0BPcrtv+LeTOXOcd8zVv2z0eL4sOzyFobzcqEGTRSTPIN?=
 =?us-ascii?Q?kMEw7XtTklvb/nponvGwrTozV+omJ93JDRUWIMKkS8pbnNeRjc259mUnZFSU?=
 =?us-ascii?Q?gWh2GobvkONRgarXSWy6f4xwErrdQDyPA+yTsJZkjuH5WGx/8QIHJUEklsX/?=
 =?us-ascii?Q?bwzn8c5zxbGAO7iQxEbFKsTI3vTl+kUciHMTPkQM/QvkdCHBgBGk5Dg2qF8b?=
 =?us-ascii?Q?E3lLXA3zq8ftuFv8p5uaHB0XXz510w2lh7bPLwnTNMFLp1l4fN2+LTZxTqbm?=
 =?us-ascii?Q?uhEXBHlHRgc7fMkhAtvJ2iWuRsDUpS0blxmHAII/OzManrz4ZJusJT6AS3z2?=
 =?us-ascii?Q?wTODwQf9K5d/In8NHNluMO+BmcJwSE+7QYStq8WlR2SPdYESw6/dI0UbgRHy?=
 =?us-ascii?Q?SBA36eiDrN7eUvsOUzZ0qk9a6OOqGqKewD+pLcKnoPmT2W4a61r/HzKBnYzy?=
 =?us-ascii?Q?rRvCAzdX9utjn8k6ducWL1vkZANCiYcgNzFAfY53jFPkj9Re/rhPyaIMqj19?=
 =?us-ascii?Q?/zk600Hfd/zc5Hu0qeBBEWHGgk6YdWCqOJqoiz5oC5oTlS2GWChKHj26Be2B?=
 =?us-ascii?Q?dv8J/fgGhyVm9HluqJ+zp6F4W6V8+sVMf2D7DJJycWKF0aQdxs5dOph32lPu?=
 =?us-ascii?Q?DIlLZvHeUgjH8NjA1BIh+97tzKHhUAyFmo/U1MGlldSvRTl/Kq+pylLbiq4m?=
 =?us-ascii?Q?sqsN6PcrHm8GnjMM39n2ipK5xRXsoly9pCFBKM+HQQmHibcphjNkLpuocl5S?=
 =?us-ascii?Q?o65HAwroqHyBKJ4jx4Y4SJLDJ4fcDmK2WRrMxn0ZbyFMt+OU5+9/88x6V56M?=
 =?us-ascii?Q?HRmAup8KgS57bukx/hY7ubnG58RSVBnVxjrLEaV3HTzmX39EMOL6eZOIxIEh?=
 =?us-ascii?Q?9/Qs5PbZRhIDnXt92oi3baRooSD2iZwbqQ7dKoxHKKiKhACW5KLaajk2l3Es?=
 =?us-ascii?Q?7wbf0nVDyhxJV8rHfJBCExqIwXQMJs3MF9O0v5K+p+m3bqZNn6WUq8YwXmBB?=
 =?us-ascii?Q?BMHS4BxqOibsbqlTBTbhwtOcSUbLMipFZSvVlQ7WYYJh4g91FpmseowdMlW5?=
 =?us-ascii?Q?YlMVaeFcaCFgTCZi+nCImVVWlQk9OhaFAZm36wqsMu1CNmvZIbOJyRySc6q6?=
 =?us-ascii?Q?/0I1w0KFtpiPlrvI8R3QkRXORZce?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7qIPT0qBlJah3vMLmYa7hbWaBF9l+RsTLyxLMla3rslNXJYmz9ikD2vjIU0Y?=
 =?us-ascii?Q?zUtzE6L93j/xvXXe1MyiMu9GjcLkBzVQDfnyV8iLxzFA6kC1wtJfQT1Bqp4Z?=
 =?us-ascii?Q?Az8pt4c+FSSq9VtfAL5Jb+OYTEQa+rLypb6yNIkzRanRPhk9PPsEzZw0fN3c?=
 =?us-ascii?Q?ePxVCwAzxUPbuJenPOj5SAaxnocXsIEBqJCO7TPwbXA6qRss0XBsYQqtOhn5?=
 =?us-ascii?Q?DE8Dbd/2ogiw9GmviYh/9WrPylNAypFksJMGxn+VJTR+SvfEvA9lmcnlTnGZ?=
 =?us-ascii?Q?biOR3w2l5+fvs6Mrcnj/4gexcqZFqoDS3AKRvwhuqdkOHGWrNd1L3mTQrHUN?=
 =?us-ascii?Q?eOa4/InoPgv1xVPYSpt/OXveRUyw/K8i3Zq3T37LeNaYyQYpwIfOEKnKsZF/?=
 =?us-ascii?Q?8IyNQj/XZbqkETIsPh0d/s2IZw3KDQnG79ewgnVGLQhJ4DdFJvV9uNfRyl1K?=
 =?us-ascii?Q?fHk8VZRns48vSVOhny8qepIdA8fyLl1UW43UkBnf8Bno43gDFAzd2W8l0J1h?=
 =?us-ascii?Q?d6sHoBI7OEcUWmG2PsFhKOGZ4tXu8hVpGp6l7UMyIeYjT/TImLvp5mWMdz99?=
 =?us-ascii?Q?D/vVP6UyMZvt9z9kjoafOCc4sQh9YCtxk7+Cf+d7Mj3X8H8B5J1aC5P0N0kf?=
 =?us-ascii?Q?5jgJvvcLLJ/i06u1TQnaZ7w8ovIkdWRrck26vyMvSAjzM0Kr0d3cWdUpcURG?=
 =?us-ascii?Q?vSeTCd7uTdTZ+HNGfmw41i65HQZUoBo3pQ9sWP9weQ+nYQmPXsqd+2NYjMwL?=
 =?us-ascii?Q?eqE8zpNt3gXrLKgl00WJf8A1L9SCKcV6JIn950XzK8orsPBhxCkKE7uKcDzM?=
 =?us-ascii?Q?XmWRKszZ4cwMHp6x6ixAv/BJa/5I3lN+ht67ox0TdKa2W1SitsnMkCcYfZHV?=
 =?us-ascii?Q?xeCE3gGqvQZMOrWtJiv5vsTElztpXsjZgOB1PoX8uOxzoMwdq316mz4E1R/a?=
 =?us-ascii?Q?wxGsNRvFssJy2YVckUN6I+/IAAZhmQ9Snv7gTkExnBkXi8Wvbt9DyMBQN5E2?=
 =?us-ascii?Q?ZFnsGHjVwpiLBAlm6ocrR2iOjz8NUHq6IxeDYGWSfqHANqi7EnIUc4WP62Pm?=
 =?us-ascii?Q?PSDbCWp1A8jNJ/Ix8n/IQiPG8PREigxOhlDGxgXmgyE7N+SBLknGKaa4p+D0?=
 =?us-ascii?Q?0ONrR2F74ANe5bXZh398OtxQW23KA2IPe9oExFRBQPElMetO/o4UgDhhxNaY?=
 =?us-ascii?Q?UmZdgQWJklRQVD/mEA3btmlWiPHLRi20qJQFCiqcVAA7ukvBp6tbgh1vo6ru?=
 =?us-ascii?Q?QPi+elluMSuXyHmAdzNgKZNPJYQDNCpJKM3YGYU9PYikTtcTEPZw4vvd6hTm?=
 =?us-ascii?Q?EFy60XY94yxm4wMwhUkRZcvoDvCLEeoeL9tGzYGjmH3VX55UkBTcjIdi4ns1?=
 =?us-ascii?Q?L8wgmMFxJyWeY4dDe7XuXmoj6uDyhzMlipue9f5TehDC+tLjP/pXTRh64l7D?=
 =?us-ascii?Q?bDeFHlfZN0xGQEaAm75OSBThiwR+LsIUHC66ggdgEt1kppuhKjJIaR1vmx/Q?=
 =?us-ascii?Q?HB+geg8W9KQyzcorye/n97xapHtBAzMzZAQXW9s+HoigJSCXOLy88JFDHSUT?=
 =?us-ascii?Q?cJ7vE+0f/VFXj8rBsdBTx57mZERB0o7fUsDgbLuhZ1Wq3yFIHv2m5v3lq271?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d61bce-f920-4c8a-a6c4-08dd49b64094
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:35:27.5279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZMycYnxg+ufgGceWSWZWbfgqxaYd6ZE5OEGrE0Un9fKZc+yqoIPMwGCePXu/c6hrIEp7ucwCtfImAnBxzEA/kJFoyYTB4DUDP6Qh+iywak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4742
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

On Fri, Feb 07, 2025 at 11:01:57AM -0800, Stephen Hemminger wrote:
> On Fri,  7 Feb 2025 09:41:08 -0800
> Andre Muezerie <andremue@linux.microsoft.com> wrote:
> 
> > This patch avoids warnings like the ones below emitted by MSVC:
> > 
> > 1)
> > ../drivers/net/ice/base/ice_flg_rd.c(71): warning C4334: '<<':
> >     result of 32-bit shift implicitly converted to 64 bits
> >     (was 64-bit shift intended?)
> > 
> > 2)
> > ../drivers/net/ice/ice_dcf_sched.c(177): warning C4018: '>=':
> >     signed/unsigned mismatch
> > 
> > The fix for (1) is to use 64-bit shifting when appropriate
> > (according to what the result is used for).
> > 
> > The fix for (2) is to explicitly cast the variables used in the
> > comparison.
> > 
> > v5:
> >  * rebase
> >  * use uint32_t instead of uint32, to better conform to DPDK standards
> >  * rename variable rqID to rq_id to better conform to DPDK standards
> >    and avoid checkpatch warning
> >  * use 2U instead of (uint32)2, which is shorter
> >  * simplify expression in meson.build using compiler id "gcc"
> > 
> > Andre Muezerie (1):
> >   drivers/net: use 64-bit shift and avoid signed/unsigned mismatch
> > 
> >  drivers/net/intel/i40e/i40e_ethdev.c   | 22 +++++++++++-----------
> >  drivers/net/intel/iavf/iavf_ethdev.c   |  2 +-
> >  drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
> >  drivers/net/intel/iavf/iavf_vchnl.c    |  2 +-
> >  drivers/net/intel/ice/base/meson.build | 19 +++++++++++++------
> >  drivers/net/intel/ice/ice_dcf_sched.c  |  2 +-
> >  drivers/net/intel/ice/ice_ethdev.c     |  4 ++--
> >  drivers/net/intel/ice/ice_rxtx.c       |  2 +-
> >  drivers/net/intel/ixgbe/ixgbe_ethdev.c |  2 +-
> >  9 files changed, 32 insertions(+), 25 deletions(-)
> 
> 
> Since all intel, this should get picked up by next-intel

V4 had some non-intel changes too. Did they get missed in v5?
