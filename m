Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16940C83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 13:26:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E414740677;
	Tue,  8 Jul 2025 15:26:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 34A80402A0
 for <dev@dpdk.org>; Tue,  8 Jul 2025 15:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751981183; x=1783517183;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=/fWucr8SYmFoq60yOnShGVcc29TKSBh7vyr600MmYFs=;
 b=fAoDGo39VNIxm9SYLtnQAbhmjmwEBwnM8FjuyZtKEl2dVop0oq0uT91f
 pdsRjy5y/OhkALuyUuLSinrV3EQcZ3pVemzGgRRFuZ2SxWT6/jChWuq0y
 Qf2sUSgW4swrpS7ksZT8SGnomEpwVud0PAflxr8NmO7rSMR7MsTQ2Jgyo
 8Bm9OBfNrAZQMbGzo8BLkLqYTy4mKQ6Ew2RtQVGNpr0UDfB17H1YGqvOx
 TCkIKYy7aK0El9mmuApD0sHUIhmvJEi0I1eTlA2+ALXuoigIiSrSsjUF/
 HZOLM8pzJUsE7xGG6wE8YgvmLHmngrFxCiAaP8X7RM96s7eKK2WenUdgE w==;
X-CSE-ConnectionGUID: nC17eRzgQT2ywYLukTCC2g==
X-CSE-MsgGUID: CXitfUflS+SxNpM+bydR4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53336194"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="53336194"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 06:26:19 -0700
X-CSE-ConnectionGUID: naj0HYRLSZmY6PGeXaOJZg==
X-CSE-MsgGUID: qDPxvXb/Sd+UrMCeOxNk1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="159537596"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 06:26:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 06:26:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 06:26:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 06:26:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7x+KSiWz6O/1ahxbD7AEdvEcxFgTE8R3vec9/GdzA7xkpUS7OhOE187CRFxRzshStjYQvN19p8Tedg3xZ5a8j3ikmH13j9UQVP8zHArF8B+kXmp5i4Mrb/TcY8+NsOvcxIS4Z2sajIen+W1aY8NO/LBICLmLuZ4idqA8f3hUNPXUWEY02jAkhQD1GJd4mzlAIwIkm5gsoA0JcyL5B2EMO4HgzcbvopbFBXVrRL87WRJ7djQjZUiiwkHZJ96er1cusMKuyli8KEy66qsZ5MySZ8jJA5NH6UnqpLdH2WFX0BZrz75wwnhGDiR0aPtoHIfceXUrQ0rFh4A0jsv1XsT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbRpKaWGGt8cRTTil5+xKQ9Oxyxnu9jTWgcvAoWeyiY=;
 b=Ligu0d5ceTgNNCMgb4gBlj8GKZLeYnCbbLBN0CAFKRwdb2SJILiXDS6INvfm9C0FQKOMTHmfUzAtc2RDcu1hNjoMt4+tCMOROb4dm/eNonJnmNkEGMHiN8phX3kvW33WKgM7JVaZab3M/WVW/UaKQN6fPTC/HRmF7LFJOXxAIvG9Vd4nbGpukl8opIRhzPaoT4hqURRDdUkhVDSSwuDjEV8H3TzrGZBtpAFe5wGWNRd0s8n8EgtfbNNoq48lJl65+tGSz/F10/gICYJ+IenCDl0ArCHnTZWPDLK/3pyc+CovrkhL9Vrpy5HZL7JkQXQCd6a2xnJss4Os/vBLVCTqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6663.namprd11.prod.outlook.com (2603:10b6:806:257::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Tue, 8 Jul
 2025 13:25:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:25:47 +0000
Date: Tue, 8 Jul 2025 14:25:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Tyler
 Retzlaff" <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v3 12/18] malloc: fix mp message alignment
Message-ID: <aG0cVcB55BF2mEDd@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
 <20250708122823.3406288-13-david.marchand@redhat.com>
 <aG0SmKmMAnW3hrfE@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8wj=EmaJnOVj4n8eVUR+BOAYhu38cJDu29Um4TkxFS9Tg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8wj=EmaJnOVj4n8eVUR+BOAYhu38cJDu29Um4TkxFS9Tg@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0184.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 2768944a-1d09-4d54-d88b-08ddbe22f2bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEtMVzFzdFo1TXFEcnlHQ1NFVzlPOXQwcmN1dmFVQVJDdmtjKzJENFRXbHJu?=
 =?utf-8?B?L0NIT3hDTERvTEFZOFQ2YzJ3MXU5R2IyYVJ4WmVtRVVOVUJCdGtDVnRNc2ZQ?=
 =?utf-8?B?SE40Rm85YUxUZ3JadGJ1eXZMbkk4SXZpUmw0endNVVZvOENCRWZ2QkpZak9u?=
 =?utf-8?B?K1BweVp6MVZLem1SSm0xRFZ2YW1PL0IrZk52Tnd6WkU3anEwcEVvSXIrR05v?=
 =?utf-8?B?aDA2ODIzaUw3Z3ZTSG1PRFRFM0VtS2FzYjFwQWVhM0hjZXRpUlZFLzFHekh4?=
 =?utf-8?B?V3RmSEpmVFhja21CNnhHMUlWRCtvSE5KbGNad1orTFZQUXVXazdudmNudUJL?=
 =?utf-8?B?ZXRNSGlhRUlqYnZRMFJWUm1NSUliSHZFNDRKUU1XRGZUVU84MC9EaVA2UUlH?=
 =?utf-8?B?SmZpQnZka3BvZGFKZkxSMmhCVjZPbm1CdFhnZVZJTm14Q0R2REZKNEl2QmR0?=
 =?utf-8?B?NFl5RDRjTGQwSWNBSTk5cTI0WDdmdU9kdXpEckc5WHhpL2g1VUFvdjlTZURG?=
 =?utf-8?B?SUM3NjBUVENFSGVaanBKR3BGeklqYi9BdHZjcTlndUFKZFdVVFdBMkF6MmY0?=
 =?utf-8?B?VEw0d050N2xOYTd3N3NIUzhyb2xmZFNyQ3dxVVpWQ3RReTBTdmhvMEdCUVFM?=
 =?utf-8?B?Vi9KaGJpamd1SHNHZldhSHpGMkREYUVyYjVDVWhvMVpLM1J3Ymh5QnltSnpV?=
 =?utf-8?B?Y0NxNC9UQVFlbmUyaXNvbVViYlRHSStyQUJmeEIwYkZxTHBId0R2QUNhNlpG?=
 =?utf-8?B?QVJHV05PVmxWL0tCN2xkQnNsL1J5NWtHd2o1cnc2bHFXS1ZIbEJvRDI3VVZo?=
 =?utf-8?B?VVRsSWNYUnFMbVhRMkNyTEl2dWRVY29VNzZRRFhXRGZMZ0d2TVBHalNxZDR6?=
 =?utf-8?B?T1FnWWg0QVFQSEpCbU81KzUwTWducVBpUGJZdUdFMDdTV0lGMHFvVHdIcmFl?=
 =?utf-8?B?dDVFZmZTUkozVjBpYmhEUmp4bWRYSDVQUy9uY1BuM2tjanlLWW5UZDJ4d0p5?=
 =?utf-8?B?MDN6blYzK3RRRWIyK0FsU2xTbXkzWFRUVWY1SW02N2I4VWhXQjVUM3BlOU5Z?=
 =?utf-8?B?amgyazdPcGR5ZFZ1RzBzdHl2cEZzOWZzdktCTFRzdE54WUYvekVkNUlITERw?=
 =?utf-8?B?MVg4SGNySytpbENaVVg0Wi9nbWRxS21ROWZITmlLVU9vandqL2ZjSXBDb0FH?=
 =?utf-8?B?Z2VXemY4Tnc5L3dyRkp3YkdoeFRlSGx3SHFWSU9SZ1B6ZzNtSU9ick13TFlw?=
 =?utf-8?B?V0N4bFB0MlFKUWJCUDlHU0tISWxkQ1pxSjgyUEtZalh0WkdOZDJ4RklsTVFC?=
 =?utf-8?B?R2Mva0IzUk9EaTZRa0szem41QkFCM2pJRkUwTVRwUE1GcmNwWVJUcXZhV3U0?=
 =?utf-8?B?bVdiYmFNYi8xZTBDU2hrTFNTcVFDNXg3c3gzd2hKbUpsMHFnTmY3bVZ6eGFn?=
 =?utf-8?B?aEF2MkhHWDR0SHFkbUtMR3pwM3Y5cUk1RHZKUk5VcFZCNFRDRjAyZ25FVEVv?=
 =?utf-8?B?amIvaGg3U3VwSzFONUZGNnhDWTl4YnF5N2Fub0pMMWhPakhEblBSUldvT2p3?=
 =?utf-8?B?Z2QwakdqdkRRTGhqcDF0WG8vSUVsa1Y4NmRhZEVtRGFHdTh0UVN5Lzhnb2Mx?=
 =?utf-8?B?MXMvdVlyQ2ZETDJHNEZFRWpyelVDVCsxL1diVFM3VUlhLzNtSEhRTjRFR1pB?=
 =?utf-8?B?QzJ5ejBNTnB3SVdQTDJTMmQwMHpRREpGMGF1QmlZcHZyWVZTWEJBdnZJalhX?=
 =?utf-8?B?VmlaRjlKWERsQ1Zyem9vNzFNd3lQYjJBVncxTmtGYnVIV3hlYWU0K0paM2ZD?=
 =?utf-8?B?U1c3RTdFSVZGczgyd2YxNWxMZlJJcTdGNXRpTVZwcG90d2c3aDhFTDF3bHdO?=
 =?utf-8?B?SUoyTzNWOUR5QmtDdUozSlRYZFJXRXIzcUo4YkpGRUorWVR3S0ZYWDV2a2lP?=
 =?utf-8?Q?vA7GH4ZCqDE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXhjV2FPTjRaaXpvL2lvdkF3WFZRZ0xXTUt2TC9QSmVTT3pFaGFMTDhBUjNP?=
 =?utf-8?B?MWZZNDE2aXQ3dFJHUFlOSjdNc0djeUk0bm1RUWdUNGkzOWJBa3lXSWdNTVdU?=
 =?utf-8?B?d2IzVmUxYWwyd2w0aXh6dUNvL0lIalBJVFA4TDg5cTdxSXRZVDhFT3MxdUNq?=
 =?utf-8?B?b1lVRFl2anhWSlZrWStmTTVHN2xRYmF4ajVEbjBuQkQ2OXJuZUVlcVlySStP?=
 =?utf-8?B?eVFWRVNQamYvejZMbFlhSHczZEFmSi9IYU16dDRvZ2N0b3ZDZXNtbGRHcVlh?=
 =?utf-8?B?WUp5THczUy9lc2x4SzM3clJQR0tOdzBkYlZhVjRFRWdCK0QzVVhhQlJ1OWY0?=
 =?utf-8?B?dWhUcWZ6bEtDUittbGl2Sy9pN2xma2ZPVjdRM1RJdUFqUTVLdVBjc1pjOUNF?=
 =?utf-8?B?ZHpHQTV3cHlVZjM2UEd5cnJCWjJVRXZmUldhdHlzRm9rV2Z4NEZabmxBKzlL?=
 =?utf-8?B?ZFM2MGg4aGhDVjRLUkRvRi84QVJreC80czZQVTN2aWFsdWNjcmVBVUZzV1Jn?=
 =?utf-8?B?ME1INmxmNHl5ZjVHVnRuaDJkK24xVXNVMjhJVk5LM0k4dloxNVdrME1mVHpR?=
 =?utf-8?B?aW9BNHNuM3hJa0tmdU5TV2FQSXBXS0tYWTRhK05PbWU2SkhOek9raXprRnpp?=
 =?utf-8?B?YUdIWGZFZXR4bmpEYzdhUHRYZ3Z1RDYrcW5ZZm8rc2FHVUZtZDBReXJOeXA4?=
 =?utf-8?B?ci9UOFlJVDRLSmVvNGx6cDkrSlpXNFd5dnI1bWJOdW4raWVJODU3c3A2c1FU?=
 =?utf-8?B?dFljK1dwaWlQTjRjOVpiS0tjUmsxSEhxZkFFSUxGY2h2ZWNOaTZUeFQ3UCtE?=
 =?utf-8?B?RnlmWGFVNHpsMXFyYm5IRzJ2TnFPcm5GRnNYbFVhSUFIN1U1cTVLWGNZOXpa?=
 =?utf-8?B?Y21kYVB4bmh4T1p0d2NXSnB4WG9ubEJHVkRHV2s4bUFmTkxWME1yR2VFcTRN?=
 =?utf-8?B?eWI0U0N2N0ZLbVZRdjZWMlorUzVLLzdmNTNKWWhvSEFsUU5xclJ3U2Y5d2ZR?=
 =?utf-8?B?Q2NneVoxR3ZSaE1YZTgrcXFCQUlVTWV4OVNqby9iem5PM3dGNkdKamNmMm8z?=
 =?utf-8?B?SFdrcGRjUjlyK21scjFpZUxOcnN1R0dPWmgvaERYUUxNaTc2bG5ScXJYbXJP?=
 =?utf-8?B?NmZ5YUluR2laMHpVMHRydnpGVHdLQ1luYytsNXB5aVNIUk1DNUI1ZEtuVlRs?=
 =?utf-8?B?dEdGNUxLR2tGend3Y0xHODd5WXU0UUZwT0g1c25hOXd5bEo4RUpmZ3hNWlZU?=
 =?utf-8?B?WTR6b0tWdVc0eEpORTR1dDRiNGlNck5lM0tBNmRaVkYxMDBYVVhGbURVUE04?=
 =?utf-8?B?SHV1clFNaDg1ejVQS081MVRLbWhWc2ovdlYvZWhCQ0d2WkgvWlFrTVpNQ3kr?=
 =?utf-8?B?Q2FaRGV2bXlhSjNNVEp5SzVIZEo2c3Z5ZXFobDhnREFCUmJvNlVrakl1dVNu?=
 =?utf-8?B?U1FVb25COUllcjlwM28yZlE5RWo4S0d1TGt1V21wUmpjRi9kb2RLQndydDVz?=
 =?utf-8?B?ODhlV2tIQTFCNmdOSWRnUUx2MjFOYXh1bTlOQmZKcXo1ZkFaSHByemtDY1Z3?=
 =?utf-8?B?K0FtWjVCelk0dEZOclVVRlVmQzErQ1cxUW11TENmK2MvOFY1TC9BeVplTmZu?=
 =?utf-8?B?MXlQd2dRbmtTeHhCYVpLVFVSUE82UlZBb1NCV2VKU2xzZFRjYmVsQ3NhWDNz?=
 =?utf-8?B?c2xady9MK2Y0MHVjcWR1TXJ0T1NaQUgrNTMzblcyUHlGZk1vd3NTR1k4YmVm?=
 =?utf-8?B?ZzBRM1NKemVHUjU3bEUzYUdEVm0wZFc4Vy9KZGVxa3dCZjNubGZsYndnbXhL?=
 =?utf-8?B?K0V3aGhncjVXUEFROFFEbGR6dnFXd21OWWxiVDViK1prZDBXMzBCMTJNUE9z?=
 =?utf-8?B?TVpIWmI5MzN4a1pHN0VncDdjQlozRHEwUmdRb0ZYbE40WG5DbGc5R3FIQ2NO?=
 =?utf-8?B?b2JYbHRGS2F5L2c1ZysvY25MYml2WitVcnN2cHByY1hHbHU5MEhuNjg4aW1n?=
 =?utf-8?B?emw5Mm84T3UrODF0R2hrbG9qVjhYd2dwdkxYT2ZkWDZ2SDBOVnQ0MXg1Nnkw?=
 =?utf-8?B?dG80M2ZCM2hHdlVzbUtvdk42YUVQZzJzVG1sd0F1VGIwcE9TZkVCdUVNc1hX?=
 =?utf-8?B?MCs3ajBJZ0hWNFZjT09SQWtwUUQwTVNVSVBNRTlacXJBTmN4UzF6b0FJNFBh?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2768944a-1d09-4d54-d88b-08ddbe22f2bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:25:47.0153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22hjASizMwMgriAZp8bWQ5/tqv1fha8NBot5AfNluPz4pacKGKSAWh0nHd0Yv3mnTO4qD2HpxJJOlwwE2PJsPnj0DrKC65XjcYvuBhXQVG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6663
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

On Tue, Jul 08, 2025 at 02:46:04PM +0200, David Marchand wrote:
> On Tue, Jul 8, 2025 at 2:44 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Tue, Jul 08, 2025 at 02:28:16PM +0200, David Marchand wrote:
> > > Content (param[]) of received multiprocess messages are aligned with
> > > a 4 bytes constraint.
> > >
> > > Before patch:
> > > struct mp_msg_internal {
> > >  int type;                                                     /*   0     4 */
> > >  struct rte_mp_msg {
> > >   char name[64];                                               /*   4    64 */
> > >   /* --- cacheline 1 boundary (64 bytes) was 4 bytes ago --- */
> > >   int len_param;                                               /*  68     4 */
> > >   int num_fds;                                                 /*  72     4 */
> > >   /* typedef uint8_t -> __uint8_t */ unsigned char param[256]; /*  76   256 */
> > >   /* --- cacheline 5 boundary (320 bytes) was 12 bytes ago --- */
> > >   int fds[253];                                                /* 332  1012 */
> > >  } msg;                                                        /*   4  1340 */
> > >
> > >  /* size: 1344, cachelines: 21, members: 2 */
> > > };
> > >
> > > This results in many unaligned accesses for multiprocess malloc requests.
> > >
> > > Examples:
> > > ../lib/eal/common/malloc_mp.c:308:32: runtime error:
> > >       member access within misaligned address 0x7f7b35df4684 for type
> > >       'const struct malloc_mp_req', which requires 8 byte alignment
> > >
> > > ../lib/eal/common/malloc_mp.c:158:9: runtime error:
> > >       member access within misaligned address 0x7f36a535bb5c for type
> > >       'const struct malloc_mp_req', which requires 8 byte alignment
> > >
> > > ../lib/eal/common/malloc_mp.c:171:8: runtime error:
> > >       member access within misaligned address 0x7f4ba65f296c for type
> > >       'struct malloc_mp_req', which requires 8 byte alignment
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > ---
> > >  lib/eal/common/eal_common_proc.c |  2 +-
> > >  lib/eal/common/malloc_mp.c       | 18 +++++++++---------
> > >  2 files changed, 10 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
> > > index 0dea787e38..3846c7178d 100644
> > > --- a/lib/eal/common/eal_common_proc.c
> > > +++ b/lib/eal/common/eal_common_proc.c
> > > @@ -62,7 +62,7 @@ enum mp_type {
> > >
> > >  struct mp_msg_internal {
> > >       int type;
> > > -     struct rte_mp_msg msg;
> > > +     alignas(8) struct rte_mp_msg msg;
> > >  };
> > >
> > >  struct async_request_param {
> > > diff --git a/lib/eal/common/malloc_mp.c b/lib/eal/common/malloc_mp.c
> > > index 9765277f5d..000c7f6b47 100644
> > > --- a/lib/eal/common/malloc_mp.c
> > > +++ b/lib/eal/common/malloc_mp.c
> > > @@ -148,7 +148,7 @@ get_unique_id(void)
> > >  static int
> > >  handle_sync(const struct rte_mp_msg *msg, const void *peer)
> > >  {
> > > -     struct rte_mp_msg reply;
> > > +     alignas(8) struct rte_mp_msg reply;
> > >       const struct malloc_mp_req *req =
> > >                       (const struct malloc_mp_req *)msg->param;
> >
> > This patch seems to have a lot of these definitions with alignas added to
> > them. Would it be simpler just to put the alignas inside the rte_mp_msg
> > definition?
> >
> > More specifically, if its the "uint8_t param" element that needs alignment,
> > how about changing that specific field to make it aligned?
> 
> We could probably enhance this, but I expect this breaks ABI.
> 
Is the multi-process message type part of the public ABI? I don't believe
we ever guaranteed multiprocess support working across versions of DPDK.

/Bruce
