Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ED2C3ABAA
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 14:36:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F0D5402A0;
	Fri,  2 May 2025 16:36:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id E15014029E
 for <dev@dpdk.org>; Fri,  2 May 2025 16:36:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746196561; x=1777732561;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=seLI3TyV+bJoy2l4EvpUgwKEBPpvtLUT6zlL47N5Xbo=;
 b=nt3Y+Rpa3W4MAHh0dRfGDEhGvdcLtSCFGVYgDNrr78T7QYH30irXkWq5
 qaz7v+2myU1LqFIIRU4QjvJT4Es9NB4HiBivITF/XobNXLGMVgZg2DEDS
 NPg2wmZxGsL5y37Xf444IUYnn5P7fmsl1vLUYf+bhpCNVveUG859rwkJX
 oPGEs4LGn9Kxyuodk48mNhhXuuGIPuxnwjKTyb2JKQBHDAi88395fqbnE
 iYfHSGlQRgp/wZnJmAUr1uDNU/UhwdGRDn+Xvye0TPdP4bFzVA2/8vt25
 4W+KGvAp5CiL0QK1OdwnP0rYPlk0T9bYcWYwFzEmm3h59VwoPI/HaHjcC A==;
X-CSE-ConnectionGUID: zEpiyNmOTGy5tFZWerfX9w==
X-CSE-MsgGUID: n/GZY0VNS7CwPeh43Z7Fdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="58867746"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="58867746"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 07:36:00 -0700
X-CSE-ConnectionGUID: uPf56SUNQVeMn63Y1P8LLg==
X-CSE-MsgGUID: pYh8K8jWSe6MnMITlKdnEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="134401160"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 07:36:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 2 May 2025 07:35:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 2 May 2025 07:35:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 2 May 2025 07:35:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZA3MIYEWdM2hnbyDfBgNdD99/BtvBWt7eY6uIUHx4/mY86iZxfaOatwqHh3+o2YK19GJT0jVbrd7NKbI4LUGmGQlgRcDwSNeocUa2t8qFrsuO7CQoBmYKEm9+Mp2F1oJR1ykOaWPuGEME2H+bdrSEPKX/w+JOfKgBuWnlFU1W/pLI5SXz2GeVkjvLyNCUVaA5LIXOUoBi7hbn+cQMgQ0YN1Kqlfg58TMik36bfnZGUB716uclpxWvvFzjGYEFetO4H1in9xVV3EDwez8d4pk8MX+c8uDwD2ipYOE5kctIRL2+HEeJJ8bKEuSPaL4mTQodFlolVUXUo+1wnOyF3Zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WNz2NCxu5dUStMKiYV5WTGwYP/XDMNK+VxIfcCnqIA=;
 b=OYQai5JGJpiUwQ2QoFZRzAapvOGmfRsUOPHbr+0nJstAoan6k9hkwrDUh/4ALA57WDpHSrH/wuStUMG89xeKyqGedx8YEN3QhsqkVn00ZQL/8r7pdt0EAw+Qn0duBDTJ5TsvWRjdbbQwNkf3dzlikAKH2p1/Zl2ENq+w4fV8LXNo29diynn2R6gX3u2LAvYcVsgVt/z76BSmEtJQLqo/C/kleiltX1RgQk3GdxfLekNFP81G0d8KCWPVCaho2C1tzJD7StHtiTLhQvYoxSfaQeNqbscXD4E1l9zsksBAW91cXZiewIw+hTqrVh/NcbRDp7BnLsuBRqi3DWaKd+ufAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 14:35:14 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Fri, 2 May 2025
 14:35:14 +0000
Message-ID: <60e02461-362c-4edd-b917-36a524670c5d@intel.com>
Date: Fri, 2 May 2025 16:35:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] app/testpmd: add sleep command
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <aBS8e9GZkyXiCCJS@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aBS8e9GZkyXiCCJS@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0061.eurprd04.prod.outlook.com
 (2603:10a6:10:232::6) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SN7PR11MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d90d3bf-77d5-44ac-1c69-08dd89868cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zm1HWXdFcWxnRHJyY2dIOE9CVFFLMVgzSTFjZVVhc2haaitTVVZ1b2NhV3lQ?=
 =?utf-8?B?RFBFT0RHQXRBY1FXalNtdkV5cHpHWkhVem9XclY2OWhWTHptcWdBb2VZNnFZ?=
 =?utf-8?B?Yjh0Z01XYUdjMzZsSGlvcGkwSG55aldiWWljd2s3RFNxNmxyQS9RWFl2QzF3?=
 =?utf-8?B?ZE9zMkpqWWZQNmdXNmZxUHo5TEtIRUNtQzNWMXVJOXBwWEszZXpnalYzTUdU?=
 =?utf-8?B?UUZxbS9rWUhnc2h1VU0rV0FVaTBzSGFlM2dwSU9vQmU5dzhlNGxoVnRlNVdy?=
 =?utf-8?B?UmdlNWNPRXFRT0FZUGs5ZFdrMDhrbzh3TVVBVFJGZlhTZXpGWGVsaVNuQ2lY?=
 =?utf-8?B?UjdjdjlQSzQxdEc3dEpaZkR5UGtXQmpFQ0FaR096RUt5U1ptbEpDWXhnRUQv?=
 =?utf-8?B?K0t4dDlYZDFvcklDczBIeFc5L3lvemVnZUhlNTRSdXBwb1FGU3U4MGR5U3JM?=
 =?utf-8?B?elROUFJVVEV3R2pYWjJZTkdkVmVLUDByTFZVR1VmYzF4TUtYV1MvYUl2c0l3?=
 =?utf-8?B?RGJtaGdJb2JGWDB0K2lzQ0NHRHZKODBjUU1FOUsvbndYRGdFSUFuV0w2WWdZ?=
 =?utf-8?B?QjR4cTVxdHpiaEowaDR4d3Q4TWhiM09CS3ZKc2s3ME50VitTTWlUZFZ5SEJo?=
 =?utf-8?B?WHV3U3FVR0dUY2ZXa0l0RUluTkhOLzZTd2xyMlZlckQ1R3pzalBDY1M2L0hY?=
 =?utf-8?B?VEFEbWZtT0hpdmZKVFhVVVlSQloyWG40WEpHQU56cXMrS0g2amFDVXo5TWlB?=
 =?utf-8?B?cWxka1lFSGVoL3NPQzg1L3U3cmV1SFhWMy8zSlpqQzFpUUNKd1pCUlF3U3pN?=
 =?utf-8?B?QnVYbTFVRCtBdGZmTUJ4bkZ6ZDF1c091alF4Q0lpYm4rZ2lnMFg3WlVUVUhH?=
 =?utf-8?B?UDBsVnladzhKMG10NmpqRmJ6eDd0NDJpZUZRUkZWV0lCb00raFZ4Z0NSNkdr?=
 =?utf-8?B?S3grK0ljOHV4VWJFZ3VhK2dEa3FKUWdpcFRTYUlNcTBkdUtydWhhbGcyNTNT?=
 =?utf-8?B?WWxmTFlyT2h5UVBLU2VxYU1KaWJqV3lSTmE2R0NrMXFMTitLNGgzUmVUL20y?=
 =?utf-8?B?SEtWdms0MTZUMDBNVFlYSFB0akVNSHQwRU1BazcwQXBYYTNtcFEwNE5IRTdt?=
 =?utf-8?B?MitsWVBDL29VZlh2SU13Vm1pTnpCREFsR2lxQnExS2ZrSm90aTRpS1p5c3I3?=
 =?utf-8?B?NmRHaEdqQzdXd2tueGVuUW5qQnZsb3pUNjdtQWxONUlWa0pVTUJLaWxFS2kw?=
 =?utf-8?B?V2ZrL3RwRWNYTElYaUZZQllYUzVDMTI2UjNwT3NlM0V1UURHQmZxQ3psNmxn?=
 =?utf-8?B?NW5kTTJqbm00UVJaOEJhSXpHb1NxZXMvbDJVK3pmTmFCcFkrSmNhUVRyWi9u?=
 =?utf-8?B?NHcyWFhZZGpIclVyOWRyaXd3QU90blpwcmRzbXRacXM4SGJSWlpQNWxsNzUv?=
 =?utf-8?B?NDkrZHU1dVR4QzJrZXgvaEhVQ2N2bmVVTmFORy9Ta25VOEt2NUtLdTNucGhE?=
 =?utf-8?B?eXBiS0RHUUtSOUxEbXJmMktWUXdNeHFBNlprS2w4RE91bkZlL2V2dG5vRWRE?=
 =?utf-8?B?ZnFtWndmY3RxNmQwMlhQeHRCMExJdllmZ0t4VldwQ2tpVmxOa1pIVFZtQlZo?=
 =?utf-8?B?UmhPSS9BVDlMZ3NLSU9JMHZEU2NQSDNwdlNzV1lsREhGei9QQTduVVlrdDFV?=
 =?utf-8?B?K2xGZ2R0azhMajRIVEcvd3Fab0xNQ1hkWnhOTEJnUWZJNFJoSVNRVUltYUpU?=
 =?utf-8?B?VlNoWDgyaXFDYWxXcXIyQ2sxOFREUHA0dmhwNWJMN0YreWdaZVFNYlVmL2o3?=
 =?utf-8?B?V3ZYUmZUYWhJaE9MRDNuRE9tVGk1UmhDOE9BV3ZmRi9VS0cyMElxVWdXZXpF?=
 =?utf-8?B?azdmRTZlOWZFS0RwYVFsMUc0dWhzUnRyUU9IL2VQRndDbUszV0x3eC9XYTAr?=
 =?utf-8?Q?QVA/XoYIumo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STM5S1k5MmhlTVBWRXAxdU5Md05DcllWMndDNm9KNmZwUlR0eUlxVEk0SWdX?=
 =?utf-8?B?TndaZ1k3bnhKSDRPTk9hVmJPNnVxRmtDaFhqU1pxK2srNGxHVVZ0c0NFMHVr?=
 =?utf-8?B?aE53SGFpNWRvT0dMZUlyZWg0R0lwYkIzVUZMRTJzSFkreW4vMHc4TFVXSXpp?=
 =?utf-8?B?VE5LT25WeXZZbWxWOVVaaWhUcGxkbDhLc3NpeFVoaU4vTjgrMm4zcTZsRk40?=
 =?utf-8?B?MzdWdlc5MWRkYmZOYzRHUlp3aXZDK0IvWVNOREJ4b2J4UUxlaGR4MTRhbzdp?=
 =?utf-8?B?UDdXZUNtTGtxb3U0WFdnNXRsSVdSakZvQ2c0bGJOYWZsaUx2S1VDVmxZZGp6?=
 =?utf-8?B?TXRpM3VkYy9Pc2ZFa3I2VzNiaDZNRENDVEpMVTYvelc5bEpZUmR0aUtGVmZp?=
 =?utf-8?B?MTlzSE5RdVFFMjI0bUM2VCtTMGtidWgzdG5vZ1pYRkdSOEEyTzcxdm11d2JD?=
 =?utf-8?B?SnpVQW9KZituTUpianVreFpRSnRZRFFIYlVlMXdJWjc3KzBRMWFYYVdTUTJ6?=
 =?utf-8?B?ZTB2NlYwaURucVN1TGFBMGxVT29rVkF4ZVB5WU1Bb210ZTRMRC8vTHgvNS9I?=
 =?utf-8?B?U1AvSTlaVkZaL1VsNkxkM3RLdUxwWFFNVjJ5VG9UdW1raUJNUDhielRQUFc1?=
 =?utf-8?B?ZitYNmdJRysyN2h0QklubDhGdUh0NkN3WVZBUWZ0T0JxUHBWam9WNFlZSW4y?=
 =?utf-8?B?RjdRbjRFSFJyTnlwNEJIRkRObnFWTVExNWVJZEc2c2tmRW9RMkJ6eUdqSWFv?=
 =?utf-8?B?N1BPMCs5TVZERG1hMnRSUkpjUXhSWUhPNEk4ZjVuVnZrMnpZMTVYNlhuNitQ?=
 =?utf-8?B?Rnd4cC94a0ZlVWFRMjJCY3JEMFM1UVV6Z3ZRaUprSWl1aXdNY3RGcG0xS1hU?=
 =?utf-8?B?c0ZqRkFYZk85ZENGSFB0L3g2YzFVdGgveDJEbzg5SEVWZldJa005R2c4Y0xu?=
 =?utf-8?B?Wk9sTU9iRjRYWTM3SUIwQkZzcEFwMHIybHZsWlA1NEJKNkpzSXNBd21ZNTZu?=
 =?utf-8?B?TGdxRkppdjRNMkZ0a2VEbmxQclZ1dUlTN3BzWHVvWmZsODhZcUpvcVU4akFV?=
 =?utf-8?B?c050M2loSnBQeTY1a3Y4aEdTMFl5bEE3RUxuMGhQVVhOS29GdUN3K2RKbXZv?=
 =?utf-8?B?VHlPdnR1T2VpOXY5SG1nM1lWN0ZsZnFDSEEvWGplMTBXaFZObzZPaHpwS2hK?=
 =?utf-8?B?bTloNFpTQ1p0QldhUnhzVUp0N2k3Y285Z0xtY1ZLdk81QkFaZ2cwMFRKYlRF?=
 =?utf-8?B?bUtqM09wZythWUFGWUpIREdQTjlOZVpLaGZUWlJvQVptb3kreDliOGZ6UHlZ?=
 =?utf-8?B?NnJkVmY4TW5NSTBBUlBEMnpmK1NoNzRnUkNyMkxnZEFnV012Uk4rQVplM2xp?=
 =?utf-8?B?ZTVPR0k2K1dhZUNleUh5THArbnJsNUI0Z1ZvNTBZejdpazZHRm1tajQzd1Bo?=
 =?utf-8?B?YzkwYnFjS29vc0VRTi9EZUgwN04wRVgrMEhveGhIekR1UGtZV1FXNmF1RVlp?=
 =?utf-8?B?ZmJqeU9nQyt3SEFRVGVKaUpOME9YS3oyNkphUXV2cGVlRjA1VGV1U2dsck10?=
 =?utf-8?B?ODRyYStxYXplSWl2VzhVYmw2Ry9BSHlNa3ZiV0VGWlFSUytRV3JGM0xLcEZo?=
 =?utf-8?B?ZUh0cVAyc2hybEZDS1VOdkg2RDI2anl0dE8yYzJFd1VPM1V3L3pRRWJ3K0VO?=
 =?utf-8?B?ZjE5bzFKM1MxYjhBNVZUSUYxaFdmN3AyWFNtdHl6WGNDYVdRZGplaVpXNGNC?=
 =?utf-8?B?NjZJMjFrVUVGRWdtTEN1Y1F3L0NKdllMN3RkMHJQRGxYRzZaSXQ5OW9MdGU5?=
 =?utf-8?B?RUhRb1BKZzRFZTZRZjArN3IvU3BteEhJQlZ1clhkMGxTVFNuME4zMEgvbDhk?=
 =?utf-8?B?cDExMmFseVJzb1VnUTZMNitWcisvMUZSemJpK0JSQ1EzRDdvU2FSTmlrR0J2?=
 =?utf-8?B?bGtLOHFmeTliRGVZcnJnT2QvcFgra2JSdy9QTjAxWENsVHJKbkFRa1M2bHFN?=
 =?utf-8?B?bis1Wkh4aVVPMjlwL3FrVmp4RnB3UlBrUFFITEtibktFbzFVSTk2R3AvYVE3?=
 =?utf-8?B?TFF6RGR5UXpEcW9maUNuM0pWa0pGd2JYbC84MmtFNFVWZDVLUXc2VVZxckg4?=
 =?utf-8?B?R000ZVRXd1FTTTRzTmhzY0pvNUZzeHh4THJZcnI4WU00RVhncFNZaXV3dUYw?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d90d3bf-77d5-44ac-1c69-08dd89868cd0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 14:35:14.0776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frwvUZjQ/CBJ8jaSveUVyCChhX1Amalkj+NNtUj6p4kDPCkVhMfFgfi2rYow9HfYLCuQgI1ZlxAZxHqfYWITeu3007RdeVPUepsWdEQ9C2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604
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

On 5/2/2025 2:37 PM, Bruce Richardson wrote:
> On Fri, May 02, 2025 at 01:27:29PM +0100, Anatoly Burakov wrote:
>> Test-pmd already has a way to run a list of commands from file, but there
>> is no way to pause execution for a specified amount of time between two
>> commands. This may be necessary for simple automation, particularly for
>> waiting on some asynchronous operation such as link status update.
>>
>> Add a simple sleep command to wait until certain number of milliseconds has
>> passed.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   app/test-pmd/cmdline.c | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
>> index d4bb3ec998..1e429e6d0a 100644
>> --- a/app/test-pmd/cmdline.c
>> +++ b/app/test-pmd/cmdline.c
>> @@ -151,6 +151,9 @@ static void cmd_help_long_parsed(void *parsed_result,
>>   
>>   			"quit\n"
>>   			"    Quit to prompt.\n\n"
>> +
>> +			"sleep ms\n"
>> +			"    Sleep for ms milliseconds.\n\n"
>>   		);
>>   	}
>>   
> 
> A "sleep" command, I would expect to sleep for a certain number of seconds,
> for compatibility e.g. with terminal "sleep" command.
> To keep this as "ms" granularity, how about making it explicit as a
> "sleep_ms" command. Alternatively, how about adding a usleep command? [Not
> sure "msleep" works, which is why I suggested sleep_ms instead]
> 
> /Bruce

I have no strong opinions on what it should do. My initial version *was* 
a "sleep in seconds" command, I just thought that maybe someone would 
want it more flexible. I suspect that actually "sleep" and second 
granularity is just fine.

-- 
Thanks,
Anatoly
