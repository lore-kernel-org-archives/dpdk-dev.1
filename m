Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2026BC021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 16:43:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C686402CF;
	Tue, 18 Feb 2025 17:43:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id C57DF402C3
 for <dev@dpdk.org>; Tue, 18 Feb 2025 17:43:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739896991; x=1771432991;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Jlnk9/V0TMQ0qcW8lhDeRjbFmstnYINuGK8eQgI/fcc=;
 b=kHVXQw3hhNYQg4hhsGB0Jxs6rg/lBebfcIuCwfQoz4MGjdiLFLnXJEad
 dHLT6bcQLy63FQvMk8ovq64h/KgA3hzMGlGgPGnEBgHXj0JejZ5nnYrSr
 IfxT9e6q7cQju8dntH1dX3B91h0SUSxlI2KX0m+KfdCX+X+lV4HAPgAKd
 oYosw+W1mPRUkfsViiZGrChyQ6ENABznYtUvITcptm4I069nYQkA20Yhl
 uwqrqimxDKDIidGXKwwko1ghWiAzeeasFltQLdlpRXgfwFR4X4XJ77Mpb
 BJSqmQ3gs17zEFBrmDhTLfVcg2eAZ21kilda2w9VnU29gIAKen/WlIBeN w==;
X-CSE-ConnectionGUID: +Jfjwz0cT4mZSuAvgDUqCA==
X-CSE-MsgGUID: YkIOXwccRDWjgOTYn0wFvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40463258"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="40463258"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 08:43:10 -0800
X-CSE-ConnectionGUID: 6z8LSNAER4SI++hVrtT2Nw==
X-CSE-MsgGUID: lLVbnsrDTWinM7TvHH5pEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="114312382"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Feb 2025 08:43:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 08:43:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 08:43:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 08:43:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMtXZCi6jgp0zZbz6psOhZb92+CoC3Ht7JFnZGXFRYZ6nVk50/8y+/OYkf0S3w1IlkyvVhg9UtQzNbct5lWnvBPbqF2/+dx3f+1PkiE5EO1472eT+trp9MchH3uBOwFG4RdjLQiYYqA9YayF+2cYPZc9x6FENYmfMWmfm8/SuA/oDtV7tCJyQmnNWL9ylTBhm0EQYaUAGowSYjiKCBXYZ56Taq6XfJ1g1v52BJrCwLAu8a36WUf/sSCIozkU/J4ofU2C9/wjmOVwmSWb9kQnxrCpsjFHDKkX/0O/5LCrPKDsEuGdvWeQOUE6rK5qTmU7O3FsPTqsmmrwSU8R8HhAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qzYG2NI61/88xsSlSqtQXdlJU6bSx3F3tk//5MXhxc=;
 b=kGt/+ECEvM+c9jkNtwxo81+cCiWortASxYV69HNZFX/6wr+VjYyPSHDw62V4UE0FX3mpmkn3+LEwwYXKsewPreNrSxHT3+ViYiWO33LiokBwFrR6+b/ZjvvjhaeCUtyTpmN4mydvwQ1ya4G6duz2kPK9593HAf93Qul1qwo8lRwnwPNlb3KPiH4vQcFzGrba1/eoqv5u/GHWUHF3rbvY7ZXU+GOxSrehKvReAFCNAMltWOd3o63KDWuZRmD6dSvmsZLjyLby5rmI5LJPal5rVVbEYKCHATyLJZf3/fFb7ogCu6ztS/gUUlLln2cmjIdY9xjpraaP1oJTyXg2QJJEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8703.namprd11.prod.outlook.com (2603:10b6:610:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 16:42:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:42:38 +0000
Date: Tue, 18 Feb 2025 16:42:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 07/10] test-pmd: don't return value from void function
Message-ID: <Z7S4eRa7GviDyk7o@bricha3-mobl1.ger.corp.intel.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-8-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1739896329-1946-8-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU7PR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6c9d75-bd17-4f27-c47d-08dd503b4131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mJ65eo85OFZ59eKoPpqlunCgJ66ZRxcH2oOlAKnM8VqxaljSK1rBuifXQGnB?=
 =?us-ascii?Q?Z2zYZXVk9HBngBTijWyqEqY0dvjNuqpd6b1NlP94f6SLT8BJmHl+yat7FkOw?=
 =?us-ascii?Q?o5eVrg4Ur8vsjkoqskQrE94VkOo8uy2VSmsuoAccdMJ0DkKJkUfSwhoL0ASc?=
 =?us-ascii?Q?hQ++w/+JLnhGeDObIGXKyw9WjGE784JkyUrkYwUzD1fIcifZq/8HKC8gpm4b?=
 =?us-ascii?Q?JY19AUg6RLgKuovsSMQ3EabOfStWIGjGDptsEf1EmS4unH5nkuPicWTkZTyk?=
 =?us-ascii?Q?xMu1sUYd13oswFet/Y/jxkglOOegWuwXytFkUed0OxKpOggmNUJm1adU32Ja?=
 =?us-ascii?Q?ySlc2oTKCQlWI5xPJ+Z0B9Alr+HI9nruI6birz2uBCMppypgjpfS5VfSjqkm?=
 =?us-ascii?Q?Yl2LJV5Eg25heyUlsU27VEH6/HPE1Fr0c0P6Sj9+Dn9J13lzQ1tRMJZA6ScF?=
 =?us-ascii?Q?Su7sOiHZyFv49oKFBTnYa2ZmtQ6Cy11LXjyFsX5ypmrznXVIZmtnR4eXN/f4?=
 =?us-ascii?Q?okwQgDidiS1j4/zeCKaKO0qrM0skqOff6zhvq8X7ui9n8+WldSlG6BX2uc9P?=
 =?us-ascii?Q?sfIgfGuObiHjGjO6Cj2cEulb2CGOdcJLxJNY1wgbv7aaJNuA1kN42Lu/JuxB?=
 =?us-ascii?Q?mQJEHBNdPpBt1ODPTHxnzb+fXrkF5QZQsAskhu+5/ZIXxiGyEYbQ0nuRkcS4?=
 =?us-ascii?Q?mAGAbPuKgDbQXEAbzcT1ozWg/qIu1JCF17cH/xGBTMlXVbADq2sjtUkzOioo?=
 =?us-ascii?Q?wKIy185YFGJl15viSkeq00u3HVwV/76oydDFstOSqS9tAixNRqCbD0kDz5A3?=
 =?us-ascii?Q?8dfJfhF9sPJIOkwsZKINv3vlIogoALd7/pANlL2FDLUhjblt5P1YHkKXmfuP?=
 =?us-ascii?Q?zVMknHQs3gKCe3eKanBLH/0b39pRcr5EyVoqdqutrWG7nhqeFVa6WoWhcD0i?=
 =?us-ascii?Q?jHIglhO4LOOrh6/kc4/hOzUOGyGta2rfhot2wFv00c/FSMh4eoNOLQU+oEGm?=
 =?us-ascii?Q?PSW7qjl3VoDZgdg+rwrnkFBLFKzBzGoETpbn/SihsGaMd5e/HiOJojgTEIMD?=
 =?us-ascii?Q?0fK5JDnm1F9F6eVcRCSTW43OHRZ7eZvm6ZEu3voCqw7nGHPv1OdGFC74UbD4?=
 =?us-ascii?Q?weCEsxshx7dsfffXXvVFTAN51M6r2X8WpCz8g92Y1HIN0eSJMy4vIXLgy6Qs?=
 =?us-ascii?Q?LIfR68IxpvfjRWqAy7LqeCICCNM/QxeDAt2n9niCFg92Is/4vF9+gUKN5Eht?=
 =?us-ascii?Q?CRWVhzDxO27zOlLYPvyTbEqa0Kyjssx9AO75HlQBY2lqGjr2Ymy1FSAgPFHB?=
 =?us-ascii?Q?kxjcP0IMnF7aNC5Exz71lEkvI6kdbedH0sDDJ/VPnlPiSDHbRDWK5synz5Eu?=
 =?us-ascii?Q?63MPYRO2YrMr2z/zN3hWymfD1q2p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zpS1ClJlIj8IIIZ9Euc7BVbNvOwEJ4qkJVlo90c0pyE5/KApYwg/RmvPKsgb?=
 =?us-ascii?Q?0BKYINdfgChqdm0mOIISZNUeSkpJWEvUvSB5Cy8LRPDMR3DQzxamqKeWvGy2?=
 =?us-ascii?Q?6JXBA5lMVCsvS74ItC6ZCjQ+Ls+XrxAuIupg+3SB2OVSCdghd8goqsHGLLzW?=
 =?us-ascii?Q?MrnFX+2W12MxQNXHPC1LPaVGfTG7s0q61KtUPGs3inFsqkFOnOjHaHFbXKzd?=
 =?us-ascii?Q?mxyxbi2FayW4WLvyK0dwOZ8bdv896b642HKVkmtWdVYsJE3xpTM5r2iJ8JUZ?=
 =?us-ascii?Q?LoFNpcOYpOFWQcvJ2Ix9mSLuFwn8aJMT2txxNZO2un1QHuIYpLYlR6TbEJMh?=
 =?us-ascii?Q?OVRuyPntHl5k0CYJ9mbjlcC32anrCusMoEcj5EUoDMRyYomgXO6HSgju2TsZ?=
 =?us-ascii?Q?C3VkBeHDat6nBO3u5kasV0WgteEunMxaPDMyvPygmPeOgZn6xDaGKJoVtg0W?=
 =?us-ascii?Q?zKwzU9WqBlmTvnU3SqxVbfE9NDrJVQ2+C3eKb3mrnPOZDl6JfBf4a1y8pWkE?=
 =?us-ascii?Q?9ETPV6uBWutIf0/laf9nelzULICazsyBh/OG8UEv2vfsqNpiI9fbAoYzPXR0?=
 =?us-ascii?Q?5PsNpMNbhM7QCaZzcQoHvsqHPTSea7qDGI7Xkyh9JMvzxJU8+yv2aTZtcbMq?=
 =?us-ascii?Q?GA/MtV0MsJqwfUK/ooCD8btJQbkBk0T4bOeorOj4fHZ0+MqA+zaeI+o6M1OL?=
 =?us-ascii?Q?SKsZQZkz5BJbTP+mBQKYan4T+bi5nsQgCjSrZZH+EidZrQZgJ30SMSKJMKpG?=
 =?us-ascii?Q?DXsnqUB7gs8EkmwLOmKHh4YA4FAuw73wWnS1l2KVIXP1END8jDK526jNoHQ0?=
 =?us-ascii?Q?7oeDOnC1ZEGdfn30E8lRPttCmClhG49ui5Iv34YJwDOnYbQP0iumwz9jwBir?=
 =?us-ascii?Q?arU2R8U3JRQX5wuTVBIvkowscXL7ld5ZwEZT087Z4QC4jC2ygMSBhADZDKq3?=
 =?us-ascii?Q?GEyTeG19zuRTtPI1hnGFDKdI+io3GLRMiLm/HXz1x3ddP9G4s/k4wMKnOFE4?=
 =?us-ascii?Q?Y5ZTLCGkdcVfmGyNGNIhFAOvfFuZQIzYq6P+tgKEjsCV8wlL8BEgtKJTaBmV?=
 =?us-ascii?Q?2UPRcD1n+mjM/DEvB6QHuX8SMzg2jt5D6OAwJfEgB/lsXfRxIrW+cphTs9YN?=
 =?us-ascii?Q?azv3QJqsxE24CWBnu+JcTpYlNIeYeLQY0kotfgV/eRO+Cl/RPXVyOeIOF/1f?=
 =?us-ascii?Q?c/GrxJu2hkBQv8L2Qc5k1e9LsiCZbj/YMMwMXOS48ntorWdTuy2aBYvKviXI?=
 =?us-ascii?Q?zgxM2aox9Bc3dQ3SAgoWKteHck6aD9leof0qOzXlfYJ775WZ5aO7L3HMfe/Y?=
 =?us-ascii?Q?ZD+IpNvbdXCF1+NPE1mi38nxvvUAYCwJTivsBeMrU+ukASNfEUlNeh6cTR58?=
 =?us-ascii?Q?8xqrolvqwyrmVKtuD39ZsvplYzp7vBUEB/DLQnysdvvFto0vxPp3uu4CXWyu?=
 =?us-ascii?Q?VZQQ9VlnPYarIqWNMu/Z4LkywqW4mJFpl33rP4SRG16ssq5N0sli1qMYU8N6?=
 =?us-ascii?Q?zPYK6ie6HgGlzV+A7uJ6Q/Laa09S2WUrEiRJVI2NKleCLj96WRW6lu5o9Crm?=
 =?us-ascii?Q?oQ2RwYU0z5YwG0+njyss1StnESmd8MUuTAhyiIZkvGEY+IZHAvPX8xbo2qSk?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6c9d75-bd17-4f27-c47d-08dd503b4131
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:42:38.5481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0AA9G2jLyiDqMX1togTKzG7/jGA61CzWwGJviRJMoLIjAfPzLupkqzHDTY8OcQUXzX+Woh4hG1Idb0y8oeaOLqINJD8lU+Q/7gOzSO/nZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8703
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

On Tue, Feb 18, 2025 at 08:32:06AM -0800, Andre Muezerie wrote:
> Compiling with MSVC results in the warning below:
> 
> app/test-pmd/cmdline_flow.c(13964): warning C4098: 'cmd_set_raw_parsed':
>     'void' function returning a value
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

