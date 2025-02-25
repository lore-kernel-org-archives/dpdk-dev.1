Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EFEC021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 18:17:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E408402B1;
	Tue, 25 Feb 2025 19:17:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 51548402AE
 for <dev@dpdk.org>; Tue, 25 Feb 2025 19:17:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740507436; x=1772043436;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=P1zsHklETkBvxxu8HZoVqYE6ctOjb3agcEdvmMC9+3o=;
 b=ed2TOyUVJ5/rEh/DKnO87Xhcg9wyHIcNDTx4xYi6LpY2QZQK7sRHDogj
 U/i9OGnzYdMJu1NKL0mfXsaydrK/QrA6MiVvJicL/iqfm0uXXRe0Rv8Yz
 7s+dAnTWLUU0Tzn/56SeQzP7uOlUmi33s8GHgbmtnC/dEgxIFVBJkWM+X
 QQ/rD32JyblRha0N7N86EPgi1r/IPYMUjdQ04WQK57K3O1nB5C6/qFsNE
 DN/1rMeCUY4l9AVnHDtjDKVv5PZUEhEvyxlouyixiniBV6FK6Er82/Snr
 mSxMA7fPVMk1q2SQDG/hbnJCPyF1U5X6rW8cumsmRmIk9ufP4wGCQ0xC1 w==;
X-CSE-ConnectionGUID: jO4VWpGPRkegDWgOwiX6tg==
X-CSE-MsgGUID: nlVmcVT2SwycgH/aIgF1aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41465734"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; d="scan'208";a="41465734"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 10:17:14 -0800
X-CSE-ConnectionGUID: sqllfcIKTlW5BqiqKl6E+A==
X-CSE-MsgGUID: ZPyGY5kHSl+NFpzy0JOs+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; d="scan'208";a="116269697"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Feb 2025 10:17:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 10:17:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 10:17:13 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 10:17:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pO8GzBVHK6y86wj+P3z0ZI9XdVelJlak+f3yUHq71rJy5dtMLxiEJSfWZDfc77RS0kHUIUVGwbUN7IrPnC2DIoL0/UPIs4pnDv1GrIdVJilEwmgBIjIJAOk5tkmWSjG3r+S9WUi7Ia3sBZseP5hyCi4Nmu8St/kX8ujkL0CSZ5eElQdJCvgprk+UUmdUbsMJlqOdKwtKDGCT/r6fsbNlwZqQx/GwqoGpXlW1ikDny0+L6Zppi2bQ+fv3DA11IhogmssfF53w769OvtKLI1WXHNAoqWGB0ml1XFTke52cmSIYGREUvr5ZblB6HrqDQ0bhWvxlysR1AmV9Qyo9K3h+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QeG8Pu47s1LqYwlgXzOxn2mXptJeW4EnU2Ole2OfPU=;
 b=khWxDO0GAdWHWbOxzvZYtBQLOznqMEL3iqztqWL5A5VJUkEpSI/JiCVBFggYNfPGRcgRYNHCZ94gKnnhdU4g316Rvgn60hVK1PBZutxdvYFqfl76QVr6WmBOd4Qyw8S1C1LfznDR3da9jNTymnEBRmdjd/MulGYjOQ8ZkLcOur61ofgyJFy7c+H+2X/c/ROKXYygd7sWRoGWQ6RmHG35K9nmseaNgDBFEJTce/JG+oQi2it4UJeOZV6MCsKozcvXG+fuORVc7qBF0xwKEBb6g5hZbENqREM0hU84eEP+BAyFQEWXT2TSno9Ua+W4EMVenWHNbrpi7PxxakwBu17DUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 by SJ0PR11MB8294.namprd11.prod.outlook.com (2603:10b6:a03:478::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 18:16:40 +0000
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b]) by SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b%5]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 18:16:40 +0000
Message-ID: <f820a6a6-4332-43f7-95f3-96d40bd3bb6b@intel.com>
Date: Tue, 25 Feb 2025 18:16:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: fix ACL filter uninit
To: Mingjin Ye <mingjinx.ye@intel.com>, <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
References: <20250221082510.332677-1-mingjinx.ye@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250221082510.332677-1-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR02CA0020.eurprd02.prod.outlook.com
 (2603:10a6:10:52::33) To SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_|SJ0PR11MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7d52f5-b178-4c8e-5b91-08dd55c88c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVU4bVpTNFlkMWh3RDkyak1kMnYwa2IzRGRSQUJwN0tTUmFPRFIzUHVTazFy?=
 =?utf-8?B?Uk5mbDhLYU1mWjRPdlZXRVlBT3dqV3Z6VlhGZ2drTFRWTHNMZWp1Zm4vY2hk?=
 =?utf-8?B?WmFoclRpS3hpMzA2d3BKUUtPRnB2UjJIYTJnQzVGK2dZQ1RBM2ZYRVNkTS91?=
 =?utf-8?B?UFNPRUhEU1lRUG9BVm9HNlBRa05EalQxQjg5aGNKWWFNbHo1ZEQ2N1kwMHk5?=
 =?utf-8?B?dFdVb1gzY2hNTUVZNUM3QVBsalE3c2trb2NXclBZbytKQmtGdUwzRlVUaGNh?=
 =?utf-8?B?MGVxNFZlaXRzNk1jN3BpdFdRT3FqekN5Qmlac0w2d3Fqdm92R0RsSEk0bU1E?=
 =?utf-8?B?bmV5czFDdVV2R3p1MzhJbGlvSXIrT05jaFdDcGhiendha1ZPNGNrQ1YzSWxn?=
 =?utf-8?B?M1dFcDZyVmYzVjNpOFlQVjFMNmtVNXVxbWxoeWNUMjBYdVZxQk9YL29ERWg0?=
 =?utf-8?B?Zm1QTTYxcXhTM1VFK29EWDR4MlRMM2FmenBmYnRRSy93aXpTcDlPR1ZnMG01?=
 =?utf-8?B?UElvaU1PUjZLWUZlTnNqVlNFLzN2bHgzRnVDNy91OXdLMjVVWGZWSWZBQmlI?=
 =?utf-8?B?c2JiNnpWMjREYTlGWmFFdnoranpWZGo0dWxnNlNJUW1mdDlqZlJrY2VLZFlr?=
 =?utf-8?B?RWtrVnNXNGZwdzZkZllkV0ZuQml6dmUzWVJWQjNLUWsvMCsyMmZZaW5oWEFS?=
 =?utf-8?B?MmxwdlYzanpYdUdSc1NJRnpTYmMzRlhvdVVPM2tGd3paNnNpZDdOMDNVTld3?=
 =?utf-8?B?RFdKYjA0T3V5T1RrS3pYYXh5UFNLejBrSXRWcVJqZFNEZHZjLzdUb05ZSzJu?=
 =?utf-8?B?U1JFdytyMDNEWmZnbVBMVEc5Ly9hTWRLVmpId1R1UURSa3hiVDhCbmU3dDhE?=
 =?utf-8?B?cEVxdDN5akN1RzRYOEpweWwxSWUrK0FZVU9ONmpTeHZLbGdJU3NVTEZmQXlF?=
 =?utf-8?B?dHF2ZTU3SzVaWXA4a1EzMTJ6d2RRMVd0ZkRYdE5NampRQmc4YmlqWmpyUWlz?=
 =?utf-8?B?ejRsV0E1blMzSW9aRWIrZllBVU9RQmgvblBvaDI0MGM4R2gzc0FYVFBMQ3Nv?=
 =?utf-8?B?b09rRUN2Y0puMkNIeTN6NnBLKzBva3ZId1VacW5QblVodnhjWGpOdWFwUkhv?=
 =?utf-8?B?Q29PVFlzb2NBT2NsdkNSRDRDcldtdUU4bjRPMWN0Zi9Jc2VIeDl2L2FhUVdv?=
 =?utf-8?B?cnptVkFxajUxczlMTS9QR3A2dW9VT1NEeWp6NHBrQ1pvUnJULzcyckdhR0hu?=
 =?utf-8?B?TWNKUHNsMjQ2eUhrY3Y0eVR1NXFxRDZrT1VoVnJLbWtNdUxQVDRDUUhnODRn?=
 =?utf-8?B?NVlGdkh5aEhsTVRuUEd2YlZuUWF5NThmd0oxUm5OZFJzc0ZDTi9SNmdZZXZV?=
 =?utf-8?B?T1hQcWMrbkdnbitXLzdLZWRjT1V5UW5hMHlVMTZaKzhKYzJvUVJ4R3BKTE8x?=
 =?utf-8?B?RVJscUo5RWtBZ3ZKVU9Lb0hyVUc1RWNUeGlvakJ0YUc0MGhsZ3JFa2h6aDlp?=
 =?utf-8?B?YTREK3BOMTZubi9sRy80TUxpTFBEamxqUTYrT0QrU3hiaHgyUW9VaVRKVU0r?=
 =?utf-8?B?THZSMGdvcHhMV2lDdkpQOEEybFRTSy8ra3RKMGRFT01yclVQQ2JMNCsyYVhF?=
 =?utf-8?B?dzdhTUdwa2ZGWms0QUJhbmlvM0NxbytEcjZ6UkJSNzhKd2ozQ3RzakU4TDVp?=
 =?utf-8?B?VUFibG5jM0JHOWFJS2VRSisweEU1ZEZMMEp4VHNNZjhSeHFxenF6MDlNY2NF?=
 =?utf-8?B?ZFY2TmhPbzVQNDg1RDBuTk0vWm5WcFZ5clZUSkFHUFZneFBmYkFaZC93eGVR?=
 =?utf-8?B?eHAzYkdlVUFUTnR3NmRPOTRqSGZGRmt4MnFkb0ZITVRVaWhpeFdzQUszRVE2?=
 =?utf-8?Q?jfwyW/s6ndgAX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5772.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NENUTVJnMWhXUHhKNFYxY2JIU09hbWdteUd6c3ZSMTVqNk4rVG5PbjB0QitH?=
 =?utf-8?B?YWh3Y3gyNjNiV2ZlK0ZleWlFRjMvTWtCNHB6OURnbG5EbXpIQTA5Z0hTVmI2?=
 =?utf-8?B?d1RWSUVEeVNIbEJWSlhyTlZoSUJOMXh6QUhBSi9Fby9NYmhMaEx0UDJUZ2tL?=
 =?utf-8?B?azBDV0FnTktJdXovdHFHOG1jNC9TcU9ybmVkcUFZcENGUGk3Wk9OSnk0bUVu?=
 =?utf-8?B?VGgzN1lvNDdqMDcxcTRwU0p5WXp3dG5mbW1UNmY4UlNCb3ZxQnpxeVRzQ2Iz?=
 =?utf-8?B?MGtuZ3RDbTJuazVJNnhWRmVFenJQcmFTZzc3UWUyeXczaU9UUVJWei9XbGE4?=
 =?utf-8?B?bWc1YnhCQURFRlJpQ01jMDBhRlZweE1NSzRwZU1LUXFnYW1mMndVZHpPaWln?=
 =?utf-8?B?Y2V4elhUYWxZcUtIZVQ0R3krclNWQS8wOTd4OEtmeXdhUU9MY1BhdG9vWUt1?=
 =?utf-8?B?aHdSMWYxRUk4djBRM0pyTVI2aXpCZEI3WWxwZEFURnorN3BEbzRSeWtsMHZs?=
 =?utf-8?B?ck81aWg4aTRUZmhYWEQ3MEJRcktjL3p0bVRMSzQvL2doUGFWTlUvcmZidXVK?=
 =?utf-8?B?WGluOTI1Z2lnVzRNQUlzUitsWm5TcUpBZHpnUGZ2aXQyckt2SmxHRDIvNmVR?=
 =?utf-8?B?THAyT0Z0TlppaTBMRjhnQjd3dUlUbWU5RDI3NnZRR3h6cWxEaDd1WHI1NzNv?=
 =?utf-8?B?VVU5UmxLQzJZWGp4ZDNEdE1wV0RMOTJqRzV2NnRITExLUUhKVHd4VmNOMnM1?=
 =?utf-8?B?dmMzVU9kVS9TL2hJVTZacDRUZWRSL1I0b2pURnFXNmpuTTZNQ1lCZVM0bkh0?=
 =?utf-8?B?ZnVUd2xTekE5MWpuM21GcDI2N2Zxa0U3dlpCaVRwNWlLcFlYdFVTY2JFenFu?=
 =?utf-8?B?VThEZHhGcHIvTE92ZERkL1hURkdTQmpEUkowMjVyNmJJNFFvcXdCZ0M5MWJT?=
 =?utf-8?B?OGxkVENDaTN5UmlIRm9ibkxycmlqRmNOVFNJT1ZXWVo2ZmhIL3RPdXFQeDBx?=
 =?utf-8?B?OUlzYzhsTTVyQThNcFhLTGZ3aFdDWU1zaEpqNXVwallJb0VwQzZiN1Y3TlpZ?=
 =?utf-8?B?enNXMndLanVPQWpaVmFrMHVlampGdGg4QkN5YUpwTGtvNFNXM2hTeGpyNlJ3?=
 =?utf-8?B?cWlXM2dVUFc4cU9YNWgvSjd4dmd5ZjFFMkF6cVM4QUhUTHlPYlovV0xQWTV1?=
 =?utf-8?B?ZkEwdjJoeWo1VEVpWE95bklDM2FRcE1xb05UTE0yNTBlek1aUGp4T0lPUzVu?=
 =?utf-8?B?b3NEMnVqL2ZHSkQwYjVJSy9XRkRndW9zemYzRytZT1JFbmhNS3FieGdWOUpZ?=
 =?utf-8?B?eWNoLzRvMUVIelJSZFdxREhQQWpXdWhWdlpVbTNxWURoLzdYVFhob0M4dkVs?=
 =?utf-8?B?NW9wZlJha0wxVnlVTEE0eFI4NUxlVysvVE1JZEJ6MXhscFZRQkdrQloyTm9w?=
 =?utf-8?B?anlJam4rdUl0VHhRdER5REQrZGw5NERQN3l1REt2NWg0S3hqQzB1dVM1enNZ?=
 =?utf-8?B?bExPblM5VXZPNGcvTXpUeVVDUlRrRXZWYVQ0RXlMdGR6RTlwUVJTZ3JTdkhO?=
 =?utf-8?B?OVNFVEJtdW1HWlprNFRJekM3aU14eHc2dFhGK3VKME1VeFFTTkFSWHMzbE9X?=
 =?utf-8?B?NmtCNFY2N0hjejlFWTRQUUlKT2xrdmsvb0lCUVJCVml5Q1dXUE93RVdPS2pD?=
 =?utf-8?B?cU1ZMy9TV2pUem9WVGhNNS9qakh5eDluR3UxUW83bDBYNW44VENUWGMycFBu?=
 =?utf-8?B?Tm9zYjgvZFFIK3VXWjF1SUtGdVhKM2k5V2FOTHRCckhKdFozeGdtUit3OGF2?=
 =?utf-8?B?MUNZdVIzcGpXbnlDaytNQ3pZWFdjcWNHeG9DRklnbW5PT0FBYXc4c3NGeTEx?=
 =?utf-8?B?MmVjNUl6OVFOaXZuUVZwUDBIZVVlM0l0MGpNTmlLQTFYSlNUMVlTTm1xOVEy?=
 =?utf-8?B?SGZhQS82VTBLRDVaSVFpZE42ZytBT0FYT1FxQ1FGK0lxbzBXY1hzeXJWYS9I?=
 =?utf-8?B?S2NsaVlSamRuaEhzWmJGaUNNSElCRy9HdEFhRGdNbWlOeWZkUmJQbE4xNVF5?=
 =?utf-8?B?MjZiRGlIV2hrRnhvQlE2K2JMYnBEdlFreTJrRXFmL2psbm44MHQvL0lNVFJ5?=
 =?utf-8?B?RWVXUEVCdWxlZVlPdWFleThzcXpTMC9ONzg5dFBldDJ4OS9rUjJxdUhnRktV?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7d52f5-b178-4c8e-5b91-08dd55c88c8d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5772.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 18:16:40.3668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3qXDvBSgQPwAHRGzrEt6fhlDKPGMw6FbhpzmHPQMzB70DgF7jq4IKsxZQuAngEsOhNN4G0+BIMZFKXMPMie49LPV3cU9AsPdeondScQgNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8294
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 21/02/2025 08:25, Mingjin Ye wrote:
> The pf has enabled the ACL filter, so uninit is no longer limited
> to the DCF.
>
> Fixes: a9d612291c2d ("net/ice: support IPv4 fragments in ACL filters")
>
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---
>   drivers/net/intel/ice/ice_acl_filter.c | 48 +++++++++++++-------------
>   1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
> index 04c17a98ed..83cb3e36f9 100644
> --- a/drivers/net/intel/ice/ice_acl_filter.c
> +++ b/drivers/net/intel/ice/ice_acl_filter.c
> @@ -278,26 +278,28 @@ ice_acl_prof_init(struct ice_pf *pf)
>   	if (ret)
>   		goto err_add_prof_ipv4_sctp;
>   
> -	for (i = 0; i < pf->main_vsi->idx; i++) {
> -		ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4, i);
> -		if (ret)
> -			goto err_assoc_prof;
> -
> -		ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_frag, i);
> -		if (ret)
> -			goto err_assoc_prof;
> -
> -		ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_udp, i);
> -		if (ret)
> -			goto err_assoc_prof;
> -
> -		ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_tcp, i);
> -		if (ret)
> -			goto err_assoc_prof;
> -
> -		ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_sctp, i);
> -		if (ret)
> -			goto err_assoc_prof;
> +	if (hw->dcf_enabled) {
> +		for (i = 0; i < pf->main_vsi->idx; i++) {
> +			ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4, i);
> +			if (ret)
> +				goto err_assoc_prof;
> +
> +			ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_frag, i);
> +			if (ret)
> +				goto err_assoc_prof;
> +
> +			ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_udp, i);
> +			if (ret)
> +				goto err_assoc_prof;
> +
> +			ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_tcp, i);
> +			if (ret)
> +				goto err_assoc_prof;
> +
> +			ret = ice_flow_assoc_prof(hw, ICE_BLK_ACL, prof_ipv4_sctp, i);
> +			if (ret)
> +				goto err_assoc_prof;
> +		}
>   	}
>   	return 0;
>   
> @@ -1082,10 +1084,8 @@ ice_acl_uninit(struct ice_adapter *ad)
>   	struct ice_pf *pf = &ad->pf;
>   	struct ice_hw *hw = ICE_PF_TO_HW(pf);
>   
> -	if (ad->hw.dcf_enabled) {
> -		ice_deinit_acl(pf);
> -		ice_acl_prof_free(hw);
> -	}
> +	ice_deinit_acl(pf);
> +	ice_acl_prof_free(hw);
>   }
>   
>   static struct

-- 
Regards,
Vladimir

