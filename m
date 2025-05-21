Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41477C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 13:07:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C72E2427DE;
	Wed, 21 May 2025 15:07:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id B0DEC400EF
 for <dev@dpdk.org>; Wed, 21 May 2025 15:06:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747832820; x=1779368820;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=xZ6H2qGl79Vf1ogVAUN6GWXWjqkrEh3ZNJxtlFxJxoM=;
 b=GRFBEn6qZ1WkYP71o/jBNUnSOu/Le57EQDSZx/6Lpy8jMqynaU1uFWyP
 hrHkDaXZUbNA693I2IiY+NWDn2gdBnDjMfhCDHUjzB0A6JzEAsv5m9Ljl
 3wyugtNpeAF0rzRjcJA5dZa4ElWm5DSVsS7bwIXbRymMc3NfjqokQU14c
 Bnaon+uSGH3oJ7RCAiJgiz5lZQKhLiqogNTHpM31mz3Caqs2vzf5v2mcc
 jAj75lwh6k/i9RtzkIHHQ1qn4Kx88HdWKvithLZG+4dBIQmElPUqTCFT8
 /PztNGIvCL9/LNs7zqtcZ91z1rnYBQLZgTmu1w94DyBVDyBJMKgvU4fnO A==;
X-CSE-ConnectionGUID: hnTpv8mfRqOJufnt+gppuw==
X-CSE-MsgGUID: iYyOZkRdSV+rsgQn9xNRew==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="53475096"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208,217";a="53475096"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 06:06:58 -0700
X-CSE-ConnectionGUID: rhtShcyqR/2T605OP0481w==
X-CSE-MsgGUID: 7e+10OkSRoew4EjDAMQQIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
 d="scan'208,217";a="139815457"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 06:06:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 06:06:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 06:06:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 06:06:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whIv7uB09+jxE9u5KKxN1KbSMSsXiYEq5yzdwUaw+Qf1vz9bfQ8nHysqTQH1LFJqxS8DlbkJRh8PmTWc9dhGZx0oDvpgqApZ6hUX2KBoGkkys2ERj9NN0pbVTEQXHLRXbh+yDBigZTv/kde2wackI3suM6ByhVCfiH7nHDZXXcSCwXjPCp+g0oiJOzGSPgNTpCVPKMCExb6O7P4c7gyvIV1eqVsydU2+DfR9vbJ17EBbpRt7cHbFZZgxhaDLy2xYU91KRNkW0+1tnwGo+NmMNBb4FCOQxIr+XThigeHZDAMb9otALMRrsaKkf0vELsvjPHOduh7WbfHOwdUL93UdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9/gm7rw1Rpi8uc0PJnV43nkyGfm8NClqwtn9nbNnRw=;
 b=dW8FYgljIdNLUePuP7pDcEUQ4C+WEFD9iKPUel9XtsRJpAmN5SaXg7pk+8NLZKPWOYmPdPO8p+eAPE/RJos2+Mxavtw+lm+GqtMMjztajnK/0+jbkjCz5g5JotWBDIIiSOZkuVe1cyer1qYNfmsbmdMjemDzqs2eq1Ou+Ky6g0mIoC1EMFAQ2q6O2i0hFo93FJ3gDh0y0mXzAe/ZvxVON10T5igZwJAhrM3tSDv8NAYBfeHMQOAZ4sXFqmcvh+h4sJWzPZ4CGKqklQcYFmhSoSxibxiOTN5Eq8+Z42IHzwjHUNOonrBM7jh/sor0GY9hkn5Y0UaAvey/Go25fCHgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14)
 by MW3PR11MB4524.namprd11.prod.outlook.com (2603:10b6:303:2c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 13:06:48 +0000
Received: from MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::6444:ca4c:aa3e:f8d2]) by MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::6444:ca4c:aa3e:f8d2%5]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 13:06:48 +0000
Content-Type: multipart/alternative;
 boundary="------------wFRZ8jEBlFFwk303zgHIc621"
Message-ID: <4152a2bc-0468-4319-88e6-69cc65fcba8d@intel.com>
Date: Wed, 21 May 2025 14:06:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] test/power_intel_uncore: skip test if init fails
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, David Hunt
 <david.hunt@intel.com>, Sivaprasad Tummala <sivaprasad.tummala@amd.com>
References: <20250515165854.1087247-1-bruce.richardson@intel.com>
 <20250515165854.1087247-2-bruce.richardson@intel.com>
Content-Language: en-US
From: Kevin Laatz <kevin.laatz@intel.com>
In-Reply-To: <20250515165854.1087247-2-bruce.richardson@intel.com>
X-ClientProxiedBy: DB8PR09CA0027.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::40) To MW4PR11MB5872.namprd11.prod.outlook.com
 (2603:10b6:303:169::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5872:EE_|MW3PR11MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 21127458-dbec-4a3e-d4a7-08dd9868585f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDI0T1FybTVsR1laN0ZaeFNvcjZEU1libmRhaWJST1F5RlM3Y294aUFMd2FC?=
 =?utf-8?B?VGpkdHhqRk16SGJqdENSUmVCcC9qb1I2Z1BVcUhDUUVMaUw1Rm10SUswRkJm?=
 =?utf-8?B?QXkxVklrRk1EL1BxM3lIVFM4NmNOUFUwZXZIU1VLTEI5WFBYcWVOZ2ZyeTRu?=
 =?utf-8?B?ZG1vdVBJZ1VNQ3RUK0F3ZkM0dkd4ODFDcWNMaWswYTRROWlhd0NneXAwbGFa?=
 =?utf-8?B?RkxpcDN5Y1Jaa3MvTEM4SE9yRm5ZYlJSYkxOTUJKS0J5dmJjQmFFQVlONHJO?=
 =?utf-8?B?dGxGbVFPYkduOGZhM3lSS254RDBzeHRzdEl6WGYvTWpmd3gvUTQ1aWxMck1n?=
 =?utf-8?B?dmRtaU9kM1cyTW4zTVQ4dEJRK3Z4MkJSVnIwY1cwK0lKOVVvTmhyK1NoRTlT?=
 =?utf-8?B?NzZ4M1FTS1VoT1AwZk44NWl2T0FKSzhlYmhPd20vaCtmd3JvS0wvak5oOE5C?=
 =?utf-8?B?eGN0T0Jhb3Q2OWRkSnJaTmtLdUU4TElkYlloeU9SZVgxTUpFcEliT2dyTDM4?=
 =?utf-8?B?M1pKc0RKNWdaY3U4cWZvWXVsbTFheXlGZ2JSOTJEbEVnbjg5dlRhb21BMWEw?=
 =?utf-8?B?VUk5NVVBaTdkZXc4U0YzdHZDTzhzcXdnR0FtaVQ4U3JDSmJsNlRmd0hnZzJu?=
 =?utf-8?B?TVVzYXVXcndiZ09LSGNYRVAzc3hCejFpaHNCRHp6NC93U1hXZnBXMk1ucmEr?=
 =?utf-8?B?ZEdTaUZOcC9YZk9SK2ZYZmN2QVBwb2Zzb25JM0lvUzNHcE5URjhOazBXeTkw?=
 =?utf-8?B?QUxLTHQ4QzlrZVNVTnB3eEtFbmRzWGJyb0QwWkdyY09zM01qQkpOWlduU29i?=
 =?utf-8?B?WHY5cXFPL0lXaDRtYndnclBFWHdNVHFhcDJ0NUdqWDdwUThOd0JWemlOTzVH?=
 =?utf-8?B?dmJQQ2RBVXNrU3Rza3p5WThxblNPRlc2RU56RHVZQW83MFZCWDgrMklJNWUx?=
 =?utf-8?B?UGxJcXVLb21hVys3Q291SUxXZGtaUC93K2ZWYWdjd3NvY0pGSHlCVjdVVHhw?=
 =?utf-8?B?TVE2dml3bmpPRDJZWWFZdmZIQmlnc1cvbW04SDNyVmxncENQc1Z3bWdVSVZt?=
 =?utf-8?B?aFY4QlJuaUlxQnJRS1dxMVBab2pzR1UxckJVdE10RzRsOTNDcllhUDNEVXEw?=
 =?utf-8?B?aGl0T3UySjkydVpkN0twMWdqYnIwYWtPVDdwRmNmRGpiajhZUkh1TWRrcWZG?=
 =?utf-8?B?Y2pnUmljdUdjSXYzcVRHMUsvUUlvc3Q2Si9XTHNZdnNxNy8zMmxEa2IwWWJ3?=
 =?utf-8?B?MGp5MHZhaTBPeWZ5dEVzN003blNJUE5waTNYQ056SUlUMXJhNTR4MnA1aHVt?=
 =?utf-8?B?bVVNOVlRcnI5czlxMTVUZ2JpY2dGcmpjRkkrMGNlV0FsU2toQnUzYWVkWXpC?=
 =?utf-8?B?U1Zlb2FjUkNycWRlWXVuWHgreDdIMXd4S3VPQ0F2dmhlUmJnNC9ZaGhKOUF3?=
 =?utf-8?B?NWdVVnRoeXUxSGFyL2ZYSEtITG5STG1tM3FhUDlSUDRRc0F3SGUwK2lqZUFF?=
 =?utf-8?B?bW5uUEpXeFU2WW9sQjZmekRaOXBTa2w4Zmk4RUdYeWo1eHBNYzU1SUVhMVIw?=
 =?utf-8?B?ajY5eFBBd1NkVnNodVJnM1ZRR1k0WXBVS25MVlIwbUpiTHlFNzVSSUJRalh1?=
 =?utf-8?B?b3NvNEo4a1Y5a3E0bXBsdk51TXNleTFNVnVNQ2EzTFljZ1JJcEZpM3BTVFJF?=
 =?utf-8?B?eG5QTU4rNHo3Zk9CeUJHcktQT2pYRXRUUVBVNFBvRWIxMzMxY3orSzBoaVg2?=
 =?utf-8?B?em42WWtLY0Z4UlZxQzJGT1pWdm1kZVkrTUVGNDZpQUVObC9FRlE0Ykc5OGFl?=
 =?utf-8?B?NHp4ZGl0OU1OYVFINEJqMFZKb0VoWERWM2x2V002VlkrTlB6YkxuZmxaTjB0?=
 =?utf-8?B?clRiZmc3U2FsTlFUSFRpbHZvdXl1SDJ3QnY3dWJOZXNFdzhPMVE5cWp2bXpm?=
 =?utf-8?Q?hutFzEpLKS0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5872.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGFQdFh3cUVtWDk5bndnc0dIS2hNZ0hqMUJYbEpOMFdQWlh6bStYMDBFMzNN?=
 =?utf-8?B?OE5JSCtmYXJrVm1iSG1hRWwvR0EyaEVoY0p6S1E3SHRvd25yTEZJeG5mNFht?=
 =?utf-8?B?ZlpLRmlpbDN4WVAzVDZXVWxDaEgvMHdsQ2pybFI0OUVpaFV6VTZ5ZUhtNGxB?=
 =?utf-8?B?M0R2OXNwSUhGUlJOZWl0L2JIUlBnczlBRGJoc21MelZ0Z3BJU0FzM05RL1d3?=
 =?utf-8?B?NTJrNWF5SDRZQ1lJK1pWZWZseHpTN0xNZDhnbUM1MUNmT2lYN1BFdCtKc1pO?=
 =?utf-8?B?UWtKcklReWZlalRtYXNqcWM0ZUlPaCtMNXBNZURWQU5mb29UV1JqTk9hblRJ?=
 =?utf-8?B?R0pmdDE2S1hOSjgyZjZrWlNEbjNCMGdiL3pEc2p1RHRVc0lIY3RiWnk4WmFU?=
 =?utf-8?B?eUhnK2VaMVJtNXVGOXNrTmZHMkw0ZzM3eGhpNHE4TEhIYzBXVVR3ejRSK0Zr?=
 =?utf-8?B?d0EvNnhNUi9objYwNnZhb2tWVUk1RHBPSjdVVGV3RWVNaFl6dGlWRXkxY0Nl?=
 =?utf-8?B?dWdjbGd0ZlBORXdvYTNXTzc1L2NMZG9HVUZsTk9zeUVJTndYZ1l5cE56TC9K?=
 =?utf-8?B?Umo3S2dlMk55NXIwVGNWbVZ2ckozcFprS3VEZ2FpekxROXFkWEtERzR0ZlBE?=
 =?utf-8?B?L2QrUktpekZ0LzV4MmdrNHNjekZOWEttZmppbTdGS213RHJqTHJ5U1NsdVVJ?=
 =?utf-8?B?cjFUd2dDTWVCdVRlYXJlR1FIbXlJZ05TQlZBalRmNmpHVjFpaVRZNEtXdmhZ?=
 =?utf-8?B?SGhFS3NWeFpNdHpCOWFLcUZQY1hlMHVZSzhZb0h6M3ZDVHgxRmMzdjI2NmpH?=
 =?utf-8?B?U3FxYmh3RmdCRGpMRGdkVUcya0xJUEVIdlBQL2dHK0c2QktNNGwvVjE2Wnps?=
 =?utf-8?B?TWFRbUNlWHZoeWc3TE9BN0lpVEpzTXJlMlFYZENEOGF4V3A5Uy9GTHZaQ2V3?=
 =?utf-8?B?RGRYSG9JZlprRTB5MHpiaGNEd2VySlJHSHJ2M0lPeEc4Rmp1Qy9WYk5FTnZn?=
 =?utf-8?B?NFQwbHYwQngxMEJUdlRzT05VWTFBQ1d1cWZzamkzcUt5U1NrV1BxNkcvSHF6?=
 =?utf-8?B?Z05vcTJDOC9uUGpacVBVM1MvVDhzTDZVMEk5d0ZkRVZFL3hEdVhBeU5ITWNi?=
 =?utf-8?B?SEhIbFZEdHhQZy93U3k3bTg1LzhMKzBkWklkQXFWbzBHMXRlejJQTEFJdWtz?=
 =?utf-8?B?L0dHQW1ZaEhCZkJYcEt5YmdQNUY3S2N4NkVPNk1QU25aOFdVb1N1Uk5pSHhl?=
 =?utf-8?B?c3ArWXVuSjFuOG85SkVzV1VLTytQZTlhd055a2M5WHRoVXU5NHY0VmxXdXp6?=
 =?utf-8?B?U1FhU2FaZjh6S2RiNTFHcklMQkEvbmVTcmw0eUxuN2ZUdHJQb1RZaC9LeHBE?=
 =?utf-8?B?a2QzUzNvdGo0MktkL1RweHFpVGJncXh1L1RVS1U0aDZsdFduUmJSTjMxNTdx?=
 =?utf-8?B?ZTI3VWY5bkZISzViSDI1dFpWNGNOc2dZNUtqNW03QS80QWk0YnArelNwbjFM?=
 =?utf-8?B?WFh2UlpkSkJQZ0RWc2FBS0dqb1BRY0crUG9ncDVMa2FFcmFkd3FKVnRhc29p?=
 =?utf-8?B?NEZPMFV5bGlXR2Eyb1lXWkdhVXpIV01BekJ1T2VBQVFPOVBGaE8wQXBFY0hC?=
 =?utf-8?B?MUdjbXByUVdpVWRacEg1WVZyTjVUdHZBR0RmR21GK2dQeXhHTFovdHptK3RW?=
 =?utf-8?B?cWhHSFdzN0x5M2l0WS9vb0szRWowcmhuYWhLaFIrdFEreDl3elIvMllmVXl1?=
 =?utf-8?B?dXJhZWovMWVPdTk2THZpUm9TZmxwcThKVnBuOFR1SGxOVWhwRVZ4UUJWbjBk?=
 =?utf-8?B?ejR6aFM4Sk0xQ2ZqL0o2c1JqVlhqb1VpTGoxQ2NlUEF4bHNVbk1FK2JMYVd6?=
 =?utf-8?B?b3Z4ZGliN1lqdmw0UGlZSFdqWVVTU1lxcU8welZyalNBUUZmanVyT1RtclZs?=
 =?utf-8?B?NHFROFQzeVg3WHhFZ2wxRWpSYTNETHZpTDM5Y3RjZ1YyS0xzUDBySWdYOFFr?=
 =?utf-8?B?VWx2bmxVUTg0ZGhDOHRYMmJuR1BMZGh1aVdQNUFzelpTVXhtMWNSSVc5TzZy?=
 =?utf-8?B?cEtFU0tBSTZGM1BhOEtaVnRBSVVIN1RIczB5bVBTWjB2bTVoM1Z4VnllZGla?=
 =?utf-8?B?NlY2L0tGOVNRS21vZEFwblVQcXZ5RWJ4MDVncHhqR0twNGNQeVYrM2dWWGlI?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21127458-dbec-4a3e-d4a7-08dd9868585f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 13:06:48.5754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMExQjJm/TYgVBVSDFfZ7DmFblHJp5EWm0VDYGfS2BqnhDoGcIo2z9KZ94mzaGbIlo2lJSxectMxTFY+eJpmgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4524
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

--------------wFRZ8jEBlFFwk303zgHIc621
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 15/05/2025 17:58, Bruce Richardson wrote:
> If the initialization of the uncore power management fails, mark the
> test as skipped rather than a failure. This prevents false failures in
> the case where we are running as a normal user, who doesn't have
> permissions to edit uncore power states.
>
> Signed-off-by: Bruce Richardson<bruce.richardson@intel.com>
> ---
>   app/test/test_power_intel_uncore.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
Acked-by: Kevin Laatz <kevin.laatz@intel.com>

--------------wFRZ8jEBlFFwk303zgHIc621
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 15/05/2025 17:58, Bruce Richardson
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250515165854.1087247-2-bruce.richardson@intel.com">
      <pre wrap="" class="moz-quote-pre">If the initialization of the uncore power management fails, mark the
test as skipped rather than a failure. This prevents false failures in
the case where we are running as a normal user, who doesn't have
permissions to edit uncore power states.

Signed-off-by: Bruce Richardson <a class="moz-txt-link-rfc2396E" href="mailto:bruce.richardson@intel.com">&lt;bruce.richardson@intel.com&gt;</a>
---
 app/test/test_power_intel_uncore.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">Acked-by: Kevin Laatz <a class="moz-txt-link-rfc2396E" href="mailto:kevin.laatz@intel.com">&lt;kevin.laatz@intel.com&gt;</a></span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------wFRZ8jEBlFFwk303zgHIc621--
