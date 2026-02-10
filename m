Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE027EA8112
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:14:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2076440652;
	Tue, 10 Feb 2026 14:14:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1E54C400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:14:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770729258; x=1802265258;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=yiKhhG+Ch+cHzvOCu8mOjWknXTp/2U48WyRZXwzxvNQ=;
 b=TeOTHVqfw3QD2RY8ibkBcs+k/XE1JWsz1grjz7wnPAUuZpnHpxt+U7ut
 E8CgiSAwmO4LytcUX9mhplDELc0yigObPSOts1+Q6VHMKIucW+LlfT+yK
 Y/QIWzikvQIdzSVfzio3HXU7HLDdw6fuqHJP7zQQlw3jn+m+ek+ndpXuj
 WL+GpcNzDstUgbxCv/OQ/kpRTLxinA3nijASVe3Kr+ntmTFRbko45k/yL
 v+K32/LtP+/EFT+4LwpsXmLFi2u/y/KvfJoBiSiX08c8iZs+htp1wLRLg
 GPCox+J6kuxvACoojf4lHGNZhvz3frtCyAmbF6t95WNcxL+1pbElFE82K w==;
X-CSE-ConnectionGUID: xBrTBO7+THatP1SM4HGpGQ==
X-CSE-MsgGUID: bl7QsVYTS++NqSGLTESm4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71749835"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71749835"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:14:18 -0800
X-CSE-ConnectionGUID: 350Vi0WFTJW0f6tpE0ayRw==
X-CSE-MsgGUID: Gx8Yg4oHSZaw0HIKGaDXDw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:14:17 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:14:16 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 05:14:16 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:14:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcAZAjaIY9kKrRSQ+6CW5svRE1aTMXx6/BVlhQOBSz8ipXU/k0H1dUR0wBCfQ0AMdA30hfwAXuub1MqBUzdpjzR6mTOf7xNHUfj31kNy1YAhCadW70kVMW/ky+dwkParFdu52goNfpEkE30NeUTT/R+VGJU2btTwBi2ywiY180lMadbSoCx4fut3NeYtXiKQbhC86V6eEzYukqHz5xCH7yn/Wm+r2x+Tc+RqpXDXoZu0Gg/ptzHP1R7YV1RXLS3WLUpsiNGt3ARozDpV+x9WNFyEmiildXi1UQPgOkhN4n72mZEE/i2WuKEvCLlG5VWhZvh5mrtiQmSLsP6bSEAcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/JOmptRroEJ13RISczjcPHB6Bj4X1xhJpRMEybiQ/Q=;
 b=M+pqldXXJsZzhJx7SEx4yGP751CqI7AA7ezMajxD82dLHoYTjyLmpFSMv315LuaeYarVT1bbu4ViwGRb80ySEhCV2i80Eth5+Fl6mmCyMHCGaHrqeWSFP36c3oxKUrVvJzde4vWw1jGviwplZyorWZtglyLqwkg1SrYgxeRyqqLrWMvA8gcg14x1AGiP6bA1qWgxo2OyzO6FQ6ov6iksG0TGYAOTZfG8pFiVY6CIglyI1sE9F5LK2DQEOXWOKNAy+xc20GOqmuo8UMJlbg7TXEnALwbmSA0iPaHH+k7sRFCegvMXDPV5+eQYAV19gPUG5Br3zqvS4hjnPWFOtZIY9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MN0PR11MB6279.namprd11.prod.outlook.com (2603:10b6:208:3c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 13:14:09 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:14:09 +0000
Message-ID: <7dc889e3-f8b4-415f-a911-d3e14acd4cbb@intel.com>
Date: Tue, 10 Feb 2026 14:14:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/35] net/intel: create a common scalar Tx function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-12-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-12-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0118.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::7) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MN0PR11MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d0a762-b664-49d6-80d6-08de68a646b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3ArN0YzclhmOXhGdkxPWUZzKzVBeUJxOWVsQjhxelhHZml0c01GNmZNK2VN?=
 =?utf-8?B?OWtNL0l0Wms4OFVsVW9MQXI3dzBqZGV4N1hzMm1vbUVIdldSbDN1aFowKy9t?=
 =?utf-8?B?MEt0RXBFR3kyR3BmSXdnMVRwTGlGNjJkRU9DSzNRdnp0cnMwZFA5NTVsSEw1?=
 =?utf-8?B?K2dZZ1k3WDN6V0YzRElsOXBTUUJHeFFwVUphTTJuMTBOblN2MFpXaU1vdkY3?=
 =?utf-8?B?NE9pWFNNNitHa2NGVkNqTGgvenNsL3Q4Z285RzlPdmlWVG9MTWt6TUxCck95?=
 =?utf-8?B?WlZuMC82dmNhb3dLV0xOSDNRTUYzU3JFa3U1bzd6SE0xenRWYzVTNmNEN1VB?=
 =?utf-8?B?czJzWUM1WW12OEVBVWo0eHYwdTRUOUZ2OGUrUmlzR3ZoTnFVeVpyWldQbEZp?=
 =?utf-8?B?Z1F3NDFVOWZmZjNiN3hWNktuM1UyMVVrcHVyd005eGZSekhSTDExeXI0Y0Uz?=
 =?utf-8?B?bHkzS1VmbzBrUHZRZHgyVElOSXVhaFZjVnlyYU10SEtpTG02UnZ3WnRWaXlk?=
 =?utf-8?B?U25HTlk1eERodm81YW1IZ3loSkpSUUxqMk5UeHUrVEhaVzR3NTdSWkNCWGlp?=
 =?utf-8?B?THFncHhWeWZoUWlTV3RrQTg5SCtIbmpjQ2F0UTA0TWRUYlRwN0JvWlQ4TW1t?=
 =?utf-8?B?R0FDUDZVaEExYTNNVk5nVUZpZ2F6dEUyeGlaelkvazBPWStsUE5ic0tPM2JI?=
 =?utf-8?B?MUNTSEQwODBHeDN6TVdGZi9pMjU1emNBY3ZpemR6ZngzbVBENW5zU2ZORFJO?=
 =?utf-8?B?TytqVDdlL3pXdGtFVTJzcS9La1ZLWW5RRXZOTU1hTWwxM0lGUXJIOFIxUDNM?=
 =?utf-8?B?VEFrL3hCcVhKKzlMNTBXMWtRcUMrdW0xbDFiK09qdWJodHora0lRb0M5VnJx?=
 =?utf-8?B?R2gwWFR2MFdyTjNqbW5lbXd0dVpXdFd3aE1xZ0YyMnphSzNZeUMxd2hDTFcv?=
 =?utf-8?B?SEN2eFphTEgrcjUzcDF5Y0sxUUJkQ1AxMm54bnNSYTNZV3hONHNoeWlLbklT?=
 =?utf-8?B?bUtaTWpwOUVGR3hCRWgzSG5IRkMvNmhJK1A4UXU4ZlA2MVFMTjEvYVZ3S2I4?=
 =?utf-8?B?NWRpZ01ZYjVvMG9pQitYTjBoK1h3TVp4UDV6NlBrUWFNNnJhT09KdHBIMGY3?=
 =?utf-8?B?L2QrOXM0MWlwV25QZDBLOGs5YjlVRTlqekprSWNDZ3ZydFJXd3M4Z2RJTTY0?=
 =?utf-8?B?YitGRjZvMHVybk04YXFCS29lT0RZOGp0ck1rTjkrZlBXdVhGSTMyRFVpa1Fh?=
 =?utf-8?B?SVpOU0hGYWdXZE5BMEZ6Q1FNUTRQRTFldUtHdm5hc08veUREdGlobmEzL3NG?=
 =?utf-8?B?RjZTdC9sWmRGVTcrS29VU3lBRFRibGIzNGZmZjFUL2JwQVQwZ0ZlU2lDMGx1?=
 =?utf-8?B?a2wya1hmTEJxT3ZtMWNCZEpkTnpXVWM3eW1QWTZtZ3lhendoT2RoZ28xd1dH?=
 =?utf-8?B?N3pObVA1R2tyZHZFcEk4QUdIdVBXMkVxTjU4MUtHY1Q1NERnRzJKcTRiVnJ5?=
 =?utf-8?B?RzhxYk1yVzZJN29TMWhXc3FYL1ZhNGlGdHAxYTdxMXh0QnMwVDNHMThiSnUy?=
 =?utf-8?B?Rm9kSGF4dTV1Uit6VHVlSUVtY3d0YytCVUdvRzJhNW5lRit3aEtDaW45RFF4?=
 =?utf-8?B?WTZuQXlVc0V6cFk4czcwUzRQOFVSWDQ5dkk1Q0dLUXFKVzBJN2xaQjZjQUZT?=
 =?utf-8?B?ZklHUHBmMDZaeUEvTkNROUV1SG9IZDNvUmRvV1loQTlUNzdZSVQzZkNMclpF?=
 =?utf-8?B?SkhkS2NIMHNxM1k5UllVNlJXTW1EOWhaNjlhQ2ZWR3RhVk1ZV2pBclkwekxK?=
 =?utf-8?B?YXMyNjNEL2pZNm03S3hhU3NFcWN5dzVnV2VNYkxKNE1jd0pmY2pKWEN4a1BV?=
 =?utf-8?B?OVNGYVk4QzZTVVZWOXNDQzRyWERpUExaQVFkRi9meEVKSnFVbElvbG1JSjA3?=
 =?utf-8?B?UXN1MTRFa0ZBYlBCMVh2Zk5pVU1hSCtFZ24waVArQ3dzbjVXaHRTU1RzeVdC?=
 =?utf-8?B?WkNURnFtUE01ZDFkb2pzL3dlOEQ0RUd0RndoMWw3am1PT2RSdjVJKzFMWmJo?=
 =?utf-8?B?SFBvM2RGSk1mT3ZrWTBENXM2Tm9FZXUvbjl2RmpVdHY1NDRqdlAxa2Fsc1kx?=
 =?utf-8?Q?Osdw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEFCM2VPVjRnaFJXbEZWNG9KQ3JlOEdJQklzZ1pUOTF6NFRSdkpjbmlpS3Ri?=
 =?utf-8?B?QXRaVzNGVkZJWVB6NThKM2xkRCtCNGdWL0xyTjIzK3pNZGlib3RoWjZqOTZt?=
 =?utf-8?B?ViszT3JIRWVTK1hGY09CRysyKy8zeGFxRG9FYWdscFEwTUZ3dXdYbWFJRGhw?=
 =?utf-8?B?a2lsK1FGcnBqZkFmZ3BBMnRpZXA0MUI1d09kcWxMSVRnSVFxZ0xKVzJzRmhl?=
 =?utf-8?B?Z3k0YTNjQmhsR3l0cktuNE05dm1RSlgzbHp1OWFsUVYxaHB5NGY3UTNFUzNj?=
 =?utf-8?B?T1YvdWt6K3ZuZTRQcW5QdXUxR2l4a0J4ZGZFd1VCRFNiWTVmYjlqekNpMXIy?=
 =?utf-8?B?Zk9LaUhmb0tBMlpPMmRRaUl5N00zbHEzNml0dG5UWVpEeFRYSFZvNE1ZY0tB?=
 =?utf-8?B?UXo5b0tVNkxYM01Rdk5rWGZXaXM3YUFzNjRhN3NKN1pRaE9aTjRDQU1IWmRL?=
 =?utf-8?B?T1piVWNxKzg1SURMZm9RaEZiMmxvMmtpc2d6TzR6M2dRSjdYSDU1MnRhazBY?=
 =?utf-8?B?bUpxUW9POEd0bmphVGFxSEw1d1Y4Zzl3OVdBMm1MN2N5aDR3VnJGbytEWWo2?=
 =?utf-8?B?N01aZStJRlprZjNmZDh4WENMbTd6bTE2TUorL3prWlJFdU1kdmc0OENhYnR0?=
 =?utf-8?B?b20yVzFoTGVTTFZoYnJBazlZRi9ibTdKN05ONWVlNE54RGU2d2FxMEtjRlV6?=
 =?utf-8?B?NzN5d3NXalFsSXJoQkVaaDd5aU1XOVpPSmpNU21iNTFZTEZHRldSam40TXJC?=
 =?utf-8?B?ZktpSnJrNnBxWnRnbnNZV3NDRUpOWGkyYUU0dlVsTkpNMjdtVUpkbWNRd0Ri?=
 =?utf-8?B?bUFxV0x3aUdnRkdtdlpZdEp6dU5XRDZLWVQzV01sVUdKU0RlUWdUVkh0aENa?=
 =?utf-8?B?dndpOFVCOEZKejNGUjlENGtNOTdhbks0bHhUUUNwK2lzMWo1UzMvcmw4azlq?=
 =?utf-8?B?dXFDTjg0QVQrRnhCaFJSOHIwSkVYcHlvV0JZSktlUDRBWC82eCtQWVF3QURB?=
 =?utf-8?B?VDRybkFXeDBFcDBCZXBVQkozcW5hRXB3UVYyV3VhYkxvS3hBNk5OWCt6SC9R?=
 =?utf-8?B?QldvU1hCbER1cDhZZWVIRHh0WlI3d0hzS1N6VTJsRS9xajV2TWljTFZWSTRL?=
 =?utf-8?B?R1cvMXRwZlZMV2dMN2hIUGdHaCtKQkdVTm96dTViaEx3RE1DU3lKbnF6Tno2?=
 =?utf-8?B?dEE1Q0ZMS1l6WTJFY3M4Rkc0VUlCR3Y5MEVMbW44V3g0Q1pEby9QYncvNVNj?=
 =?utf-8?B?dW1xSTRpR3NqUjM0YXNFVE5SYy85cGFKMTllaDBYV2NCVENrNXBiKzN2Q3hZ?=
 =?utf-8?B?R09BVUNxVFN2WDVYUk9BdmpuTUF5akRHOW9YZGxvYVJ1MTl0Sm45amZ0eEta?=
 =?utf-8?B?c0sxVVgxclo4NldqejdjU0s3eTdYaFgvSHd1MW1yWkozNURUVXRrQnZRTjJE?=
 =?utf-8?B?WllhbnZZOWNSTTFuTjZMekVJM0VCNlEwQUJwdUVoaXZuRHpBUHc2L2tkUHI5?=
 =?utf-8?B?SlFYSjI0YVozdDVkcStNbSsxbVR0NkNxRExFYk5wVTU5Mm5ienhHK3ozYTFI?=
 =?utf-8?B?cmpDTFZUNkYwTno1NUEyd0tDLytIWHBJODZJWGNLU0tWLytPb2hJSlRvdXdw?=
 =?utf-8?B?aU9lenhjbEVpbExGdzVPSGtKWXFRWlFxSWpWbVpNOUZ1V2U1TUZVMkpxQnhP?=
 =?utf-8?B?bTBVK25UQldlSnZFOWhheUk3blZwZ2FVbGQ1L1ZkRzhqdXFYdERCSkhFUjlj?=
 =?utf-8?B?YmRTOSt0K2MvMG9OY2lxK01SdmNOR3NVNkt3QzFPc0pUL0RnM09ld3MvSE5Q?=
 =?utf-8?B?dTdXckdjRE1zNFZJMldtTXlHV3F5anErSjZTMGtibjI1MWhLSkVUMFlqa000?=
 =?utf-8?B?bm8veWV5dGdWVVNBVzVyREF5ZEw5QzdpMHJLdlNNbS9oWnRmMHVWUDN4LzBy?=
 =?utf-8?B?dTM3Y3k0NkxRZGdYTTQwTk05andCY3VzWjIvZDZybVg3Tnczck9RMnFpbjN3?=
 =?utf-8?B?anJTc1V5QW94dVhtd2dxcHR0Mm1lM2t1TEJlWERxWThlK1JTRkFjMzlERHRB?=
 =?utf-8?B?cXZ6VUZDdnphM3NHUkNlK3ZQelNKK2JDQTF3RTRYMzZQK0NQL1l0dTI5UWlO?=
 =?utf-8?B?MnpHaHFVZFdibnR1ZmhYWVRRY1FUcGxmK0N3QmhudFFZUnN6eCsrQTdXWEtY?=
 =?utf-8?B?Zlh0UkNZWndPSUc0eFpRcXVDYXBnR0E2bmhIYmRReU9INVRULzJDNGo2TmVy?=
 =?utf-8?B?RzFkZ2F2dmloTUJLTGw3amFwY1FSRFkwcVFIN21NN1BuMUVIU3ZCck80eW1i?=
 =?utf-8?B?TzM3ZUdNb3Y1RXJiQWlZd2lhdjYwZ0lkSEFRM3orMmozalVXdUxJbkFiWnBX?=
 =?utf-8?Q?ec+BCADIgE670nPc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d0a762-b664-49d6-80d6-08de68a646b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:14:09.4368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMyf5mVX3mB2om+0vrAWV3PLMA6ttf8XT25zJa2c/ELgsygZNYhC3fMbNpYKoWKMVG8Sb7RFNLWe02rXb42To/oF1KgeW+lOayrgb0UqjlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6279
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

On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> Given the similarities between the transmit functions across various
> Intel drivers, make a start on consolidating them by moving the ice Tx
> function into common, for reuse by other drivers.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

> +	if (ts_fns != NULL)
> +		ts_id = ts_fns->get_ts_tail(txq);
> +
> +	/* Check if the descriptor ring needs to be cleaned. */
> +	if (txq->nb_tx_free < txq->tx_free_thresh)
> +		(void)ci_tx_xmit_cleanup(txq);

Why (void) ?

<snip>

> +		if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
> +			nb_used = (uint16_t)(ci_calc_pkt_desc(tx_pkt) + nb_ctx);
> +		else
> +			nb_used = (uint16_t)(tx_pkt->nb_segs + nb_ctx);
> +		tx_last = (uint16_t)(tx_id + nb_used - 1);
> +
> +		/* Circular ring */

nicholas_cage_you_dont_say.jpg

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
