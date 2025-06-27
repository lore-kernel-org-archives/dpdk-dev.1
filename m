Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E664FC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 14:53:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FC6E402AE;
	Fri, 27 Jun 2025 16:53:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6C4FB400D5
 for <dev@dpdk.org>; Fri, 27 Jun 2025 16:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751036020; x=1782572020;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UXFWHGnr++WIIpiRUpngTggP5XdmZeTrTopIKmy7Wxo=;
 b=ld5faWSDeb5XW7mPgDf/qS+6T499FOGcVFEMU2Js5x7zIVkzVgvQaDRs
 ORyOXadQILkr6nJ6j98zqAMgJ1lzp96fAGTK9AYUVXXOTxjDsvJ4RSgNA
 1bQKMM7hvuQJ0E/kjVYxODU8D5iwnF/ikfYeoIXtsIb+WrY3zZDlJ9NC9
 1RNCTEUORVBWl3TJ2ioUH3teKhvO5wsnx/7xWcTa6wHtQzUoDuB85MEbq
 MBaVefFJj9KQLdABoqb9TQ/CAlRP5B6LJPZnZvvpU6+glMHJHa8+c7PXM
 vbfnsNCOC1XS5pETqeV19x2ZqsifoeQRbwKSm4sFmlzWyDifdRQRa3LIO A==;
X-CSE-ConnectionGUID: Y4DTEZz/SHWVLlr/sfFkVA==
X-CSE-MsgGUID: b+qeAABtQb65JGIaj41u6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53446125"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="53446125"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 07:53:38 -0700
X-CSE-ConnectionGUID: 0I9aqKcFQIKan/X/OXZC/Q==
X-CSE-MsgGUID: C+D7dyoxQXCzMySXoOMZCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="158309076"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 07:53:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 07:53:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 07:53:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.71)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 07:53:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBfoWJ8b48/V9Yq2P5MeJSN+srhS9UsstdrKtcOvEXr4Co7oyTjsp66K9htiCIHTXvXACHqD86n04T5euQo5l2L1cr7pusGUy8qCMEfla987pxFH8pNit+6+undiW3pFA24TeZDusMQJCGtDJys5oaITyy6wO5SULGbBwXmYdE+iwlPc4nBllVrp5X2HZcboXZRO5lTV0K9PeQzeycxd5HmSWYl4gEwQCEmAeiX2Rp9GV3mGMKSTCCMGyyZ2TbRz6MYj+J0P5pRARRGQ3a/kYPlLVnbl1xh7zHMIRvYqkV2k/Bs4oDweygFGL61r/MhV+DNMRqDL2yDSkYv6qnzc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kadYUnt4vCCzl6WtHWVsAhndsaT0HWkWNChOUH2Jb4=;
 b=wIBcwCn4M18X3Sud1T6RAwtMjay6Zb7MlEJydHg6FLJS2pHJEw9t2bddYzvmsCXPpANW6sO6v+AzumE1CqecqpC7jYrfoGgOuwoO/c5UnP3YIg17wdYAN/n2wKQ16pQQXcaOSQyDbcwfWRgl1HmmPTKDJHJI8uyXz9HzFErswLRIgFGCF3bvcYjLiuOp68mL83zpGb7PtQKUC1lhvE2SexDrL7ii8XRcCyunhnk9x3N2Va1RHgjn49GAOsroJ39wetzvmz8KanNqfkjZIS/ocVpzqpF+d/Y1/vgDb5XTwMLYAOB3I14MJbu/f/Tr4hE6cJ9S5LN4VnPO1Xbib8YVSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.21; Fri, 27 Jun 2025 14:53:35 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 14:53:35 +0000
Message-ID: <00f559cf-4ff8-4c24-983c-65b38ee1d33a@intel.com>
Date: Fri, 27 Jun 2025 16:53:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] memory: handle invalid socket ID's when allocating
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <4e785f17154922f775c56558947b2f967f25b23c.1750426216.git.anatoly.burakov@intel.com>
 <aFVkMQ6jc27mTJG2@bricha3-mobl1.ger.corp.intel.com>
 <3956282.MyG8hOvIyE@thomas> <3865806.FMhQkTaH9n@thomas>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <3865806.FMhQkTaH9n@thomas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::31) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS7PR11MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 11647ec7-7648-495d-51dd-08ddb58a646b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TU1IeEMvVzgvNkt4N0IzUHZCQmYrdXRSUkxuODFWd3IzN2hpSC8zNXJCUlcr?=
 =?utf-8?B?aGVxTENCSlRhR1FDV3VBWDFWcTN1Mmk3SG5OQ29SOGdHKyt5cnovMGttNVNa?=
 =?utf-8?B?cHFCalBxczREaEVGbWV5WVFFNlNKSGc1aENrNGVHWXhpS1VPMXArR2xBeVBO?=
 =?utf-8?B?dlpvNXJHWlJiNm9oOEVteDdVNTlyUVpKZ1JaeFRtTU5mK3ozRTJEWWdWZmtk?=
 =?utf-8?B?aGFqazBiTkpnb0lZZVR2NmdkZDhDWGpPeTB1ZWx5L1QrMGl5amNXMi9xM2Zm?=
 =?utf-8?B?MmZiVzlBNUpSdXpCNldpNTV2dGRlWCtWeDlzNU1ob0x4VmZ3c3o1QWtwVjJ6?=
 =?utf-8?B?blZGUTJiUkUyeTlML1BCbjNKSU83SndET1ErUkV4OEFuUnNBWFdTSzJVbkdp?=
 =?utf-8?B?UThxMWl0MnUyd1l1eFY0STlMdHFzUldSSGdwYlhYKzMySS82SGhWVVhWNFlh?=
 =?utf-8?B?d0YrOEdoSGU0VndyTFBWOXZGRWxXQU5MbHd3dEY4ajkzQ3lFWUR1Y1c1aFZT?=
 =?utf-8?B?QnJva3lKZ0c0SUxnV3VheXpRTzFYVkg5d2UrQ2hmU1ZoMnN0b2dFU25SbGRv?=
 =?utf-8?B?OUMrSmJpNjZ1dTY0bC9ENEh2UWJDZGRubkdyNjlSU3lubHNuZzZNdmpxVE1l?=
 =?utf-8?B?aVI2WXhrZVdJMWwwMXRnaHNYdjZqTEJUWngzaWRpQVFHM1RwTWl2Njhvck5M?=
 =?utf-8?B?L0ovNkR6NmxldVhLQ2V3UUFtK2tmdVdCWDhySVNEYWhpV3FndkRLd0p4S1M2?=
 =?utf-8?B?dmdEbS9UWjJ0WVRiK25iNmxxZHlTbkx0ZzZ4Wm5kNnBPNjQrMW4xY2lybXlC?=
 =?utf-8?B?b1hSeDluanRnY2Zicm9MQ0N4MkVUU1d4UFdwR0w1K0ZORXc5ejBpaEZjNUgv?=
 =?utf-8?B?Z2pKOTJWTEMwR0RiYmRKcGE3ckw1UkpCejVwZlZ2cm9Ub2tiS3p1bUU3MUpI?=
 =?utf-8?B?Mjg1a05PNmlKcmZva09yczVvYjFiaE94T1RjR3M1Q0pNU0VWVVpoWkJQeDBD?=
 =?utf-8?B?ZDA4ZGtnbU9sc2ZwRm1LeTNyOVNMTUVyanQ3RnF0dEVMK1Zlcy9Hbng3cVBq?=
 =?utf-8?B?QW1aRm1QaUI2WEdySENndEZFdFYwRjNtdUxNNElKZWVnS0VQMHpiRWM2YnlN?=
 =?utf-8?B?c1ZtNU1iUG82NUhUMUEvOExxSUsrSmNQVE5ReGdaenlHb3RraXNiZ3RBcUdN?=
 =?utf-8?B?M3Q0UG1uOWJZZzZyZXZpMDlrcHpIVXNQY2MrQnFtaTNJaldMcVRHOU16cFZ1?=
 =?utf-8?B?Sk1vbW4vVkhCNXhNRmx6SzE4eVFzQ1ppMysvS0RDekk2d3hXdDhTa3NNb0Fr?=
 =?utf-8?B?Z0IvTzhMdllkeldVYjUxWUQwZlgwNTRPM1dzTnlmMVQyb0xKYXNEd2h6ZG4z?=
 =?utf-8?B?cWpOclpVai92Tk1aSjg4b2JJUTYyZlQxTnJnYWJJa2pQcmgxTWp0VjQxTnMv?=
 =?utf-8?B?L1MzY2VFLy9JRnJuL3NPeU0yV3BEL0lXdTlEZW5Ta1JWRExhYlFSQVR5Zk9E?=
 =?utf-8?B?MkFnNWE4Zld4L1lDS1RRaFRTV2ZJd3R2UTF3dXJzVExFM1BjZWlQeE5tRTU5?=
 =?utf-8?B?Y0NGMEtkZ29zYjIvSEQ5eFdmWlllUFpnWEYvNVhNVXNlNUZhb0Rpcis4dldl?=
 =?utf-8?B?dUE1TWZFajFUa0ZIbksxdkZGeCt2RStrWTRXOTB4TVZKek4raWNNYnVxcWk2?=
 =?utf-8?B?cmcrL1BabmtocEUySTh5dFhCZDc1SzNWcXhRd1pvOVhxMVAwdGlJZkV1dUZy?=
 =?utf-8?B?aDFJSmprMWphNzBBWkpTRHRaWk9ITXI1TGFFbVBKNXl4SFZodmxZTEZVUFFy?=
 =?utf-8?B?cmVJR1BNOFZiK09MbVBzcmhCQWMya1JvT2ZyRHBKV3pmbDRBdUY3enA2T3lT?=
 =?utf-8?B?SFJHZlVMTTViNWsvZWcwWEQwSStYOHBKcTBxNFhLZ0ZrNnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bSt4M3dYYjJZeDdNV3RsQlRMeER1SUFVNVJPOTAxVjh6cHFaZW1QTndkOVdp?=
 =?utf-8?B?UGFUZ2k0RWJtdlg3aHNBZ2NDci9Gb3N1L2dMUFU4QWhpK3lycFQ0M2hTVzZt?=
 =?utf-8?B?KzJocXV1Z1dVR2Z4a2V0Q3JMZnRMQURuVWdCS0pIcW9VM2h0Y3Q2OVV3dkUv?=
 =?utf-8?B?WW5yRFRqcUFOUTNZd0RQR3lKMzRaRzhuWmQvOXBtektIMTBwUFFMK1ZyOHVV?=
 =?utf-8?B?dHprbVZ6L2N0TXRYZXNWQzYxcHVvbGkwbldwSG5EZzY5WVlhanR3dVJ6cklM?=
 =?utf-8?B?MVpxNFgxdmNLYjY5TFhLU0xEKytoNGZuZ28wVC9leGpacFhHWjM5amp2aXdF?=
 =?utf-8?B?ZjhJTXY0VHEzRzhCSEpTakhtZlpHOWUwTG9tNi9LWktRU3NYZ0Y4dXFRdEpK?=
 =?utf-8?B?UUhVTEF2Q09IcnVVVjFFaWtQNGpCRzIzVTFBeUVnendXT083TnlVZ0x6T3Y5?=
 =?utf-8?B?YUNyQTBoaE85cnVBdjNOeCtxdkttSVR1azBSQXZuUXgyZG02MEU4R3BSdm5B?=
 =?utf-8?B?a3pqRExiMnFUQk1DcHVPQWNKMVRzUXRLenpxL2JmTjlzZGpsalZUWUNjcFcv?=
 =?utf-8?B?dDlRVXpienZYQUNlRExBYUNUV2dWWTlDZGVYSVJ6TDNXbGhqWmNLNlM3dHdY?=
 =?utf-8?B?NHVLT1hJdThxeXhPZ1JrOWMweE82V1NLSStkcDMyT3FuV0w3RWs5QisxNnRi?=
 =?utf-8?B?L0E0NGZuSlRmSWdObE0ydDl6ai82OXZ3ejZ4OUx3enFSZFNib2d6Vnp6alI3?=
 =?utf-8?B?TmdsbVNRRnBKYVZQbG56RWVjYXoweGFuQjN1WEFGNUFQTkJwcGo5TktldWRR?=
 =?utf-8?B?Rm5LbEN5cHIwRDZtdVFmNzBudFZkZVlFQTlkK0RJMGlLcWdJQmdic2NPOFJG?=
 =?utf-8?B?VkRyN2NLVk1LOVd3UW92TElkRnZaVzBXSHROUmxjakZqdjJITzltWjZQYk1N?=
 =?utf-8?B?ajU0YUs2MFBJMUFiZVRKNlA3akRTVjhNUk9OcVRLQjVpVmVXYmRUSk16MFZM?=
 =?utf-8?B?SXNGRldKN0k5bStOYjgrNVBMeEJVdnM1VFBhdEJmTjJKbFVxTW11alNPYkxP?=
 =?utf-8?B?aXcraW4vdi91VHpzeDA2WkdVRGZKRHlDUFN0S3JUL3psY3pxNUQ5Nk5kTU9l?=
 =?utf-8?B?ZHZkM0ltRS9NS080WitXTWpqSjMrWXlEQ2tleUhURWM5T25GcDc5T1JXVjQz?=
 =?utf-8?B?ckRDUmlsc2Ixb2JSZUpabHBSY1BnbU5MWmNTZzZqRElnRE5wZ2pYRU9aWkVp?=
 =?utf-8?B?ZnVMdEdxQnBXTGFGRFlhaFhuR2hyZ3FzbWxUY1ZEdWptKy94M3haTnlSckt0?=
 =?utf-8?B?cHc1ei9wbGdOcjQ1Q2E3TjFEWWcwWXZMZ3RFVk85d1VqQStJc21Pc2xHaFRi?=
 =?utf-8?B?VTBBd1NEVVNML2FyN2ZrWHBGOTAyeEg0Q203SklQcUF6MkQ4cjM4NnZrUnZY?=
 =?utf-8?B?dmNjUHZFVnROMmszNTFyeU5zYjIxUzdIVmFjWGpORjBCdmhrUmNpNmNVOWRI?=
 =?utf-8?B?blZCUEQvcDhPdlFWSHhlejAzU0lrQzQycXNBNGpndE1ubXVSTjJsWkZZQlBi?=
 =?utf-8?B?d2FBMTRiY2F0cG1JRm9MbzRWK1JQNTNOZXZ5eGZZK29Sam1raEdYSUMrM0lK?=
 =?utf-8?B?dGhDSzlZU3hYeUsxbUVDaHI5Q1p3YXhvaTVPRlhXeDFwdXR2b24yb2Y3clZ1?=
 =?utf-8?B?d1dEZXBkakU5RGtZOTdqK3Z0SkxzNkRUSFRVby8zQlB0U2VjZENrcjBuckZU?=
 =?utf-8?B?T2wxWXZVZFN1V3g5SnE0NmdXV01HY3U4Y3JDYmhubmcvM25vVEVPb1Rtcm5R?=
 =?utf-8?B?ckxibGtCcEsrb0w4RlAwMXdPdjdCVXVMb05pR2I3RFR5WTFvS1FERm50WXFY?=
 =?utf-8?B?cmlHV05hQzJOdTJmd0lSZ1ZqcDI0TFFKcXB0WU5pN0xmY0wvUkpkNndBM2Nt?=
 =?utf-8?B?dE1qV05PUlVYSFpiNWF0bGJsV0xYaTA4V2dyL1ZwdXhFKzhnMnQ2N1dpQWNn?=
 =?utf-8?B?M2hSeXpXSDBsb1JLOWEyMXZab1Q1MUc5cGI5b0Jxby9MZy9nbjBFRnVjemdm?=
 =?utf-8?B?NzJlVkhxTUIvRGl2RHd3WDkzYzEwblU2eHVVYnViUW8vREZNc3NRZ2xlM1NK?=
 =?utf-8?B?c3k5Mng2cW9qRXpxVGxQVWNNbHh5amo4Q05lTFVBK2hMbEt0ZVowRWpLbkN5?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11647ec7-7648-495d-51dd-08ddb58a646b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:53:35.2948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKhXP1XFH7M2VyWZEhZIqyvB6FZtR34RMmpyuElRXtbYNgCCKPEL2JChitq786EL8K1h9wwkCgtAt3I2KgnSE7bGJ3NCDFAt9gEd0Bm5p0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6269
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

On 6/27/2025 12:46 PM, Thomas Monjalon wrote:
> 27/06/2025 12:44, Thomas Monjalon:
>> 20/06/2025 15:37, Bruce Richardson:
>>> On Fri, Jun 20, 2025 at 02:30:23PM +0100, Anatoly Burakov wrote:
>>>> This issue was reported by static analysis. It is a false positive,
>>>> because both `rte_socket_count` and `rte_socket_id_by_idx` only report
>>>> information about physical sockets, and these specific calls are made
>>>> during EAL initialization, so no other sockets (i.e. external) could have
>>>> been available, so it is pretty much impossible to get invalid return here.
>>>>
>>>> Still, to avoid future false positives, we can fix it here.
>>>>
>>>> Coverity issue: 470131
>>>>
>>>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>>> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>>
>> Applied, thanks?
> 
> Sorry for this typo, it was not supposed to be a question mark.
> Yes you absolutely deserve some thanks for your continuous maintenance
> of the DPDK memory subsystem. Thank you Anatoly :)
> 

Thanks for the kind words, and yes, I did infer it was a typo :)
-- 
Thanks,
Anatoly
