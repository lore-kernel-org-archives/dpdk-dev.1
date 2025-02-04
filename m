Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD64DC02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:36:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 319754025F;
	Tue,  4 Feb 2025 16:36:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4F338400D6
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:36:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738683414; x=1770219414;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FFKcYk/msP8AeZDFS/kSH9Dlj5RfS1qFNDDv07mG4hQ=;
 b=CUXGLzyT9iaUSofqS6lFmxHWbsVWS5xSDuIrwClBLF2dOurPrlKyV+Fi
 cmijUdIbiRKuyHh59GRIHcFig4J2vkKQh4G1rtrdrw+To704xVez4sDe3
 0wv69oiU90yc3L5ndvfvtSaxUWiJBbYcfpBYa70Ae+Pus63HXhNAnjCc0
 rFLP3nkwtjKqAqAZxgMraSFfKG4VAQkBh9H0qdRmQQHhiVWmEeGk+IxYI
 mNkojg9H+rct7cvmfRo1+mXzPpvaq7Pa4Wiw9okUVlpjpOpm/ZR4Pmm4j
 3/NZ75kqm2AUawjBYWaS1M1L0fuzs0B9RYxuqCPiBimDs8g54+vMFo+Ge w==;
X-CSE-ConnectionGUID: T28/JosERLexISZElsgSUw==
X-CSE-MsgGUID: eY968cc0RJSNFG8Zcf2J/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49867736"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="49867736"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:36:25 -0800
X-CSE-ConnectionGUID: NSYMYmtuQjyiqySOo8w1JA==
X-CSE-MsgGUID: 2tsDZkn9RHiDO846pNw48g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110505575"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Feb 2025 07:36:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 07:36:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 07:36:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 07:36:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPlZrRbYRfE/qGLWYpH/gA/CwVoP65tYqLPIoKrEJcn5A7i9PMUZ+HGsFSfsOqUxH8G1EBQXnFk0qmKGUHwOF1+8ERsE7DvvKDP4ZFdtDIxH7XQMPJHHYm1zqkBd7e1Y6kKhvu0NHtV7Ijd810l+FJw/IV6hfm8Zkln6jUiSFfog3HJiXPnf4P+WCA6UzPZfCBvI0OwctniP5aGCnU7Kyw7DQ4bSpofOls0WzFiDGGtpvizXoqbSeDzFF8/PCsLBcjUpCmFAHRTJh9N1bMzBkWFGIrZKgjJ4mGS0lKKUpo8/JWNKzvFWleNQAyvIeUN6MhUWZWCaXYIdxpJB+HfQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5d6dXqxcJLzDUgtB3tB6AdalMWQ5kWY3ail0V5XFpuk=;
 b=gpdLsqdldo6nsnjzqWq+j3OeZrVdfP8NcUeu7q3O8MzYyNJA2kCdyuBFd6hY9/WzZZVtswfIVVTNLdVvaMurOq5cp/h6rp968NLbaPWJ5bg5sx3xq4Yvu64mwGNdlqOvU1gBCoqma7tRyXmS6QdLYmQ+h17HqSyRf/bR5M6MCVarX2wo+0z9lzSxgK84wBxFXsdndtPU2s5U2FTp2drVLBiDXwMHP8jAtPZvn0CW+mDAgsjrDwHisomiTvXo81l+Xtwh/hittB22uHpsFs4Mn+WyfhM8PcYMiFyKjUXjTX8QecOKw1GqxUaJm5+6LXnLQILFqoN0Jx07UnN73GUGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CYYPR11MB8359.namprd11.prod.outlook.com (2603:10b6:930:ca::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.25; Tue, 4 Feb 2025 15:35:46 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%7]) with mapi id 15.20.8422.010; Tue, 4 Feb 2025
 15:35:46 +0000
Message-ID: <ac303c68-e335-41d3-b2c8-721f9f0e3aeb@intel.com>
Date: Tue, 4 Feb 2025 16:35:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/42] Merge Intel IGC and E1000 drivers, and update
 E1000 base code
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <CAJFAV8yY+T7S49daG+yRedGzvhis3iUC2yznvae7ZW4WEE4n7Q@mail.gmail.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <CAJFAV8yY+T7S49daG+yRedGzvhis3iUC2yznvae7ZW4WEE4n7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0059.eurprd04.prod.outlook.com
 (2603:10a6:10:234::34) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CYYPR11MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: e0621b5b-f7e9-4cd5-7d50-08dd45319814
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTg5bkpYN3ZSR2t4bXNuRVlVbU94aUI3L1lGeEZNeEtyd3N3ZGpRWkV5Z2Qr?=
 =?utf-8?B?MjBHNXhraEVYUDFzNmRLaTVvSFFsT3BIbTdHeCt0cURsV2FFQzE0cjFXUUVx?=
 =?utf-8?B?MTY2V0pEZE83T3NORndEU2tPOW5manp0NnRrV3hHdzIxUE92c1NZS1QzNGdB?=
 =?utf-8?B?UjR3eWlJR2lpOTc3V05XYmR3S2VPZXp5bFg3cFZUdzZNYlA4OVFPblhGNVdo?=
 =?utf-8?B?b3hzYytHcUttOE80bGNHT2taNUlpYk9VakJRdW9LeFZ0bmlWbWpLSkRRYTZY?=
 =?utf-8?B?ckR5MnlwN0NYbTdDZmg3QlI4OGt2UkpZYkJQV2tVRGxJMjVRcUR6cVVUdHJ3?=
 =?utf-8?B?Y1Y1WkdqLzFxMnBoU2o5U1BzM2JjUmhwU08rRXlOSDFoL3IvTEdEN0tQOHM2?=
 =?utf-8?B?YXIzMGU4RHNqckI0RDNLdUM5ZXRwV3BqU3AxNEpPV1QzdWptNzZENFIwbDF0?=
 =?utf-8?B?OVgvQ1k4MTlERkttdDF2dkt5L3RFNDcwREhnYkFtLzZEWVQ5Mk0rWGdqbE5U?=
 =?utf-8?B?bXkwYlAzNUUrTTFjRnVxTDlEbFZkeDBhSjBUT2IxUU00M3RmM0pRanJwNE5s?=
 =?utf-8?B?dGlwUm96ZTNzRnQxY1E1aURuODNkZUxVZlVFRmxuM3hQam9RekJIc2dNbXp6?=
 =?utf-8?B?eW1GNy9zSEo2V1dZUHhUM1dLL2FoWkNnVGVMeU94aHRhcFpiMENiSFdybXVn?=
 =?utf-8?B?Q2taaERZOXlpNWxtWEY2NnlGRnhlaUtBVEdYMjVONURLemhkTmlvTHloTWph?=
 =?utf-8?B?QVpyYkZURkFISlNidVdZMEozUVVmWk5HMkMxNDJwLzZMQ3hnTXhLY1VVR1Mv?=
 =?utf-8?B?Y1hmNGZEVXN4OTgvV3Qzc2hQbGxRRVVFRVduSUdZTmcvelhhVXFiUkxzbCtU?=
 =?utf-8?B?emFCSStwRDF1Mk9UR1FIK3JIUUZOUWY2aXczcEREM3lHOW5yb3oyUUVLTzJl?=
 =?utf-8?B?OHFOY3FCRXFHZ0VEUTNUOUJwWU9HQTcrRU9DTVV3cklSUW9GVmpGVVA4MDZJ?=
 =?utf-8?B?eXltOHdFaC9lOFp3bUttd2lkRis0NmJjcFVITUZ0MXpKcFNXSUNrR2M4SDZz?=
 =?utf-8?B?bnNxL1VzeTh3UHRXb1h1N3JqWGprSDVnZjVSbVVSMTExQzVSMERuWGFDUWFM?=
 =?utf-8?B?OHBBRElnQVJnZjJlaUFZQkE5K3A3TnJmVitXQXNsT25RL0dSd2lLQVFrUGJn?=
 =?utf-8?B?QkFOL3NQSjlkK2xHcFFuUjFUSU5wUjJkTjJvTWh1SGhySXZ3SCt1UEFLYW5z?=
 =?utf-8?B?WGMvRlFFSWV3aXN1cXRyemhyS1FwelVjdUN0OEFHWHNXaUVidCtYOTFGdXUy?=
 =?utf-8?B?SFh3VUdZbVpiZEtzL1dYcTBwUkFHYitialc4eTZCd0RzZzhzd3ZOM2ZaRG15?=
 =?utf-8?B?enFxbnIxMlVJMzFYYUNRLy8zc21tbWo0L2VRamtPR3pLakFmRDJJcFdmMEF4?=
 =?utf-8?B?SjV4Rnh1WS9rb3RJUFFXc2xLSXdybjdpUjZOcWFYb2xFcGNIRlJNTCtTZG5D?=
 =?utf-8?B?M25NUmQyMC9Za3NpSVhnQ2hpRWhvS01RdHFJUXQwMmZPMHJvTThBYkNDZVpt?=
 =?utf-8?B?RXRDNndaSnVrYWxBWmI1dXM2ckxLeWdQQ0kzaFRjMEVidjdRUDlSOE5DSkh2?=
 =?utf-8?B?NDVRUDF5OU1ITllWczVjMDdpdkJXYU9YekpDSmw2dWd6Tk5BMllJeDZuajU0?=
 =?utf-8?B?QU9Ybkd4M2YvM1ozcjd6TW5SM1RocmM1d0lUM2l0am82K09VRnJKbU5DYnVY?=
 =?utf-8?B?YUNyazV0UmgzVU5JSHlVODI2emZjUFB2WG42aHQ4bVorVWJmNjRBOGt6dGd6?=
 =?utf-8?B?QUh5a2t5RldhUmFza0JZUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkUvNG5MUWpBS2YxeTBvaCs5bWw4VTZkeGJhRUVHcndsdmJMbjFsTnoyTEtn?=
 =?utf-8?B?dmZhYVEzTTV0T0NvVHNqRFk2VEJpZXJsd1cwMUw2MktjclBZcmlJbitpQmFO?=
 =?utf-8?B?alRocWIvUU5PTlROT3pPM1dkaFhZTlRrVjJDQ1U0dld3N1NScEp4WkRKVW1G?=
 =?utf-8?B?TldueGdtbklodmxPQmtYd0RhSG1PSGlVd2NIY2pvQnQrRTV0NExYdzJXRlVk?=
 =?utf-8?B?Q0pDamZVQ05VV20xR2V0WGRPQU54L2ZYU0cwS2hLQ1B0OGdlbEUyNERFTENV?=
 =?utf-8?B?QkozWlNxbVNvL3QxUHVsLzBtemcrRDdFR2pIN2NObVAyMXFJNWJ3WVhueTVH?=
 =?utf-8?B?Ym10WnluZGpPRzB3TTBnMmZlZEwzQkFtSUVwSnVuQU5iMWM5YjlpTEx3ekdm?=
 =?utf-8?B?N3A3UEs3VWsxSldZdkdQL2VSTHBsUkgvRWdKblpqZGZBMlJrSHpHQjRNU1dJ?=
 =?utf-8?B?MEFoek9RNlU5K1BJYm5aYURTL0F6QmtxbXp4QU1Da09CZkhzbnBSOUdHaURX?=
 =?utf-8?B?aWJ0MjNYZFgvbWttQnRWMDNyWHF2WTlzQnNhd0lpVWRkUms5R3lEb014R3Q0?=
 =?utf-8?B?ZjZxU1lFYXNmanZ0a2NrMFNOUE5DbVFpY2YrZVlGbi9abGg3N3dFTEhsSjNC?=
 =?utf-8?B?SGpqdEJ4c2sxVDVHdnlYSk91bjBjZThBMkJ4Nk9OTSsxSGVUcVBkSEJHR1BJ?=
 =?utf-8?B?VkRsQzVSbUhWbks5OEJCVEhtY3czN25KMUhJd0x1Rzg5SDJOOFVGdWhxSVhs?=
 =?utf-8?B?ZWNkOTJtYzdQSlprZlFTdU41Z2lJNDdOcUFEQVVjMXNFbnlLQ3QvQnJEUnlz?=
 =?utf-8?B?SjZ3NHY3ZVNXYTllemJ4SGl0a09iNGlaRXlBQTJNV2orOWdIL01QZTVJSXFB?=
 =?utf-8?B?TXJJMXNCckIxdkk4eFRndENtRnB2TFdNNENrTlZyMFBDMDJXWnNGV216b0Y4?=
 =?utf-8?B?aEdMVHB3N0dkeHdOVW1WV2NaOHpVckgxdGxBMmdmTGVpaWlRZktVcitqNmdB?=
 =?utf-8?B?WjNtanV6WWUxVXdoNG13c0ZjRVgzMlhsZnBDQVlsa2MxSVFHNnAvSXVUaXpv?=
 =?utf-8?B?V2l6ZHBYT3VKNEYvUVQzNjN6VG1BMkRaSjJkVmdNMi9LTFFXVzE3TlJKUDFW?=
 =?utf-8?B?Vm1EVU1aRVR0cHdCbm51bE9Gd3FweUl6VkV2Q0FzWjd6WWxNQitXWjBpVFh3?=
 =?utf-8?B?cmNGSTIwdGM4dE5STExhY25VamI2NXNTSzNrNlljUUpNVkdXY1dwY1ZEZTNr?=
 =?utf-8?B?cXkwWkJjTDQzaWVZYm5FKzZuVGhxQ3Fjd2FYbnQzQkg4UWhBblVYUWlnS0gw?=
 =?utf-8?B?eHNBOS9tVGtrcGdtc3U1UlNQOUhMQURyNkQ3cWdiRVczUnZmcEs0R2kra1Br?=
 =?utf-8?B?Ni9iQTNtRW1DTzQ4dzZReUZ3NEI5S0NiaUM3c2pIem9JUWFPSzFDK0ZQVkxE?=
 =?utf-8?B?aTdwTWo5d2hXSE9XSTF6TlR5OEp1S0xrUzBMOUppSHRMRjUrTVVUZGlEVlcy?=
 =?utf-8?B?SGd0VkdtVmpJWHF2STFNeEdTcGVxL3ZCTnh5a0xjTVpSZlRUYXlOaDc2TStR?=
 =?utf-8?B?d3d3SHVSTlJWdjFiS2s0MFNtYXhXNmFnQUdOMjRXM3R6bHV4bHJBeURIRENP?=
 =?utf-8?B?dHhSd0prbkZ1L0owdGVGK1dOZUxXc2JlR0x3MTJENXI4RFNua2JWMVc4MzVG?=
 =?utf-8?B?ZW1YdTh2QVhoWjVRQ0tjWVlxUkdHanBxYWlLblBXc3U4RWZwYi9CSG9NMnhw?=
 =?utf-8?B?Vm03dVhpRXdpTDg5UVRtQXZYSHI4dTVVQVViSkNnSEcwV2hYVWpVdjVqK2Zq?=
 =?utf-8?B?MndXN0lkcGM4N084ODZnRVlxQ3ByT0o4azJjaVJDUEhPeSt0aTZNeTZFbmp5?=
 =?utf-8?B?RDQvNTBzSDRsekRsRG9oOUFrR0VGdUliZHAwVE5pOStualYxMEdhR0g4MDVQ?=
 =?utf-8?B?ckpFbjczZkgwck82djk4VzVBZVZpNHVJVGFNTFg0UWdoZklCRThyVnhCS2xm?=
 =?utf-8?B?TnA2N2pkdDlBQVMwMFhiM0x6aUxkMTQ0UWF6cHYyREx4L3ZsT0Y5QmJXR3oz?=
 =?utf-8?B?cEhFY2FjK1dIRkxWckFNSzU5bVY4VkcwTkREWFVKY1FWRUtROXdaQUxaUVhh?=
 =?utf-8?B?ZU94empOdWJHM1Z1RlgydEZBa0JTc0VwSHBTcUY3VDNKWURLbWxHa2FMNFJF?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0621b5b-f7e9-4cd5-7d50-08dd45319814
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 15:35:46.5261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoiHMtV4vzFfmTymLMx/Wqn3UDx8KmFc46ClA9sduWSCFwy9N5/36FFkcLthnxIXxIToU+lypAPvm08dsb9Z/7J/ORnGU/l+MGhpWhzTF+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8359
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

On 03/02/2025 9:18, David Marchand wrote:
> Hello Anatoly,
> 
> On Fri, Jan 31, 2025 at 1:59 PM Anatoly Burakov
> <anatoly.burakov@intel.com> wrote:
>>
>> Intel IGC and E1000 drivers are distinct, but they are actually generated
>> from the same base code. This patchset will merge together all e1000-derived
>> drivers into one common base, with three different ethdev driver
>> frontends (EM, IGB, and IGC).
>>
>> After the merge is done, base code is also updated to latest snapshot.
>>
>> Adam Ludkiewicz (1):
>>    net/e1000/base: add WoL definitions
>>
>> Aleksandr Loktionov (1):
>>    net/e1000/base: fix mac addr hash bit_shift
>>
>> Amir Avivi (1):
>>    net/e1000/base: fix iterator type
>>
>> Anatoly Burakov (13):
>>    net/e1000/base: add initial support for i225
>>    net/e1000/base: add link bringup support for i225
>>    net/e1000/base: add LED blink support for i225
>>    net/e1000/base: add NVM/EEPROM support for i225
>>    net/e1000/base: add LTR support in i225
>>    net/e1000/base: add eee support for i225
>>    net/e1000/base: add misc definitions for i225
>>    net/e1000: merge igc with e1000
>>    net/e1000: add missing i225 devices
>>    net/e1000: add missing hardware support
>>    net/e1000/base: correct minor formatting issues
>>    net/e1000/base: correct mPHY access logic
>>    net/e1000/base: update readme
>>
>> Barbara Skobiej (2):
>>    net/e1000/base: fix reset for 82580
>>    net/e1000/base: fix data type in MAC hash
>>
>> Carolyn Wyborny (1):
>>    net/e1000/base: skip MANC check for 82575
>>
>> Dima Ruinskiy (4):
>>    net/e1000/base: make e1000_access_phy_wakeup_reg_bm non-static
>>    net/e1000/base: make debug prints more informative
>>    net/e1000/base: hardcode bus parameters for ICH8
>>    net/e1000/base: fix unchecked return
>>
>> Evgeny Efimov (1):
>>    net/e1000/base: add EEE common API function
>>
>> Jakub Buchocki (1):
>>    net/e1000/base: fix uninitialized variable usage
>>
>> Marcin Jurczak (1):
>>    net/e1000/base: remove non-inclusive language
>>
>> Nir Efrati (6):
>>    net/e1000/base: workaround for packet loss
>>    net/e1000/base: add definition for EXFWSM register
>>    net/e1000/base: use longer ULP exit timeout on more HW
>>    net/e1000/base: remove redundant access to RO register
>>    net/e1000/base: introduce PHY ID retry mechanism
>>    net/e1000/base: add PHY read/write retry mechanism
>>
>> Pawel Malinowski (1):
>>    net/e1000/base: fix semaphore timeout value
>>
>> Piotr Kubaj (1):
>>    net/e1000/base: rename NVM version variable
>>
>> Piotr Pietruszewski (1):
>>    net/e1000/base: improve code flow in ICH8LAN
>>
>> Przemyslaw Ciesielski (1):
>>    net/e1000/base: fix static analysis warnings
>>
>> Sasha Neftin (4):
>>    net/e1000/base: add queue select definitions
>>    net/e1000/base: add profile information field
>>    net/e1000/base: add LPI counters
>>    net/e1000/base: improve NVM checksum handling
>>
>> Vitaly Lifshits (2):
>>    net/e1000: add support for more I219 devices
>>    net/e1000/base: correct disable k1 logic
>>
>>   drivers/net/intel/e1000/base/README           |    8 +-
>>   .../net/intel/e1000/base/e1000_80003es2lan.c  |   10 +-
>>   drivers/net/intel/e1000/base/e1000_82571.c    |    4 +-
>>   drivers/net/intel/e1000/base/e1000_82575.c    |   21 +-
>>   drivers/net/intel/e1000/base/e1000_82575.h    |   29 -
>>   drivers/net/intel/e1000/base/e1000_api.c      |   76 +-
>>   drivers/net/intel/e1000/base/e1000_api.h      |    4 +-
>>   drivers/net/intel/e1000/base/e1000_base.c     |    3 +-
>>   drivers/net/intel/e1000/base/e1000_defines.h  |  259 +-
>>   drivers/net/intel/e1000/base/e1000_hw.h       |   86 +-
>>   drivers/net/intel/e1000/base/e1000_i210.c     |   14 +-
>>   drivers/net/intel/e1000/base/e1000_i210.h     |    4 +
>>   drivers/net/intel/e1000/base/e1000_i225.c     | 1384 ++++++
>>   drivers/net/intel/e1000/base/e1000_i225.h     |  117 +
>>   drivers/net/intel/e1000/base/e1000_ich8lan.c  |  224 +-
>>   drivers/net/intel/e1000/base/e1000_ich8lan.h  |    3 +-
>>   drivers/net/intel/e1000/base/e1000_mac.c      |   62 +-
>>   drivers/net/intel/e1000/base/e1000_mac.h      |    2 +-
>>   drivers/net/intel/e1000/base/e1000_nvm.c      |    7 +-
>>   drivers/net/intel/e1000/base/e1000_osdep.h    |   33 +-
>>   drivers/net/intel/e1000/base/e1000_phy.c      |  447 +-
>>   drivers/net/intel/e1000/base/e1000_phy.h      |   21 +
>>   drivers/net/intel/e1000/base/e1000_regs.h     |   48 +-
>>   drivers/net/intel/e1000/base/e1000_vf.c       |   14 +-
>>   drivers/net/intel/e1000/base/meson.build      |    1 +
>>   drivers/net/intel/e1000/em_ethdev.c           |   36 +-
>>   drivers/net/intel/e1000/igb_ethdev.c          |    1 +
>>   drivers/net/intel/{igc => e1000}/igc_ethdev.c |  914 ++--
>>   drivers/net/intel/{igc => e1000}/igc_ethdev.h |   32 +-
>>   drivers/net/intel/{igc => e1000}/igc_filter.c |   84 +-
>>   drivers/net/intel/{igc => e1000}/igc_filter.h |    0
>>   drivers/net/intel/{igc => e1000}/igc_flow.c   |    2 +-
>>   drivers/net/intel/{igc => e1000}/igc_flow.h   |    0
>>   drivers/net/intel/{igc => e1000}/igc_logs.c   |    2 +-
>>   drivers/net/intel/{igc => e1000}/igc_txrx.c   |  376 +-
>>   drivers/net/intel/{igc => e1000}/igc_txrx.h   |    6 +-
>>   drivers/net/intel/e1000/meson.build           |   11 +
>>   drivers/net/intel/igc/base/README             |   29 -
>>   drivers/net/intel/igc/base/igc_82571.h        |   36 -
>>   drivers/net/intel/igc/base/igc_82575.h        |  351 --
>>   drivers/net/intel/igc/base/igc_api.c          | 1853 -------
>>   drivers/net/intel/igc/base/igc_api.h          |  111 -
>>   drivers/net/intel/igc/base/igc_base.c         |  190 -
>>   drivers/net/intel/igc/base/igc_base.h         |  127 -
>>   drivers/net/intel/igc/base/igc_defines.h      | 1670 -------
>>   drivers/net/intel/igc/base/igc_hw.h           | 1059 ----
>>   drivers/net/intel/igc/base/igc_i225.c         | 1372 -----
>>   drivers/net/intel/igc/base/igc_i225.h         |  110 -
>>   drivers/net/intel/igc/base/igc_ich8lan.h      |  296 --
>>   drivers/net/intel/igc/base/igc_mac.c          | 2100 --------
>>   drivers/net/intel/igc/base/igc_mac.h          |   64 -
>>   drivers/net/intel/igc/base/igc_manage.c       |  547 --
>>   drivers/net/intel/igc/base/igc_manage.h       |   65 -
>>   drivers/net/intel/igc/base/igc_nvm.c          | 1324 -----
>>   drivers/net/intel/igc/base/igc_nvm.h          |   69 -
>>   drivers/net/intel/igc/base/igc_osdep.c        |   64 -
>>   drivers/net/intel/igc/base/igc_osdep.h        |  163 -
>>   drivers/net/intel/igc/base/igc_phy.c          | 4420 -----------------
>>   drivers/net/intel/igc/base/igc_phy.h          |  337 --
>>   drivers/net/intel/igc/base/igc_regs.h         |  732 ---
>>   drivers/net/intel/igc/base/meson.build        |   19 -
>>   drivers/net/intel/igc/igc_logs.h              |   43 -
>>   drivers/net/intel/igc/meson.build             |   21 -
>>   drivers/net/meson.build                       |    1 -
>>   64 files changed, 3300 insertions(+), 18218 deletions(-)
>>   create mode 100644 drivers/net/intel/e1000/base/e1000_i225.c
>>   create mode 100644 drivers/net/intel/e1000/base/e1000_i225.h
>>   rename drivers/net/intel/{igc => e1000}/igc_ethdev.c (73%)
>>   rename drivers/net/intel/{igc => e1000}/igc_ethdev.h (91%)
>>   rename drivers/net/intel/{igc => e1000}/igc_filter.c (81%)
>>   rename drivers/net/intel/{igc => e1000}/igc_filter.h (100%)
>>   rename drivers/net/intel/{igc => e1000}/igc_flow.c (99%)
>>   rename drivers/net/intel/{igc => e1000}/igc_flow.h (100%)
>>   rename drivers/net/intel/{igc => e1000}/igc_logs.c (90%)
>>   rename drivers/net/intel/{igc => e1000}/igc_txrx.c (87%)
>>   rename drivers/net/intel/{igc => e1000}/igc_txrx.h (97%)
>>   delete mode 100644 drivers/net/intel/igc/base/README
>>   delete mode 100644 drivers/net/intel/igc/base/igc_82571.h
>>   delete mode 100644 drivers/net/intel/igc/base/igc_82575.h
>>   delete mode 100644 drivers/net/intel/igc/base/igc_api.c
>>   delete mode 100644 drivers/net/intel/igc/base/igc_api.h
>>   delete mode 100644 drivers/net/intel/igc/base/igc_base.c
>>   delete mode 100644 drivers/net/intel/igc/base/igc_base.h
>>   delete mode 100644 drivers/net/intel/igc/base/igc_defines.h
>>   delete mode 100644 drivers/net/intel/igc/base/igc_hw.h
>>   delete mode 100644 drivers/net/intel/igc/base/igc_i225.c
>>   delete mode 100644 drivers/net/intel/igc/base/igc_i225.h
>>   delete mode 100644 drivers/net/intel/igc/base/igc_ich8lan.h
>>   delete mode 100644 drivers/net/intel/igc/base/igc_mac.c
>>   delete mode 100644 drivers/net/intel/igc/base/igc_mac.h
>>   delete mode 100644 drivers/net/intel/igc/base/igc_manage.c
>>   delete mode 100644 drivers/net/intel/igc/base/igc_manage.h
>>   delete mode 100644 drivers/net/intel/igc/base/igc_nvm.c
>>   delete mode 100644 drivers/net/intel/igc/base/igc_nvm.h
>>   delete mode 100644 drivers/net/intel/igc/base/igc_osdep.c
>>   delete mode 100644 drivers/net/intel/igc/base/igc_osdep.h
>>   delete mode 100644 drivers/net/intel/igc/base/igc_phy.c
>>   delete mode 100644 drivers/net/intel/igc/base/igc_phy.h
>>   delete mode 100644 drivers/net/intel/igc/base/igc_regs.h
>>   delete mode 100644 drivers/net/intel/igc/base/meson.build
>>   delete mode 100644 drivers/net/intel/igc/igc_logs.h
>>   delete mode 100644 drivers/net/intel/igc/meson.build
> 
> Consolidation is a good thing, there are two small issues with this
> series though:
> - the ABI check (as it tracks all .so) reports that librte_net_igc.so
> disappeared: this will need some waiving, like Bruce did in his
> series: https://patchwork.dpdk.org/project/dpdk/patch/20250130151222.944561-2-bruce.richardson@intel.com/
> - with this merge, "users" can't select net/igc compilation anymore
> and need to be aware that igc support now requires enabling net/e1000,
> please update the release notes to make this visible,
> 
> There is also a strange build failure for mingw (see github test report).
> 

MinGW issues were fixed, abigail changes and release notes will come in 
(now) V3.

-- 
Thanks,
Anatoly
