Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53214C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 16:49:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A600E4026B;
	Mon, 14 Jul 2025 18:49:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 79D744021F;
 Mon, 14 Jul 2025 18:49:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752511795; x=1784047795;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=RJ71J9IOxAEg1lGJPxHPdFw17AyRP0xshkZasV5AT0c=;
 b=g3rHxPntfFaHBeVR1uGowR4OJZf3LUwQDhdFDqP4IllEYLjy6B0SgluB
 24unIrEK1WX2qkdsgBrHcbWDT6OJslqe5k4ONQtvvA2xRKUE0BJ+3jr5G
 CAKUyRSFPneacCJzAQ4eE69rJ+Ho8Gw3ccfiXvpV7RpQuJ+w+vjZ7ZeKL
 h2/FPKdqW5vZ0KGMBtR+w76jvTJEEQCpf6IAa2E5FkKBMCDLnwT+HcBlP
 L7zt4om0Ss75m3bljhzmeKGlRTW2J3rZp1i2K3kdUYCNJNqunpvkpwrsI
 JeqInP1gFP1rdPaBroYEcKPxVb2Q+qwByY5/oWrFN8Jyv8q8FHQdpdFRL g==;
X-CSE-ConnectionGUID: TsB3vw3yROy1N5SKgvN5vQ==
X-CSE-MsgGUID: aq415R+5QmCr8xSRqvh8eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="72159102"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; d="scan'208";a="72159102"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 09:49:49 -0700
X-CSE-ConnectionGUID: vtL5qDMfTHKa2X57UQaZVQ==
X-CSE-MsgGUID: XWVK40VYT5a2i6Hb8B4wQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; d="scan'208";a="162531916"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 09:49:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 14 Jul 2025 09:49:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 14 Jul 2025 09:49:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 09:49:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWLhv27RmjHwv+Gt9lb1wKV5ipAPV1yPpnp0EXPxfw7DwpTr5lN7YMfAJFdr+Q4/5yfZOcUxGvPfLAKjI5rm1VzwNLlneHutSt4K38D9ORqcfG57cLUK7JIUBEaqE/2YcGfLr8cXj4Cq9G22FuzDhP7fIPJKqzLjUHPo1T0uiDZzQ4G3TchaVwoHSAHxrlSy1tPAUt6bES9HBlR/qPqxtkeSYLEesxSo+1MVmqaEnL5pAav2+Lnxs41bkSCWXzgdEddrlCxMkC6oOsdCWkXwF/1OLlt1rRs5SB7uqMMWi8dR6IJ6x//o3xt6TcWJlHW10eL8JMvdS+RR+/t+DuUcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8XpOcHqUDOVGPTQDTs2/jNa0W1mYxACR5C/91HKrLg=;
 b=sIAiVB7h5Ytxcip0x7VS47mbDvKqSCRvQsQ/sxeso9UpcsFF4XYkvGDuaQPv7nj5d8fsP2Edj5eonGIrbqHfFmysql4VeyFuCcZZm7nL+fmDp3UsjU7eMvuzV1ekWMgkPqDjUhYzMizCHTsDfBZDGr2vUy4V4nGPWH0NJvP+Oq98JL8gVfegFUBHk/sVEdod8/vEeYilvonDDUkB45Zp/kIEsXE58Tenszj4xPcQD7eRAQ4fJqwq4OipCNbo+DWO+gDqOZcLde7SQVMId+jjZEC78YFuiuajmHE2o07RFvLGHsvtrRHv7C9kD2qNDoSJOGFpco8ya4Zaj6pP68s0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 16:49:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 16:49:24 +0000
Date: Mon, 14 Jul 2025 17:49:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Dengdui Huang <huangdengdui@huawei.com>, "Vladimir
 Medvedkin" <medvedkinv@gmail.com>, <techboard@dpdk.org>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Message-ID: <aHU1EJNHLjmynoUs@bricha3-mobl1.ger.corp.intel.com>
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDB4@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDB4@smartserver.smartshare.dk>
X-ClientProxiedBy: DB8PR09CA0033.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::46) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4701:EE_
X-MS-Office365-Filtering-Correlation-Id: 757aa10b-7a4a-40cb-6481-08ddc2f663a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?t0OPV/mU+XW1yDK/Vitv468sCceFaXjJ8UTikPe41xFpAu2gzLbbfcIWvT?=
 =?iso-8859-1?Q?e7s+Hsets0cf0zUTrgVmZHbbPejW9LLJG4zG1IMAPIUWA5+SfLie/ZwXzf?=
 =?iso-8859-1?Q?QVSLFY/T+iyZnDiCdkJ/d+ADRXih7K0Nci+tiiDW9kOVmmgqxNHE/WmqX/?=
 =?iso-8859-1?Q?ebE6qyDVfBhNiuyRDj69gHKwEn8z5I5xXcf0x/o9GjcFbxNTc2hgKQtzE2?=
 =?iso-8859-1?Q?PL0++Dow7KC1DZRImsTfOvwW7TvscM6r6lz6iv/dMmFUIXVuAUk03Uzv4z?=
 =?iso-8859-1?Q?ngZB8+XvopNs8hC+fvyFueOv5ZRCL2duTtP4SmCLMX6iVaayGEi4fMTbCq?=
 =?iso-8859-1?Q?AgLerzLUIZZ6UmF1UfWg9hhKfQ6Zp0dyw9VmD6+BGnmr5WOWjjn0tcqvAg?=
 =?iso-8859-1?Q?KV4kBFV8HyeYBrXHeNCmeRC+yqH6Td8eEJrjdUjVhzrazYWlQ/h5hvsHVg?=
 =?iso-8859-1?Q?t77M6sU7NOaS4ktBFOMohg154d5iDsjMFJKXFNId0QuBWtJs6M6yWn00wn?=
 =?iso-8859-1?Q?8TXuPdgWqboE6Z04GmQ4gpvlXuBac6WptM1my4qOcXIBoN83KI+vSKD5Ws?=
 =?iso-8859-1?Q?AmIanLgOH+C8mFnnl3fhqlEHJ4+mLOj896bKnls74XxE9T34zvNtx4EoJd?=
 =?iso-8859-1?Q?uZp+vGsSFsB/uyeQX8pAgXNkbEClNlh81q8IyzIaqkE9MECfChgK5Tr6GY?=
 =?iso-8859-1?Q?6GlwJOVaUuGW7BYjyZIJ1BM+qIWbc/S/cZPXEwAenvMr4TyzatYI97bFPf?=
 =?iso-8859-1?Q?HO7JNW0G5lP0Uzzy1Ty4aZ1zjckB/tljzLjdfqR0RdRQHmkTgcb2Ha4RT7?=
 =?iso-8859-1?Q?ZkHTGr79LFOSrrNt4vwMAE3FtZNrs3p8jGPnGICWv3vZ4gDNcA549GbHrz?=
 =?iso-8859-1?Q?QJdSxySN92lKZUffosc+xTvBrjPIkDIL/Ct2iIOUM73ztkEraURkkYhh+X?=
 =?iso-8859-1?Q?NGziRzlmf3v736sRzuxs3vDarpF/nw3uqbJeLyHf92YTAI3ykuqwu3129I?=
 =?iso-8859-1?Q?tEdl1GKGORQJTrRGo9caid1ngDc3MHYarZeV5JNeqdRom3/jPDO209SmZA?=
 =?iso-8859-1?Q?CVyZhd6RMjj3InFQBsHQilQbzQd0sNR5UWbvMON4CnDmRchaUHYRHhjICN?=
 =?iso-8859-1?Q?k3PG/vXZiZY4P6ZjWXkW4UbeaocmcvL7e0K16aYOUUDDNKMKEALjbjTAFN?=
 =?iso-8859-1?Q?hiFYv5WhBC8D5gWioSRyH/zEuB22k/iPLNXu+AVOtP6+3R8geDsU9y+O+3?=
 =?iso-8859-1?Q?adzUd6MPfEuXerxgB2YDcOP8iOlQWLQa7+YYjPt5wQ+90dw36I4xSJEDUy?=
 =?iso-8859-1?Q?UizgCEBP9JBEkf5H6cPg8zsYTg3jWj4wIWiJ5zC+B1+xmI+Poc4j0QqNEB?=
 =?iso-8859-1?Q?UNZOOOXU9hSeG0iTTRzCjJZDJf9mMH+jycSm1J1kCDCWaggc5gfBIEDgff?=
 =?iso-8859-1?Q?D4pvCoMsU0/HHBa6NoThaDxkiJJCC4nDZf14T2yjEaBFF3WI3HisXZSlV1?=
 =?iso-8859-1?Q?w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?booC7UmlMY/hmj9kfbDgWzVQtgF4xwjtv/GJOA/P3iBUGSRnm291TzUVLr?=
 =?iso-8859-1?Q?HnnI+l9wRamXfwfV5kBtFtxNcjt71MrLrtXigryiw1D+lI2s5aNjcQ+SUP?=
 =?iso-8859-1?Q?b7/SoQbNnlCsGIJ+VZ+9ojTiQUgFwbSkRkhqXGAmJI+uxZIXgpcD3/qU2Q?=
 =?iso-8859-1?Q?YN3k2FgPsmCknpo2lap+arw3ABb9Va85xBUgHTXtlDjMZYm5S70At92dCf?=
 =?iso-8859-1?Q?pOdyv9+UFggQLZCoZGpemNV4egmR6fKiHgv+MjL1733/gjOCMHNG5y3xWF?=
 =?iso-8859-1?Q?Q1d0/GMnePe5yunVoxFfn6ToqcQmjfx3dplggfDMk7uebUcwkIMOUz2CuL?=
 =?iso-8859-1?Q?nKL7zV+JXuyayVw5f1Gj0YjdUaaNf4s8aCgEn6kYM054QqN78hjqsOlT29?=
 =?iso-8859-1?Q?80SV02iicW+kqDPoZokUTYjD2XCLMLIjOyZM3vFr43fDJ4KQ0O+RvKSk6G?=
 =?iso-8859-1?Q?WSegVHFsJ5aiRL4uMSUSSK559Rx/6U4mZAPEBiuwLtLKum3oAiL72HyAMJ?=
 =?iso-8859-1?Q?Z3P3nzg9g3vjFoc2IkegkwdKPD3GxXaU+Tg07buQ9RiXAnN24KTtFsri0n?=
 =?iso-8859-1?Q?9et8RmEORnXSRZ/BINWZJ4IH+xBZpDZUc9iKHpU59qHmT2FNXci5GFNo5S?=
 =?iso-8859-1?Q?HC+/j1tqTZviWiH7OTrR6KbmSrLtrqH48Y2gETg6WKhFOPAkNLL2R+zVw8?=
 =?iso-8859-1?Q?o3PA23X551/eIHzT6LkXXqjBKRX9LsCxrHjzhbEkYyvo9lIJvZMe9dBSHH?=
 =?iso-8859-1?Q?QLzt71tzeseU6zLOk6F4B42B8MwVcddHmh4ut8YuqkizAa0TUOH25p+FEq?=
 =?iso-8859-1?Q?4DcaJvNYU5RXDE/n+ktDh664bKBB7bsp1uEIDRcNrVnmlHj7OPAI5HUTDG?=
 =?iso-8859-1?Q?CkwzbrjnxwfpbLtVyCaSgEtR1cIGFnpF3ZNcXVo7S6baAHDYz8fwzgioct?=
 =?iso-8859-1?Q?+EVUXR2GBmcZhNFghx22YcQ9UDKuWIc7Sf1w9qulV71VEstWJuHrBRfY/J?=
 =?iso-8859-1?Q?x588O1UkywU4Fl+4dCNeTFAdBpt/x8lW9/nOWqH5hQeqPOhUcRa0xRdYyK?=
 =?iso-8859-1?Q?kZyzqPYy27Pb5aMHGgub5IptbD+5tR0wXI5/JvApoPR12+R+ieRNW5a2NA?=
 =?iso-8859-1?Q?MWWF/4TeVktsEqwzl2jVXAPNu+NVjRBMx8ad28EPGHwkf5gK4M28RWio/0?=
 =?iso-8859-1?Q?qROREJPLyqi71n7ixpcH3/XHflEClR/GeAEKK7F4EwddenMea6Y2recQTh?=
 =?iso-8859-1?Q?kVLWHrOg5/KUgcu89woBpZe4OwmfnUegFMO4XoYlLI8KjUeh3mzTHxxAtP?=
 =?iso-8859-1?Q?bmnIoRK9eoZj4aRMZwY6/4R4hCCf775PesqKMiiLvhDRsm3zJno8FI4nej?=
 =?iso-8859-1?Q?/2Rj4qkMnu06tOIleeTxmx3f+uzCLsC+eUO128jFq2NiIXvOeB6kRkrxMr?=
 =?iso-8859-1?Q?yBavor1dOmepv8QE9PeGkg+huTjXDNvvE994m+KlRhuxQSwjNDzraQSumz?=
 =?iso-8859-1?Q?FhXlCzqfsI4HtATPNcjXI4nL4NxG9O7USEuN9aAco+x5BOc57DXOActcsr?=
 =?iso-8859-1?Q?8Owove+E4y8FHWDGdYtoPHz03i7MuJ3TjFxtOhv3yU1ywynJOxF6Eb71IH?=
 =?iso-8859-1?Q?SI4lreuL44hxQvl8pt4KMYGZV7VHUSH45MjgX4ffO8cFwUB53SlAr4MQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 757aa10b-7a4a-40cb-6481-08ddc2f663a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 16:49:24.8604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7I05OgXZIkuCLe3BbA53bdrQ1TeSpHfc/k3/irnAKNiLNE6slCtfykOloX2NRo7w4Xar06QNvHCwIfnu3IYwOQ0aLr2UTWw1W11QqSPfo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
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

On Mon, Jul 14, 2025 at 06:33:43PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 14 July 2025 15.30
> > 
> > The behaviour of VLAN tag stripping Rx offloads is unclear in DPDK, and
> > not very well documented. Even the documentation that does exist appears
> > contradictory.
> > 
> > For example, the doxygen docs for the mbuf flag
> > RTE_MBUF_F_RX_QINQ_STRIPPED says:
> > 
> >   "If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPPED
> >   is unset, only the outer VLAN is removed from packet data,..."
> > 
> > but the docs for RTE_MBUF_F_RX_QINQ says:
> > 
> >   "If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs
> >   headers have been stripped from mbuf data, ..."
> > 
> > Without a good definition of what the correct behaviour is, it's not
> > possible to assess and ensure conformance across drivers. Update the
> > documentation for NIC features, ethdev and mbuf library to all report
> > the same information: that VLAN strip feature is stripping one flag, and
> > QinQ strip feature is removing two.
> > 
> > Summary of VLAN and QinQ stripping behaviour as reported in docs after
> > this patch:
> > 
> > +-------------------+----------------------+----------------------------
> > +
> > | Input Traffic     | VLAN-strip on        | QinQ strip on
> > |
> > +===================+======================+============================
> > +
> > | Single VLAN pkts  | Tag in vlan_tci      | Tag in vlan_tci
> > |
> > +-------------------+----------------------+----------------------------
> > +
> > | Double VLAN pkts  | Outer tag in vlan_tci| Outer tag in
> > vlan_tci_outer|
> > |                   |                      | Inner tag in vlan_tci
> > |
> > +-------------------+----------------------+----------------------------
> > +
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> I think your RFC is not a description of originally intended behavior.
> However, I think your last thought in the previous discussion, speculating about the original intention, was correct:
> 
> The QINQ flag and the VLAN flag are completely independent.
> 
> The QINQ flag refers to EtherType 0x88a8 (QinQ) tags, and vlan_tci_outer holds the ID of such a tag.
> It can be the outer tag of a double-tagged packet (i.e. the S-TAG of a packet with a C-TAG (C-TAG = Customer's VLAN tag)), or
> the only tag of a single EtherType 0x88a8 tagged packet (i.e. the S-TAG of a customer packet with no VLAN tag).
> 
> The VLAN flag refers to EtherType 0x8100 (VLAN) tags, and vlan_tci holds the ID of such a tag.
> It can be the only tag of a single EtherType 0x8100 tagged packet (i.e. a normal VLAN tag), or
> the inner tag (i.e. the C-TAG) of a double-tagged packet with an outer EtherType 0x88a8 tag (the S-TAG).
> 
> On RX, RTE_MBUF_F_RX_QINQ (and vlan_tci_outer) should be set if the packet has an EtherType 0x88a8 tag (as the only tag, or as the outer tag).
> If it was stripped, RTE_MBUF_F_RX_QINQ_STRIPPED should also be set.
> Similarly on RX, RTE_MBUF_F_RX_VLAN (and vlan_tci) should be set if the packet has an EtherType 0x8100 tag (as the only tag, or after the QinQ tag).
> If it was stripped, RTE_MBUF_F_RX_VLAN_STRIPPED should also be set.
> 
> Same goes for TX: If RTE_MBUF_F_TX_VLAN_INSERT is set, an EtherType 0x8100 tag should be inserted with the ID coming from vlan_tci.
> Similarly for TX, if RTE_MBUF_F_TX_QINQ_INSERT is set, an EtherType 0x88a8 tag should be inserted with the ID coming from vlan_tci_outer.
> Any HW inserted tags are inserted as the outermost tag, i.e. after the MAC addresses in the Ethernet header.
> And the VLAN tag insertion (if any) happens before the QinQ tag insertion (if any).
> 
> Note:
> With this behavior, VLAN Stacking (i.e. double-tagged packets using EtherType 0x8100 for both inner and outer tag) can only be partially hardware offloaded.
> On RX, HW VLAN stripping will strip the outer VLAN tag to vlan_tci, and the application must move vlan_tci to vlan_tci_outer and manually strip the inner VLAN tag to vlan_tci.
> On TX, the application must manually insert the inner tag from vlan_tci, and move vlan_tci_outer to vlan_tci, and HW VLAN insertion will insert the outer VLAN tag from vlan_tci.
> 
> 
> Support for VLAN Stacking would be nice, but it should be added as a new feature, not through a doc update.
>
Yes, I suspect that some of that was the original intention, but I also
suspect it may not have been tied to tag ids. The documentation I
quoted earlier on the QinQ (non-strip) mbuf flag suggests the alternate
way of working as described above - which further confuses things.

However, the main concern for me now is what way to current drivers
actually implement this.

From chatting to Patrick on slack, it looks like the IOL is currently
working on testing the VLAN and QinQ features, so hopefully we will have
some idea shortly. To avoid major breakage, I would rather standardize on
what we currently have implemented, rather than shooting for an
"original idea" or a "best case" implementation.

/Bruce
