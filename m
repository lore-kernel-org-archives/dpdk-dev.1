Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF62AD3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 08:50:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFEFE40270;
	Tue,  9 Dec 2025 09:50:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id D6EEC4025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 09:50:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765270215; x=1796806215;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0PjrZEkSNwh57ZsPBHGdYPV3PJ571U8mpHzW/oWmy80=;
 b=TTc1BvIUbmUcsxbuCX5b+xgCtIWh6oQB3CqcGj3EV9f00w61TGtGHg1y
 soO9VUz4sV1p4d40SCSWclCjazLV6Hll0S9qK6R1ecXPck0sslOIXyZgX
 SCsbmQ0Kusk+1JzPqdFQD3NYlWr0KcelQwj3vldtwKdhau0KnMNX/d7o4
 AMilmglJVHTLJ/2s6RHUfBN3VEC9WXtENhQj3Y7RTteJrc0pVa2jcYBWn
 kF+xNMrV2YAYPy2gMbJUGpi4PITmzdp6XbWwt+ueWMK67vkdN2XQMmj59
 GUyRfRsz/qfaTFcLO5njiwrRnbuTpg7SflZ1gnA2epbrWxY+LiMUZCE99 Q==;
X-CSE-ConnectionGUID: GSLJNBRJTuKNsNVJsJRbrw==
X-CSE-MsgGUID: rAkxS6KmSaSqDPZpLwtHZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="77908460"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="77908460"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 00:50:14 -0800
X-CSE-ConnectionGUID: tDTk5nL2S0qOsl8q+qA4Hg==
X-CSE-MsgGUID: tLZhWZZAT+GI+MvH6naJTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="200646080"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 00:50:14 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 00:50:13 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 9 Dec 2025 00:50:13 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.70)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 00:50:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cr662aPJWSjjHp1s1q2u7xHYZCtInfV4LGsF3vFex5cd7kt0xS6UoXZx2HFBwGR0u1inO1/d8W1/z8WaFjRk2jZ+L+vmYYspfMqIXl61RNIAf4akvtV2i07MkIdaNIzqz9sZX/5XimkIW5etv7kNKYIXSJyUcEGxGAN0Kfvzht/pVOgPMgdBxyGzoEgt74a3ppnQDvZOpfhNX8PrHVNI0HFCWBEOCDt51l8xbZcqM3mxAsgNBIK3e9JFk6zjK+AyXQ6oVDDF+3eIyOE3zWXA8EyowMuR811O749p+ZHFQbS7quaxeaLbygW9MdSKtMCuxOMqjEAr9Eg3a35hEwJMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XO4RREM9v40j1JdYl3CbmU+oeFT9LSnTXbn6A1blwck=;
 b=tWYMlOhXJVACI0KIUVPHSZZrYhvzeie6egmQWc8nSzHKMVGSChOdOp77kS0Dxep9DKHXQJT/CpBiYwjUBZurCHs/6LJlDCbagvhFe3UM4A6EDG68iOzWr7Nkcm/trqGmZwXn9tkPaDZX1gwPG+Cg27xmzjGCZeEMaOZf3n7iR09ExFn3DhdlBLqOUET/P1cdH05MLMjF7ugsx9S5C2jI7RhBkecxY/gURwZ0iO2PcxvDKOB76ywNvmDIqq+/7Juj1nFD0JSiOBX+zODyIEYBdK8PNvlatKPNwgudFfx23eTvinegpg2gPPnmoLFo/oux0YQHRPngaL9NZdV1WtyyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DM4PR11MB6068.namprd11.prod.outlook.com (2603:10b6:8:64::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.14; Tue, 9 Dec 2025 08:50:11 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%6]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 08:50:11 +0000
Date: Tue, 9 Dec 2025 08:50:06 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 00/11] Assign all unit tests to suites
Message-ID: <aTfivuaqs37ESNYx@bricha3-mobl1.ger.corp.intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251208115245.3809624-1-bruce.richardson@intel.com>
 <20251208111053.12535b4f@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251208111053.12535b4f@phoenix.local>
X-ClientProxiedBy: DUZPR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::18) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DM4PR11MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 857fc088-0c9d-474f-fa1e-08de36fff654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OX9/9ZLMUo4WwHgwPAe+rkmuLBgzHOVXJgvQAQV6r6VZ6YO4CW2FTa3db1Yn?=
 =?us-ascii?Q?4hYxMQRmCae0vUPXJR1t3S8IMNdbU5YHpT6eXpRkNCFBigGIAdKO3wwWmaKe?=
 =?us-ascii?Q?EOVS3r0fYjiOATIvbs9KA3Apf4whQwfmqq64oHl8oJngJQzgfEGi1OuYfX3I?=
 =?us-ascii?Q?7vI1dgJhfJAKCLSGWa0rhj0u2y8s6m2IJ23Xd23enhVSRok8bsWTg00/nhag?=
 =?us-ascii?Q?w75bCbQtQtWNaddPPlYhM9SeA0fHQQzMZwEKK2d1TiWkgftn0Gbd8HIVagG8?=
 =?us-ascii?Q?JLB6nK5RcduTlwCXjueYBV1Tivbxiqc7x84gxqcLiv38iwIuHVRD53bgSd1R?=
 =?us-ascii?Q?zevBiip4slsPcFOTxKEB9gl52QEwoTmFhXiBk6AsBxtCkn3qmHWHfA36HFN7?=
 =?us-ascii?Q?4NRIW9/RN7blpK3rYBOHFPBsdrgeTOGeGoARjv6bIiCLP12raEw9j6z7RK9n?=
 =?us-ascii?Q?5lCuHljxGOrmJ6LzVRjo/lMy9qfl5014eKuv5n6o1XcD4iiOdpFsQ4h7y+hG?=
 =?us-ascii?Q?TSql1wKXI/gsA2sHcfQBGXJAlBsAWnMDbwmKKGAaSIfTp7k14Rjkiwc4Pbo0?=
 =?us-ascii?Q?D6IW65vU3oOl3AjeHLcmvOYSiGHmfWC4HIkxn1rk3uDkFv9nYc+6VJEc0EBZ?=
 =?us-ascii?Q?J+4UV+sFtf1lt8K+KqBcWaTSikz6g8i8priJcCWyHiRRe08HEWuGfevuWsFD?=
 =?us-ascii?Q?+GUnJ227pXhPjqdTQqVI2g1arnhJeEttsyjJPBVhqHltBtrHaVAc96sLbnq8?=
 =?us-ascii?Q?QgaLGEMOZ1mStOwOeqMzlVHHFmGwZ5f1KvOSxDaGHqGmveCXSeDFyL+THVGF?=
 =?us-ascii?Q?6W1AXtksIqoLmAxdpibz10FFHjXsEU8zog2UAlMjTMhRwnvwypwkJ1qtwwXQ?=
 =?us-ascii?Q?fUBypSV35ZnFdDHbDExOszrTFsw/bg+4wNSNTiPya8OhoIV5afviW53CK2em?=
 =?us-ascii?Q?YRT/MfVS0yP2YC0Fiuv6xiBwqIzQvEwtKF4BH/GnFvx1OqLgH81K+21+LC8E?=
 =?us-ascii?Q?MN8GXziEO8hVURvaK7r62qROgEX6Mja+ZT+0insSP1qjWgPez3JuyrUHhIVv?=
 =?us-ascii?Q?jl+syPt2R/9tHryl11w6wz0jrUU926Sf/KW6NIHiEdGMJWpoGM/ksDB7XBx0?=
 =?us-ascii?Q?84ulzwRSj/3UkGzAZ6Fp2xUBiA72KiGdlTk892XgBuJ9GNKVEDw/lCkvEiLj?=
 =?us-ascii?Q?mzNEKyOcEplp/PqnanJCo1/Q2IT7wMGnclVC9Kf0oy9FGx5EVxSS/Klqphut?=
 =?us-ascii?Q?pzPx8beKV2S78UkUALR/ozaztCdawys2ShRr9taqcmmdbwERT5n1sC/nzLcI?=
 =?us-ascii?Q?dtZ37wpoO2gsXe6OFSgGXQNzGjm2Oxe4h6IxEVMdj/5voPVV+4xm9d8hCfOC?=
 =?us-ascii?Q?Nvoc6QIfw37/DezdySe6mKk6SUHz6OkQi5NWLcq1/THBZsslKmwGAQ1XivZh?=
 =?us-ascii?Q?ArhuPYu4JqyeweyVuTD60OBvZLlYr/v0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+NjwLZGUb2beUi360hXOW0Z9AA8QPlgm2RqP8ovnmAlxQVx7F5S5nvbt89xT?=
 =?us-ascii?Q?qCfLw6lefLxz11Hy4n7j+J+nRZ6WWho5EHoBmwUcvEVmoiWwqJlQAz3jKlkP?=
 =?us-ascii?Q?1R2leybQuo34D9P1UCNlh9p5SU7KfnMlF3LWpbowbOa4TL8QfJ0JsbjgU6Rb?=
 =?us-ascii?Q?9p/Rb+7h1GRMisW4hL8ne6TZ5Yr6bJzqDP+P/kOvSWUU4PiCPww11OgPwHxz?=
 =?us-ascii?Q?On2h2j/p2xavPa1GvHSJdk3l6ZX+G+JN1LqEXr9nMrz8qSEnZOBvA9YXz/+y?=
 =?us-ascii?Q?2SKD9ibYmzQJ5zOmMGoj7Tr/fIPSJWgpaR9c7ukRhK7D8bU+Dy1tZFs9/zMT?=
 =?us-ascii?Q?/dxwRPX6wr7D3TQhdVTOaCA8g2+mnnK0Kzbmsl/ZzcRnebsRTUXVG5DQLZM2?=
 =?us-ascii?Q?p12GIfpfzzH3W2r3id8nxIzKo00CDnapUmTYoXDhIsZYKwxwhCQr2ijC7y2u?=
 =?us-ascii?Q?x9RmdJaYTQSQ3BHFkCViAzfBGLXBqMqd0e575QN+d+Pn7OkLN0dqvojSLaxi?=
 =?us-ascii?Q?imAKJWFoP6S2NKXots7YXgGD9d5H4vDwyNxVMLPxqDZsARCKHWSU2lWU8KWy?=
 =?us-ascii?Q?odoh6tVbiD2ghpSDI/R0b3A2wT5KRPmdI6zGpA6aDp2iqeNucC/DfksNsGWc?=
 =?us-ascii?Q?AC72oWXmWQKQ+JSbgREr1c1mg2ZVZGoQZCZj4ihN3nbHWEcTEWFdudBGEVlO?=
 =?us-ascii?Q?G+tgfBAgROyt7Pw6q/j4SXNG10bwq4fZFZgViDi5N7B6zpkisvl0nC/KfsFX?=
 =?us-ascii?Q?RjDPqiJBCMNNGviif2ZnbALJ4HAgOtrlNP6pzd5qSO+lGWBv+GfhVGLF6phm?=
 =?us-ascii?Q?tYI6kE+5njdkwAXfkohIVRGhpfujNErTPIHBmn6u9D6AarH+Oi/O8rjkjlQb?=
 =?us-ascii?Q?N50KZBlQeKQhJR5A7kRaVnvO06FgxCKo5OnqLzAvbhUldqcGVXPpBf+UAtGC?=
 =?us-ascii?Q?07pYeYKYjxN3MR7d4Xv9SKiBMYJhDUBWnSg6LqM3PfCOk9heJosfEAUTKvS8?=
 =?us-ascii?Q?ILPm4aeZtPPApaww9aASiCuLC+BhaHotu2reuiXpimzafZ84OTJbDDFC4BSP?=
 =?us-ascii?Q?3nm6YacvpRY1cFKJ2STpfAVhO0w8/nAUlTTX5ln8sPRQZXIvBJgHXkaU2mGx?=
 =?us-ascii?Q?DApPF0Tm88lMwkAPLyu9FkOvjOqzN7/EJ+5dSFH9BWAbFCxcQrhZOnJ7UDPS?=
 =?us-ascii?Q?JeYsYH6hEGQJwL7RR0FYML/iw7IxQnyGcKX58xl2no7lv8VD2Z6KODOwXo7N?=
 =?us-ascii?Q?OIADJg7snCZqRPAkn3GRrsfcCOO2gqmD0wnAN3IMsL1ORvmhniZ3CoNabBis?=
 =?us-ascii?Q?9JceM8Na0h3LGK/bRhAI07dRN+n1i/H2ZJhoVRDS4WUky23nb7B7z31ShjDU?=
 =?us-ascii?Q?1ESrjNdBqs8daNoU0FaPI8OWC/p8TzqVW1fm4Z6Vp76tZXJ7d9Cbnr4C/FrN?=
 =?us-ascii?Q?VQ9k8yMD4nh+vZ0ZnhVxsZ3YH9FXi6LAF0HJp1R6d4CbpJX2xfVM/A70I1fv?=
 =?us-ascii?Q?4A+EqHHbN0252CgJ9DGhthdMmfFEDl+myHE5mpkkJ0qqojntnqxp/RvpK1vz?=
 =?us-ascii?Q?ILLXQo+XTktf+0rxgxkF1Is9iIPfN22LGYZkmGKDWQxTZ47hTlSnkE4Enb4/?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 857fc088-0c9d-474f-fa1e-08de36fff654
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:50:11.3154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RySSDLbFozGHjqHsSJKwGTUHkBf3/L0aEEH2pSulS1ov7vjmLdMMKYJhdUGFTNDEkIPUoSLuo1NZHvJL2Dts4LbuSZsgn8Z0M3bqqGcDxdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6068
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

On Mon, Dec 08, 2025 at 11:10:53AM -0800, Stephen Hemminger wrote:
> On Mon,  8 Dec 2025 11:52:34 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > Categorize all unit tests into one of the test suites: generally driver
> > tests or fast-tests. In order to add some of the tests to fast tests,
> > some additional work was required, hence the additional patches in this
> > set. Also, make the parameters for asan and hugepages clearer in each
> > test's definition.
> > 
> > V3:
> >  - correct comment in patch 1
> >  - define "attic" suite for unstable tests and add red_autotest to it.
> > 
> > V2:
> > - rename the parameters for fast-test
> > - fix issues with the tests to be added to fast-tests:
> >   * allow loading drivers from secondary processes
> >   * fix undefined behaviour flagged by asan in red test
> >   * skip unrunnable power tests, rather than failing
> > - add tests to driver-test suite also
> > - add patch fixing output in case we have no unattached tests
> > 
> > Bruce Richardson (11):
> >   app/test: make parameters clearer when adding fast tests
> >   app/test: fix undefined behaviour in red autotest
> >   app/test: reduce duration of secondary timer test
> >   app/test: fix timer loop hang on secondary process failure
> >   eal: add internal APIs to query loaded driver paths
> >   app/test: pass loaded driver info to secondary procs
> >   app/test: skip power capabilities test if unsupported
> >   app/test: add some unattached tests to fast-test suite
> >   app/test: add tests to driver test suite
> >   buildtools/get-test-suites: suppress empty output
> >   app/test: move red autotest to attic
> > 
> >  app/test/process.h                     | 28 ++++++++++++-
> >  app/test/suites/meson.build            | 14 ++++++-
> >  app/test/test.h                        | 13 ++++++-
> >  app/test/test_acl.c                    |  2 +-
> >  app/test/test_alarm.c                  |  2 +-
> >  app/test/test_argparse.c               |  2 +-
> >  app/test/test_atomic.c                 |  2 +-
> >  app/test/test_bitcount.c               |  2 +-
> >  app/test/test_bitmap.c                 |  2 +-
> >  app/test/test_bitops.c                 |  2 +-
> >  app/test/test_bitratestats.c           |  2 +-
> >  app/test/test_bitset.c                 |  2 +-
> >  app/test/test_bpf.c                    |  6 +--
> >  app/test/test_byteorder.c              |  2 +-
> >  app/test/test_cfgfile.c                |  2 +-
> >  app/test/test_cksum.c                  |  2 +-
> >  app/test/test_cmdline.c                |  2 +-
> >  app/test/test_common.c                 |  2 +-
> >  app/test/test_compressdev.c            |  2 +-
> >  app/test/test_cpuflags.c               |  2 +-
> >  app/test/test_crc.c                    |  2 +-
> >  app/test/test_cryptodev_crosscheck.c   |  2 +-
> >  app/test/test_cycles.c                 |  2 +-
> >  app/test/test_debug.c                  |  2 +-
> >  app/test/test_devargs.c                |  2 +-
> >  app/test/test_dispatcher.c             |  2 +-
> >  app/test/test_distributor.c            |  2 +-
> >  app/test/test_eal_flags.c              | 24 ++++++------
> >  app/test/test_eal_fs.c                 |  2 +-
> >  app/test/test_errno.c                  |  2 +-
> >  app/test/test_ethdev_api.c             |  2 +-
> >  app/test/test_ethdev_link.c            |  2 +-
> >  app/test/test_event_crypto_adapter.c   |  2 +-
> >  app/test/test_event_eth_rx_adapter.c   |  4 +-
> >  app/test/test_event_eth_tx_adapter.c   |  2 +-
> >  app/test/test_event_ring.c             |  2 +-
> >  app/test/test_event_timer_adapter.c    |  2 +-
> >  app/test/test_event_vector_adapter.c   |  2 +-
> >  app/test/test_eventdev.c               |  4 +-
> >  app/test/test_external_mem.c           |  2 +-
> >  app/test/test_fbarray.c                |  2 +-
> >  app/test/test_fib.c                    |  2 +-
> >  app/test/test_fib6.c                   |  2 +-
> >  app/test/test_func_reentrancy.c        |  2 +-
> >  app/test/test_graph.c                  |  4 +-
> >  app/test/test_graph_feature_arc.c      |  2 +-
> >  app/test/test_hash.c                   |  2 +-
> >  app/test/test_hash_readwrite.c         |  2 +-
> >  app/test/test_interrupts.c             |  2 +-
> >  app/test/test_ipfrag.c                 |  2 +-
> >  app/test/test_ipsec.c                  |  2 +-
> >  app/test/test_ipsec_sad.c              |  2 +-
> >  app/test/test_kvargs.c                 |  2 +-
> >  app/test/test_latencystats.c           |  2 +-
> >  app/test/test_lcore_var.c              |  2 +-
> >  app/test/test_lcores.c                 |  2 +-
> >  app/test/test_logs.c                   |  2 +-
> >  app/test/test_lpm.c                    |  2 +-
> >  app/test/test_lpm6.c                   |  2 +-
> >  app/test/test_malloc.c                 |  2 +-
> >  app/test/test_mbuf.c                   |  2 +-
> >  app/test/test_mcslock.c                |  2 +-
> >  app/test/test_member.c                 |  2 +-
> >  app/test/test_memcpy.c                 |  2 +-
> >  app/test/test_memory.c                 |  2 +-
> >  app/test/test_mempool.c                |  2 +-
> >  app/test/test_memzone.c                |  2 +-
> >  app/test/test_meter.c                  |  2 +-
> >  app/test/test_metrics.c                |  2 +-
> >  app/test/test_mp_secondary.c           |  2 +-
> >  app/test/test_net_ether.c              |  2 +-
> >  app/test/test_net_ip6.c                |  2 +-
> >  app/test/test_pcapng.c                 |  2 +-
> >  app/test/test_pdcp.c                   |  2 +-
> >  app/test/test_pdump.c                  |  2 +-
> >  app/test/test_per_lcore.c              |  2 +-
> >  app/test/test_pflock.c                 |  2 +-
> >  app/test/test_pie.c                    |  2 +-
> >  app/test/test_pmd_ring.c               |  2 +-
> >  app/test/test_pmu.c                    |  2 +-
> >  app/test/test_power.c                  |  2 +-
> >  app/test/test_power_cpufreq.c          |  6 +--
> >  app/test/test_power_intel_uncore.c     |  2 +-
> >  app/test/test_power_kvm_vm.c           |  2 +-
> >  app/test/test_prefetch.c               |  2 +-
> >  app/test/test_ptr_compress.c           |  2 +-
> >  app/test/test_rawdev.c                 |  2 +-
> >  app/test/test_rcu_qsbr.c               |  2 +-
> >  app/test/test_red.c                    |  2 +-
> >  app/test/test_reorder.c                |  2 +-
> >  app/test/test_rib.c                    |  2 +-
> >  app/test/test_rib6.c                   |  2 +-
> >  app/test/test_ring.c                   |  2 +-
> >  app/test/test_rwlock.c                 |  8 ++--
> >  app/test/test_sched.c                  |  2 +-
> >  app/test/test_security.c               |  2 +-
> >  app/test/test_security_inline_macsec.c |  2 +-
> >  app/test/test_security_inline_proto.c  |  6 +--
> >  app/test/test_seqlock.c                |  2 +-
> >  app/test/test_service_cores.c          |  2 +-
> >  app/test/test_soring.c                 |  2 +-
> >  app/test/test_spinlock.c               |  2 +-
> >  app/test/test_stack.c                  |  4 +-
> >  app/test/test_string_fns.c             |  2 +-
> >  app/test/test_table.c                  |  2 +-
> >  app/test/test_tailq.c                  |  2 +-
> >  app/test/test_telemetry_data.c         |  2 +-
> >  app/test/test_telemetry_json.c         |  2 +-
> >  app/test/test_thash.c                  |  2 +-
> >  app/test/test_threads.c                |  2 +-
> >  app/test/test_ticketlock.c             |  2 +-
> >  app/test/test_timer.c                  |  2 +-
> >  app/test/test_timer_secondary.c        | 13 ++++---
> >  app/test/test_trace.c                  |  2 +-
> >  app/test/test_vdev.c                   |  2 +-
> >  app/test/test_version.c                |  2 +-
> >  buildtools/get-test-suites.py          |  5 ++-
> >  doc/guides/contributing/unit_test.rst  | 10 +++--
> >  lib/eal/common/eal_common_options.c    | 54 ++++++++++++++++++++++++--
> >  lib/eal/include/rte_eal.h              | 52 +++++++++++++++++++++++++
> >  lib/sched/rte_red.h                    |  9 ++++-
> >  121 files changed, 313 insertions(+), 157 deletions(-)
> > 
> > --
> > 2.51.0
> > 
> 
> 
> Overall looks good, one comment is to try and make sure the new
> functions are internal only? or experimental?

I think internal-only. I've marked them in doxygen as internal-only but did
not put it in the export line. I don't see the need for apps to use these
APIs, so let's limit the scope as much as possible, because we can always
open it up further later.

/Bruce
