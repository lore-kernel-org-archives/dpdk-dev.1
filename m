Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC7EC83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 21:08:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA089402A3;
	Tue,  1 Jul 2025 23:08:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id DB93340298
 for <dev@dpdk.org>; Tue,  1 Jul 2025 23:08:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751404119; x=1782940119;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=J0iwBZJ3vN9R+zfnibvTKkVEAHnTaB6MFxKLYeZ7DAI=;
 b=axNQBt8cS0KXG4ICPONvNBKGQhh2wngttqWYGGTR2HCiES/VkirxVzB+
 dhj5zAQoRHLlzM+BQRm9vHJPyqt0NwO0b6iddfB8W6U4Tvw7p1bKHZ4q5
 RhXP+P8I3PmnC9eMKeEGIjDHoXdo14IbEDMCg3XDuUueheVDponslQk8R
 oAi3+AcGqsuli6W9B2Nffq7Gd+MjlgSke7K8HIUHoB3xpVXzeLvQbqLC6
 beJXdzWYawxmoh5+D8tCNil6GD06QwM4mONTRbUFsAuAgrIkzr4aIJjEC
 mb6uWQ0FuBSudZ0KHyUxDUt68QYGzkh3T3929/Yt6OmsB49EoLvBNVCBx Q==;
X-CSE-ConnectionGUID: LGHrsHuOTYOnoAQ9le5G0g==
X-CSE-MsgGUID: V4GTyf9QTZmu0eVOF9t01w==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="63933628"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="63933628"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 14:08:38 -0700
X-CSE-ConnectionGUID: aVrDpVo6SYeHd4ye/X5CFA==
X-CSE-MsgGUID: x+GVfYUrTuiZc0NXiL/2nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="154419042"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 14:08:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 14:08:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 14:08:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 14:08:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKkrdoc55gCZDj14YPRxKWzBoeMVLbFc4SK06MaIFe3c5FV9RMddYnoP4LzmCLyHksjiKzLqWrU4jHj6kFoazYp+5iWo0/wNpXlgfTeeKMoePGLWY5FZmOmMVnFp3VjTX2oBidiY7P2jIvkwz0e4ymfej74hwsUUXdybLp2kZmAQj1/ojYU+kZnZ4PJEClNYVl/n8lZQY0+NzaomTpdDu0erLt3wPIgGJy2cg+OeV6WYZ6+U3x0WWxc+uK8kRQw2yTBS2Gjr0jSqyaF87V+2kwZ+6JtMfK1COc8TvCGZfHsJ0Rq6xMjz5UD7lKa84I8jnpEyANL/W7v7noArF71uDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0iwBZJ3vN9R+zfnibvTKkVEAHnTaB6MFxKLYeZ7DAI=;
 b=aTLr4aHJVpGp9C6A/hyvI/FJC8+aNmulAtqHphgmaPhjhJEDKEGzwe19hCPZUaPCJGjs5XhXMRJrD6TDeREDvpdmByvrFREUp5p1IwoZ54rza//GN/pttA/Gt3sPvMQVGVIqzPT/F5ifxeWtu5yjQpBudtTQG68rLDLHgegkHETVgOHpv6RprVPOyh+VSWeWaujADwlNPNh+Yv8vWNROB/cWyXMIUTYAXsCL1X92EsjrNgU9YyxBJsw1/w3kh0KH2gEuXJiybqkA6QoR+NLThegy+B2Oc72h9Z514PZRwGPMpTLr9baf0+C/i0xeFA8vZo0X5ghDss0kGTMt2ca35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5461.namprd11.prod.outlook.com (2603:10b6:208:30b::17)
 by SJ2PR11MB7599.namprd11.prod.outlook.com (2603:10b6:a03:4c6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.37; Tue, 1 Jul
 2025 21:08:31 +0000
Received: from BL1PR11MB5461.namprd11.prod.outlook.com
 ([fe80::8d83:7a30:43c4:835a]) by BL1PR11MB5461.namprd11.prod.outlook.com
 ([fe80::8d83:7a30:43c4:835a%4]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 21:08:31 +0000
From: "Pathak, Pravin" <pravin.pathak@intel.com>
To: =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <hofors@lysator.liu.se>, Jerin Jacob
 <jerinjacobk@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "jerinj@marvell.com" <jerinj@marvell.com>, 
 "Chen, Mike Ximing" <mike.ximing.chen@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "Marchand, David" <david.marchand@redhat.com>, "nipun.gupta@amd.com"
 <nipun.gupta@amd.com>, "chenbox@nvidia.com" <chenbox@nvidia.com>, "Sarkar,
 Tirthendu" <tirthendu.sarkar@intel.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Shijith Thotton <sthotton@marvell.com>, "Hemant
 Agrawal" <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@oss.nxp.com>, 
 "harry.chang@intel.com" <harry.chang@intel.com>,
 =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>
Subject: RE: [PATCH v1] event/dlb2: add dequeue interrupt mode support
Thread-Topic: [PATCH v1] event/dlb2: add dequeue interrupt mode support
Thread-Index: AQHb5+hQTKfpvceKnEijI2kY71ZrfrQbcGgAgAAgywCAAAeCgIAAS4OQgAAKWgCAAAjpMIAA+XyAgADTG9A=
Date: Tue, 1 Jul 2025 21:08:31 +0000
Message-ID: <BL1PR11MB5461841B6FF2D7F57B69888FF441A@BL1PR11MB5461.namprd11.prod.outlook.com>
References: <20250628045112.655999-1-pravin.pathak@intel.com>
 <CALBAE1NrMu3znG6N+iSQacxHWpoGmCe=azvTbkjEUQZGLY+DmA@mail.gmail.com>
 <bc0299d2-052d-4188-ab18-987360d65cb4@lysator.liu.se>
 <CALBAE1MUrpZqWA=E78QiWy7k=H8QrYQ-=4vme4eHqSm8avBHJg@mail.gmail.com>
 <BL1PR11MB5461AD27C632B62C4A81FC59F446A@BL1PR11MB5461.namprd11.prod.outlook.com>
 <47e87bef-a862-495c-ad96-fb82c840f443@lysator.liu.se>
 <BL1PR11MB54613D5082A1DACD884D8F3AF446A@BL1PR11MB5461.namprd11.prod.outlook.com>
 <efd0a370-d13b-4848-870b-a49f4d6f5f55@lysator.liu.se>
In-Reply-To: <efd0a370-d13b-4848-870b-a49f4d6f5f55@lysator.liu.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5461:EE_|SJ2PR11MB7599:EE_
x-ms-office365-filtering-correlation-id: 60bf7173-0e03-4972-64b2-08ddb8e36edc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?QitSV0VZOGZFUFAvOU50N2tmSndQeHllbE1GQ1pJaE1XOTM1SGRXY3pHOXZ0?=
 =?utf-8?B?OHdTYTRValRNaGppN2krNTlwR2J4VitlbFlrOXhoQjhWUzBpU0g0SXcrakp4?=
 =?utf-8?B?TTkwaHhtMmV3MDFOc0RMNHJNdWRyYkJoNDFCZGk4bkozOHcvdEpBWDlFVTBZ?=
 =?utf-8?B?aVZsMmt2NitXcVh2NEZpYnFwSk9qU0l3RUFib2tHVnBybS9CdmdQNXlMTjQr?=
 =?utf-8?B?WjZTUXVDb1M3V0dCMmRWQUpNMmxvTnk4ZWJqWExjbHU1Q0pTNU01QllDQTk3?=
 =?utf-8?B?RkpmZUxtME5oZVM0ZjVIMVYwbW40d3pSdHh4WnRkbkV4L25IYmdDRkpHSGdo?=
 =?utf-8?B?S0hmTEkrdlFFMnZ1dDRXOXAzMFdET01vN1V2QmFhYnFPU3hXTk9FSTVyL08z?=
 =?utf-8?B?QTZzK0g5ZXVaZDBkWGhEZGMwWk5ycklycnZwbTcxRWJVQ1gySDRXNFplZW1q?=
 =?utf-8?B?bFJ3WXNsaWY0aVlRWDRqakd0K2RobVhNdU5VanZaTU1EamJQYXZOb2gxalpy?=
 =?utf-8?B?dG5ZOVdCMjFOcW0zKzZyUkdqd2kxbTJOWFNxVSthREdOdDZTT20vbUMvMnFX?=
 =?utf-8?B?RmpyUEMzYXFmdTcwZE5ZcGhsZ2RIbGZ6UHd0NWRhUzJ3RVNRTUxCN0lKSVo4?=
 =?utf-8?B?Q2FoZ3NDWXZMay9reUt1bXVjclZPaTBwQ1BuWm42bFZPdWwvNUxiZ0NVNWJv?=
 =?utf-8?B?RXJPSHVvcGl3QkUweGkxMm9UcFhVaEIwRTV4N2ZuMnVqVDRpckVjSU52Z2No?=
 =?utf-8?B?Ulc0Vk1pYWdueWdCYzAxWmI5YVdYczBqRDJBT01mbVNyQWVxTEJLWUpFRmJ0?=
 =?utf-8?B?NHhiMllaUnhmbHhyUTJvTnhMbDJmVEwxMDNnYU81Qmsxdmthc0FNTklBdzdS?=
 =?utf-8?B?TVh5NEYrZVJ5Y3FOdG5GQ2lQTkRPZTJKRG5Cb291T3g5Y0J2VngrZGVGaW5m?=
 =?utf-8?B?Q0pXaTlvTUhwM0ZQMWdjVG55djVtN0xoeDQ3M3lpZHk4S0hrNzNKQjFOOTBT?=
 =?utf-8?B?NXFBRDJ4SXdCeXNuZWRNNUlZSEttSlBiVVRyM25KUk14aW93eG9TbWtqdXRa?=
 =?utf-8?B?MDNvNVRwcEhQTWFLQWNtUmJuRTZRUC9ieUhIdk1tTDNEc1QxdzdxOE03THZ0?=
 =?utf-8?B?OC93RlZLZit3MW5TakRoOUdoQ0JvakV4c3NIeU1kdXJ3dTJHQ0dXTE9OR0dk?=
 =?utf-8?B?K2ZnblhGOGNSTlFsdytsVW41MXM4TE83b0l3RDlTdnQreGQ2bmdCNGN6ZW52?=
 =?utf-8?B?dDhtWHJiQWdKaVRtQWM5U1NwOVFyL2JIYVdScU1aOXpSZHZDZDRFalZNa2J2?=
 =?utf-8?B?cU1ScHZMbTM0eWV1L3kzbmx4amxnRmVYQUVUVlNabTBjM003a0wwTDIvSHNo?=
 =?utf-8?B?Uk55MUFuajlQTjl5VytxS016MmV1MmFQSk8vQkdMZ2JJTWw1US9iUTYyQ2gr?=
 =?utf-8?B?Nng1ZVczeHRSZ1oxTk9TODVjMWR0UzV4Z3gvb1VFQkJPY24vOTVIRGRLc29M?=
 =?utf-8?B?SEV1bmRueUsvUTdTM3l0Qms1ZklBYUxTcjBlczJrelRPVWp4c2YyQlJPZHdN?=
 =?utf-8?B?U1JrZHppbGovRTd5b1hmNTF6MGpTNlUrRU00Nmh1VDUvMUFIcXRra2tKbHU5?=
 =?utf-8?B?YmM2V0FQcWJIUlIzbk15REU0dmU4NTZseGg2RmVDTHpSV2dyMWNCR3k5WEIy?=
 =?utf-8?B?aUdBRUFJdjVhM1cyZ2ZHQ05GRHdYVGpCc3JWWE5GUXdDWHQ5eGQydDFzMm9G?=
 =?utf-8?B?SXl3djRPcnFBdkE4Y3VMNWMzUW9PZUtFY0l5ZVJBN0dDS3lQUjl6Ri9lYTJH?=
 =?utf-8?B?cG8vT21EMWNlNk9OcStiaVA5N2RHSHgxWVZJSzFQbjRrU3VvZTN3M2M0UnJM?=
 =?utf-8?B?NWt2OS9INkRzOUVFNTU5dmo2VFMrQVc5bWRTaHFjQWkvU1VRNTd3MmVVQnFp?=
 =?utf-8?B?UkNCS1NzYWxzNmhKQS9CcitUdHNTcWdYeDFTbGVOanhFVCs5Ni9CSUt4SzNO?=
 =?utf-8?B?dUR5NWVRQkhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5461.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0I2M3FKa1hCWVEvdDdLOUxkVmQ2ZW8wSlM3YWI0dmRvVHh3WlJBeEZKUkd3?=
 =?utf-8?B?bWdBeGxLRlYzYWhTb0pRTU4ydWZwVnYzM3p5TG8zMGJTRDcxSktMS3VtelZS?=
 =?utf-8?B?YlQwMDhqWWNSWFFRdlRTenZ4QkdsQmE4ZVFmMFlXNTFML1pQZFo5SGV3eXNY?=
 =?utf-8?B?S3Z6NlB5eUprbVRxRjNsV1NFbWM3OUJWWkR6U29xbS9lQlFpS0dCMHZ1RjBy?=
 =?utf-8?B?aGpkY1lqZkNNbHJ3ekloN3RleUhGT0VwdmZsYVNtZ05VNDRvR0NJZkJuOURF?=
 =?utf-8?B?ZEFUdlRuaFpadW1YMEdsQmRmY1NPeTIySTdzOXF0YURXbEQwQTFjVG93T0dq?=
 =?utf-8?B?bE81emNJQ1ZJbEl2MXJtd2FQeFp1Vno2RVV0Nmx2dS9pVlVCY09kZGNmc1B0?=
 =?utf-8?B?L1ZtSjY3WTZYaVFQWjdKdStOZ2tFRVVsazFxSndBM3BpR3lJN3dIUXhka2s4?=
 =?utf-8?B?Ty9acXBMVG1UdEhoRm1pMDloZjVrZlA1WmtuckdvRVBKSXBRSW1HUGJ5TDZq?=
 =?utf-8?B?bnN6UkI1cWVZQWVJSCtxazBSeC93b0l0TjZSM1RWb0lmK0VFM3V2TzIzSUtn?=
 =?utf-8?B?NHBHR0tadFRrb2QwbFU2ZWd2cE9mcE9Xdmk5Y0lGVkU2SVphUjZaZlRxVmlo?=
 =?utf-8?B?cnc2ZWwwNWhGQ1Q5dEtic0VqQzc2VW4yMWc0SWt1MmtPR2s5VVhFSStHMGpM?=
 =?utf-8?B?VmhrcmdMaVNQcldHZnowd0FoZHVUeFpBcGorTk1KNENwWjVNQXBweTJXaFlk?=
 =?utf-8?B?WVh5RzlJeEcxQnMzNWxCYmw0eURuUElZcHM5Rk9ILzhaZnpmTitNeVg2L1d0?=
 =?utf-8?B?a2s4Y2VkWUxiaFhPS2dMbUYvTUZobTB4anBScUUyMm8vK09USWdqdW1NQmpt?=
 =?utf-8?B?YkhaYlZRYWx5cGR0d2NsbEV2T25keWtwRU1UNU1sWWNHY010amhQMDBlUzlq?=
 =?utf-8?B?elNLTURzZnZjNDduZUxWTWU2OUNNZ0V3Nk1wcTE2Yzl6MFN4c0VmU1BXdEYv?=
 =?utf-8?B?ZWlWUVJKU2NaaVNuSVV6UWZrR1dWbVlnbEtGZk9UTEV3V1NXMVpSdXcybit4?=
 =?utf-8?B?QzI2bUw3Y1hmeUc1MEhtVk52a2MvWC9ETXdoQWhFdzk5WWlaMzR1L3VoQkZm?=
 =?utf-8?B?MCtscnZab0xHVUZLNDVpZ2xhclM2SWVWVEM0R0NrR0ZVUUF2VFFSU0pONnQw?=
 =?utf-8?B?NEc3NC9Gb01lTXRhYmt4U1FPV085cnRUbC92cTVaU0xUSVU3YzNSQjdOdTcr?=
 =?utf-8?B?OGMySld1MTU2MVN5a2h4R0JDUy85bnlwUnNCMEpFdzloY2FnRloxdXNZWEJz?=
 =?utf-8?B?S1ZoUVhBQStmMTZ1ZUZOcGpJdXM2MFZKajBJTkgyTzN4QUNoZTZUVUpRZElE?=
 =?utf-8?B?MnJpdTc3UlU1NnRyeXdJMUtyaGEvK1B6Uy9vZEovK1JVcy9FNTM1UTVpeGpU?=
 =?utf-8?B?MU5PRy9FVzJmT3c4MlA2aXlISTFVTHRGWldteUx5Y3lzS0hFbEl5UzlDYVhZ?=
 =?utf-8?B?UUJtOHVkNE1nZE5vUDMwT1EvOW1ocy95emJDOERLNXdzVU5BVnVYN2V5djZ6?=
 =?utf-8?B?UG5ESDdjZDVHS2JKT2orMEJMeTFtS0lSZU9XN0U4Zk01YWt1MWFDT1hxTUVx?=
 =?utf-8?B?UkdONDNsWGY4aUcyN2dSd2Fra1pUYmpjWDJXV3pXZ2xFa3hjWDh0dWllOHgw?=
 =?utf-8?B?NnlVSWJzU0NRWm5URnlWRGVmaDhiRzBQc0drb3BWN0dPZUtkQ25RQ2JsaE1t?=
 =?utf-8?B?NVFLWG9qeFFXZlRJRHBhQUdiWVZkVGJ4aW8rSEZoZWVHWWVaK2xUclNJS1NI?=
 =?utf-8?B?ekJBWTJnY1htTm1lT20wMDkxSkdxSlRsRUZnb1hHcVUwNExUKzFWQWJzaGdB?=
 =?utf-8?B?ZEduS0FSOEZzVWNUU3pMbVBZOFFoemNMRVpvMi9hTnVqK3R0ZnYyR0N6MGo5?=
 =?utf-8?B?eGtYMlc0ZjNWSUlyUFZabWJVQ2NCTGQ3RFFONC9TSFlUYkhVNFlxdUg4SkRm?=
 =?utf-8?B?bmNJUFFKVFBUdmxkUi8rWWk5WXh5bFNCZmhnNVE4Z1NEeE9PcS8yV2VlL0l6?=
 =?utf-8?B?cUJyN0JNb1JremdSWnFlRGtDN2k5YTYrRDRnWkMzWkJZcXRZR1Z2Y1ZacDBm?=
 =?utf-8?Q?0f1HNTONDjmUoTxwkKxTn6Rla?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5461.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bf7173-0e03-4972-64b2-08ddb8e36edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 21:08:31.3077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2kQhnWYHLKYOVUKB4Ukda7/quoKi7YLlC1MkbUQ/DkzU8GtgXMkBmhRnj5tJPSintNugeACh0h7kvKPZy9X1uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7599
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF0dGlhcyBSw7ZubmJs
b20gPGhvZm9yc0BseXNhdG9yLmxpdS5zZT4NCj4gU2VudDogVHVlc2RheSwgSnVseSAxLCAyMDI1
IDQ6MTYgQU0NCj4gVG86IFBhdGhhaywgUHJhdmluIDxwcmF2aW4ucGF0aGFrQGludGVsLmNvbT47
IEplcmluIEphY29iDQo+IDxqZXJpbmphY29ia0BnbWFpbC5jb20+DQo+IENjOiBkZXZAZHBkay5v
cmc7IGplcmluakBtYXJ2ZWxsLmNvbTsgQ2hlbiwgTWlrZSBYaW1pbmcNCj4gPG1pa2UueGltaW5n
LmNoZW5AaW50ZWwuY29tPjsgUmljaGFyZHNvbiwgQnJ1Y2UNCj4gPGJydWNlLnJpY2hhcmRzb25A
aW50ZWwuY29tPjsgdGhvbWFzQG1vbmphbG9uLm5ldDsgTWFyY2hhbmQsIERhdmlkDQo+IDxkYXZp
ZC5tYXJjaGFuZEByZWRoYXQuY29tPjsgbmlwdW4uZ3VwdGFAYW1kLmNvbTsNCj4gY2hlbmJveEBu
dmlkaWEuY29tOyBTYXJrYXIsIFRpcnRoZW5kdSA8dGlydGhlbmR1LnNhcmthckBpbnRlbC5jb20+
OyBQYXZhbg0KPiBOaWtoaWxlc2ggPHBiaGFnYXZhdHVsYUBtYXJ2ZWxsLmNvbT47IFNoaWppdGgg
VGhvdHRvbg0KPiA8c3Rob3R0b25AbWFydmVsbC5jb20+OyBIZW1hbnQgQWdyYXdhbCA8aGVtYW50
LmFncmF3YWxAbnhwLmNvbT47DQo+IFNhY2hpbiBTYXhlbmEgPHNhY2hpbi5zYXhlbmFAb3NzLm54
cC5jb20+OyBoYXJyeS5jaGFuZ0BpbnRlbC5jb207DQo+IE1hdHRpYXMgUsO2bm5ibG9tIDxtYXR0
aWFzLnJvbm5ibG9tQGVyaWNzc29uLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gZXZl
bnQvZGxiMjogYWRkIGRlcXVldWUgaW50ZXJydXB0IG1vZGUgc3VwcG9ydA0KPiANCj4gT24gMjAy
NS0wNi0zMCAxOTozNCwgUGF0aGFrLCBQcmF2aW4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBNYXR0aWFzIFLDtm5uYmxvbSA8aG9m
b3JzQGx5c2F0b3IubGl1LnNlPg0KPiA+PiBTZW50OiBNb25kYXksIEp1bmUgMzAsIDIwMjUgMTI6
NTEgUE0NCj4gPj4gVG86IFBhdGhhaywgUHJhdmluIDxwcmF2aW4ucGF0aGFrQGludGVsLmNvbT47
IEplcmluIEphY29iDQo+ID4+IDxqZXJpbmphY29ia0BnbWFpbC5jb20+DQo+ID4+IENjOiBkZXZA
ZHBkay5vcmc7IGplcmluakBtYXJ2ZWxsLmNvbTsgQ2hlbiwgTWlrZSBYaW1pbmcNCj4gPj4gPG1p
a2UueGltaW5nLmNoZW5AaW50ZWwuY29tPjsgUmljaGFyZHNvbiwgQnJ1Y2UNCj4gPj4gPGJydWNl
LnJpY2hhcmRzb25AaW50ZWwuY29tPjsgdGhvbWFzQG1vbmphbG9uLm5ldDsgTWFyY2hhbmQsIERh
dmlkDQo+ID4+IDxkYXZpZC5tYXJjaGFuZEByZWRoYXQuY29tPjsgbmlwdW4uZ3VwdGFAYW1kLmNv
bTsNCj4gY2hlbmJveEBudmlkaWEuY29tOw0KPiA+PiBTYXJrYXIsIFRpcnRoZW5kdSA8dGlydGhl
bmR1LnNhcmthckBpbnRlbC5jb20+OyBQYXZhbiBOaWtoaWxlc2gNCj4gPj4gPHBiaGFnYXZhdHVs
YUBtYXJ2ZWxsLmNvbT47IFNoaWppdGggVGhvdHRvbiA8c3Rob3R0b25AbWFydmVsbC5jb20+Ow0K
PiA+PiBIZW1hbnQgQWdyYXdhbCA8aGVtYW50LmFncmF3YWxAbnhwLmNvbT47IFNhY2hpbiBTYXhl
bmENCj4gPj4gPHNhY2hpbi5zYXhlbmFAb3NzLm54cC5jb20+OyBoYXJyeS5jaGFuZ0BpbnRlbC5j
b207IE1hdHRpYXMgUsO2bm5ibG9tDQo+ID4+IDxtYXR0aWFzLnJvbm5ibG9tQGVyaWNzc29uLmNv
bT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gZXZlbnQvZGxiMjogYWRkIGRlcXVldWUg
aW50ZXJydXB0IG1vZGUNCj4gPj4gc3VwcG9ydA0KPiA+Pg0KPiA+PiBPbiAyMDI1LTA2LTMwIDE4
OjE4LCBQYXRoYWssIFByYXZpbiB3cm90ZToNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogSmVyaW4gSmFjb2IgPGplcmluamFjb2Jr
QGdtYWlsLmNvbT4NCj4gPj4+PiBTZW50OiBNb25kYXksIEp1bmUgMzAsIDIwMjUgNzo0NCBBTQ0K
PiA+Pj4+IFRvOiBNYXR0aWFzIFLDtm5uYmxvbSA8aG9mb3JzQGx5c2F0b3IubGl1LnNlPg0KPiA+
Pj4+IENjOiBQYXRoYWssIFByYXZpbiA8cHJhdmluLnBhdGhha0BpbnRlbC5jb20+OyBkZXZAZHBk
ay5vcmc7DQo+ID4+Pj4gamVyaW5qQG1hcnZlbGwuY29tOyBDaGVuLCBNaWtlIFhpbWluZyA8bWlr
ZS54aW1pbmcuY2hlbkBpbnRlbC5jb20+Ow0KPiA+Pj4+IFJpY2hhcmRzb24sIEJydWNlIDxicnVj
ZS5yaWNoYXJkc29uQGludGVsLmNvbT47DQo+ID4+Pj4gdGhvbWFzQG1vbmphbG9uLm5ldDsgTWFy
Y2hhbmQsIERhdmlkDQo+IDxkYXZpZC5tYXJjaGFuZEByZWRoYXQuY29tPjsNCj4gPj4gbmlwdW4u
Z3VwdGFAYW1kLmNvbTsNCj4gPj4+PiBjaGVuYm94QG52aWRpYS5jb207IFNhcmthciwgVGlydGhl
bmR1IDx0aXJ0aGVuZHUuc2Fya2FyQGludGVsLmNvbT47DQo+ID4+Pj4gUGF2YW4gTmlraGlsZXNo
IDxwYmhhZ2F2YXR1bGFAbWFydmVsbC5jb20+OyBTaGlqaXRoIFRob3R0b24NCj4gPj4+PiA8c3Ro
b3R0b25AbWFydmVsbC5jb20+OyBIZW1hbnQgQWdyYXdhbA0KPiA8aGVtYW50LmFncmF3YWxAbnhw
LmNvbT47DQo+ID4+Pj4gU2FjaGluIFNheGVuYSA8c2FjaGluLnNheGVuYUBvc3MubnhwLmNvbT47
IGhhcnJ5LmNoYW5nQGludGVsLmNvbTsNCj4gPj4+PiBNYXR0aWFzIFLDtm5uYmxvbSA8bWF0dGlh
cy5yb25uYmxvbUBlcmljc3Nvbi5jb20+DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0g
ZXZlbnQvZGxiMjogYWRkIGRlcXVldWUgaW50ZXJydXB0IG1vZGUNCj4gPj4+PiBzdXBwb3J0DQo+
ID4+Pj4NCj4gPj4+PiBPbiBNb24sIEp1biAzMCwgMjAyNSBhdCA0OjQ34oCvUE0gTWF0dGlhcyBS
w7ZubmJsb20NCj4gPj4+PiA8aG9mb3JzQGx5c2F0b3IubGl1LnNlPg0KPiA+Pj4+IHdyb3RlOg0K
PiA+Pj4+Pg0KPiA+Pj4+PiBPbiAyMDI1LTA2LTMwIDExOjE5LCBKZXJpbiBKYWNvYiB3cm90ZToN
Cj4gPj4+Pj4+IE9uIFNhdCwgSnVuIDI4LCAyMDI1IGF0IDExOjE34oCvQU0gUHJhdmluIFBhdGhh
aw0KPiA+Pj4+IDxwcmF2aW4ucGF0aGFrQGludGVsLmNvbT4gd3JvdGU6DQo+ID4+Pj4+Pj4NCj4g
Pj4+Pj4+PiBETEIyIHBvcnQgaW50ZXJydXB0IGlzIGltcGxlbWVudGVkIHVzaW5nIERQREsgaW50
ZXJydXB0IGZyYW1ld29yay4NCj4gPj4+Pj4+PiBUaGlzIGFsbG93cyBldmVudGRldiBkZXF1ZXVl
IEFQSSB0byBzbGVlcCB3aGVuIHRoZSBwb3J0IHF1ZXVlIGlzDQo+ID4+Pj4+Pj4gZW1wdHkgYW5k
IGdldHMgd2FrZXVwIHdoZW4gZXZlbnQgYXJyaXZlcyBhdCB0aGUgcG9ydC4gUG9ydA0KPiA+Pj4+
Pj4+IGRlcXVldWUgbW9kZSBpcyBjb25maWd1cmVkIHVzaW5nIGRldmFyZ3MgYXJndW1lbnQNCj4g
cG9ydF9kZXF1ZXVlX3dhaXQuDQo+ID4+Pj4+Pj4gU3VwcG9ydGVkIG1vZGVzIGFyZSBwb2xsaW5n
IGFuZCBpbnRlcnJ1cHQuIERlZmF1bHQgbW9kZSBpcyBwb2xsaW5nLg0KPiA+Pj4+Pj4+IFRoaXMg
Y29tbWl0IGFsc28gYWRkcyBjb2RlIHRvIGhhbmRsZSBkZXZpY2UgZXJyb3IgaW50ZXJydXB0cyBh
bmQNCj4gPj4+Pj4+PiBwcmludCBhbGFybSBkZXRhaWxzLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4g
U2lnbmVkLW9mZi1ieTogUHJhdmluIFBhdGhhayA8cHJhdmluLnBhdGhha0BpbnRlbC5jb20+DQo+
ID4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogVGlydGhlbmR1IFNhcmthciA8dGlydGhlbmR1LnNhcmth
ckBpbnRlbC5jb20+DQo+ID4+Pj4+Pj4gLS0tDQo+ID4+Pj4+Pj4gICAgIGRvYy9ndWlkZXMvZXZl
bnRkZXZzL2RsYjIucnN0ICAgICAgICAgICAgICB8ICAyMCArDQo+ID4+Pj4+Pj4gICAgIGRyaXZl
cnMvZXZlbnQvZGxiMi9kbGIyLmMgICAgICAgICAgICAgICAgICB8IDIzNiArKysrKy0NCj4gPj4+
Pj4+PiAgICAgZHJpdmVycy9ldmVudC9kbGIyL2RsYjJfaWZhY2UuYyAgICAgICAgICAgIHwgICA3
ICsNCj4gPj4+Pj4+PiAgICAgZHJpdmVycy9ldmVudC9kbGIyL2RsYjJfaWZhY2UuaCAgICAgICAg
ICAgIHwgICA4ICsNCj4gPj4+Pj4+PiAgICAgZHJpdmVycy9ldmVudC9kbGIyL2RsYjJfcHJpdi5o
ICAgICAgICAgICAgIHwgIDE4ICsNCj4gPj4+Pj4+PiAgICAgZHJpdmVycy9ldmVudC9kbGIyL2Rs
YjJfdXNlci5oICAgICAgICAgICAgIHwgMTEyICsrKw0KPiA+Pj4+Pj4+ICAgICBkcml2ZXJzL2V2
ZW50L2RsYjIvcGYvYmFzZS9kbGIyX2h3X3R5cGVzLmggfCAgNzAgKysNCj4gPj4+Pj4+PiAgICAg
ZHJpdmVycy9ldmVudC9kbGIyL3BmL2Jhc2UvZGxiMl9vc2RlcC5oICAgIHwgIDQ2ICsrDQo+ID4+
Pj4+Pj4gICAgIGRyaXZlcnMvZXZlbnQvZGxiMi9wZi9iYXNlL2RsYjJfcmVncy5oICAgICB8IDE0
OSArKystDQo+ID4+Pj4+Pj4gICAgIGRyaXZlcnMvZXZlbnQvZGxiMi9wZi9iYXNlL2RsYjJfcmVz
b3VyY2UuYyB8IDgyNQ0KPiA+Pj4+ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+Pj4+Pj4+ICAg
ICBkcml2ZXJzL2V2ZW50L2RsYjIvcGYvYmFzZS9kbGIyX3Jlc291cmNlLmggfCAgIDYgKw0KPiA+
Pj4+Pj4+ICAgICBkcml2ZXJzL2V2ZW50L2RsYjIvcGYvZGxiMl9wZi5jICAgICAgICAgICAgfCAy
MjMgKysrKysrDQo+ID4+Pj4+Pj4gICAgIDEyIGZpbGVzIGNoYW5nZWQsIDE3MTEgaW5zZXJ0aW9u
cygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IGRpZmYgLS1naXQgYS9k
b2MvZ3VpZGVzL2V2ZW50ZGV2cy9kbGIyLnJzdA0KPiA+Pj4+Pj4+IGIvZG9jL2d1aWRlcy9ldmVu
dGRldnMvZGxiMi5yc3QgaW5kZXggOGVjNzE2OGYyMC4uYTRiYTg1NzM1MQ0KPiA+Pj4+IDEwMDY0
NA0KPiA+Pj4+Pj4+IC0tLSBhL2RvYy9ndWlkZXMvZXZlbnRkZXZzL2RsYjIucnN0DQo+ID4+Pj4+
Pj4gKysrIGIvZG9jL2d1aWRlcy9ldmVudGRldnMvZGxiMi5yc3QNCj4gPj4+Pj4+PiBAQCAtNDc3
LDYgKzQ3NywyNiBAQCBFeGFtcGxlIGNvbW1hbmQgdG8gdXNlIGFzIG1lc29uIG9wdGlvbg0KPiA+
PiBmb3INCj4gPj4+PiBjcmVkaXQgaGFuZGxpbmc6DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiAgICAg
ICAgICAgIG1lc29uIGNvbmZpZ3VyZSAtRGNfYXJncz0nLURETEJfU1dfQ1JFRElUU19DSEVDS1M9
MCAtDQo+ID4+Pj4gRERMQl9IV19DUkVESVRTX0NIRUNLUz0xJw0KPiA+Pj4+Pj4+DQo+ID4+Pj4+
Pj4gK0ludGVycnVwdCBNb2RlIFN1cHBvcnQNCj4gPj4+Pj4+PiArfn5+fn5+fn5+fn5+fn5+fn5+
fn5+fg0KPiA+Pj4+Pj4+ICtETEIgZGVxdWV1ZSBzdXBwb3J0cyBpbnRlcnJ1cHQgbW9kZSBmb3Ig
dGhlIEFQSQ0KPiA+Pj4+IHJ0ZV9ldmVudF9kZXF1ZXVlX2J1cnN0KCkuDQo+ID4+Pj4+Pj4gK1Ro
ZSBkZWZhdWx0IHBvcnQgZGVxdWV1ZSBtb2RlIGlzIHBvbGxpbmcuIERlcXVldWUgd2FpdCBtb2Rl
IGNhbg0KPiA+Pj4+Pj4+ICtiZSBjb25maWd1cmVkIG9uIHBlciBldmVudGRldiBwb3J0IGJhc2lz
IHVzaW5nIGRldmFyZ3MgYXJndW1lbnQNCj4gPj4+Pj4+PiArJ3BvcnRfZGVxdWV1ZV93YWl0Jy4g
SW4gaW50ZXJydXB0IG1vZGUsIGlmIHRoZSBwb3J0IHF1ZXVlIGlzDQo+ID4+Pj4+Pj4gK2VtcHR5
LCB0aGUgYXBwbGljYXRpb24gdGhyZWFkIHdpbGwgYmxvY2sgb24gdGhlIGludGVycnVwdCB1bnRp
bA0KPiA+Pj4+Pj4+ICthIG5ldyBldmVudCBhcnJpdmVzLiBJdCBlbnRlcnMgYmxvY2tpbmcgbW9k
ZSBvbmx5IGFmdGVyIGFueQ0KPiA+Pj4+Pj4+ICtzcGVjaWZpZWQgdGltZW91dC4gRHVyaW5nIHRo
ZSB0aW1lb3V0LCBpdCB3aWxsIHBvbGwgdGhlIHBvcnQNCj4gPj4+Pj4+PiArcXVldWUgZm9yDQo+
ID4+Pj4gZXZlbnRzIGFzIHVzdWFsLiBJbnRlcnJ1cHQgbW9kZSB1c2VzIHRoZSBEUERLIGludGVy
cnVwdCBzdXBwb3J0DQo+ID4+IGZyYW1ld29yay4NCj4gPj4+Pj4+PiArDQo+ID4+Pj4+Pj4gKyAg
ICAuLiBjb2RlLWJsb2NrOjogY29uc29sZQ0KPiA+Pj4+Pj4+ICsNCj4gPj4+Pj4+PiArICAgICAg
IC0tYWxsb3cgZWE6MDAuMCxwb3J0X2RlcXVldWVfd2FpdD1hbGw6aW50ZXJydXB0DQo+ID4+Pj4+
Pg0KPiA+Pj4+Pj4gQWRkaW5nIG90aGVyIGV2ZW50ZGV2IFBNRCBtYWluYXRhaW5lcnMuDQo+ID4+
Pj4+Pg0KPiA+Pj4+Pj4gTG9va3MgbGlrZSBpdCBjYW4gYmUgYSBnZW5lcmljIGZlYXR1cmUuIGku
ZSBzZXQgdGhpcyBvcHRpb24gaXMNCj4gPj4+Pj4+IGRldl9jb25maWd1cmUoKSBJZiB0aGVyZSBp
cyBubyBvYmplY3Rpb24sIFBsZWFzZSBzZW5kIGEgbmV3IHBhdGNoDQo+ID4+Pj4+PiBhcm91bmQN
Cj4gPj4+PiB0aGF0Lg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJJ3ZlIGNvbnNpZGVyZWQgaW1wbGVtZW50
aW5nIHRoaXMgaW4gRFNXLCBhbHRob3VnaCBpbiBhIGRpZmZlcmVudA0KPiA+Pj4+PiBtYW5uZXIg
KHdpdGggZXZlbnRmZHMgYW5kIHBvbGwoKSkuDQo+ID4+Pj4+DQo+ID4+Pj4+IFRoZSBkZXF1ZXVl
IHRpbWVvdXQgd2lsbCBzdGlsbCBiZSBob25vcmVkIGluICJpbnRlcnJ1cHQgbW9kZSIsIGNvcnJl
Y3Q/DQo+ID4+Pj4+IEl0IHdhc24ndCBvYnZpb3VzIGZyb20gdGhlIGRlc2NyaXB0aW9uLg0KPiA+
Pj4+DQo+ID4+Pj4gSG93IGlzIGl0IGluIEludGVsIFBNRD8NCj4gPj4+DQo+ID4+PiBJdCB3b3Vs
ZCBiZSBiZXN0IGlmIHdlwqBjb25maWd1cmUgaXQgcGVyIHBvcnQgdXNpbmcNCj4gPj4+IFJURV9F
VkVOVF9QT1JUX0NGR18qDQo+ID4+IGZsYWdzLiBXaWxsIGl0IGJlLCBPSz8NCj4gPj4+IFRoZSBk
ZXF1ZXVlIHRpbWVvdXQgd2lsbCBiZSBob25vcmVkLCBhbmQgdGhlwqBkZWNpc2lvbiB0byBibG9j
ayBvcg0KPiA+Pj4gcmV0dXJuDQo+ID4+IHdpbGwgYmUgbWFkZSBhZnRlciB0aGUgdGltZW91dC4N
Cj4gPj4NCj4gPj4gVGhhdCBkb2Vzbid0IHNvdW5kIGxpa2UgdGhlIHRpbWVvdXQgaXMgaG9ub3Jl
ZC4NCj4gPj4NCj4gPj4gVGhlIHJlYXNvbiBhbiBhcHBsaWNhdGlvbiB3YW50cyB0aGUgZGVxdWV1
ZSBjYWxsIHRvIGNvbXBsZXRlIHdpdGhpbiBhDQo+ID4+IGNlcnRhaW4gdGltZSwgZXZlbiB0aG91
Z2ggdGhlcmUgd2Fzbid0IGFueSBldmVudHMsIGlzIGxpa2VseSBiZWNhdXNlDQo+ID4+IGl0IHdh
bnQgdG8gZ28gZG8gc29tZXRoaW5nIGVsc2Ugd2l0aCB0aGF0IHRocmVhZCwgYWZ0ZXIgdGhlIHRp
bWVvdXQuDQo+ID4+DQo+ID4+IFRodXMsIHlvdSBjYW4ndCBkZWNpZGUgdG8gYmxvY2sgdGhlIHRo
cmVhZCAqYWZ0ZXIqIHRoZSB0aW1lb3V0LiBJZg0KPiA+PiB5b3UgYmxvY2ssIHlvdSBoYXZlIHRv
IGRvIHNvbWUgdGltZSAqYmVmb3JlKiB0aGUgdGltZW91dCwgYW5kIHdha2UgdXANCj4gPj4gaW4g
dGltZSB0byBtZWV0IHRoZSBkZWFkbGluZS4NCj4gPj4NCj4gPj4gRm9yIGV4YW1wbGUsIGlmIHRo
ZSBldmVudCBkZXZpY2UgaXMgZ2l2ZW4gYSAxIG1zIGRlcXVldWUgdGltZW91dCBieQ0KPiA+PiB0
aGUgYXBwbGljYXRpb24sIGl0IGNvdWxkIGdvIGJ1c3ktcG9sbCBmb3IgMTAgdXMsIHRoZW4gYnVz
eS1wb2xsIHdpdGgNCj4gPj4gYSBzaG9ydCB0cGF1c2UgZm9yIDEwMCB1cywgYW5kIHRoZW4gcHV0
IHRoZSB0aHJlYWQgdG8gc2xlZXAgYmxvY2tpbmcNCj4gPj4gb24gc29tZSBmZCBmb3IgdGhlIHJl
bWFpbmluZyA4OTAgdXMuDQo+ID4+DQo+ID4+IFRoZSBoYXJkd2FyZS1zcGVjaWZpYyBuYXR1cmUg
b2YgdGhlIHRpbWluZyBhbmQgZXhhY3QgbWVjaGFuaXNtIHRvIHVzZQ0KPiA+PiBzcGVha3MgYWdh
aW5zdCBoYXZpbmcgdGhpcyBraW5kIG9mIGNvbmZpZ3VyYXRpb24gaW4gdGhlIEV2ZW50ZGV2IEFQ
SS4NCj4gPg0KPiA+IFRoZSBtb2RlIGlzIG5vdCBmb3Igd2hhdCB0byBkbyBkdXJpbmcgYSB0aW1l
b3V0LCBidXQgYWZ0ZXIgYcKgdGltZW91dC4NCj4gDQo+IE15IGNvbW1lbnRzIHdlcmUgbm90IHNv
IG11Y2ggY29uY2VybmluZyBhbnkgRExCLXNwZWNpZmljIGV4dGVuc2lvbiwgYnV0DQo+IHJhdGhl
ciBob3cgdGhpcyBraW5kIG9mIGZ1bmN0aW9uIHNob3VsZCB3b3JrLCBpZiBpdCB3YXMgYSBwYXJ0
IG9mIHRoZSBzdGFuZGFyZA0KPiBBUEkuDQo+IA0KPiA+IFdlIGNhbiBlbnRlciBzbGVlcCBtb2Rl
IGltbWVkaWF0ZWx5IGJ5IHNldHRpbmcgdGhlwqB0aW1lb3V0IHRvIDAgaWYgd2UgbmVlZA0KPiB0
by4NCj4gPiBUaGlzIG1vZGUgaXMgbm90IGNoYW5naW5nIHRoZcKgY3VycmVudCB0aW1lb3V0IGJl
aGF2aW9yLiAgQWZ0ZXIgdGhlDQo+ID4gdGltZW91dCwgaXQgYWxsb3dzIEhXIGRldmljZXMgc3Vw
cG9ydGluZyBpbnRlcnJ1cHRzIHRvIGJsb2NrIG9uIGFuwqBpbnRlcnJ1cHQuDQo+IA0KPiBUaGUg
Y3VycmVudCBBUEkgc3BlY2lmaWVzIHRoYXQgY29udHJvbCBpcyByZXR1cm5lZCB0byB0aGUgYXBw
bGljYXRpb24sIGFmdGVyIHRoZQ0KPiB0aW1lb3V0IGhhcyBleHBpcmVkLiBJZiB5b3UgY2hhbmdl
IHRoYXQgd2l0aCBhIFBNRCBwYXJhbWV0ZXIsIHRoZSBETEINCj4gYmVoYXZpb3Igd2lsbCBiZSBp
biB2aW9sYXRpb24gb2YgdGhlIEFQSSBjb250cmFjdC4gQXBwbGljYXRpb25zIHVzaW5nDQo+IHJ0
ZV9rZWVwYWxpdmVfYWxpdmUoKSBiZXR3ZWVuIGRlcXVldWVzIGlzIG9uZSBleGFtcGxlIG9mIHRo
b3NlIHRoYXQgd2lsbA0KPiBicmVhay4gSW4gZmFjdCwgYWxsIGFwcGxpY2F0aW9ucyB0aGF0IHVz
ZSBtb3JlIHRoYW4gb25lIFJURSBzZXJ2aWNlIHdpbGwgYnJlYWsuDQo+IA0KPiA+IEl0IHdpbGwg
d2FrZSB1cCBvbmx5IGFmdGVyIGHCoG5ldyBldmVudCBhcnJpdmVzIGF0IHRoZSBwb3J0LiBJZiB0
aGUNCj4gPiBhcHBsaWNhdGlvbiBuZWVkcyBjb250cm9sIGJhY2sgdGhlbiBpdCBjYW4gdXNlIHRo
ZcKgY3VycmVudCBkZWZhdWx0DQo+ID4gbm9uLWJsb2NraW5nIG1vZGUuIEEgYmV0dGVyIG1vZGUg
dG8gc2F2ZSBwb3dlciBkdXJpbmcgdGltZW91dCB3aWxsIGJlDQo+ID4gdG8gdXNlIHVtd2FpdC1i
YXNlZCBzbGVlcC4gIENvbnNpZGVyIHRoaXMgYXMgZXh0ZW5zaW9uIHRvIGN1cnJlbnQgdGltZW91
dA0KPiBiZWhhdmlvciBpZiBkZXZpY2Ugc3VwcG9ydHMgaW50ZXJydXB0cy4NCj4gPg0KPiANCj4g
V2hhdCBhYm91dCBhcHBsaWNhdGlvbnMgdGhhdCBib3RoIHdhbnQgcG93ZXIgZWZmaWNpZW5jeSAq
YW5kKiByZXF1aXJlIGENCj4gdGltZW91dD8NCj4gDQo+IEl0IG1ha2VzIG5vIHNlbnNlIHRvIG1l
IHRoZSBjaGFuZ2UgdGhlIHNlbWFudGljcyBvZiB0aGUgZGVxdWV1ZSB0aW1lb3V0DQo+IHBhcmFt
ZXRlciBmcm9tICJ0aGUgdGltZSB1bnRpbCBJIHdhbnQgY29udHJvbCBiYWNrIiB0byAidGhlIHRp
bWUgSSB3YW50IHRoZQ0KPiBldmVudCBkZXZpY2UgdG8gdXNlIHBvbGxpbmcsIGFmdGVyIHdoaWNo
IGl0IHNob3VsZCBwdXQgdGhlIHRocmVhZCB0byBzbGVlcCIuDQo+IFRob3NlIHR3byBhcmUgcHJl
dHR5IG11Y2ggb3J0aG9nb25hbC4NCj4gDQo+IFRoZSBjdXJyZW50IEFQSSBkb2Vzbid0IHNwZWNp
Znkgd2hhdCBoYXBwZW5zIGR1cmluZyB0aGUgdGltZW91dC4gSWYgeW91IGJ5DQo+ICJub24tYmxv
Y2tpbmciIG1lYW4gImJ1c3ktcG9sbGluZyIsIHRoYXQgaXMgbm90IGFuIEFQSSByZXF1aXJlbWVu
dC4gSSBkb24ndA0KPiBzZWUgd2h5IHRoZSBldmVudCBkZXZpY2UgY291bGRuJ3QgcHV0IHRoZSBs
Y29yZSB0aHJlYWQgdG8gc2xlZXAgZHVyaW5nIGEgbG9uZw0KPiB0aW1lb3V0IChhbmQgSSBhbHNv
IHNlZSB3aHkgeW91IG1heSBub3Qgd2FudCB0aGF0IHRvIGJlIHRoZSBkZWZhdWx0DQo+IGJlaGF2
aW9yKS4NCg0KSSBnb3QgeW91ciBwb2ludC4gQXBwbGljYXRpb24gd2lsbCBwcmVmZXIgdG8gcmV0
dXJuIGFuZCBub3QgYmxvY2sgYWZ0ZXIgdGhlIHRpbWVvdXQgYXMgDQpwZXIgY3VycmVudCBBUEkg
ZGVzY3JpcHRpb24uIEN1cnJlbnQgQVBJIHNpZ25hdHVyZSBpcyANCj0gMCBuby13YWl0LCByZXR1
cm5zIGltbWVkaWF0ZWx5IGlmIHRoZXJlIGlzIG5vIGV2ZW50Lg0KPjAgd2FpdCBmb3IgdGhlIGV2
ZW50IG9yIHRpbWVvdXQNCldpbGwgaXQgYmUgT0sgdG8gZXh0ZW5kIGl0IHRvIHRyZWF0IG1heCB0
aW1lb3V0IDB4ZmZmZmZmZmYgYXMgYmxvY2sgZm9yIGV2ZW50IHdpdGggUE1EIHNwZWNpZmljIA0K
TWVjaGFuaXNtIHRvIHdhaXQgZm9yIHRoZSBldmVudCA/IFBvcnQgc3BlY2lmaWMgY29uZmlndXJh
dGlvbiB3aWxsIG5vdCBiZSByZXF1aXJlZCBpbiB0aGlzIGNhc2UuDQpEZXZpY2VzIHN1cHBvcnRp
bmcgaW50ZXJydXB0cyB0aGVuIGNhbiB1c2UgaW50ZXJydXB0IGJsb2NraW5nIG1vZGUgaW50ZXJu
YWxseS4gDQoNCj4gDQo+ID4+DQo+ID4+PiBJZiBub3QgaW50ZXJydXB0LCBpdCBjYW4gYmUgY2Fs
bGVkIGJsb2NraW5nIHZzIHBvbGxpbmcgbW9kZS4gIElmIHRoZQ0KPiA+Pj4gcG9ydCBjb25maWcg
aXMNCj4gPj4gZmluZSwgSSB3aWxsIGNyZWF0ZSBhwqBuZXcgcGF0Y2ggd2l0aCBpdC4NCj4gPj4+
IEFsc28sIHdlIHNob3VsZCBoYXZlIHRoaXMgYXMgYcKgY2FwYWJpbGl0eSBmb3IgZXZlbnRkZXZz
Lg0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+PiBXaGF0J3MgYmVpbmcgY29uZmlndXJl
ZCBzaG91bGQganVzdCBiZSBhIHRocmVzaG9sZCB0aW1lIGF0IHdoaWNoDQo+ID4+Pj4+IHRoZSBl
dmVudCBkZXZpY2Ugd291bGQgZ28gZnJvbSBidXN5LXBvbGxpbmcgdG8gYmxvY2tpbmcgdGhlIHRo
cmVhZC4NCj4gPj4+Pj4NCj4gPj4+Pj4gTWF5YmUgaXQgc2hvdWxkIGJlIGNhbGxlZCBzb21ldGhp
bmcgd2l0aCAiYmxvY2tpbmciIG9yICJzbGVlcGluZyIsDQo+ID4+Pj4+IGluc3RlYWQgb2YgImlu
dGVycnVwdCIsIHNpbmNlIGludGVycnVwdHMgYXJlIG5ldmVyIGRpcmVjdGx5IGludm9sdmVkLg0K
PiA+Pj4+DQo+ID4+Pj4gQWdyZWUuIG9yIG1ha2UgaXQgYSBwb3dlciBzYXZlIG1vZGUgb3Igc28u
DQo+ID4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gQW55d2F5LCBzZWVtcyBsaWtlIGEgZ29vZCBjYW5k
aWRhdGUgZm9yIGEgZ2VuZXJpYyBmZWF0dXJlIHRvIG1lLg0KPiA+Pj4+Pg0KPiA+DQoNCg==
