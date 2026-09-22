Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66357C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 16:41:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B01042D26;
	Tue, 22 Sep 2026 18:41:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7F99042796
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:41:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790095310; x=1821631310;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MtYZy6bSMhQpu6IUOCDz4PFpjTPL0ODhlrmc+pwdmnU=;
 b=HM1zxbuWQptwHBKO/yORIKzCx/dSvV/V6hN64fl/a+KnIHqBJVn2/ezT
 BJq2wnilCClxLeUALNrR2w9NnMj2hXyCHwL9k82RODCR7iYr9My6OJJoi
 AOIkEe9O+jzuAm1dyCNIAgePBSyV4eBPyzrtJjsF7L7GoI3zA4Ass8faF
 6DIydC5ywPX87tSP6Zjqnh9MhBUGaOqf1lGD4eeltW2OuAS7wGH5DRajD
 k67RnLy/1NkLP7xVcE4VQApFy5+pfoVyw1YrFDK0LDA17hqeH4GfLSsot
 q11BUI8EDkJGUIgiwPOh+3m5AS+aREKexfv8xzFxyEBIOF0pY5qtTkhL1 Q==;
X-CSE-ConnectionGUID: +ME1FifXRe6DNvyRmFhrgA==
X-CSE-MsgGUID: LS2IeMsbTIKePUW4j8AOVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="102071784"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="102071784"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 09:41:49 -0700
X-CSE-ConnectionGUID: 9kCQJlnjT6Sisms+01iP1g==
X-CSE-MsgGUID: u2vLUrjbRIGgIi7NdDVkbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="272685062"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 09:41:48 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 09:41:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 09:41:48 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.38) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 09:41:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZSZO1O/Pw4FVxZsU6zvmRyOMlpYt7ILoZcD7r4vlJ+NJZfPZInE/6qrk/5+QAkgIngEv/GYnWkVnFIdFRdMOme7WcwKNVbv/z0xe/QD16KhHUG+llBZ+Fb4mhMM5yERCXCNvmsGoQ6WHNr010aMkl/q2fEA+6pN2mz+rZv46uEVORkvySk/+fdCbjJY0BO3Wj/3f+W+k5I0MebL9+FfoP8ryNbd+TWKXDprn8ZX2oHGCpZla844UONChwN/oWiTJCCygDdVHQryOTgq1YJC0sEU3hCx9KRTo4ECNmgQdckMEzt2+QLWT0akLEkdnQSFlXvhp6QXf7ZWs48Xzy8GSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rhj5pSFA4F4EMpVVtzZ1Z+fXVYbAPRUjgwB04pjexKI=;
 b=dKXdFghZVd55a7h/izM6YNnz9LNRwHCD2SVEwW1S29u8dTTM7aTh6W3Qbdu+mSBsnh0+ypvMNuuGnF3MYYaqCVLKMXqk5TRu7v6VickFRUh1zNf9yIpKB8tdlPHEqbg9lqb05o3spU9q3uGJtUZi9ErmjbLSH2ocyqq3JNBYBI0JH+S1lFRiRnWQoPs8JIyetut0qnuzdTPIZBnMEfcOSxHnfm5T/eWHfwYSvYriu6nGerJSq7lCPxGLok85g6qGztRlb8/ZAAQCX6pTHYTRb/Q2qnEV5jz0RzhzYg4AiZhlOhBw/13fXk4vn5bHOWEwKfb9X2ztSyEP+YUkJ+EYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA3PR11MB7534.namprd11.prod.outlook.com (2603:10b6:806:305::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 16:41:42 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 16:41:42 +0000
Date: Tue, 22 Sep 2026 17:41:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>, "Thomas
 Monjalon" <thomas@monjalon.net>
Subject: Re: [PATCH v2 00/17] drivers: replace strncpy with strlcpy
Message-ID: <arKvweESua0SewSt@bricha3-mobl1.ger.corp.intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
 <CAJFAV8wTO-xdChto3Tzs2ci1QThtLingNDE_i0bjREhiOORjsQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8wTO-xdChto3Tzs2ci1QThtLingNDE_i0bjREhiOORjsQ@mail.gmail.com>
X-ClientProxiedBy: DU7P250CA0028.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::33) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA3PR11MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f1ca96-07ba-4f51-a542-08df18c861b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: va8JIaIcJUZQ+FQmbMs+/fDK6NJ6CbKxdsXp/Ut/eHOgBjdZLiC8/N5YkTu87IjXPe0+Jk0SSsbhwUtU0Y+MR/ntOrC7+MZnZ44h4x0xls+rKupMS5Q3lyFKPxxdhPWgF7K57q94h2FJidUkshaPVVx+IbMVU41ol0sJiPkneq6JZDuoiQY56lz9vQeNIPcBY4o1hfGebOG6pusvyefjuF7R4y4n2u/gZGzRt0hNon9MKwaYNMgiVtnRTlVGzxJzJdJHpVekn14H7Ph8RZ7GU+JG4/dpQhyc/GDw5nPWtwNyBPfnRvXNHGw1erHFAVzbp6O11gkmkKqBPjg4gq0uR+elwiu7URdH1uVOpYnoUU9vFkDEJLNHMymZBiYlhSoqRRFRLosCMC+P+IubZmiz+x8N4Wjf79D1j7E3dWVHESbQHGzt3GivyJJhr5O8Li9qwa+Lhzs3PxyOAJTV7oCre32gk3cVeQwQTrsli6OPcy/N1c/dJ9rb+1etyW4Lt4D6KmYG4VlUGKdc2+/M6uBR2qOuGO1Kx+ExL9j5SMVjdYvB26L02D7f6NmLfcQTCjTIoGvQFGe3g/VmRgDwdQBPYEkvOGS+LKsrh64mrZ1hOVB9SkeWkBLw5UY9xIGlBKHEXYyjxMc06jAATd2NAIkEJ/PKqOKVtp++v9+7HC6JEZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VaZhLL90i2ErhP3mgJBG6maH5t0gojp/wSNg21tV/TLHxGM3E97LTBr+ZAUA?=
 =?us-ascii?Q?9QE4S+k09WU/yfi6yOJtnQqdMAlFQaz/oyaSf8x6vkha4K6raPbexLAA8Rsm?=
 =?us-ascii?Q?19E1FgszWHgHP7KlZatYvjplWSKIcaKk6vJfCD91AMnFzwmpF4z4wqoXsm3X?=
 =?us-ascii?Q?Mw4ZgOmgO+ACI6gRS7i/quPldr5UYVICJC/OjmoqVzLthpf9a49sdsviSL2t?=
 =?us-ascii?Q?WDPOqa2PyD91BjiXa6UZb1JRaBGW23TiPn7A3T9lzqq/ZXyEfAO6ICJy8gdC?=
 =?us-ascii?Q?zs8nMHrCw4+DzNu2Pb9MPPO7uPXtG2EIzklxxvCjdeMthxm+Ddte3KYIAHTX?=
 =?us-ascii?Q?zYiYUxKez1Gv2c4ZODVYjKVkRKkOlQLmkwDKMRXcvhJz+ITp0XBAUgjKM+El?=
 =?us-ascii?Q?Ig2xlbj5+foSG9fXzKDyrkCuXZE7JmW9IxEKoGPoIuTn0kYoNhPf2NDHvW1d?=
 =?us-ascii?Q?RMfJESMrFVHo2CLwC3APBMozzzAC4BzqTSskUpJO5gNEQPcQ64obz8cEPYUv?=
 =?us-ascii?Q?dlfBD8as8HnfW1a4zJQt+qJ4vvIYyobqEHcQl0JQth6kT8eylLdqbO95fVK/?=
 =?us-ascii?Q?Xgn4jHKVC8RDPAqBYEu9gWpjJyv5U0XdSdGyT0suLWZaWrB/fQYHlaPPVIcl?=
 =?us-ascii?Q?dWYmIcq/HzjP2SfX8pyRlpsUJPaN0WKMwBxGcaITu0qEKERPcEBtGhxg8nZ7?=
 =?us-ascii?Q?oI6mYcIRmPJvGw7zCeaI6AFf7dvWTV6qCVRmuQ7kOcn25tSJLbypkz/zrU2f?=
 =?us-ascii?Q?d04OkFS3qUJ1mNXmJKB9CE8jWlNE4BBMN4kJfjzb0YBvCLMg2aS6NO6ZeGE8?=
 =?us-ascii?Q?NJMcN9+Q4qhs7yxKIqh3/c3NKMnWPBpbBvpJE2cb4o9pj3KuIBE+PghkcZ9N?=
 =?us-ascii?Q?6TGEkuQfOLQ4e6xbEdu4pLSzH1N67rxjJO8o0CMrddt5FVt6e0Zmo63V8/Z1?=
 =?us-ascii?Q?9WUw1RqPMJ7STAeghwVpGkCmf6e4+dY1jK/bE3YVBvZoGnBI2VVPzN72LcAx?=
 =?us-ascii?Q?vCsXlD3/5Dzr7qLoaLgNM5fJgJrQ51rMlzI1DUTHvxRPPCTZwUYcvW+er6jK?=
 =?us-ascii?Q?Df+SRqhEIW8Fwp84D52PCxL8SWIGvv5TKLqe875gM1t6O71FeNmV+FU4fQV+?=
 =?us-ascii?Q?m4L51EJDazgulQ0/qaqZN/3X03EJcKJm/XMDYYu/aggbcDMDv4j6X/ZNFuis?=
 =?us-ascii?Q?TLlU3p3HHh8Ay+Dp10gi+Orup/CfLogo0MILP+vLHScx2S1j2xcFCyzoljXk?=
 =?us-ascii?Q?zp58g9DO5r5tuxpZBBoADaTcczkvgCnZNaw2Edt+v2ZOYOEWPpqIHEes5lp8?=
 =?us-ascii?Q?81tnYxjuCwNTicWgmV9ATclCvjfFKOGHnLH3B+w92VzNIdL5Hv1TJCHswBw/?=
 =?us-ascii?Q?Q+HYZT4Tq35mbdsWC9JkY/flj3C76S8FMtoTwdEMeKJD2wcxRZ9zp13vrKxz?=
 =?us-ascii?Q?FluohGsptnxH10zT4rR2vYdE+SjV+ZPZHvyqx1SVfVBudidqwZAdgs4cabiL?=
 =?us-ascii?Q?VoLNu+Naa33RcXvtllO6WBPAGS5lOl+xxjtURFnlNCifAEB4nHBvCmrnYHCK?=
 =?us-ascii?Q?D/3Ug2yUVaempudkRthyI82ABTW7Sh4Q2fgWfvSAon4kXB+hECp7YKYH+FbD?=
 =?us-ascii?Q?H+QkGcsGKrDy/8xnvGVFT79mh1g24qmKch1bMr66mjWtfX7Z/1FN7FLxRjPt?=
 =?us-ascii?Q?0UWgBwU3FOZhPcoCReFJGmprR3fpTTuJoilR2viax84lPSzCG55rdNZ6RriM?=
 =?us-ascii?Q?UVWanQT6NXScSy3N7Pe6GGD/11Ulp2w=3D?=
X-Exchange-RoutingPolicyChecked: laW3LHL+OqUU6ZsQvijvULFBUbmO6vxBzUT9eQQ+/lbRd4saaC1tJIYmlvuJyh4GuzedY3xjmRIHjtJ1pQefdwWMeORNMpU9UlLoXmfZsbDhpvnNldmXobjhi9/6lVA3MPfFrSeaR9upDcwtEfCFTsww5hyiTnPDPWLJcUJsj/MU26rZ+BrgFGeutFOAKRwjS7zYpinkOSnsLMvsth69lNv6xPYcmW/okT7cDtSx0pBMlMl0KMG9ZUjSju+VqFgxDpVssDKtWcYnmekN4qPBjWqBqK9pkPeJAJFpBO8n62ABAgv3eEuzZr4FFpjegR7v4xHbw3wZ/qJjvEOMagRaYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f1ca96-07ba-4f51-a542-08df18c861b8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:41:42.4781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdtIczNI03TEctcAen7fpGlOW8HDG4JrG6hypXAgUXH5UoXfWUYb4Giw/4VUfsUoamEDfoOJompsEDj8iBewiimFP+Wppl85cJlo6BQWrvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7534
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

On Tue, Sep 22, 2026 at 06:13:08PM +0200, David Marchand wrote:
> On Wed, 24 Jun 2026 at 12:37, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Many uses of strncpy in DPDK drivers can be directly replaced by
> > a call to strlcpy instead, which is safer in that it always null-
> > terminates the string. This AI assisted patchset makes those
> > simple replacements, adjusting lengths as appropriate.
> >
> > After this set, there are still a number of drivers with strncpy calls
> > in them, but those are not simple strncpy->strlcpy replacements, so
> > left for later rework.
> >
> > v2:
> > * fix incorrect commit ids for fixlines.
> > * fix build errors due to missing rte_string_fns.h header include
> >
> > Bruce Richardson (17):
> >   common/cnxk: replace strncpy with strlcpy
> >   common/mlx5: replace strncpy with strlcpy
> >   crypto/mvsam: replace strncpy with strlcpy
> >   crypto/scheduler: replace strncpy with strlcpy
> >   event/cnxk: replace strncpy with strlcpy
> >   net/ark: replace strncpy with strlcpy
> >   net/bnx2x: replace strncpy with strlcpy
> >   net/cnxk: replace strncpy with strlcpy
> >   net/dpaa: replace strncpy with strlcpy
> >   net/ionic: replace strncpy with strlcpy
> >   net/mlx4: replace strncpy with strlcpy
> >   net/mlx5: replace strncpy with strlcpy
> >   net/nfp: replace strncpy with strlcpy
> >   net/qede: replace strncpy with strlcpy
> >   net/softnic: replace strncpy with strlcpy
> >   net/vhost: replace strncpy with strlcpy
> >   net/virtio: replace strncpy with strlcpy
> >
> >  drivers/common/cnxk/roc_model.c                   | 8 ++++----
> >  drivers/common/mlx5/linux/mlx5_common_os.c        | 2 +-
> >  drivers/crypto/mvsam/rte_mrvl_pmd.c               | 2 +-
> >  drivers/crypto/scheduler/scheduler_pmd.c          | 8 ++++----
> >  drivers/event/cnxk/cnxk_eventdev_stats.c          | 2 +-
> >  drivers/net/ark/ark_ethdev.c                      | 2 +-
> >  drivers/net/bnx2x/bnx2x.c                         | 2 +-
> >  drivers/net/bnx2x/bnx2x_vfpf.c                    | 2 +-
> >  drivers/net/cnxk/cnxk_eswitch.c                   | 4 ++--
> >  drivers/net/cnxk/cnxk_rep_msg.c                   | 2 +-
> >  drivers/net/dpaa/dpaa_ethdev.c                    | 2 +-
> >  drivers/net/ionic/ionic_main.c                    | 4 ++--
> >  drivers/net/mlx4/mlx4_ethdev.c                    | 2 +-
> >  drivers/net/mlx5/mlx5.c                           | 8 ++++----
> >  drivers/net/mlx5/windows/mlx5_ethdev_os.c         | 2 +-
> >  drivers/net/nfp/nfpcore/nfp_resource.c            | 2 +-
> >  drivers/net/qede/qede_ethdev.c                    | 2 +-
> >  drivers/net/softnic/conn.c                        | 6 ++++--
> >  drivers/net/vhost/rte_eth_vhost.c                 | 2 +-
> >  drivers/net/virtio/virtio_user/vhost_kernel_tap.c | 2 +-
> >  20 files changed, 34 insertions(+), 32 deletions(-)
> 
> Series applied.
> 
> Thanks for the cleanup Bruce.
> 
> Even if the transition is not finished, it is probably worth updating
> checkpatches.sh to avoid new strncpy additions now.
> 
This should be already covered by kernel checkpatch.pl script we wrap, so I
don't believe we need to add anything:

  cat /tmp/test_strncpy.patch | devtools/checkpatches.sh -q 2>&1

  ### [PATCH] test: check strncpy detection

  WARNING:COMMIT_MESSAGE: Missing commit description - Add an appropriate one

  WARNING:STRNCPY: Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90
  #20: FILE: ...


If we replace the checkpatches.sh script with Stephen's python version, we
can probably get a better error message more relevant for userspace.

/Bruce
