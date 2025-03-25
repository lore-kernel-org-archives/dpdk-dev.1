Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA5AC35FFC
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 13:12:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A026D40B9C;
	Tue, 25 Mar 2025 14:12:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 033D84027C
 for <dev@dpdk.org>; Tue, 25 Mar 2025 14:12:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742908352; x=1774444352;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=u7tCCL2jI0h7ctPE5PaZi05Afj9BD3fRdjvrvv3F4wk=;
 b=fOj4XoayX45IgWrHHh7TFpAC/PuLS6D6jHQX+ibx40YYyM142eeOsdOu
 dFbY+1kd1VT3NjHOL82fbhJzs49EhRs18UfxSS8SDR7C0Q8XEZCNapCvL
 zhndMk3cq/QH3dxJq3vQOrzcrnuagWsQ/xFYM+Cu8FdL0zV0ZjWy0GPQb
 +GdJmd1KaTv99f//aWri+xVaJGSTGYVbZ4SL7PDS6ZHFTUymowduy/Vzw
 5GKIzC+RRiJhuGFr6c4mdIRd1DKHw/mubzj9Y28KjYNTmvPimGh8d2jjO
 ZbMlda5SdQzwqOyZUi9Sb+RZqe2wiKDHRtnAuxZaTQA+5x7t7+o7utVmU Q==;
X-CSE-ConnectionGUID: RC+xYDnrR22u1N0JmBmb9w==
X-CSE-MsgGUID: WphF4nbRSE6dtM009WB7rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61545405"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="61545405"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 06:12:30 -0700
X-CSE-ConnectionGUID: Ba4FglBfRX24nCZY1pCN5w==
X-CSE-MsgGUID: aulPJmZmRh2EtcCfzXr5sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="155284143"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 06:12:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Mar 2025 06:12:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Mar 2025 06:12:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Mar 2025 06:12:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYCBw9teUwaj7VaYR/dFIDn71sezSXRQlc5xMp4CmiTAFUEemliNQK/KDvuvMMP9Xg4JE+A84PHiqZjsKe8aUPhPlmYArTE1LA0jLYrRZ/YNilrrLB4HNVuMbMk1MDaKTovo35RTqZoRI+idXcuKfG1YZXIeWXvpXw8A41Grx9AzNDMbyk+RuwgmgN0lXiomxTiV+Jrm3bnc2rbbDKfAqhzxutYDiaVSE6zRGf63/p0d/PmPURhuMkefyb19anK1vLQ5NXo/U57r6sZH37407WAJNKqLrhh03L+ohYcEgo/ORVrl9Yz9s5p28EwxedW0cCfTH+NK4915dNMgOLkmRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CxGSFJhT91uNYeDsGDnkXqz8IYP+bn0mWKek++3IY0=;
 b=IP7ezRkuGJrN6WKTgsQqdlMgdrdcZzDQyqBaRpbaqQ7Fk8et+NPBWESsSdjxeZCI5ToSPDMw8pvvSQz/VvakoFe9P6HuWpO2CztKDOz2fbylrE2ydIlqcLPKeA4aKALYZMZnhAT3VO383zCwmNPzX3EhQ6gVldXGBpjWVJhWrjIAWjkz26jjWUdU6CdBK0nr5B4lpPnTPVBVoO94tIbxz6WZViH0KBpT+TzCVYn3gz2V9bIDoOMTfbql4PqpEJFYRidRtA2fVH7VzbwTtw/B3+3OdUdIRKIJAf5wQku0EYT+FoxoF5FtAxAlOj8WG7PowiGBZUNb8FnhcaX21oP7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8687.namprd11.prod.outlook.com (2603:10b6:8:1be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 13:12:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 13:12:21 +0000
Date: Tue, 25 Mar 2025 13:12:16 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 00/11] remove component-specific logic for AVX builds
Message-ID: <Z-KrsMZ8753hjN71@bricha3-mobl1.ger.corp.intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250319172942.2992053-1-bruce.richardson@intel.com>
 <Z9sIGDafadtgB9gr@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8ynP9_b7DV=xR_s_b4u5Vkzh9G8ZGHEe8wQ6htGhqvwsQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8ynP9_b7DV=xR_s_b4u5Vkzh9G8ZGHEe8wQ6htGhqvwsQ@mail.gmail.com>
X-ClientProxiedBy: DB9PR05CA0002.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8687:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dad6c6e-6586-40a1-d922-08dd6b9ead6d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U09FL0xoWVFDSVpQWnpaNHUyUTZ3MGNvbGNjM2hQMVBVYjY2emVrRG9tMVhE?=
 =?utf-8?B?Mm5QMXNQMFBRVVZwdVVDWTllTHVQZzRyTHlFekVIOW1HRlhXeHlubkRoTFBB?=
 =?utf-8?B?eFBMTEgzLy9COVZiaUY0TmppUGRiYUd2UU9qc1hDUWhXWlQ4THo2bitTa2ha?=
 =?utf-8?B?RUFPR3l0YkxmbUtFR1l1b2U0V05mM2tqdTVZcER0YlUrRTZhS0hoaW1pS0VL?=
 =?utf-8?B?ZjZzTDAxWFZKOEhsL2JkNzllVFRuV09qY0xYY0k1L2E3S2lqZ0RJQmF2MXl6?=
 =?utf-8?B?a0wrOUdOVklqclJGVjBmVXZ6Z0syQzExLy9ISVNJNjRRdGhFL2dPOHcvcVBL?=
 =?utf-8?B?eWF0N2FxdTdQdWJWdTdMQjYxQWZZTm8zRS9NcGI2aHJjSXBNRUdyWSs0T3VC?=
 =?utf-8?B?dVBXdWhrb2g4dmp4VjRJQWc2T2J2aDYxa1p3M09FUHc2cTR5czlnMDY5Zm1Q?=
 =?utf-8?B?cDA0bWtmZjNCUlQ4U3NWY2liWDZBb0VyZUhVRTUzSmtCVDZ0bitUQjVqTWc4?=
 =?utf-8?B?emZ0dzNoUENFWWxscWo1R1AxWWxZMXB3bEVpQmJ2ZUNxZ2l5bEdFc1djYVRH?=
 =?utf-8?B?WExzY0FhMWJCdnJCL3ZUYUI3YmhUTGlIei8xbFdleE5Bb0NWeTF0Mm5sYjNv?=
 =?utf-8?B?MU90S0xMS2lBN2Jnak1YZ2RYQlB1VEdOd2hRT3JueDNYeXd2ODFLdy9GT1Rh?=
 =?utf-8?B?dDB6b3pZTWJYbTBhcytUV2ZZM2oyRGNUb2JDYmZEMUxiSkxHYkdrSTAvNzRa?=
 =?utf-8?B?b092R1YrcnFSWkJVVWNMWlRyRmtkck01L2h1ZXR4ZGdrZTl4ZXlKcStNV255?=
 =?utf-8?B?alI5SnZscjJNMXRaZWZINDZncm40c0JMeitmRnVpYm80dmZ6dEJ3elltQ0tl?=
 =?utf-8?B?NFJuVDg0Yk1tU1VXMjVYR1drMjNNQ0ttNWdtTkhGNHZpUEl5bytxbk5MMHNX?=
 =?utf-8?B?b0U3ZDJjaEV4NytjMk5aeGhBUmZhN1Q0KzdDZ2FVeFZka0lTazM1cVc5ejgx?=
 =?utf-8?B?bXlqdGJnQXBxMmY4YmJSZk5GMGlqQkRBQ3I5ODB4WXNEb25ueTFxaWM5UEFF?=
 =?utf-8?B?L0dLdmJEbGVkT05JYjJQeUdPR1pla3psbTMrNFRPVEZlSWRNa3VFTEhSa0wr?=
 =?utf-8?B?cWdSNnhwS0diZVJNNHBPUmNCSGhscDMrYmZzSDAwUTY2dDFTMFNRSlZnTWFY?=
 =?utf-8?B?T2RtelpvNFVSQVZqaUlrVWkwb01zWlJ0SGY3VkdidXhzVGtxeHF4KzZEeEhs?=
 =?utf-8?B?cXI1UFVFUEtLU01EOVRJZVdhaHdCRlh3aW5ZVkNVTndaQUxaaDRKRzNHM1hj?=
 =?utf-8?B?NHpadUU5MFF5MjViVE9tWkVnSW9admNFb0pEUWY4TDR3aUR5VVlBc05IcWF2?=
 =?utf-8?B?WWpzTzZVd3pCU1MzeGFMajJNOEp4bDVNVk5xSWdSRU9BNTllZWl5bWtuNzVV?=
 =?utf-8?B?MkRZNmVFV09WTE85U0RNK2sxMVBUNFRwOVFNaGxYdWRWSVdBRER5SHBzdFBY?=
 =?utf-8?B?NldvT0ovRDJrbjh2cEpyc3JJOVVlWUxQamFqbUtGQWtWVW5YeXkzekNISzh5?=
 =?utf-8?B?OExHaGQ2RFVBcjBiMGF2dUJObmtwaGg3TDJtYlpTcWw5c3duT0xhcThDUGkr?=
 =?utf-8?B?ZU9TOVRhUGlHaG9YZzNwL2NKVnVXNUxGek5sYVZLWWZRRHpPdWFyYkVSeVlU?=
 =?utf-8?B?Szd1ZHRDRVBlYkxaTjdzcVY0aktqdHdrU04zTmdIcDVaS0Q4SldkT2gyTjNh?=
 =?utf-8?B?VEVpbUVEbUg5aitPTWp2VzdIU0Jna2pRTmN0YnJkZEFPd2NGZHVWeXdrbnN2?=
 =?utf-8?B?ZzhSNFlmeERVOFZIeFZJVEYxeVY5ay9sVTd1aXJIMm1QSngrYVFUQTBFNzRx?=
 =?utf-8?B?ZHB6SHFVY2lDd2RsVTJJak1yR2JPQ0NORWxVS1hPVll5RHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEF2R0VvLzhiYmN6NGJtTXlkaVhhWW1TREc3cHJTUkxGaUZ1YWFrS1BYUTEv?=
 =?utf-8?B?REFaTG5uZW1tOUFPNDAwU0phSVpRTlpFSUZ1Ry9BZlBCRFJScFhWaGlIYmJn?=
 =?utf-8?B?bERibnV5bWg5WUx3R1M4czFWOWZrSDhwa2pWZ2czOUsrTzFNTVozNDRCdjU4?=
 =?utf-8?B?OWo1N01DTENYcWZtZGZKMklZQndTN2QvMWRUakVISDZvTENKdC81dDlhWVBm?=
 =?utf-8?B?RjIxcW1ocFI4WDFGalRYNnRWTTE3NVpQN1d5bnlmNGVYVlFYbGtoWnhLL0Q3?=
 =?utf-8?B?dHFCcnpBUmpwY1gvOTVKTDU3S3c4QXk2N1QzLzRRMUg3bTErVGwrQzM2M01Q?=
 =?utf-8?B?alg3TG1CdlRUb1JUT0FHT2NGWWdaYlluWlNpZzlGZ0xrMmhTdDRHUVpJZloz?=
 =?utf-8?B?emozN01CV2NoWGFCWFU3SHBDMXppSDVldnBna3R6SDlYOWRKU3VvNUhINno5?=
 =?utf-8?B?dVY1VFNwU0gyS1B4ZVVxZzRMOWQxSHlkQ0hoMFZ6WC9wUEFEWDc1ZzVMemZS?=
 =?utf-8?B?NG5JYzFCU0J6SktVRXpIWmJaYUNWZ3ZFM3psVGZoRkxzNTFadFZDeC9mK2xR?=
 =?utf-8?B?V1FKVjVHSExHS2tZV0lzaDVUeTlpTXhRZCt1eStpalNIclQvNEVDbTBxREdV?=
 =?utf-8?B?NzBaQk9jVjBpSHBQRTNoSHZoUnlIZ09heUFmaWZWditoUEZId0Q2c1BFR3JN?=
 =?utf-8?B?VHpVaE1MSzZ2UGNXVVBLZXc2WXNsRnhpNzNaRGpBYThhYUJvbjVXQkp2LzIr?=
 =?utf-8?B?S0U0VFplRnBZMXRaQmhraHZUQ2grZUhYSkhSV1Z4anRIWFcwSHVGNkNuck1F?=
 =?utf-8?B?NXNDVDM0WFJIMG5YZ0hBRnlXOGhzQ09vZE9pWWRUYjc2dmc3dnRRY2pXWGdi?=
 =?utf-8?B?M2I4UzRNa1Y2bWJQeFE3RnBwMldNZTloYWpwR0srMzhMTll0ZXlENEE4dVB1?=
 =?utf-8?B?L0RJaVN5U2tFSzZFb2NvdFY1d2VsTlhWZ0twWkt0anBZRW9jdjdZUHlkNVdi?=
 =?utf-8?B?QXRreSt1NTczZU4zYUFIQlRrcnY3b3dVWEZLRW1zais4RHpRakkzaUJ1cUo3?=
 =?utf-8?B?cmhlWkNUUXl4UE5kVUJOdG5UMkFlWUkyV0Y4WUNNTk16WjdMK1N1Mk1vWGc2?=
 =?utf-8?B?enJEZklwNEx1YklDb2Z1bkttOTdCSHc3NUZFT0FIQWJVU1NxdnpoMENpbG5W?=
 =?utf-8?B?Z09mbFRNdXB4NUFwc0Z1NU1qM1hDMWZ6SDhXczF4Z2srcHJSb0xRSUxEVXEy?=
 =?utf-8?B?WkkxTkFuYzZNaUxneXhyeTRYN0cwcVdiMXZzbjc5akZaZXhRb3pzVTIrczdR?=
 =?utf-8?B?aXl1UnJDeVJ2dUgweGMvd2FlMzZVMTJESnVIN29CNEpQdHEvR244MHFvQktv?=
 =?utf-8?B?ZDRQZWZrcEVNeHdwNFNVYjcrVzY5OFFGZDA1ZEFJb01FTm5MYnByZ2d5TWpJ?=
 =?utf-8?B?cDUvWEJWWTVacCt6NXJrK0Rya29hM2I3bU8yWjh6UlhtMVp6WEN6RjFBOFFr?=
 =?utf-8?B?TVRwVzhhWm5OTitocEx0THpCdDlydHpUSmJoS0VDOXpsVmNQNE5XTldES09u?=
 =?utf-8?B?T1BCZ1haTTBNaEVZRXc5TTdvUHRGcU12ZWlSS0FZYTFvaEJLZVpDMlpLMzFG?=
 =?utf-8?B?UndlZGhNYjlYWW1kL1cyTitpeE91SDR3SGh0dnE2UEVhMkV1QnpWNTJjYzd1?=
 =?utf-8?B?eDhqRTAwd3lzSFVQa29HTEdmS3Y3NFRwdC9UWFcxSWlzM2l5Y0FmTzhDT01S?=
 =?utf-8?B?OThLZjZ0OW1CUWhYQ09STDJSbGZhSXlsSGdXbFVJbUNEcnN1Szg4eWRxR21M?=
 =?utf-8?B?dDhmY1NIeERsZDVidU9tTjFzOEZkUm5jdFN0ZVAzcnR1NlJEMnB2Tys5M01H?=
 =?utf-8?B?Mm9BeTB4d0UvakxINVhmQU40VnFQRnRKN1Zpckt3YlF6K2VhVjNOU0RubDBh?=
 =?utf-8?B?cE5abktKMi9LKzRsZEVnUFRETTZzdzhseThXakNHRW5IZ3p3b3duY3pIZDBr?=
 =?utf-8?B?SjNHQTFWYW00aTVvMVkrK2NWallLQTNSODl2ZnFGaXBaTzlHSThCZUFEaWhZ?=
 =?utf-8?B?QjZLNmZxczJ0RGVtTjY4QzV0dExuTnd1bkV1bEgrQmZqUHYrbjRHcEVNczNT?=
 =?utf-8?B?UTVJNHdFckZTSitYd0VjTHlqRWlHUnhySExiT2ZCS05tcXBjcklFR2F2cWNp?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dad6c6e-6586-40a1-d922-08dd6b9ead6d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 13:12:21.7996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSgk/mDu1CDe1rfMARyR/53/usaKZIZlVUakl2UP7AJZ1N3Fa6azm+faN+1jY13G4ojN1Ty2Ez9qkCB5m7/Hovzwn/rbtr7u93OP/RANbWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8687
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

On Tue, Mar 25, 2025 at 08:46:35AM +0100, David Marchand wrote:
> Hello Bruce,
> 
> On Wed, Mar 19, 2025 at 7:09 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 05:29:30PM +0000, Bruce Richardson wrote:
> > > A number of libs and drivers had special optimized AVX2 and AVX512 code
> > > paths for performance reasons, and these tended to have copy-pasted
> > > logic to build those files. Centralise that logic in the main
> > > drivers/ and lib/ meson.build files to avoid duplication.
> > >
> > > v4: rebase on latest main branch
> > >     minor fixes following feedback
> > >     limit use of -march=skylake-avx512 to when we don't already have a
> > >       -march flag supporting AVX512.
> > > v3: add patch for event/dlb2 AVX512 handling.
> > >     add common code for libraries as well as drivers.
> > > v2: add patch 4 to remove use of unnecessary CC_AVX2_SUPPORT flag
> > >
> > A related follow-up to this patchset. Checking with "godbolt.org", it
> > appears that both clang 3.6[1] and gcc 5[2] (the minimum called out compiler
> > versions in our docs[1]) support the set of AVX-512 compiler flags we use.
> > Therefore, it seems we can simplify our code further by removing the
> > "cc_has_avx512" variable.
> 
> What about https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90028 ?
> 

Yep, still needs to be handled, something I only realised after sending the
email.

> You'll need to send a new revision for this series in any case, since
> patch 9 broke the crc stuff in the net library.
> https://inbox.dpdk.org/dev/CAJFAV8w9wYPN+30Hv=batMvP=0M4momKZgmNDFixXbd-9u8t6w@mail.gmail.com/
> 
Yes, I saw that and just started looking at it last evening. Will hopefully
get a new revision out soon.

/Bruce
