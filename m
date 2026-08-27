Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96FAC61DC6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:09:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 657B940150;
	Thu, 27 Aug 2026 13:09:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id DF1BD4003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 13:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787828958; x=1819364958;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5WrsM66rNBkBApeb059ldaSzPsJhuaSH+0LAL0BmxTs=;
 b=HhxCUEmuiUHoyYBx6j6lHRvCCkgvweEvUtF7fzjrdWYbXUWDa3xmJku9
 L3dOHkjtNKZMkAtS5DivF4V0O7+4VVqP/IoQy9tYoAR6bc0hiwPcnBpQ+
 PiBOpUSHGu9O8nhJgvK2iCXSWHbLEQBPUFl2q+enmH/fBZ7hregeekNi2
 q4CHFpHpJgH5cVjR2S671+4CIDJjXNSXqIRNVv7AdeaHqMmJ/VjEBUGEJ
 E3yIkcCL1/0wvHDQE3U3hPlDp5z8CMIqwRlQAgOlpCL/jmvn7OgDLRGaK
 HBPfeHVjcfsKzu5+Iq9/VHZHhgKdD7XYDZKFG2oZZan8AQ2wWAR0oxCHH g==;
X-CSE-ConnectionGUID: Y11QXEXpSd6pB7+rcC43xg==
X-CSE-MsgGUID: W+QLkOUWTq6ZFh7eDCIb7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="87269260"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="87269260"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 04:09:17 -0700
X-CSE-ConnectionGUID: iHnGuVAlTVSGmp23PGaxXg==
X-CSE-MsgGUID: GWWNZtE1QTaxUeXIIzti2w==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 04:09:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 04:09:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 04:09:15 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 04:09:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgq1f1R8GiS/SqGrdbcsSRBZx8iLOM5lMknorzzyVq+fpGPJmW9RPbA0NefZN81k+z8Rf0mdjFkqc17DH/4xiE2fBPKKg2+AoXnp+FkIOWr9BfJMjCDdreU1OA5QuFhOg6rX+vxlwkyZgEhiSqCVW5Mtf0w5Y4T5G7JzXhZvG/yGb4Ed7BDgd2xXs1QC+3Q4cnhzFybWk9+33FzFxWGB+ooTzz0agQVgBMCQJ5RziBBCVBlaofKVeeIO6EEUqT7G/NbVEXSabV0qDg2WvHYx1Ee9ng92aBwO2VXTvy93emickPzbOaLog7lY3mDIAQKWIb4OXBTSRT6QEZsH+teijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl9+fZb80UnEbmo3Prtmi6G01YhCBmUauE/c2ZE9FIY=;
 b=DYocxdWIh+bA31dd5O+JqD7Fgu8FAJq4H9wk5TUz5eZwd3KQ+eQQEqvKB4qqAGzBDkY1McLRfQFquDf8f+JgLyDStdIFJWybBlJHctGypjjYiiQZ/7462gpRoO8b6NltbSdhWV++VQ+J+0nO/Vj9p7zE1WKt/i9BXN5jz9n7wXAfrJ4RDOOIPcnPanNhzCy9RYsHGFxR7zlEvsjZmMx3LCHD5veqeF2MUpMLPf0SG75Z+rsbZo0AMHBoZqjps5hVu9M6mf4h/i2qQ6FFGkTjDXovHjHntMR2WotdodsFjVOSECKY7iyIs8jQbzCDmW4bZXXrXbQFip3o9Iw/TUUj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by DS7PR11MB8783.namprd11.prod.outlook.com (2603:10b6:8:254::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Thu, 27 Aug
 2026 11:09:12 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 11:09:12 +0000
Message-ID: <931547fb-71a1-4b59-a9c6-48bc5a09f1a8@intel.com>
Date: Thu, 27 Aug 2026 16:39:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] ethdev: per-packet Tx timestamp slot management
To: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>
References: <20260817192417.3009990-1-rajesh3.kumar@intel.com>
 <SA3PR11MB43100661032C326636FE9E32E1A1A42@SA3PR11MB431006.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Kumar, Rajesh" <rajesh3.kumar@intel.com>
In-Reply-To: <SA3PR11MB43100661032C326636FE9E32E1A1A42@SA3PR11MB431006.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::17) To PH0PR11MB7563.namprd11.prod.outlook.com
 (2603:10b6:510:286::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7563:EE_|DS7PR11MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: f67e245a-f046-456b-2104-08df042b9fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 2Gx93BhvOK63ygWPNGgcnFLISXsuDWovwKnW/X6PnsHl78w9x0QIVQTIa37qxaDVcxEWD1m8ZkHIMCn0QasK0EhFZU13eVR3zVbYriJXNx8t2JwpYqkbhRFcIajawz0IShSAaPL/IDMfpew8Qlmrz5dyeCZm5gzPC/Mf8koCSSsGdM4HPya6hRKjPFkCmmTGy0qW7j/3p0EWCFt82IDFY5jmS4rJHqilNg8XwLc8eUcfJE21P9eVyiZgycrtHSBE79inu+U9LfAGTIMx0mPLJbUAAv+p/zi9OFsMRQ31iEvtFgpEVtsMnsS1kXLPe5OrLjqQerPL4TXr/+QAMZegVccYDerIkOKRPz3Ojq9dWLvl7SPI/oG0wLKKwV2/dmFMp+LpN6UpC8zLuzP6c37TZMfHH1j6ak7H4CeD7j4cqxaeTrmUCD26Y2teiskOTDFGLLZTX5kXLhDpzc0gKjX+FXgQA2v8KpV0uBRazOgL84i28itqWr8N3yHE73ZxfibiN54d6V9D/GrNEeLJtLnZefMqVu7srjwo/6KKMp3Ljmtxvmucpiu2Z6pz9cLJyRncqEvPIOTHi7YlHWX/VMWdIfmuG+RGmY15vq33n2wIxgy6DUg0dbR1d4YyLh+XU+QwXkMFVyEFanBr20EG+lM1od+bLz5lhlpHq+45tJrxKZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3Z1TDRSZWxlOHNSbytnTUxCcDFNanFBYllNSzlMczVvWmJESCsxT0lQanEv?=
 =?utf-8?B?SFRWeE1kUzcxZFR1N01sc3l1SGxBRDc3MlpaSzQvOHJaMzdyVnJkMmhmcml1?=
 =?utf-8?B?Zy9JanlOTENod08xQ0VMK1ljTlJJbzZraGs5VDdIalEzQll4NkV6blFRdE1t?=
 =?utf-8?B?dUs1YUhiTDd1RkhraExoNmVIQXhuQXJSVzNuY3AyTFluL2NqbzAyamh3OXNp?=
 =?utf-8?B?cGRhMmJkNVFKYzcwVTFKbGlrck44ZHJnTkNnUHNVdWhnWm8rOVRXTXk4MHNR?=
 =?utf-8?B?VTJFdDNvUGFnRVlCc09ETjVCdkkxelZVeXZVMklHdU1hcjYxZFdLdEVMWUYy?=
 =?utf-8?B?SnFKZ2d6ems0cGZ6TUZkYmREZFRnUGhJSXpHY2VHcHFWdFpQVGs3VlVCYnhz?=
 =?utf-8?B?VWZ3TVhzK1IxVXpEanl1TThvTElhM0VFQk1DbXllY2xjRUZ6K0EvbHpJdzEr?=
 =?utf-8?B?Ty83eXFIY05mUlplR3ZBKzYyc3pVU3Y3L1cwRE9GLzA3YjdYanRsaVE5SjhG?=
 =?utf-8?B?Z1hLZEQrREZZNlp0aGtFaG9KRGlCNFNIRUVXcGtRYnhOK29CendZcWR2U2JJ?=
 =?utf-8?B?Qm14bTVKNUs4UnJUQ3QwUHozVWk1akNmZ0pwcGNNZllkRktCb0kwNmtGSng1?=
 =?utf-8?B?ZXJZTStDQmE2eGc1SWE0enZRUUwrNWxaMTUvVXNGVXMvdE1pc01Sc0s3YjJs?=
 =?utf-8?B?emFQUGpuZ3lxMDZSS0lYTFY0Um5SYmx4VXpWN0U5THFqYnpzc0VsVTREQW9F?=
 =?utf-8?B?dEtKd2ZxZDV2Y0xidWVSMFZjdmF3K0FHYnkreU02cXZzN2ROMU5OWURPYU5t?=
 =?utf-8?B?MFJ2QmNzK2xuUnRCYStXUlA4ams1UzBuQ2M0R1JZKzV1bGlHZ3N2UytrQUhF?=
 =?utf-8?B?eDgyZE9FMTh5TEJ5RHIrS2YvRU1UNmZ3b0pNU0ZQUGpabzF3Q0FScWZveEFx?=
 =?utf-8?B?YVEzKy83eFNpZE5XNXVkUFZJQ3UwU2NxTTk2d3ZadDlVZW93VXMvNzd4Ynpi?=
 =?utf-8?B?S21UeFFCcnc2bnlWWWVyVEt2ZEdwZzRYSTZhMmorVktXNjN6ZjduL3dZZGZS?=
 =?utf-8?B?Nk1IcTROT1FDUGhIekIyZEI4OTJmenhoMU9Sajl0b01JUW85bVlLZkl3TjI2?=
 =?utf-8?B?THAxdjZVR2p2S3VBQ3BYMTI5bHZWRklTRU4wWTkzZFczTURvYVpvdEs2ejJt?=
 =?utf-8?B?RVR0N2xzcE44b0xHa0lUTlVyendhcGJrT0Q2ejVxUE53OFY0d3ltTWdzYkVV?=
 =?utf-8?B?RDdpZVR3T3o4RXM4blY1Zjl1bjJkVmx0Y3REaGdUYndJMGg5VzFGV2pxQUph?=
 =?utf-8?B?Wi93dEExT1BuQ3ljQ1VaUWFyY3Iwc2R5ZGUwU1ZJRXB3a1dyMk5GS3JoaThG?=
 =?utf-8?B?dG1LN3d2NTh0OFhIWThpbVJjUnBRdVdZSWtTb2M5OXJkVXVVMkMxS3pEMVJN?=
 =?utf-8?B?YmVzWkw0OStnTjk5QXFFaTdqNHduejBJNWw1d3dWS2ZqZ3FJbStuSitUcXJj?=
 =?utf-8?B?YklMSDNXamRKeGUyRGRacWZlQjlJRHVHbnMybGdjN3ZNd1NFNHhOWjk1aHBm?=
 =?utf-8?B?UVBEUDBwR1FUaFRFd3JMMzBiQVBxS0p3YlZONzU1Y0FkMGJ1UUdzMTJIc3Ew?=
 =?utf-8?B?YWxmc1YwR3VXeklvVlVWYTkwVWFsVm1ZQjZGUW1TQWlGU0VnQlV3eUFZWjBq?=
 =?utf-8?B?UitnTmlYVDNLeHYrYXIrblJZK1U4dHp3TkVZRWd1UWU2MUVEbm0zVi9hN2wy?=
 =?utf-8?B?RnZqY3lFTGVyYm0rWE1lT3JEYU5JcytTZVVrSEhhWWtDZWlFVzUyamdIdUU4?=
 =?utf-8?B?YTFiZVRlMFcyeHJLbkFvaHNjVVg0NzhwLzdrcVM2YjdiNC93NU55dWo0bDgw?=
 =?utf-8?B?K2V3eVJla05UNEN1OFg2L1dGMkVyMSsvR0U5UFBZdEV5NGpTZExxd2lCNWNM?=
 =?utf-8?B?ZnRFcHU4OCtkWHBXRkUyQkVpRXBPNlBpTkxZcTZhbm5hZHMzUUJsOE5ucFE5?=
 =?utf-8?B?eXZsamFPYVBWSFhWYkpKU0ZwR0hDVWZ3cSt4WkhPSENBaXBNQmFxWGh2R3or?=
 =?utf-8?B?S3VYeld3c25semdVaWZ3aXYycTd3VEJZNmlxYlpvYTJNY1VMc28wdXRYR2Vp?=
 =?utf-8?B?V0dXdHBYZkl6eGl2UzM4NXdxTFMvRlowRW1wT1JWdXQ2dTA4clFSWklEM1Bn?=
 =?utf-8?B?MmZ5dGc3RGdHTUU4aHg4Smt4VDJ2Y3RZMVFmd0o2L1c2T0Z1QnQvYzRyNWg1?=
 =?utf-8?B?aUZPZ0RQWko0L0gxOUZDbVIzY3NoZ21kMTZQK1RhNU1HR2UxTWRCbnlIMXdL?=
 =?utf-8?B?OWY0bUd1ZU9Tb1NUUS9jQ1d0SmlLOXYzblFCdnBJU1RlakxueU1UL2xFOHNl?=
 =?utf-8?Q?cbwA9N3zCGLAY+Xo=3D?=
X-Exchange-RoutingPolicyChecked: QHNjj3Q2jihHO6Tn6IIjDs8r75KkA2Xd9TOlfmRrlCQuYcOtugWZS/k0mimdU3/wOISwIaUGXvSxEohcfvkqo9OuElwWiFVb/qu/QrYCleIa/6Hz1W2OwiNpfAsxTpVLhbWvJSvyObsmbYQigDUHT5TbvTc5yROG/8Lh+JfoGBIffw1i9LGP3LCljBkf4Wn7wKdh0zP0rro1602JC2lfyI2rOwtyR+hgU543nDJao+ajuYA97eykeSa10VsN5e7uvGMl8WnpavjBdCJolrfXySduIYRheRFb4Uje06JYeXk6rbDkkgNL+HLeX9Br2Ra2K3WyVH5b9Z2iSA1pE0mQyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f67e245a-f046-456b-2104-08df042b9fb9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 11:09:12.2178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXV7GRzx9dK2rmZtmHOaUi4LTnhSRRTfIiD0Vx69793nHSk8njn+yG8scPeuodaDmyqyFHmpI6hAssOXwhRmcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8783
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


On 20-08-2026 10:11 am, Naga Harish K, S V wrote:
> rte_mbuf structure has "timesync" field, which can be used for the slot.
>  This way mbuf dynamic field use can be avoided.

"timesync" in rte_mbuf is already an established RX-side metadata field 
and not a generic TX slot carrier. As it is used as RX-side timestamp 
metadata, not as a generic TX slot ID. If the same field suddenly meant 
“TX slot handle” for one PMD and “RX queue/timestamp tag” for another, 
the ABI would become ambiguous and driver-specific, while the 
dynamic-field approach keeps the per-packet slot metadata explicit and 
portable. For that reason, we prefer the dynamic-field design for this 
feature.

