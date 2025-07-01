Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64CBC83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 15:49:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1440B40276;
	Tue,  1 Jul 2025 17:49:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 6870440264
 for <dev@dpdk.org>; Tue,  1 Jul 2025 17:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751384939; x=1782920939;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=33F9/8BEFf9pMAKcnQozRHTtlPsdqV7mN0tALcHx9XI=;
 b=EmnZ75WGJ4Z/l/f4b/058ktlns4WBhM/Gt88PBJEfoaw4JmnEi3mDJUt
 hIlGO7+GuJ3whL1SlCk+b/lZp1DRZg9uDb72/lTNi0egHsfKMG71ka8Eb
 vqv3uCjDcvQBvqwD6A32ClsRXSQASquXjlbOoi1ukZgkiW/dmRpIudIKi
 v9e17ta1tzhDXJRu0TMPL327CwCB8mCRQ1QmFArctycU2Yr1EI3xp9uWp
 7Emm5Zb7tz/x5InnHYT6S06ZeSYYUz+kluR8t/tZG7twoa2bQ3mHNtEv/
 84B8qwu8PMu4H/7Xgo0qJbCSB0gUMnz2wDlmd3I1XvKQoi/BfuiWICK/w Q==;
X-CSE-ConnectionGUID: yIgKuJ1bR+m+UliOpkuckw==
X-CSE-MsgGUID: h3U0RthKTgqJhhkg/vylWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53748943"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="53748943"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 08:48:58 -0700
X-CSE-ConnectionGUID: zE2uMMpXSDGC/SUCM1JQvw==
X-CSE-MsgGUID: 33RQxrDXSq2m4cwWnH9hAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="184856376"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 08:48:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 08:48:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 08:48:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 08:48:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hxwtze9cPq7DZvbURAK2ASOALQL3636lAmf2x3xOdjBtPVYU7MshrQxMHpyz8h9SSoAhcwz/7DngKdjrHJPiRQ80LNTcqrLHymyEMmq5KILgen40RkTbUwXyLRwQEnGdFLzSucjaCkn4w8eN0z4oOrVGZooR43O1r839LMo6WqDF+yqhdtWI+s0bb4cF6MxZ5NHWx3rdl7yhpTAiBw3YYZW5OWUBskk/Awlbwq0FXf47OsET70ccXCp5BzANE4HlEzFpi4wlahZFzpn7ZC1hN4Gjq4SqidB9GxoVJtkof/h1hHsc3BfO20Hohi5dk/lv32shonulh8hiw6LatY1JWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdrWqdGcmitu1052ARAn8+NyfMgKIo1OeN5AxK2vv/o=;
 b=j6dVjrm667IrqsCe48kpX8Ar3K7+CsN6tLfDdMs9oguIZZUrT4IqOHlrlxsA1iIqrIHyxWXJHHzxDsqvuqQq74A4ZcpUOBeQ58IuqgvXL+UrK1T7E6vlLGBXrMNDSTb3FIoFuY6OiD5gw0cnaTO1NAOTbq85Mkk3L9vfmiaCrgsNijnTJta1nKnHvFUR1LuyNRf4j+PE1reXFP35TKMYe4c0rltJLzMdSo8EPNW/v2S9f/TwLQEF1c4bldRGH3/5bSYomlQ0C+s5hiLDfF8zMVMfhGxxHoVW6UgNp4+ilZeJwEgg2eA6tr4wu6JA7Ei/gXbxolPflD3IVEEz+i6Hrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6393.namprd11.prod.outlook.com (2603:10b6:208:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Tue, 1 Jul
 2025 15:48:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 15:48:26 +0000
Date: Tue, 1 Jul 2025 16:48:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <fengchengwen@huawei.com>
Subject: Re: [PATCH v3] test/argparse: change initialization to workaround LTO
Message-ID: <aGQDRIez0Xy1r6Sg@bricha3-mobl1.ger.corp.intel.com>
References: <20250627162305.340042-1-stephen@networkplumber.org>
 <20250701154202.237442-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701154202.237442-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU6P191CA0053.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: be677213-eb86-4fdc-9490-08ddb8b6b79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlVMUTlrN2JoaFVodDBtenNKT1RIODZDYjdkOFRKdm45OFAvZFIxMDh1Ry9z?=
 =?utf-8?B?blBTSGZNRmRJK3lManc3NFVUUFIyc29vNWp3NG5EQlk0WkpOWHMxVnBTbUNi?=
 =?utf-8?B?OVY4d1VBZWN6dEJXQ3FkeGxtallZOTBTbTNWWVUvaW1GamF5Z3JHcUZ5T0Jr?=
 =?utf-8?B?YVZSa1NTQWhhOGJCTER6dEE3QnZMakhIdlFQNzEyMGFwaFRjWjlMQmhUaVVQ?=
 =?utf-8?B?ZlRZSHVPVHNvdE5MRWRBeUJLZE43dWJmbUNhVE9aY0w3MHhZUWc1NityUVNS?=
 =?utf-8?B?L2g5R0xHQlA5Z0tuM2NoZUdzemRGanNzQ2RJM3dNYzMrMkRrTVRmUUV5TTNZ?=
 =?utf-8?B?WUdzMjVBZHlhVStjTFRINjNmVlByTCtuRDl5SXRIQUF5ZFNBYWFkcW1FcG5Y?=
 =?utf-8?B?dURIQWcvQ0o0TzFBWm1ORUxSdkt6SVo5QU5SbFprcGpvOVNEaXQ1MzE4TUFG?=
 =?utf-8?B?cjdpMS84d3RmUnA0S2h6SHUrdnRmV00yQkM0Q08yV3VFMWVlYWdYaHRQWmNj?=
 =?utf-8?B?R2VoKzlzYy9jUk5FejUzeDArSGlkeGJnY2JBbXpGK0F0cGFhTGFpbCtWM2ty?=
 =?utf-8?B?VWZVZFhUeldHUzlFQnpJKzRRRC9GdG45bFZSeFk3ZWdsWFY3ZFdrODIrbDBK?=
 =?utf-8?B?SzRCVDdTSWUvTEpMTjNUc3IycmRlRlJGa1RNVm9ZUEduZThHNEF4VFRNc2hI?=
 =?utf-8?B?dml6M3czYlFJNVljVmlpYllqWlBmQ1dxT3ZXUWZ5QUtaZ3NsaUJyTnBGTTFS?=
 =?utf-8?B?L2dWbUVDU0FKYXhqNGVLOTdIWHRsa3Rpemdhd0w1eXk3dSswekRmVzZGdVJE?=
 =?utf-8?B?cTRuS2NxRnByRTBrTmhIWS9YSk80ZDlBTytZeFF1WWhOM095d1Z4cGpPNkVT?=
 =?utf-8?B?dGlsY2NFZTJNLzBUZ2pjVjJneGNKb1lvaitSUURYU1ZFWkhFSGJLTTFON2lO?=
 =?utf-8?B?bXd0SW4rWk9BRmN2WEl2K2hacHhhRHFYZ3I5WklsT0NrMmtXczQxZ0tvQmVw?=
 =?utf-8?B?WndUUUF1WWEycWs3cmdwRll1UHh4aWFiZitGaXRNT1VsOGdxb2N4YnA1bExB?=
 =?utf-8?B?L0NYZmVuWE56a0tVUG1kS1Fvc2ZTRDh0VGdIVURzNDNhcjFlbTJ1a29mUzkz?=
 =?utf-8?B?aXIwby8yb1FtUUV2d3p0Z0luT1ZKczMzZzdtWFk0Z1NhZjhkbHAyNkJXYVIv?=
 =?utf-8?B?L1pnRjBMZGdPTmwzT2UxZHpKT1VFdUdQMTIyUmEwbG1BMFZUNG5aUk9nMTFq?=
 =?utf-8?B?Ujd5ZkhXM0hQL3BBNklZQ3lXQyt6YU01dVdjWkdyVERxc0djNnB6T0wyUWxw?=
 =?utf-8?B?RWRKYy9FUjMyYTFIV21zM3hZdmpRWDZSY3pLb0VSYm9JMlQyQnJBZWhNTi9a?=
 =?utf-8?B?cjllTzMxcXdTV0VIYmJTQ2M1YmVUL1JCeXphMTdrNVNVK1hFTHJERGlTcmlK?=
 =?utf-8?B?a1Z2RVRCOE5zb2txWTFZZUV3ZGVjNmhZbDRjSW1VU1dETUVHNjdabVpLM0Fz?=
 =?utf-8?B?ZzQwQXNreXozbVZ1RTNBRjF1TUVwSENJdUphdThEZHYrT3lqTHJpZGljVThD?=
 =?utf-8?B?eW94aGJTY1NQMzl4Mnc2MkdYaWZqMTloS2pYTzdhK2ZIakxQNmR3eFJRWVN5?=
 =?utf-8?B?N0FQNWhnUzBxa21FUWhPd1ZKNlh1WUZmMUJmOXRwdG9JOXF4MmpPMlpBbVpl?=
 =?utf-8?B?MVNYdGFTT2ZoSHNZRkVXOE1qNTJ0dnh5RDM3Wnh0NlJ5dVRmOGhZUDJraFN0?=
 =?utf-8?B?L01nWkUyRWdCciswQ2FaU05PVkRMVGJ5TlNRYWtTR3ZVdjc4TmZ5Vll1QVRG?=
 =?utf-8?B?dHBTZFRZeVBoNmlSZ1BTL2dIR1NrYm8wcXBmN2dBcWVkZ05uYTMwTXNKdkto?=
 =?utf-8?B?ejdORExHK3NKNHQzUUpvNzBSUUlEbWhtQ0JCN3pFOUJFMk5BUXAzOHNRUnZv?=
 =?utf-8?Q?kezlCt4f86o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3RnN2RMS2doeFJZWngxd1VQeW00eFkvaWNFdGx2aW5OWWF1RmRaZkRrdTFR?=
 =?utf-8?B?TytZbVR5R1pVdFJNWTlDT0oybFZ0OTBVTkhUVFAzWXI3eXExK0J4MWdxWHBE?=
 =?utf-8?B?bFdJMklXUHR3S1JqbDlnZmdzVFN4d3B1UmV3eUVqMHgrT0dFY1RnZ2RvT1Ru?=
 =?utf-8?B?bE51SXZYNnNhc042b3huU01OS2cxcjRVdUZZVzgzQlFRZlFKek5kc2FXN0dO?=
 =?utf-8?B?ejNHVHVsYTFVUzZRSklTdWxuaEkwV2xZc1RPeXIxZEZ2K3YyOTl1dkx1NExW?=
 =?utf-8?B?M0g3cXorL0h0WHIvdytiak1TTUZBZjVFQW5tZHFZNDhQbHFtL3piZ0s0LzNU?=
 =?utf-8?B?L3UyWHJLcWdseGNOQkt4TFZYazVFN2FNSytiSEExbUpYZW9qR1N3TWxlWjRF?=
 =?utf-8?B?U3ZRTWZVN25ZRWRwQXN6NW9kU1p0aktDNHVaQWVwZ3VHUWFSZGd3Yk5TZTM1?=
 =?utf-8?B?VXdWZnQ5dkEwYWtzdWN2cnlncDUxVWE1azlIYUJDUnl5RXZKdlc4bFJMbWg2?=
 =?utf-8?B?NUpKU0NoOHRvbXhmdFdFUWJ2T2pCN1lQMmJ3YXlWOXRvSDh1Z1AwY1R1L2t0?=
 =?utf-8?B?RjhlSzRIelU3QVBka2c1dENGL1hoYkg0ckRxWnI4ejlQTlNvRlhFOFFqSVY0?=
 =?utf-8?B?ZUwzNHBNbEdodXVvdFBRUG93Ykg2andnNUE3QW5PNFBpQWptZkJiaEgyWEEw?=
 =?utf-8?B?aUVweGpOMVhjckFkSEpBQ0dORXA4NENabjR0MTI2eUJNVEJydm5NU2F4bHJv?=
 =?utf-8?B?aUVlTkFvbVY5MHh6T2F4YWhzRk5DdWNLcWJXZG1Ib1RCUUorRTZZdkZIa0VW?=
 =?utf-8?B?SStGb3lPUXlrc21PblI1T1NPVjNET3RSL3NVZ3lQT0Rqbk1ZbDd1YTM1VE43?=
 =?utf-8?B?KytHeHdBNVlVYm4wd2FmamMyQ1hmVnNJMU1wdHVyVGc2WTJrcVF2Mkh6VmR4?=
 =?utf-8?B?c3NUdjdEN1ZCMkZCaktvaDNlTVk0OGg1ZytIa2xSUVQ5TnVnUkE4VHJlUERu?=
 =?utf-8?B?OVZ4YmRMOFluem03WFFLSVF6QWNKRDV2Wk9CWEdRYjVNV08xMndJemJUWkJK?=
 =?utf-8?B?WmVac2luZ0lEMEFyNFNIMG1IQUdRbTZSM0pKLzBxNE1ybGdCUGZYeVNsUWE3?=
 =?utf-8?B?UzFkbEtVNldndmtUeklDSURVV1FocFNTRnlKVElEcythdS9pRmRHb1hhYlpE?=
 =?utf-8?B?bGJwd24rckxaNGZRSllkaE1VTGQydXM5SnFQVExMVmxxdTRLd1F1d254OWZl?=
 =?utf-8?B?dzQ0UUwzN2RWVWZ4UnVsUTBNQmpyMWxLMjB1YVpTcEtYeDNBWTZQbnk5R2xY?=
 =?utf-8?B?UkRWbytUYy9IRWhCY0o2WllLdXVJUUNMSGVUOEVvaFR4TDRNT0ZRelBXY3hJ?=
 =?utf-8?B?YUk1UE1DR21kVDllYkNGdDlpRStORWkzbk8rZjdSMlk4V25YRDZodnUzWStw?=
 =?utf-8?B?VWtVRTMyK1hId3Y2WE8waS90VVZaVGJPVC9YVGRTWThKK3lqbm4yZDBab2cy?=
 =?utf-8?B?Uy9EODBWeFZCWEYxYkxkUXRRNitUOXBJTjY5NURFQzkwZ1ZWdFN5VUxnekY2?=
 =?utf-8?B?ZUVndDVkV25kZHNYV0JWc0J1S1R0TG13Q0JhOHRxZmVWeGlldlprVTRyTXBt?=
 =?utf-8?B?Y3hMZUwwYm1nRS9FekFmMDFZbDhueDEyOVZqckhuejNsWXYyRE1lZm9WeTl1?=
 =?utf-8?B?SlR0UzA0ZTBYRS9LZ24reXZPNlFSSWtYWS8rMTdEcHZXTHc2WUt0Z29NbVdL?=
 =?utf-8?B?RkxlZVhNOC9NM0VCU1FhS21CSll6VUxHeW9oRlJuTHlSTGV4RWRVMDRla25E?=
 =?utf-8?B?akN0VzRQb1VQMjBrVHdaSmY3cEJaNnRkWVc0bDNrN0pLK3JsdWtmNERBblNJ?=
 =?utf-8?B?MGxpbE56Zy9yN0JoOUxDbUN5SlQvb0JrSmFCVWJ3MVMzR3djZDdnTmdYekh0?=
 =?utf-8?B?UHdCR05Makc0VkRBajBLSmhIdmhHdk1VZHB4QzRMc2g0UzhHa0NLeDdIUXBB?=
 =?utf-8?B?MzhjUXZuSFRHb3M3Mm96TW5ra3NTc2FiTU9aUCtTV0s2QzQreHVtbmJ5ZVJa?=
 =?utf-8?B?M0dZU1YyeEZKU0Z2Qm5LMkpNRVFEYjFPUTJuMEhwVXZTNHF2cnc0Z0c5TEhp?=
 =?utf-8?B?YlJJVmg2bHJtOHhBT2xCNG1kYmNSeWQzSTZSQ1FUWG1aeTBnOFJrVGREUzVC?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be677213-eb86-4fdc-9490-08ddb8b6b79a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:48:26.1904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wY51/178iDusQ+w6chyD/3KV2AWjT4vfYdhV+Vjg+u7MPk4P7UqUATqaDU0R0X9mI3gY6RKjRI1fhinxzWD1AZ8QjuWrzybms1Df7tIUFaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6393
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

On Tue, Jul 01, 2025 at 08:41:46AM -0700, Stephen Hemminger wrote:
> When compiled with Link Time Optimization, the existing code
> generated an error, because the compiler was unable to intuit
> that there was space in the flexible array.
> 
> In function ‘test_argparse_copy’,
>     inlined from ‘test_argparse_init_obj’ at ../app/test/test_argparse.c:108:2,
>     inlined from ‘test_argparse_opt_callback_parse_int_of_no_val’ at ../app/test/test_argparse.c:490:8:
> ../app/test/test_argparse.c:96:17: warning: ‘memcpy’ writing 56 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
>    96 |                 memcpy(&dst->args[i], &src->args[i], sizeof(src->args[i]));
> 
> Initializing a structure with flexible array is special case
> and compiler expands the structure to fit. But inside the copy
> function it no longer knew that.
> 
> The workaround is to put the copy inside the same function
> and use structure assignment. Also macro should be upper case.
> 
> Fixes: 6c5c6571601c ("argparse: verify argument config")
> Cc: fengchengwen@huawei.com
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
