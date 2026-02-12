Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA014EE3698
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 17:19:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED41C4025F;
	Thu, 12 Feb 2026 18:19:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 29F2C40041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 18:19:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770916787; x=1802452787;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=AjSfDizz4Fyvmw5Hrk6dMqa/4y9p5EQ/6gEW8QYvIuE=;
 b=bJVv0xtySeSbrGs8WnE2pSS8nO/36zDP56568FgimNNtOhShXAWvbQYo
 AHPPgsDhT4hblhBBru26JCva6vFElHlE5EfmTKWSDCeeRr7kGF/PMJrzP
 aXbTF4o/UGkXnT43zzeld3sn09ABi7oHYVkK7NJAzwrXWqADlDRNKPfER
 Elx2l2IHKEX5ZDWEgpZNlpuinVhjvS0DwG7lKl1kSRpySlDNrT2aZvHCV
 tElc45PobR4ryhQgK5qnTN1A2MmSB43riwSQLcI8rkLisq/w4FBQGKjBC
 GkEU1vm+sOz0tcS0fXZHQs9DIfItP9cuWQ98ozQPpZ88NE8HZbqSQHMog A==;
X-CSE-ConnectionGUID: RecdkbmATxqmyCp2bKBcpg==
X-CSE-MsgGUID: B6ftzPVdSNyUEyzFHIxdcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71297271"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="71297271"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:19:46 -0800
X-CSE-ConnectionGUID: vYjqi2RtSy6OaF1z22HX9Q==
X-CSE-MsgGUID: DwsILT8aQ46JM87OZ/xw4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="242214477"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:19:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:19:45 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 09:19:45 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:19:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h87i6WnrbJfBV7FDymMhTizMnlTdrbwygEjbe+88Smyw/Aj+RiNnUkB9/h3Z9Phux90ynDmP7PgKlQD5ooywn+xW0Ha9uHSy0nPr94nHt4mNhIcY7MrYulfooZpEzNct/YeLbEZ/2EjJbrN04wZJkFfuoq2/kl9P3u4aN6ozr4bvi85IforhQA/etVZ2Ypg2PHIL39WGx1pXBiSifA6pppQrPpb0uC6F9o3r67BStri6uAIhkvN3Y3KgwIszDdd74vAum3PUQrraEDeO+Kc1OHTeXa8FwAk9NcvqAa6ojB3xxw0zwIUwMIgvKfUXP0okmq9pmKuKZNgsRen7iQtLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjSfDizz4Fyvmw5Hrk6dMqa/4y9p5EQ/6gEW8QYvIuE=;
 b=HUZqpiODwKYEnAGLtuVJzlPH4Wq/Wjw6BI/3VliIdeKFDPX4DMQ704TSMI7WvawGS1p3s7GMuVSPuYCVusy/7uH4A8AT0d3l3TkS/8dH5bODCeSj4C/ImzcP9M/K4YVTWXtFAO4cyHdu3LyDOc/abftp8yvhorwSM3FGIQ8LrKzyUOw+Medz88LSQ3x9URAF/Nv4OuwPAWLLSACh3VlkCZ8JLxogiwljBAAaLGjjgD2HI6+p1MYW/MEIloNTMC3e4Nz2LiPDCFNNUIqtKFuQQlNcXFVQAjzkrbAwfdKnyJwJdusSlmxHqLcaplr+RS7q7xJGIo5xhyJuXFFlqpNzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SN7PR11MB6704.namprd11.prod.outlook.com (2603:10b6:806:267::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Thu, 12 Feb 2026 17:19:41 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 17:19:41 +0000
Message-ID: <0d1ed97f-8882-4aee-ad8b-d87dc2deb70a@intel.com>
Date: Thu, 12 Feb 2026 17:19:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] net/ixgbe: fix potential null dereference in
 IPsec
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Declan Doherty
 <declan.doherty@intel.com>
References: <af139585d9da1c0211d9e4d7926260f83b216b3e.1770900758.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <af139585d9da1c0211d9e4d7926260f83b216b3e.1770900758.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0284.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::19) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SN7PR11MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 5684214d-2026-4305-b6d0-08de6a5ae88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0lNYUNTc3Zqc2lkNkRVZW9XMVVjcUhkNFAwZUVsNDVvNWh2a2pmb3lKK0J4?=
 =?utf-8?B?Y3IvS0RSQlZRTEtMLytaN0Uzc1FuOEYyV3BhMTAwTE1rNUdFRy8yVzVKV3JY?=
 =?utf-8?B?b25abzRjWnNhdlB6WUI2aUxhVW8zbGIwR1BHK2JTZDdadzZPcytybU1jMFhl?=
 =?utf-8?B?Vk1kaTBPUmdsaXZ6RmEwSGpDMDBiVkR6Ny9leVVMa2tERkF5bVhwZUNDS3R6?=
 =?utf-8?B?RmdncnNzNm1DSUNCNnNycTJDQ29EM3NYM3U1V1lHQ2ZGS25CMmtMRyttY3BD?=
 =?utf-8?B?dm11VWxkWEQ2YkNneHdXM2ZpNnVUTmhqNnpFTzgvRWhVN2x4cmxsSzFHcHor?=
 =?utf-8?B?d0loSk5BOGk4eFY5MFA2Mk5MREY4b0I0WTNDMWVmNE5iOFIxamNKQU5mMGY1?=
 =?utf-8?B?ZmZIWCtrcTRQN0tLRDk3MTd0YjBaK2VhQThxNytscGZkWmRiemdUd0dwZkZG?=
 =?utf-8?B?YzAvMVRhd1hlQ3NYNGJFL0hxRnlmVk5VYTZiUEdYTi9VODhaNTFWOVRQY0E4?=
 =?utf-8?B?QUVzbUlhdTE0LzhwRmU5RWdaZjEvNFJnNW1xZldmSXdaZzVEUFQ3c2lITVFm?=
 =?utf-8?B?TExHY2FBQVlVa1pJNFdubTk3RVNGcis5QTRPbkcxNEFYaFN6WElRc0xIc1Iy?=
 =?utf-8?B?eTkvMGlVTXYzdHRkQ08rTU8vTFh1dU5YUUl3VDJqUng3Rlg0SFVOc1ZqN3Qy?=
 =?utf-8?B?RHdBaGlxOW1YUlpKdURldmovZUhTK2xxKy9sbDhZUVBLc2hHQlNibjYzOThH?=
 =?utf-8?B?dnd5czF1YkJVaVFBUEhDSGxlNHNsS2F2a3ZiMFlOblBhd2c5WG0vRnhzM0gv?=
 =?utf-8?B?ZFdFS2JaRFFnVzVNZk9iTENGYWx1RnFBZWl2ZEc5MzNURWRQem5CMmd1ajQ1?=
 =?utf-8?B?aWRlVEJCeWFQSHQ1UUlrWDc0MEVkTkJBcEFJK3AzdmdUYnJWMFMrVXVGeEU1?=
 =?utf-8?B?SXJzL2F2bDRiMzZETU1mNTlaZFlqRlJtSTM3b0pHcDNYR0VJN0ZyTGpXeDc5?=
 =?utf-8?B?bmU4bFRENHRoOUFHMVhsTkZxV29takR6RnNkTkt6eUp1Zlc2UG1iRzYzTm1L?=
 =?utf-8?B?aE1QcFh0YlY4WlFXOXJYY09IcGROeW5FT2l1MUQ2VUU2RkREWUVtZ0ZJMEQ0?=
 =?utf-8?B?LzNRT3p0cUxsVm1iak5ZWXpLRWk5S2xVWlhqWUJIMTNIYVZacW5OL1JkVU5H?=
 =?utf-8?B?ZVpTQTZVY0NqT0tHREQxb3JRRlV4SGh6Q1U2V1ljUXRNa0d2VEhXa2RkYm90?=
 =?utf-8?B?NzlMckRHbGtNVXVNbG9WdHlpcDRxcnp5azdqa25jb3MyWTdGZFJ5M2FramtG?=
 =?utf-8?B?QUgvelpDQ0QyVHhEK051UUFMV2YxUlg5Mno1dWNqTm1XOU5odW5hYVJLR2VW?=
 =?utf-8?B?RVJUcllHZEFOZ0p1NFJibzBaYm1HcVZRUkxhanFuMGFQWWxqdDF1SkdxWkcz?=
 =?utf-8?B?cytLcHVlNjBsNFFZMGJoQWsyMS9uWkJEUlBNRWQydGxCeFYrNU5wazlRZ2hF?=
 =?utf-8?B?WGRtaGZVL3pOYlhKS3NxYkI5dWh6UnAwV0JNOFhyWGw5WGp1dmV3dVlkZ3Fw?=
 =?utf-8?B?NXUvTWh0T3JoQjlOSHpnNkxVRVd0ZVJzWkNxQmlDeFRldXM1dFBjc0RFazlj?=
 =?utf-8?B?b24zUkN6R1lyREJsam5zM1dZSkE4TnRxVEVxMU95RUVVWjFXVTJoZGFnaUJU?=
 =?utf-8?B?RG5kYjdCeFR1UzgyNHJ0dHpIV2xRY05ZS3JnVGxCaEtBbVJyeTdnN1BGVlpO?=
 =?utf-8?B?bmFpckd3ZlFWZlBjdW5LOGtwUGcxZE4vcnBnQXpjcGg0QUhUSlJlTWRpdHJV?=
 =?utf-8?B?cGR2bVFLZnhhb0s1TDJPQlJ5Z25kTkZZVVVVQUlaS1gzMUxrYXFaUE5uOFlQ?=
 =?utf-8?B?SGM5NS8wa256WnFlMklPL3p1bllZbklBL001SEl4dExHV242UXdtRVdwQmFM?=
 =?utf-8?B?b1VEYmpnY0dkdllXK3AvekJaTm5Wc24rOEFHRFNhWURkTGFIYTVkU3RkeDR5?=
 =?utf-8?B?bkZkbURycDBVTDdLdUVmVEs4Rko5ZUxBMW5JK2VCSGxyREVIK1Y4bzdHMFkw?=
 =?utf-8?B?YzdaZHphZG9tdkJzdUlqbW5UdW1UamkwU3gwcU5OMWRuN1FRQXBNRXB0TFht?=
 =?utf-8?Q?U+/8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWgvWTZUNHBiS3lTQkxmL1NHV2wxemFsU2t5RUUyRnMxYkpYZTk1YTdEVSti?=
 =?utf-8?B?UUozMkphbjk3MXNpM3RvcEk4azc0V29sd2wyLzdwKzlBYzJKcUhvRWh2VUxm?=
 =?utf-8?B?c0ZMbk5yRmtqOU9VWGg2UWc3ZlBKSDZXVTliUzkyU0NUQ3pKc1BmcHZSL3F0?=
 =?utf-8?B?K1o0Y1o5Q0o4R2hWZEdpQmRhZVUvbXFhS1hpNjFvWmQvNDZVRGZ1Y0hRaUpl?=
 =?utf-8?B?SHkwaUkxU0ZIeHlMSTB2OFJvak9Sbk5nMzVibWpsVERybVVOSTZmakVoOTVT?=
 =?utf-8?B?WlRHUWx6TlJhVmtHNXp0OEFlcTJlZkdWUThyNS85UUxyaHcwdHdkZ2Y0bUMz?=
 =?utf-8?B?YmVZa0lZS3hpejVpZlg5Ui9kQXp0bGp4Y0wxK2Q0Rk1lQUcxd202eGdpM200?=
 =?utf-8?B?OHFlU2RhN2RyM0JPODlhNFBPc1B3ekM1bEVtS0ZLWGlUTlllaFp2UEJRTkRs?=
 =?utf-8?B?WTlPY1lMVlNXVlNLT1Z4a2xRL3pjWVlBQUtXaUs3Nm8yN2RRaVdvcFp3KzdI?=
 =?utf-8?B?MGdVeGZzK0hMRFBXUExpRndvRmNRL015bklueWhQVWJ0U1FobjlGN1pwM1Bt?=
 =?utf-8?B?cmN4WTYvVzNidTBRcndnOVdRc3lqb0lPbnFOYlRaWUF5ZnZBTWNhcXpLK0xF?=
 =?utf-8?B?L1B0ODBtTmJ3T2oyaEU1RllsZXM2b2VHeXVoNDlvc2hiMS8raTlFanhRM3NP?=
 =?utf-8?B?ZXRva3VScjFyMUF2VUp1TjQxYU0rWVlNREJ5YitjaDNOSjE2bFZDdHlsRCtm?=
 =?utf-8?B?akFKUytyTXhrd2dETFdCQVR4UnNtclBtS0swVUJoM2d0d0hYd3ZKanFEYXRN?=
 =?utf-8?B?SjBYb3NPclBwZVAzV2NLR1cyQ0kxWTFGenk1U21MNUUvMmtybCt6RE40SHBv?=
 =?utf-8?B?Znl6R1BCL0FyQytzcFBCMUdVNktvRERjcXVJcXFyVm5zdTBCSGNxYTlEbHov?=
 =?utf-8?B?ZVgwODR1WVkvTUNHS3NXd0pXN25IYmRZbmN1SkRuQitzQlhIYitTVDgvRGdj?=
 =?utf-8?B?cmx2Vi8wbHdiQXJSbDZkMnJScDExWGkzTlJmcFBxdUxrUmVRYkJ2ZUN3SnB5?=
 =?utf-8?B?TTVjOXcxcisyZnZxMy82SE1rTHZ4SWt1a2Zla1V4clpHdjY4K3lKcEZKRXFX?=
 =?utf-8?B?YmFKYlpHaEdoa0pCQUozd3VVaXA1dk5kcVh6Ukk3ek1lRkZnVnhFN2JrZHpY?=
 =?utf-8?B?S0ZNQ3hiSVlxMi9FR1cxOFBYdXkrVUdXakVYS0JqNU5MR3hGc1diRTl6eGdV?=
 =?utf-8?B?OXlNM0xNU0tuZjJKRW9tMmNHTEtDT3puM053aGJGS3B1akVBVWlRZlVySFFv?=
 =?utf-8?B?bjh5eXBVV0JLVHd3RGhDbHRzL1JRSkhRcmZOcFU1MWdwRnUxbHJaS0g2Ymw4?=
 =?utf-8?B?M1kvTXBIUmprNWdOSzNRcmlJanhkQUR6VS9vWHhUaG02bnV1MXlQVVVDMjBD?=
 =?utf-8?B?TW90eFA2QWQzNGlsOXBVckR0eUtnSmw4K1ZZTHlIMFFtVkZHdnFwWi9uREwx?=
 =?utf-8?B?ODRmSTg2SGlERDRjeTVtV2I4WnFMdlkzTGxON1g0SWF1ZGJmSTNleHU0NFpq?=
 =?utf-8?B?QzR0UVRBUDNnN3FFR21mWVhkQ29Gek9RRVlSdXgvVWxuUWdGaHQ2Y2RBME5r?=
 =?utf-8?B?bkE5MTdzVkhYWlc5MmpOYVJQdkJDSmdvRW1mME83MnVGQzdhb3orSVdhWHhX?=
 =?utf-8?B?NWdHMUZFai9jK1V5TWNBTDgvQzYrWFdwa2lBeWpkMittdU1iV09OS1hpWjNq?=
 =?utf-8?B?Y05JWmd6eGxSVjZ3bFJIUWlFSFY5SERWZTY1Q1RMNnBKOE5ZS2pwSFdOWllW?=
 =?utf-8?B?ZWlXRjI3M2xLaVg4bWZjcFNJTTlyQ25ncldUTFJRai9NTkloYTAvM3NWTjA4?=
 =?utf-8?B?Uzk0bktiTHdnQ05zV21ERkcrcWx6dUZqMlpWdGxORVIwRGJFL1FLRjVzcUw1?=
 =?utf-8?B?dDdvcHA2ODdYZjQ0L0VOL1JIU2lvMElzYUNqY3RJRTFIa3YxVlhwYlg0N2JZ?=
 =?utf-8?B?WU9VNE9nZmR6RTM1MS9ERlNON3paVEo5RWU5OThLTGZqTk9YcCt4NDFrbktQ?=
 =?utf-8?B?VVI2TUtQenl4TE5obFRmbXl5OG8vTlI1VDlZcjVvL0diOVNqY21xT1JETXQ3?=
 =?utf-8?B?VUNHTEdxYlRCdmJET0NkNWYzb0ZXU3U0L2FpcmFQTTQ3dVY0dWFUNkhTVFBD?=
 =?utf-8?B?ZDdweTVpQ2duSkowMmxxWCt5akdMcFlkN2paSUN4NjRla2pRV2JtMzQ0OWM5?=
 =?utf-8?B?NTBzTWh3L3hCM1BoMmh5bVFXZmdBWWJiUTdaamFCK09yWFdYdGdHWFFPQzNp?=
 =?utf-8?B?QlJEdkdpVmVrM1lHbFNhVk8zbFJLcXJ0SFVPUkJ6WWRNV3E5dWlPQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5684214d-2026-4305-b6d0-08de6a5ae88b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:19:41.6674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubZ1Fqpn2ND23c6ZyaNwepmO3XH8UZ8af9laZzObyWwQ+KEpCwltxPnXBwj4f2RMDRKe2JRC/pESDnLDeNPRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6704
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


On 12-Feb-26 12:53 PM, Anatoly Burakov wrote:
> When parsing IPsec flows, we access the `conf` pointer unconditionally,
> even though it might be NULL. Fix by adding the check.
>
> Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
