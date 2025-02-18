Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B955C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 15:45:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7258402E7;
	Tue, 18 Feb 2025 16:45:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id BFC5040261
 for <dev@dpdk.org>; Tue, 18 Feb 2025 16:45:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739893533; x=1771429533;
 h=message-id:date:subject:to:references:from:in-reply-to:
 mime-version; bh=rkmXRFaTaI35kS0YQTbfB5ViyPO79Y1Kmu1i6T0tPCQ=;
 b=WY3RNv5srEGGZ//l8d1VSVVr/VgYYb6G83gvvJoRjRlO1ezm2M01Kofy
 omF075oAQYp+pHhirCqMvNAbL3vOd5VuRuJK0U+vIvF23bx3SOT0iacIk
 bvD9mpkrRaXQmmSK1S6J8DQc96uTBQ+JN5+BuXV7+WPCDTAR1aTDgVD0U
 x0VlNLKX07ChGGy0vrgqvIvti65FH8pcjUdF4QUndljt+atXk23I2m2UI
 fS8nlyzYPfXOOJJmsRNvmv24hsIBqyHVwGyJS6qcx18icQGAfKbj68VWd
 Fav+lFP4TBM7/EEBelFGbWk9O0zx1GWKiFUdwV9vWEHejoWHWBNpH/weF w==;
X-CSE-ConnectionGUID: 3HoRsDk/TwqbGI6aH43D0A==
X-CSE-MsgGUID: 085Wis76RJKYEsNYeLosAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44355359"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208,217";a="44355359"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 07:45:32 -0800
X-CSE-ConnectionGUID: cUSdKO1aSx2PrI9owvf8MA==
X-CSE-MsgGUID: yVEetpagQeWrny9B9U9Cbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
 d="scan'208,217";a="119408762"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 07:45:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 07:45:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 07:45:31 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 07:45:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkx38pIaw0iE0gdWV2zkN66MCol9N8oWx1Ei4F+faypvipXaQp+raWPpEevMm3M8qOxvBTIF54IMI/0bc/wq8R+NOO1Y4SHplyWO99BOw1auZDS8Km78jjrckcQKtcao2RVMoj04K+JYTR6wXqGVk1yn02iAxwKIoJ4O062sId5BQVjqYb2OWUVvNZknnE/Zm42YPlaGk3OWKXQivXNRe5R/xSvHDYo7sHJXGiBUHFrprCy8Mzc1bbcjFAc9L6I7mzkuj/vmXHJXR6Q7yrOukHUIjWUXVfekWOLjq2ce1gomDIpE/C9yxUAwCkFFZq4s9z5WRRsO5+qEJV7HX1BFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPJTNqjJl6m8gul3Ppf5CACr8WOGY75MdMfA3T7geCs=;
 b=YN2CMHKtonhFqBb/eAUGQ8LFShQslwmRGYsmm6RHI1GKED5sUn6y+HC7Cuvgg6aGgqtmMpsMLrgKjoiieCsSQ0l5LUzAs2+Y9+0Boug8yeDKwZ54DXhiCKXxtagNGoQYCCJEoW3kvusRLCBMhuAs6KWQVx3KrWE1oikbni0QLAikLXXQs856pkl3AlI0KYtANan1Kl/0FcqP5aT7nqk0AKqlV4JvsmPioWZCj0SL69IU0GbkxJ1VCZTQWzW8ZRntlQIzzsAaAkzGeLU8AxzvjbRciHQv1HhIZ5ER5Hsh9gPwipGumIAIWvPCSWZgA3Y5QQ03Nuhro4m3bivZZ9XUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14)
 by SN7PR11MB7466.namprd11.prod.outlook.com (2603:10b6:806:34c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 15:44:42 +0000
Received: from MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::6444:ca4c:aa3e:f8d2]) by MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::6444:ca4c:aa3e:f8d2%4]) with mapi id 15.20.8445.013; Tue, 18 Feb 2025
 15:44:42 +0000
Content-Type: multipart/alternative;
 boundary="------------hg0zj4yJc2gRBJncV8BMiAW5"
Message-ID: <e0f6beea-80d1-47e1-a519-e8d3a6a8183a@intel.com>
Date: Tue, 18 Feb 2025 15:44:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/dmadevs: clarify naming constraints for idxd devices
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20250131144915.2129736-1-bruce.richardson@intel.com>
Content-Language: en-US
From: Kevin Laatz <kevin.laatz@intel.com>
In-Reply-To: <20250131144915.2129736-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0321.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::15) To MW4PR11MB5872.namprd11.prod.outlook.com
 (2603:10b6:303:169::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5872:EE_|SN7PR11MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: c53d8f7a-89c4-45b6-c748-08dd50332944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1pncHo2VEhxUHFwdU5FVzROampzV3hibTkvZVlvZGN1OUp4WGloZGhlUm1u?=
 =?utf-8?B?djRNUFhLNnUzR1VDRExhc29yQk05MzVscTV4VEJGRnJIRS9DdEFGSW5jNFpK?=
 =?utf-8?B?MEtYUGgxUnk1a3ZJNW5mTnRDNlZCZ000WDVLK3JKak5hV3ZVSFQ1SVBldWtU?=
 =?utf-8?B?VTNDYzN0R09EYkw5L0RQbFljNlo2Y1BoRWlvYmtmMlNwcTZiZG9WSCs5NkFw?=
 =?utf-8?B?NUdRUmZFRlpiLzlSUmNnYk9Hd0dKRnN4N0w5eWFSMkNmMkFJeE5PM2FoS2lG?=
 =?utf-8?B?em5za1ZuaDJWSDFxeFFZVXRFZEN5N2luanppQzJkcU1uZTdUVUYvbUgxUTVG?=
 =?utf-8?B?amQwUkJSc2QzMDEwVWNabnVKa3dqb3lCbUErMENZN0FBK0hocDZ2V2ZRMzY5?=
 =?utf-8?B?MmFUKzJjUTJVSDBlR0NxWDVmbWNac1IvRENQYUNGL2tld3k1SmRMYVlzdU1j?=
 =?utf-8?B?elJ1T1kyL2dYQW5pcEVFOFoycUFmZjlqK3ZZVXFHaEhhMG5tVjdldWtuY0k5?=
 =?utf-8?B?U1pMcVJpNHlvWVRmVGdSTzRQdE9qTW5CRUhwTzl4WHZ5MDdpK0h0ZDJONFJl?=
 =?utf-8?B?cHZydGVGL2t4UFJUOUZXaVNIQkdUNGRSWTZDTHVvQ2xqcEszSDR3V2NMWGFE?=
 =?utf-8?B?eTFJUThzVGpTSDlHZW02NEN6cUpiUWhtdnFKYUJJK0p2QUlzNjh4R0FjanJs?=
 =?utf-8?B?UG5QTWE5QkZEY1VLaEh1eDg5TW01SnAyMUtPMXNldnJyU3dhR0t5K3ZhcWlo?=
 =?utf-8?B?RlNFa0dPVjYrT3VkNnkweXhsRmdzc0dIdk9yaHZQOURhTFAxei9kdDJEU2Fs?=
 =?utf-8?B?Ylg3N1lWMVVrVGswREVSY3BRVEd3K2FaeEgrOEhudzJTaUVBRHg2OU0vWS9T?=
 =?utf-8?B?bGRvTVJOT1MwUGtTcVVQYlZlVU1QVXRKQkVLaHhVQVZscFpuSVJsZnp1UUky?=
 =?utf-8?B?VnF0R2drZnRxNXFtZm9yTkZ3Z1B4cmozNmtHeTJqYWRCSFljdnBPN3M4RGZt?=
 =?utf-8?B?ajdoQlh2K09hTGYwN1B6ZlJiMXFKTTdTYWI2VC8vam5PMXZRQnFsR3gydmtM?=
 =?utf-8?B?Yk43WTFybjFVWTRjTzd2OXk1VlpmTE1TUi9Xdm9EeGgyeGVjdWU4d251cHRx?=
 =?utf-8?B?K1VLQ3Vyb3FqL0dUN1RMdkZTazgvWGxCMUpEQmh0ZWZqQXZkWUE1azhsMFpB?=
 =?utf-8?B?RXpWcVVRWVhFbG9sa1JweXNZczlMcmRaSzBFdmlCYmVUZXdKcElLVFZyQTli?=
 =?utf-8?B?NjlvN1JKLzVqRWVQS1FoUHhXOVl1di9KRUFUS1RJd0F2VUx0ckRGME1ydkFJ?=
 =?utf-8?B?dytpak9ZL3B3UDVXMisrNStmOURleVl2ZmtZK0dlZW1mdklNZDFvbFcwci9E?=
 =?utf-8?B?STFmU2NRVlFZMVZMR2Y0NTQrQkhuQkhOaU12R3c1eVlUYkw1dTBSKzNXZzdL?=
 =?utf-8?B?SkgrMVgreDhkMXFyVWJkckNTNzJRVDJlZTlSK3AvcFFKb2Z5YXg4UzFXeHdi?=
 =?utf-8?B?RDh0dXZaejJ4Z241Si85cTNLckd2TEVnRVFBSVExdExlZ1dreUwvajhEQWRO?=
 =?utf-8?B?eTdLSytWL28xa1hzVkNMempkNEt4SkNLYnBsZmFXKzVSTDNqdGtnM1ZXb0ph?=
 =?utf-8?B?OFF2M21FVDk5emwxNVQwNmdTczFUU3FWdjFSOXJPWFpTUXpYdkh5c3hYQUwr?=
 =?utf-8?B?OXBuTk9ubkd6dzB2dWVEQUplMkM0UTdyZ3RpaTVadVZ0QjlncUowSy9QdmtQ?=
 =?utf-8?B?MC9SUEVrSkIrT0craC9jRE9qUWQxeDIrNWZMWGt6bFVnUFc3WVRFMTRHZ1ZX?=
 =?utf-8?B?YXVMZXgxcEo2UEkwNEJQUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5872.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2hmT0NOY0ZLcXltbm9ZVXVZMVRFUFNhdUpRWDRCWU5GQUp2d2RHeTFIZjJv?=
 =?utf-8?B?LzNjdXBKU1Y3VHBiZnViWWtrSngyRWtPRHVXcmZJeDlEK0JmbWlhcnlpaDd4?=
 =?utf-8?B?b2ZMTERvTXRuYjFENmhLSU8vZkkvWjZxKzdZSEhaQ255N1kydmlZUk1zcW1H?=
 =?utf-8?B?VVduc2JlYXRIZW8wc0xMZGdlNjZoT1UwQnNLaDBDbFpMMUpqL0dUZVNCc3hk?=
 =?utf-8?B?M0l4RGZxQkU4S0RIbHFjYkhYeXVrdGQ0ZXJMVVZHcEVYZTFFZDdRamowdGtT?=
 =?utf-8?B?WndHY3lhM3pRSWkydUpRcE13NmNSdGI0TmxjMWQwVVg3V3huUGsyVnB2Zi9V?=
 =?utf-8?B?VmRmVkU0T0NodXJybkV1dE00MUw1ZVdHRlNTZS9WenZjeVFXTUZ4OHY2MjMw?=
 =?utf-8?B?ZlRxciszSml2eHNXamhNZi9GeDhCSzhRS1ZxekpYajBWM1NZZnJMVGkxM2NM?=
 =?utf-8?B?K2NMZldyeHF0ay9kajhCMUxnelYyNGtrY2pWVXFLUzlRNlI1NWtYb21CTERP?=
 =?utf-8?B?SHZTdUgxdWZ4SHZzYjlCQjZJTjVWVnpYd3REY3l6UGYrclg4VFlCbW5BTmtr?=
 =?utf-8?B?ZjhkeHRwNWVXQ1ozamxFVG9qUFRPMkRSWllZTnM1WVppSXcyelhtNDU3MFBR?=
 =?utf-8?B?MzdybU9uZGdmUjgvMkR4NVNsaERtMVZ0ZUZPU3Z3Q1lLYUxJZnlXY0NSYWVF?=
 =?utf-8?B?bndJOWI3azArZU5IOHVDZzAyUlJXVFRGTGlteWtZYVNHaDBFOFJlek5uMXN2?=
 =?utf-8?B?RTVnUkhRMUZrb1huZWw4WklKOFJLZ3QxQmtrd0cyc3JNcHVwRmZjWExHR2pn?=
 =?utf-8?B?elZlb09DbyswV2ZRRE5RS2tJRmlWZXczdHBjam1zMXV5U1hKdTdGMXJhQlhP?=
 =?utf-8?B?eFBZRjc5Z0Y5UjZVN0NnL2tjZWNhTTlYdXprM3I0VGxDT2FwdXdKYVFUQ09B?=
 =?utf-8?B?L2RBdjFGbFVVaDhmN2lXcEJ6anlUMVgxVkF5MXdzRmdaelNJM1FzNFhXZjhN?=
 =?utf-8?B?WFVicHhrYWNhNVZPWnVFZ1RrUndpeG83RGd5WlRPLzhSZjJ2SHU0Y0RSbDNX?=
 =?utf-8?B?R3ZaN1QxU2IrNjVzU05XSi9KaFlkeVNBMkFWQ2haaWZpaHkranNqOGYxdHlH?=
 =?utf-8?B?SThjZDZJQi9xanJXdERvdTk0b0xlaWdseUU0OTdFU1VkZnMzdmpONUVBVVJi?=
 =?utf-8?B?NGNGaEliWWhZZFlkeWFUZTYwNDVESkhualRMSGhyUHY2N3RIWWxvSUFtc2c3?=
 =?utf-8?B?ODQ4SjFpakZaTE9ZQ0hVdVVzd0IrcUdCdlNrb0dPSTg2cERKb1QxTU1vYkpn?=
 =?utf-8?B?dXFIVSsvRldCYzBwMzVqU3pBZmsyRFlmdlVSRjViejZoZEFOU2h2ekk3bGRq?=
 =?utf-8?B?bUdvekhhSWhreFpySHZoSGNsV1VPQjZVNU0yUW5sMVNGQndJbDVpd3NnclVT?=
 =?utf-8?B?TndpOThyeDlQejdxbzRBanpOam5vMmpFUURkS1Azb2lySXFCakFrWm9sTDMx?=
 =?utf-8?B?dURnQ0J2amxBTTgxSlZPcmJ2SjdIUXJwVnhNUXIxM3VUSE9wdHdWMmMveFhU?=
 =?utf-8?B?dmx1YkFLMjY4bnZHWjlxQlN3TWx1cjlSalBjdDFWUW1QdzNySUpadlFFNGg2?=
 =?utf-8?B?KzN5VzlXaXNyYjVvSUc0V0RpeXdoakRlZjlmUVJRdzlyR01mbFRCM0ZEZWNu?=
 =?utf-8?B?WHZKMVZzOUJodE5LaDdBSm5PTEI0Y1hvdWt4VlBMdUpzNmc4dkRocWxiKzdP?=
 =?utf-8?B?TlZUekJOWkt1ZVcxWlY3b3ZLY0JZZnFLRkJEUE9MTjhrcmY0Ni9VdER2eWtQ?=
 =?utf-8?B?NU5MWWVibWJ4cnVET0dKcjREL0pHaGdlWlZ2Nll1QVdCa3lQUzdXT05XMGhz?=
 =?utf-8?B?TXNCRFViZzV1YmlKc0g1eXdCeVVDbFBLQkJ0anNFS1ZMNUNXNjFxMTFLd3Uw?=
 =?utf-8?B?MUFNdVlFMGhTRWs0VlNjOE96ZWNnN0c5VERJUzcvdStFN2lPVWttazJSVnR4?=
 =?utf-8?B?QnY5N2JrcUZWdkRuUGV2QlZEZDgyczFtUFVnMndRY21rbkp1ZlAyN0czbGxW?=
 =?utf-8?B?aDhOVXBxeHc2UFNTdlRhdmRUMmxqNUI1UWNsRmZiS2lCdGdScG9kM042am40?=
 =?utf-8?B?QjM3VDJJTlNqcHVVdis0cmp6RUNiQ1MvRE5rbzRybmRxTmxNYjBLdG1jQnBB?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c53d8f7a-89c4-45b6-c748-08dd50332944
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 15:44:42.4895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLxTG1jlBea5aN9V4PEGymsQxbCjDNTtk1hZ7StHhVxbPH0undjHdA8yckA+DfKNe2lQ+eaVPNRTaqWSR/eSzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7466
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

--------------hg0zj4yJc2gRBJncV8BMiAW5
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 31/01/2025 14:49, Bruce Richardson wrote:
> The requirement to have DPDK in the DSA wq name is given in the idxd
> chapter section 5.3.3 [1]. However, that information should also be
> given in section 5.3.1 [2] where we list out the fields to be set and
> what values they should have.
>
> [1]https://doc.dpdk.org/guides-24.11/dmadevs/idxd.html#device-probing-and-initialization
> [2]https://doc.dpdk.org/guides-24.11/dmadevs/idxd.html#intelreg-dsa-devices-using-idxd-kernel-driver
>
> Signed-off-by: Bruce Richardson<bruce.richardson@intel.com>
> ---
>   doc/guides/dmadevs/idxd.rst | 4 ++++
>   1 file changed, 4 insertions(+)

Acked-by: Kevin Laatz <kevin.laatz@intel.com>

--------------hg0zj4yJc2gRBJncV8BMiAW5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 31/01/2025 14:49, Bruce Richardson
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131144915.2129736-1-bruce.richardson@intel.com">
      <pre wrap="" class="moz-quote-pre">The requirement to have DPDK in the DSA wq name is given in the idxd
chapter section 5.3.3 [1]. However, that information should also be
given in section 5.3.1 [2] where we list out the fields to be set and
what values they should have.

[1] <a class="moz-txt-link-freetext" href="https://doc.dpdk.org/guides-24.11/dmadevs/idxd.html#device-probing-and-initialization">https://doc.dpdk.org/guides-24.11/dmadevs/idxd.html#device-probing-and-initialization</a>
[2] <a class="moz-txt-link-freetext" href="https://doc.dpdk.org/guides-24.11/dmadevs/idxd.html#intelreg-dsa-devices-using-idxd-kernel-driver">https://doc.dpdk.org/guides-24.11/dmadevs/idxd.html#intelreg-dsa-devices-using-idxd-kernel-driver</a>

Signed-off-by: Bruce Richardson <a class="moz-txt-link-rfc2396E" href="mailto:bruce.richardson@intel.com">&lt;bruce.richardson@intel.com&gt;</a>
---
 doc/guides/dmadevs/idxd.rst | 4 ++++
 1 file changed, 4 insertions(+)
</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">Acked-by: Kevin Laatz <a class="moz-txt-link-rfc2396E" href="mailto:kevin.laatz@intel.com">&lt;kevin.laatz@intel.com&gt;</a>
</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------hg0zj4yJc2gRBJncV8BMiAW5--
