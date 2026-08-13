Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC5DC5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 11:50:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 425B44279E;
	Thu, 13 Aug 2026 13:50:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id D72764026A
 for <dev@dpdk.org>; Thu, 13 Aug 2026 13:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786621836; x=1818157836;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=q4mU2uOt+7lB34hLPWjgfTugjtMvesxOvJvwpxPPz4c=;
 b=GsgIc39l0GFX4xTNfnZYXxrG0yjr+dnD37kgutaHWPXVlGe5n6NV7pGE
 NLM745O9MeBi2xP+ZNJtWPc8APwH8UtMQHlhOCPCwqNFLHGWypShiX16T
 Kn3ItXfGgbnBlqJKiilrh8nUNIOyw2BuWBGCiCE+lt4wJaiPSiLjU0MQE
 WwaIwoGAxnLUTiYBbijHORugSTDlmS2oZziUk+f9DjmRh/s/bhss3kr+H
 Vr4A9T1+ookBM0eFDjQiPdlBpnmFJQwOpTobGiVs31UxtVJ/HErBx13zj
 xuGDWodubdKXNqOKmA/nLJGPIb5dIMFdq3Cym0VSgZ7QsaCpPtDuuuk1O Q==;
X-CSE-ConnectionGUID: +6j2vaZVSCO9zPLBAJf3uQ==
X-CSE-MsgGUID: mruNC7yiStKuM17YTCdw4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="98345926"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="98345926"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 04:50:35 -0700
X-CSE-ConnectionGUID: RA2lo1oAS0eTejwga12rhQ==
X-CSE-MsgGUID: oUFpyXvORBS4xXFITjf23w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="287357926"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 04:50:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 04:50:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 04:50:34 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 04:50:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmK6AsOJCJ0yktQNTWe9UGclm8JEADx4qS53xATizXvRjiVRXiHqhbc2tuyC6efjFgzo+qBXwJRi/WTVRA7Za88I625AV5AqGBlfSvMQuBtOOIc3cXV0QmP3XRKiNU50mQr7p0t/ED2MZd6rAwKn8fjDCq4ucPgS4R/GwPLt6bUr+ofY1w92gXL0yaQKBBXHroiPCmZV5Faq/nM+xNegdX6D6va68phKoxi+3LdXqQqvRdf3oKs9vNxJUp6gHepFFcq/0sKPSyAdhDnVLHuQ0Tb5oxANduqcW6xbl8PoQb/DD6C/kdfsa6vbT8dQYpIEvijqHisSekPdzMGhVUXIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4ebWyoVT+hwPvAcVB5K+PU5PUI/4oZ9Tkr7wMFe7Qg=;
 b=RuncnsuzvzmetNHtNvyZi6rDK/EGX98PVfTsCJo87Udaz4EcIMW5hSvyXBJALHbUJxkxRA8ykboZCfWDRQyYPldjKVQ/vcrvwH2ZVDh8xB9aVFBODUmkKm7tFIxKYV/nEFsYkeYTtkipQdz5VpiYnwfXLC5nSAFuacX7CvbgaulbYcG22DGtL1QgYrGVNV9OsfxBuivdaJIg4VyU1lI27+7WpIOfDjO4yUp9v6nG/1cnwc7t/f9YAH+hc58S7BKc/2U5XNhxY0HR5Wf+ouRn7OWQ5zMdAcs6J1FJIzTIsOmmtlj1A02rTTq43blLiJjQTBreKBqLbjB76T51pV1S+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA3PR11MB689426.namprd11.prod.outlook.com (2603:10b6:806:58b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 11:50:32 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 11:50:31 +0000
Date: Thu, 13 Aug 2026 12:50:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] stack: introduce pile
Message-ID: <an2vg8NMp9MRtbwO@bricha3-mobl1.ger.corp.intel.com>
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
 <anyEWVXfFEHBbsAJ@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F659DB@smartserver.smartshare.dk>
 <anycOPsfQs2cbZLf@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F659DC@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659DC@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0353.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::13) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA3PR11MB689426:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f956a1-5036-44e6-f5e7-08def93113d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pQTniD6gmYRsdy4RKIrWKQNX1OFmtC+q6Chq57iyMM0qOiAcOo4xeB58xRF3ml9Mml4LqaA8gnqLbUJbbQxfMptwYWHwYq+dL2902du9v4hiQfvKKyMpq1sMP9dh/x1kCUDf92lRGBt4YotHJuOVQgOtTeNnBBV40u36KlcJSY80gIljlIEelQWA1oM4qrr4qQ4CIHRT5Cr2vCXjWAI02UVHAQqaHDyY/leOI31uQn1Xmubt0piYgQQy8cBc53f3stYRLMxDdEDSqiji3dyhUpnq1FQK6OCB35PZ7sqJeqZniWiqVBbPR8oCTMJZ/yq97bbyLDvgYEkWPzLtN25bQpbVIMA0tyNsHsI2cG48gIu+uKKRCEjxHlSptfSCS/IXYY4Owu/RXrIHFDjrF+Kj4PjEdJzU2MXCHZsdWPdicA/t5G4/LoOc/XcYRIBDiUkdALg1cIc9aE9OXGRHO6APjBJvacEfiOJXMjOsO72peLb18bFv/nrfecY8BBLfdKH74OPvV30yZv5CdtYzpIfAOyN9rfnXRUrlAr2WOr988KE7E/wYTlF7lyEt72WDlBXsV4kvVNg1hnADnX7EkmNZxDNJ85++n7hrPuNBcfn0bmDRHzLpprRcnKTDRYrQbLrza5AY4IF0isGbfHJ7jJkkh9M7/o+T6eeQrLvNG7nCpNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Cp3FmTTW5mFYc1DdK8SayCbBiMC5gAj1DghKDR8199yo303xAVW9/P7jyU?=
 =?iso-8859-1?Q?BpdACKlbzdNTuhjuM6f1wInEXtV0c0bwWnv4U8pXY22IQdoKkGa2iKDTeZ?=
 =?iso-8859-1?Q?TFs2Ez9XhPY6lT//yAjxc3TchcuanDT2RJfJ+nJUpaChfmRQI0sOcr4IVI?=
 =?iso-8859-1?Q?emXk5+XRsoyHVC+ahMetg5Rbi24Y7KHPlyzdl17sCa2VKw4U+k+1o/r3S6?=
 =?iso-8859-1?Q?OFtExmVlrvCx7iJY2BUByerIjhxuLzDa11++v8E5DZT/39fcAyzc5Uv9g2?=
 =?iso-8859-1?Q?gVDGlesG64j2vldsfCoV88g+RzEeFAiKzOQkK7ChFPcBVIkwxSz3bOossH?=
 =?iso-8859-1?Q?GJSfrJZe8reuR0rZFUDFco2Hz2zgQjPeZwdd7W1Mu0NZk4pEawaU+rHc+G?=
 =?iso-8859-1?Q?8XHkBks2CtQd0Drk6zNY98uFOlOVRnWuy8noLpuslZDEGegGN7nCCKCUDF?=
 =?iso-8859-1?Q?JY9h+dk3Q47ZyLgI3d41PQ0a897O+r9VdWdO8ci4x4xwnUIxxJJgC7EozZ?=
 =?iso-8859-1?Q?raEcHoYtDo8D2e5hlT8sr2uLRhPw7VUy9aH8zSKzIXtgMKHIiIKHMwVuM6?=
 =?iso-8859-1?Q?bOkFfV/P8K3sFsZe7LKAJz3ptZ0OVv26siJGnfYHrorfEaCXqN9LI5Njs0?=
 =?iso-8859-1?Q?ylNTFJLRpRMnAQMqoXM9ldlB9YkLpoKzyZGBpNXxgFyHM+osj4+3JGqE0w?=
 =?iso-8859-1?Q?KY4AanaDP26OpGYCzuyzvsMbdnQJ7qSQsem4q/ILEQM/t1Bwe3q8wHQRH4?=
 =?iso-8859-1?Q?LyarC4TSGUBF3nWsvev5zJk04utmydNcq2+iiJZBi14dYaLgvxTOGNNWrA?=
 =?iso-8859-1?Q?jvh05ZLjMfmZ2n+0UIBxFQbapHuZQ8I8eJTw0LlFvI5cVRCbLeBeJiyC2/?=
 =?iso-8859-1?Q?vPy707G8Xy7K1A2h03RYVXMFd+DdZ5gfIAvGQ3JLUAWgO7CpuwVqzk5WSG?=
 =?iso-8859-1?Q?hdLBe6Fae1fJ7kxUpHMhrotXrVR+x1zMrqmsrMZYnoe5LT9rFyDFOGZUaV?=
 =?iso-8859-1?Q?f+qGDK7AJ+z4YjCeIuPJYx0otBo0WcU9BPNf1R2/aBI5wUs21IqjHDLFBN?=
 =?iso-8859-1?Q?tX+0NkUQnj2tG6CFUX8JYtbaCXBlFF0NuQ7uFDKuLFkkAl3YjpWNsiMaIU?=
 =?iso-8859-1?Q?LIeP4MhsQ3ImAY11jaUNek+Y/jcTBW0jm4Egj+ml26meueowt8Qjlb2SMW?=
 =?iso-8859-1?Q?uul1YjkZYtJQO6aG2s9ZeAy2eQm1zOdYBzkNFeTnDPAnlS4+lOKk+D6yDZ?=
 =?iso-8859-1?Q?uO9lS0hRstmDAcFKRSVPymQ3oeuDK7IptBaJlDI8Igd5OhexmZ/tfLeMKo?=
 =?iso-8859-1?Q?jsJtuA2zsMC+7vqmK0Khjx+N6fZvrAA6wd7QiLlWY0SjzSu+OdaWpZ2CM+?=
 =?iso-8859-1?Q?li+kRSj7Sx31+KhiCkPfjaK+xSOAHkYEy4OQZ6ny4r9sEUC2cOZnM3fd9V?=
 =?iso-8859-1?Q?kftplY9T/Qn5zjkNtMd/2k1rKazsF4Jcs/jkrr0KdBwC8lCp/TuqUF44WD?=
 =?iso-8859-1?Q?BmHxOLG5HV8nvbQJPeYBJckgGBngJvcG6wlkmUi8AgmBYCHz4sagFqXxes?=
 =?iso-8859-1?Q?6PwiJYjek3cEgMwBqUtDBk1F4y1vsCByB5qqUG2lZMdt3ZJYaHjFSgwSsc?=
 =?iso-8859-1?Q?NigWAkprySEiD2iw8GHVnff3zFK5IJxO8vJHhb0G6wa9OR8n8C/gEDiAQ5?=
 =?iso-8859-1?Q?N9DlMFK0AlQGsk+9+tVx7BS1tvvkegETNsItZ2V34kom31ZExBwV/VTWAO?=
 =?iso-8859-1?Q?yosMC0v5bcrWMdrfrma1aV7NM/xGiWb40JAO9eK2WjZhsKygP46XFwVNt8?=
 =?iso-8859-1?Q?Xh/trZPJjjY1vHgXdY2Ck1z0BMpOxuQ=3D?=
X-Exchange-RoutingPolicyChecked: OYtR2QJHo2yWdanPCCUyoPgG8yfhJ2qq5n/ejjvrxIKczATfzh6RqAVPsvJcOJHu6zTPD6nBGHJIKIM2shCq7Aa59+iK9YL+REGwVN8cdypM/IDKM4tWWy7K7aV2ZiN2mE0IKUa0k47JQdyUJdWTxq3M2PUL8eQdLkthNXe0Guq5D/6sog30UoLjDmw1BFkZPJFqav64qhCtFGOoUT3BWho5Fs3Btxc2Q2+IPE0qRMPNCIX5Ez0FsacjZh8L/Fk2OZP7dnYfrX48u6ttV4/H3lXFvIQu3/Kc0a+0TNRvHFXkIai8VgYBDdwtZDKn8yumgTTKM8IK7OR0TfwSty9Agg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f956a1-5036-44e6-f5e7-08def93113d6
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 11:50:31.7870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ITOEJXo+IMbYSILInm9mV4JOYclNaP2KLqc4/YHBuwMRz+xtVkfPPl1DSgFkeKsxaYC5+1Xkw6oL0OsOlhyuY8mTVQ+IBs5PLmgJ3MTM30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB689426
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

On Wed, Aug 12, 2026 at 06:28:36PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 12 August 2026 18.16
> > 
> > On Wed, Aug 12, 2026 at 06:01:31PM +0200, Morten Brørup wrote:
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent: Wednesday, 12 August 2026 16.34
> > > >
> > > > On Wed, Aug 12, 2026 at 01:47:56PM +0000, Morten Brørup wrote:
> > > > > Added a new high-performance lock-free "pile", using the Stack
> > API.
> > > > > The pile behaves roughly like a stack, but is not strictly LIFO.
> > > > >
> > > > > The pile is optimized for pushing/popping bulks of objects, which
> > > > > it does significantly faster than the lock-free stack.
> > > > >
> > > > > Pushing/popping a number of objects not divisible by the compile
> > time
> > > > > configurable bulk size is handled gracefully, but not as fast as
> > > > > complete bulks.
> > > > >
> > > > > Performance examples, stack_pile_perf_autotest vs.
> > stack_lf_autotest:
> > > > >
> > > > > On a single core, pushing/popping 1 or 8 objects is similar
> > speed.
> > > > > On a single core, pushing/popping 32 objects is 2x faster.
> > > > > On a single core, pushing/popping 512 objects is 10x faster.
> > > > >
> > > > > On four cores, pushing/popping 1, 8 or 32 objects is slightly
> > faster.
> > > > > On four cores, pushing/popping 512 objects is 4x faster.
> > > > >
> > > > How does it differ, or what are the benefits vs the standard stack.
> > >
> > > The standard stack is generally faster on single core.
> > > Only pushing/popping 512 objects is slightly faster than the standard
> > stack, but maybe the standard stack could be microoptimized to fix
> > that.
> > >
> > > On four cores, it is slightly faster than the standard stack with
> > multiple objects:
> > >
> > > stack_perf_autotest
> > > Average cycles per object push/pop (bulk size: 1): 3806.65
> > > Average cycles per object push/pop (bulk size: 8): 554.77
> > > Average cycles per object push/pop (bulk size: 32): 144.70
> > > Average cycles per object push/pop (bulk size: 512): 13.52
> > >
> > > stack_pile_perf_autotest
> > > Average cycles per object push/pop (bulk size: 1): 4012.39
> > > Average cycles per object push/pop (bulk size: 8): 459.82
> > > Average cycles per object push/pop (bulk size: 32): 122.40
> > > Average cycles per object push/pop (bulk size: 512): 9.60
> > >
> > >
> > > > The
> > > > LF
> > > > stack I'd view as a strange edge case, since even with the standard
> > > > MP/MC
> > > > ring mempool driver you still have atomics on the fast-path and you
> > > > will
> > > > still get stalls if a thread gets context switched out in the
> > middle of
> > > > a
> > > > mempool operation.
> > >
> > > Yes, the no-stall guarantee is a key benefit of the lock-free stack
> > and the pile.
> > >
> > 
> > Ok, that is good. Next question, rather than adding a whole new mempool
> > driver implementation, can we use this to replace one of the existing
> > stack
> > implementations? Do we need to have so many mempool stack drivers
> > generally?
> 
> We could consider replacing the lock-free stack implementation by the pile implementation, but the pile is not strictly LIFO, so it seems risky.
> 
> For a mempool holding mbufs, there's probably no harm in the difference.
> But for a mempool holding some other object type, it could be harmful. I don't know.
> IMO, not worth the risk.
> 
> Good idea, though!
> I'm usually in favor of cleaning up. Just not this one. :-)
> 

Having not reviewed the code yet, I can't fully comment, but I would look
for a strong differentiator before adding yet another stack implementation
to DPDK. Just because it's not strictly LIFO doesn't rule-out it being
a drop-in replacement for the existing stack_lf implementation, for
example, so long as it's pretty close. We have a habit of accumulating lots
of different implementations of things with slight variances, leading both
to having lots of stuff to maintain and also then to confusion from users
as to what to use. Therefore, as we look to have "better" implementations
of structures, I believe that we should always replace old with new, rather
than just adding new alongside old all the time - unless there is a very
strong reason not to.

Hope to review your new implementation in the coming days, and hope to have
more feedback then.

Thanks,
/Bruce
