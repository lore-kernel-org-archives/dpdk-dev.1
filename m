Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4E7CA0FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 15:38:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 104AE40281;
	Tue,  9 Sep 2025 17:38:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0AC6E4026D
 for <dev@dpdk.org>; Tue,  9 Sep 2025 17:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757432285; x=1788968285;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CzJfeRsX2O8ybtGs4EHPxYR2+gocsJnCdSNsYIOTFE8=;
 b=XGD7Y56vx28nAv8IlLsXSZRvc5sryltRixuFs6yBmx1KeW6Fjrzk9xL2
 9qXayMhHfroDZ603RssAZgxwirlJU6zBD4dlwJbkf7lmtXEzXV5z7rru2
 ExZG30QW9a6MXtmit92OM9AXy4eAjtREaTM42EClyrACNn4bwhLd2PxXH
 MWE3Ivem3Z6STavcLB/T6OqhLUQ9vE5Z7btLpnYuJBfosBreCOL48WTyq
 ilWCsgbltxhIr651QlE0bEI8QW10opkZKIFepn25S0PqTivOv/kjJWuIb
 SpQfce4p6gWVFOdbQx7aaO4511I8caoIO0fTXTl5pl+OfWzweoPaUzwYb A==;
X-CSE-ConnectionGUID: kJInQrT3R0e6z6CWP8U+DA==
X-CSE-MsgGUID: SBb1iT4eThOCr+HUnqCu6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="70338946"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; d="scan'208";a="70338946"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 08:38:04 -0700
X-CSE-ConnectionGUID: C7+ARDAaTW22hBnvsoWYDg==
X-CSE-MsgGUID: 4enZOh6VT7SUaTHqPt0SQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; d="scan'208";a="173236888"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 08:38:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 08:38:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 08:38:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.70)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 08:38:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esDDOp1gfoQ+T8d6V737IMUC/bA/lF3ZuiwTXB0cnT0tklxsYrkLtTU/W5JGAPo7OnYt0hzReVrV/NWC72Aa1yT2TVV8GMwXIN1KgaCR8Zi7pZgtHdHPBQNPmKPkUYzfZtsCa+TD2nRxtZZiwNRHefevahE2tJzJPhyZ+RemDewP9Md8kxH9OMzeS++bTaslFqGg2nf5+2o9QMxGwN2HS4veCfHix9jCkFOcXpkAfx7ALEkZqe8Sr/e1qGZ15I1FunypkhtuXOdZreHjHeg3GdSnc07FEoHVImzBz8TpJ/ASMtCh9kyF2au+1PnFw/0aZDF7Ff0mSq0SuL4kT8m9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oc5Cmq2veyOMiWCUQKnfFFzCxznh7AtHnvuPtKGhu9w=;
 b=rnoJp1hsZTWgCBP6JLnJdNFZgMoSYXJilH3yZY7xFgnbtf0p3/9xYB1nEKB6Y+zpjn9M0P+jRLS9EgpDieqJzSVB8yy5i7VAIzYMU+nSxI5Sw8Pps9/nwM4MSfVKvnVeiklHqNXxzcVz+vbsNj7gUzmdtBc6VWEGG5q72SCjdd+a0NTfcwDxeJ98KzJsWf18nAktHSRIsgqmlZa1UPa/lDmtXTFS+Ud2mQDW12OjCB5UTjfgVmwY08H2NLJAuLn7LtEcAdFjUVnNNe1Vh81TE13UL3xanFfioDL1EHRnZbe13fvHMchLzhj38GqG3ek31Q6h0L+lenR4ZhbmnR5PHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB5801.namprd11.prod.outlook.com (2603:10b6:806:23d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:37:58 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:37:58 +0000
Message-ID: <688448ee-3dcd-4bcb-a16c-0446e3936cf1@intel.com>
Date: Tue, 9 Sep 2025 17:37:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 4/9] vfio: remove public wrappers
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <maxime.coquelin@redhat.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, "Hemant
 Agrawal" <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Harman Kalra <hkalra@marvell.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-1-david.marchand@redhat.com>
 <20250903151800.1965006-5-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250903151800.1965006-5-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR03CA0027.eurprd03.prod.outlook.com
 (2603:10a6:10:be::40) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 764c409c-3c53-4909-9afc-08ddefb6da7d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0VGdnNtSkpqalNpdStlbnZlclFrTEVDUVZZdkN3RDVmVWNnbm5ZdXpRa05o?=
 =?utf-8?B?NGN6TzI1U0U3TUg1Q0dpbDlHTWRkdklPUnhoU2w1MUpodnJsK0p3eGdEdk54?=
 =?utf-8?B?bUF6N1VNbTRsbWVDL3M2NWx3MDgxRW1sTXpPaVArVXVkNnBpTi8zY1JNWnV5?=
 =?utf-8?B?czc5L3V0bkZ2NXhhZndHSmZyQ25jdFJOdTJXTmEvUjVFWjRRa05XUDlMN1R1?=
 =?utf-8?B?aGd3U010QlYrZTh3ZitwcDV6T0VWRUxhQ2FVZVppSlJ5UUxxanRTWDl6UUN2?=
 =?utf-8?B?QVFwL2pJRHdaaFAvNkdIREhEcVNqdWxBVVhZVTdyR296US9mQ1E0U2JDMWRK?=
 =?utf-8?B?bVFicGFNd2Zud2hXVTV1c1dCazBESCtIbTdVa012TkZoWFdiREh4bzBhdGNi?=
 =?utf-8?B?ZkFGQTVoU3hvSFdWL2JYTXJVTWpvQWI4Qnh3YzQ5OVVkRmJ1bzMrVHp1M0pz?=
 =?utf-8?B?UzliM1huT1ArS2haQkI4bEcrVnRiZkl2cVprbkFZRVRhM2g2dHF6ZFNaRTFI?=
 =?utf-8?B?NVNpV3hqNW1EUUJEZHJRNGJGY0RwQUl0UzZMUVpFaDMvYTY1NXN3NnowRnVL?=
 =?utf-8?B?dzh3bmZtdXRHRXR0VGt2bEtweTlzdGpzU21OZFRCQXlXM1ZiMHpsSjBKZEZx?=
 =?utf-8?B?blJIVm9WSUt6V0FsODlNRzR3NDQwQTlxK1NNL3JGbTdoeEpYRzBwRDl2bnIz?=
 =?utf-8?B?N1FWaDFWc0tGQ1JhK3NtTEd3d3hjV1EyZXRMcXFiSzBTd0JLNGhtMzdycHhk?=
 =?utf-8?B?alpGTkVQc3hHUzJqRDQ0Qk5sYUlDamJzREhuc0lsNXAwaFl4emlmUzExM3Mx?=
 =?utf-8?B?TjhRM1g3dkVWRGxNRzI5ZDZwOUYyeVlXSXM2M2sremc0SExyOUs4S05pY1Y4?=
 =?utf-8?B?Uk9PUnJWVy8vQ1pZT2dtU2VlYXFVZGhCZEwvcncwL3RLTVNOYTRKUFlvcEJp?=
 =?utf-8?B?TE9OaGI5REgrOE1WYnB3ZmhrZHY5N1hiMHdTK05lSlo4ZWJqYlRDL2hmQytQ?=
 =?utf-8?B?dE1yNFVTM3hPWGpocXdtNFIvejFVcVhuSEYybEdFNlJKSW9HZ0h2TndyMWZI?=
 =?utf-8?B?aFVtV0RmQnlsNDJsS3hXWS9MT0pUVEgvWmlLK3laVzdlcTZSZXczZkdlaHo4?=
 =?utf-8?B?SGx5V3BBNTBFMmFGcFFiNXdWUmhVdWZkMUhYVmNPN0YzM0E1L1BYaSt5S0VG?=
 =?utf-8?B?UWljWUlhc1lnbGRPSlc5VkxnK00wV05SUUx3RTF0cEloak1DQ1VRanIraVZV?=
 =?utf-8?B?YWRweGhGeFkyc0dFdDVnaXZEU0VwM25zMlVtT2pGZ1hPVEpPalgzekpzL3Vu?=
 =?utf-8?B?RHhjQ1JNUGYyRkFtd2E2c1NGSDNkMmh2SVhrc3JTazkzZGtpM211SENhdm53?=
 =?utf-8?B?a29LZmZWQWV1Nk0zcklMNkthWFBhWmkydllWRUNOanNITk5xYkxjc1ZFZVRa?=
 =?utf-8?B?WnZvVXpteUl4T1FFK1JXQUVmekZQVXkxSmYwd3ovdWJOZHJ6TEl3OFgrdUY5?=
 =?utf-8?B?ZC9aNDAxK2hzWG04Q0lOZ0pjMTdwQ1Q4RWlXbytYaDBCU0RwTkJvd1ZlS0Fk?=
 =?utf-8?B?UWtVaEdBMytXNm1nZW52YlJRUkpZTmx1UzRpVzZJK0dDdDhBY3Z2YmlvWWpD?=
 =?utf-8?B?U0dXcGl6UVJJKzVlV1hmRkNQTk9HdTk4dkQ4UVgxSEhqY2ZFT05CQ2FRTzFI?=
 =?utf-8?B?amxOTGRxSzQwWmZFQ0V6QmM3aGh5YVBMNnBNbW5sYkVBczQ2cmloSG1ZUlMx?=
 =?utf-8?B?OTN6d2V3dEJhcDM3ZWpqRjZnUkdKOFg2bFVaNkNvejJ1NDRzTlI5UnJqdk01?=
 =?utf-8?B?dFhIVytNZytnU3hHNjVIamkrOERmc2xkR3lrdzFxMVpESnZveUgyUkFweTcv?=
 =?utf-8?B?dGJ5aWN6TERwQzNvY3VOdzQyUmEvMEhoKzdIZUhtT0xUa2x1RDlKdm83ZDhU?=
 =?utf-8?Q?Bg+n7aCm6Tk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3dZcFIrUXlVamJSTlplMzZpWTR6d1JwWElrUEMwVGJ1SDRUbllsNWV4Rjk1?=
 =?utf-8?B?RnFrNi9CM21BL3F1Vi9aY2ZHbnM3eEhwL3h5ZE40OFVxWHFwZ01nd0JLS3l2?=
 =?utf-8?B?K3B6c0RiSVNGeFRxbmtzaXNTc2ZadXllYUcySkpTT0RqZGdQQWp1V0pmUHIz?=
 =?utf-8?B?bGQyMWdSRUtZbXlLVEJ3TmNhZ29VMFA2bitFUUlnTmxhYnFNY3Y5NlkvbnRH?=
 =?utf-8?B?MzlqSEJHZ1M0aVBodHN5Y05nUUdDNmJmVng2ckR2OXNUb2lEY0xMU2hEREI4?=
 =?utf-8?B?SVV2RHNhakF2YmJmYWdPOHVteGh0NmVQVDZPTERkeGVJeitDbFdSakNjWXdN?=
 =?utf-8?B?Ym1kRmZ4Qmt1dWJjVThPVjhYZVkxdGJTb3NjMGxDQ3NlTUhjNldVRmRJckJR?=
 =?utf-8?B?WldtZkhxc3dhcWcwaFIyb2xnVDMyZDNSNkRvcWI3akxrUTJLdzNaZ1hiUEhR?=
 =?utf-8?B?bWpKTGlUUmwwaHNrU3V0RTVPVjZDb2oyZmlsMjN1TDdnb3ZpbUgxdDFydnlp?=
 =?utf-8?B?MXU1ZDdiMFA5bFQyUDNyNFlaM0ZMKytTZ1k0ZSsyT2pETkJ6a05MS2dGVEdU?=
 =?utf-8?B?emk4dEVyb3dSMFZnenVINko4WlRYOHoya1JmQ2pZNGkzLytkN1Rralk2d2do?=
 =?utf-8?B?NTJEQlpBUEZVL0JtakhzMEM5V3B1dmtoK1pnN3lUSWpTNEMvSE9SQjZyVi82?=
 =?utf-8?B?TWdkaytzb0VaRnpxNHZqWUdqbzNYb0pBZW9Ddk9ESlBpTzhkdDk2eEpEOFBS?=
 =?utf-8?B?OUZsOURPOXUyQXgzN1lkelBHV2hISHNzSHJhTVFaVk9YaXovOXc1SW03Nmhj?=
 =?utf-8?B?bDUyVVdqelFPdE4vRkRoNG9jcHZ0U1QrRUswa3ozUlpZSEVzNGI2MG92RTls?=
 =?utf-8?B?aDVOUzBQTis2THE3WCtKa3BaSElXVlkxWWRrREhJeGNvR3FuUVp5RDVsSHNO?=
 =?utf-8?B?MmZOVHFUcWlBS3lTWWc2R1RUb3dDNGNOUmJucnV5aTZkallIZHhqUFZKdG9R?=
 =?utf-8?B?Mmdvc3Mzb2czSlJWOEdYQXAxQU5lZ0ZoeDV3a0xhdVF4SjBsdTNwNEx6VkRl?=
 =?utf-8?B?SitrMTQwQXZOUWNzUDFBVzI0WW9jdlVxb202TW1TcGRoWE11dkw0aWMrLzVS?=
 =?utf-8?B?VzNkWE10NWFPdTkvMzBPSmVBUEkzN3g0WkoxWWt3anJrVmZUb2daaHVjdXps?=
 =?utf-8?B?cDdwb3VDTVJwN2pkaFZHTnVTU2F0QjNzdlFHamJCUEY1OWxuUjBPQ050YXlN?=
 =?utf-8?B?T3JKV1l3YUw1LzFXcnVSTmVqZm5CSFpoODBWVzlXY3ljVUN6RkkyUlRFQ3d5?=
 =?utf-8?B?eFlCeDlsZmdMWWJtNFZxMEIvQnkvaWowYlB0U1VueTZFZ0p4Wmt2T0ovSFR5?=
 =?utf-8?B?Y1E2cTZobXFzVVNNVEF0TGV0dW5weFlvWmxkMnplKzlKWnhVSTl3OS93Z1Y1?=
 =?utf-8?B?amt5SkJRdlZVSWFOM3d2UkRSU0pBWVNEUmZnSzRwUjhNVzl2blZiOENZZ01I?=
 =?utf-8?B?djJyb2RHcnR3eWxWYlpuVEgxbHlyYmM3SEp0ZmZaMWdIWVRiSFFQYUp3SDY4?=
 =?utf-8?B?SThON2lHUWNBUmJ4SUppTzl4ak9WUEhTWE5kbm9QM1Y2bm93bUtSWkNCS3hC?=
 =?utf-8?B?ZkI3aDlMaVord0VCQWNSTThFczZBYncraWh5V2MxMlhHSFFWQUZIT1lldnlR?=
 =?utf-8?B?R0tWd1JCaTArM3d4bFA3OFRKcnl4SkhJQlM5bzVVM3FCSHg0aERlZml1c2lY?=
 =?utf-8?B?Uy9Qa0ZBZTN2eXRMenBjdGlQcmVyR1NEejNmVVQwSWFVQi9WbGx1cHJlRXZD?=
 =?utf-8?B?ODBsMTNEdmU5aVZnNGNVOTV1VDFYN2tycE1PS2JUMkNxandPbFZ3bDA3dmNl?=
 =?utf-8?B?Wm1NMUdNVUt2TEpscTBYQjZSdzluMlpBbkRmNy9PcjRac0xIRkZ4Z0J1YTBz?=
 =?utf-8?B?MkFtNlh1RktVVUwzZzNYbmVJZXhXdDE4ckloY254aFl1QjBiZldpcmlRNEVn?=
 =?utf-8?B?bFlFTDNqYy9Gc2VQTGNrSTJkdWVza0lQRTl6ZHV0Tlg3cUY1NitiK1hqc05Y?=
 =?utf-8?B?eEkxY2N0alBISWE2Zm5hTlNubVJRVUh1dXl3S0VwM1kvRU11T3NJbXhDUkZW?=
 =?utf-8?B?amc0K3pnN0MxREVMOVZWS21QZ1lzV2UyTVJsbElUOVRXMTQ3RUNTdVdwSGFi?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 764c409c-3c53-4909-9afc-08ddefb6da7d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:37:58.7860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NX+0dl3h9piDYeas570aB1bFC9rs/9eO2JF1btUf0mzcsmHhqO5yS7wucfM9H5cvb91b3xHbmlC6SZ0UPrCIBRILp48pYZE6yptxs9artbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5801
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

On 9/3/2025 5:17 PM, David Marchand wrote:
> The public header defines a number of wrappers that can be removed or
> hidden internally.
> 
> Either, those concern old Linux kernel versions that are not supported by
> dpdk anymore (DPDK now requires Linux v5.4 at least), like:
> - the request notifier feature, present since Linux v4.0,
> - the noiommu mode, present since Linux v4.5,
> - the capability support, present since Linux v4.6,
> - the msix mapping feature, present since Linux v4.16,
> 
> Or, those wrappers can be made private as only consumed internally.
> - VFIO_GET_REGION_IDX() has no equivalent in the Linux uapi, but
>    is only used by the Linux PCI bus code,
> - VFIO_DEVICE_FEATURE is only used by the CDX bus code,
> - the various macros around /dev/vfio/ or the noiommu kmod parameter are
>    only used by eal_vfio.c,
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

<snip>

>   	{
> -		.type_id = RTE_VFIO_NOIOMMU,
> +		.type_id = VFIO_NOIOMMU_IOMMU,
>   		.name = "No-IOMMU",
>   		.partial_unmap = true,
>   		.dma_map_func = &vfio_noiommu_dma_map,
> @@ -363,8 +363,7 @@ vfio_open_group_fd(int iommu_group_num)
>   	/* if primary, try to open the group */
>   	if (internal_conf->process_type == RTE_PROC_PRIMARY) {
>   		/* try regular group format */
> -		snprintf(filename, sizeof(filename),
> -				 VFIO_GROUP_FMT, iommu_group_num);
> +		snprintf(filename, sizeof(filename), "/dev/vfio/%u", iommu_group_num);
>   		vfio_group_fd = open(filename, O_RDWR);
>   		if (vfio_group_fd < 0) {
>   			/* if file not found, it's not an error */
> @@ -375,9 +374,8 @@ vfio_open_group_fd(int iommu_group_num)
>   			}
>   
>   			/* special case: try no-IOMMU path as well */
> -			snprintf(filename, sizeof(filename),
> -					VFIO_NOIOMMU_GROUP_FMT,
> -					iommu_group_num);
> +			snprintf(filename, sizeof(filename), "/dev/vfio/noiommu-%u",
> +				iommu_group_num);
>   			vfio_group_fd = open(filename, O_RDWR);
>   			if (vfio_group_fd < 0) {
>   				if (errno != ENOENT) {
> @@ -1128,7 +1126,7 @@ rte_vfio_enable(const char *modname)
>   	}
>   
>   	/* VFIO directory might not exist (e.g., unprivileged containers) */
> -	dir = opendir(VFIO_DIR);
> +	dir = opendir("/dev/vfio");

This and similar places: I would rather prefer if we used defines rather 
than repeating the same literals over and over in multiple places.

Other than that,

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
