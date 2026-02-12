Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3A2EE36A5
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 17:01:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74C6B4025F;
	Thu, 12 Feb 2026 18:01:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id E23CF40041;
 Thu, 12 Feb 2026 18:01:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770915702; x=1802451702;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=vGdRDhRRMLTZTeESVIchBn2NL+jqdc+KN79wMS4MRvI=;
 b=fxn8mIxJs/tg9UiL6U74q2+FnVyOnOVplmtub/9Dxae/Bc2cbPN25Sqk
 5cjJQTSZZsqG6Vg/CrFiBXyqW3lp7lBNKskpO9jRmJtIFCF1R+P9MGDhX
 bejaWtIHOK76U44CnmUo1X+kc+ijbUyC/kY3Y0HYg/4162w/erOB3U7AH
 7nuySrYbuz1hkoEc3BpH2+7DVO0GWsEyKaMuENDcsyuqcCu6kjaOPq2PB
 hKVDgLX6+Wk2WE2yZiQBBgp3dqFtkcqORPk3gw10bqg2aK13QEM4Ydq9K
 3A6U+ZhVEoFklVqpwt/MKmZztC5zU2OjnjWpFC5HZt65QlmSJ3QAPGRaQ g==;
X-CSE-ConnectionGUID: 7QaZPP8FTrC8WfXey3m8QQ==
X-CSE-MsgGUID: TwjQpPdoQwy8IRQyYDQSGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="97551244"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="97551244"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:01:40 -0800
X-CSE-ConnectionGUID: tf193fVlRCqhPeuAcTuX7g==
X-CSE-MsgGUID: ixMPHAa4SoqeD/Dx+9iWtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="211448534"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:01:41 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:01:40 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 09:01:40 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:01:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNlTssUzQfSDbMiiCxRxa0cuivFew4fyG5X0vkveIxXfTtCKp2NJre6dWir1Ah4zeWSXn2HcRghFPnhRa/4UnkuOCcWaVEsCRrkegb49sNOQ7tiNXgHZYq0NCDhzLqNEWB+SxyK8MvJkV6msbfNbLCkkyWZViHDKMl+aujhsOxu+brhuRlYNFHkVCwxPoIyDqDlpTsD6jwV8nxkKNEp8FPg2JjOtb4ilGy37tIBvQ4eYYFqHrQznQtYmSe+pgUhxo5+8rp9sCw33IGoODP9eLmgNO9NtwIHGuDdJ39y2IGX1CkaT5+drbb7C63FfTMFKiHziSNIZUof6jUEOa3EtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwVBEqlVopN9NmeAVbRi6+PbS95E73xghtRMVb8XeRs=;
 b=vWJkyxUfi/e3rTH3jEe7BxdPz8T9Z3pBo2Ifwh7v3wxNbAMO1zJDuIYUr6tnOO5Fm/rSvIlkzVfg/Re4bqqk04gVB7cSUH+C/aO6MjHNfJrPxeuOTiM0dPlth7dIalWicO9cNrnSkvoiJwlIY2m8wNnYrJtx238bYL4F8rGQNEP7bmZaY0H3RfDZS1hfqbQRF9bO7iBo+IDCx4R/Jqex1sQs5qHYcseSmxoeX+rf7X0a09W00AxhoStgKKk2i+9tnpkibTKLwVukdJUxODvZGArXYRy0dEJTFS4IroFVBmNXDyqvOP1WB8/oxwTYFmEhKnSnPF7qbfXGMClcSxEJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB8400.namprd11.prod.outlook.com (2603:10b6:208:482::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 17:01:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 17:01:37 +0000
Date: Thu, 12 Feb 2026 17:01:31 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] hash: fix maybe-uninitialized warnings on build
Message-ID: <aY4Ha1mEyfcMtU-8@bricha3-mobl1.ger.corp.intel.com>
References: <20260212162705.3923717-1-bruce.richardson@intel.com>
 <CAJFAV8xteqCnX7LKqPWFSmvbBz-rQVCRUuSmHLaHdG-BckhAqA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xteqCnX7LKqPWFSmvbBz-rQVCRUuSmHLaHdG-BckhAqA@mail.gmail.com>
X-ClientProxiedBy: DB9PR05CA0027.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB8400:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c7f71e-6cf5-48a7-dc90-08de6a5861f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7142099003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzZ3czdjSHkrQllxUkIvUXZnOENCeUtIZkY0Z0Fxd3V6a1BzUkhKTk5mNkkz?=
 =?utf-8?B?RVRIaVpXRXJQMUxJOWFQSGlFa3pDNW1iUDNtK1BCNzRaZFdBTm1IaGdkSjlP?=
 =?utf-8?B?U25uMFY5SC9pcFJ6NFYra3h5R1BHNk9LM3h3TVFENCtiMFV1Z1IxKzBiMDh0?=
 =?utf-8?B?SUs3MVR1ZnNPdDAxcExKb3BCbDFCS1NUYXpjSjFEdmlrR3RCV3duZG1kcjVt?=
 =?utf-8?B?c3EyUnpFS0F3WTFXR2lCWGtrUUR6cVEzeURHT2Y2S1g3UFBTZG1ranJtZ0FQ?=
 =?utf-8?B?ZE5nMWJvVkFHUEQwaGdyNEdjQ3lOc2Q3VFZaZ3RQb2lqbEVHR0NlT2tqWnpO?=
 =?utf-8?B?eTBySGgyU29WSW1mbm52VlBLMXRtRmFtRVB4UGFsa3NULzNaMCt6NEtMSktH?=
 =?utf-8?B?dEtKcHpxWmlJbHltWDg4L0dLK1NZcTFmdGlwK2VhdFZJSUlDL0RaRmZHWEN6?=
 =?utf-8?B?NFVSOXJtMjNNc1kwekcwS2lrN1M2ZzJUcUJLZjA5cTk2SnhXdEJmYytQWmxT?=
 =?utf-8?B?Q0tnZUZ4V0JCVDNUQ3lJL1BQS3hzbGgrL0tRT1J4RHF4cVZWRVdvdEhlV0Vm?=
 =?utf-8?B?aWFZVUJuMWp0NklPa29ZS1d3SFdtL0g0cWMwRjJnaWZlV1BkRXBrSWsxc1Q2?=
 =?utf-8?B?MUtTc1E5aUtCWG1uVWRYK3pENUt0N3hDaHVqU1hXUnJ2UWJBVXVNUGF6WTE0?=
 =?utf-8?B?RlZHajh6UVJzNUJ3VEVVL2R4eFlDSGtoL1c3Y1ZrOFY2d0Z0TWs4SWpxV25x?=
 =?utf-8?B?b0kvUk02SVJQbDgzSkZaSWhXbzZPTHJWYkxrckVyQUVUb0J5bFJEekQ0WldT?=
 =?utf-8?B?SGp5U0Z5TlEyYlFaNDNOMFpHNzV5a1pOTzJUMEFHTVdDSmhac1NlMHFyWXNv?=
 =?utf-8?B?MkJ0RGt1WHliQ0JvUGlBT01xb081VXVWaG9qajdLcEpyN1dUcHNETkdmVGZH?=
 =?utf-8?B?TVVYZGRaV0dRcWdZRk94YWdjMkVPRFlxaTRNTFBINVVzRHVkaGV4bVRMNXU1?=
 =?utf-8?B?NmZ6NEtPWEtQTnFzS1U0bk8wZHRSVmlaQmFCMm04MnU1SThYbWpNZWF4dFg5?=
 =?utf-8?B?WURuenVsOWdLQWRyMGs2Uk9RNERaYlptL3FUZkk3bTZKRHpaRGkxZ0lpM0VN?=
 =?utf-8?B?Z3AzZ2JhRncrWlJONFpzTmw2bDZXSWEvUFh2VUFwaWZVSThWZ29WVGZqdHg5?=
 =?utf-8?B?WnhsS1ZZM3pTV3V6Kzh6MHcwdGNIRkFhYy8vTWtXZFUvNVJIOGpyQk8rdHdZ?=
 =?utf-8?B?OGdRWHJVTFNYT3hQOVJ0aVF1Um0xZDU3RjErZ1dZc0poaldrTTZKNHJnTlZo?=
 =?utf-8?B?cDNqRFVsa3VmQVR2UUZ1cnY0VklpUWdDMTJmbWJWTng5Z25Ec2drU3g3cjhy?=
 =?utf-8?B?aGdtbGljZjB4RmE2b1NFaXBZdHh4NVg1Ny9ucXR4VEh1bUNMcEQ0UjZEK0hl?=
 =?utf-8?B?cWgwY1g3RHpnbnNmWC8yYzlBMTI1REtoSUhySk1VOHR2c1p5V1pTcmY5U3k0?=
 =?utf-8?B?L3NqTElGY3ZXQkp1TEx6SS90QS9XSlZBcTVmWGNGdnc1R3VXZEFOR1dPUDdj?=
 =?utf-8?B?V3JpZ0NYN3ArdFowQVNXWjJ5Y1l1NlgyQTR6Uy9xQnR0OHJhamZQWURzVHpN?=
 =?utf-8?B?ZkZZS1dDU1hYWlZKTTZUREVrZVRtR2htVWIyNEcybjJuaXNTYkRGZC9OVDI2?=
 =?utf-8?B?TWZna1RRNXZmS2hJOWMvYzB4b2JKb3UrWVJBYnJsUzFiR0VjTnhTQ3RMc0NQ?=
 =?utf-8?B?dUlpUnVMd1JrQklKa1dZQk5DVzhtVHlZbGRCMGVOOUdBT2JHZGZWSnpwaWlL?=
 =?utf-8?B?M0ozWEd0aGFEMHVmR1pFdXA2aFFNTDF5REtOVmF6Qm5lcjNHS3l2aGZPa2pW?=
 =?utf-8?B?L0RvWXhUbHN5Ym52UURtSDNQamdWMCtOTWdVeVYyK2VEN2ZDTUwwbElVUXA2?=
 =?utf-8?B?S1F1aWEzSjhaWE1Ma0ZuRWtheC9vbzJseHRWWE12LzZFUHNpaEZQOHBQc1BZ?=
 =?utf-8?B?Y1lWNlVud1ZQZU4ra3RBQ2s2NjNyM0RhUFpVZ081NHJnUnA0RjZ2UHlkUElj?=
 =?utf-8?B?N3drbkIwT1FGMHNSNXBranhOWmJOOGVkaXp6ampBTXJHYzdCb2c0UElUUE9N?=
 =?utf-8?Q?Y0rg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7142099003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFRFaWhiV2pzektmdWl1Q2lOSFFEQktJYVQ1UkVNdDNWenA0MktNd1BCZHpJ?=
 =?utf-8?B?UWZSemJaUmJLZUZ1SWJtWHpEdVZpSzRHNmhVZkF6OHkvMnc4TzFJN2Y2Rjgw?=
 =?utf-8?B?d3ljNEpQMEJndXpuOEhyY0VSQWVmQ3A1Q29HRllwSEdMMXhHZ0hpRDZJbk5H?=
 =?utf-8?B?NUl4dVgxdlBqaXIwd3N4aFVPS2poeHE3akhFUjI3M1VKY2dhNnFGU1h0U1B5?=
 =?utf-8?B?b3E3NnczRElvZU0yeGR0VzFZVE1vWEZSNFNVYkFNSHhhM3lLcy8rM1lYL1g3?=
 =?utf-8?B?MHZ6OUdDdXhob3RnR2RSVDNYQ3B4NHR0VGk3dGVDUVdHR2pVcklFZno3anZB?=
 =?utf-8?B?citCQXc1Q2VvTWo3K2FkeHJHYXBiRkptTWpRNVlYQjdVakV4c2MrRmthYWUz?=
 =?utf-8?B?QjkrY0tBQWJpRGh2V2F6M0R1dTVZc0Rvak0rd2pHSUZGZFZoemI1TEVmZnhm?=
 =?utf-8?B?OU1ESE9XVVRJclhTNktSamQ3eG1sNmhyQTViTUhzMXJpekxMSVdBdmUyblNh?=
 =?utf-8?B?TmZ0U2hyNlJjTDVUbVlpNHU2Mk95dEFYbGlqUVJvS0ZtUGphYWQ2MWpxWlhx?=
 =?utf-8?B?aUZRQi91Mzc1NGZjdUlGbmI3a3VxRk1OcGNPYzZzc2p4MDdwYVd1VWhaOGdp?=
 =?utf-8?B?THNpTmRSMGROM2x4QjlIc1VhbmRvZ1ROOTB3bW9HTTNYeExPYndpOFRsbUNJ?=
 =?utf-8?B?MHpuRHhQb1JtQktudXlUc3JXUkI3Vzg1Zm96eUwrVGJKMitKbWtFbi9pZk90?=
 =?utf-8?B?bEZ4RHB2ZUFkMkZQaEU2aXpxZnRPSmN4WXcxK1ZwMVh3RUJhdkc3cXRXV0Zv?=
 =?utf-8?B?Umh5MWQxZU81QjBrWWNQMzhsWHlUSUJSMzlvb20xMlRQOFM0U0NCRklPZGdS?=
 =?utf-8?B?cjlhYjNqdjRIejBQN1R6eUtVRW8vUmI3RDlSWVk0ZlI0MmhCdllLYTcvWnUv?=
 =?utf-8?B?MzJmMzhhVExuREJGSnRWeHRoWTJwVTcyOEtNY3l2ZGVVMFNXeDViSW1Qb2VQ?=
 =?utf-8?B?Y0pFdTI4dlo3eWJFYnhKYWhiUng4dWpPUkdvN2NPbG5ZcEZKdjUrMG83Lzgv?=
 =?utf-8?B?RUZsd2ZlVlJVU0FzcmhDSER2b2ZqcjJZNVpZN3pOK0gyb3Q5c3Avempva3o0?=
 =?utf-8?B?dXBOazRNYm45SzE1TmJNWjd1Q1VQQlgzRUZ6eUZJUFNsQUdqa0t6QTFwY0h6?=
 =?utf-8?B?WlNGRlpwRnlFeFZ6Q05ucnppSW1nV2QwQzVMZkYwME5CM2pZdFBybmRyYzB6?=
 =?utf-8?B?NlNKQjVIenBmY3psdUtHYUZrMndjdHBkSDcwM1ZFNkRUeS9rQTdoMDRvN0dQ?=
 =?utf-8?B?d0N1em50bDE2UkhKUURiK2JGMFFjWkxMZ2JEQzJTMDZTTXBQNTlEYWZOMXBz?=
 =?utf-8?B?aHRlc1VvdG4wajZQRUQ3SitaVDZqWERUTmhhbm1NVFhYQkRHbTlWRVlaa2NW?=
 =?utf-8?B?V1JYL3ZwS0RRSW5QdGtEdTZCUWdOZXZyN2dqN0tMVmFnWm14RkZvMjV0MTBO?=
 =?utf-8?B?V2hhZ052eU5VYWllZmxZZnBSYVBhZmFuNUZhQVBscU5pTS9UL2UxSldDaGpx?=
 =?utf-8?B?SVB2bzdFTWc0NFdYS1gyZnZMY1hjY2E5ZDA0bEordnZSNWtYblVpMVpnSm93?=
 =?utf-8?B?bW5nbXVGQXIrY1E2RzVtTjFtK1ZURmVBUlYzdlRTVDJYQ3VnZXdhY3V2K1JX?=
 =?utf-8?B?dEl2Y2M0NTBxQjBTQjdiVFdQZGdnNGdOUDlSTGlEMWxMRStWTWVWSXUrZytq?=
 =?utf-8?B?VEJOZjBDay9SZmtjQytBMWcrZnZlbTg3TzlWR3ZNYUEwSjY5SFF1ZTR6R3Zh?=
 =?utf-8?B?UUFTQ29yakpNN3VYOVZGaTRXMFlDS29SV01GczZVZzZlbXRKT0dDUnkvUU1E?=
 =?utf-8?B?ZlhLeDhpV3huL2ozOUxBUVhtak9ZaGhFcWpydytCOS9hcVdYQ2RUTGZVWXAv?=
 =?utf-8?B?aWR0YkloYk95YU9FOE5LaTJVd2I1a1ZPODZ3QTVYRTBXbDQ2ZkRrS2RHckVn?=
 =?utf-8?B?Z1cvTE1VK0xGMXRHV2RUY1VmWWM0Y2NkNkZENlVwdFlHdno3TEw1Q0h4a2tz?=
 =?utf-8?B?REhpQ2pOR1E5YmN0R1AzYVZ4dWJCYnE4QmZ3MWl1VUhaTW51ZzhrOG0ycmRh?=
 =?utf-8?B?eFdwc1c4VFFja3RBbjdaZWdkaFptU052NGVwN3pPb0xkb3k2ZXVvdGoyK3Nl?=
 =?utf-8?B?ejdFeXMzWUVZTkpvYkNSNGtOamFDNmJ2M0VXaW03TnkxRi9MRC9MQUZSem5u?=
 =?utf-8?B?ZDZsYW1HVlI2YlFtYmlUdWhIcXpxeXppVnFJNDN6Qm1NWmhGV2RZR3ZCVkF2?=
 =?utf-8?B?VzFaMk1uZGhtM1czcWc2ZFFEVXhzRmRVZmJkNDhEeW1CVEoyVkNjQmc4QnYw?=
 =?utf-8?Q?b4eP1BOZ3pioK+Ts=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c7f71e-6cf5-48a7-dc90-08de6a5861f3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:01:36.9327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4s+KfWTGd6YCJf0OG0/gx8jNvSHucyl4Af9u9FQV/sPONJ57Kjy+0JOk0e9Qg6GAjT0Gd+wzYP4gplo2cX56MyIdYbo96IvB/gPFt0gxZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8400
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

On Thu, Feb 12, 2026 at 05:54:22PM +0100, David Marchand wrote:
> On Thu, 12 Feb 2026 at 17:27, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Following recent changes to the test-meson-build.sh script[1] to use more
> > build-types warnings are seen in the hash library GFNI code about values
> > possibly being uninitialized.
> >
> > In function ‘_mm512_mask_permutexvar_epi8’,
> >     inlined from ‘__rte_thash_gfni’ at ../lib/hash/rte_thash_x86_gfni.h:150:6:
> > /usr/lib/gcc/x86_64-linux-gnu/15/include/avx512vbmiintrin.h:97:20: error: ‘tuple_bytes_2’ may be used uninitialized [-Werror=maybe-uninitialized]
> >
> > These all appear to be a false positive, but fix these by explicitly
> > zero-initializing the offending values.
> >
> > [1] 177acaf5cf75 ("devtools: test different build types")
> >
> > Fixes: 4fd8c4cb0de1 ("hash: add new Toeplitz hash implementation")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Too bad Intel CI did not catch it.
> 
> Acked-by: David Marchand <david.marchand@redhat.com>
> 
I don't think any of the CIs use the test-meson-build scripts, do they?
It's more a convenience for maintainers.
