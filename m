Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D4FEA8109
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 12:42:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE019400D7;
	Tue, 10 Feb 2026 13:42:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id F32EB400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 13:42:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770727348; x=1802263348;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=pFR47xNcGltu2WIYaX53Qy6wDmY2fYLcyQl+VG3yMtI=;
 b=F7x0QouSGUFyVAlEUmaZatjmBcTa96eQcLgA5iY4arzYSxH7io4iXPPJ
 bGWRhDUik6vPwFdFCMope5JsHgNgno+l0PyV6WnKs14boJ4ueBhQqFuvA
 PH69fY8JQSdxgfuxr0ePRo5crY20ZTl5x7xy8xXYskdvwLX3tol/3oTB/
 9bJMj5nbBX0/bRfyeQPQcFPm23XNcvAMQKJvstU4Y274RvMpV+9aSwE+g
 6aw46wCVPOHBCYDCE/TxaMvzjZjEiKBfIo3jrdcxocbjXNQXVFneIuQ5Q
 yJjeeM3ld10RtGOlWMQW3eQzFO0Q2BrtvO0pAsUQ7trPekox2ohH6pzIt g==;
X-CSE-ConnectionGUID: 9EBwImPCSV69Bf+Bu402qA==
X-CSE-MsgGUID: uEsElVMESVWe61Xr+aUwUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71954992"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71954992"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 04:42:27 -0800
X-CSE-ConnectionGUID: 8ArNO16aQEariI5agUqFEg==
X-CSE-MsgGUID: 1qMCem4EQ3+y9Af90yHLlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216441231"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 04:42:27 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 04:42:26 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 04:42:26 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 04:42:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMfhIhf0hy83EbkJOX7Jx2FXodFwpQJL+NpdH+khgT46KI0tw7EZjQ6egLtS+zg5M4PfdfpQpr3Vs1PozHRVdZJBnB7yqkpjHDjof6MGvG3RpUm/3pzWI7OGfJU0H9QDD9Ynb1J/PHT2CbBRdf3D3ti2bZ7gzES1xR0WRkQjyx6PqQSD+5hns5rEqYNofC55yeHbwF275eDhevBFJQgwasSeUjZ0AZq3GmCAXZaHuKc8B033fuFpuIJbSdU6AW6mBkMRLbke6VdxJ1H8tZuzuv5aIVGUu/A/aUKxL7K0kZBIk8vzaUZ9rNxaCkwBy+YmKVgvSgkSog8rMtFKGgPYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhUkH79X30idX14x+HbeYB+XU3QHjaEh+it5hNdXha4=;
 b=ErXl0G79oW0HWaVxfAGHI+DJrswZfn76sVmGx6hh5hDQOCp9KObIQGclAVvEbj6l2V0MTl9101Avsm+73PbHvEhg1rbqzPHBqG4CqdemxyhbMGSy0BjdheEW5Tzcwj1TT3dfRNgKFpevzA3eoz//eWXNfJCnSmAjpbEDXkUDw7M3NzW/ES1E1M3q+0Q7+UFdfCfYSCAlDF4XIPNl/Kl0XJaXXnc3S3t7VBmLOZq/ZpWaSvG4O3Ee+FtKBE+7zgBXOK5W3Y+IqOUs232npZr9uOa8IMAh4uH55obsVK45oKiMTNO+Z+rlZEA7zGi5U7+iODKWGEOPBdpBOQAXMj5LRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ2PR11MB7519.namprd11.prod.outlook.com (2603:10b6:a03:4c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 12:42:22 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 12:42:22 +0000
Message-ID: <f3a53f53-e636-4660-81a8-5ae3b3fabf0f@intel.com>
Date: Tue, 10 Feb 2026 13:42:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/35] net/ice: refactor context descriptor handling
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-7-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-7-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0267.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::10) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ2PR11MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8e9e00-1aac-433e-8c50-08de68a1d60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmFwbEYyMU1SdFdGZjNMS2dTRDZTUVZxN3l1aC9pYWdUNWdLQ0hOMTVRejF2?=
 =?utf-8?B?ckI0MHFWQlRFTE1SZndDZ0NyK296WmFaWCtmMDFmZ0pPTEkyWnFXL056YmJq?=
 =?utf-8?B?MFFoTURYU1MxVmtpZk9nRGZuQ1hyZEVwVFJpY0ZOWG02UDVSOE5qQThHL2I2?=
 =?utf-8?B?VGdWRmZlUWM4YWxBbFhLS2p6ZlhqcXAwVG51bkIwWFJBdHhJYTZycEh4Z2xE?=
 =?utf-8?B?cTZ3RXVvV01SRFNKWHlITS9CQVVrT1RRTWYyZGI1ZTRKMEJ3Z0NpeXdzMkhL?=
 =?utf-8?B?bElJUmI4T2x3c0NDczdUTHZTQVc5dXd3dlFEWnA4OGFPdW1uMnFQZE55cGFZ?=
 =?utf-8?B?NXAyUndmOGxaT05lNk9yeGZheTRvUDZXMTNyWkg5am9MR1hTNFJ3REVFOE8v?=
 =?utf-8?B?aTVvWkh2a2lOUmRsTHM5Nm9IS1hDdHZ2MHprUVI2cFRPaDZxUmo0TzJlTmdG?=
 =?utf-8?B?dGQzOTBlWjF0WWJJcnFUa0ZJa01KeE12MVlycmNXa3dVTjBwU1hBOHlGckc1?=
 =?utf-8?B?cFZzOTVqbHNibThWc1B4Y1VVV29rM1dPVVlybzM3WWtURFNMUE0zVFZJcmkr?=
 =?utf-8?B?ZEU4WVVuWGZJZXl1dGk3aVFRTnR5ZE5naytzK0s5Q1VtYTFWVGlyS1h0YjdY?=
 =?utf-8?B?RkcvRFBwWFNnekdjWTIxalJwQ2NYZE4ybVpzRG9NbGRPNGlTQ3Naazkzd09G?=
 =?utf-8?B?MnlmaDQ0MVJnZm1McklwRWxqWWlZK0hjeVl4RE9KYzU2V1Q4UEo5Vk0vUjdZ?=
 =?utf-8?B?Y2lYbEVSMGpYeDFPTkZZU3plVXFrWjFFa1lFcnBISlFMNjVxMW5zdVhxaWF1?=
 =?utf-8?B?cHdLallmZEtMOE1IakJWNlZxUkdIa3lYdFM5RXc4TWtaWEhTZXlzN01oRlRR?=
 =?utf-8?B?cUtEWUoyMHl4VmFBVnJOVXVrUUw5ZFZ4T2RnWGx2azE1bFIybmtJREtuSnVv?=
 =?utf-8?B?SFBuTC9RZ04vOWR1WCtQT3dwaWx4dTl0aVZtUmVBbWdGTjRCZHU5d050UTB3?=
 =?utf-8?B?Vm5TUzhrZVZNTldQclJOQWJhbnF6cDhhS2JtSTFuSzVrUk5TUVF4ZllsaVR0?=
 =?utf-8?B?bldibWZaZGxzWURuUTk2YWhtZVh3dCt5YWF3TEZYSndsditZeXFicWpycS9Z?=
 =?utf-8?B?R3VrRDcxY3d6aXNRWUdCSk1LdHB6R210eUttNU5nRkVJQzBIWVQwRzdyTzNv?=
 =?utf-8?B?RUtEYWcvcnUvL0RXVjYvN0JTZ2ZZWEVFUWJSSDJYV0hCb2ZSZTR1Tm9pK1ZL?=
 =?utf-8?B?OCtEd0MrU0xZaXZVY0k3RWpIdG5UVW9OUU9OY05RRnpwYUxPU21COVhIQ2tq?=
 =?utf-8?B?a0ZaTXIyRFpqRUlhNkIyTEVsQ0dIbG43UnNpL2l5SVpKN2ZROXM2Nlo0TnlC?=
 =?utf-8?B?ZkxHUEtOV0FZNVhIcmNOM1ppeEtmWFJtMG1VUVlpeGtpVXBqdlRma3ZETzB1?=
 =?utf-8?B?NVRjOU85ZkJET3NuNE5UZHVVenRmVTRUUkdlNC9qeGJud2Yzd2tSdm1kcktU?=
 =?utf-8?B?ak5FZUluK1N4VEpCS0tKeVdwTzhOVFhwelp4Q0pON1dyVEszR0JGaTU4ZGYy?=
 =?utf-8?B?ZHRTeWhWRWFmYVRsTXVsaUxlREhiRkZPV056ZlZ6SVcyV0JYNXQvR0lOWWx4?=
 =?utf-8?B?b0lpUGJ5VVNBd09CR1NOZW5JSzB5RGk4VE96RHBoYkV2eGg0RDN3VGUwTHlY?=
 =?utf-8?B?WWtDbGdZL0hpbEptYWpXZFA4VnhhUEFyTGwrNFRDUXQ0dytxYkI1Y3Z3elhW?=
 =?utf-8?B?SnMyNnpOK3R4MXg0Q2ZrNXVVSGhMemtHOElWbTFCYlhHckFRcU85OXNXVnNQ?=
 =?utf-8?B?Zjl3UXZDbVRJbVBEbks4dkdwS203T0dlNGNud2tYTVU1bW5YWithejg4UXh0?=
 =?utf-8?B?OHIxYzNQWXVhYXFPTlN0Vy9jYkM5eGNyNVF6SDZ0R2R4ajNKQnphMkVGV3lT?=
 =?utf-8?B?U0l0YTZFRkRBSVJXTDFSMUVCNVJwTVJNN2UyR1ZyNUJTMHArL1ZQelFCbXc5?=
 =?utf-8?B?Z3JQREo3UmFIV2RFR3hxdnNrVUdJbmlYYTI2enhBYWoxenMyTjhGSndQQVcr?=
 =?utf-8?B?ODF1R09Pc09MTTlDN3VuM3RLK3ZnVTVSNlNwTUxIMkJpcFV2eEx5Vi84dXVV?=
 =?utf-8?Q?CkvI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXNiVnpvUjk3dkw4bWQ4NUlLS1RsaERwNDlNZGVlZ1VlWC9LZ3hUN1ZHc1ZD?=
 =?utf-8?B?Vk01OEZmcEFlYyt6Vm9YV2s3WDUyYVVXMFI1YWYzbnpIbWFOdWtaZ3IwekVI?=
 =?utf-8?B?OE9JRmZjeUEybjFuVm8yK1dtUU9kNmszcDAzNFZMY2lSMHZ3NWxQQzhzcnh3?=
 =?utf-8?B?eDhNcGhTRk1hdGowWHN0dHBBdm9MSzRNVDZDeFlVd2RaNFlyN1lXSGpwSWV4?=
 =?utf-8?B?YUtPMXI5SjJjNlMxS0czTkV5emxDQkZzMDR0OVhaTHJMMExhejZqQm95azEv?=
 =?utf-8?B?UTM1bVBXc016SEs3ZWl1TE1iYm9vVGowZ1l1T21lMkFRNVVTem5LeTdJZW9C?=
 =?utf-8?B?U2lXLzNUOGpJa0RnVEVjRVBBajRzVEkxazVtOU4ya200bDNXRVNuYmdpb25G?=
 =?utf-8?B?SUZXa09EN0RFbWRhcVgxVmN1TzlBOUJ4R25xZHB6Mkp3c3hxRlpIOVRlczJu?=
 =?utf-8?B?MFlKSXBGVHpvdDRMZlYxcGVrbHp1QUVxT3U0Q0xpcmdiV1pYM1VQK2ovSTZp?=
 =?utf-8?B?d1NVZldCNENTTE4xY3ZlVFkzdjhqWW85c1Q5ZFFEemQrb2d5cFE1ck5KUDFQ?=
 =?utf-8?B?MHhOTkNhK09LUlptSEFzNmxOeUQ3K0RRbkttUkVIMEg0cE5GV2J4T1hZRitv?=
 =?utf-8?B?cDdhaDlLbmFsczcrQlltNWtFOWdMYmYvdERZQWg0UmgyZFBRbytJYU16dDZo?=
 =?utf-8?B?cysrUkkzeE1jVXpqd085YUx3NnVHMkVNREord2p3cjY4cVE1SXJFaUNDNHQ1?=
 =?utf-8?B?dVN2T1ZidTlwT2xwS2MwTnVDSnJnaldPR3dlc2VTT2c4dlM0OVpiMVBmR1ZQ?=
 =?utf-8?B?dHNpZ0ZFc1JsZThsS21MNFJ0aytRZG13enJCS1dEdHBmMzB3UGFNanlyc0JX?=
 =?utf-8?B?U0p1MDdFRlF2N0F2ZjI4WkxRQU5IYytuWnR4RVBUaGxKQnNLaUIrMG4xM0Nm?=
 =?utf-8?B?a2JTdGx5c3Fza1VsWjZ6aytRdmZhSXB3NlRuOFdyQ0pvdGRkc3dDNUZwd01n?=
 =?utf-8?B?TDhvbU5NaU0xNFYyQytpVTB3VkJRMnpIVG1hc2xIdGQzamxBQ2x1aFh4TURM?=
 =?utf-8?B?QktQcXN1U0pUY2swMW1DeUNIVXZXdUJNRFI2L3BUNXBjMnJTN0cxYXFIVzkv?=
 =?utf-8?B?Z0Nac2lZL0hDTVBqUzM4Ykc5dnQxMGhFUHVFNi9mMXNGK0thVEt2ekJoNzY4?=
 =?utf-8?B?VTdEeU55aHYrN0U1QW1mRzJzMHlPcFE5NWNLMUZ3ZDhvbFZwYzZHeWh2eHRD?=
 =?utf-8?B?Smh6Q0lpajlaNHEwNHg4NUhBeXkyWjRmMHZKOTU5RlJxc0VEQ1F0ZHZlVUJ5?=
 =?utf-8?B?alZCc2JHSWJHVkNBTXpyMWNmaGx0RmxJZVJnSU5nZ0pQelU5WktFRFFwcTFt?=
 =?utf-8?B?Z1BlRlQ2YUxQd3h2SWh6YlRUZTk5UldLUVdkeFhwK1ptYnlFT2pMNXo0M1Jw?=
 =?utf-8?B?S0JHbm1GeWtKUzlSQ3RvMnNBWGV1ZEtHQ0tjRityQWp0L0M3S2R2cng0ODB6?=
 =?utf-8?B?ak96aFBTckY0NjNHRVVZZHVjRGxhWTB4ZEQ3eGU3T3ExMWxwdzY1K3ZnQ1hO?=
 =?utf-8?B?YTlHenNhbWd0TWxoMEx2RmE4YXJxUjlQZ29iZzVrbVhib0JieGhIQ09ibFIy?=
 =?utf-8?B?STJObmszdTRQbGRyeG5NWFdMVkV0NERhU0RJbXRvQnJTbzVYZ1VkblBFbk1w?=
 =?utf-8?B?L0ZnT2VnRlNjbC9GY1NwUTVJYVp5dSsrOUhKam0yVTJPbzFWMUFNS3NwWnpX?=
 =?utf-8?B?ZUdiZGJqVm5DTWJlc1JaZ0NrR1ZsZ0dHdlQ1Uk0zWm1kdDVjdWdkWXpSc3RH?=
 =?utf-8?B?NmdSa3hkOWZNSjJldEVjdDNQRmFweVcxMXczN0RFd1BZVVhKUnpvUUFJeXVt?=
 =?utf-8?B?bHptWHdvUDI5c3RrRkJpaFpsWmowNm16TDNQN1VaY3VSak92WjA0WTVMV0d4?=
 =?utf-8?B?dkI3UjRvVFlJN3M1VmFyQWFlSWkrczVKZHoyc2lpcGlPaEV6UXVnbExtWmJI?=
 =?utf-8?B?a2czSmYvV1dHeWdUVnYwdDJlYXhtSjZ4OUFVMVZSbTVzUUFHYUlFRHFKOUdl?=
 =?utf-8?B?ZERrd1ZmbTVsL0dDSFpmcEQ0OFBwb09rVlU5UzRrYSt4MmlXSW11VzJsbGZh?=
 =?utf-8?B?cTVGdjh3dEtNQkdJcEV0bHQ5Qlo3dTJobHNHQnJheGlYZHQzYmFiRTJhZWYr?=
 =?utf-8?B?SGlNSklORTZpNmIwU3hVWHR2dmpOVlVDcUdxR2hPdW4zdXNBeTZZZEtZMGlT?=
 =?utf-8?B?U3dOVEhJVmlyb1J2b2VpNTZ2NG1KcmYxUUlWcXlFT3BkaXMySENFbXBlaWxn?=
 =?utf-8?B?NmJtcHNLbTk4MG9IMTBVOHZJa1RXRGNHbTlib09XbDJwYUpxcXRqdDZuNnNm?=
 =?utf-8?Q?e1h8s8SRyM86PE1U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8e9e00-1aac-433e-8c50-08de68a1d60e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 12:42:22.4643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/GVb8PIZYR5NGBBzvAMhIsa0EnXgJcXtOMyQMS/rjh/c444qshD3Y7loWOi4ECx5XM/OScfe3DPFuS12qQ+sLh5So7YgGEkx56ZLFSUSuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7519
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
> Create a single function to manage all context descriptor handling,
> which returns either 0 or 1 depending on whether a descriptor is needed
> or not, as well as returning directly the descriptor contents if
> relevant.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

<snip>

> +static __rte_always_inline uint16_t
> +get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
> +	const union ci_tx_offload *tx_offload, const struct ci_tx_queue *txq,
> +	uint64_t *qw0, uint64_t *qw1)
> +{
> +	uint16_t cd_l2tag2 = 0;
> +	uint64_t cd_type_cmd_tso_mss = ICE_TX_DESC_DTYPE_CTX;
> +	uint32_t cd_tunneling_params = 0;
> +	uint64_t ptp_tx_index = txq->ice_vsi->adapter->ptp_tx_index;
> +
> +	if (ice_calc_context_desc(ol_flags) == 0)
> +		return 0;
> +
> +	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
> +		ice_parse_tunneling_params(ol_flags, *tx_offload, &cd_tunneling_params);
> +
> +	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
> +		cd_type_cmd_tso_mss |= ice_set_tso_ctx(ol_flags, tx_pkt, *tx_offload);
> +	else if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
> +		cd_type_cmd_tso_mss |=
> +			((uint64_t)CI_TX_CTX_DESC_TSYN << CI_TXD_QW1_CMD_S) |
> +			((ptp_tx_index << ICE_TXD_CTX_QW1_TSYN_S) & ICE_TXD_CTX_QW1_TSYN_M);

It's tangentially related to this commit but it caught my attention that 
TSO and timestamping are mutually exclusive here. They *are* mutually 
exclusive as far as the driver is concerned so that part is fine, but I 
couldn't find any signs of us enforcing this limitation anywhere in our 
configuration path, so a well behaved application could theoretically 
arrive at this combination of mbuf flags without breaking anything.

(if I understand things correctly, this applies to both ice and i40e)

-- 
Thanks,
Anatoly
