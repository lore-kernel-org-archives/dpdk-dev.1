Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF57C61DB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 09:56:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38B5F42E4E;
	Fri, 13 Jun 2025 11:56:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 34CB640151
 for <dev@dpdk.org>; Fri, 13 Jun 2025 11:56:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749808583; x=1781344583;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=w6vHjMmNwMlch7zEQjvBg7Mn6nHifBGU2UZLskBiM7k=;
 b=c94FEiHQCxr1E0CmeetztWjoghMq+usJkq5hel+L53xoYyENu04FLe6a
 XzO7WNJGbT8XfYf8iiwV1VIJPHNbH/lwahUw/vhp96OjyMu3VrQUYyh/3
 4tYtVAur/E2BJnsXs3hgr0qbw65ILVLTwMF6WZ3C6mxytPVvOadhB1hjI
 gcaNhks3TJxx8htbiX7KkOmQpUcyLjCcgAWZBh0CoPIHlHqvR5pKNl2Oo
 05aVOSNMnDtzl+ShdPzTK3B4LOuFlWGML4cIcHlV9CUsTasvFVFByLTtD
 jokFmBEx3Vi06mr/kc7RGsiqU7Vh4RRB8XDoPEoPMVvPHdCigFxdcMtpn w==;
X-CSE-ConnectionGUID: Azh1Fmz7RYynCP99zHOtOQ==
X-CSE-MsgGUID: RF63uzhTQqWatz5R95n4bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="69592320"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; d="scan'208";a="69592320"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 02:56:22 -0700
X-CSE-ConnectionGUID: 3N0MPXUATNCDvExpU5skIQ==
X-CSE-MsgGUID: ypbkNyo6RKmMeUHaWCkQzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; d="scan'208";a="147630871"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 02:56:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 02:56:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 02:56:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 02:56:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ru9A2BLZZHG7iFBoJwZx5zDdFDKlZ/F70dTRE4i1ZV5jRwMTX0nYIp6fGUQielfizAQOsFMDHCKlbl8Kx179tj10vmBpUn9et4cy/NHQfiV7nqW8VZt0zY7KM6w3TM6vg8mej3yDn89ibPBJRK8OMC9TYiwpA+EwYNzH8SSXhthjb0XgukfDumZpRJ6sABFm69FUyUORQBPdc24QhRHo6oAbssWJ2FPM+lo9hMeMN4i5jaq9FWtkhnxWJUtPkS5c3UifSvNZh8/8JBsebq70gDbk0Skoc4LntRXRvQi/iDbeiXztb+bejJQ9bPZw1SYXQG88hDro5F/df5IJtAjS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oF5hw97HU2rX8VfJ9hH9lk1ez9kmM+mVCjUW5dvXmUY=;
 b=ekTEJTfeayVn58Q0PpWDInkZMIzBYUMlVuF80fTA6vLwm8hTuKMaerzkSiHWBWgYtIeSozQpa86VLpRQI3xUAKXuYTzTRDz9oiKcH/ie2tK8rBdlJre/v7U4Kr/V4OIXlZWIoKVIqYqa2xxmX1laH+So9jjiMNE12l+qgllEcS9mFROik5cgKfN1nqdbvjgHeR3D6goQXPkSV56VLmBtptBzeXkfcqm9SlI523MmhahrEzdwt+gw+PzSf8ozjmHGs4+7HMOWTILhfTUUSJ+94BaH+Xzhnhu1uRaGxQO1vUnteQlamprobtGKjcy42+LYHC/vzvhoraUeQetFtrm/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB8592.namprd11.prod.outlook.com (2603:10b6:610:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Fri, 13 Jun
 2025 09:56:04 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 09:56:03 +0000
Message-ID: <d615143c-1f5d-4744-a637-01c6099c9515@intel.com>
Date: Fri, 13 Jun 2025 11:55:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] eal: handle sysconf(_SC_PAGESIZE) negative return value
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <20250612140657.313785-1-mb@smartsharesystems.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250612140657.313785-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::8) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH3PR11MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: 8163f946-6fe3-4d5f-7169-08ddaa60824f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTlzdkd3YWFDZmlHNC84TnB0cTVLSWREZWFYbVM3NmU3aXMwQ1YvUzR6UFNN?=
 =?utf-8?B?UlNrTm5aS3ZmNkxzUW1yYWlnbGRCYnZoOEpJMXhYajg5WlhoSXZ4RzdocGhW?=
 =?utf-8?B?Q25TUkRsekZzcFFFeGhHS2EzWG5pY1AvdFQrdi9mS3Q1QituNXMrOXBKWlor?=
 =?utf-8?B?WWRJUGljVHFqNXVobFl2eWU5YzZuVW00YjVPLzdwaDZQeU9MS1gwL1hCeUlM?=
 =?utf-8?B?SWdTZ3RIWWd1OWJTWEF4OG9weCtJWW1XTWNoQ3htekFja0V0ZHE4ZHN2TFBZ?=
 =?utf-8?B?MVdqTVRDb0U5ZC9BNVFiaTBPVEl2VHE3cXV0Q3Z6MEZuT0NVUDNsS0E4SjZ2?=
 =?utf-8?B?WmpOenA2MnFXc0hnaUVqMjFEL1lpSlZJQ0ZVYVF3SjF6ZFBualFwalRLc2hu?=
 =?utf-8?B?a0luS0VTVWg2UlVqVVRzenBzQ3Q1WktzWlYwRSsvR3dXNXZxN2V0VzVSMXlG?=
 =?utf-8?B?aXBVWlRYQXI3MzBZQ3NQMEI2RHZZckhSc3ROTjIwVlVDWVZnekU3RnV2S00y?=
 =?utf-8?B?OVB2ZW5VQ3BYZFo1aWxJRWdkdytDRXZOL0wySWV6M3FxbWFHMUZXNzVLTHR1?=
 =?utf-8?B?WXdyUVp0ZW85czZOcWNYb3hYM0Q1L0Fwb2hZbkIrb2tFYTd5WUkzU20vRFRC?=
 =?utf-8?B?c29ETjhqTzlaTm0yZnBZcEw5VFVXcnpvY3puMHVmRndlbTZoUUN6Zkw0R1hh?=
 =?utf-8?B?N0xKb05iUFIyRHd5bTlmcHlsZ1l5a1ZDcVlnRmJwbkY2K20rUEQ1RnFza1l2?=
 =?utf-8?B?R3VMaW1JblNPTTZrZk5CRW9pNllGWHFnbEJXZ1RJdlphTG9ZOTRaM3hieWl0?=
 =?utf-8?B?V3JndFprN1pHSDc4cTBpNWp4SERZVEFtNjF4STNzZG1lL3RmaFpoTVI4amhl?=
 =?utf-8?B?UjhwdVhTdTY2VkZYTUFERWFmcEtJMWNiQXdER08vemVyWERhbzlDWitMRXBQ?=
 =?utf-8?B?b0pZM0xMbFB0OGJMR2xYc1RMd0lYUnIvZG5hclh4cWdoYTlUemtFUVdPTHFE?=
 =?utf-8?B?NmpZQVc4cUZycVlJcWdVTGxzUmFqRGNuUU9teGZSa1EvM2NaVDhqY252VEps?=
 =?utf-8?B?QVU0R0xPMm4yUVdJcTFKNFlYUXFvS2J2MnJ6bk1DWUxCUGVzcXBHQUNBeG1T?=
 =?utf-8?B?aVlCdkl5T00yZEZ0cGpNWVc3c0RMcEdCTDZYT1ZZd2IwQWhMNmJ1NEc2YzZj?=
 =?utf-8?B?aGpGRGk4cnl6NVR2dWpXazh3THNmbHBXditvdDIzZTd6MEJHc2xmNjBUOVB1?=
 =?utf-8?B?MmJHazFIaXRIOXlSeGxhUWhkODNWQ2lmbmUyanFjL08xQTBYWkpDbng3c2Ry?=
 =?utf-8?B?WjdDL2M5R3h1aXBpa09ycVQ2WS9NOVBVZ2thcjFCY3Z1Y0JUeCtaK25OeHd1?=
 =?utf-8?B?Vys0NEx3cjVET244MnY5VkpuQVFZbHQ0N3Q1RkZtaWtWTEZVV0ZaWjVEenVM?=
 =?utf-8?B?R0Rmc3E3UlJrZ2FibFd5NDlzU0w5aEdyRlVnZzM5Qmg4VFVML2p4cHlNZ1JT?=
 =?utf-8?B?T1dsbmkzOFRVNnFCcTlGdTA1WUFKUUhzNXZKY3JzaWltdTJtWWlUd3dCVWJE?=
 =?utf-8?B?bnI4NU04dlNyZlZwN21sd2RmaXpOOTRmcGt0SkVyeWMxUGhKandIaUNEN3RJ?=
 =?utf-8?B?VGhzbXFGVFNOWDRYZU5VY2VPVHVsMDhEY085QmRUU1VhZWdjU0Z5Yy9CNmJV?=
 =?utf-8?B?ek9xMWRyR3ErS0E2L3g5WXFoa1JRQ3U4M2xVMWxETDJiTmFYU1NRVnA3Nk16?=
 =?utf-8?B?R3ZOMTRHQWh5YUJJbUlOeVlnbXVydmJKNVpwbzBoYm1FRjZ6MDlCMHI3alYv?=
 =?utf-8?B?OWFGdll1MjR1eTMvdjVFb2VLTllCSHNHSS90bU43eElqcXJudnVaeEVhN1Y2?=
 =?utf-8?B?WmdJdWNQTGY3YnBPenJwd01rdVp6QW5UWERaWmJFQisrQWpCNmVRM0hjZFFZ?=
 =?utf-8?Q?BLeHY5d7kmU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGNOUUx2Y3JMQWpOTzZWamgxK1NhYmNGS1JjeVl3Q3dFbUZrMEhmaWlMa3dk?=
 =?utf-8?B?a1NKdmpwYlI1MTZJM3oxblFhenZZeXVya21YWTUrclRTWE5ZWWNxSG4wYWsx?=
 =?utf-8?B?UXlUR0YzVHBSMHNqdjcvRk8vSW9xTU4xcjFDUnR5Wmd5SVRFeXdwTHZSZGlq?=
 =?utf-8?B?TFVlM2Jnbk1leXUzK1hzV0JKQlpOV2p6eE1teTd2Yk9zbjBjUGhTVkdLRTZu?=
 =?utf-8?B?YWQ0N1Y2cUFVUldFQVRrVGNFTHgxNGkwVitPekJHUjAwVjZINGlDeHhJaDgv?=
 =?utf-8?B?ZHNrdTE0TGtNb2pUSlF5VlZtQ0dQcEl2cGMwaTNEUFFYclJaQjlwVWZaeXgz?=
 =?utf-8?B?bkhzS0V1Mkl3OHVSRi9YdFdQV1dLVTdoRkJQNFNEL2grYXVQa3grbEZQZGVm?=
 =?utf-8?B?ZG53Y2QwWFR4SUR6QW4rZGRqS0xZVGFpRDhyY0t4ankvN0RPank2a1Q2bWdl?=
 =?utf-8?B?MGtMbEZoUmgweGlRWjFLdk9YcThISkdGZUdBRjhrbzltazhPem4zcXJQWkp5?=
 =?utf-8?B?RTZiSjFRQmhHbXFDVU94RFZWLzg2d0hoMFMyb1FOS3NDVmd0NGIvS1ZoUjRQ?=
 =?utf-8?B?SE14RUdNT0IvRWxLREFOT3ZGSnhMRnFOdmdGZ2xwSHpYUmhnUWQxaHUyU2ZK?=
 =?utf-8?B?b044WjZqNlhuRmlDeTd4MUwrZzI4b1FWU2xaUHJnVTVJUitEVnI3bjNQWmhS?=
 =?utf-8?B?cVhUQityUFpDSkxZdGpmWS9ZVWRZOEo5Nis4cFBpU2pQajRBRTFnSWRMV1M2?=
 =?utf-8?B?K3kwLytVb3VwYlBkeGdUb1RFaXpsSnpaQyt5KzNZaGZVbEFqbnZrZStLVTUy?=
 =?utf-8?B?OUd6N2xUcmRwWGU2V0tkK3VYTEZDSkplQ2xuWmo2UXVDYkQwZXcydHJtdmk4?=
 =?utf-8?B?eVh3eGtPV2E1NEpyM2hyaVI3YVp6MG05QlppbWVBS1pJcWJ3bnBRbmxMWVhE?=
 =?utf-8?B?RmgvZW9HZzJFci9pd056a25JdUMrMEF5TXIyQks2a1BpSDRJSllaK2lROHpL?=
 =?utf-8?B?VDVBRXZBTUFSWXlvNW0vOFFjTFd4SFRjcGFDL2p5RDQ4UmMxdElCc3E4T25o?=
 =?utf-8?B?L3p2WktFbzZJU1NwdWgzUmV2aUJJdEdSUUhadTgyNXZVVUs0MHkzZ3NTd0RT?=
 =?utf-8?B?THphU3dyeksvUW5lOXhKdm54QVJkL3ZFWlRJeXNrQUduc0pPTnkvVUVTZG5U?=
 =?utf-8?B?RjZzVElSajRuR0xnU3V3cCtWVjlYSDdnbWowTWZubW11ZGpoMzI0ZDdXSG5S?=
 =?utf-8?B?S1JMajVmUGRUbzEvN3MzdGNDTy91ekZIdFhqdFNKRktudkVUc3l3Z21rbnVO?=
 =?utf-8?B?cmFoM3llMGpkckE0MzNIcGltUlhPU3ZKL0N5UXlXajIxNHJhQzd3NDdDQy9u?=
 =?utf-8?B?NS9CcHBVOXJJeFR3TE9vM0xrNkJOdGVkVEg1VFVkTmJHblE5UFZqcFRpSDht?=
 =?utf-8?B?cEpINHhYZUphUHEyZ1VDdWp0akJQdldEbzZXQVRWR3lHTmlTb2lvdytCVzdn?=
 =?utf-8?B?RnJsNEx4S0R5SHl5cHZBemNZd1NNWDRhYUdvYkhFQi95MEphRkxzTnRNU1Jw?=
 =?utf-8?B?VVFobFlMK0lQZUtnMXlXQXM5VUpCYk5qSGZ3ZXRPWi9QL1EwMnZLTHQrSWFR?=
 =?utf-8?B?ZXpSYjNmK2t4dXhsdy95Q1o2ZVZrY2VHaVlxNmxQaU1NMUFsSWtQQjZvUTJu?=
 =?utf-8?B?VGZjZXA1elk0cGpDbjByNmVIakRvSitjWmFncGZtTC9IVVd2MHFKeXZmTDhP?=
 =?utf-8?B?c1MyQkpVZm5RRTVLNG9acStlTS8xcU5kbDV1ejRSejdkVlczUkN6bGQxK1Bz?=
 =?utf-8?B?UTh0ckY3bjZiVS8rV3hrc29wVm5uR3ZIVXRsZllKNFBNczlBTnRUTElQM0Q5?=
 =?utf-8?B?UFpIaVpEekJlR3hDZXRNNDN4NmFMQXdpOTZjVFEzYUQ4aTRvRExzU0J1d0FO?=
 =?utf-8?B?VVBIbzE1ampZQnFOWnhMYnJnVmF6TVc3U3pHT2ZmY1BrTUhCL3h1RXpVTUtk?=
 =?utf-8?B?N29RSDVrZFhRSW1OYUZ5eTlLVWJiaW4xRnB3VXQxUmxTVUN1TTVsL2d0RmI0?=
 =?utf-8?B?YnF6SW94cXgzR1h4Wkh5UGVwaG81WUNGa1ZqWVk2c3ArQzd3SHh4dFM4c1Av?=
 =?utf-8?B?aDZJdi93dENsWFZwQkFTcXNMU1ZGTnpld2Q5bnJxN25tZm1XRFNqQzR4Qmpr?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8163f946-6fe3-4d5f-7169-08ddaa60824f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 09:56:03.7423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wq7NgKLELjCD3UZ5PEX6DZtZWGt4JTdslQ8/i2pg28Sn1zh+Z6OylzySAfhWDiblJlzVfmO6nfjm2XUROSbmQh4B42fFkG24cOMwWwMDgj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8592
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

On 6/12/2025 4:06 PM, Morten Brørup wrote:
> eal: handle sysconf(_SC_PAGESIZE) negative return value
> 
> Coverity reports some defects, where the root cause seems to be negative
> return value from sysconf(_SC_PAGESIZE) not being handled.
> 
> rte_mem_page_size() was updated to handle negative return value from
> sysconf(_SC_PAGESIZE).
> 
> All other functions calling sysconf(_SC_PAGESIZE) directly were updated to
> call rte_mem_page_size() instead.
> 
> At this time, no other calls to sysconf(_SC_PAGESIZE) have been found in
> the DPDK libraries.
> 
> PS: "_SC_PAGESIZE" has the alias "_SC_PAGE_SIZE". Both are covered here.
> 
> Moved the PMU library to the correct location in the meson.build file; it
> depends on the EAL, not vice versa.
> 
> And an unrelated drive-by minor fix in eal_mem_set_dump():
> When madvise() failed, an incorrect reason was logged.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>

Hi Morten,

I don't think including unrelated fixes is a good idea, as it makes it 
more difficult to bisect, trace line history, etc., so I would suggest 
splitting these into 3 patches.

Regarding contents of the patch itself, LGTM

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

> ---
> v2:
> * Clarify in title and description that only sysconf(_SC_PAGESIZE) is
>    covered, and in description that only DPDK libs have been patched.
> * Include new PMU library in patch after rebasing.
> v1:
> * Improve comment about errno for indeterminate sysconf() values.
>    (Stephen)
> ---
>   lib/eal/freebsd/eal.c          |  3 ++-
>   lib/eal/freebsd/eal_memory.c   |  7 +++----
>   lib/eal/linux/eal.c            |  3 ++-
>   lib/eal/unix/eal_unix_memory.c | 16 ++++++++++++++--
>   lib/meson.build                |  2 +-
>   lib/pmu/pmu.c                  |  8 ++++----
>   lib/vhost/vduse.c              |  3 ++-
>   7 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
> index 82382d6e8f..c1ab8d86d2 100644
> --- a/lib/eal/freebsd/eal.c
> +++ b/lib/eal/freebsd/eal.c
> @@ -26,6 +26,7 @@
>   #include <rte_launch.h>
>   #include <rte_eal.h>
>   #include <rte_eal_memconfig.h>
> +#include <rte_eal_paging.h>
>   #include <rte_errno.h>
>   #include <rte_per_lcore.h>
>   #include <rte_lcore.h>
> @@ -98,7 +99,7 @@ rte_eal_config_create(void)
>   	struct rte_config *config = rte_eal_get_configuration();
>   	const struct internal_config *internal_conf =
>   		eal_get_internal_configuration();
> -	size_t page_sz = sysconf(_SC_PAGE_SIZE);
> +	size_t page_sz = rte_mem_page_size();
>   	size_t cfg_len = sizeof(struct rte_mem_config);
>   	size_t cfg_len_aligned = RTE_ALIGN(cfg_len, page_sz);
>   	void *rte_mem_cfg_addr, *mapped_mem_cfg_addr;
> diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
> index 3b72e13506..6d3d46a390 100644
> --- a/lib/eal/freebsd/eal_memory.c
> +++ b/lib/eal/freebsd/eal_memory.c
> @@ -11,6 +11,7 @@
>   #include <fcntl.h>
>   
>   #include <rte_eal.h>
> +#include <rte_eal_paging.h>
>   #include <rte_errno.h>
>   #include <rte_log.h>
>   #include <rte_string_fns.h>
> @@ -22,8 +23,6 @@
>   #include "eal_memcfg.h"
>   #include "eal_options.h"
>   
> -#define EAL_PAGE_SIZE (sysconf(_SC_PAGESIZE))
> -
>   uint64_t eal_get_baseaddr(void)
>   {
>   	/*
> @@ -191,7 +190,7 @@ rte_eal_hugepage_init(void)
>   			addr = mmap(addr, page_sz, PROT_READ|PROT_WRITE,
>   					MAP_SHARED | MAP_FIXED,
>   					hpi->lock_descriptor,
> -					j * EAL_PAGE_SIZE);
> +					j * rte_mem_page_size());
>   			if (addr == MAP_FAILED) {
>   				EAL_LOG(ERR, "Failed to mmap buffer %u from %s",
>   						j, hpi->hugedir);
> @@ -243,7 +242,7 @@ attach_segment(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
>   
>   	addr = mmap(ms->addr, ms->len, PROT_READ | PROT_WRITE,
>   			MAP_SHARED | MAP_FIXED, wa->fd_hugepage,
> -			wa->seg_idx * EAL_PAGE_SIZE);
> +			wa->seg_idx * rte_mem_page_size());
>   	if (addr == MAP_FAILED || addr != ms->addr)
>   		return -1;
>   	wa->seg_idx++;
> diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
> index 54bee4a2cf..52efb8626b 100644
> --- a/lib/eal/linux/eal.c
> +++ b/lib/eal/linux/eal.c
> @@ -31,6 +31,7 @@
>   #include <rte_launch.h>
>   #include <rte_eal.h>
>   #include <rte_eal_memconfig.h>
> +#include <rte_eal_paging.h>
>   #include <rte_errno.h>
>   #include <rte_lcore.h>
>   #include <rte_service_component.h>
> @@ -179,7 +180,7 @@ static int
>   rte_eal_config_create(void)
>   {
>   	struct rte_config *config = rte_eal_get_configuration();
> -	size_t page_sz = sysconf(_SC_PAGE_SIZE);
> +	size_t page_sz = rte_mem_page_size();
>   	size_t cfg_len = sizeof(*config->mem_config);
>   	size_t cfg_len_aligned = RTE_ALIGN(cfg_len, page_sz);
>   	void *rte_mem_cfg_addr, *mapped_mem_cfg_addr;
> diff --git a/lib/eal/unix/eal_unix_memory.c b/lib/eal/unix/eal_unix_memory.c
> index 61e914b8db..562b2b6d92 100644
> --- a/lib/eal/unix/eal_unix_memory.c
> +++ b/lib/eal/unix/eal_unix_memory.c
> @@ -89,7 +89,7 @@ eal_mem_set_dump(void *virt, size_t size, bool dump)
>   	int ret = madvise(virt, size, flags);
>   	if (ret) {
>   		EAL_LOG(DEBUG, "madvise(%p, %#zx, %d) failed: %s",
> -				virt, size, flags, strerror(rte_errno));
> +				virt, size, flags, strerror(errno));
>   		rte_errno = errno;
>   	}
>   	return ret;
> @@ -147,8 +147,20 @@ rte_mem_page_size(void)
>   {
>   	static size_t page_size;
>   
> -	if (!page_size)
> +	if (page_size == 0) {
> +		/*
> +		 * When the sysconf value cannot be determined, sysconf()
> +		 * returns -1 without setting errno.
> +		 * To distinguish an indeterminate value from an error,
> +		 * clear errno before calling sysconf(), and check whether
> +		 * errno has been set if sysconf() returns -1.
> +		 */
> +		errno = 0;
>   		page_size = sysconf(_SC_PAGESIZE);
> +		if ((ssize_t)page_size < 0)
> +			rte_panic("sysconf(_SC_PAGESIZE) failed: %s",
> +					errno == 0 ? "Indeterminate" : strerror(errno));
> +	}
>   
>   	return page_size;
>   }
> diff --git a/lib/meson.build b/lib/meson.build
> index 1934cb4a29..7c1c21e6bc 100644
> --- a/lib/meson.build
> +++ b/lib/meson.build
> @@ -13,7 +13,6 @@ libraries = [
>           'kvargs', # eal depends on kvargs
>           'argparse',
>           'telemetry', # basic info querying
> -        'pmu',
>           'eal', # everything depends on eal
>           'ptr_compress',
>           'ring',
> @@ -49,6 +48,7 @@ libraries = [
>           'lpm',
>           'member',
>           'pcapng',
> +        'pmu',
>           'power',
>           'rawdev',
>           'regexdev',
> diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
> index 46b0b450ac..267d48c3d6 100644
> --- a/lib/pmu/pmu.c
> +++ b/lib/pmu/pmu.c
> @@ -14,6 +14,7 @@
>   
>   #include <eal_export.h>
>   #include <rte_bitops.h>
> +#include <rte_eal_paging.h>
>   #include <rte_tailq.h>
>   #include <rte_log.h>
>   
> @@ -215,13 +216,12 @@ open_events(struct rte_pmu_event_group *group)
>   static int
>   mmap_events(struct rte_pmu_event_group *group)
>   {
> -	long page_size = sysconf(_SC_PAGE_SIZE);
>   	unsigned int i;
>   	void *addr;
>   	int ret;
>   
>   	for (i = 0; i < rte_pmu.num_group_events; i++) {
> -		addr = mmap(0, page_size, PROT_READ, MAP_SHARED, group->fds[i], 0);
> +		addr = mmap(0, rte_mem_page_size(), PROT_READ, MAP_SHARED, group->fds[i], 0);
>   		if (addr == MAP_FAILED) {
>   			ret = -errno;
>   			goto out;
> @@ -233,7 +233,7 @@ mmap_events(struct rte_pmu_event_group *group)
>   	return 0;
>   out:
>   	for (; i; i--) {
> -		munmap(group->mmap_pages[i - 1], page_size);
> +		munmap(group->mmap_pages[i - 1], rte_mem_page_size());
>   		group->mmap_pages[i - 1] = NULL;
>   	}
>   
> @@ -250,7 +250,7 @@ cleanup_events(struct rte_pmu_event_group *group)
>   
>   	for (i = 0; i < rte_pmu.num_group_events; i++) {
>   		if (group->mmap_pages[i]) {
> -			munmap(group->mmap_pages[i], sysconf(_SC_PAGE_SIZE));
> +			munmap(group->mmap_pages[i], rte_mem_page_size());
>   			group->mmap_pages[i] = NULL;
>   		}
>   
> diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
> index a2a7d73388..9de7f04a4f 100644
> --- a/lib/vhost/vduse.c
> +++ b/lib/vhost/vduse.c
> @@ -16,6 +16,7 @@
>   #include <sys/stat.h>
>   
>   #include <rte_common.h>
> +#include <rte_eal_paging.h>
>   #include <rte_thread.h>
>   
>   #include "fd_man.h"
> @@ -690,7 +691,7 @@ vduse_device_create(const char *path, bool compliant_ol_flags)
>   		dev_config->vendor_id = 0;
>   		dev_config->features = features;
>   		dev_config->vq_num = total_queues;
> -		dev_config->vq_align = sysconf(_SC_PAGE_SIZE);
> +		dev_config->vq_align = rte_mem_page_size();
>   		dev_config->config_size = sizeof(struct virtio_net_config);
>   		memcpy(dev_config->config, &vnet_config, sizeof(vnet_config));
>   


-- 
Thanks,
Anatoly
