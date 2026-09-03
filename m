Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E270C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 16:13:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57A7640647;
	Thu,  3 Sep 2026 18:13:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 22191402D8
 for <dev@dpdk.org>; Thu,  3 Sep 2026 18:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788451986; x=1819987986;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GdmZCXF33Mwmd+9K5AVQ7b+Nvgp5CTmU4Am/qZzajRc=;
 b=TSkVCx5gUYj7Y2lEwr7i2xpMUMKcST/zAXwQYLXb+3gPxCZyOK+FoEwy
 nWbkdbI5MY1laSP+SFfh2hYWCJjA++kiPbmWIx+dJt+tMNags6tLl25ml
 y126yobxe1dknpN1ndARPPT81bmH8U9JCcVDH9lh1nBKTOkR5hS1GCple
 T8JIzC4qJs+3/sQ8rLrGzEyckHPFWpJFzy3DZu5fMWN8kbNjUQo7NUJSN
 +t4oqBpAaMvB/JuN6MI0vsDONCq9mcNm4nV/NVVFpuXmRmb3hvHh9aSC1
 MzdrtYzeK97IehPN0SGdIdNA9kgWOlArpHe9oobNyo3w0COIhBT4gd09k Q==;
X-CSE-ConnectionGUID: xfaaCCKfSg2Sr6sIcj5zQw==
X-CSE-MsgGUID: CebQ/AVkTTuTfGVGlOochQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="114486663"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="114486663"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 09:13:05 -0700
X-CSE-ConnectionGUID: iPb2lE8vR6S9AGZdULc1iA==
X-CSE-MsgGUID: UAV2PSbnS4CUXjo2gBdAVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="268460532"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 09:13:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 09:13:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 09:13:04 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 09:13:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnUlqYzKPGbfG2agz1EqwQTAU9KhjNJpcP76JOdYw++x4+L/T2Y4Be5eS60nNqvHNaIwVvkF9DHtK524QfidhFRzsyHNalRJZO+pnah1U841UjoZj/E5lbfb5yeAXfz3afkKw3wfu0c/4iXy9pWDEx/sLAVTBYiMggHAU7S2XUWCYcpGr90p7aunqceqLNvISt9JFhq/Z8H6Fnu/DFlrl1ZgiJRr2ZgO9BEo4a+FXx8cyY6P6sXQQa+4enywpC379s0qDLeKnN7ySOim7MWf89grjnnZ1TVJaH5JnsYbdumAlteCUC7Lz3/MzFb48szqSENeSBadAbQmApycTnElvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7G/ppdH+B/dtimXgYr0TSERfEcu91Ies8ZMgpEZ14A=;
 b=PzTSbArXWWFXyS5TFv4fC+1S2hB25N6Ao+P3Dj4pvv7znxbMjfcNLUW8GmEniu5WqZAikiKKnUkk92fPIR2CDBlwQqAyTTPxeCaG9SxPe9VQpC15hMK62mOEoSG6fYjf8B4ohYahmTwmA2TUxHzxjcU99sOoI1R8m5+xD2amu/z4JZ4blCiM+mHxSyzus0hPD3k00AgLr4KTN8Xmqzb6VtuqNa/UJWpHfpDuVKnGsREFqnco7cBLfbqZvUD24u6/esIJ4aI6phtlmTAFBTgjOafBCa3bnK5zrZFCBhPSDmXEBSKFnOERfXH7QLtOtNiJNxOf0tg+5nwGycnspq2qCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH3PPF6D09CA9CB.namprd11.prod.outlook.com (2603:10b6:518:1::d2c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Thu, 3 Sep
 2026 16:13:01 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 16:13:00 +0000
Date: Thu, 3 Sep 2026 17:12:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v4 02/23] ethdev: use DPDK byte order conversion
Message-ID: <apmciLmF_jXUnX3U@bricha3-mobl1.ger.corp.intel.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
 <20260806051004.166778-3-stephen@networkplumber.org>
 <apk732FF5TwghkqP@bricha3-mobl1.ger.corp.intel.com>
 <20260903090802.30707f54@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260903090802.30707f54@phoenix.local>
X-ClientProxiedBy: DU7P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::13) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH3PPF6D09CA9CB:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5d453f-1d2b-4381-f62e-08df09d639cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|4143699003|5023799004|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: /fXgCMAZHQhpC6vqQ7hDeXHUac6XJZPVe0WDsT8BnVPuFvgbRsic9dnz6I9gzb+5zd86QNNO7tu16wKAzeRJJUTccQVW4fdj5B2PkX27wdHGlaJIRWnSy8eRUVMa2KO9h8nRo0OTK3Jqs0wUFDXQUAb6EXVgalb6kjkhhwU3zWTQVMx5np3uyoLa1W4s6b8LwxWd4n0oZvOTspHcJHxn6IIxirwSwG3VIdoESUk9io4i0priljNrAny9TDKj3RFV8DXUCqffag7Ve/ECuSvQQmve8buwkq8OLX9ZD21nyE2LpGX6r+Yp+kbSGKlkVmRAbuOd4B/wU6ovtWaUwAkbB2wormecIJtToXorlnhIaNSh0VI8nbjH5RZiTXgEhVuQtfUhCRRw4YlX3FTKyYd4+Cb8rI43qzcByZaWE9gZlizY2W3XMCc8pPapy6wInYYQeUsfNJk6+xxqUHb0XZb1z/mdn2gb8vr4n7c1+1Shuod/4kk0MVuJ3HczVkzxCZycKOdJEY9NKzMPx/LDpYGPyGpa5pQgf82kB8MWYurEArjxht/4gS0KbfOWl5Wf1Z+KsZNzS9kYdUCDoMrb6hFHI/GsOviiYtqrJcNV6vlsINiXdKIWWznAmxgTeyeo/mL6yKlVTTTaI48HehIM99X1ue9DaY27efqVEB3s+sEP03s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(5023799004)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WsZNRhehmRqs/ObC4ILGIzi/1bBSsyXstTcsBtkZJ5nj3FipCufQcS93pifP?=
 =?us-ascii?Q?AkIPeyWPd/jbpJf1h1uYjv2/z4zhiviBs4Rk5U2bBhdnSTcrFk2HvuBq7XGt?=
 =?us-ascii?Q?NJY5f2U0FJWSp/aIHTrsNH95ta3y4iCtUIpwVtoV6XBXjY43DDiaLuKuhihW?=
 =?us-ascii?Q?WkvBEIPveCHZnSKM+GlhspPuYmObjHbxWwZcaaRisyIRaKQL1wPJsCHiDI0Z?=
 =?us-ascii?Q?Zmu6B+mLOi8bDz4bNWI64wbYYWt/zYwNuv54/BGdtXCRKkwrVkGZT8r98usW?=
 =?us-ascii?Q?5A1luUfteaNYtf0FiogKHD6iQZ+2IbSF20xgaGWtyGxQb6Tua0+NNdWvQA5J?=
 =?us-ascii?Q?wjQSjL8XjsjJCb+ouWajHkB3HycKZZ84cNnCrD5H1J4NIMXusT6TuJs0r+jC?=
 =?us-ascii?Q?0btYgh5zGwEA+I/RoVSg7QeTGHJT5ZhAcyfI2ZWgCSw7UoE6EsQYYwmO1Z9b?=
 =?us-ascii?Q?/+CCnmkvJpqJDQFo6XfLwi72bJBk8ijTO3EMePtGjyJko8E/Ga1dTflRnmHY?=
 =?us-ascii?Q?Yr4sqXdS2gb51XQ5z3nBU4MISTtn6Zwkt/IRaCClXPBt57dJjJ08aiuT8KTH?=
 =?us-ascii?Q?qAT2fPrNOfWNs2JxjssNNy84qRXnFrN0EXRndFSTOvFTivGCx48KGmA0QDyz?=
 =?us-ascii?Q?/SXpYG2EudzXAf9oFIfXyH+BXHS2A7CoVvNbnDe+Cl/UOU4Fe/EbWKOBrwMP?=
 =?us-ascii?Q?6zZ3aYyOMk0G0tEOYWR5RN47e2PORewmgPdIsuUgtCrAfX98qBPnntPXqUlQ?=
 =?us-ascii?Q?YIvTXf0XsDWeLsgibLIh1CKIKeb36GyoOltiTKNT1TS3d0JKFzLkLeWd9kwQ?=
 =?us-ascii?Q?mR+RqnEiOJwNAdRD7WFUfOuGPA3AHpXl41lPphZWU3UqIZBHSMdKxk6qi5Gv?=
 =?us-ascii?Q?xyRjFWIa5gNjsWQIYCzg5NHCIqdDg0YgEEX7p15vnb4oofvDc6K0G8gZan5S?=
 =?us-ascii?Q?IrNN9irakyW/3cfLd3WZwVnbATowITHr7FAidnzLfjODFtV/N98gXxp5VVAM?=
 =?us-ascii?Q?wuhysYXIGRxHs8xeYNOfA32KCgOxpLs8dBiTucVe9yrHOBXey+l5hgPfGkJJ?=
 =?us-ascii?Q?NifyyDMwJwhJzOj6zKuWZ0VtP6dOFih20cbmN95iMqA/H31dm4kme9umNPQK?=
 =?us-ascii?Q?5IQTdWsL1SLD2vT/hK3lLO4yhGngdxEPjobDyTNVvKMzh/KHDKzpaDyjTWpE?=
 =?us-ascii?Q?TsoWufINjBqMq8c1zwKsNk/O0J04FXMsOLX7bXFswKaQwwyvo8gFxP89B+/K?=
 =?us-ascii?Q?9sujQiDshCa42E9ydXcURLPMipkU1KiwoZM49oUF/er8Poq8SuOIj3tEM6c7?=
 =?us-ascii?Q?XRv3zKzjzpt7GTneEvXm/d0FFaoY8rIDLAzps+mSipmcEsUrO0iXGH+VWQAk?=
 =?us-ascii?Q?uV47rzP6HPArTREwb3ZgwLJUUZH3DOMc6iIwsbv1JXdqysaCmqadEQREAn/l?=
 =?us-ascii?Q?w1a5lpOdFjJac6cdWOmbTYpW6nGYol+TJu7bfTUDBA44F7buGaA33tcbIcty?=
 =?us-ascii?Q?7dqbd+fmdeRY/w6BWIzhLPDKJ7FIAjdudjNnU6+hn74oqCgI8BOfGw/IBau3?=
 =?us-ascii?Q?22B5CySLJxNWcVSS5do0EEmXSwC+dIixT3apCBmYk/x4k0DQV6eRvGA2SU25?=
 =?us-ascii?Q?SvIwuIK1DbpsF2W648K3G6VuCcVIvc0sKHd3zAyFCNKgordu+Cc0++OZJs4Y?=
 =?us-ascii?Q?3i+17L/Kcgqv+nqAf0WgyDtJnClDcQVD/UJF7wt7pv2gtFzo5WLo9EYYDOU2?=
 =?us-ascii?Q?iH7YvxPOk1v9NYZat9HgW09FLJMruco=3D?=
X-Exchange-RoutingPolicyChecked: OO59/bT2X3KqXAm/2Xb2mlO6xzDJY9gpoNekN/4ob2/93+LSaXO3w5LpNPd5upKnVxqSznoihQZJaPQWNjavW8RzogRVQ4lTr2KaDypvLyK8xXq/SQq65gs5GWAlGllwTaHJ62jFtvzElLOwMK56hvRnkR8IZwWbgaXPGuTqGo4RXxvo2UQ0TaOQQ5yUwdniG5PcbZ+5WvzRyuTvm35PBLasac2aAIUqOeEpwXRCjr+X8ge+paIQLkV1Py7VWsiM1mdqDaRiF4FO/XQu/pqVrmvVCa3saiUQqpSf4LZpxFFTOPiRTmFsmfSKjAGmIwJxVdUxWgkMq6GLb8RNsfNRZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5d453f-1d2b-4381-f62e-08df09d639cb
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 16:13:00.8811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDCA1HdwbPWInkbtIpY4JUmRYQoRCS33oJbVt20BnkD0xOHr6/X7yXLELc4w4PW/Pq49DuKgjJTAid/omc5ctg7EOxYhe737BxNitYGtSjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6D09CA9CB
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

On Thu, Sep 03, 2026 at 09:08:02AM -0700, Stephen Hemminger wrote:
> On Thu, 3 Sep 2026 10:20:31 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > On Wed, Aug 05, 2026 at 10:08:56PM -0700, Stephen Hemminger wrote:
> > > DPDK has its own byte order macros which are preferred
> > > over the POSIX/libc ones in arpa/inet.h
> > > This resolves issue where this code was inheriting the
> > > inclusion of arpa/inet.h from rte_ethdev.h -> rte_eth_ctrl.h.
> > > 
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > ---
> > >  lib/ethdev/sff_8472.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >   
> > 
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > 
> > Ok fix, though I would note that this fix is nothing to do with the removal
> > of flow director material.
> 
> What happened was that when flow director part (in rte_eth_ctrl.h)
> is removed from always being included by rte_ethdev.h, then this
> code would not build.  The code relied on the include cascade:
>    rte_ethdev.h
>      rte_eth_ctrl.h
>        rte_flow.h
>          rte_ip4.h
>            arpa/inet.h
> 
Right. In cases like this, then, it's better that all the pre-requisite
fixups go at the start of the series so they are in inter-mingled with the
actual fdir removal. In this case, there are more fixes than removal
patches so I think the series needs splitting (as I explained in another
mail).

