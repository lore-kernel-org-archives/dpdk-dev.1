Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E778CD8CB0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 17:34:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6643040E42;
	Thu, 13 Nov 2025 18:34:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 272F340151;
 Thu, 13 Nov 2025 18:34:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763055244; x=1794591244;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=EfaJ5ohP8hcP2G57DVo4/fD/j5Sh+21Qn7yyENWuXj4=;
 b=gw2Mz6+2m27G5XTb0rbmo1MRzMyvWzJBE/BSLqMzsxXtCBxiWY849Okq
 K8GuONnjoWXfhKitgaBnAbeGm6C6LX8itZQeAvaDXKd2+4EJNRLPe+5oF
 PiNGCn25Zypjkv3jf8U+eOHbXNHm/D/yvWkLYDsXjJTbBTZsL/t+eOeAJ
 /KCIj9DhaLRscXMRzZ4nqkWJsMwKccu56tASwIPuMcm9Ml6y+4oaNsNVR
 +7EuhbphbPxVGb0WsIMdLgAXAnlCmwcswF/BXUDb1IVSKvkRo2f+KmZir
 ElfC2qA2clTiyTFdUsQ2dp9/eOt0sK1jZCdc27ZHh6jeOxa2HL4BTmRZ2 Q==;
X-CSE-ConnectionGUID: lK6AacleQvqQjznJbyNTiA==
X-CSE-MsgGUID: BcPiTLYFSUKUnqIWWVlS2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65175780"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; d="scan'208";a="65175780"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 09:34:03 -0800
X-CSE-ConnectionGUID: lHkYIqQjQICvVckrwb6vJA==
X-CSE-MsgGUID: OObaYuZ7QvWXv6m03d675w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; d="scan'208";a="220200921"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 09:34:03 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 09:34:01 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 09:34:01 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 09:34:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRO66hp/BJxFUKVklKO/ydDIUwHUZrL+WimkyaM9c6niDj/AzQTHWwokXQDAgp3ymOs1X/aP0Hr3VKY2edyHtVMVlGpigebqFXJFCy+we5baaiv0nE+iL/ovqasIDtJJbXHRZ5QuxEBw1RR6rA9LzD4oV7st+pbF2WMiSJ3drGgst2DPDM67a3a6d/jnq2Syi76E1WHjveBDUhPeWPBR1AbQm6HIjY3A2gy+zXONmXWZXEbgjNoloJd+R3d1EsrNZlIpBkI9dY4fnOrhxJMvBvo6DhVTCHj5CP7cIoUa7XddncOz4j3PS6Xrv2D0sKtPB3h1cy0zS9vR03iZahleDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWlhhFOTYIm48N/oqgOidWapas0ILTXJeOIKuOcEkE0=;
 b=mfA4AQCymaL061Akojc3ziu0CFTn2+PDaiNzVmHL94qQf7aGWvxLWTaFPnSeIM81FiGwUDf/PJddfDyO07ob+NAmd3kCAr149pbdOLX5ruAMDqQP6R7O9NAVhwxEIt3nSsJ2Oxerw+KgZTjsA0J4Dy9fBatFpjMYUJ/FS4+OMLIOM5uoElQG+sruMebFdz/iC8hArfGptHssfq2N4RgTdOoai8Y1MsMK8hDQGR2S7NcSHBaH23DzU+Ddm9Rpv49OflWvd0EjdJPPY6ehrvODmJmkGcyVte0W93m+0zkcRlwTaKli/qhRc7rSkOfKVYfN5BKTfLCPcWEUHrw2tHDH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPFF0E3B6AEF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 17:33:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 17:33:59 +0000
Date: Thu, 13 Nov 2025 17:33:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Zhichao Zeng <zhichaox.zeng@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>, 
 Anatoly Burakov <anatoly.burakov@intel.com>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>, Jeff Guo
 <jia.guo@intel.com>
Subject: Re: [PATCH] net/ice: fix statistics read error
Message-ID: <aRYWgnRDIN0PL05X@bricha3-mobl1.ger.corp.intel.com>
References: <20251107074338.957352-1-zhichaox.zeng@intel.com>
 <20251113092910.015df6eb@phoenix>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113092910.015df6eb@phoenix>
X-ClientProxiedBy: LO2P265CA0249.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPFF0E3B6AEF:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b997c2-965d-4e04-9440-08de22dad446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnFjaTFjR3h6ZmZsdTZvUXBMcnZreDlUQTNkc1ZYcXpnTHlZcmNwODZmREhZ?=
 =?utf-8?B?M2JCMWMwbFdsYVk0Q0pacmlpREsxMkNOa0FzRklrc2tqUmVETkFWb3BNWnBZ?=
 =?utf-8?B?Z2ttU2dtVGdyNytNejVPUVZtaDlUVFg2MWUwN2VQSndIbW50aytuOE8wdm9F?=
 =?utf-8?B?SzhqUDZ0TlhFeHJnUmVDeTlHVHlFY3BOcG1NbHZnNG5zUXFYMllVS2FVYm42?=
 =?utf-8?B?dDRPaU1Jc0pxMFN2Y2IwRzNuRWhVelh0TEp1eG1ja0NZcGNRQmc0WFJNRjZh?=
 =?utf-8?B?SW80N3AraVNlLzV6UUlHamQvbmUzTVkrYmk0UU9XTS9kUVA3TSt3SmY4RE9L?=
 =?utf-8?B?dGtTL3dGRlU1N2F5ODJqQzRmcU9HNXdNVWhZQi9jVkdOSGJseDBBa0tWYnVo?=
 =?utf-8?B?SVNkZitHMWFQbmVHTzhyYll3aVYrUWd1alpWNHRYRUZxWHhqRVRxVUVsVUlW?=
 =?utf-8?B?OGdqcWc5L29FK2k1ckdHa0hqZm1rZ0IwWk9pcUVpVW1NN2FMSmZRejIyUTFI?=
 =?utf-8?B?cEJaRzN6QkVROTA4UW00VGdCREhWMjNkNDNDZDBmakpZZHpKQnJ3aTlwWnpW?=
 =?utf-8?B?V1l0akdDRlNGb3BTNzI4dEJKSHJZS0t2L1o2ckxmVjJUdVoyNGZrR0dvU3pl?=
 =?utf-8?B?U3Axb2RxVGdGek51dFh0TkwrTzIvN3JDaVhsRENPaFdBUWlKVWxVaDhMaXJ3?=
 =?utf-8?B?czR2Qm1aWVJZODEvS0FDUmZrRW0xcHI5OG13VVFHM0ZJRGJQeWxKd2k3QkJk?=
 =?utf-8?B?ZExWSEViM00reUV0eFc0aFNsbVNhdThRZGJhNndOcEdNNVM5enhTcGtqV2tJ?=
 =?utf-8?B?N0FkTmVpN01FMEhIM3NrQkZBVHgxb3U3c3I1M0IyMy9TSkRUdmw0SGNCMjN6?=
 =?utf-8?B?VXpDc0loU3hlQjlkUFRaWDY2aEZCaDdKWlp1THFjVlZBdzJUMGFtTHVGbW84?=
 =?utf-8?B?VHFFRWUvQ0g3RVVVNkNzc1FmSmhzUlcvclBpVDlNbkZReXUzUHV2b3FKVjVm?=
 =?utf-8?B?M0NZbW1McXlNNGNjNTJnb09WQ1FibXNOSmFBQjNocTA5TFRsM1pvb0RPMEFo?=
 =?utf-8?B?djZ5YkV0MVFMd0N3NkRpQ1JWMW1kQUMwN2tiWTBMT2pkMnRiaTBzN2RwRGV0?=
 =?utf-8?B?aWpXRVVrNXltRG15S0xyMUtEcDNBSzRJeEo3Y2lnejA1MEVvUFRGTmZnUjNM?=
 =?utf-8?B?bjd6aVVEMlhQditweEdxQU9kNWhJZGFHdTFMRGV2VnZjb3MraFlseGlJcXVy?=
 =?utf-8?B?MGkrRHJqNUQ0NWdUTEJDMVo4bi9wVXlvd0ttU204RFBLUW40T1VXd3ZzZ0Fp?=
 =?utf-8?B?ZEd5WFhDL3VBblJWb3dtOU56RUw0SnlXQWF3VjlTWkJLS1o3ZTUrdTZlMml5?=
 =?utf-8?B?YjR4SUNXYzM5bUhCT3pJbDNrckRIeUJZbDlJdzFBcm1HNUdOa1ZJRVVyTDBh?=
 =?utf-8?B?VFZaLzBNWkxpdnhXWkV0L3dRR2ZBT29udzVOQkFDUG5uVnNWUExjWUtrSU5J?=
 =?utf-8?B?dFpERGdnSzBMSE9zY2huYUVUK1BxaEhTenBrQTN4RHBielg4Ykxaam1abHVt?=
 =?utf-8?B?dmVkd1pqZ0pyVGdIem1WVS9RdW1JNjBBT3BNT21MalZ2UVpJRGozZnh6cFg5?=
 =?utf-8?B?UHpudDQxREhJZmY4bjVDT29uTzY4bTBsMjBkamszR0x6d1htZFU5RzR5STFN?=
 =?utf-8?B?QzRiVDdoaTBRMTNSUjlvY2E4TFRoMVpucmFtb0RobW1RSUhXbEhkOThpVjFU?=
 =?utf-8?B?c1VRNTd6YW5IWGdoNUV5TE92UGFpTWlWbjArS25wSWhxbDFpTHpLdmhMV09p?=
 =?utf-8?B?cXJnZWgybVN3SE9WRGdRczFMUFk0SmRITk52endEaUYycXFPTGpXK2dDSUQ4?=
 =?utf-8?B?cytNS1A5eUk2c2s5NUk5dWxXWkVzTkFXUU1RellqWEY5eE0zTzZXR2NKbWky?=
 =?utf-8?Q?JhpImVlY+DEEiT8o4e7QxFepIdFt24ft?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1NmeVFJZE82L2tBTUExRk50ZVJBUEZQTHhsMGdLN3RGNk1raGw3L3NUUmpN?=
 =?utf-8?B?dlhheG1SZW4zaldiVHRBTDhvM2F6Q05NZ2N3SmZuV1NhZFRVVTUvVjFNWW1D?=
 =?utf-8?B?NXpPTDNoY0pIMGlLTWwvelZ1ajBtRGR5QmgrczV6Q3RsdWJSd0RSenBKSXpk?=
 =?utf-8?B?S3RXNUlYdkZoT3NhaHVLSllnNlhxa0ZDNU1HTDJKQ3dlU2RmRThJSnN3Q00v?=
 =?utf-8?B?aVlIajB2a2tNTnF1NzdZcDVQMDU5TXFpZWlxaW1aYk5mTDMyQzZ5TlBnMURE?=
 =?utf-8?B?T0dsT0xiVTU0YVdlb1VXRlg2cUM1ZEpkZHF2NXlIK3o5a2pZWnZSdHU4Z0pN?=
 =?utf-8?B?VVRCTlVsbHFzMWxZRE42aFdZWVhlaFgwOW5GS3gzSDIxQlYxVDFJbzNaN3BP?=
 =?utf-8?B?M2Q5M1pPdGt6SC9FT1IyRXpGZzQwRng4cUszU2d0YnJDUGM4cmwwYWdjWXp4?=
 =?utf-8?B?bGkrMThRVk1RK1hpY3lUL0FYQllHUWxFekxoZk1hcVRnRUxkSFcra3JyYlZl?=
 =?utf-8?B?SktiRmtObnNiL003VGtTRWtSZ0lkUml3eU9DZlVjTWpQL0FWOFlrQTBLMCt6?=
 =?utf-8?B?YmdMUU5QeUkzWU1FTENRSFI4WHZ0UENRQzhXdlZEWCtGL2dVcytPOXRVM281?=
 =?utf-8?B?WDU1d2dSQmdycEZuK001S1RxTHBiZ2xNTHd0bWRBY1h4Y0RSVlV4ZmhBeXNS?=
 =?utf-8?B?UmluZndLTVRod3FDSHZqQnBuZGcwQXBUVElsMWlGOUtrbWdkS3NQWWJlU2R1?=
 =?utf-8?B?WkdnSjBpcUpURkNCR1cyMmt2TnlqaGxjeFM0ZEVKV2RsRlBNN1BiVkJQUWNn?=
 =?utf-8?B?UCtUbVlaUHpqckQzcmlvYTRXREJ0MlA1Wm5tbDNma0lIb2czbmE3V1ROWWFu?=
 =?utf-8?B?VTAxendVdXdiMkFtUE9RcmxNMUxQMXRtc0dra05rRGtuSWMyOXlOdmIwREIr?=
 =?utf-8?B?dUd2UnF6ZThwc09rTHhmOEd5ajAzbmIvS29DUDZtVG1xR2FNeGdhZkx3dVN3?=
 =?utf-8?B?KzI3N3ExK0hBa2U4M1UxQ204M3czekdyV0FUbytEVVdwSUlDa3pxbDJybUZl?=
 =?utf-8?B?V2lwRGQrL2R5encyT09QK2NXL0VRbzdqNjIvU1krRk5USkt6NlF6OU1XK3Zv?=
 =?utf-8?B?NlJZYXJHS2lWdFFQMjdGcE1GYmdQV0J0d2R3RDJNcDJTRjFvQkpZWTZ2ZVo0?=
 =?utf-8?B?a0RST1N1Z2tvOUo3bFQwSEI3Wk91STkvcVdSaXJya1hRd2R4cnpwdXJNZUtQ?=
 =?utf-8?B?TDFicFVrdDYzR0xYOXF4aVdLYUVOYnFLZmNHRG5rSjEyYUJ1aVRlV0UvT1Q3?=
 =?utf-8?B?L1VmSDFNTXNRVngvRktraWdXd3dyTzZXZG5ERnZYMHhwaEc0UURnUHMzSmJx?=
 =?utf-8?B?MDRhM2RoQTFPbWFHb2I4WVN2TGJCTStoRGQ3aHVSZkQvWnJpTUpOY05lSGth?=
 =?utf-8?B?ZUREY3VFbmNTWWYxRkxjNE42MlJzdXVvNzB2Y1d6WDVWK2ZaZnlPNHA0ZHls?=
 =?utf-8?B?V1dFVDM5ZUh2YWNPbE5Dd3h6L1N5amtkNUhMWkszSFZJWjRUZGE1VSs3bUtU?=
 =?utf-8?B?Z0tpZFJiQUlsNFdMbW1MamtEVzVLL2h4RWtGWTBsSk10RmVYdWprZTRCcngv?=
 =?utf-8?B?bWY3Umd5WWJJRDZDaXlqSTJTQzNwQllaQkVNTytYZVZqc3d1aWdmZXMxZEF5?=
 =?utf-8?B?ekxSZHM1MkY1TzR3U0RNQXY1NU1zZ0I1NC8xcEpVdTFPTTNYM3BQcENRTyta?=
 =?utf-8?B?UzJCQURqb3lpNEkvS1lnZmp5L2RSVVJjeUpQcU5RMDhqRFEydFRqeDBxNWdh?=
 =?utf-8?B?MmxiRDFadStFWUw4SThPeDJrVkI3T0NtRkJjdDkwV3NyanBZTkFyZi9EdVgv?=
 =?utf-8?B?UVpUazJFR3JHM09LQ1Z5MFZtNm9yS0VHWXRLRnNjRjZ6VjJyWk11QWFMWXBD?=
 =?utf-8?B?VmYwcDF2L0ZBcllzNU9mZk1ieU9hT0gyYmNLZmVlQmxoS1hnVzlhdnJRUitp?=
 =?utf-8?B?V1hTamNTM2lmVDI3dTlHdWZtcDlVR041a3hRR2pQSEVZT3lIZmplSEN6MjVs?=
 =?utf-8?B?a29oNFBmZjNaa3MzU2lvMzBtNFMyeW40djB6aG1yNFh6WWlRN002U1lmaE9n?=
 =?utf-8?B?bk1jRWFHZ0lOK2JaclRvME5td3JQby9zWjhTVFFzM0pGMFByOU5LR2FCVmV1?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b997c2-965d-4e04-9440-08de22dad446
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 17:33:59.6058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIWBrOMz4xZmNxN8tENkGU2xtPZzEapyhWIvGxULSt/J97YRMkQ+Gln2VE0Gdao8L1Qf0fk8IxVsSMtbTDnxjl+XBkZycGXpZVUqkZcCG4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF0E3B6AEF
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

On Thu, Nov 13, 2025 at 09:29:10AM -0800, Stephen Hemminger wrote:
> On Fri,  7 Nov 2025 15:43:38 +0800
> Zhichao Zeng <zhichaox.zeng@intel.com> wrote:
> 
> > The statistics contain 40 bits. The lower 32 bits are read first, followed
> > by the upper 8 bits.
> > 
> > In some cases, after reading the lower 32 bits, a carry occurs from the
> > lower bits, which causes the final statistics to be incorrect.
> > 
> > This commit fixes this issue.
> > 
> > Fixes: a37bde56314d ("net/ice: support statistics")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Zhichao Zeng <zhichaox.zeng@intel.com>
> 
> This works but may still have issues under really high load.
> I have seen code like this (from ChatGPT)
>

How is checking high for equality better? I considered when reviewing
having the high be double-read, but I though we'd get better accuracy by
reading the more frequency-changing counter (lo) last.

/Bruce
 
> 
> /*
>  * Safely read a 64-bit counter split across two 32-bit registers.
>  * Handles rollover and avoids inconsistency if low overflows
>  * between high and low reads.
>  */
> static inline uint64_t read_hw_counter_64(void)
> {
>     uint32_t hi1, lo, hi2;
> 
>     /*
>      * Read high-low-high and check for wraparound:
>      * if high changed, low overflowed during read — reread.
>      */
>     do {
>         hi1 = read_reg32_high();
>         lo  = read_reg32_low();
>         hi2 = read_reg32_high();
>     } while (hi1 != hi2);
> 
>     return ((uint64_t)hi1 << 32) | lo;
> }
